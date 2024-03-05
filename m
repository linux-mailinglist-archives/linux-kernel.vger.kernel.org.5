Return-Path: <linux-kernel+bounces-92686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053CF87245B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E171F259EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D08F55;
	Tue,  5 Mar 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AydxLkZz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E979D3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656314; cv=none; b=itw7e0ep8EmyfKa4A1CdEY3HMVfVYmLR85GcWmIrQbiZKgjYMnXVsUK1vDPxDmebvQqrQMv71ZHb6lBno0/UEPqjZG/EwepPXAO5L/z9aOIiTSIvhoe0bikeOTjCV/UIO3OMA3x8Gu8tWNkgmf+f1ZH9QQJR6s/ENo6LpzQ1ZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656314; c=relaxed/simple;
	bh=/JbAVBt5dMRpm8wlJigwtQpNLZ0qkxBdk9oG80TTA54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmW3NEdsH/+1LhnsqtVlwTofFZiQsbi7QsJoq5sf0QA/tvT/xh9N3Amt3is9MKuwBPqIMEZPi7espLrDP2KHyWMLxAi4OLUjQ3ZI0ItQ6FSdSqgc/S3dYSUQRVGWYUUT7IUibW3XWD1abhkoODwJkhP0Bgi8Ands7eUdv4cnZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AydxLkZz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709656311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXgCv056O/7zp95FcTfgFnOwWrzQXNCndhaAX1Dnxss=;
	b=AydxLkZzn2J43MHHvIR+6bGFOIHnoYsmI9DNgw0Q9HT0KmQgKRjDxd7uY1a9QwIf4hZ55l
	C3H9utQsqAZ7qE+X307fwnRJfhGgDZYO4Yp1xBfq9v25dTmICUeEp1QRz1OXHoq/g79B54
	AUdlqH/cRIs40v0fQyDpOK3vRrfIP4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-myYpRxOeNumV2rAuKAcHCA-1; Tue, 05 Mar 2024 11:31:50 -0500
X-MC-Unique: myYpRxOeNumV2rAuKAcHCA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412eeb789d9so3474785e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 08:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709656308; x=1710261108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXgCv056O/7zp95FcTfgFnOwWrzQXNCndhaAX1Dnxss=;
        b=ZjYw+qptDWNSFMMwZ7nRS5AIgmlyrSjDLHSfK1iP87gsfrF+ASXLvGtYTkVMiP0+0c
         My5SJsp0Nr8EZiL0q9OD4k69RiAg+H0C3AB9Ht+nAJgznjThLpjLuddWKRs2XKsWqH4h
         mlOD+gcCihHRwI/W441nt87sZjipZFQA2G7VsHmUdFiVIXTFV0KRG2mKwgrAfX8eCMp7
         cCkoVh52pGxTmeVvB8/Uhg8DsHrZaPQvWm4l8ZX8GvUnzu7YzrI2nq8Z6qo36KQg/LZt
         s0/FxYB4k5tRNMcb8gpbruAscgMBV2lC6dSs/YbuljbABvvclc2QXUezD7N5RIAiMumB
         tWRg==
X-Forwarded-Encrypted: i=1; AJvYcCVKOlmttlZgvZJzRdBk1vXMoqVqqCyNyd5sgxqsDnOCksDy8Zdi8jnyMHoEuyaj5jGYvl5NSejfF53lLo4/8+6GkPpphXWtBJYPd+il
X-Gm-Message-State: AOJu0Yz/sHm46Q+qVHNJyg3Hn/pYDHJgsF2jMFj8e1I/yBNNZ/Nf9EIS
	77yissm4tmGZBQqYZ4SwTkjzLmG0hCu8eD72oY0GggTyusFOXJ5W91NxK6D0Sek4x0DyBCSwctj
	Uy8tz6V9MkpCpx5r+ddwm8dcWxOGo5j8ivFp/Mh8iFP9HdXXhwbVLQNfgThvXX0R2bc7n4csc
X-Received: by 2002:a05:600c:3b87:b0:412:e55e:83de with SMTP id n7-20020a05600c3b8700b00412e55e83demr4651279wms.7.1709656308493;
        Tue, 05 Mar 2024 08:31:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwWCPNQ67k9EXc/a4VhY4qoHguRPFEF+4DIsDEhV2/uKWWUge72Mjm5EOArMoOwGUPip+I8w==
X-Received: by 2002:a05:600c:3b87:b0:412:e55e:83de with SMTP id n7-20020a05600c3b8700b00412e55e83demr4651262wms.7.1709656308137;
        Tue, 05 Mar 2024 08:31:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id h3-20020adfa4c3000000b0033dd2a7167fsm15503470wrb.29.2024.03.05.08.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 08:31:47 -0800 (PST)
Message-ID: <aa383f43-b57d-47f7-9b54-1169956586cb@redhat.com>
Date: Tue, 5 Mar 2024 17:31:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] How to test panic handlers, without crashing the kernel
Content-Language: en-US, fr
To: John Ogness <john.ogness@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lukas Wunner <lukas@wunner.de>,
 Uros Bizjak <ubizjak@gmail.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
References: <266579a9-fde6-40ff-b13d-fb2312db406c@redhat.com>
 <87edcpn1l3.fsf@jogness.linutronix.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <87edcpn1l3.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/03/2024 22:12, John Ogness wrote:
> [Added printk maintainer and kdb folks]
> 
> Hi Jocelyn,
> 
> On 2024-03-01, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> While writing a panic handler for drm devices [1], I needed a way to
>> test it without crashing the machine.
>> So from debugfs, I called
>> atomic_notifier_call_chain(&panic_notifier_list, ...), but it has the
>> side effect of calling all other panic notifiers registered.
>>
>> So Sima suggested to move that to the generic panic code, and test all
>> panic notifiers with a dedicated debugfs interface.
>>
>> I can move that code to kernel/, but before doing that, I would like to
>> know if you think that's the right way to test the panic code.
> 
> One major event that happens before the panic notifiers is
> panic_other_cpus_shutdown(). This can cause special situations because
> CPUs can be stopped while holding resources (such as raw spin
> locks). And these are the situations that make it so tricky to have safe
> and reliable notifiers. If triggered from debugfs, these situations will
> never occur.
> 
> My concern is that the tests via debugfs will always succeed, but in the
> real world panic notifiers are failing/hanging/exploding. IMHO useful
> panic testing requires real panic'ing.

Yes, but for the drm panic, it's still useful to check that the output 
is working (ie: make sure the color format and the framebuffer address 
are good). Also I've reworked the debugfs patch, so I don't have to call 
all panic notifiers. It's now per device, so your can trigger the 
drm_panic handler on a specific GPU.

> 
> For my printk panic tests I trigger unknown NMIs while booting with
> "unknown_nmi_panic". Particularly with Qemu this is quite easy and
> amazingly effective at catching problems. In fact, a recent printk
> series [0] fixed seven issues that were found through this method of
> panic testing.

Thanks for this tip, I used to test with "echo c > /proc/sysrq-trigger" 
in the guest, but that's more permissive. I'm now testing with virsh 
inject-nmi, and drm_panic is still working.
> 
>> The second question is how to simulate a panic context in a
>> non-destructive way, so we can test the panic notifiers in CI, without
>> crashing the machine.
> 
> I'm wondering if a "fake panic" can be implemented that quiesces all the
> other CPUs via NMI (similar to kdb) and then calls the panic
> notifiers. And finally releases everything back to normal. That might
> produce a fairly realistic panic situation and should be fairly
> non-destructive (depending on what the notifiers do and how long they
> take).
> 
>> The worst case for a panic notifier, is when the panic occurs in NMI
>> context, but I don't know how to simulate that. The goal would be to
>> find early if a panic notifier tries to sleep, or do other things that
>> are not allowed in a panic context.
> 
> Maybe with a new boot argument "unknown_nmi_fake_panic" that triggers
> the fake panic instead?
> 
> John Ogness
> 
> [0] https://lore.kernel.org/lkml/20240207134103.1357162-1-john.ogness@linutronix.de
> 

Best regards,

-- 

Jocelyn


