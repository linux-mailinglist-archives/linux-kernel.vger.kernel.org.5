Return-Path: <linux-kernel+bounces-76642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C8C85FA63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A500F1F24D98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B8F146916;
	Thu, 22 Feb 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFxoS9a6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE741350D8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609973; cv=none; b=rNSPVKE1B+qV375xmIePJ6oG/D0JjfxoKfxoosY/1Rbq+0wsnSqBot6GfuBiePPZUXjH5NGU8hJ4h66Z6dyMQDBNhupkekRNgSyPpLjdClU0a4kiFrJ3uzgFTM2tcPvUD6B41+A7DnL5hd4tvMOHusoEUoBI9iS3Ubw2HqiYTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609973; c=relaxed/simple;
	bh=ldvCiK/V4BDWF+2sdQWwisT/oGzl+qxNF14gWToQctw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ROqYtrswPseti+hvnIr8+k1tSxbc2WNODL2B15DWNjrq++vM8FJ3KO+fF60VpmRyI51+zXmAZhNs5BaxM8GUpj7tKjNP1ergFIx/UIP86vda2GED1uiIqxxSAuAq16MWI/Talf1lRTdQIb2ujTtzzd7DEa6HiRcjUEc1ZpMpoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFxoS9a6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708609969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a2iYz0S7YtfHc/kfUkSN1Rclgg5kbRE8AFUFm3AJCy0=;
	b=OFxoS9a6JUsP9i+1iv2l+YgrObUz1VYrR1bCwovp0dBkKzXB24aRGQtZaC9WD8O965BD1i
	LE5mQI8pR1FsdMhCTe+8RQa2tYpnds2Kwgcg+apmjA22e9WcIsBxegAYU8FBtki9iwTRSo
	kgy0CYL6X2m8LkeKvIsrZdogNP6ZPPE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ZLiy4gAaNaeoyfBcWlrpmg-1; Thu, 22 Feb 2024 08:52:48 -0500
X-MC-Unique: ZLiy4gAaNaeoyfBcWlrpmg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so5849377a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609967; x=1709214767;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a2iYz0S7YtfHc/kfUkSN1Rclgg5kbRE8AFUFm3AJCy0=;
        b=r204eWANao7iDpVJfFHs9E3aI+ilhmsJ4mwaAI79jUx3bVOpzKGQ1CC2gbkoiuVjQv
         KFy1xvDx7BcsIYzdVRoGH3iJk59Xu4INtQerW+HJLK2NdWwdxvbM8vjEZmMZds6qWL4G
         DGWP9jAB/Ge61PBxuhAUbcz7Wv2EPl/cMFy990dvyAlylrhRekMEzD6jUdpQ5wN9nrwU
         9LAzmTGXw0DexuTXXE8AuVaTH24Vgq6yaz7AVZW5y3mFKY3ekuF6jvu9yPJbP3oXj8rI
         Ng0sUJpbgTMmcVUcdzcdeyhhHqExBNixNYMEg/ApmSmxb5y7lIhjZFKk4iOYWWp7J1Tc
         VDXw==
X-Gm-Message-State: AOJu0Yxlb2BWwgfh7W0XMEzrJMDdu1jmXvSLODW2n3Ft9FGqbe+uxPsP
	5JglnteiCVf7hnDOEjhcjEBEIo0T0bEOCMJmNvX/Ggz9A3zNbwttoQt7r7tuS4kHuiVLWa7vAq/
	kYgqbvcSyAwNOh7q2ibf94uKdV2vi0/NCKQZEAbiMhLS77LQ/705zX4U4kFyx9Q==
X-Received: by 2002:a17:906:27d1:b0:a3e:5ae8:5777 with SMTP id k17-20020a17090627d100b00a3e5ae85777mr9079876ejc.44.1708609967053;
        Thu, 22 Feb 2024 05:52:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhWrsFmLDSwlexAS/8lXO8oaBnpo3FVCIYop3rqTGFjz+tKlt1K+lWdcQPYKDh+oklP7MHmg==
X-Received: by 2002:a17:906:27d1:b0:a3e:5ae8:5777 with SMTP id k17-20020a17090627d100b00a3e5ae85777mr9079868ejc.44.1708609966714;
        Thu, 22 Feb 2024 05:52:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id mj8-20020a170906af8800b00a3ee9305b02sm2847619ejb.20.2024.02.22.05.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 05:52:46 -0800 (PST)
Message-ID: <2b496ce8-4711-48cd-b1da-d70522bc0580@redhat.com>
Date: Thu, 22 Feb 2024 14:52:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.8-3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is the second round of fixes for platform-drivers-x86 for 6.8.

Highlights:
 -  Regression fixes:
    -  Fix INT0002 vGPIO events no longer working after 6.8 ACPI SCI changes
    -  AMD-PMF: Fix laptops (e.g. Framework 13 AMD) hanging on suspend
    -  x86-android-tablets: Fix touchscreen no longer working on Lenovo Yogabook
    -  x86-android-tablets: Fix serdev instantiation regression
    -  intel-vbtn: Fix ThinkPad X1 Tablet Gen2 no longer suspending
 -  Bug fixes
    -  think-lmi: Fix changing BIOS settings on Lenovo workstations
    -  touchscreen_dmi: Fix Hi8 Air touchscreen data sometimes missing
    -  AMD-PMF: Fix Smart PC support not working after suspend/resume
 -  Other misc. small fixes

Regards,

Hans


The following changes since commit 1abdf288b0ef5606f76b6e191fa6df05330e3d7e:

  platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet (2024-01-26 20:21:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.8-3

for you to fetch changes up to 427c70dec738318b7f71e1b9d829ff0e9771d493:

  platform/x86: thinkpad_acpi: Only update profile if successfully converted (2024-02-20 14:35:36 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.8-3

Highlights:
 -  Regression fixes:
    -  Fix INT0002 vGPIO events no longer working after 6.8 ACPI SCI changes
    -  AMD-PMF: Fix laptops (e.g. Framework 13 AMD) hanging on suspend
    -  x86-android-tablets: Fix touchscreen no longer working on Lenovo Yogabook
    -  x86-android-tablets: Fix serdev instantiation regression
    -  intel-vbtn: Fix ThinkPad X1 Tablet Gen2 no longer suspending
 -  Bug fixes
    -  think-lmi: Fix changing BIOS settings on Lenovo workstations
    -  touchscreen_dmi: Fix Hi8 Air touchscreen data sometimes missing
    -  AMD-PMF: Fix Smart PC support not working after suspend/resume
 -  Other misc. small fixes

The following is an automated git shortlog grouped by driver:

Add new get_serdev_controller() helper:
 -  Add new get_serdev_controller() helper

intel:
 -  int0002_vgpio: Pass IRQF_ONESHOT to request_irq()

intel-vbtn:
 -  Stop calling "VBDL" from notify_handler

platform/x86/amd/pmf:
 -  Fix a potential race with policy binary sideload
 -  Fixup error handling for amd_pmf_init_smart_pc()
 -  Add debugging message for missing policy data
 -  Fix a suspend hang on Framework 13
 -  Fix TEE enact command failure after suspend and resume
 -  Remove smart_pc_status enum

think-lmi:
 -  Fix password opcode ordering for workstations

thinkpad_acpi:
 -  Only update profile if successfully converted

touchscreen_dmi:
 -  Consolidate Goodix upside-down touchscreen data
 -  Allow partial (prefix) matches for ACPI names

x86-android-tablets:
 -  Fix acer_b1_750_goodix_gpios name
 -  Fix serdev instantiation no longer working
 -  Fix keyboard touchscreen on Lenovo Yogabook1 X90

----------------------------------------------------------------
Hans de Goede (8):
      platform/x86: intel: int0002_vgpio: Pass IRQF_ONESHOT to request_irq()
      platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names
      platform/x86: touchscreen_dmi: Consolidate Goodix upside-down touchscreen data
      platform/x86: x86-android-tablets: Fix keyboard touchscreen on Lenovo Yogabook1 X90
      platform/x86: Add new get_serdev_controller() helper
      platform/x86: x86-android-tablets: Fix serdev instantiation no longer working
      platform/x86: x86-android-tablets: Fix acer_b1_750_goodix_gpios name
      platform/x86: intel-vbtn: Stop calling "VBDL" from notify_handler

Mario Limonciello (5):
      platform/x86/amd/pmf: Fix a suspend hang on Framework 13
      platform/x86/amd/pmf: Add debugging message for missing policy data
      platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()
      platform/x86/amd/pmf: Fix a potential race with policy binary sideload
      platform/x86: thinkpad_acpi: Only update profile if successfully converted

Mark Pearson (1):
      platform/x86: think-lmi: Fix password opcode ordering for workstations

Shyam Sundar S K (2):
      platform/x86/amd/pmf: Remove smart_pc_status enum
      platform/x86/amd/pmf: Fix TEE enact command failure after suspend and resume

 drivers/platform/x86/amd/pmf/core.c                | 17 +++--
 drivers/platform/x86/amd/pmf/pmf.h                 |  5 --
 drivers/platform/x86/amd/pmf/tee-if.c              | 76 ++++++++++++--------
 drivers/platform/x86/intel/int0002_vgpio.c         |  2 +-
 drivers/platform/x86/intel/vbtn.c                  |  3 -
 drivers/platform/x86/serdev_helpers.h              | 80 ++++++++++++++++++++++
 drivers/platform/x86/think-lmi.c                   | 20 +++---
 drivers/platform/x86/thinkpad_acpi.c               |  5 +-
 drivers/platform/x86/touchscreen_dmi.c             | 29 ++++----
 drivers/platform/x86/x86-android-tablets/core.c    | 38 ++++------
 drivers/platform/x86/x86-android-tablets/lenovo.c  |  1 +
 drivers/platform/x86/x86-android-tablets/other.c   |  4 +-
 .../x86/x86-android-tablets/x86-android-tablets.h  |  1 +
 13 files changed, 183 insertions(+), 98 deletions(-)
 create mode 100644 drivers/platform/x86/serdev_helpers.h


