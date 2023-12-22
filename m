Return-Path: <linux-kernel+bounces-9850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186EB81CC58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8D0B22D35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AA32377D;
	Fri, 22 Dec 2023 15:41:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out187-3.us.a.mail.aliyun.com (out187-3.us.a.mail.aliyun.com [47.90.187.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B189241E6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---.Vqjmyjt_1703259637;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.Vqjmyjt_1703259637)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 23:40:38 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: rientjes@google.com
Cc:  <akpm@linux-foundation.org>,
  "Henry Huang" <henry.hj@antgroup.com>,
  "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
  "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
   <yuanchu@google.com>,
   <yuzhao@google.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
Date: Fri, 22 Dec 2023 23:40:33 +0800
Message-ID: <20231222154037.62823-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <931f2e6d-30a1-5f10-e879-65cb11c89b85@google.com>
References: <931f2e6d-30a1-5f10-e879-65cb11c89b85@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for replying.

On Fri, Dec 22, 2023 at 13:14 PM David Rientjes wrote:
> - is the lack of predeterministic charging a problem for you?  Are you
>   initially faulting it in a manner that charges it to the "right" memcg
>   and the refault of it after periodic reclaim can causing the charge to
>   appear "randomly," i.e. to whichever process happened to access it 
>   next?

Actually at begin, all pages got charged to cgroup A, but with memory pressure
or after proactive reclaim. Some pages would be dropped or swapped.
Task in cgroup B visit this shared memory before task in cgroup A,
would make these pages charged to cgroup B.

This is common in our enviorment.

> - are pages ever shared between different memcg hierarchies?  You 
>   mentioned sharing between processes in A and A/B, but I'm wondering
>   if there is sharing between two different memcg hierarchies where root
>   is the only common ancestor?

Yes, there is a another really common case:
If docker graph driver is overlayfs, different docker containers use the
same image, or share same low layers, would share file cache of public bin or
lib(i.e libc.so).

> - do you anticipate a shorter scan period at some point?  Proactively
>   reclaiming all memory colder than one hour is a long time :)  Are you
>   concerned at all about the cost of doing your current idle bit 
>   harvesting approach becoming too expensive if you significantly reduce
>   the scan period?

We don't want the owner of the application to feel a significant
performance downgrade when using swap. There is a high risk to reclaim pages
which idle age are less than 1 hour. We have internal test and
data analysis to support it.

We disabled global swappiness and memcg swapinness.
Only proactive reclaim can swap anon pages.

What's more, we see that mglru has a more efficient way to scan pte access bit.
We perferred to use mglru scan help us scan and select idle pages.

> - is proactive reclaim being driven by writing to memory.reclaim, by
>   enforcing a smaller memory.high, or something else?

Because all pages info and idle age are stored in userspace, kernel can't get
these information directly. We have a private patch include a new reclaim interface
to support reclaim pages with specific pfns.

-- 
2.43.0


