Return-Path: <linux-kernel+bounces-41149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC5983EC9E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EFB1F236CE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52041EB2F;
	Sat, 27 Jan 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVGounnX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDA7F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350135; cv=none; b=MIIoENzUHfIP7sOaO8OUxYMkMURYUcq90WehcaECk8IzudLKaidxx1kaupiKpYTdSwVSfOAJ+QdBURRBlcqQyHKpWSM9YbsHTp4ltTBiu7dvUeia1xBwtJV/w2Yk8+dFmo6Eoxvon5inyj69/L60lyv2Uu0z4URNchDSDHb1VC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350135; c=relaxed/simple;
	bh=1VxgF4ABxRMuz9+GUjkRK1OHy17du72n2fD1tWMTxtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULFmg47TORfm3XIAvELL2xE7ec5WTGBKWA7LdJM44TLDr1Lzq4e50D8JdnqMxpvtgYHyShP3EqFz1rSMOkbtswyMG+tPC2KMGaB2AkxCxMg3H4pZa0Fsg6BEMG65+QOhvBPWJrjLsPGG/LL8BhEbaXr3KYit8BDr7hbplsw9ugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVGounnX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706350133; x=1737886133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1VxgF4ABxRMuz9+GUjkRK1OHy17du72n2fD1tWMTxtc=;
  b=dVGounnXXb2yoafnYMsTg/e6jfPc30wTZw1d3mW6qRZFRiqaJK5UBkM7
   4oe7ykukuO5i4/AKk4Rf19SRi8WeTAvDOBIcDONtCwHA1po6eVtHutpNf
   XSS52c2FXLhRmPf0e3euWl2GMAgQnuiWP6aKSmeSezEiiYA3YGvijJoDM
   du3Mt2ovJPp50whhsgwv4Og4WXvporR6HveM2ZwLcwJROry2xul6NGfnw
   SbACAnqiaHvKrEsXDbM2w8wz1WmiN4mIFKMgrv5A0ACxayfzfrfRodh+f
   Eu7CbCEcgadGQf3KY8D5U6CbzGApJDlt6zfr4xfWFOeL7m8JN8nE/Xnxp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="16190964"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16190964"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 02:08:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736923486"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="736923486"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2024 02:08:51 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	ravi.v.shankar@intel.com,
	andrew.cooper3@citrix.com
Subject: [PATCH 0/2] x86/fred: Fix two build issues
Date: Sat, 27 Jan 2024 01:37:26 -0800
Message-ID: <20240127093728.1323-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Boris reported two build issues immediately after the FRED native patches
landed in the tip x86/fred branch, fix them.

Xin Li (2):
  x86/fred: Fix build with clang
  x86/fred: Fix build with CONFIG_IA32_EMULATION=n

 arch/x86/entry/entry_64_fred.S | 3 +--
 arch/x86/entry/entry_fred.c    | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)


base-commit: a9f26154bf5478fc155309fc69128415f3a1be08
prerequisite-patch-id: 4dc72e7440d5412bf200dbccb9a41128ed30baec
-- 
2.43.0


