Return-Path: <linux-kernel+bounces-119940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4588CF21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756101C66FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E413E88D;
	Tue, 26 Mar 2024 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="YgWq3xjz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eAhZVZKe"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F913E40C;
	Tue, 26 Mar 2024 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485347; cv=none; b=dfI4xmFziNoy2523NMPgCt1A1jqvLZ+REhYpLiSy4225Lk02Pq0t5N5qOlcJ3iPNW4OabFwt0xXai1caT/10rafE5bU5m5xgqUe1KZ2sgFGoviTHfG0HKJtu/92jnuX3E9aR4t5DVL3RUExRV7+NQXTPLNi+05LAxdf7xozXhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485347; c=relaxed/simple;
	bh=irGpCozp/lilyVLox4eGShQhiRvynFL3bvQwuDsrmFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlfYsNSE6f7LT8suRTLWhqmeQq5gRaeTw17OozV9Xs5dOkvIHkfdthytAp8mNvIcLhOoZiFWgBoEUiW8QPwE1DFqw6HP2zTR7o3othGrYXUMmpcgUMpbWSVlky/y+nFygpPtmUv5qiYylMfgrr4a7GCgrCHz4I6oYqJT9KH1m5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=YgWq3xjz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eAhZVZKe; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 374C9138014C;
	Tue, 26 Mar 2024 16:35:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 26 Mar 2024 16:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485345;
	 x=1711571745; bh=HPssrUZACwtn3Nesp/zJ+D5cfkKN5v46jJVqYJYHcvc=; b=
	YgWq3xjzf1kpINprYpZpZx2FmXic0tivLPB+Ty+1yqL5ZMOlL41nA/sYIRn/45kM
	9CavWjtEUu8cQE7D8uht/tcgT8fuMd7+oyZAP2NceA5XJxdex2nGRXgNgZ2QUoIQ
	GSvOeYyYzT5oZTiDBR178abgHBqIYcKxDqHEBbFd7mGwSSsDbmsqXdG/yUHnxPRF
	TUdMPHPBh4uKepvdMdIxBgCK9HHJnOGUqkVH4XRGywedURAJuBuy5kf1moWugZA6
	x5fo64ZBXk8/uBVoT4ozE8CV6iAozbhYFkK2vzGrnZmL/JtlES2nDF1Iol+rWg7c
	HZjz+tzgFIthYY+PJK5D/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485345; x=
	1711571745; bh=HPssrUZACwtn3Nesp/zJ+D5cfkKN5v46jJVqYJYHcvc=; b=e
	AhZVZKeBCOb7OTl5sigfrh0UU8Cfu4RlGdAlZA0+1bVcPFR6DdQ+H1fiF5xyOiYE
	hQePqi4ywOLyAael/EZxxRA4wb9KXoSidgCrocOLMDf6qq1fIst+lkAOhx/8Igjw
	vtiTF5jeYnk8wH4TxFoF402WTxfNEbKd/qTKnlD2bknfuVTI+qVGA8nNjYDbYdC5
	CyRIUMWy377lMxSUxWMXSgp0furhuukgOfxRlxs7LwAu7ia9r7CBTCqczPNkh5Jn
	c5q3+2MTmgZ4OFpHWXqhr5FQANk34x0ssMjZDZE21QM4fXOqwEGZP2f+6i9pMZyp
	Snpw7YfZ9/ukz1vXoSMOA==
X-ME-Sender: <xms:oTEDZtkCqUlBkrMKh2ekI_viU__8iIo_CMPTp7TlFw7JcP1AKxlWIA>
    <xme:oTEDZo1Ih0vtol0rjSDbkG5dVF_qtw7w4w6FL1yc_kEHy_Dx69-KNqTAtDufVDLSN
    6rr5Bp0L00Idx0IUTs>
X-ME-Received: <xmr:oTEDZjrqJNPUks6KZ1Tp-34JX3DrK6-xpndnRRE6yYufkhwLarsIiFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedtvefhheeggfelieekudekhfegjeevledtudeltedtiefg
    leeggeduleelkeejvdenucffohhmrghinheptghpshdqvhgvtgdrshgsnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:oTEDZtlCg486Mmka1AvCwT1Usgn7fIzpWbMCjAqiI61bFIlt-0-zFw>
    <xmx:oTEDZr0wQhMF4AH7NP3sJ7eqcNEpTDx_HiQtaWQiuZfCuA7eqIAvEA>
    <xmx:oTEDZssqGwBOfOBCO6zTiAikVubIXkc-YY5rIsA4Bg1EZjiZ9zRcmg>
    <xmx:oTEDZvUrxWNYv8FlBtqKD8VIWUfEh8mxu2NUc02qtlO6MCrygpb4lw>
    <xmx:oTEDZr-Mfy8Uj5nn5rhndqSPHbJzDy2lY2Dbf-gWndUbGYCY2onw8w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:44 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 20:35:41 +0000
Subject: [PATCH v2 9/9] MIPS: CPS: Convert to use debug_ll facilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mips_debug_ll-v2-9-b64abc76f2a1@flygoat.com>
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
In-Reply-To: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4534;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=irGpCozp/lilyVLox4eGShQhiRvynFL3bvQwuDsrmFw=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5kn5J/fTmPT7TnP7Rw5aeOKt6n6Rte98hnmW7wyf
 rBh17zvHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjARZ12G//meXGfsJz2duKT6
 6mvvoMYJmXc1i8yNIgxL1k34/6DEhYuR4WKmsfnsI18CGPc+zP/IlhH5fkOS394k3ovJczgFU28
 mcAEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

debug_ll replaced CPS's custom NS16550 printing functions
for dump early SMP bring-up exceptions.

This will enable CPS debugging on more platforms and also
reduce code duplication.

All exception name strings are prefixed with CPS to help
identification with regular low-level interrupts.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig.debug    | 52 +++++++++-------------------------------------
 arch/mips/kernel/Makefile  |  1 -
 arch/mips/kernel/cps-vec.S | 16 +++++++-------
 3 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 0ce6d24d05b3..caba00cd8a33 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -96,48 +96,6 @@ config SCACHE_DEBUGFS
 
 	  If unsure, say N.
 
-menuconfig MIPS_CPS_NS16550_BOOL
-	bool "CPS SMP NS16550 UART output"
-	depends on MIPS_CPS
-	help
-	  Output debug information via an ns16550 compatible UART if exceptions
-	  occur early in the boot process of a secondary core.
-
-if MIPS_CPS_NS16550_BOOL
-
-config MIPS_CPS_NS16550
-	def_bool MIPS_CPS_NS16550_BASE != 0
-
-config MIPS_CPS_NS16550_BASE
-	hex "UART Base Address"
-	default 0x1b0003f8 if MIPS_MALTA
-	default 0
-	help
-	  The base address of the ns16550 compatible UART on which to output
-	  debug information from the early stages of core startup.
-
-	  This is only used if non-zero.
-
-config MIPS_CPS_NS16550_SHIFT
-	int "UART Register Shift"
-	default 0
-	help
-	  The number of bits to shift ns16550 register indices by in order to
-	  form their addresses. That is, log base 2 of the span between
-	  adjacent ns16550 registers in the system.
-
-config MIPS_CPS_NS16550_WIDTH
-	int "UART Register Width"
-	default 1
-	help
-	  ns16550 registers width. UART registers IO access methods will be
-	  selected in accordance with this parameter. By setting it to 1, 2 or
-	  4 UART registers will be accessed by means of lb/sb, lh/sh or lw/sw
-	  instructions respectively. Any value not from that set activates
-	  lb/sb instructions.
-
-endif # MIPS_CPS_NS16550_BOOL
-
 # These options are only for real kernel hackers who want to get their hands dirty.
 config DEBUG_LL
 	bool "Kernel low-level debugging functions (read help!)"
@@ -320,3 +278,13 @@ config DEBUG_ZBOOT_EXCEPT
 	  during decompression of a compressed kernel via the DEBUG_LL output.
 
 	  If unsure, say N.
+
+config DEBUG_CPS_EXCEPT
+	bool "Enable kernel debugging of Coherent Processing System exceptions"
+	depends on MIPS_CPS && DEBUG_LL_EXCEPT
+	help
+	  Say Y here if you want to enable debugging of exceptions happen
+	  during SMP bring-up stages on processors witn MIPS Coherent Processing
+	  System support.
+
+	  If unsure, say N.
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 6641c3370e68..94325c02cae2 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -59,7 +59,6 @@ obj-$(CONFIG_MIPS_MT)		+= mips-mt.o
 obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
-obj-$(CONFIG_MIPS_CPS_NS16550)	+= cps-vec-ns16550.o
 obj-$(CONFIG_MIPS_SPRAM)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index f876309130ad..49d682b3b49a 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -33,15 +33,15 @@
 # define STATUS_BITDEPS		0
 #endif
 
-#ifdef CONFIG_MIPS_CPS_NS16550
+#ifdef CONFIG_DEBUG_CPS_EXCEPT
 
 #define DUMP_EXCEP(name)		\
 	PTR_LA	a0, 8f;			\
-	jal	mips_cps_bev_dump;	\
+	jal	debug_ll_exception;	\
 	 nop;				\
 	TEXT(name)
 
-#else /* !CONFIG_MIPS_CPS_NS16550 */
+#else /* !CONFIG_DEBUG_CPS_EXCEPT */
 
 #define DUMP_EXCEP(name)
 
@@ -154,31 +154,31 @@ LEAF(mips_cps_core_boot)
 
 	__INIT
 LEAF(excep_tlbfill)
-	DUMP_EXCEP("TLB Fill")
+	DUMP_EXCEP("CPS - TLB Fill")
 	b	.
 	 nop
 	END(excep_tlbfill)
 
 LEAF(excep_xtlbfill)
-	DUMP_EXCEP("XTLB Fill")
+	DUMP_EXCEP("CPS - XTLB Fill")
 	b	.
 	 nop
 	END(excep_xtlbfill)
 
 LEAF(excep_cache)
-	DUMP_EXCEP("Cache")
+	DUMP_EXCEP("CPS - Cache")
 	b	.
 	 nop
 	END(excep_cache)
 
 LEAF(excep_genex)
-	DUMP_EXCEP("General")
+	DUMP_EXCEP("CPS - General")
 	b	.
 	 nop
 	END(excep_genex)
 
 LEAF(excep_intex)
-	DUMP_EXCEP("Interrupt")
+	DUMP_EXCEP("CPS - Interrupt")
 	b	.
 	 nop
 	END(excep_intex)

-- 
2.34.1


