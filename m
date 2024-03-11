Return-Path: <linux-kernel+bounces-99164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7258287845B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA858283040
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6323482CF;
	Mon, 11 Mar 2024 15:59:43 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246D4503F;
	Mon, 11 Mar 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172783; cv=none; b=CV8ZQIjV14AvXP6A80jR4zoQEh2I48B7ix+VYyZ5trImh1IHRPxwFYNRfuzAbPjcrP1sIiSAJMP57zwRfCls+OGfG/dFI+HyF/4VUf1Cx5gs2aVDnIZFdMXFhyDttm6zfp8Q3WJYvoDnb7vTHlDf+RjHIpXr2IrO0QmYnNcwLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172783; c=relaxed/simple;
	bh=zX3RXgMU2woct70wnJ9OoknW9J4jADZXkktqaUGoOmM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I3wfqh/shYv39U7S2uEyEoPE9rAfb38zMm6kQBDoO94xKm3FOpZWrFeh6hhapAuzLK/9JilbPEQ13lZPWMEEPvq/0fN/BhrS76C8aAGcA6jQ3ft30bh3qulYQbH9BPxpiUaAldsW65NVsWsWW9FPY+bwSHjbkciKhgJpdtKNvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-221b9142995so946309fac.1;
        Mon, 11 Mar 2024 08:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710172781; x=1710777581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sahXLkTv1AizHAzx7D7y1KuDCbu0bSUcDiURF2qrqAQ=;
        b=ZizCfnG2aNgx+rXPAN5kPMYBwNVlyJf38tuRZ2isahuTF3/zPW1T/W+Z4+JABMIA21
         IJUVPKtf9w64yIVxXbRDWp/5vgPg/b7sCGS8XaZOC9nG4VF0lu21j8VKK/o3t7BrNG2L
         LLGYV2jGc7a00gVZk1e7NdVfm4hSM4h2jaOUwxMQBkXLeaQEWq83vZKHCrOw7w6qSEkU
         aEc+KRGfTCWW40EUDAkPaak4pCUcFaGHKHkBfLAlg2Po04FpF+STb+ZNQXbsxgyzkdnw
         XZ36hNQ/0d74tNsYRJbodOVRSz12CmolmweKg6x7JQSuU+VVIVH5NcGc3C6fVRtxQFKj
         ONaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXidy9A8MNgDtdXExKv6CSxI/YWCMBoYZ7Xj3w18Zt7UmYhmbgqzTuBQ/g37zNw7RBCvMTj5dw4HaBaqO+WsLHXVYFYbqiuYTGWIg/cchUx62QLYrsw6XFZTRLTgYLFugPApHz/Pxg=
X-Gm-Message-State: AOJu0YwAb1Gat/RZm/9wWwbXCyoIJ7KEEZVHHgqDFDnWFVOg0hNxqLFS
	j5+3JzdGn+Lpg1tckHmU//SeBWyOst7bDryDhPjlmZ/4otRmyyN7cwRmblEZmHa5IGyAZ6E9OEp
	FlOpSnlmnsN6uioQ1wYvCjRQv507V9jYok+4=
X-Google-Smtp-Source: AGHT+IF2a3pjhvaF9kmj+oIiOfrH3grh4hNiN0zf3zN9NxndEwOF8W9ORQYoQm/q9bAg2bXFLDsqATR1As2bmVfR0KY=
X-Received: by 2002:a05:6870:2185:b0:221:c9e7:7220 with SMTP id
 l5-20020a056870218500b00221c9e77220mr6291731oae.3.1710172780779; Mon, 11 Mar
 2024 08:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Mar 2024 16:59:29 +0100
Message-ID: <CAJZ5v0gvbDaDihXq5WTocekjDgL34v4L9ZWVMpnFkkCC0p4Ntg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.9-rc1

with top-most commit 817d2371e4d53be202bb6d7df9a9b9c0c342ab21

 Merge branches 'acpi-x86', 'acpi-video', 'acpi-apei' and 'acpi-misc'

on top of commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72

 Linux 6.8-rc7

to receive ACPI updates for 6.9-rc1.

These modify the ACPI device events and processor enumeration code to take
the "enabled" _STA bit into account as mandated by the ACPI specification,
convert several platform drivers to using a remove callback that returns
void, add some new quirks for ACPI IRQ override and other things, address
assorted issues and clean up code.

Specifics:

 - Rearrange Device Check and Bus Check notification handling in the
   ACPI device hotplug code to make it get the "enabled" _STA bit into
   account (Rafael Wysocki).

 - Modify acpi_processor_add() to skip processors with the "enabled"
   _STA bit clear, as per the specification (Rafael Wysocki).

 - Stop failing Device Check notification handling without a valid
   reason (Rafael Wysocki).

 - Defer enumeration of devices that depend on a device with an ACPI
   device ID equalt to INTC10CF to address probe ordering issues on
   some platforms (Wentong Wu).

 - Constify acpi_bus_type (Ricardo Marliere).

 - Make the ACPI-specific suspend-to-idle code take the Low-Power S0
   Idle MSFT UUID into account on non-AMD systems (Rafael Wysocki).

 - Add ACPI IRQ override quirks for some new platforms (Sergey
   Kalinichev, Maxim Kudinov, Alexey Froloff, Sviatoslav Harasymchuk,
   Nicolas Haye).

 - Make the NFIT parsing code use acpi_evaluate_dsm_typed() (Andy
   Shevchenko).

 - Fix a memory leak in acpi_processor_power_exit() (Armin Wolf).

 - Make it possible to quirk the CSI-2 and MIPI DisCo for Imaging
   properties parsing and add a quirk for Dell XPS 9315 (Sakari Ailus).

 - Prevent false-positive static checker warnings from triggering by
   intializing some variables in the ACPI thermal code to zero (Colin
   Ian King).

 - Add DELL0501 handling to acpi_quirk_skip_serdev_enumeration() and
   make that function generic (Hans de Goede).

 - Make the ACPI backlight code handle fetching EDID that is longer than
   256 bytes (Mario Limonciello).

 - Skip initialization of GHES_ASSIST structures for Machine Check
   Architecture in APEI (Avadhut Naik).

 - Convert several plaform drivers in the ACPI subsystem to using a
   remove callback that returns void (Uwe Kleine-K=C3=B6nig).

 - Drop the long-deprecated custom_method debugfs interface that is
   problematic from the security standpoint (Rafael Wysocki).

 - Use %pe in a couple of places in the ACPI code for easier error
   decoding (Onkarnath).

 - Fix register width information handling during system memory
   accesses in the ACPI CPPC library (Jarred White).

 - Add AMD CPPC V2 support for family 17h processors to the ACPI CPPC
   library (Perry Yuan).

Thanks!


---------------

Alexey I. Froloff (1):
      ACPI: resource: Do IRQ override on Lunnen Ground laptops

Andy Shevchenko (1):
      ACPI: NFIT: Switch to use acpi_evaluate_dsm_typed()

Armin Wolf (1):
      ACPI: processor_idle: Fix memory leak in acpi_processor_power_exit()

Avadhut Naik (1):
      ACPI: APEI: Skip initialization of GHES_ASSIST structures for
Machine Check Architecture

Colin Ian King (1):
      ACPI: thermal_lib: Initialize temp_decik to zero

Hans de Goede (2):
      ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of
CONFIG_X86_ANDROID_TABLETS
      ACPI: x86: Add DELL0501 handling to acpi_quirk_skip_serdev_enumeratio=
n()

Jarred White (1):
      ACPI: CPPC: Use access_width over bit_width for system memory accesse=
s

Mario Limonciello (1):
      ACPI: video: Handle fetching EDID that is longer than 256 bytes

Maxim Kudinov (1):
      ACPI: resource: Add MAIBENBEN X577 to irq1_edge_low_force_override

Nicolas Haye (1):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CVA

Onkarnath (1):
      ACPI: use %pe for better readability of errors while printing

Perry Yuan (1):
      ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors

Rafael J. Wysocki (7):
      ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT UUID for non-AMD syst=
ems
      ACPI: Drop the custom_method debugfs interface
      ACPI: scan: Fix device check notification handling
      ACPI: scan: Relocate acpi_bus_trim_one()
      ACPI: scan: Make acpi_processor_add() check the device enabled bit
      ACPI: scan: Rework Device Check and Bus Check notification handling
      ACPI: scan: Consolidate Device Check and Bus Check notification handl=
ing

Ricardo B. Marliere (1):
      ACPI: bus: make acpi_bus_type const

Sakari Ailus (3):
      ACPI: utils: Make acpi_handle_path() not static
      ACPI: property: Ignore bad graph port nodes on Dell XPS 9315
      ACPI: property: Polish ignoring bad data nodes

Sergey Kalinichev (1):
      ACPI: resource: Use IRQ override on Maibenben X565

Sviatoslav Harasymchuk (1):
      ACPI: resource: Add IRQ override quirk for ASUS ExpertBook B2502FBA

Uwe Kleine-K=C3=B6nig (8):
      ACPI: APEI: GHES: Convert to platform remove callback returning void
      ACPI: TAD: Convert to platform remove callback returning void
      ACPI: AGDI: Convert to platform remove callback returning void
      ACPI: DPTF: Convert to platform remove callback returning void
      ACPI: GED: Convert to platform remove callback returning void
      ACPI: fan: Convert to platform remove callback returning void
      ACPI: pfr_telemetry: Convert to platform remove callback returning vo=
id
      ACPI: pfr_update: Convert to platform remove callback returning void

Wentong Wu (1):
      ACPI: scan: Defer enumeration of devices with a _DEP pointing to
IVSC device

---------------

 Documentation/firmware-guide/acpi/index.rst        |   1 -
 .../firmware-guide/acpi/method-customizing.rst     |  89 -----------
 arch/x86/kernel/acpi/cppc.c                        |   2 +-
 drivers/acpi/Kconfig                               |  14 --
 drivers/acpi/Makefile                              |   1 -
 drivers/acpi/acpi_processor.c                      |   5 +-
 drivers/acpi/acpi_tad.c                            |   5 +-
 drivers/acpi/acpi_video.c                          |  28 ++--
 drivers/acpi/acpi_watchdog.c                       |   2 +-
 drivers/acpi/apei/ghes.c                           |  17 +-
 drivers/acpi/apei/hest.c                           |  51 ++++++
 drivers/acpi/arm64/agdi.c                          |   8 +-
 drivers/acpi/bus.c                                 |   2 +-
 drivers/acpi/cppc_acpi.c                           |  31 +++-
 drivers/acpi/custom_method.c                       | 103 ------------
 drivers/acpi/dptf/dptf_pch_fivr.c                  |   6 +-
 drivers/acpi/dptf/dptf_power.c                     |   6 +-
 drivers/acpi/evged.c                               |   5 +-
 drivers/acpi/fan_core.c                            |   6 +-
 drivers/acpi/internal.h                            |   2 +
 drivers/acpi/mipi-disco-img.c                      |  71 +++++++++
 drivers/acpi/nfit/core.c                           |   5 +-
 drivers/acpi/pci_slot.c                            |   2 +-
 drivers/acpi/pfr_telemetry.c                       |   6 +-
 drivers/acpi/pfr_update.c                          |   6 +-
 drivers/acpi/processor_idle.c                      |   2 +
 drivers/acpi/property.c                            |   3 +
 drivers/acpi/resource.c                            |  42 +++++
 drivers/acpi/scan.c                                | 172 +++++++++++------=
----
 drivers/acpi/thermal_lib.c                         |   8 +-
 drivers/acpi/utils.c                               |   2 +-
 drivers/acpi/x86/s2idle.c                          |  37 +++--
 drivers/acpi/x86/utils.c                           |  38 ++++-
 include/acpi/acpi_bus.h                            |  16 +-
 include/linux/acpi.h                               |   1 +
 35 files changed, 414 insertions(+), 381 deletions(-)

