Return-Path: <linux-kernel+bounces-31566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1883302F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21A1B22DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3145810C;
	Fri, 19 Jan 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CvFH2wPS"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBB5789A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699374; cv=none; b=C9+yhaYsPtwospJGevjI/N2v0O2rXjxwhhkcfy6m/QWKkTu0xczHh5hl+QsB3qGksRxb6sd1GQyuLcFY3ps9TV6tR9MP8HwlF17ryO93aA2DlhJ9sQc0DKBgAhrjkORsUYlPukQGWiiakR2CC0j+AetWzc7m93HYvWq/BRe39Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699374; c=relaxed/simple;
	bh=qBUWt82nGAl/Jo8NF/0ION3U1peVCjsCQWauDswqerk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLDlcls3IanwTjvvS8AN2PoQaaSd2zF6QxoVh0rmotE6P5GAz7ljD9wQ+mHIIV1njVJl7tPGV7LiNdPMu7FWZIA8ms4kgqpTFUOwUvPZK3IzujjfEWfkkHWk8msXt7mF18Mi8NbMkJtyjKDHNPR2zJbgDhCcyEzJlpqiIkQfiPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CvFH2wPS; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso13615539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705699371; x=1706304171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhg0VXUn6GSGo/fJYyg3JJjsnII4D6lYYn8pfIAZut0=;
        b=CvFH2wPSMBas/+pHMR/fnumEUl8bTQWloZERRk8EcRN+dXTs90U8Dzij4MjHUMFFjy
         6UGjNtIlqSZGGUDFsAnKxSVfauPAhd290Xc72QUs341xvK1KzDa8nYWMfnw5Ld+uHsE3
         1fYCmuojZ04rlPVwJz+cGJNeXWdoqLtZl83vVtv8Cus5FCDx5V4EevfAht8b+57MNOlY
         PpnaHGHPdXCKNsyRuDpjav1h2K7nxFHL4DDWzX3N+uNkw5xN2MqcDiYMyiLid8mq/pfE
         u3f6mCR40YyIoeXhth8kWyUJON2tZNX4+mbSF6k9QfWdumw4T8f/ZV9mLvZgqtEDKsnf
         zylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705699371; x=1706304171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhg0VXUn6GSGo/fJYyg3JJjsnII4D6lYYn8pfIAZut0=;
        b=MmOyTc6yvHSTqdyhKOKbB1tvMTnjxlftxVsS8MORWMK6Gld0gaE1WGaHhyW2qwQkSs
         OEi4fA0hA6NbA5U9qGu8dA/WqeRhLHVzAqS0NZeDn996zGYkBeqbo0viFd0HH92XWnAC
         18sPN2Xe+8ty9q9HZvK450NGo0pQQ5ocZAY4Q2z2iOoE+i3WJnt+LfiedP2JpZ3p8SG8
         iOkymqWOYBZ/19LIV75/5xQJYLLmSiMh/XXHPwJ46HjpbopJS9WJq4dhYIXRGXgXoL7l
         wB3rZena5tE5grR2DRHiFznp0l2oabzwN5R7ny41tjqS6WG84i1MNaUb3uYemz1WYHO9
         +cdA==
X-Gm-Message-State: AOJu0YzWwXNa38yLK79OCNBBeDTmmAfqZ6e/aL5GfPg4xpAr5pWOBB8V
	XwTPK8ycYkAP84TtQVTUtdTXpyu7Sk4WTRS0AvVR3daEYfj/5QdOWEPnP4v/8F4=
X-Google-Smtp-Source: AGHT+IEhZv7rBM/0mhazF6qpEocA3UoyedhPX7vTStNQc2skiNZxCDLHraxA8cGa9o7E0Y+OafuGNQ==
X-Received: by 2002:a05:6e02:1a84:b0:361:9667:937f with SMTP id k4-20020a056e021a8400b003619667937fmr935474ilv.1.1705699371364;
        Fri, 19 Jan 2024 13:22:51 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t11-20020a92c0cb000000b003606dc5804asm5634663ilf.65.2024.01.19.13.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 13:22:50 -0800 (PST)
Message-ID: <017a1df5-e08b-44c5-9e4e-f61a9ce49e8d@kernel.dk>
Date: Fri, 19 Jan 2024 14:22:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REGRESSION: no console on current -git
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: avier Martinez Canillas <javierm@redhat.com>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
References: <05ea3233-20dd-4af7-86cc-de11ad2efe84@kernel.dk>
 <0293b14b-6188-4229-9fb6-29fbbdb8dc83@gmx.de>
 <9e09464a-d58c-4f17-9318-26f0813a3023@kernel.dk>
 <b6350dac-0be6-45f9-9309-d196ea455dea@gmx.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b6350dac-0be6-45f9-9309-d196ea455dea@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 2:14 PM, Helge Deller wrote:
> On 1/19/24 22:01, Jens Axboe wrote:
>> On 1/19/24 1:55 PM, Helge Deller wrote:
>>> Adding Mirsad Todorovac (who reported a similar issue).
>>>
>>> On 1/19/24 19:39, Jens Axboe wrote:
>>>> My trusty R7525 test box is failing to show a console, or in fact anything,
>>>> on current -git. There's no output after:
>>>>
>>>> Loading Linux 6.7.0+ ...
>>>> Loading initial ramdisk ...
>>>>
>>>> and I don't get a console up. I went through the bisection pain and
>>>> found this was the culprit:
>>>>
>>>> commit df67699c9cb0ceb70f6cc60630ca938c06773eda
>>>> Author: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Date:   Wed Jan 3 11:15:11 2024 +0100
>>>>
>>>>       firmware/sysfb: Clear screen_info state after consuming it
>>>>
>>>> Reverting this commit, and everything is fine. Looking at dmesg with a
>>>> buggy kernel, I get no frame or fb messages. On a good kernel, it looks
>>>> ilke this:
>>>>
>>>> [    1.416486] efifb: probing for efifb
>>>> [    1.416602] efifb: framebuffer at 0xde000000, using 3072k, total 3072k
>>>> [    1.416605] efifb: mode is 1024x768x32, linelength=4096, pages=1
>>>> [    1.416607] efifb: scrolling: redraw
>>>> [    1.416608] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>>>> [    1.449746] fb0: EFI VGA frame buffer device
>>>>
>>>> Happy to test a fix, or barring that, can someone just revert this
>>>> commit please?
>>>
>>> I've temporarily added a revert patch into the fbdev for-next tree for now,
>>> so people should not face the issue in the for-next series:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?h=for-next
>>> I'd like to wait for Thomas to return on monday to check the issue
>>> as there are some other upcoming patches in this area from him.
>>
>> Given the issue (and that I'm not the only one reporting it), can we
>> please just get that pushed so it'll make -rc1? It can always get
>> re-introduced in a fixed fashion. I don't run -next here, I rely on
>> mainline working for my testing.
> 
> I agree, it would be good to get it fixed for -rc1.
> So, it's ok for me, but I won't be able to test the revert short time right now.
> If you can assure that the revert fixes it, and builds in git-head,
> I can now prepare the pull request for Linus now (or he just reverts
> commit df67699c9cb0 manually).

I already tested a revert on top of the current tree, and it builds just
fine and boots with a working console. So reverting it does work and
solves the issue.

-- 
Jens Axboe


