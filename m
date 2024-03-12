Return-Path: <linux-kernel+bounces-100763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C6A879CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55B428382B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC1142907;
	Tue, 12 Mar 2024 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXGHthcD"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE633FE4B;
	Tue, 12 Mar 2024 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275511; cv=none; b=OLR19Tv+Rqq2vdGJtrY6F1Ag0oB2K9OJLN3sWknwU3zXdKirCu8KPdnv6p/Ip2JM1TR9S+KKG0PEVx0wG9rXGUbNBJDXMBCF5Maw2r+Ox6hI0hsh0KAHJUxRAcCkeVVHI4ImLfshvDF4DAmBisHb/JBdk8nUfCGIq2PWU8lQKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275511; c=relaxed/simple;
	bh=JXSa5IZmO1jNZ+fM8VFVw/7HSAL4JMoeAMYB1B9xby4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l1Z/ob7TcvH8I7xoAvhekb42Ag8csr+/NIi6ewF2UWvtxbH10GEzHCUh4KbWvdMd5L1id2Q6wAeRkihWwNbR563RVHQ6jPtrx+dAroWBm8lWDrs1YvfoHgV/WdZvzfrPOzV3WqaFOZbIJK/gypjHUgWxkY7SfFWREm8kJdITI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXGHthcD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5139d80f8b6so4000812e87.1;
        Tue, 12 Mar 2024 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710275507; x=1710880307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bY/WtxOFtc3v8C11Yjzy8PcAyCUqZKnqHl3z6YyZxAg=;
        b=UXGHthcDR5X1e/jAQScDCD5K0niHUZPpnCx11acVD0Soxquak7/lJtDvzDcq41ueIO
         MVCseHDa+osP26AnC7B3JafRXAlQdr7vhUR9Yf8eFEOtU0q5z/qzjsCeTnysokfJ9x1V
         GyxjaghrkzIOaHaXT6w2BeNEZL+1GKiCoEOOkMYuuieJyW590dC2WWJjUuydSMciiQf0
         W0YbnacG4it6o8+C0K8ljFiTcZc4seu2N21upvwsRjUmjiZRP8b6xPkzPHRoGHItR2iu
         kwcroanrMnq/uTgxeZUrfN/VlCFAM6OVVQvB//A2nJXdx8AwobaL05l3R90zXqjGf08p
         rjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710275507; x=1710880307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bY/WtxOFtc3v8C11Yjzy8PcAyCUqZKnqHl3z6YyZxAg=;
        b=R7ApM0Xnmme8LYhKPBJmAcWr/PKx7yYB/oXHfZHPWMV1a2WqwrQZLx7380bIiSC+SG
         rvlNlkAQzoa5refvQw/CSnI/kY5umgZNpM1w7flyJw6mMseoW6BVD7SFagCT5cp9Bl1I
         Gc0Rr22jg4QpiKVne3bp0RmDua9ZgUQvVi1vDu14UXfBedOTBeZFASyC8coCRivY+oX9
         gHAJ7cUbUNnIdRvZG+9aNPNLtd1fNMRx0gVeLofuCmnuXM62c0gxib9f/E3W1dR12Cs/
         Mc3Fua/t0zHt7tIqhz4aEjA/ft1vfW6yJ8sU58NVwQ3+bIuRrG68UZeSOKkc449jAByp
         72vA==
X-Forwarded-Encrypted: i=1; AJvYcCVj6KFIoRTH3+mnzcHglvQ+ND9tSLrEO7xGbEbcXR7VnbAhx1MkDUDnM8vhsyMcrXjx4LKHlCVzToN9672OqjXE6y8Dc3WIThMJH7gdfKlBbkDzYw8Y/Nw6R7I+fIgOzlaKikkfSEClHmqcfkhVqhgWfAlsvC7udldr/TouSyT9KKs/9jfBqZ8Mlu8TO43aSRlOYbKxyRBztHtB1FtEGry7Ty8Or4epMAKveQ==
X-Gm-Message-State: AOJu0YyPPKxrg/vj6m2bRHQFdnPZXm29TIkDf2ya6N83428L59X7qJRN
	jB+e3WoFJNmgWHLsqQvkruIHkGxiLsjN5rve3XO7jkuB4cvXLESQ
X-Google-Smtp-Source: AGHT+IEEuNHdD3XEsVZU3XTfvkxGw2fW6xI4JWOAK/WnAKeIPec1EGFenE2FVoPa3yYR/FZp7rxZxQ==
X-Received: by 2002:ac2:51a5:0:b0:512:bf99:7d80 with SMTP id f5-20020ac251a5000000b00512bf997d80mr6919657lfk.1.1710275506510;
        Tue, 12 Mar 2024 13:31:46 -0700 (PDT)
Received: from localhost.localdomain ([94.120.90.19])
        by smtp.gmail.com with ESMTPSA id rn16-20020a170906d93000b00a441a7a75b5sm4146883ejb.209.2024.03.12.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 13:31:46 -0700 (PDT)
From: mustafa <mustafa.eskieksi@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	mustafa.eskieksi@gmail.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	linux-leds@vger.kernel.org
Cc: rishitbansal0@gmail.com
Subject: [PATCH v4 0/1] platform/x86: Add wmi driver for Casper Excalibur laptops
Date: Tue, 12 Mar 2024 23:31:27 +0300
Message-ID: <20240312203128.6708-1-mustafa.eskieksi@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mustafa Ekşi <mustafa.eskieksi@gmail.com>

Hi,

On 10.03.2024 22:17, Armin Wolf wrote:
>> +static struct casper_quirk_entry *quirk_applied;
>> +static struct led_classdev_mc *casper_kbd_mcled_info;
> 
> Hi,
> 
> those global variables are initialized inside the probe() callback of 
> the WMI driver,
> so there are going to be issues when this driver is going to be 
> instantiated multiple times.
> 
> Please move those global variables into a private driver struct using 
> the state container pattern:
> https://www.kernel.org/doc/html/latest/driver-api/driver-model/design-patterns.html
> 
> Maybe you can keep the variables associated with quirk handling global 
> and instead do the DMI matching
> inside the modules init function before registering the WMI driver (this 
> would replace module_wmi_driver()).
I tried to use container_of, but I couldn't make it work with multicolor leds.
So I used driver_data instead. I don't think there is much difference.

I copied below from earlier patch.

On 23.02.2024 13:14, Ilpo Järvinen wrote:
> However, I still suspect this is wrong way to do RGB leds and the multi_*
> sysfs interface is the way you should use.
I was skeptical about using multicolor because it said it wasn't a good
fit for rgb drivers in drivers/leds/TODO but after I read the thread about
hp omen backlight driver support, I changed my mind. Hp omen's keyboard
backlight is very similar to Casper's keyboard backlight. And probably
TODO file meant "per key rgb"s and not zoned rgbs.
I think Rishit's' driver didn't get into mainline but I still liked the
API he used so I decided to use the same API.
Driver creates 4 different led_classdev_mc devices:
> casper::kbd_zoned_backlight-right/
> casper::kbd_zoned_backlight-middle/
> casper::kbd_zoned_backlight-left/
> casper::kbd_zoned_backlight-corners/
right, middle, and left leds share the same brightness but the corners
led doesn't.
I found a way to get the brightness level from the hardware, so it shows
the correct brightness when it is changed via keyboard shortcut. But
still, there's most likely no way to get color data from firmware,
Windows driver uses a Windows registry (as a cache) for same reason.

I seek your advice on how to support "led modes". It is very different
from led_pattern. It is not possible to change the interval, or anything.
This version has an enum called casper_led_mode:
> enum casper_led_mode {
>        LED_NORMAL = 0x10,
>        LED_BLINK = 0x20,
>        LED_FADE = 0x30,
>        LED_HEARTBEAT = 0x40,
>        LED_REPEAT = 0x50,
>        LED_RANDOM = 0x60
> };
For example, random mode assigns random colors to leds every second. Fade
mode slowly fades out brightness and then fades in. I thought of creating
an attribute but working with multiple leds seemed uneasy.

And also this multicolor approach doesn't include a way to set all
keyboard leds all at once (like Rishit's driver). This can create long
delays when a userspace program (like OpenRGB) sets all keyboard leds
to user configuration.

Link to Rishit Bansal's thread:
https://lore.kernel.org/lkml/20230131235027.36304-1-rishitbansal0@gmail.com/

Regards,
Mustafa Ekşi

Mustafa Ekşi (1):
  platform/x86: Add wmi driver for Casper Excalibur laptops

 MAINTAINERS                       |   6 +
 drivers/platform/x86/Kconfig      |  14 +
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/casper-wmi.c | 629 ++++++++++++++++++++++++++++++
 4 files changed, 650 insertions(+)
 create mode 100644 drivers/platform/x86/casper-wmi.c

-- 
2.44.0


