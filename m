Return-Path: <linux-kernel+bounces-167356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B48BA866
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BF0282EA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4AC14EC7A;
	Fri,  3 May 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUkgCLib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AD14EC5E;
	Fri,  3 May 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723937; cv=none; b=czm4cCNhiqdlbcNELpt4rrGFwXUMDmcDopHMCRqmG07cuqeCnN9qk+SU0TLP4YZsxDoC5uVDdBWhz1vhodozCIzW6nzFc1SEASIsoANu49FLRPwpqre7c2f8RyRRKLVrT5YFim7La5Awok09Sk729Zgm+qbspGA1uQX1U+QZWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723937; c=relaxed/simple;
	bh=RytdZHmYvHip2W4dxB0Jwgs5syvGgFQXYO0pQDh3dkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+K3ig63JDc+DInjQpJTuStkm9+6Lq+S3jJE5iQxdk5A6A+oz3/UwvR7IpTyViH8zjFP5yUTJewKtbqtCvHrmg2/2XeY9td/yNckVD9lzQrmt9D9hCvsVsAqVW9Fs6DrDBjiqM+dohT0zIT5ABL8hCklbKOAdvCJnpuSguGYSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUkgCLib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01A5C4AF18;
	Fri,  3 May 2024 08:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723937;
	bh=RytdZHmYvHip2W4dxB0Jwgs5syvGgFQXYO0pQDh3dkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUkgCLibJmcIOxxisMKrkL2Zvo/7en8jAYthv3g5iCCp5HJeObcZ94jHz6vDUWvV3
	 aJe0JoB3BWbMz11QdE35FaxK+CzGPR90p0ID+xs2IxbbQ45aN8OdNrC5bF+liH+xQL
	 vrZxA0lrfMuC2zEGwEJ+cyhatCbhI7QDqPZDwCNMRPFVYprjpwArgFePeZ9YIM13+p
	 YaCtXmks62t6tdEoSMAyNwSTqRrZaFjpItEwDuT2Nt2YDQajLm1Fo7hqwdxshgjjgF
	 979w0vF+jwYlAMpF8nQ16/bnxSJVhvUVi+V3kMCtQU6uDx0+i0kGy9uvTffBKbBNMJ
	 Xy9PkPFF7eKGA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] alpha: don't make functions public without a reason
Date: Fri,  3 May 2024 10:11:15 +0200
Message-Id: <20240503081125.67990-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

if it's really used only inside the same source file, make it
static...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/core_cia.c      | 6 +++---
 arch/alpha/kernel/core_marvel.c   | 2 +-
 arch/alpha/kernel/core_wildfire.c | 8 ++++----
 arch/alpha/kernel/perf_event.c    | 2 +-
 arch/alpha/kernel/smc37c669.c     | 4 +++-
 arch/alpha/kernel/sys_nautilus.c  | 6 +++---
 arch/alpha/kernel/sys_sio.c       | 2 +-
 drivers/char/agp/alpha-agp.c      | 2 +-
 8 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/kernel/core_cia.c b/arch/alpha/kernel/core_cia.c
index 12926e9538b8..ca3d9c732b61 100644
--- a/arch/alpha/kernel/core_cia.c
+++ b/arch/alpha/kernel/core_cia.c
@@ -280,7 +280,7 @@ cia_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
 #define CIA_BROKEN_TBIA_SIZE	1024
 
 /* Always called with interrupts disabled */
-void
+static void
 cia_pci_tbi_try2(struct pci_controller *hose,
 		 dma_addr_t start, dma_addr_t end)
 {
@@ -576,7 +576,7 @@ struct
     } window[4];
 } saved_config __attribute((common));
 
-void
+static void
 cia_save_srm_settings(int is_pyxis)
 {
 	int i;
@@ -602,7 +602,7 @@ cia_save_srm_settings(int is_pyxis)
 	mb();
 }
 
-void
+static void
 cia_restore_srm_settings(void)
 {
 	int i;
diff --git a/arch/alpha/kernel/core_marvel.c b/arch/alpha/kernel/core_marvel.c
index e9348aec4649..b22248044bf0 100644
--- a/arch/alpha/kernel/core_marvel.c
+++ b/arch/alpha/kernel/core_marvel.c
@@ -355,7 +355,7 @@ marvel_init_io7(struct io7 *io7)
 	}
 }
 
-void __init
+static void __init
 marvel_io7_present(gct6_node *node)
 {
 	int pe;
diff --git a/arch/alpha/kernel/core_wildfire.c b/arch/alpha/kernel/core_wildfire.c
index 3a804b67f9da..8dd08c5e4270 100644
--- a/arch/alpha/kernel/core_wildfire.c
+++ b/arch/alpha/kernel/core_wildfire.c
@@ -59,7 +59,7 @@ unsigned long wildfire_pca_mask;
 unsigned long wildfire_cpu_mask;
 unsigned long wildfire_mem_mask;
 
-void __init
+static void __init
 wildfire_init_hose(int qbbno, int hoseno)
 {
 	struct pci_controller *hose;
@@ -137,7 +137,7 @@ wildfire_init_hose(int qbbno, int hoseno)
 	wildfire_pci_tbi(hose, 0, 0); /* Flush TLB at the end. */
 }
 
-void __init
+static void __init
 wildfire_init_pca(int qbbno, int pcano)
 {
 
@@ -154,7 +154,7 @@ wildfire_init_pca(int qbbno, int pcano)
 	wildfire_init_hose(qbbno, (pcano << 1) + 1);
 }
 
-void __init
+static void __init
 wildfire_init_qbb(int qbbno)
 {
 	int pcano;
@@ -176,7 +176,7 @@ wildfire_init_qbb(int qbbno)
 	}
 }
 
-void __init
+static void __init
 wildfire_hardware_probe(void)
 {
 	unsigned long temp;
diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index ccdb508c1516..1f0eb4f25c0f 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -870,7 +870,7 @@ static void alpha_perf_event_irq_handler(unsigned long la_ptr,
 /*
  * Init call to initialise performance events at kernel startup.
  */
-int __init init_hw_perf_events(void)
+static int __init init_hw_perf_events(void)
 {
 	pr_info("Performance events: ");
 
diff --git a/arch/alpha/kernel/smc37c669.c b/arch/alpha/kernel/smc37c669.c
index bbbd34586de0..cb8726b667da 100644
--- a/arch/alpha/kernel/smc37c669.c
+++ b/arch/alpha/kernel/smc37c669.c
@@ -2430,13 +2430,15 @@ int __init smcc669_write( struct FILE *fp, int size, int number, unsigned char *
 }
 #endif
 
-void __init
+#if SMC_DEBUG
+static void __init
 SMC37c669_dump_registers(void)
 {
   int i;
   for (i = 0; i <= 0x29; i++)
     printk("-- CR%02x : %02x\n", i, SMC37c669_read_config(i));
 }
+#endif
 /*+
  * ============================================================================
  * = SMC_init - SMC37c669 Super I/O controller initialization                 =
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 96fd6ff3fe81..4dcee81606a5 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -78,7 +78,7 @@ nautilus_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-void
+static void
 nautilus_kill_arch(int mode)
 {
 	struct pci_bus *bus = pci_isa_hose->bus;
@@ -127,7 +127,7 @@ naut_sys_machine_check(unsigned long vector, unsigned long la_ptr,
 /* Machine checks can come from two sources - those on the CPU and those
    in the system.  They are analysed separately but all starts here.  */
 
-void
+static void
 nautilus_machine_check(unsigned long vector, unsigned long la_ptr)
 {
 	char *mchk_class;
@@ -197,7 +197,7 @@ static struct resource busn_resource = {
 	.flags	= IORESOURCE_BUS,
 };
 
-void __init
+static void __init
 nautilus_init_pci(void)
 {
 	struct pci_controller *hose = hose_head;
diff --git a/arch/alpha/kernel/sys_sio.c b/arch/alpha/kernel/sys_sio.c
index 086488ed83a7..0bf38f868665 100644
--- a/arch/alpha/kernel/sys_sio.c
+++ b/arch/alpha/kernel/sys_sio.c
@@ -310,7 +310,7 @@ alphabook1_init_pci(void)
 	outb(0x0f, 0x3ce); outb(orig, 0x3cf); /* (re)lock PR0-4 */
 }
 
-void
+static void
 sio_kill_arch(int mode)
 {
 #if defined(ALPHA_RESTORE_SRM_SETUP)
diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index c9bf2c219841..f0d0c044731c 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -149,7 +149,7 @@ struct agp_bridge_driver alpha_core_agp_driver = {
 
 struct agp_bridge_data *alpha_bridge;
 
-int __init
+static int __init
 alpha_core_agp_setup(void)
 {
 	alpha_agp_info *agp = alpha_mv.agp_info();
-- 
2.39.2


