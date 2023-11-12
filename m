Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD807E8EC6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjKLGTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjKLGSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:18:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE249D1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:18:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF689C433CC;
        Sun, 12 Nov 2023 06:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769898;
        bh=C5/JTwI5wb372y7wWIYf3dQ+SLZcZm+RSCZqId06nPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzxiUc/riiP4tMEJUwggD2u9mRqrLLZ41Aw67HFXqS1bHzAuFmeIH2H5OdveRi8cH
         5zztfx/t2iY6XV7eYL8QLHaXv5f+VLVEv0DQBpzv3fhdQ34oepKnhuUHQCRLTAAfmI
         BlXFjNTpR4nT0HBy8oRTm2UlXg1Lm37W6+Es2jfbgDfBCMc1rqNVmbOAc2iRrA8GrJ
         6R8wIWO+3OcjVbkakLgVpVjgClmWXdTeeqSpyTGCAbCoxFIQVQxFEwORvHlUkG+QQa
         oywT+nnivDrE06mlTpUBGGpGzGR1WmPvM77j7UI/6TmlIhpnpuKOcrEvU6Cvpr98bH
         HAReT157wq6iw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        LiaoShihua <shihua@iscas.ac.cn>
Subject: [RFC PATCH V2 28/38] riscv: s64ilp32: Temporary workaround solution to gcc problem
Date:   Sun, 12 Nov 2023 01:15:04 -0500
Message-Id: <20231112061514.2306187-29-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There is an existing problem in 64ilp32 gcc that combines two pointers
in one register. Liao is solving that problem. Before he finishes the
job, we could prevent it with a simple noinline attribute, fortunately.

struct path {
	struct vfsmount *mnt;
	struct dentry *dentry;
} __randomize_layout;

struct nameidata {
        struct path     path;
        struct qstr     last;
        struct path     root;
...
} __randomize_layout;

	struct nameidata *nd
	...
	nd->path = nd->root;
6c88                	ld	a0,24(s1)
				^^ // Wrong arg of mntget
e088                	sd	a0,0(s1)
	// Need inserting "lw a0,0(s1)" here
	mntget(path->mnt);
2a6150ef          	jal	c01ce946 <mntget>

Any gcc helps are welcome :)

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: LiaoShihua <shihua@iscas.ac.cn>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index e56ff39a79bc..1285736dadc4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -543,7 +543,7 @@ EXPORT_SYMBOL(inode_permission);
  *
  * Given a path increment the reference count to the dentry and the vfsmount.
  */
-void path_get(const struct path *path)
+void noinline path_get(const struct path *path)
 {
 	mntget(path->mnt);
 	dget(path->dentry);
-- 
2.36.1

