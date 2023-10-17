Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B347CC2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjJQMSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjJQMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720312B;
        Tue, 17 Oct 2023 05:18:02 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:18:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697545081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lW6h5HaP2T0hEUSDnlfNN9p2vJFFaQe5q8jVPY53xY=;
        b=ZgDC/U5lRRmoxD6MCITCKxehp5YrirlkrgETdF9fsAsL9Qz7ynqqNcNWBLATtY6Rx1mGKo
        OsJYOJLkiAS6s96HewgXqHnzSJxicNLAaBlJ3eE1Jany+4c6s7R5Z7LnrcYp7535dF4+9d
        ro29yWILcNRkeSFZbyad/W0ugruzwkDxhkI+XJWxFXqXa2/VNhIxbCKZODN662QQ0CpnpP
        pno+Ttu0N/meCxfuiPDKTLPF8huoEQENVrtkpNfYme2EDKY4xwfTK5Wzl7GU6NE17wL7HC
        lLVXM7nkuCCfUpCZEEkIfJeKvC3lrb7hpqhgKxvOXk+4BxILmUPC8dNqNvrqqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697545081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lW6h5HaP2T0hEUSDnlfNN9p2vJFFaQe5q8jVPY53xY=;
        b=2M9tqUtG9R6lhOR8xd6w11ZbISQ2cfzhER+9R6wVPsdSx56D9yK30MvWmiY/tinVF+J+qy
        adz4PVwvOFh7tWBA==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move default group file creation to mount
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Newman <peternewman@google.com>,
        Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        ilpo.jarvinen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017002308.134480-6-babu.moger@amd.com>
References: <20231017002308.134480-6-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <169754508033.3135.12802577163859081206.tip-bot2@tip-bot2>
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

Commit-ID:     d27567a0eb54be457b25e240593fdbd1c35c8618
Gitweb:        https://git.kernel.org/tip/d27567a0eb54be457b25e240593fdbd1c35=
c8618
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 16 Oct 2023 19:23:04 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 12:50:53 +02:00

x86/resctrl: Move default group file creation to mount

The default resource group and its files are created during kernel init
time. Upcoming changes will make some resctrl files optional based on
a mount parameter. If optional files are to be added to the default
group based on the mount option, then each new file needs to be created
separately and call kernfs_activate() again.

Create all files of the default resource group during resctrl mount,
destroyed during unmount, to avoid scattering resctrl file addition
across two separate code flows.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Link: https://lore.kernel.org/r/20231017002308.134480-6-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 58 ++++++++++++++-----------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index d1b5fd7..55da93b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -54,6 +54,9 @@ static struct kernfs_node *kn_mondata;
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
=20
+static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
+static void rdtgroup_destroy_root(void);
+
 struct dentry *debugfs_resctrl;
=20
 void rdt_last_cmd_clear(void)
@@ -2529,10 +2532,14 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out;
 	}
=20
-	ret =3D rdt_enable_ctx(ctx);
+	ret =3D rdtgroup_setup_root(ctx);
 	if (ret)
 		goto out;
=20
+	ret =3D rdt_enable_ctx(ctx);
+	if (ret)
+		goto out_root;
+
 	ret =3D schemata_list_create();
 	if (ret) {
 		schemata_list_destroy();
@@ -2541,6 +2548,12 @@ static int rdt_get_tree(struct fs_context *fc)
=20
 	closid_init();
=20
+	ret =3D rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
+	if (ret)
+		goto out_schemata_free;
+
+	kernfs_activate(rdtgroup_default.kn);
+
 	ret =3D rdtgroup_create_info_dir(rdtgroup_default.kn);
 	if (ret < 0)
 		goto out_schemata_free;
@@ -2597,6 +2610,8 @@ out_schemata_free:
 	schemata_list_destroy();
 out_ctx:
 	rdt_disable_ctx();
+out_root:
+	rdtgroup_destroy_root();
 out:
 	rdt_last_cmd_clear();
 	mutex_unlock(&rdtgroup_mutex);
@@ -2667,7 +2682,6 @@ static int rdt_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
=20
-	ctx->kfc.root =3D rdt_root;
 	ctx->kfc.magic =3D RDTGROUP_SUPER_MAGIC;
 	fc->fs_private =3D &ctx->kfc;
 	fc->ops =3D &rdt_fs_context_ops;
@@ -2837,6 +2851,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;
 	schemata_list_destroy();
+	rdtgroup_destroy_root();
 	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
@@ -3718,10 +3733,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_o=
ps =3D {
 	.show_options	=3D rdtgroup_show_options,
 };
=20
-static int __init rdtgroup_setup_root(void)
+static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
 {
-	int ret;
-
 	rdt_root =3D kernfs_create_root(&rdtgroup_kf_syscall_ops,
 				      KERNFS_ROOT_CREATE_DEACTIVATED |
 				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
@@ -3729,6 +3742,20 @@ static int __init rdtgroup_setup_root(void)
 	if (IS_ERR(rdt_root))
 		return PTR_ERR(rdt_root);
=20
+	ctx->kfc.root =3D rdt_root;
+	rdtgroup_default.kn =3D kernfs_root_to_node(rdt_root);
+
+	return 0;
+}
+
+static void rdtgroup_destroy_root(void)
+{
+	kernfs_destroy_root(rdt_root);
+	rdtgroup_default.kn =3D NULL;
+}
+
+static void __init rdtgroup_setup_default(void)
+{
 	mutex_lock(&rdtgroup_mutex);
=20
 	rdtgroup_default.closid =3D 0;
@@ -3738,19 +3765,7 @@ static int __init rdtgroup_setup_root(void)
=20
 	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
=20
-	ret =3D rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
-	if (ret) {
-		kernfs_destroy_root(rdt_root);
-		goto out;
-	}
-
-	rdtgroup_default.kn =3D kernfs_root_to_node(rdt_root);
-	kernfs_activate(rdtgroup_default.kn);
-
-out:
 	mutex_unlock(&rdtgroup_mutex);
-
-	return ret;
 }
=20
 static void domain_destroy_mon_state(struct rdt_domain *d)
@@ -3872,13 +3887,11 @@ int __init rdtgroup_init(void)
 	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
 		     sizeof(last_cmd_status_buf));
=20
-	ret =3D rdtgroup_setup_root();
-	if (ret)
-		return ret;
+	rdtgroup_setup_default();
=20
 	ret =3D sysfs_create_mount_point(fs_kobj, "resctrl");
 	if (ret)
-		goto cleanup_root;
+		return ret;
=20
 	ret =3D register_filesystem(&rdt_fs_type);
 	if (ret)
@@ -3911,8 +3924,6 @@ int __init rdtgroup_init(void)
=20
 cleanup_mountpoint:
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-cleanup_root:
-	kernfs_destroy_root(rdt_root);
=20
 	return ret;
 }
@@ -3922,5 +3933,4 @@ void __exit rdtgroup_exit(void)
 	debugfs_remove_recursive(debugfs_resctrl);
 	unregister_filesystem(&rdt_fs_type);
 	sysfs_remove_mount_point(fs_kobj, "resctrl");
-	kernfs_destroy_root(rdt_root);
 }
