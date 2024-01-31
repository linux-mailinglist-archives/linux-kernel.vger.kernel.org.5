Return-Path: <linux-kernel+bounces-46349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29263843E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B960B280ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9261768F4;
	Wed, 31 Jan 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGo0UW7A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951B56D1BA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700729; cv=none; b=qnl/+1NsdPKkQMkO1RXlLUnljx0eyuXVPOe/uBDaHXzCuJe3fkpUJGS/Jis1c6/wciVNoTJFeZ6rTxgz+u42YYtwaUo72WdoeV16bgld1a89xAGRGMK1jM0FGsx5tcwRfA6XalbmVHO+8ymwJrlMqea50DuG62kaiCK/+TqRLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700729; c=relaxed/simple;
	bh=BMkblpyoANB3IfYB1c0zr/z+RR3pHfH694CCivKN7dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sNWUbGZd7hz6/T/TITOX5Wm+5W2/wtoZ3hXQ8nAfmoN2pWNq/D/0AnIMTTOu1VjiFiaFNISIv+LDdnbHUdpVklvZp54sftglMQRB+IPZUWa9KlR/OF3NYCo65ggzNOjU3CaiOQgddgf22OVcLG5L28hbOKjpiQGGkIASVSZxHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGo0UW7A; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706700727; x=1738236727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BMkblpyoANB3IfYB1c0zr/z+RR3pHfH694CCivKN7dg=;
  b=aGo0UW7Ad6XOguA/YlPIK5+9ZarWH7pXUdxiywHv/XiUZNT6PSLj8B3F
   +GrMf/retWTyUMCANBWqGJ8fFvVF4HTQ9Cosss9c2T9Bu34Sx1ahNyiUL
   UtN5VRw45h9IkKSzjlmg9aLMR5LatU2wh+D/zYdKctfCy9DtyivJk/1s8
   G9i8hJ89/DHIJL5DcesDnTyVefCwnL+fT4ZLHR+dsYbArhHO/aVhwCv+X
   ScVg/9/lXx/VHLQsvRjgx+KC57tE5J7pQQDy5O5hLZNLUn7nfwob7X+gc
   Ht9iY2syCNCjMjHph6Woci8OQdSuEADeSo0ZWY6mvfU8onPW1rP8vLNPi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3414122"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3414122"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878764784"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="878764784"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:03 -0800
From: "Huang, Kai" <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	thomas.lendacky@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com
Subject: [PATCH 0/4] TDX host: kexec() support
Date: Wed, 31 Jan 2024 11:31:52 +0000
Message-Id: <cover.1706698706.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently kexec() support and TDX host are muturally exclusive in the
Kconfig.  This series adds the TDX host kexec support so that they can
work together and can be enabled at the same time in the Kconfig.

This follows Dave's suggestion to add the CC_ATTR_HOST_MEM_INCOHERENT
attribute to unify both Intel and AMD, instead of having Intel/AMD
specific checks around [1].

Hi Tom,

I've tested on my TDX testig machine but I don't have AMD machine to
test.  I highly appreciate if you or any AMD guy can help to review
and/or test this series to make sure I didn't break anything.

Thanks a lot!

[1] https://lore.kernel.org/lkml/cbc9c527-17e5-4a63-80fe-85451394cc7c@amd.com/

Kai Huang (4):
  x86/coco: Add a new CC attribute to unify cache flush during kexec
  x86/virt/tdx: Advertise the CC_ATTR_HOST_MEM_INCOHERENT for TDX host
  x86/kexec(): Reset TDX private memory on platforms with TDX erratum
  x86/virt/tdx: Remove the !KEXEC_CORE dependency

 arch/x86/Kconfig                   |   2 +-
 arch/x86/coco/core.c               |  34 +++++++++-
 arch/x86/include/asm/tdx.h         |   2 +
 arch/x86/kernel/machine_kexec_64.c |  18 ++++-
 arch/x86/kernel/process.c          |  14 +---
 arch/x86/mm/mem_encrypt_identity.c |  11 +++-
 arch/x86/virt/vmx/tdx/tdx.c        | 101 +++++++++++++++++++++++++++++
 include/linux/cc_platform.h        |  16 +++++
 8 files changed, 183 insertions(+), 15 deletions(-)


base-commit: a6f0b57202b0ee50dc042bae16494008dc6dc992
-- 
2.34.1


