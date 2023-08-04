Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1776FB89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjHDH67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjHDH65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:58:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B73D1702
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:58:56 -0700 (PDT)
Date:   Fri, 4 Aug 2023 09:58:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691135934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6FKEDuzMKNNLeZG2jeuUZN+W0ab8lNF9LA6bdXeiC8=;
        b=TTaIxnY+P1/OgI3xSNhMJQqXKdtkCIpjiPmGRBvtIBkuE3gcqdrZKvrDEh17IODdfGx+Qg
        WIyo0QwtyOfFsSZYrQlcVKDnwGtsmt8uYQMz5fGSXB8ZAY/mRRrNmtJFVpkaPIpfTC+OIk
        wXdEZUKzTb/zsCAIzEaxjMd+NHq8AIi//mQM+/Ltbk6COGVOz3KMlPi/CME8dHyUh/2pzx
        1Ogg6nxHoRWoYUSF551Scmy4eOHXFKbn+5AZV15aGd9tOEGpRClutO7fZt9hb5gO9b4zi+
        z8V6nehdwS0Da4xkervOfpTwU3/JrUNti5CJnDnWTwt2Sg97jhVRepBDFRBSpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691135934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6FKEDuzMKNNLeZG2jeuUZN+W0ab8lNF9LA6bdXeiC8=;
        b=+LYWqR9TRuZsy6j42SuBFKiTnxdywdtKQzM2ELnLZpEgH23jtWWQl4PWyr98g69a7vd3x5
        2kv1fwf1s1V6/dBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] x86/microcode: Remove microcode_mutex.
Message-ID: <20230804075853.JF_n6GXC@linutronix.de>
References: <20230803083253.VGMnC9Gd@linutronix.de>
 <7f31f938-cd4f-bb1b-d44d-57adabf62c51@intel.com>
 <20230804075504.MxYvbNle@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230804075504.MxYvbNle@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

microcode_mutex is only used by reload_store(). It has a comment saying
"to synchronize with each other". Other user of this mutex have been
removed in the commits
	181b6f40e9ea8 ("x86/microcode: Rip out the OLD_INTERFACE").
	b6f86689d5b74 ("x86/microcode: Rip out the subsys interface gunk")

The sysfs interface does not need additional synchronisation vs itself
because it is provided as kernfs_ops::mutex which is acquired in
kernfs_fop_write_iter().

Remove superfluous microcode_mutex.

Link: https://lore.kernel.org/r/20230803083253.VGMnC9Gd@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v1=E2=80=A6v2:
  - Add another commit to the commit description which removed another
    user. Suggested by Sohil Mehta.
  - Also update the comment in microcode_check(). Suggested by Sohil
    Mehta.

 arch/x86/kernel/cpu/common.c         | 3 +--
 arch/x86/kernel/cpu/microcode/core.c | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0ba1067f4e5f1..de49b9cd8077a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2276,8 +2276,7 @@ void store_cpu_caps(struct cpuinfo_x86 *curr_info)
  * @prev_info:	CPU capabilities stored before an update.
  *
  * The microcode loader calls this upon late microcode load to recheck fea=
tures,
- * only when microcode has been updated. Caller holds microcode_mutex and =
CPU
- * hotplug lock.
+ * only when microcode has been updated. Caller holds and CPU hotplug lock.
  *
  * Return: None
  */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/mic=
rocode/core.c
index 3afcf3de0dd49..2f9d35744bc41 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -54,15 +54,12 @@ LIST_HEAD(microcode_cache);
  *
  * All non cpu-hotplug-callback call sites use:
  *
- * - microcode_mutex to synchronize with each other;
  * - cpus_read_lock/unlock() to synchronize with
  *   the cpu-hotplug-callback call sites.
  *
  * We guarantee that only a single cpu is being
  * updated at any particular moment of time.
  */
-static DEFINE_MUTEX(microcode_mutex);
-
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
=20
 struct cpu_info_ctx {
@@ -488,10 +485,7 @@ static ssize_t reload_store(struct device *dev,
 	if (tmp_ret !=3D UCODE_NEW)
 		goto put;
=20
-	mutex_lock(&microcode_mutex);
 	ret =3D microcode_reload_late();
-	mutex_unlock(&microcode_mutex);
-
 put:
 	cpus_read_unlock();
=20
--=20
2.40.1

