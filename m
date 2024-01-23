Return-Path: <linux-kernel+bounces-35263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C75838ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6775B214A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563B5EE81;
	Tue, 23 Jan 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpDqB7LQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F35EE6C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014341; cv=none; b=c0HfXDm1HBEPayEGxWxnVXbA7s7Gp7PdaQxFjSZhiw9TMeCZpLk3OVyk9roCWouaWJvK+80wsSvcosIY/PdqE9TubYOqG+MvctIKPYkHHVdLx2mtwPo5TK/E5tFrG9o9AzseiLtE1ier4ls9XPr0x7ScoD1g/bOeCPc5qoOFEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014341; c=relaxed/simple;
	bh=9Doj/gTHL3//w2tFAh8hYikUi4bc/x4E4gubWtQZ8Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQAEHU/OCjgzq69vi6FpyjsNaiwc6J2MHXLXjx3y/9MqxVyG52ScDwHVrBWD6+YI7yU6dyX+IRf/iritudMy7oNkIxIW8SO1M0YcgD0YPmaqZsHrwt6HcxbB0YBPP0Zi5bduA1vQG2CFHVjUB1oYOUwkQzbcHSR4oJ5YWT2a2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpDqB7LQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4379C433C7;
	Tue, 23 Jan 2024 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706014341;
	bh=9Doj/gTHL3//w2tFAh8hYikUi4bc/x4E4gubWtQZ8Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CpDqB7LQEcEuqa3niaxIcL4o90Q2HZw/Qz+VvkXmKqwkUbR25SECSEOScNiTct7cM
	 JjYPbk6SY8uN82M9ZYOUV+Dk6xaMl9H58VuOwLr+67E0ZD8F0N8WS7s7XqUBWUQoDA
	 sM/3vhbNNmzC8rhwQyQu6ZR6QZiyKvEenBOO6kawF3P/ftzR4TYoQRpWIU4OZKd6Tq
	 oKvROao5yTDUILfHMF3skeTus0E6DPY7I5iY+H14RUjmt9dkoLvLwMzsmPXeKsaYjJ
	 bLOImNkIChGVw1fAFNWZoxI6SfbZbiWPfnAmcnuypYvOpqGZTSrdl1zJupVXs6Ogks
	 wZo4JgrJK4Lgw==
From: Arnd Bergmann <arnd@kernel.org>
To: Scott Wood <oss@buserror.net>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: 85xx: mark local functions static
Date: Tue, 23 Jan 2024 13:51:42 +0100
Message-Id: <20240123125148.2004648-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123125148.2004648-1-arnd@kernel.org>
References: <20240123125148.2004648-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

These functions are either used in only one file and can just be
makde static or need an #include statement to avoid a warning:

arch/powerpc/platforms/85xx/mpc8536_ds.c:30:13: error: no previous prototype for 'mpc8536_ds_pic_init' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/p1010rdb.c:27:13: error: no previous prototype for 'p1010_rdb_pic_init' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/p1022_ds.c:373:6: error: no previous prototype for 'p1022ds_set_pixel_clock' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/p1022_ds.c:422:1: error: no previous prototype for 'p1022ds_valid_monitor_port' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/p1022_ds.c:435:13: error: no previous prototype for 'p1022_ds_pic_init' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/p1022_rdk.c:43:6: error: no previous prototype for 'p1022rdk_set_pixel_clock' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/p1022_rdk.c:92:1: error: no previous prototype for 'p1022rdk_valid_monitor_port' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/p1022_rdk.c:99:13: error: no previous prototype for 'p1022_rdk_pic_init' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/socrates_fpga_pic.c:273:13: error: no previous prototype for 'socrates_fpga_pic_init' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/xes_mpc85xx.c:40:13: error: no previous prototype for 'xes_mpc85xx_pic_init' [-Werror=missing-prototypes]
arch/powerpc/platforms/85xx/mvme2500.c:24:13: error: no previous prototype for 'mvme2500_pic_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/85xx/mpc8536_ds.c        | 2 +-
 arch/powerpc/platforms/85xx/mvme2500.c          | 2 +-
 arch/powerpc/platforms/85xx/p1010rdb.c          | 2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c          | 6 +++---
 arch/powerpc/platforms/85xx/p1022_rdk.c         | 6 +++---
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c | 2 ++
 arch/powerpc/platforms/85xx/xes_mpc85xx.c       | 2 +-
 7 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index e966b2ad8ecd..b3327a358eb4 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -27,7 +27,7 @@
 
 #include "mpc85xx.h"
 
-void __init mpc8536_ds_pic_init(void)
+static void __init mpc8536_ds_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
diff --git a/arch/powerpc/platforms/85xx/mvme2500.c b/arch/powerpc/platforms/85xx/mvme2500.c
index 1b59e45a0c64..19122daadb55 100644
--- a/arch/powerpc/platforms/85xx/mvme2500.c
+++ b/arch/powerpc/platforms/85xx/mvme2500.c
@@ -21,7 +21,7 @@
 
 #include "mpc85xx.h"
 
-void __init mvme2500_pic_init(void)
+static void __init mvme2500_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0,
 		  MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU,
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 10d6f1fa3327..491895ac8bcf 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -24,7 +24,7 @@
 
 #include "mpc85xx.h"
 
-void __init p1010_rdb_pic_init(void)
+static void __init p1010_rdb_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
 	  MPIC_SINGLE_DEST_CPU,
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 0dd786a061a6..adc3a2ee1415 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -370,7 +370,7 @@ static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
  *
  * @pixclock: the wavelength, in picoseconds, of the clock
  */
-void p1022ds_set_pixel_clock(unsigned int pixclock)
+static void p1022ds_set_pixel_clock(unsigned int pixclock)
 {
 	struct device_node *guts_np = NULL;
 	struct ccsr_guts __iomem *guts;
@@ -418,7 +418,7 @@ void p1022ds_set_pixel_clock(unsigned int pixclock)
 /**
  * p1022ds_valid_monitor_port: set the monitor port for sysfs
  */
-enum fsl_diu_monitor_port
+static enum fsl_diu_monitor_port
 p1022ds_valid_monitor_port(enum fsl_diu_monitor_port port)
 {
 	switch (port) {
@@ -432,7 +432,7 @@ p1022ds_valid_monitor_port(enum fsl_diu_monitor_port port)
 
 #endif
 
-void __init p1022_ds_pic_init(void)
+static void __init p1022_ds_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
 		MPIC_SINGLE_DEST_CPU,
diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
index 25ab6e9c1470..6198299d95b1 100644
--- a/arch/powerpc/platforms/85xx/p1022_rdk.c
+++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
@@ -40,7 +40,7 @@
  *
  * @pixclock: the wavelength, in picoseconds, of the clock
  */
-void p1022rdk_set_pixel_clock(unsigned int pixclock)
+static void p1022rdk_set_pixel_clock(unsigned int pixclock)
 {
 	struct device_node *guts_np = NULL;
 	struct ccsr_guts __iomem *guts;
@@ -88,7 +88,7 @@ void p1022rdk_set_pixel_clock(unsigned int pixclock)
 /**
  * p1022rdk_valid_monitor_port: set the monitor port for sysfs
  */
-enum fsl_diu_monitor_port
+static enum fsl_diu_monitor_port
 p1022rdk_valid_monitor_port(enum fsl_diu_monitor_port port)
 {
 	return FSL_DIU_PORT_DVI;
@@ -96,7 +96,7 @@ p1022rdk_valid_monitor_port(enum fsl_diu_monitor_port port)
 
 #endif
 
-void __init p1022_rdk_pic_init(void)
+static void __init p1022_rdk_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
 		MPIC_SINGLE_DEST_CPU,
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index baa12eff6d5d..60e0b8947ce6 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -8,6 +8,8 @@
 #include <linux/of_irq.h>
 #include <linux/io.h>
 
+#include "socrates_fpga_pic.h"
+
 /*
  * The FPGA supports 9 interrupt sources, which can be routed to 3
  * interrupt request lines of the MPIC. The line to be used can be
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 45f257fc1ade..2582427d8d01 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -37,7 +37,7 @@
 #define MPC85xx_L2CTL_L2I		0x40000000 /* L2 flash invalidate */
 #define MPC85xx_L2CTL_L2SIZ_MASK	0x30000000 /* L2 SRAM size (R/O) */
 
-void __init xes_mpc85xx_pic_init(void)
+static void __init xes_mpc85xx_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN,
 			0, 256, " OpenPIC  ");
-- 
2.39.2


