Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9E7CBA14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjJQFZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjJQFZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:25:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584BC185;
        Mon, 16 Oct 2023 22:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697520303; x=1729056303;
  h=from:to:cc:subject:date:message-id;
  bh=uFnVHow6/7iLw6jBlHdpFq+FgPhk3gqeoxO/WOVpyZ8=;
  b=MOIfAekuBe+snMejfoJBUSTdmbn3w2AbSNO9V7XvVFROWUa7P5KwDoSq
   GHAqlBjSwhfC05vqUpi6Cy1xuOR3qTU0yRXvgUG6v4nOsgsGY8m0BtBOI
   5WRCXKhqWLdZ4GYUKL5CCu+p9AH+oB/789qtHkXhHoRLLbvehhFrGaEzF
   KPbvtGwgo0W21g8Ea4epyJWB9syvtAByP/SS3sbl3kbdqL0AUJcB3kPUc
   eh9czHCuh5uaTwf8oGUbfoUxg+1SES698+XcekNZyypVIV44UkPThH78U
   lJW+NW9h1Zvpf5cdLIR52/X0LWFw6B6hwkJgFowdk3417+pzbNuQwKHSo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388561713"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="388561713"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087357954"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1087357954"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 22:24:57 -0700
From:   lakshmi.sowjanya.d@intel.com
To:     tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
        christopher.s.hall@intel.com, pandith.n@intel.com,
        mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: [PATCH v1 0/6] Add support for Intel PPS Generator
Date:   Tue, 17 Oct 2023 10:54:51 +0530
Message-Id: <20231017052457.25287-1-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The goal of the PPS(Pulse Per Second) hardware/software is to generate a
signal from the system on a wire so that some third-party hardware can
observe that signal and judge how close the system's time is to another
system or piece of hardware.

Existing methods (like parallel ports) require software to flip a bit at
just the right time to create a PPS signal. Many things can prevent
software from doing this precisely. This (Timed I/O) method is better
because software only "arms" the hardware in advance and then depends on
the hardware to "fire" and flip the signal at just the right time.

To generate a PPS signal with this new hardware, the kernel wakes up
twice a second, once for 1->0 edge and other for the 0->1 edge. It does
this shortly (~10ms) before the actual change in the signal needs to be
made. It computes the TSC value at which edge will happen, convert to a
value hardware understands and program this value to Timed I/O hardware.
The actual edge transition happens without any further action from the
kernel.

The result here is a signal coming out of the system that is roughly
1,000 times more accurate than the old methods. If the system is heavily
loaded, the difference in accuracy is larger in old methods.
Facebook and Google are the customers that use this feature.

Application Interface:
The API to use Timed I/O is very simple. It is enabled and disabled by
writing a '1' or '0' value to the sysfs enable attribute associated with
the Timed I/O PPS device. Each Timed I/O pin is represented by a PPS
device. When enabled, a pulse-per-second(PPS) synchronized with the
system clock is continuously produced on the Timed I/O pin, otherwise it
is pulled low.

The Timed I/O signal on the motherboard is enabled in the BIOS setup.

References:
https://en.wikipedia.org/wiki/Pulse-per-second_signal
https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-DxLW6t_V/view
https://youtu.be/JLUTT-lrDqw

Patch 1 contains the conversion from system time to system counter i.e
the format that the hardware understands.
Patch 2 has the conversion from TSC(Time stamp counter) to ART(Always
running timer) time.
Patch 3 introduces the interface to check if the clock source is related
to ART.
Patch 4 adds the pps(pulse per second) generator tio driver to the pps
subsystem.
Patch 5 documentation and usage of the pps tio generator module.
Patch 6 includes documentation for sysfs interface.

Please help to review the changes.

Thanks in advance,
Sowjanya

Lakshmi Sowjanya D (6):
  kernel/time: Add system time to system counter conversion
  x86/tsc: Convert Time Stamp Counter (TSC) value to Always Running
    Timer (ART)
  x86/tsc: Check if the current clock source is related to ART(Always
    Running Timer)
  pps: generators: Add PPS Generator TIO Driver
  Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
  ABI: pps: Add ABI documentation for Intel TIO

 .../ABI/testing/sysfs-platform-pps-tio        |   7 +
 Documentation/driver-api/pps.rst              |  22 ++
 arch/x86/include/asm/tsc.h                    |   4 +
 arch/x86/kernel/tsc.c                         |  44 +++
 drivers/pps/generators/Kconfig                |  16 +
 drivers/pps/generators/Makefile               |   1 +
 drivers/pps/generators/pps_gen_tio.c          | 302 ++++++++++++++++++
 include/linux/timekeeping.h                   |   5 +
 kernel/time/timekeeping.c                     |  69 ++++
 9 files changed, 470 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

-- 
2.17.1

