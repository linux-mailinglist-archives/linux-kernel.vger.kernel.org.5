Return-Path: <linux-kernel+bounces-31897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C55833611
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7241F21CC1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2591112E47;
	Sat, 20 Jan 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ip80SeM2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5F125CC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705782371; cv=none; b=ZbuCpriyos5vd6+UHTrSjyT3RIXL9z/OOB/xKvasT0qjy++fRXi6D85cYwrIm6JE3yalwYgpXuYTpwBDhrZzqFoMErN2H58V5/DmczMIs/9fQRj6VYTfsDjiud4k/Y7901hXIoNptUIVKUTo5jj5CcfPErac7AXshmNqCHRpF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705782371; c=relaxed/simple;
	bh=E9NsYbZxlVjESIGCacSf+Ik7c/ume2adKqxJLr5Rotg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=d6/MLg/T+uGoPV6lChhFfyLOhNd3adT3/DVg7z9bO5T7C+cwUNDgikJHE8aVjuuFtlTQInkEpjrYyMJ3eLEkqPazl5PBURUIwGzU1/5asQE68V6oEYJsskLCQxLdehr/ZSetiyHFMyTYYl65eyAvP7RfwyhVsiAa9K1pNc5GniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ip80SeM2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705782368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DX4dXMQ9Zd/jP9gKVwQfRx3j8zLRWZtP8Q+HxZciNU4=;
	b=Ip80SeM2GcYz79zkUf2bxy8d6ITbPZ1gi1vND2S29oQ64VJY5bsNUFxfxphKSq2JgqzK2J
	/JlPgpxDE7kIZY/7kl2ne6Jk60oBiwAj7+ytEP0LI0lVeKg/N7+4L7A1XXrC69LlHQ3CPo
	uygZaOw3uIeigUpF89yGlJiW3SE2kSU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-JxLIHuzAOlSXs_LEBypeiQ-1; Sat, 20 Jan 2024 15:26:06 -0500
X-MC-Unique: JxLIHuzAOlSXs_LEBypeiQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2cccd597247so18047381fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 12:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705782365; x=1706387165;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DX4dXMQ9Zd/jP9gKVwQfRx3j8zLRWZtP8Q+HxZciNU4=;
        b=FgZPtpGNo2mCyly1zsGSDw3+IkQXT16Y/bp5kOswvEDTIJX8KSNjdJ5KNRjoYvQOej
         AiFQJ7H6nqBiKuqkenqYpqSLaHJSICxyMFmFrnk7wu3UOLFwjPI/871DXlKfbazj62SN
         FKH6LHdpY8e1J0naNSgmIDPo/ZwvL0NIJHxeym9umAYQj38idtCSQ4IZ5IN04LHNL+9w
         u0OgETBaTFVrGil8aYhtzDYsrYDF9TAHslDLUCfxp9hOnzwMhG7nF/Y4n+Fz0sCcdLYg
         zJKlVk4ZgnIBzHZbGjzQW7QJ8nk9ZbE3oacSZdQOOmFVDY35AerhzKKmwCfAFULvUid5
         6Xwg==
X-Gm-Message-State: AOJu0Yz5Obv+GLJtnlp/NZ7xxmL+R7EZ5QP7DrcryAaKOzf+uRBSRBxr
	6LzYckXnhdJKYY6Rad+k3Ujlm21D6BKpY2QK0NHpblxTdGqLFYWdKWjU1LOadVAqalGvKKoqIhZ
	dXZnJRz9fM/3iejfaM76EYBXqSfaYODHXfjndTkJyIhg0riC/1ginPhB2e2seDQ==
X-Received: by 2002:a2e:91c9:0:b0:2cd:fa79:4cc1 with SMTP id u9-20020a2e91c9000000b002cdfa794cc1mr275565ljg.89.1705782365081;
        Sat, 20 Jan 2024 12:26:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSO0D5rt1ubbifU4nVe4zOHGkl8IEXhQH7ZMFwmsWrcpWj5rb7od2jV1jehadOksOEMsSGNw==
X-Received: by 2002:a2e:91c9:0:b0:2cd:fa79:4cc1 with SMTP id u9-20020a2e91c9000000b002cdfa794cc1mr275561ljg.89.1705782364743;
        Sat, 20 Jan 2024 12:26:04 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p16-20020aa7cc90000000b00558a7d36956sm12156869edt.0.2024.01.20.12.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 12:26:04 -0800 (PST)
Message-ID: <f27b491c-2f1c-4e68-804c-24eeaa8d10de@redhat.com>
Date: Sat, 20 Jan 2024 21:26:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: PS/2 keyboard of laptop Dell XPS 13 9360 goes missing after S3
To: Paul Menzel <pmenzel@molgen.mpg.de>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
 Dell.Client.Kernel@dell.com, regressions@lists.linux.dev
References: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
Content-Language: en-US, nl
In-Reply-To: <0aa4a61f-c939-46fe-a572-08022e8931c7@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paul,

On 1/18/24 13:57, Paul Menzel wrote:
> #regzbot introduced v6.6.11..v6.7
> 
> Dear Linux folks,
> 
> 
> There seems to be a regression in Linux 6.7 on the Dell XPS 13 9360 (Intel i7-7500U).
> 
>     [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
> 
> The PS/2 keyboard goes missing after S3 resume¹. The problem does not happen with Linux 6.6.11.

Thank you for reporting this.

Can you try adding "i8042.dumbkbd=1" to your kernel commandline?

This should at least lead to the device not disappearing from

"sudo libinput list-devices"

The next question is if the keyboard will still actually
work after suspend/resume with "i8042.dumbkbd=1". If it
stays in the list, but no longer works then there is
a problem with the i8042 controller; or interrupt
delivery to the i8042 controller.

If "i8042.dumbkbd=1" somehow fully fixes things, then I guess
my atkbd driver fix for other laptop keyboards is somehow
causing issues for yours.

If "i8042.dumbkbd=1" fully fixes things, can you try building
your own 6.7.0 kernel with commit 936e4d49ecbc:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=936e4d49ecbc8c404790504386e1422b599dec39

reverted?

Regards,

Hans








> 
>     [    1.435071] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
>     [    1.435409] i8042: Warning: Keylock active
>     [    1.437624] serio: i8042 KBD port at 0x60,0x64 irq 1
>     [    1.437631] serio: i8042 AUX port at 0x60,0x64 irq 12
>     […]
>     [    1.439743] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
> 
>     $ sudo libinput list-devices
>     […]
>     Device:           AT Translated Set 2 keyboard
>     Kernel:           /dev/input/event0
>     Group:            15
>     Seat:             seat0, default
>     Capabilities:     keyboard
>     Tap-to-click:     n/a
>     Tap-and-drag:     n/a
>     Tap drag lock:    n/a
>     Left-handed:      n/a
>     Nat.scrolling:    n/a
>     Middle emulation: n/a
>     Calibration:      n/a
>     Scroll methods:   none
>     Click methods:    none
>     Disable-w-typing: n/a
>     Disable-w-trackpointing: n/a
>     Accel profiles:   n/a
>     Rotation:         0.0
> 
> `libinput list-devices` does not list the device after resuming from S3. Some of the function keys, like brightness and airplane mode keys, still work, as the events are probably transmitted over the embedded controller or some other mechanism. An external USB keyboard also still works.
> 
> I haven’t had time to further analyze this, but wanted to report it. No idea
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> ¹ s2idle is not working correctly on the device, in the sense, that energy usage is very high in that state, and the full battery is at 20 % after leaving it for eight hours.



