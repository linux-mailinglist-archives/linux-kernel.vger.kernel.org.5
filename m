Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44787CC2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjJQMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjJQMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:18:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789C0195;
        Tue, 17 Oct 2023 05:18:00 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:17:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697545079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmcQE5lRmLwcJo5cQwSR++3r6UQhsrhv/OAurZwBPg0=;
        b=sXkO+DS7ApDqGac3QgVoQWgzhfMsbE/c+Z1hFv4XDBHaF1XQrXjBDx00ouCpgRCoUQytf3
        dOtfF3qbW7fM6JcVB5ysamsObIdD7FLOhXLNaSaWyaPxa17dZ4F5vaSEBfvcmLcrHLYenT
        gZ9uJukmZNkaNmou4i8ZicfsFZYWuH1ySBHWE5JoGb9q3xi1FbD+Iefo2eRgqHXFFJMtj4
        ZsviT/BD/rfgO9MTXPCyWwZ1ZqnNrAVzxjNNF6v3GEKGLC/G1YxnzMleCgZg6dptf5Ojrh
        w68aE0ZKwqvgjMSna47BHODpINIVqHhJpC2n5OPSs+7O5Lpnp+IEoV/D6L6AFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697545079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmcQE5lRmLwcJo5cQwSR++3r6UQhsrhv/OAurZwBPg0=;
        b=cYBm75hFY1fLrsgQzBO66saFQq1lO6QP/vgsFWqx7bHhQFRPdMoAigWCTjW2HUk+KtubPR
        HaX2j48GosKtfxAg==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add support for the files of MON groups only
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Newman <peternewman@google.com>,
        Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        ilpo.jarvinen@linux.intel.com,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017002308.134480-9-babu.moger@amd.com>
References: <20231017002308.134480-9-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <169754507834.3135.8385571109591338616.tip-bot2@tip-bot2>
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

Commit-ID:     918f211b5e4e709e91acf856967a850569c96b71
Gitweb:        https://git.kernel.org/tip/918f211b5e4e709e91acf856967a850569c=
96b71
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 16 Oct 2023 19:23:07 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 14:05:24 +02:00

x86/resctrl: Add support for the files of MON groups only

Files unique to monitoring groups have the RFTYPE_MON flag. When a new
monitoring group is created the resctrl files with flags RFTYPE_BASE
(files common to all resource groups) and RFTYPE_MON (files unique to
monitoring groups) are created to support interacting with the new
monitoring group.

A resource group can support both monitoring and control, also termed
a CTRL_MON resource group. CTRL_MON groups should get both monitoring
and control resctrl files but that is not the case. Only the
RFTYPE_BASE and RFTYPE_CTRL files are created for CTRL_MON groups.

Ensure that files with the RFTYPE_MON flag are created for CTRL_MON groups.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Peter Newman <peternewman@google.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Link: https://lore.kernel.org/r/20231017002308.134480-9-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index 5814a0b..5f6d6ba 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2551,6 +2551,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
+	unsigned long flags =3D RFTYPE_CTRL_BASE;
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	int ret;
@@ -2581,7 +2582,10 @@ static int rdt_get_tree(struct fs_context *fc)
=20
 	closid_init();
=20
-	ret =3D rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
+	if (rdt_mon_capable)
+		flags |=3D RFTYPE_MON;
+
+	ret =3D rdtgroup_add_files(rdtgroup_default.kn, flags);
 	if (ret)
 		goto out_schemata_free;
=20
@@ -3271,8 +3275,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent=
_kn,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
 {
 	struct rdtgroup *prdtgrp, *rdtgrp;
+	unsigned long files =3D 0;
 	struct kernfs_node *kn;
-	uint files =3D 0;
 	int ret;
=20
 	prdtgrp =3D rdtgroup_kn_lock_live(parent_kn);
@@ -3324,10 +3328,13 @@ static int mkdir_rdt_prepare(struct kernfs_node *pare=
nt_kn,
 		goto out_destroy;
 	}
=20
-	if (rtype =3D=3D RDTCTRL_GROUP)
+	if (rtype =3D=3D RDTCTRL_GROUP) {
 		files =3D RFTYPE_BASE | RFTYPE_CTRL;
-	else
+		if (rdt_mon_capable)
+			files |=3D RFTYPE_MON;
+	} else {
 		files =3D RFTYPE_BASE | RFTYPE_MON;
+	}
=20
 	ret =3D rdtgroup_add_files(kn, files);
 	if (ret) {
