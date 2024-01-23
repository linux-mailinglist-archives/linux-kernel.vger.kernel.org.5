Return-Path: <linux-kernel+bounces-34728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E138386CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBCA282E36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F62443E;
	Tue, 23 Jan 2024 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCjN2pT4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A15384;
	Tue, 23 Jan 2024 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988460; cv=none; b=Eih+9fwBmYOUy4oWZ5voWBMSA7tyP3/kjzbsP1pjSLS0jAuhy8vbiEVBcnLsJYrSB9RfArUU5cptne8xfeKKvcH89+a5E4RrsFlHvUTWGdzZy6W3GsuRzUCU1FSEAgxiewUz3zUEHPMFlQU8rOrvCVYaLix6aTnotd13294Ss5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988460; c=relaxed/simple;
	bh=usqTaUXKEgQoY2T5x0AaG8q/SrqHWXmUVAmFQbDu13I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pdhuslRZecBFmgDDx0uqOCVSYUjdgYPXpqZL4Pg0IClCGhgMx4trSBPIRH/In1vTd2bK/tjc9HYJDSOrJbqYbIynncFgmlfodvrByqIVb6qYfTA+1/ptqdHkFtKJlLN2oFklpZqyTMuuP2hB+ucJg7JFNIGA5x9a2/I8CxmvDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCjN2pT4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705988460; x=1737524460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=usqTaUXKEgQoY2T5x0AaG8q/SrqHWXmUVAmFQbDu13I=;
  b=MCjN2pT4UbE7nSJEasC52lY7t5pWbnvgvcjAVQfxvtlowaZZiVQQucI/
   jE+27rl2wVa5CDzQyfVOV94hNplZAmu7Lc0EfCUPP5u8z3c0x9/ZVg3VM
   Kqxxc3hT8g+XAbty2ep086RyCtJng0XqVYwIKr7rIfld9sttRLZu3/aOT
   YAznmGN9xHsp8+PmB/LdZ7Z6hH27riJydog0YvH0LHS01jVWkEkvXAG3L
   tXz94WJ0m//AmjfzDDZEiyLchFoIRv+8ZD1E6GfTjF2DS17K8ZluuixGV
   1TqO8syxK+UnQy+bKg+Lghj90CnEIAEyEn5ZQT576nTOPE/5qEwOom8nS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14770134"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="14770134"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 21:40:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1471954"
Received: from junxiaochang.bj.intel.com ([10.238.157.86])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 21:40:42 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: bigeasy@linutronix.de,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	hao3.li@intel.com,
	lili.li@intel.com,
	jianfeng.gao@intel.com,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 0/2] nbcon locking issue with v6.6.10-rt18 kernel
Date: Tue, 23 Jan 2024 13:40:31 +0800
Message-Id: <20240123054033.183114-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two serial port devices in one Intel ADL hardware, one is 8250 lpss, another is 8250 dw. Multiple uart devices are enumerated as ttyS0, ttyS4, ttyS5,... With 6.6.10 rt18 kernel, booting hangs in nbcon_release if console is enabled by appending "console=ttySx,115200n8" to kernel command line. According to nbcon author John's suggestion, lock flag is moved from console structure to uart_port. Another patch is to add uart_is_nbcon checking in nbcon_release. 

Junxiao Chang (2):
  printk: nbcon: move locked_port flag to struct uart_port
  printk: nbcon: check uart port is nbcon or not in nbcon_release

 include/linux/console.h     |  2 --
 include/linux/serial_core.h |  1 +
 kernel/printk/nbcon.c       | 11 +++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.34.1


