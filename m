Return-Path: <linux-kernel+bounces-77056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300B860094
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900F41C25258
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894F157E9B;
	Thu, 22 Feb 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL7tys9L"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A2156990;
	Thu, 22 Feb 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625665; cv=none; b=jhIu7SjZOvFjGGDGrjP/BIaoIL7+MgmbOv0VjLUQjRl4JqpyOpQ/3qu7dIZicJKFmQ9TE13xs+FY41YcgM1TmZUAd/qAJYVtiSL5lmUVTvcoLttvNy0mvr49Mozeu7r7xyick6sIPY2NEuQA7Sj6gOj2eSfaQdPCkxlZCnEmlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625665; c=relaxed/simple;
	bh=KzFfkE1AqdsauvIwO1RKmi2wVFgoD6uToqHWHJuCmiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFCMMh091dIYQJJOd6AvyoiAFw6jcWPIfR1RcTvrNwO9xeR145JHzfiZRmx0Xjotb5CtGxAzmvDvtzF/6hcghE0GM5Pq6eQLkQ8RnA5a+K5jRKZAuRZ1JZdp/Ml8Cm+/rfDhF8tiD8Agtgx3xM4S++tMXUb8/38hFI011D4xFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL7tys9L; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512bd533be0so107974e87.0;
        Thu, 22 Feb 2024 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625661; x=1709230461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PN5NRQnWHEZRwyT6/9VVPAz+f1vMXJvzGhXBi4EmoP0=;
        b=RL7tys9LGzd3RFS1nHPQSGugsb5LexxKbwjzFrBAPt9Oab0kZEDaJ45YMU3bP2AL5O
         7+p7fxxkk8hZ7Br5rkI7fF/3q6q4fJaV92AiAwoh31m1MkOARWoRlc+T3Tq0wmPwPqsG
         3J7X93HPQb/n6KGJAEZuOuxv7qjhe9nBQRcj2BsWmW9f5OiwOahWvraHqMgn+J22W4rl
         mjuce/fGruYLbVY5j4/lP19oRPvikJqR7zIF2vUZoBdc6YGNdfNcRimJk9DJjNGNI4NA
         lniYaDUXkrnKOIgEMGwX7Xthu4LpipOct4smOXHJvt3Ejm31NsATWi2PbnkDv4z4g8Zo
         oNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625661; x=1709230461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PN5NRQnWHEZRwyT6/9VVPAz+f1vMXJvzGhXBi4EmoP0=;
        b=jnl5hURv4MpcmuxiSLfNN3zc+h87kldpHYqsOO2xR1lkj2iZ8w4SndQlGSK93ZdnX+
         UbWGzwVVIm5qSC7yGPxOsnWg1X1WCGcrEJ5bJtApZNijmJepM0r6dsLyyGkUtrmEpZuH
         xjflnStI4GNCteMCeD8/l+hvUY9YVm5zSK+W4qntKRTBMBwlVBZUjz14zcMnCr2QZSE5
         PW6DE8j1WdIMFfJTT9I+3eqPKVKPsUW3aOgV5eJ+ZHTqVYhvQ6/46TnqczzAOjDy3vz5
         bQHg/C/FiMkLfMkNCpStg5w1SWWUf1mdxD1dv1/Km+45q1b/CF7PGfc2V9bIyqlsPuvP
         m0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVuQdVIKfX4cjJVwH+0+l+Qh64gWbwMCyvSyLCDp6eh8DJvVM5JSYDvaurrihdfQgKQ/cuFgEuPK/jww8SAu1fk/YQLTwoKHVnZMOiJ2S/606/JZT+G+/hHee6EYEroc0f9btyxtLHacg==
X-Gm-Message-State: AOJu0YxxwbvtrySjWkVqtnnqU/8kVO8lWDUKR4Jh/kIVb6P60qKzVNA+
	fMiWITKTsYQpkxjbD/y8LVvzOLbiL0ruNUXCS/2DysJ1IT+H6bLI
X-Google-Smtp-Source: AGHT+IHNzg7aBgXaIJbMNuK7guBEV8t9q5d8NEnp8aTPztWCzWFVniq+diGN4H/a4FvKPWQ4MvMgFg==
X-Received: by 2002:a05:6512:3089:b0:512:ada6:f218 with SMTP id z9-20020a056512308900b00512ada6f218mr12105162lfd.59.1708625661075;
        Thu, 22 Feb 2024 10:14:21 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w5-20020a05651204c500b00512dfa19983sm246262lfq.50.2024.02.22.10.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:14:20 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/20] EDAC/mc/synopsys: Various fixes and cleanups
Date: Thu, 22 Feb 2024 21:12:45 +0300
Message-ID: <20240222181324.28242-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is a first one in the series created in the framework of
my Synopsys DW uMCTL2 DDRC-related work:

[1: In-progress v5] EDAC/mc/synopsys: Various fixes and cleanups
Link: ---you are looking at it---
[2: In-progress v4] EDAC/synopsys: Add generic DDRC info and address mapping
Link: https://lore.kernel.org/linux-edac/20230920192806.29960-1-fancer.lancer@gmail.com
[3: In-progress v4] EDAC/synopsys: Add generic resources and Scrub support
Link: https://lore.kernel.org/linux-edac/20230920195720.32047-1-fancer.lancer@gmail.com

Note the patchsets above must be merged in the same order as they are
placed in the list in order to prevent conflicts. Nothing prevents them
from being reviewed synchronously though. Any tests are very welcome.
Thanks in advance.

The main goal of the entire set of the changes provided in the mentioned
patchsets is to as much as possible specialise the synopsys_edac.c driver
to be working with the Synopsys DW uMCTL2 DDR controllers of various
versions and synthesized parameters, and add useful error-detection
features.

Regarding this series content. It's an initial patchset which
traditionally provides various fixes, cleanups and modifications required
for the more comfortable further features development. The main goal of it
though is to detach the Xilinx Zynq A05 DDRC related code into the
dedicated driver since first it has nothing to do with the Synopsys DW
uMCTL2 DDR controller and second it will be a great deal obstacle on the
way of extending the Synopsys-part functionality.

The series starts with the fixes patches, which in short concern the next
aspects: touching the ZynqMP-specific CSRs on the Xilinx ZinqMP platform
only, serializing an access to the ECCCLR/ECCCTL register, adding correct memory
devices type detection, setting a correct value to the
mem_ctl_info.scrub_cap field, dropping an erroneous ADDRMAP[4] parsing and
getting back a correct order of the ECC errors info detection procedure.

Afterwards the patchset provides several cleanup patches required for the
more coherent code splitting up (Xilinx Zynq A05 and Synopsys DW uMCTL2
DDRCs) so the provided modifications would be useful in both drivers.
First the platform resource open-coded IO-space remapping is replaced with
the devm_platform_ioremap_resource() method call for the sake of the code
simplification. Secondly the next redundant entities are dropped: internal
CE/UE errors counters, local to_mci() macros definition, some redundant
ecc_error_info structure fields and redundant info from the error message,
duplicated dimm->nr_pages debug printout and spaces from the MEM_TYPE
flags declarations. (The later two updates concern the MCI core part.)
Thirdly before detaching the Zynq A05-related code an unique MC index
allocation infrastructure is added to the MCI core. It's required since
after splitting the driver up both supported types of memory devices could
be correctly probed on the same platform. Note even though it's currently
unsupported by the synsopsys_edac.c driver it's claimed to be possible by
the original driver author (it was a reason of having two unrelated
devices supported in a single driver). Finally the Xilinx Zynq A05 part of
the driver is moved out to a dedicated driver. After that the
platform-specific setups API is removed from the Synopsys DW uMCTL2 DDRC
driver since it's no longer required.

Finally as the cherry on the cake a set of the local coding style
cleanups are provided: unify the DW uMCTL2 DDRC driver entities naming and
replace the open-coded "shift/mask" pattern with the kernel helpers like
BIT/GENMASK/FIELD_x in there. It shall significantly improve the code
readability.

Changelog v2:
- Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate patch.
  (@Krzysztof)
- Introduce a new compatible string "snps,dw-umctl2-ddrc" matching the new
  DT-schema name.
- Forgot to fix some of the prefix of the SYNPS_ZYNQMP_IRQ_REGS macro
  in several places. (@tbot)
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
- Include "linux/bitfield.h" header file to get the FIELD_GET macro
  definition. (@tbot)
- Drop the already merged in patches:
[PATCH 12/20] EDAC/mc: Replace spaces with tabs in memtype flags definition
[PATCH 13/20] EDAC/mc: Drop duplicated dimm->nr_pages debug printout

Changelog v3:
- Drop the no longer used "priv" pointer from the mc_init() function.
  (@tbot)
- Drop the merged in patches:
[PATCH v2 14/19] dt-bindings: memory: snps: Detach Zynq DDRC controller support
[PATCH v2 15/19] dt-bindings: memory: snps: Use more descriptive device name
  (@Krzysztof)

Changelog v4:
- Remove Rob, Krzysztof and DT-mailing list from Cc since the respective
  patches have already been merged in.
- Add a new patch
  [PATCH v4 6/20] EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
  detached from the very first patch of the series.
- Add a new patch
  [PATCH v4 15/20] EDAC/mc: Re-use generic unique MC index allocation procedure
- Add a new patch
  [PATCH v4 18/20] EDAC/synopsys: Unify CSRs macro declarations
  collecting the changes from various patches of the series.
- Drop redundant empty lines left by mistake.
- Drop private counters access from the check_errors() method too.
- Rebase onto the kernel v6.6-rcX.

Link: https://lore.kernel.org/linux-edac/20230920191059.28395-1-fancer.lancer@gmail.com
Changelog v5:
- Fix function names in the zynq_edac.c kdoc.
- Rebase onto the kernel 6.8-rc3.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (20):
  EDAC/synopsys: Fix ECC status data and IRQ disable race condition
  EDAC/synopsys: Fix generic device type detection procedure
  EDAC/synopsys: Fix mci->scrub_cap field setting
  EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
  EDAC/synopsys: Fix reading errors count before ECC status
  EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
  EDAC/synopsys: Use platform device devm ioremap method
  EDAC/synopsys: Drop internal CE and UE counters
  EDAC/synopsys: Drop local to_mci() macro definition
  EDAC/synopsys: Drop struct ecc_error_info.blknr field
  EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
  EDAC/synopsys: Drop redundant info from the error messages
  EDAC/mc: Init DIMM labels in MC registration method
  EDAC/mc: Add generic unique MC index allocation procedure
  EDAC/mc: Re-use generic unique MC index allocation procedure
  EDAC/synopsys: Detach Zynq A05 DDRC support to separate driver
  EDAC/synopsys: Drop unused platform-specific setup API
  EDAC/synopsys: Unify CSRs macro declarations
  EDAC/synopsys: Unify struct/macro/function prefixes
  EDAC/synopsys: Convert to using BIT/GENMASK/FIELD_x macros

 MAINTAINERS                  |   1 +
 drivers/edac/Kconfig         |   9 +-
 drivers/edac/Makefile        |   1 +
 drivers/edac/dmc520_edac.c   |   4 +-
 drivers/edac/edac_mc.c       | 135 ++++-
 drivers/edac/edac_mc.h       |   4 +
 drivers/edac/pasemi_edac.c   |   5 +-
 drivers/edac/ppc4xx_edac.c   |   5 +-
 drivers/edac/synopsys_edac.c | 967 ++++++++++++-----------------------
 drivers/edac/zynq_edac.c     | 501 ++++++++++++++++++
 10 files changed, 963 insertions(+), 669 deletions(-)
 create mode 100644 drivers/edac/zynq_edac.c

-- 
2.43.0


