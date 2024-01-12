Return-Path: <linux-kernel+bounces-24292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D282BA73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153692855A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF285B5B3;
	Fri, 12 Jan 2024 04:40:41 +0000 (UTC)
Received: from out0-194.mail.aliyun.com (out0-194.mail.aliyun.com [140.205.0.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3507F4F7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047194;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---.W4EnNzt_1705034428;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.W4EnNzt_1705034428)
          by smtp.aliyun-inc.com;
          Fri, 12 Jan 2024 12:40:29 +0800
From: "Henry Huang" <henry.hj@antgroup.com>
To: yuanchu@google.com
Cc:  <akpm@linux-foundation.org>,
  "Henry Huang" <henry.hj@antgroup.com>,
  "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
   <rientjes@google.com>,
  "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
   <yuzhao@google.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
Date: Fri, 12 Jan 2024 12:40:22 +0800
Message-ID: <20240112044026.58580-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJj2-QG3jJcA=71n5imx+OjhMapPMN-1bfT5XQRjswxOPG9MvA@mail.gmail.com>
References: <CAJj2-QG3jJcA=71n5imx+OjhMapPMN-1bfT5XQRjswxOPG9MvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for replying.

On Thu, Jan 11, 2024 at 03:24 AM Yuanchu Xie <yuanchu@google.com> wrote:
> Does this present a problem with setting memcg limits or OOMs? It
> seems like deterministically charging shared pages would be highly
> desirable. Mina Almasry previously proposed a memcg= mount option to
> implement deterministic charging[1], but it wasn't a generic sharing
> mechanism. Nonetheless, the problem remains, and it would be
> interesting to learn if this presents any issues for you.
>
> [1] https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@google.com/

In this case, total size of shared memory usually is small(< 100MB).
What's more, almost shared pages were file cache. So it doesn't present any problems.

> I'm working on a kernel driver/per-memcg interface to perform aging
> with MGLRU, including configuration for the MGLRU page scanning
> optimizations. I suspect scanning the PTE accessed bits for pages
> charged to a foreign memcg ad-hoc has some performance implications,
> and the more general solution is to charge in a predetermined way,
> which makes the scanning on behalf of the foreign memcg a bit cleaner.
> This is possible nonetheless, but a bit hacky. Let me know you have
> any ideas.

Wow! per-memcg interface is also what we need.
It's hardly to control user's behaviors in our envrionment. We can't promise that all
process who share memory would be in same memcg.
Maybe kernel should provide new interface to make shared page charge more predictable.
I think it would take some overhead to do this.

The key problem of us is that we can't check whether page is accesed(no gen or ref changed) 
in this case.
page belongs to A, but maybe process in B read/write this page more frequently.
we may treat this page as cold page but accutly hot page.
Maybe just call folio_mark_accessed instead of folio_update_gen(should hold memcg lru lock)
for those remote memcg pages?

-- 
2.43.0


