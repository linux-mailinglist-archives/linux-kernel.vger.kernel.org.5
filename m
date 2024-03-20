Return-Path: <linux-kernel+bounces-109238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF588169C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539F21C23118
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2206A343;
	Wed, 20 Mar 2024 17:33:30 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3496A02D;
	Wed, 20 Mar 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956009; cv=none; b=Re5ooIzDdapeiOPrkmoQF7As7er5ftGRKCRkgljZCwQSVjsBXwnPaWGejjqTlmWFSkqZ1iALambOpkFcCsX4e/U+bx1vK5D6BuzgBUj3jDiPqF8dDVCa8224IASR1jPLzBUI2WMq3ypHlU3KvpWiO6mrIw4s7NU+HR4mRK9qmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956009; c=relaxed/simple;
	bh=EUOYGNXttkzKdXjPhe48wrwkyokl0sot/Y+oaH9w5nA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3DaLaES2FWi/Xbj33t3DsNKD5PcE35158dpZkv1k/KRZzkA1dvOf9FI7ZpRTMlRQkN6RKNNteaRHyRPEviUn+iwKhq4m8GGGjropqct1AipcymISewg6sZIJDRJHAi2Uv/wUuELL430DSTXE9Ddtt0d5Pg2d85mwMbEvHaYMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from evilbit.green-communications.fr ([85.168.41.102]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1MdNwm-1rDvpV1dC4-00ZNo3; Wed, 20 Mar 2024 18:19:33 +0100
From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: delay procfs initialization after the ipv6 structs are ready
Date: Wed, 20 Mar 2024 18:17:36 +0100
Message-ID: <20240320171858.2671-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W7bGElgtY1racbZYK0A81P9SmHNbbxTmpzpVf+L792+wus9po92
 ndmns0ZoGBaH3CSFs6v2SIhJebA21FIwfej1y/UxEnUmNKmA336stmKZZYIhjBK7/d39S1G
 kZK2cNd0HeFWPgRttNQvAEkeh0HAKFa5H2FvtZ/23g/su1uiKmrD9cy2RpzJ5+Q7RDhuqAP
 BYOYcao0uicIdBbTC8N2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l9SIw4i0dFo=;KcNnrIyPfojTsQpKr4XR27UL3GX
 ocnCMD2gKzAw5r9jZ9ksrzToBPlX413sRZnORfThi7OQirW9Z86nvO2yBLXH/u9gsb486xddB
 xRcP+3i40IM5DrpCkTAn59tQei4yJVYwCzuRZhG/OZi5OMQq82xpSHh7yhBM0uk0I/JcWbTLQ
 dzEJCWKIQ93er4Lbpi/Q/VNT4dIYiasoL1FRNJNERDq7HqbxcAk0vTEmBlVWItzmVJytArAJi
 Ph8NZsraUWvvWWBnzo9bFu00rKgeSErQ8pTdFKEo7x9NH6G6K/qb6ydxG7NfepjBi1BqX5Pp2
 CWjAQN4uFY1kucr6JdYlGBjhlrgoSSYhryX73glqZho4+mwfhpY7uOo7yD+EjaAEjl6pJGT8u
 r5+hoRFylJwSr9bMS79kCXXE9b3ldZBqFhmvkSMvpiJ2Qq+Zf7RD9TFH/ezcGdHsAP6+4qWSN
 zhFvPlItddRGgCiclKq/smt67sX4fJJ1ThthGmE99uRol/CrhXvGh1Yf5kZt1I5zvNO3HCO38
 LDKH3yeSeneLKzk6HArMYDrZuWBKf2WLNLaf7oAy+GfavBvcFIyFwOgX8rXcxsOhXdGBgFgok
 hyUv2p2UuxJMSul/j3RVclCUSIZfKUmXMyFxZpxxSVHGLT1GLuWAFk+yPVpVdtKTsHPJYOEoN
 c4+6DDZMHgR/2YJzGgTntDdLyxBD3prjfArKBdM2R+cOGW259Jd50r2/X1pPK/i5HkGki1HBE
 YBc4er7bhIn2ooVy9XpneJSLEyjc+c5T5DXIJ2Ldvvvdv9Db7aM7qU=

procfs files are created before the structure they reference are
initialized.  For example, if6_proc_init() creates procfs files that
access structures initialized by addrconf_init().

If ipv6 is compiled as a module and a program manages to open an ipv6
procfs file during the loading of the module, it can oops the kernel.

It appears that we were unlucky enough to reproduce this problem
multiple times already, out of maybe 100 boots:

NET: Registered PF_INET6 protocol family
8<--- cut here ---
pwm-backlight backlight: supply power not found, using dummy regulator
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
Unable to handle kernel NULL pointer dereference at virtual address
 00000000
mt7915e 0000:03:00.0 wlp3s0: renamed from wlan0
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in: ipv6 mt7915e mt76_connac_lib mt76 dw_hdmi_imx
 mac80211 dw_hdmi drm_display_helper imxdrm drm_dma_helper
 drm_kms_helper snd_soc_imx_sgtl5000 syscopyarea sysfillrect sysimgblt
 fb_sys_fops imx_ipu_v3 snd_soc_fsl_asoc_card cfg80211 snd_soc_sgtl5000
 drm libarc4 snd_soc_fsl_ssi snd_soc_simple_card_utils imx_pcm_dma
 snd_soc_core rfkill snd_pcm_dmaengine snd_pcm
 drm_panel_orientation_quirks cfbfillrect cfbimgblt cfbcopyarea
 snd_timer snd egalax_ts snd_soc_imx_audmux soundcore flexcan mux_mmio
 imx2_wdt mux_core can_dev pwm_bl
CPU: 2 PID: 850 Comm: snmpd Not tainted 6.1.14 #1
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
PC is at if6_seq_start+0x2c/0x98 [ipv6]
LR is at init_net+0x0/0xc00
[...]
 if6_seq_start [ipv6] from seq_read_iter+0xb4/0x510
 seq_read_iter from seq_read+0x80/0xac
 seq_read from proc_reg_read+0xac/0x100
 proc_reg_read from vfs_read+0xb0/0x284
 vfs_read from ksys_read+0x64/0xec
 ksys_read from ret_fast_syscall+0x0/0x54
Exception stack(0xf0e31fa8 to 0xf0e31ff0)
1fa0:                   b67fd0b0 be8a666b 0000000a b67fd148 00000400
 00000000
1fc0: b67fd0b0 be8a666b 00000001 00000003 be8a67ec 00000000 b6d7e000
 b6c9954a
1fe0: b6d7eb30 be8a6638 b6ef11b4 b6ef0ddc
Code: e5931004 e35100ff ca000014 e59e25dc (e7920101)
---[ end trace 0000000000000000 ]---

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 net/ipv6/af_inet6.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 8041dc181bd4..d12d690a4867 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1148,18 +1148,6 @@ static int __init inet6_init(void)
 	err = ipv6_netfilter_init();
 	if (err)
 		goto netfilter_fail;
-	/* Create /proc/foo6 entries. */
-#ifdef CONFIG_PROC_FS
-	err = -ENOMEM;
-	if (raw6_proc_init())
-		goto proc_raw6_fail;
-	if (udplite6_proc_init())
-		goto proc_udplite6_fail;
-	if (ipv6_misc_proc_init())
-		goto proc_misc6_fail;
-	if (if6_proc_init())
-		goto proc_if6_fail;
-#endif
 	err = ip6_route_init();
 	if (err)
 		goto ip6_route_fail;
@@ -1226,6 +1214,19 @@ static int __init inet6_init(void)
 	if (err)
 		goto ioam6_fail;
 
+	/* Create /proc/foo6 entries only after ipv6 structs are ready. */
+#ifdef CONFIG_PROC_FS
+	err = -ENOMEM;
+	if (raw6_proc_init())
+		goto proc_raw6_fail;
+	if (udplite6_proc_init())
+		goto proc_udplite6_fail;
+	if (ipv6_misc_proc_init())
+		goto proc_misc6_fail;
+	if (if6_proc_init())
+		goto proc_if6_fail;
+#endif
+
 	err = igmp6_late_init();
 	if (err)
 		goto igmp6_late_err;
@@ -1248,6 +1249,16 @@ static int __init inet6_init(void)
 	igmp6_late_cleanup();
 #endif
 igmp6_late_err:
+#ifdef CONFIG_PROC_FS
+	if6_proc_exit();
+proc_if6_fail:
+	ipv6_misc_proc_exit();
+proc_misc6_fail:
+	udplite6_proc_exit();
+proc_udplite6_fail:
+	raw6_proc_exit();
+proc_raw6_fail:
+#endif
 	ioam6_exit();
 ioam6_fail:
 	rpl_exit();
@@ -1282,16 +1293,6 @@ static int __init inet6_init(void)
 ndisc_late_fail:
 	ip6_route_cleanup();
 ip6_route_fail:
-#ifdef CONFIG_PROC_FS
-	if6_proc_exit();
-proc_if6_fail:
-	ipv6_misc_proc_exit();
-proc_misc6_fail:
-	udplite6_proc_exit();
-proc_udplite6_fail:
-	raw6_proc_exit();
-proc_raw6_fail:
-#endif
 	ipv6_netfilter_fini();
 netfilter_fail:
 	igmp6_cleanup();
-- 
2.43.0


