Return-Path: <linux-kernel+bounces-31646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7911A8331D6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E98DB22B05
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724977F7;
	Sat, 20 Jan 2024 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CdUNf2s9"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426C39F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705710777; cv=none; b=kzWfdEJY4O/0Aku9jLUbL12bkwRRR2D4VlhDgYePY627A7psGl0/Kg7dyJ0vwECKttkTGxFxYfIySMKg0K8V3bU+A4fdgZigH32iIAL3plkVfokeVXmfBIM8cV6RcdhfUQUUDnVdWWoaafXP+dhKVUAeWInn3TcC/9iVoYeAQwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705710777; c=relaxed/simple;
	bh=/+xk1GzZ99hwKDwrlG+v/nJqc/sv4UabtTzChwEyZeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJpBuYyf4eOXRBn6uk6xX2lxLVanypAhVnIpVNvmTIqPCpRGWyPSY7FuD8uk6jRd1+kFODG4/0lGQkph8cwTbHEZOEct5o7/R8BvhHPJVvOcMO04RVVrLkpoFyKOrGjjWEgo+hngVKYknFbqXHeSu4/3zD/Pj07SNoZIY0SqjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CdUNf2s9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9ac0521c6so258101b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705710775; x=1706315575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXbx5KLjnuEXGoUIzJq2FnD3gOZC2HLZU+Ar46f2g5k=;
        b=CdUNf2s9ocEoh6+ZRLGbjiwYtSqBxzbNiWc4llbmFtiNcYPiGGopdjhhnX68xBWJE/
         FXWasEfvCtT6s9Nr8vSfrQU05Wbff99E0EfbHhUsUAP94X10kzvixdtioJGl6eYGT+XG
         DALcMdSslVfdQEytbVS/r0FLCHjZoNJHMrTVQGbfQsLpWbdvBCYP3we5pWUGBAWlh2hq
         Zg9Ez6so37TrX2vGswObytDpzTJKIO4Rjiuu13GOt6sXNrWpIIiB1hsSfZcFuzKVNGnw
         2qF+AiOk29KNjoWBcuv+yVS8gidnVymlzj2hwO2Vfg+SKSZYNkXxpTHUe7zUQFw9bIHu
         UGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705710775; x=1706315575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXbx5KLjnuEXGoUIzJq2FnD3gOZC2HLZU+Ar46f2g5k=;
        b=UacOKKAr5HJF8uNHF9ggbijAyhId/E/Clva0CcWGoCpL8aTabm5iJojEay2wDBlVCw
         SDEnxbrXFolHne/o3uh8mzNz1H4iEvWcMW804bFLrB9DWCPaVla6r4I4jbfymgLXS8fO
         Y+7YUWcQ52u6SYsuI+e/V5HPRgiI9Ns8lelrUWAMtVTSvHHizazWD+HuF/fVCMfyCI+u
         qhH4uGCDxehN2YOy3TnAIKp+orK08IEdqzXLa2/KUwHaOAj8BybKJuplpQatra5nJRg4
         dpP7FJ7FAN00smQ3uBDi0znkovEIWzH/Dz99WJVHsbq6SkFgmGrsQrOE3GeGdPjBfbEi
         rvPw==
X-Gm-Message-State: AOJu0YyF5hs+w05xtUHalI5KiXuqP75hUwGCUjxWiVlT22YUgLuW8U73
	H/qDmwX36QEli2Xb84rPDSVlabFsYX7TLfWyFIqSUCzxa6saZPtlx9tv1S7ZORk=
X-Google-Smtp-Source: AGHT+IH59wAMlt2d7W+nL3Uwl8nawc/QUfSY+ID2uXcxJLUh4jRHJpOIHDQd2m9rMCO4UXjvPCm5vA==
X-Received: by 2002:a05:6a20:c887:b0:19a:40f3:e460 with SMTP id hb7-20020a056a20c88700b0019a40f3e460mr1487067pzb.2.1705710774817;
        Fri, 19 Jan 2024 16:32:54 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q1-20020a63f941000000b005cfba3c84b7sm968115pgk.81.2024.01.19.16.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 16:32:54 -0800 (PST)
Message-ID: <93ffd2ee-fa83-4469-96fb-fb263c26bb3c@kernel.dk>
Date: Fri, 19 Jan 2024 17:32:52 -0700
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
 <017a1df5-e08b-44c5-9e4e-f61a9ce49e8d@kernel.dk>
 <2c267aef-f1a7-4277-aac6-75d9ea22ec03@gmx.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2c267aef-f1a7-4277-aac6-75d9ea22ec03@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 5:27 PM, Helge Deller wrote:
> On 1/19/24 22:22, Jens Axboe wrote:
>> On 1/19/24 2:14 PM, Helge Deller wrote:
>>> On 1/19/24 22:01, Jens Axboe wrote:
>>>> On 1/19/24 1:55 PM, Helge Deller wrote:
>>>>> Adding Mirsad Todorovac (who reported a similar issue).
>>>>>
>>>>> On 1/19/24 19:39, Jens Axboe wrote:
>>>>>> My trusty R7525 test box is failing to show a console, or in fact anything,
>>>>>> on current -git. There's no output after:
>>>>>>
>>>>>> Loading Linux 6.7.0+ ...
>>>>>> Loading initial ramdisk ...
>>>>>>
>>>>>> and I don't get a console up. I went through the bisection pain and
>>>>>> found this was the culprit:
>>>>>>
>>>>>> commit df67699c9cb0ceb70f6cc60630ca938c06773eda
>>>>>> Author: Thomas Zimmermann <tzimmermann@suse.de>
>>>>>> Date:   Wed Jan 3 11:15:11 2024 +0100
>>>>>>
>>>>>>        firmware/sysfb: Clear screen_info state after consuming it
>>>>>>
>>>>>> Reverting this commit, and everything is fine. Looking at dmesg with a
>>>>>> buggy kernel, I get no frame or fb messages. On a good kernel, it looks
>>>>>> ilke this:
>>>>>>
>>>>>> [    1.416486] efifb: probing for efifb
>>>>>> [    1.416602] efifb: framebuffer at 0xde000000, using 3072k, total 3072k
>>>>>> [    1.416605] efifb: mode is 1024x768x32, linelength=4096, pages=1
>>>>>> [    1.416607] efifb: scrolling: redraw
>>>>>> [    1.416608] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>>>>>> [    1.449746] fb0: EFI VGA frame buffer device
>>>>>>
>>>>>> Happy to test a fix, or barring that, can someone just revert this
>>>>>> commit please?
>>>>>
>>>>> I've temporarily added a revert patch into the fbdev for-next tree for now,
>>>>> so people should not face the issue in the for-next series:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?h=for-next
>>>>> I'd like to wait for Thomas to return on monday to check the issue
>>>>> as there are some other upcoming patches in this area from him.
>>>>
>>>> Given the issue (and that I'm not the only one reporting it), can we
>>>> please just get that pushed so it'll make -rc1? It can always get
>>>> re-introduced in a fixed fashion. I don't run -next here, I rely on
>>>> mainline working for my testing.
>>>
>>> I agree, it would be good to get it fixed for -rc1.
>>> So, it's ok for me, but I won't be able to test the revert short time right now.
>>> If you can assure that the revert fixes it, and builds in git-head,
>>> I can now prepare the pull request for Linus now (or he just reverts
>>> commit df67699c9cb0 manually).
>>
>> I already tested a revert on top of the current tree, and it builds just
>> fine and boots with a working console. So reverting it does work and
>> solves the issue.
> 
> I sent a pull request with the revert.

Thanks! You forgot the Reported-by, but no big deal.

-- 
Jens Axboe


