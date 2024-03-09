Return-Path: <linux-kernel+bounces-98041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D88773FC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B336282005
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D99524D3;
	Sat,  9 Mar 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkJHojhO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF394F894
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710018170; cv=none; b=nAugUe2KIeJCiq/GuHdWzoWA/99SVAIrCGmgG7GnyBul2Uwe4KiCE5v7ohwpc5IuZaEujk7hLYB9D2kbQrk7a0oKq8PYoiSTt3dInsRnkEkUvq62r2EZap01q3WfWDg5XT+C/3gZLH76qmtwozUydb0ckhdaxVv9B8/TBbovs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710018170; c=relaxed/simple;
	bh=uJpLDwjkc8LDuvivXlw+JgOZ/QjkKCgt3QbWl797as4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWy78IdOv45wZqBOaSgg1Lf8Sc42Uui8rVdJFptvihUH+jBkH8IQqPPNH2FRvxzCroDrqrAjXkLCeKjm3TEWTxfRfFUGHzzv2qB+tDjKkyEKPkecDXhqSRs/kl0kfTpXkDAXXFzZPSuQHDHvPU2VqXW8TzDpE8HqP6zsYuEnZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkJHojhO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710018169; x=1741554169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uJpLDwjkc8LDuvivXlw+JgOZ/QjkKCgt3QbWl797as4=;
  b=ZkJHojhOS6jmHqzXvCejshW/uRSh92c7v7QJ1RjKFypr8k8xuLG7uXzA
   Gz6+5lBaeyVqhsV0/QOLFQz4uHKkFhKqc6H4lk8x5qz/1YQko+cbbiWLI
   Ce5n79Kk3atm7fhZGlhhvaQhwTt2zeyAkGLM3wL713Mvr05uE0JpJAFSs
   zuGunppsj4yBFoldgj7oX82Z/uQr9Cpsxm6fo8Pj4VpHCvHg7n7fmMsib
   T0JO/LWqD6nxKKjD0/FSNuyoF2V2MSkBzbXiqofZxVHius2j0ogwxf5et
   YTe6t3Ytd1T4At8TXNWD0++WAmSs3RZy1ZgWXfeg8711Uq3hwNDjf1EIc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4861568"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="4861568"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 13:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="937048391"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="937048391"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2024 13:02:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2D0FD193; Sat,  9 Mar 2024 23:02:42 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hpa@zytor.com,
	seanjc@google.com,
	ele.reshetova@intel.com,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/4] Adjust TD settings on boot
Date: Sat,  9 Mar 2024 23:02:26 +0200
Message-ID: <20240309210230.239045-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust TD setting on boot:

  - Disable EPT violation #VE on private memory if TD can
    control it;

  - Enable virtualization of topology-related CPUID leafs
    X2APIC_APICID MSR;

Kirill A. Shutemov (4):
  x86/tdx: Introduce tdg_vm_wr()
  x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
  x86/tdx: Handle PENDING_EPT_VIOLATION_V2
  x86/tdx: Enable ENUM_TOPOLOGY

 arch/x86/coco/tdx/tdx.c           | 117 ++++++++++++++++++++++++++----
 arch/x86/include/asm/shared/tdx.h |  21 +++++-
 2 files changed, 123 insertions(+), 15 deletions(-)

-- 
2.43.0


