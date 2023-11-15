Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957FA7ED548
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbjKOVDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbjKOVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:02:54 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5382130
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:02:36 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BC29240E01AF;
        Wed, 15 Nov 2023 21:02:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mHJU0H3DineA; Wed, 15 Nov 2023 21:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700082151; bh=3Zj1K/YV21AvZ6fuUBCl+1nDUN1WETld0P94xKLMIH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNRJWwQeEYped26oTZHjoLsYED1w0pVeIts/4Zvqu660uL8H9K4fFqzq+BmoTlcXp
         gWhhvCO5MVsX8vLU1ZPkijBjvy1OA3W4pVN81KDw8dNr+aGWBkx0QSFD/+UsA1fslf
         kpWOgt/cMdeycC0JtSOzscTaeTwvZ9R87UDR9uEQXlNWbUcx+edsAivSorlk9Qg/Qs
         d8cSmjjNHV1Xx3TMEZ5zbbwPrB8zPIv3s+Gvudun4/rrcMX7hVe9rvfG8QlyK28HdR
         sgejrDpEo22++AKk9JarLWIUIPItdGAKAh5+BMATk38hSACFLcY+/u16POdPtbZO0H
         jQiVVpyWPcZuNF1iYQG1g4Tn6C4bXMxYdcp66Tr9L1et0wL0ALCscClfG4n/W2qjvW
         YnuKQD4kAG96/D0L12h8OIYFJD1yNlVWZtMA0nJClQ/IcO/WRSFi+fMFgD25TEXuCh
         RJHVoLcM5Qoiz0zIFW5YuG2OyCOyo1TgXXf9/yzLu3fBD/MYv7z0SKv3kZFGgq5oDB
         yOZTEKe1xFofC5bCtf1FQQDLqbxm6/UYBFPJKZK8J2aB1JGN+Yb3H0N/fkOLbFz4DW
         lcSFjg4+REk3tQYFKs/6JjQ+qILBbWLCtSDBSH14+52mab/zCqYQeH4fF1h5XUb2YV
         9NR0HkyRKmvCtn89wHy8NQg8=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90C9940E0199;
        Wed, 15 Nov 2023 21:02:28 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] x86/microcode: Rework early revisions reporting
Date:   Wed, 15 Nov 2023 22:02:12 +0100
Message-ID: <20231115210212.9981-3-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
In-Reply-To: <20231115210212.9981-1-bp@alien8.de>
References: <20231115210212.9981-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

The AMD side of the loader issues the microcode revision for each
logical thread on the system, which can become really noisy on huge
machines. And doing that doesn't make a whole lot of sense - the
microcode revision is already in /proc/cpuinfo.

So in case one is interested in the theoretical support of mixed silicon
steppings on AMD, one can check there.

What is also missing on the AMD side - something which people have
requested before - is showing the microcode revision the CPU had
*before* the early update.

So abstract that up in the main code and have the BSP on each vendor
provide those revision numbers.

Then, dump them only once on driver init.

On Intel, do not dump the patch date - it is not needed.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/CAHk-=3Dwg=3D%2B8rceshMkB4VnKxmRccVLtBLPB=
awnewZuuqyx5U=3D3A@mail.gmail.com
---
 arch/x86/kernel/cpu/microcode/amd.c      | 39 +++++++-----------------
 arch/x86/kernel/cpu/microcode/core.c     | 12 ++++++--
 arch/x86/kernel/cpu/microcode/intel.c    | 17 +++++------
 arch/x86/kernel/cpu/microcode/internal.h | 14 ++++++---
 4 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/mi=
crocode/amd.c
index 9373ec01c5ae..13b45b9c806d 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -104,8 +104,6 @@ struct cont_desc {
 	size_t		     size;
 };
=20
-static u32 ucode_new_rev;
-
 /*
  * Microcode patch container file is prepended to the initrd in cpio
  * format. See Documentation/arch/x86/microcode.rst
@@ -442,12 +440,11 @@ static int __apply_microcode_amd(struct microcode_a=
md *mc)
  *
  * Returns true if container found (sets @desc), false otherwise.
  */
-static bool early_apply_microcode(u32 cpuid_1_eax, void *ucode, size_t s=
ize)
+static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *uc=
ode, size_t size)
 {
 	struct cont_desc desc =3D { 0 };
 	struct microcode_amd *mc;
 	bool ret =3D false;
-	u32 rev, dummy;
=20
 	desc.cpuid_1_eax =3D cpuid_1_eax;
=20
@@ -457,22 +454,15 @@ static bool early_apply_microcode(u32 cpuid_1_eax, =
void *ucode, size_t size)
 	if (!mc)
 		return ret;
=20
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
 	/*
 	 * Allow application of the same revision to pick up SMT-specific
 	 * changes even if the revision of the other SMT thread is already
 	 * up-to-date.
 	 */
-	if (rev > mc->hdr.patch_id)
+	if (old_rev > mc->hdr.patch_id)
 		return ret;
=20
-	if (!__apply_microcode_amd(mc)) {
-		ucode_new_rev =3D mc->hdr.patch_id;
-		ret =3D true;
-	}
-
-	return ret;
+	return !__apply_microcode_amd(mc);
 }
=20
 static bool get_builtin_microcode(struct cpio_data *cp, unsigned int fam=
ily)
@@ -506,9 +496,12 @@ static void __init find_blobs_in_containers(unsigned=
 int cpuid_1_eax, struct cpi
 	*ret =3D cp;
 }
=20
-void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
+void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int =
cpuid_1_eax)
 {
 	struct cpio_data cp =3D { };
+	u32 dummy;
+
+	native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->old_rev, dummy);
=20
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig =3D cpuid_1_eax;
@@ -517,7 +510,8 @@ void __init load_ucode_amd_bsp(unsigned int cpuid_1_e=
ax)
 	if (!(cp.data && cp.size))
 		return;
=20
-	early_apply_microcode(cpuid_1_eax, cp.data, cp.size);
+	if (early_apply_microcode(cpuid_1_eax, ed->old_rev, cp.data, cp.size))
+		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
=20
 static enum ucode_state load_microcode_amd(u8 family, const u8 *data, si=
ze_t size);
@@ -625,10 +619,8 @@ void reload_ucode_amd(unsigned int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
=20
 	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc)) {
-			ucode_new_rev =3D mc->hdr.patch_id;
-			pr_info("reload patch_level=3D0x%08x\n", ucode_new_rev);
-		}
+		if (!__apply_microcode_amd(mc))
+			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
 	}
 }
=20
@@ -649,8 +641,6 @@ static int collect_cpu_info_amd(int cpu, struct cpu_s=
ignature *csig)
 	if (p && (p->patch_id =3D=3D csig->rev))
 		uci->mc =3D p->data;
=20
-	pr_info("CPU%d: patch_level=3D0x%08x\n", cpu, csig->rev);
-
 	return 0;
 }
=20
@@ -691,8 +681,6 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rev =3D mc_amd->hdr.patch_id;
 	ret =3D UCODE_UPDATED;
=20
-	pr_info("CPU%d: new patch_level=3D0x%08x\n", cpu, rev);
-
 out:
 	uci->cpu_sig.rev =3D rev;
 	c->microcode	 =3D rev;
@@ -935,11 +923,6 @@ struct microcode_ops * __init init_amd_microcode(voi=
d)
 		pr_warn("AMD CPU family 0x%x not supported\n", c->x86);
 		return NULL;
 	}
-
-	if (ucode_new_rev)
-		pr_info_once("microcode updated early to new patch_level=3D0x%08x\n",
-			     ucode_new_rev);
-
 	return &microcode_amd_ops;
 }
=20
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/m=
icrocode/core.c
index b4be3a2c79df..2eab4014ba02 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -75,6 +75,8 @@ static u32 final_levels[] =3D {
 	0, /* T-101 terminator */
 };
=20
+struct early_load_data early_data;
+
 /*
  * Check the current patch level on this CPU.
  *
@@ -153,9 +155,9 @@ void __init load_ucode_bsp(void)
 		return;
=20
 	if (intel)
-		load_ucode_intel_bsp();
+		load_ucode_intel_bsp(&early_data);
 	else
-		load_ucode_amd_bsp(cpuid_1_eax);
+		load_ucode_amd_bsp(&early_data, cpuid_1_eax);
 }
=20
 void load_ucode_ap(void)
@@ -826,6 +828,12 @@ static int __init microcode_init(void)
 	if (!microcode_ops)
 		return -ENODEV;
=20
+	pr_info_once("Current revision: 0x%08x\n", (early_data.new_rev ?: early=
_data.old_rev));
+
+	if (early_data.new_rev)
+		pr_info_once("Updated early from: 0x%08x\n",
+			     early_data.old_rev);
+
 	microcode_pdev =3D platform_device_register_simple("microcode", -1, NUL=
L, 0);
 	if (IS_ERR(microcode_pdev))
 		return PTR_ERR(microcode_pdev);
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/=
microcode/intel.c
index 6024feb98d29..070426b9895f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -339,16 +339,9 @@ static enum ucode_state __apply_microcode(struct uco=
de_cpu_info *uci,
 static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci=
)
 {
 	struct microcode_intel *mc =3D uci->mc;
-	enum ucode_state ret;
-	u32 cur_rev, date;
+	u32 cur_rev;
=20
-	ret =3D __apply_microcode(uci, mc, &cur_rev);
-	if (ret =3D=3D UCODE_UPDATED) {
-		date =3D mc->hdr.date;
-		pr_info_once("updated early: 0x%x -> 0x%x, date =3D %04x-%02x-%02x\n",
-			     cur_rev, mc->hdr.rev, date & 0xffff, date >> 24, (date >> 16) & =
0xff);
-	}
-	return ret;
+	return __apply_microcode(uci, mc, &cur_rev);
 }
=20
 static __init bool load_builtin_intel_microcode(struct cpio_data *cp)
@@ -413,13 +406,17 @@ static int __init save_builtin_microcode(void)
 early_initcall(save_builtin_microcode);
=20
 /* Load microcode on BSP from initrd or builtin blobs */
-void __init load_ucode_intel_bsp(void)
+void __init load_ucode_intel_bsp(struct early_load_data *ed)
 {
 	struct ucode_cpu_info uci;
=20
+	ed->old_rev =3D intel_get_microcode_revision();
+
 	uci.mc =3D get_microcode_blob(&uci, false);
 	if (uci.mc && apply_microcode_early(&uci) =3D=3D UCODE_UPDATED)
 		ucode_patch_va =3D UCODE_BSP_LOADED;
+
+	ed->new_rev =3D uci.cpu_sig.rev;
 }
=20
 void load_ucode_intel_ap(void)
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/c=
pu/microcode/internal.h
index f8047b12329a..21776c529fa9 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -37,6 +37,12 @@ struct microcode_ops {
 				use_nmi		: 1;
 };
=20
+struct early_load_data {
+	u32 old_rev;
+	u32 new_rev;
+};
+
+extern struct early_load_data early_data;
 extern struct ucode_cpu_info ucode_cpu_info[];
 struct cpio_data find_microcode_in_initrd(const char *path);
=20
@@ -92,14 +98,14 @@ extern bool dis_ucode_ldr;
 extern bool force_minrev;
=20
 #ifdef CONFIG_CPU_SUP_AMD
-void load_ucode_amd_bsp(unsigned int family);
+void load_ucode_amd_bsp(struct early_load_data *ed, unsigned int family)=
;
 void load_ucode_amd_ap(unsigned int family);
 int save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
 struct microcode_ops *init_amd_microcode(void);
 void exit_amd_microcode(void);
 #else /* CONFIG_CPU_SUP_AMD */
-static inline void load_ucode_amd_bsp(unsigned int family) { }
+static inline void load_ucode_amd_bsp(struct early_load_data *ed, unsign=
ed int family) { }
 static inline void load_ucode_amd_ap(unsigned int family) { }
 static inline int save_microcode_in_initrd_amd(unsigned int family) { re=
turn -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) { }
@@ -108,12 +114,12 @@ static inline void exit_amd_microcode(void) { }
 #endif /* !CONFIG_CPU_SUP_AMD */
=20
 #ifdef CONFIG_CPU_SUP_INTEL
-void load_ucode_intel_bsp(void);
+void load_ucode_intel_bsp(struct early_load_data *ed);
 void load_ucode_intel_ap(void);
 void reload_ucode_intel(void);
 struct microcode_ops *init_intel_microcode(void);
 #else /* CONFIG_CPU_SUP_INTEL */
-static inline void load_ucode_intel_bsp(void) { }
+static inline void load_ucode_intel_bsp(struct early_load_data *ed) { }
 static inline void load_ucode_intel_ap(void) { }
 static inline void reload_ucode_intel(void) { }
 static inline struct microcode_ops *init_intel_microcode(void) { return =
NULL; }
--=20
2.42.0.rc0.25.ga82fb66fed25

