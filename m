Return-Path: <linux-kernel+bounces-81260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D78672EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145C61C2341C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8131D532;
	Mon, 26 Feb 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sDK81OEP"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA31CFB5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946558; cv=none; b=H292Qn3TBoNMOKxketIK/1gqjrbohRa51v2ew8IxxhN7SZbFIjESJy2hkjerlSuu1kUMJZNmrj7L9ER8WnpPv+MJb1PQR1V78rU2CmEpqLq5hTeiALBuc/81zdorA9kdmbfUqTjO+ilJbDlN+gnXay3jO/OZqqyWiFK30zF1Enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946558; c=relaxed/simple;
	bh=ubOTdtYuhUW1HZ1VF9oaQpQ5UVJmPJvAjYgQVDcEV+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeTJ0Yb2EPS0gg0uOvB8mOmrW84pD6QPP6nelRIs2F/+57xiLqkHkndMFjS+JRlxyWkcs/PUacjZnFLN+bIop7SOQR02e3uZzDqhe7kmnu3xxNiHO3SQGLxEeWaDKiW4XhhuabuyL7O3WrVXM71oX7YWzrDZjDzwquajUTzuyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sDK81OEP; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708946546; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yFKuCFUbQJWXllA9q4A3yOIm5hDbUr1UP4xb9Ika1tA=;
	b=sDK81OEP1DQNRUoZMHAVp4cuC4S0Hv9TlNB/eGzahpTxmGVPjaIyN0zhboSt3A21R5cYydYEXgVUzx9VMvTEn8hdQIH4rH1TGDBHX6ED0CDbbBGaCzlN1shesCqr0pYaMOgmHw8EmyNKRaqFszRelnfRuipOU2+rRSq5m2utT6M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1HP6Kg_1708946545;
Received: from 30.178.81.124(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W1HP6Kg_1708946545)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 19:22:26 +0800
Message-ID: <e649d47c-16d5-4077-8327-b6f76aa099a5@linux.alibaba.com>
Date: Mon, 26 Feb 2024 19:22:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, thp: display [never] for defrag when THP is set to
 never
To: David Hildenbrand <david@redhat.com>,
 Yuanhe Shu <xiangzao@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240222115323.4925-1-xiangzao@linux.alibaba.com>
 <ec6f2c48-3010-4a02-8f42-fc6b912039cf@redhat.com>
 <d9eb6672-788e-414d-8138-37a3038e3c47@linux.alibaba.com>
 <8a723092-347d-443a-82e1-4093f6a1ba0e@redhat.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <8a723092-347d-443a-82e1-4093f6a1ba0e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/2/26 16:54, David Hildenbrand 写道:
> On 23.02.24 12:01, Liu Song wrote:
>>
>> 在 2024/2/22 20:14, David Hildenbrand 写道:
>>> On 22.02.24 12:53, Yuanhe Shu wrote:
>>>> When transparent_hugepage is set to never by cmdline or echo, defrag
>>>> still show what it used to be and can be modified which makes user
>>>> confusing whether defrag would take effect.
>>>>
>>>> Actually if transparent_hugepage is set to never, defrag will not take
>>>> effect. Just Display never and remain unchangeable to for defrag when
>>>> transparent_hugepage is set to never.
>>>>
>>>> Suggested-by: Liu Song <liusong@linux.alibaba.com>
>>>> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
>>>> ---
>>>
>>> No, I don't think we want such a dependency between both options.
>>>
>>> You might just end up breaking existing scripts (enable defrag before
>>> enabling THP) for no good reason.
>>>
>> In certain situations where khugepaged_thread is NULL, it would be more
>> reasonable for the value of
>> /sys/kernel/mm/transparent_hugepage/khugepaged/defrag to be 0. The patch
>> should include a fix for this case.
>
> Why?
>
> We have a bunch of THP toggles. They reside in 
> "/sys/kernel/mm/transparent_hugepage/", indicating that they are THP 
> specific.
>
> Some of them are only in effect if some other toggles are set.
>
> That is very common practice.
>
> If you think something could be confusing, maybe clarify the doc? I 
> don't immediately see why any code changes are required, really.

We should explain this in the documentation, but to be honest, many
people don't read the documentation, and even after we explicitly
disable THP with transparent_hugepage=never, khugepaged/defrag is still
set to 1, and users come asking why it's still defragging. We can't
expect all users to have technical expertise, or to diligently read
through the documentation; it would obviously be best if we could avoid
user confusion altogether.

Thanks


