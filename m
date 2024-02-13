Return-Path: <linux-kernel+bounces-63417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D0D852F00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FCB1C21AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C205364DB;
	Tue, 13 Feb 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8NL7LZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB21364A3;
	Tue, 13 Feb 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823259; cv=none; b=o38GUCma1NPQiFAoAEzqnb9iQBDQCoDXEOj/U6bmp6/sC1mFyBtHb8PGsHrOd7swUDpJIBDtnIQky98On+3GP33T8RXO4y0FzUAEis1PzQOLDX2qnn562s3q4DKj+jQf8IyPOjCgKnuPrbe8FwPfn7gDzE3nT31j4Fq3MUR6+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823259; c=relaxed/simple;
	bh=pOyF5CfLouZgow7TuV5pWW9r9yPAsPyI7+i4TrHEPsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcDIChYkbqkEDueMHspkQoG4yvjHhWumUv3CHZyL3lEJL/rHDM5nVNVvqDm2RdPBndq1xWSBLe7B3MDJ1ZHyqYpZGXOqfcRHpnzFNeNDeIk/9fpnXMYNmUE0AQZDS2+l1v7vlfM6DFhe0K2+up4HmYK+AEL2ITU4N0VnKi0TPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8NL7LZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC9CC433F1;
	Tue, 13 Feb 2024 11:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707823258;
	bh=pOyF5CfLouZgow7TuV5pWW9r9yPAsPyI7+i4TrHEPsU=;
	h=From:To:Cc:Subject:Date:From;
	b=j8NL7LZXhY9d9S9H+jlm3YKSQKgOe5jcKiaGzUDOQ1snpFtSJqhfOaeFmjutyi7zq
	 nNteUvklFXDC/3oybcOQWM2YfepjHSWJwygEarwTushIWuo5pvXICyaiLJSC3zm+6Q
	 /1Cn6uRgp7ZlJ+siQLuDkIqbXVc5LYw8glM3iFd1HwlE+tOmSEpIDtFalgsNCtq29e
	 QoeENfA+SUwmcGNBK+wk64DxptIsR8ClWn/hZbZ/JPDsIDf6oq93VEyMNB4h2uXO+r
	 KMxoINUVJbIOexhcMd6ralxLbcy6idqa+hSleBawABSfDFr15Pc6ssYCUkFT2+6d5d
	 R1H7uBC1Tt7Dg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: bp@alien8.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Douglas Thompson <dougthompson@xmission.com>,
	James Morse <james.morse@arm.com>,
	Jan Luebbe <jlu@pengutronix.de>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-edac@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Robert Richter <rric@kernel.org>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/7] EDAC: remove unused structure members
Date: Tue, 13 Feb 2024 12:20:44 +0100
Message-ID: <20240213112051.27715-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series removes unused EDAC structure members as found by
clang-struct (and manually checked by me).

I admit I could not even compile-test octeon files, hopefully
kernel-test robot would catch mistakes in there.

Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Douglas Thompson <dougthompson@xmission.com>
Cc: James Morse <james.morse@arm.com>
Cc: Jan Luebbe <jlu@pengutronix.de>
Cc: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: Khuong Dinh <khuong@os.amperecomputing.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-edac@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Robert Richter <rric@kernel.org>
Cc: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>

Jiri Slaby (SUSE) (7):
  EDAC/amd64: Remove amd64_pvt::ext_nbcfg
  EDAC/device: Remove edac_dev_sysfs_block_attribute::{block,value}
  EDAC/device: Remove edac_dev_sysfs_block_attribute::store()
  EDAC: Remove dynamic attributes from edac_device_alloc_ctl_info()
  EDAC: Remove edac_pci_ctl_info::edac_subsys
  EDAC: Remove edac_pci_ctl_info::complete
  EDAC: Remove edac_device_ctl_info::removal_complete

 drivers/edac/altera_edac.c       |  8 ++---
 drivers/edac/amd64_edac.h        |  1 -
 drivers/edac/amd8111_edac.c      |  3 +-
 drivers/edac/armada_xp_edac.c    |  2 +-
 drivers/edac/cpc925_edac.c       |  2 +-
 drivers/edac/edac_device.c       | 53 ++------------------------------
 drivers/edac/edac_device.h       | 22 ++-----------
 drivers/edac/edac_device_sysfs.c | 22 ++-----------
 drivers/edac/edac_pci.h          |  5 ---
 drivers/edac/highbank_l2_edac.c  |  2 +-
 drivers/edac/mpc85xx_edac.c      |  2 +-
 drivers/edac/octeon_edac-l2c.c   |  2 +-
 drivers/edac/octeon_edac-pc.c    |  2 +-
 drivers/edac/qcom_edac.c         |  1 -
 drivers/edac/sifive_edac.c       |  3 +-
 drivers/edac/thunderx_edac.c     |  6 ++--
 drivers/edac/xgene_edac.c        | 10 +++---
 drivers/edac/zynqmp_edac.c       |  2 +-
 18 files changed, 26 insertions(+), 122 deletions(-)

-- 
2.43.1


