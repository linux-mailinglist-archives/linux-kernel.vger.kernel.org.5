Return-Path: <linux-kernel+bounces-95928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF97C87550E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A02286B91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0E130AE3;
	Thu,  7 Mar 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXIdf1Ci"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C812F5A7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832183; cv=none; b=VuZpsA9gUxojnq8hQh5n6xBDlVskp4V8Ozhpe+wVDYGHAs587ILT38+9dlrHrMUkiPaitBsCQgL85vsSh+m5If4zYRcO8kMdeCpfzaVz1MBGNYbIwm+GDI4MuqK/EnWNZcIZLJr1JDIUNsoyFozo5kOMqjnVpr1JEd6RfhbXJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832183; c=relaxed/simple;
	bh=0vt9FiXpx4GEdr3Xzqy6R1bArKqRNlv3YXX9M7sl3M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZICwFQp60xxd57E4g9sbjWne8JtpJYHz4pYP0czg1H/z/l0VVWZvDAYC3lcyDpO3hccGsznRPs0QFTPAcp5OwjtpbjsbMpWmfmeh39YLnOJwUS2vC4NHQYxh6eLHINR+2ukcd4dySGV762G7P7OzdMwi/quUkleTlJdamLuw+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXIdf1Ci; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709832179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHud0NIMnubYeYck52m3NRwtUWz1SVAUUQWnc4Gem10=;
	b=EXIdf1Cixdyn75ZnfZoJG9tcYcFjZiW7LbklU40YDFT/9qltGycqoZRRrUOC58sLohMZ/F
	u0gN2Cyftu2eRDlVE81JPNJUkbZiwf+VbGZzGUPK2bZ4wGs03nvkUYtOca061cCXE5nWoh
	oTB6iP7qIunUyNiE0+Tngq6bUpuQH3U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-Fjv6i2ezNv2Xm2qyXv29ng-1; Thu, 07 Mar 2024 12:22:58 -0500
X-MC-Unique: Fjv6i2ezNv2Xm2qyXv29ng-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51333e20813so973557e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709832177; x=1710436977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHud0NIMnubYeYck52m3NRwtUWz1SVAUUQWnc4Gem10=;
        b=WvFewAwlSwu5xYVdjJSesf5b0kE3GUP7Jdtu0tMT6D7vJ2l2KlbIq+bKw4Z0uMxX65
         dd+uNe+Y8+5cgqbw2iTUfL3FIw5tNJdeWDxLyqjNwi8ie2lwmbhoSOx66OeKs7VyrPxU
         e/c2t7MmmLKgO/k8x7uLHXVyCYBOyQhZtWxGXpWaZM2Bfvs0rajMAy69XD7LpV7hUc1j
         GFX7Seg1bFHToG6mc8HsTnHeFocbyhcviq0h1+9d/X/sQF9Rgpcf1QNanz5hHHkxkB4C
         gnW7G/Tixo5Zm/8cy1ULEOAKIaSrY3trcwv/m+Vga3DPX53jGlPvp7BqjmVCz/DGMqWd
         Eq1A==
X-Forwarded-Encrypted: i=1; AJvYcCWbP8ljLO4EYwY5+q485BmD7P2YaGI9ChtAoqETJbjqyQR2JdToHHQTEvVA0fGkbrUTZE+YfbQr4yCUA8RqnWx12PGUoETeo+XDilpC
X-Gm-Message-State: AOJu0YyqdecPTYnhZROeqPhfGXfD52xjARm6HQ625eWMMWwHD5/RBiz3
	BU7zFyiZCqUGN+ICfZsEcYy9n9+9PhRzvcZbvAgxEdTn88cvcFxAnGWWeKkXNnJ+bsdf/PyFVkU
	gcbS5tUwFvSHVEiKjWagZggTjAr7vt8c1eligUqsc3W2tDwlWJLScFdEnbZ4qzw==
X-Received: by 2002:a19:5e52:0:b0:513:3bb2:325f with SMTP id z18-20020a195e52000000b005133bb2325fmr1784287lfi.24.1709832176883;
        Thu, 07 Mar 2024 09:22:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz5XIN51pm0w0Ds04sX7nTgcZRXzxLF4YKIC4rJgsp3JuYsh1bD2RPfc80ajrhn3Agzucyug==
X-Received: by 2002:a19:5e52:0:b0:513:3bb2:325f with SMTP id z18-20020a195e52000000b005133bb2325fmr1784268lfi.24.1709832176495;
        Thu, 07 Mar 2024 09:22:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id q13-20020a5d61cd000000b0033e11ff6284sm20037347wrv.12.2024.03.07.09.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 09:22:55 -0800 (PST)
Message-ID: <adeac189-87f8-4b70-9c04-3eaaf2ed7bc5@redhat.com>
Date: Thu, 7 Mar 2024 18:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] How to test panic handlers, without crashing the kernel
Content-Language: en-US, fr
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Michael Kelley <mhklinux@outlook.com>,
 John Ogness <john.ogness@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lukas Wunner <lukas@wunner.de>,
 Uros Bizjak <ubizjak@gmail.com>, Petr Mladek <pmladek@suse.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
References: <266579a9-fde6-40ff-b13d-fb2312db406c@redhat.com>
 <87edcpn1l3.fsf@jogness.linutronix.de>
 <15015345-3068-2fb8-aa38-f32acf27e1d0@igalia.com>
 <SN6PR02MB4157AF2E765F7ED3B9487351D4222@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d1d2093c-72a3-4f64-9a8f-9844dc38f0c5@redhat.com>
 <3d0c4180-aa6d-4519-d6d8-8f16b98587dc@igalia.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <3d0c4180-aa6d-4519-d6d8-8f16b98587dc@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2024 18:50, Guilherme G. Piccoli wrote:
> On 05/03/2024 13:52, Jocelyn Falempe wrote:
>> [...]
>> Or maybe have two lists of panic notifiers, the safe and the destructive
>> list. So in case of fake panic, we can only call the safe notifiers.
>>
> 
> I tried something like that:
> https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/
> 
> There were many suggestions, a completely refactor of the idea (panic
> lists are not really seen as reliable things).

Thanks for sharing this, so it's much more complex than what I though.
> 
> Given that, I'm not really sure splitting in lists gonna fly; maybe
> restricting the test infrastructure to drm_panic plus some paths of
> panic would be enough for this debugfs interface, in principle? I mean,
> to unblock your work on the drm panic stuff.

For drm_panic, I changed the way the debugfs is calling the drm_panic 
functions in the last version:
https://patchwork.freedesktop.org/patch/581845/?series=122244&rev=9

It doesn't use the panic notifier list, but create a file for each plane 
of each device directly.
It allows to test the panic handler, not in a real panic condition, but 
that's still better than nothing.

> 
> Cheers,
> 
> 
> Guilherme
> 

Best regards,

-- 

Jocelyn


