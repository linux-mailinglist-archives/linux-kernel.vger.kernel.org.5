Return-Path: <linux-kernel+bounces-118779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3869A88BF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A60C1C2C623
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FA6773D;
	Tue, 26 Mar 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2bs+3Dx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6D5C904
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448629; cv=none; b=mWL3sW6bspJLUyUFS89dyGp0MSr036gpQvxtqkj0E/1S3AfwKX69dQJ6NxINoOnGTBY4xeEpz0smTuA7om+2VA6DkOplFjBhn/LiXNu3WCDRkpkGGKtFklGNyYlLF0TteDjGKLPGmhQyA17E7QdtjA9wbNcfWFjeQC7/ldPdHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448629; c=relaxed/simple;
	bh=SLwhJ+EcwkZ7CsAM0YpIK0FVBbXR5eRWkHJx2SwM1/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ee662NWvBFuC5mFxRaIkyHIDuSnKUgcUmyjz0PWlEo3nHpk21AD4GsSffhO5OLoQ/ZBdpIhpGJ9PmlWCu/RRlsQTMZOX4ER1iG6ZqdRPR0YPshA6TzNFqv9vlAiXccBFlpx/a3Mr6KlnUrglPgnmnw1reYgpc91/C0Ou1xPij/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2bs+3Dx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711448628; x=1742984628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SLwhJ+EcwkZ7CsAM0YpIK0FVBbXR5eRWkHJx2SwM1/o=;
  b=S2bs+3DxT2PHotuNYcp7ICuv84bvl2ceWXq9diYiQnssylrqiyS1pZeS
   ZAbSWA4jJ3HzJzdjj7NrNKPKeGwRNRCpTPA2oRIkB/zs5hwTrtU/4Y61l
   bxbIs5sQD+gbpPY+M4JJbaoZZAswrNvCumzRbbUfCldCV91gr1ogU3Wbe
   h22hqBC41MFjnstdiVQ7jMflm6y1qb7mfmqbHZyFlMPoumfycCf57yDuV
   q+mC3eYZ+3barutIvPjHUlOXnrrU47t+uAUZ/iqsF/N9otA0VgfsYsi9P
   uuZ9sA8sPwouGBz1l9yTT0vE9peQRPC+qDlgxXdKD6dQU6l6rrSqWBTWM
   w==;
X-CSE-ConnectionGUID: Zbrzw932TYWiHVjyJAZCqA==
X-CSE-MsgGUID: 6E+qZgExT5yt284VRyCF6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6678697"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6678697"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="39029341"
Received: from pyong-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.75.208])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:23:44 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@redhat.com,
	hpa@zytor.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	jgross@suse.com,
	binbin.wu@linux.intel.com,
	kai.huang@intel.com
Subject: [PATCH v2 0/5] TDX host: Provide TDX module metadata reading APIs
Date: Tue, 26 Mar 2024 23:23:27 +1300
Message-ID: <cover.1711447449.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM will need to read bunch of TDX module metadata fields to create and
run TDX guests.  In the long term, other in-kernel TDX users, e.g., VT-d
also likely will need to read metadata.  This series provides common APIs
in the TDX host code so that KVM can use.

v1 -> v2:
  - Collect BinBin's tag.
  - Rebase to latest Linus's tree (but can also be cleanly applied to 
    latest tip/master and tip/x86/tdx).

(I dropped KVM list from the To list to stop dumping emails to people's
 mailbox, but keep maintainers Cc'ed.)

v1: https://lore.kernel.org/lkml/cover.1709288433.git.kai.huang@intel.com/T/

Kai Huang (5):
  x86/virt/tdx: Rename _offset to _member for TD_SYSINFO_MAP() macro
  x86/virt/tdx: Move TDMR metadata fields map table to local variable
  x86/virt/tdx: Unbind global metadata read with 'struct
    tdx_tdmr_sysinfo'
  x86/virt/tdx: Support global metadata read for all element sizes
  x86/virt/tdx: Export global metadata read infrastructure

 arch/x86/include/asm/tdx.h  | 22 ++++++++++
 arch/x86/virt/vmx/tdx/tdx.c | 84 +++++++++++++++++++++----------------
 arch/x86/virt/vmx/tdx/tdx.h |  2 -
 3 files changed, 71 insertions(+), 37 deletions(-)


base-commit: 928a87efa42302a23bb9554be081a28058495f22
-- 
2.43.2


