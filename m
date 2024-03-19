Return-Path: <linux-kernel+bounces-107483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A0487FD25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076D71C21D60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC5A7F46C;
	Tue, 19 Mar 2024 11:48:28 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5D57889
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848907; cv=none; b=hSGG3bxb6QDqhvGcM/lbK6IpGcFMH0AYpggIPfBWHi/ryi4+WeUHROdeJp9wJ/aHF+rIZMkhWumwjpb1dmh61MIPHMSLR+GQZVZ0mcofHnMdj+LBeRnJweDVm1IlLjlJksFpf2yluq5+hDRJvlv7nn49qHzYwQF0isihzAaJZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848907; c=relaxed/simple;
	bh=h6X5Isgv2Hfbkm85K/vHdqoLvwxZoJF9iY8zxUPx6do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odSzzL0Xct/lo8Olbx85aRwhjGgOFUjjPysIlBrt47SVTgcKs9nfAuI2x5cX7EvVM45u/Bc6Sec/YrSv23VhKehcBcLiR+6vdyUBKFkRmQwyoddYVfEcQAkUuW3NJOUIjIOCve4D5/nWpvjdZpBw/4dCj3U9DJHHb4a1pO/+GU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42JAq0AF078336;
	Tue, 19 Mar 2024 19:52:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Tue, 19 Mar 2024 19:52:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42JAq0WE078333
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 19 Mar 2024 19:52:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <37cb2e7c-97f1-4179-a715-84cc02096083@I-love.SAKURA.ne.jp>
Date: Tue, 19 Mar 2024 19:51:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,page_owner: Fix recursion
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lei Yang <leiyang@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
References: <20240313234245.18824-1-osalvador@suse.de>
 <2ff96a50-fc65-4e42-b15d-097c0f15a455@I-love.SAKURA.ne.jp>
 <ZfKPf_pGxv-xtSPN@localhost.localdomain>
 <ZfKgs9E2ozZER20D@localhost.localdomain>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZfKgs9E2ozZER20D@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/14 16:01, Oscar Salvador wrote:
> On Thu, Mar 14, 2024 at 06:47:43AM +0100, Oscar Salvador wrote:
>> On Thu, Mar 14, 2024 at 12:01:24PM +0900, Tetsuo Handa wrote:
>>> Maybe culprit for a page owner refcount bug reported at
>>> https://syzkaller.appspot.com/bug?id=8e4e66dfe299a2a00204ad220c641daaf1486a00 , for
>>> that commit went to next-20240214 and syzbot started failing to test since next-20240215 ?
>>>
>>> Please send this patch to linux-next.git as soon as possible (or can someone experiencing
>>> this bug try booting linux-next.git with this patch applied, so that we can check whether
>>> syzbot can resume testing linux-next.git), and then send to linux.git together (so that
>>> various trees which depend on linux.git won't start failing to boot).
>>
>> No, that is something else that I already started fixing a few days ago.
>> I think I will have the fix ready today.
> 
> I already have the fix. I will do some more testing and then I will send
> it out.

OK. Please test your patch using
https://syzkaller.appspot.com/bug?extid=98c1a1753a0731df2dd4 .


