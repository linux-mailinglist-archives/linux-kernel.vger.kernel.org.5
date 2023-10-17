Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB37CC2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjJQMSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjJQMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFEC13D;
        Tue, 17 Oct 2023 05:18:03 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:18:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697545081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzzxsCCtkfqVr1CXVRHwouIo2pCpN1B6+HJFXxuoKUA=;
        b=LP+6TKAlgtVM28Ji9tlNm/hxpxuMClDRIclTVTkJnZD3uSRCMhuG80yjZRbvv+HQXKKwcy
        EgKWsGLFxSun7OjVwTxrsPzkDzwCxrGA5MdbWWLialGsbMTQoFwxjyDEeBOy4uzo2M8CaA
        rZI2wbjDvncgbzB36+/ZoFdgjvqw1F+NSTUBUXM+YtKU7i0a7JgzINCH+AQWoZiQrDv9kN
        21U/FWtKJX88D0NUuYFp733h2+ckj1mFbGRAhnQgu3FXbszrBWXmPx5BzHY5fHbtPBLSo/
        AVJqOvLlIz5+f/+7QT0QuqSjQ5zSZYjLDQwrI4w5mdwtlCjrM5Sax8OShpQhbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697545081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzzxsCCtkfqVr1CXVRHwouIo2pCpN1B6+HJFXxuoKUA=;
        b=4kWgW6g5wCFnHsMBN5W1BEPIWYu6aNHPIHk7X7I32kPodvEJ+XJDQZ4SkKnK5GYRulqERQ
        WhByhRcwiQdOysBQ==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Unwind properly from rdt_enable_ctx()
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Newman <peternewman@google.com>,
        Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        ilpo.jarvinen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017002308.134480-5-babu.moger@amd.com>
References: <20231017002308.134480-5-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <169754508099.3135.17094712952428311617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     df5f3a1dd8a6d3ddb1f07a10817f735194717422
Gitweb:        https://git.kernel.org/tip/df5f3a1dd8a6d3ddb1f07a10817f7351947=
17422
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 16 Oct 2023 19:23:03 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 12:49:02 +02:00

x86/resctrl: Unwind properly from rdt_enable_ctx()

rdt_enable_ctx() enables the features provided during resctrl mount.

Additions to rdt_enable_ctx() are required to also modify error paths
of rdt_enable_ctx() callers to ensure correct unwinding if errors
are encountered after calling rdt_enable_ctx(). This is error prone.

Introduce rdt_disable_ctx() to refactor the error unwinding of
rdt_enable_ctx() to simplify future additions. This also simplifies
cleanup in rdt_kill_sb().

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Link: https://lore.kernel.org/r/20231017002308.134480-5-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 +++++++++++++++----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index 125d12d..d1b5fd7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2308,14 +2308,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_leve=
l l, bool enable)
 	return 0;
 }
=20
-static void cdp_disable_all(void)
-{
-	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
-		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
-	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
-		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
-}
-
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
@@ -2395,19 +2387,42 @@ static int mkdir_mondata_all(struct kernfs_node *pare=
nt_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **mon_data_kn);
=20
+static void rdt_disable_ctx(void)
+{
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+	set_mba_sc(false);
+}
+
 static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 {
 	int ret =3D 0;
=20
-	if (ctx->enable_cdpl2)
+	if (ctx->enable_cdpl2) {
 		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
+		if (ret)
+			goto out_done;
+	}
=20
-	if (!ret && ctx->enable_cdpl3)
+	if (ctx->enable_cdpl3) {
 		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
+		if (ret)
+			goto out_cdpl2;
+	}
=20
-	if (!ret && ctx->enable_mba_mbps)
+	if (ctx->enable_mba_mbps) {
 		ret =3D set_mba_sc(true);
+		if (ret)
+			goto out_cdpl3;
+	}
+
+	return 0;
=20
+out_cdpl3:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+out_cdpl2:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+out_done:
 	return ret;
 }
=20
@@ -2515,13 +2530,13 @@ static int rdt_get_tree(struct fs_context *fc)
 	}
=20
 	ret =3D rdt_enable_ctx(ctx);
-	if (ret < 0)
-		goto out_cdp;
+	if (ret)
+		goto out;
=20
 	ret =3D schemata_list_create();
 	if (ret) {
 		schemata_list_destroy();
-		goto out_mba;
+		goto out_ctx;
 	}
=20
 	closid_init();
@@ -2580,11 +2595,8 @@ out_info:
 	kernfs_remove(kn_info);
 out_schemata_free:
 	schemata_list_destroy();
-out_mba:
-	if (ctx->enable_mba_mbps)
-		set_mba_sc(false);
-out_cdp:
-	cdp_disable_all();
+out_ctx:
+	rdt_disable_ctx();
 out:
 	rdt_last_cmd_clear();
 	mutex_unlock(&rdtgroup_mutex);
@@ -2816,12 +2828,11 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
=20
-	set_mba_sc(false);
+	rdt_disable_ctx();
=20
 	/*Put everything back to default values. */
 	for_each_alloc_capable_rdt_resource(r)
 		reset_all_ctrls(r);
-	cdp_disable_all();
 	rmdir_all_sub();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;
