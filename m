Return-Path: <linux-kernel+bounces-102731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0087B6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0C6B21D59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED4524C;
	Thu, 14 Mar 2024 03:01:40 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472694A15
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385299; cv=none; b=UIRuV3JDm/OjLKMkuZu/HR6oVddFhKtUz2+VAUbLo1mwUbFM7aiHZ7o8F/FvWfHyVMfeSwHt2dhTQkl+RwtIkf91K7Tvt3cq+fwwSPWjmT59/tOy4Qxz4SpsUodwE5wBAswjixr+c+fsN7H1pqLO33X5TE9b0QhYIUb0bWWDtSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385299; c=relaxed/simple;
	bh=Ii+1FAL2esZW333r1Jlft0rX1mqtsvQqoU8EiDoEjzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3DJ9rP3QUJF/WEUwLNzv1gBNcfNlg46a+CwrdCoTD3VXefpjjUGcKDwfOwpNnTIFUDanF4vkLxjxk6Cxt3nTDwIjg6cFZEWEl9jMsK5fS46LiNwkrwr1K/LcRdYA1AWpwT6IS//5lcGVUSYoqtqlbfTTxyv7obCbSnlk8e9iLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42E31SKK004142;
	Thu, 14 Mar 2024 12:01:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Thu, 14 Mar 2024 12:01:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42E31RBp004134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 14 Mar 2024 12:01:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2ff96a50-fc65-4e42-b15d-097c0f15a455@I-love.SAKURA.ne.jp>
Date: Thu, 14 Mar 2024 12:01:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,page_owner: Fix recursion
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lei Yang <leiyang@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
References: <20240313234245.18824-1-osalvador@suse.de>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240313234245.18824-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/14 8:42, Oscar Salvador wrote:
> Prior to 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> the only place where page_owner could potentially go into recursion due to
> its need of allocating more memory was in save_stack(), which ends up calling
> into stackdepot code with the possibility of allocating memory.
> 
> We made sure to guard against that by signaling that the current task was
> already in page_owner code, so in case a recursion attempt was made, we
> could catch that and return dummy_handle.
> 
> After above commit, a new place in page_owner code was introduced where we
> could allocate memory, meaning we could go into recursion would we take that
> path.
> 
> Make sure to signal that we are in page_owner in that codepath as well.
> Move the guard code into two helpers {un}set_current_in_page_owner()
> and use them prior to calling in the two functions that might allocate
> memory.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")

Maybe culprit for a page owner refcount bug reported at
https://syzkaller.appspot.com/bug?id=8e4e66dfe299a2a00204ad220c641daaf1486a00 , for
that commit went to next-20240214 and syzbot started failing to test since next-20240215 ?

Please send this patch to linux-next.git as soon as possible (or can someone experiencing
this bug try booting linux-next.git with this patch applied, so that we can check whether
syzbot can resume testing linux-next.git), and then send to linux.git together (so that
various trees which depend on linux.git won't start failing to boot).


