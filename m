Return-Path: <linux-kernel+bounces-89268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903E686ED96
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BE51C21197
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0298E5235;
	Sat,  2 Mar 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SgabdurG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457DE1C16
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709340494; cv=none; b=GtgRczk+M6zqxp+5x7W4LkMRJ8ykEErmKqrui3ZuMaqjK/n0gG7zLg4+vTWskF7/0nXgkMuOPEsJ9VQYm6627yqknaPrSjgUKvMbRm9BT74XCKzn4noc3D085TMcvInSeJF9LovI5M8fcmheyaQ9vbmhpL24iMoM9Xz2VkZOEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709340494; c=relaxed/simple;
	bh=IOd6NDIB0Dl8xkBbMQFvKKUFMPFYIy3Vr4ztdYQ9VgA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DGU5peNEQ/SWkMV0Dj2x7/AriRfywiBTOhciTO31hfWiTefyX/HEZO1SaI1UlpRt1o1/4wYjJFxfTNMpSSYbyUYbLQ5THwaa38uhbD4mq6SvRYgSCVzem59RBzwaRKEmCmjx8MhEMjV2jlwM/CXBZ8/ZrPgqFL5MMoSHcBAjsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SgabdurG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709340492; x=1740876492;
  h=date:from:to:cc:subject:message-id;
  bh=IOd6NDIB0Dl8xkBbMQFvKKUFMPFYIy3Vr4ztdYQ9VgA=;
  b=SgabdurGiiupgtiw0WTZmwc+Swbr0B0+mAuMEY/JVAzjul1+PNdecYvF
   7aZMaw0pl8PdVlIxzcNYN47awxoeirVEsY9npsg1+62AOKuRQpXcLrBm3
   GdcKFD09JF1EPRx+Z6uEygNK3y4dKFUgzK0ta5eb9DyR8G1UyhN8kXZXH
   9b8uhPDU2lrWDsHn6N8gYnkMdNpVmbc8hvblYKahzOFxvTl6sp0uhkO0I
   Omo6pwuv2DQYOytq6jyRGNwANKrV7u5WelyrKwJqj9yAttMqHF/q3w2n5
   RilGScl8iEpQTJUb8MWMeu/YDbnL8rIZ/DoU5n7+iCGVVX800++YTJuQF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="29320038"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="29320038"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="39204192"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 01 Mar 2024 16:48:11 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgDXs-000ECR-08;
	Sat, 02 Mar 2024 00:48:08 +0000
Date: Sat, 02 Mar 2024 08:47:54 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 721f791ce1cddfa5f2bf524ac14741bfa0f72697
Message-ID: <202403020851.pgaPgfBC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 721f791ce1cddfa5f2bf524ac14741bfa0f72697  x86/boot: Use 32-bit XOR to clear registers

elapsed time: 729m

configs tested: 26
configs skipped: 132

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240302   clang
i386         buildonly-randconfig-002-20240302   gcc  
i386         buildonly-randconfig-003-20240302   gcc  
i386         buildonly-randconfig-004-20240302   clang
i386         buildonly-randconfig-005-20240302   gcc  
i386         buildonly-randconfig-006-20240302   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240302   clang
i386                  randconfig-002-20240302   gcc  
i386                  randconfig-003-20240302   clang
i386                  randconfig-004-20240302   gcc  
i386                  randconfig-005-20240302   gcc  
i386                  randconfig-006-20240302   clang
i386                  randconfig-011-20240302   gcc  
i386                  randconfig-012-20240302   gcc  
i386                  randconfig-013-20240302   gcc  
i386                  randconfig-014-20240302   gcc  
i386                  randconfig-015-20240302   clang
i386                  randconfig-016-20240302   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

