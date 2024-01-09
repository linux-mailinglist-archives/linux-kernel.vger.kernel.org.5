Return-Path: <linux-kernel+bounces-21485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C5829010
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A711C24C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017C3E46E;
	Tue,  9 Jan 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANXWA5Y/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DD3E462
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704840390; x=1736376390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w6kupFrzbFpocVDLGUNde4MWMYhkpk7yL5N6258QRUQ=;
  b=ANXWA5Y/Wr3ZZeLXS1LV78YqUw++hAphWjKN/DwZDgDNsAB3LH5SF3dd
   cuiYaPYzNp5aCgNceyBa7G1ADz789l+24G9se4+0X0IUCS+2spaXObnjI
   Xyg5pvRGz9cn1B7DamKB2WLQxcPuUjCscTzSNxXRG6awu3kc6QysKGqO5
   ue9GRIov855/GoNrdko2CToHn7dnYHE032VYJxgVvXl9eGmUP0E7g9Ncq
   SaIUHmuczwjdOGkcFRzsQCObXY4tVq1cgt8JF6KiS9i0xKHkjpv3OptIk
   OO/3706EsceWB+i7kiePToOlhgsx3as6KKmkmHrLRO6XXgpZNu4FMh2bB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5116937"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5116937"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 14:46:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872397599"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="872397599"
Received: from rflores-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.229.33])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 14:46:29 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: lkp@intel.com,
	x86@kernel.org
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	rick.p.edgecombe@intel.com,
	yu-cheng.yu@intel.com
Subject: [PATCH] x86/shstk: Use __force when casting away __user
Date: Tue,  9 Jan 2024 14:46:19 -0800
Message-Id: <20240109224619.1013899-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202401080003.duO4RmjK-lkp@intel.com>
References: <202401080003.duO4RmjK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In setup_signal_shadow_stack() the kernel needs to push the restorer
address to the shadow stack. This involves writing the value of the
restorer pointer to the shadow stack. Since the restorer is defined as a
__user in struct k_sigaction, the __user needs to be casted away to read
the value. It is safe to do, because nothing is being dereferenced, and
the de-__user-ed value is not stashed in an accessible local variable
where it might accidentally be used for another purpose.

However, sparse warns about casting away __user. So use __force to
silence sparse and add a comment to explain why it is ok.

Fixes: 05e36022c054 ("x86/shstk: Handle signals for shadow stack")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401080003.duO4RmjK-lkp@intel.com/
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/shstk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 59e15dd8d0f8..7cc294482011 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -367,7 +367,11 @@ int setup_signal_shadow_stack(struct ksignal *ksig)
 
 	/* Push restorer address */
 	ssp -= SS_FRAME_SIZE;
-	err = write_user_shstk_64((u64 __user *)ssp, (u64)restorer);
+	/*
+	 * Use __force because this is just writing the address of the pointer
+	 * to the shadow stack, not dereferencing it.
+	 */
+	err = write_user_shstk_64((u64 __user *)ssp, (u64 __force)restorer);
 	if (unlikely(err))
 		return -EFAULT;
 
-- 
2.34.1


