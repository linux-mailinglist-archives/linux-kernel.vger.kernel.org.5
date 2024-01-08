Return-Path: <linux-kernel+bounces-19729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58499827207
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719391C22B02
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16214777C;
	Mon,  8 Jan 2024 15:00:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298347768;
	Mon,  8 Jan 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dbd87b706aso352528a34.0;
        Mon, 08 Jan 2024 07:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704726010; x=1705330810;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6NEMm4hHIzokK3H2KBcUZXa+FLXVo9snUgwi3Hp+Wgw=;
        b=onHKHg5xYlCETdMmmRzxI6IMjx3M05F4TYEEPlCTzQPb0TVrr45G529gGxsu2p2TEa
         XFass9ESl/nNKsvHu6fYy3nQjWGxmtrbbzsm5n9FHXmQh7mmwXioND0nvQVAkaSmQL1b
         gwFH15W2xqQgbkhdxZRHggYqyt8HryZikCCfoi9dnfwJj4pRjSGgDnfJy0ec0vqcSbB3
         Iksk/JpExGamJjqKDSESNuLcUUIEE7RM6clkS1IeZyo4MSxmaTL91DxEEWFS6fpOYREF
         QZAAMMCsTdbIggG0pI1ge1cIgNkhfZRELsK9wXn1ejQJvQ0uyGf5URIrV92KQb8bICsm
         90rg==
X-Gm-Message-State: AOJu0YxyX7TXIy4qNrBwAu46ZqcHgv3ootOvkWMsOLzFlGIBgn/sHtrk
	hnytv0gO7oAvQnFeW8toPuPX3GJKn8SwbPZF8ltJgWPK79Q=
X-Google-Smtp-Source: AGHT+IEdRzsktLtGiAyBuTluFOSLXy7XwpbTN2bElBt5Hih/fzTeMZ7zAu0JuLX5Bg/4Cayo/LekCiXAAiLIZLNJlNM=
X-Received: by 2002:a4a:bb91:0:b0:596:2820:ced with SMTP id
 h17-20020a4abb91000000b0059628200cedmr5302574oop.1.1704726010175; Mon, 08 Jan
 2024 07:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jan 2024 15:59:58 +0100
Message-ID: <CAJZ5v0j+EaUmMDibUUrY0hQmT457TqAf+39mLNO62sKWHDMfpw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.8-rc1

with top-most commit e46201308a1e568059328e200282c8a62faa2f19

 Merge branch 'pnp'

on top of commit 861deac3b092f37b2c5e6871732f3e11486f7082

 Linux 6.7-rc7

to receive ACPI updates for 6.8-rc1.

From the new features standpoint, the most significant change here is
the addition of CSI-2 and MIPI DisCo for Imaging support to the ACPI
device enumeration code that will allow MIPI cameras to be enumerated
through the platform firmware on systems using ACPI.

Also significant is the switch-over to threaded interrupt handlers for
the ACPI SCI and the dedicated EC interrupt (on systems where the former
is not used) which essentially allows all ACPI code to run with local
interrupts enabled.  That should improve responsiveness significantly
on systems where multiple GPEs are enabled and the handling of one SCI
involves many I/O address space accesses which previously had to be
carried out in one go with disabled interrupts on the local CPU.

Apart from the above, the ACPI thermal zone driver will use the Thermal
fast Sampling Period (_TFP) object if available, which should allow
temperature changes to be followed more accurately on some systems, the
ACPI Notify () handlers can run on all CPUs (not just on CPU0), which
should generally speed up the processing of events signaled through the
ACPI SCI, and the ACPI power button driver will trigger wakeup key
events via the input subsystem (on systems where it is a system wakeup
device).

In addition to that, there are the usual bunch of fixes and cleanups.

Specifics:

 - Add CSI-2 and DisCo for Imaging support to the ACPI device
   enumeration code (Sakari Ailus, Rafael J. Wysocki).

 - Adjust the cpufreq thermal reduction algorithm in the ACPI processor
   driver for Tegra241 (Srikar Srimath Tirumala, Arnd Bergmann).

 - Make acpi_proc_quirk_mwait_check() x86-specific (Rafael J. Wysocki).

 - Switch over ACPI to using a threaded interrupt handler for the
   SCI (Rafael J. Wysocki).

 - Allow ACPI Notify () handlers to run on all CPUs and clean up the
   ACPI interface for deferred events processing (Rafael J. Wysocki).

 - Switch over the ACPI EC driver to using a threaded handler for the
   dedicated IRQ on systems without the EC GPE (Rafael J. Wysocki).

 - Adjust code using ACPICA spinlocks and the ACPI EC driver spinlock to
   keep local interrupts on (Rafael J. Wysocki).

 - Adjust the USB4 _OSC handshake to correctly handle cases in which
   certain types of OS control are denied by the platform (Mika
   Westerberg).

 - Correct and clean up the generic function for parsing ACPI data-only
   tables with array structure (Yuntao Wang).

 - Modify acpi_dev_uid_match() to support different types of its second
   argument and adjust its users accordingly (Raag Jadav).

 - Clean up code related to acpi_evaluate_reference() and ACPI device
   lists (Rafael J. Wysocki).

 - Use generic ACPI helpers for evaluating trip point temperature
   objects in the ACPI thermal zone driver (Rafael J. Wysockii, Arnd
   Bergmann).

 - Add Thermal fast Sampling Period (_TFP) support to the ACPI thermal
   zone driver (Jeff Brasen).

 - Modify the ACPI LPIT table handling code to avoid u32 multiplication
   overflows in state residency computations (Nikita Kiryushin).

 - Drop an unused helper function from the ACPI backlight (video) driver
   and add a clarifying comment to it (Hans de Goede).

 - Update the ACPI backlight driver to avoid using uninitialized memory
   in some cases (Nikita Kiryushin).

 - Add ACPI backlight quirk for the Colorful X15 AT 23 laptop (Yuluo
   Qiu).

 - Add support for vendor-defined error types to the ACPI APEI error
   injection code (Avadhut Naik).

 - Adjust APEI to properly set MF_ACTION_REQUIRED on synchronous memory
   failure events, so they are handled differently from the asynchronous
   ones (Shuai Xue).

 - Fix NULL pointer dereference check in the ACPI extlog driver (Prarit
   Bhargava).

 - Adjust the ACPI extlog driver to clear the Extended Error Log status
   when RAS_CEC handled the error (Tony Luck).

 - Add IRQ override quirks for some Infinity laptops and for TongFang
   GMxXGxx (David McFarland, Hans de Goede).

 - Clean up the ACPI NUMA code and fix it to ensure that fake_pxm is not
   the same as one of the real pxm values (Yuntao Wang).

 - Fix the fractional clock divider flags in the ACPI LPSS (Intel SoC)
   driver so as to prevent miscalculation of the values in the clock
   divider (Andy Shevchenko).

 - Adjust comments in the ACPI watchdog driver to prevent kernel-doc
   from complaining during documentation builds (Randy Dunlap).

 - Make the ACPI button driver send wakeup key events to user space in
   addition to power button events on systems that can be woken up by
   the power button (Ken Xue).

 - Adjust pnpacpi_parse_allocated_vendor() to use memcpy() on a full
   structure field (Dmitry Antipov).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: LPSS: Fix the fractional clock divider flags

Arnd Bergmann (2):
      ACPI: thermal_lib: include "internal.h" for function prototypes
      ACPI: arm64: export acpi_arch_thermal_cpufreq_pctg()

Avadhut Naik (4):
      ACPI: APEI: EINJ: Refactor available_error_type_show()
      fs: debugfs: Add write functionality to debugfs blobs
      platform/chrome: cros_ec_debugfs: Fix permissions for panicinfo
      ACPI: APEI: EINJ: Add support for vendor defined error types

David McFarland (1):
      ACPI: resource: Add Infinity laptops to irq1_edge_low_force_override

Dmitry Antipov (1):
      PNP: ACPI: fix fortify warning

Hans de Goede (3):
      ACPI: video: Add comment about acpi_video_backlight_use_native() usage
      ACPI: video: Drop should_check_lcd_flag()
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Jeff Brasen (1):
      ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support

Ken Xue (1):
      ACPI: button: trigger wakeup key events

Mika Westerberg (1):
      ACPI: Run USB4 _OSC() first with query bit set

Nikita Kiryushin (2):
      ACPI: video: check for error while searching for backlight device parent
      ACPI: LPIT: Avoid u32 multiplication overflow

Prarit Bhargava (1):
      ACPI: extlog: fix NULL pointer dereference check

Raag Jadav (5):
      ACPI: bus: update acpi_dev_uid_match() to support multiple types
      ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
      ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
      efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
      perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()

Rafael J. Wysocki (20):
      ACPI: property: Support using strings in reference properties
      ACPI: scan: Extract CSI-2 connection graph from _CRS
      ACPI: scan: Extract _CRS CSI-2 connection information into swnodes
      ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes
      thermal: ACPI: Move the ACPI thermal library to drivers/acpi/
      ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin
      ACPI: thermal: Use library functions to obtain trip point
temperature values
      ACPI: processor: Provide empty stub of acpi_proc_quirk_mwait_check()
      ACPI: OSL: Use a threaded interrupt handler for SCI
      ACPI: OSL: Rework error handling in acpi_os_execute()
      ACPI: OSL: Rearrange workqueue selection in acpi_os_execute()
      ACPI: OSL: Allow Notify () handlers to run on all CPUs
      ACPI: utils: Rearrange in acpi_evaluate_reference()
      ACPI: utils: Return bool from acpi_evaluate_reference()
      ACPI: utils: Refine acpi_handle_list_equal() slightly
      ACPI: utils: Fix white space in struct acpi_handle_list definition
      ACPI: utils: Introduce helper for _DEP list lookup
      ACPI: OSL: Use spin locks without disabling interrupts
      ACPI: EC: Use a threaded handler for dedicated IRQ
      ACPI: EC: Use a spin lock without disabing interrupts

Randy Dunlap (1):
      ACPI: watchdog: fix kernel-doc warnings

Sakari Ailus (4):
      device property: Add SOFTWARE_NODE() macro for defining software nodes
      ACPI: property: Dig "rotation" property for devices with CSI2 _CRS
      ACPI: property: Replicate DT-aligned u32 properties from DisCo for Imaging
      ACPI: scan: Fix an error message in DisCo for Imaging support

Shuai Xue (1):
      ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
synchronous events

Srikar Srimath Tirumala (1):
      ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241

Tony Luck (1):
      ACPI: extlog: Clear Extended Error Log status when RAS_CEC
handled the error

Yuluo Qiu (1):
      ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop

Yuntao Wang (4):
      ACPI: tables: Correct and clean up the logic of acpi_parse_entries_array()
      ACPI: NUMA: Remove unnecessary check in acpi_parse_gi_affinity()
      ACPI: NUMA: Optimize the check for the availability of node values
      ACPI: NUMA: Fix the logic of getting the fake_pxm value

---------------

 drivers/acpi/Kconfig                               |   5 +
 drivers/acpi/Makefile                              |   3 +-
 drivers/acpi/acpi_extlog.c                         |  12 +-
 drivers/acpi/acpi_lpit.c                           |   2 +-
 drivers/acpi/acpi_lpss.c                           |  51 +-
 drivers/acpi/acpi_video.c                          |  77 +--
 drivers/acpi/acpi_watchdog.c                       |   2 +-
 drivers/acpi/apei/einj.c                           |  71 +-
 drivers/acpi/apei/ghes.c                           |  29 +-
 drivers/acpi/arm64/Makefile                        |   1 +
 drivers/acpi/arm64/thermal_cpufreq.c               |  22 +
 drivers/acpi/bus.c                                 |  32 +-
 drivers/acpi/button.c                              |  10 +
 drivers/acpi/ec.c                                  | 116 ++--
 drivers/acpi/internal.h                            |  28 +-
 drivers/acpi/mipi-disco-img.c                      | 725 +++++++++++++++++++++
 drivers/acpi/numa/srat.c                           |  10 +-
 drivers/acpi/osl.c                                 |  77 +--
 drivers/acpi/processor_thermal.c                   |  49 +-
 drivers/acpi/property.c                            | 102 ++-
 drivers/acpi/resource.c                            |  19 +
 drivers/acpi/scan.c                                |  61 +-
 drivers/acpi/thermal.c                             |  73 +--
 .../{thermal/thermal_acpi.c => acpi/thermal_lib.c} |  80 ++-
 drivers/acpi/utils.c                               | 164 ++---
 drivers/firmware/efi/dev-path-parser.c             |   7 +-
 drivers/perf/arm_cspmu/arm_cspmu.c                 |   4 +-
 drivers/platform/chrome/cros_ec_debugfs.c          |   2 +-
 drivers/platform/surface/surface_acpi_notify.c     |  30 +-
 drivers/pnp/pnpacpi/rsparser.c                     |  12 +-
 drivers/thermal/Kconfig                            |   4 -
 drivers/thermal/Makefile                           |   1 -
 drivers/thermal/intel/Kconfig                      |   2 +-
 drivers/thermal/intel/int340x_thermal/Kconfig      |   2 +-
 fs/debugfs/file.c                                  |  28 +-
 include/acpi/acpi_bus.h                            | 169 ++++-
 include/acpi/video.h                               |   9 +
 include/linux/acpi.h                               |  22 +-
 include/linux/property.h                           |   7 +
 include/linux/thermal.h                            |   7 -
 lib/fw_table.c                                     |  30 +-
 41 files changed, 1603 insertions(+), 554 deletions(-)

