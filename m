Return-Path: <linux-kernel+bounces-116883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB988A4CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1FE2E7EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58CC839EE;
	Mon, 25 Mar 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMu9DLt0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BC14D2AB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363588; cv=none; b=MDJvp7PSCr+m+Kdpj687wSkEMu5ZMT2HaCRzCvKmLkMOxvYVaJtE9pRuGeH5vgN7PCGC6zfn33MULUKgkTxGRYYmgqei/d2+mFunJi5LLbc9fAd/NfXMUIphhHr8LX9O8Q6/At1lc2UAx81v9b7nlyMzAUM0Q1cJaX2Sz3SMVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363588; c=relaxed/simple;
	bh=mlE49kqI6dPJkzgie9r8tKbOXRV7PLOUR48sfchNiMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzVQNQ9ZTPFN/lk2C3JGVF+zpNql/Ogf6uC3N+tB/lDRuVsgJOHzObDU79J30t+8r+RLDw8NR+FVP/HVVEkcKEeGqxbrjVAwUMeHsubLFy25UOWtycekiJR/IrfseYIj+4LCx5o6ZvBFzNWLQAdT67W68ZiP6j7yyOX8z6DnKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMu9DLt0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363587; x=1742899587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mlE49kqI6dPJkzgie9r8tKbOXRV7PLOUR48sfchNiMU=;
  b=WMu9DLt0zxz4a8zJWI+6orkb7LYL0xOnPIKUno1aGCRFnq7KsjUfMh7j
   dte0ZCuWFLHpC6uWMC9k2tU6FAbKYbDQuCBrgNUTXiXeCyjwLvcyVJ1EV
   BpWsgniW/E032PU5N4VwhPgQUGDXuJ+NGG8YDR4WzRvwX5JvllUSbmal2
   0UK57AGNZ7S11eJknG2u8KFdXpFFrJ+N6MvEc0uYNcofP1P9ZIAUG2bf5
   UIiOeZ9leKrsFCoENqpMsDFHd6844p62ckGv5SHmY1VmPTXPRLf7S7Lf8
   +1nDviiz2hZlxY7pe1Xkop7Gb3Hw2tCtFte3g0zMw6b/pTy+rbHK+LXrA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6562014"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6562014"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070191"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070191"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:46:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C6E43228; Mon, 25 Mar 2024 12:46:10 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hpa@zytor.com,
	seanjc@google.com,
	elena.reshetova@intel.com,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/4] x86/tdx: Adjust TD settings on boot
Date: Mon, 25 Mar 2024 12:46:03 +0200
Message-ID: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
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

v2:
  - Rebased;
  - Allow write to TDCS_TD_CTLS to fail;
  - Adjust commit messages;

Kirill A. Shutemov (4):
  x86/tdx: Introduce tdg_vm_wr()
  x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
  x86/tdx: Handle PENDING_EPT_VIOLATION_V2
  x86/tdx: Enable ENUM_TOPOLOGY

 arch/x86/coco/tdx/tdx.c           | 125 ++++++++++++++++++++++++++----
 arch/x86/include/asm/shared/tdx.h |  21 ++++-
 2 files changed, 131 insertions(+), 15 deletions(-)

-- 
2.43.0


