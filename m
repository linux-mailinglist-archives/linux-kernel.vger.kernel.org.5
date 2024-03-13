Return-Path: <linux-kernel+bounces-102439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EA287B2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C749AB35A31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9946537;
	Wed, 13 Mar 2024 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AhEPFmqR"
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249AE53381
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358373; cv=none; b=ch1SvZnD7ITGY2Ywk+8pkmnUNlHFLCU19UV15ne3XjhhmsoadX7r3GDuN6nHXoBeLto2qdO7aVrBwktRZwP4a1Fe/QthCJoIT3UpueBkHRE9yMso7OVF7F7kwI58xn9G87R6cnYZMD4J3TmgSX8MNrEv8fVXkwPzVseWuVRZ6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358373; c=relaxed/simple;
	bh=JGXVK2CH/5bQ9QjZde7FyAWyXXE+Eqg5hpWGv9A8m/E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZPKHegtB7Z1tgIIbsSZv5bhzqyC+nm1xJbmaD3GoIDTf19GOIKUXEIB5zVSmbHhYLPR5koVyM4rz1yuO+cR4LnsddjnmfEVG3BEvxmW8yVSEeHsu/MxXYPxpXALKAYSQ4lHnLVuttgreJFGQJ6Iw94OU/manChVtZT/vQruKMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AhEPFmqR; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710358363; bh=cUdH/mnS3ww+3Y+DLTMPILz1eZnkRASZI1DJ8bqh3Ls=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=AhEPFmqRXTWHgvlyY/Hc7N/IxdJElt5llgOQEmSQA8/tUgG3TpQk+CedoQW1/WnZahZXTmulYq0NE3IIYG++fIn6NMnk3GB8OEOG+dKIXahNPyKUmF8wg4/+7PVwEchjOYz8OxxRoydJDuNxQKxo+Siquil1jpjrl88zWXQ16CIdQwIjO18ljowhQm8ni2Z5JJFtGou+PrKv01us95oHKACUlX2Lhu3HafkH5Ujr0kzBNR0dPmT2AaBCLKXB52a2DePsgMjJcCZQ45dwXw0v+2okJGa26lAISoQs56tJA0Tnav4E2kpNDbXgHDPSUyI0g/y6ol+ccQr/pO2bStrfVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710358363; bh=wi9K1BpKCy58m2eQSYBrtceMays3ZINgOjwfzUF49IS=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=gD6ALuYnOIUMqUTxkpepyKRgy4U11oTmjkF29RyCPRj0nVsSg8jgs+BZ42SOKLY1MVy1c5hZpkmBwmYHeCYwviitHZ/IkK2DFRg8pOVdKeNG0vuRM0M53JXZTzXEnKFSlsBJFIP6vx8q/sv66qchV5Hz7rVXceG3iffmWV1pdDObldgOisTAFK1xu/Y/3bDt9vbCM77Qq/MVXNDiHtAIJTnakM55ilJeVSoaERDCTcJweIWy1VAyPs0HjOq1zJGg9djLmVTrpiI2BgXDiSDjnnb0iQkFtoRVijxeq2bbkoxRnvzOheIuP1fPtCvITrpM3xTZGHzURxh9i/LHr7ikhg==
X-YMail-OSG: ZcjUV7YVM1mPk9u8n4Q2KQVV5WzVEqLhgoyNpREllwBh0TRUQVuYvxOUI2G96vd
 c5otlUkeqLqmGHLXHsdW7AfXJlCc.7nBiv69RiO.bJTRIWQLC_SCU2kGIeVbln7yHXpEGoWIX.J2
 V9UEYj5nh3rjWh85mHK3bbQpfnj7ZtbSPlTXYmm7fgR3De9Tn6Z_L1zlovq_Pa3eOYYx3wG5XMI_
 7hEhvVd0ho5koQacrxNgy3xdIvQyWoK46NLPpcQur_leyxxyB6XmsSF0s.9XmiCFr2KiaXUP8xf4
 .s7ASKMLCSq5C0WwX3HbyKjQjax2mGlhuc_gdjzbrqCJBZ2smyyMDVP5TLjpFI4IbaEtGA8BrUgQ
 dPpURkA3yieRcbfsHjI4RWfCWpjSIF0BdmcukCSVcCATl0nDLBRADvbiDj_jQ_TQX_XrJ2Vdfi23
 _FAinE0fmpNdGs6wJtikdT4THwRfglTnJ6EhLXuhhfVbvY36UUhW.PmyNe0ru16QlkqIVgssXqUP
 JTaBFBnfHkkhoVKLVqR.z.RGLoVjpcAlRhDNhioB2Dk1xHlHLEXkEocbUgfGgsNSZa3Awb.dtisJ
 _pqaqr1t43_2i9zFuvCSn.VIOlVsv6PByk2.6UsDD2J1xOUb17Aov3k20prgIh.YMcG_890FYeKS
 ywNQ5mTwxdCZHa1mgnh0pAZngfj9eUd7kabNRF1UqVcvrdmcs7f6cKcMCg0SBOZZPS7jeycGZ5Kk
 g4t9DyReuohGEl4J3kgT.h5.bkQ.mLy7ZxBp6p3yKdx30_XjWQNRJc3lEF5CvcWZ0HTDhqv6BRP0
 xW_OtI31y6bdwxEQGhVIINUvvyomIsdxxSpI5dL27Zjgi_Fw2r.Ze85Tmlp.2lwCU3Tm5hHm65uK
 CSpYLWlY7r.5noO394GZ3xWvwkozkgIK9LanePXAUYePUFJS7CVMoKqlrijbKaQBgZYBsifXTrs0
 jTqGEo_DrvzcJiS3CPZMisMETmwTd6.mzNXZazNHWgHfFU_P1AKmMDtCaP03g49onuVnIc_EFrS6
 aLK4LHtzmkKcAwt03iNhcmsJZvXpV_rif_k6KZjeax8pn2En1ET9DmWGdlTryrS0OV2azaiNqJ.a
 ttWDDsbzPFmL5_5JdusWXf2x9OKKT1HSa51IXhkgnugi9ePJY.EKV69uvIFf9batWVmg.058daDB
 mTCVf8WY7t8iF_uXh3gZtCUdm1OzYyrTq7Z1UAH1mspcXGjMVxqfZyWRf82QHoDZkpwc0KLPOTRB
 vC31T1KL8ahUemDpXgqCSFX5Bx_xOHEFaDZEIrZ_vgoAlIfesMYr33DOMQD8a3.GQ.JMf4pOah_x
 IE4fgET_2PvJSpD.41xYRjnjprw8dJN5p3jd29HdDDfkBiaIPVYUscWCE9S3wY2tH0UdJfd_3AxQ
 zrwTv69Gf8EM9x9w63Xz9sQ.ctddZC5x2z83pASPCfe5B.5g2kwl54kENLfXgnaYEbIzlNyQ4mK8
 OX6ij4Tai4z2a_J_RONJGAJYTOBB37hSOajz0ECaQF0R0dw09Zp5XeY03AIEqYfYbJn2oG8i0MBU
 sno_1ccTIBQ5PLwKU6_o3Kq8yWxsNY7wxFPy2j81j_a.BGMHkRY3m68chnYT9YfoUcNsTqzwh.P0
 zBHvXjDZIP_V021vrjRxGaU9UY0HzmHVuVx8s8HgLlBllafBwFRuZwHqdaIn_GU7PaQmG_MALwKV
 _IzUvlW_kjxSYkAfHtVbTVUTvTFwwiHS9xX5sEbrO5i6O.E6U00PNBAMeQKTY8JRrjKDJCSMcJvb
 ED2BcqA_WG6K7JD6DeOZT9nG1zPegl6BT.CesA2W_DQ95z1OzyEeLLeHBIEXubsJAThY5ezdSrcX
 zNtHNz2P3AIVqhLzceRdW6eTNJayVf50x7b8B5foH2Zhi_NC49KQTNwooGzlh_QR.Qgpb4C1Uyo1
 eCBcjKRXq.O_pN_FRRdIohpxAPaVMXh5NSW_m9WUTcjg.LrFfZsFw4GErTi0GWo.hasdCSDPcdZO
 M_fVst0WcVHAxyDl3j3dxp6knW.xNlHA7ZzjO9jTl5vuzf81t83c4kWeALZAqC7ddyhrwut9Jr17
 XuS5UxqEczgZwBgu2CQRHiQa3yKr3LI3hJzf4nGwAwUcW.FYTqyo_x8wjkHDcypZHJvmsiOtkNB4
 7leawIJ3s2RPbJmWyRTLdXBJa8UP0fx.JvK_n2uaH9j1NffOPNAsylMIEu3UEbDvUl1iGjA1F7Nl
 MH1XZOPMhSo5dcwNKzRpdDjsgJzjDGFrmWwBihBCheIKicyIKl2reSFjcF49sk17NEN3C4R9WoMT
 C0.uIbig2D6bEE5cBYMs3sQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ba54dfa9-94eb-4ba3-9d52-356ea51f6229
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Mar 2024 19:32:43 +0000
Received: by hermes--production-gq1-5c57879fdf-llxbt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a6b0be8cb46521c77fae42ada2855ce7;
          Wed, 13 Mar 2024 19:32:38 +0000 (UTC)
Message-ID: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>
Date: Wed, 13 Mar 2024 12:32:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v3] LSM: use 32 bit compatible data types in LSM syscalls.
To: "Dmitry V. Levin" <ldv@strace.io>, Paul Moore <paul@paul-moore.com>,
 LSM List <linux-security-module@vger.kernel.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 linux-api@vger.kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, James Morris <jmorris@namei.org>,
 Serge Hallyn <serge@hallyn.com>, John Johansen
 <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <00734a64-a5fe-420c-bf6e-bee27c9d83be.ref@schaufler-ca.com>
Content-Language: en-US
In-Reply-To: <00734a64-a5fe-420c-bf6e-bee27c9d83be.ref@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

LSM: use 32 bit compatible data types in LSM syscalls.

Change the size parameters in lsm_list_modules(), lsm_set_self_attr()
and lsm_get_self_attr() from size_t to u32. This avoids the need to
have different interfaces for 32 and 64 bit systems.

Cc: stable@vger.kernel.org
Fixes: a04a1198088a: ("LSM: syscalls for current process attributes")
Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h                        |  4 ++--
 include/linux/security.h                             |  8 ++++----
 security/apparmor/lsm.c                              |  4 ++--
 security/lsm_syscalls.c                              | 10 +++++-----
 security/security.c                                  | 12 ++++++------
 security/selinux/hooks.c                             |  4 ++--
 security/smack/smack_lsm.c                           |  4 ++--
 tools/testing/selftests/lsm/common.h                 |  6 +++---
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++-----
 tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
 11 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..f9b5baf1b5f4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -265,9 +265,9 @@ LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
 LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
-	 struct lsm_ctx __user *ctx, size_t *size, u32 flags)
+	 struct lsm_ctx __user *ctx, u32 *size, u32 flags)
 LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
-	 struct lsm_ctx *ctx, size_t size, u32 flags)
+	 struct lsm_ctx *ctx, u32 size, u32 flags)
 LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
 LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..3180d823e023 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -478,9 +478,9 @@ int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			 size_t __user *size, u32 flags);
+			 u32 __user *size, u32 flags);
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			 size_t size, u32 flags);
+			 u32 size, u32 flags);
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
@@ -494,7 +494,7 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
-int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
+int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
@@ -1434,7 +1434,7 @@ static inline int security_locked_down(enum lockdown_reason what)
 	return 0;
 }
 static inline int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,
-				    size_t *uctx_len, void *val, size_t val_len,
+				    u32 *uctx_len, void *val, size_t val_len,
 				    u64 id, u64 flags)
 {
 	return -EOPNOTSUPP;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9a3dcaafb5b1..cef8c466af80 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -779,7 +779,7 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
 }
 
 static int apparmor_getselfattr(unsigned int attr, struct lsm_ctx __user *lx,
-				size_t *size, u32 flags)
+				u32 *size, u32 flags)
 {
 	int error = -ENOENT;
 	struct aa_task_ctx *ctx = task_ctx(current);
@@ -924,7 +924,7 @@ static int do_setattr(u64 attr, void *value, size_t size)
 }
 
 static int apparmor_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
-				size_t size, u32 flags)
+				u32 size, u32 flags)
 {
 	int rc;
 
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 5d391b1f7e69..8440948a690c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -53,7 +53,7 @@ u64 lsm_name_to_attr(const char *name)
  * value indicating the reason for the error is returned.
  */
 SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
-		ctx, size_t, size, u32, flags)
+		ctx, u32, size, u32, flags)
 {
 	return security_setselfattr(attr, ctx, size, flags);
 }
@@ -75,7 +75,7 @@ SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
  * a negative value indicating the error is returned.
  */
 SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
-		ctx, size_t __user *, size, u32, flags)
+		ctx, u32 __user *, size, u32, flags)
 {
 	return security_getselfattr(attr, ctx, size, flags);
 }
@@ -93,11 +93,11 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
  * required size. In all other cases a negative value indicating the
  * error is returned.
  */
-SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
+SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
 		u32, flags)
 {
-	size_t total_size = lsm_active_cnt * sizeof(*ids);
-	size_t usize;
+	u32 total_size = lsm_active_cnt * sizeof(*ids);
+	u32 usize;
 	int i;
 
 	if (flags)
diff --git a/security/security.c b/security/security.c
index 7035ee35a393..fb7505c73485 100644
--- a/security/security.c
+++ b/security/security.c
@@ -785,7 +785,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
  * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
  * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
  */
-int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
+int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len,
 		      u64 id, u64 flags)
 {
@@ -3918,14 +3918,14 @@ EXPORT_SYMBOL(security_d_instantiate);
  * If @size is insufficient to contain the data -E2BIG is returned.
  */
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
-			 size_t __user *size, u32 flags)
+			 u32 __user *size, u32 flags)
 {
 	struct security_hook_list *hp;
 	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
 	u8 __user *base = (u8 __user *)uctx;
-	size_t total = 0;
-	size_t entrysize;
-	size_t left;
+	u32 entrysize;
+	u32 total = 0;
+	u32 left;
 	bool toobig = false;
 	bool single = false;
 	int count = 0;
@@ -4011,7 +4011,7 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
  * LSM specific failure.
  */
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
-			 size_t size, u32 flags)
+			 u32 size, u32 flags)
 {
 	struct security_hook_list *hp;
 	struct lsm_ctx *lctx;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 338b023a8c3e..71e6e7079d7f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6556,7 +6556,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
  * There will only ever be one attribute.
  */
 static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			       size_t *size, u32 flags)
+			       u32 *size, u32 flags)
 {
 	int rc;
 	char *val = NULL;
@@ -6571,7 +6571,7 @@ static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
 }
 
 static int selinux_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
-			       size_t size, u32 flags)
+			       u32 size, u32 flags)
 {
 	int rc;
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0fdbf04cc258..0891fcc11e40 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3641,7 +3641,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
  * There will only ever be one attribute.
  */
 static int smack_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			     size_t *size, u32 flags)
+			     u32 *size, u32 flags)
 {
 	int rc;
 	struct smack_known *skp;
@@ -3762,7 +3762,7 @@ static int do_setattr(u64 attr, void *value, size_t size)
  * Returns 0 on success, an error code otherwise.
  */
 static int smack_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
-			     size_t size, u32 flags)
+			     u32 size, u32 flags)
 {
 	int rc;
 
diff --git a/tools/testing/selftests/lsm/common.h b/tools/testing/selftests/lsm/common.h
index d404329e5eeb..06d12110d241 100644
--- a/tools/testing/selftests/lsm/common.h
+++ b/tools/testing/selftests/lsm/common.h
@@ -7,7 +7,7 @@
 
 #ifndef lsm_get_self_attr
 static inline int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
-				    size_t *size, __u32 flags)
+				    __u32 *size, __u32 flags)
 {
 	return syscall(__NR_lsm_get_self_attr, attr, ctx, size, flags);
 }
@@ -15,14 +15,14 @@ static inline int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 
 #ifndef lsm_set_self_attr
 static inline int lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
-				    size_t size, __u32 flags)
+				    __u32 size, __u32 flags)
 {
 	return syscall(__NR_lsm_set_self_attr, attr, ctx, size, flags);
 }
 #endif
 
 #ifndef lsm_list_modules
-static inline int lsm_list_modules(__u64 *ids, size_t *size, __u32 flags)
+static inline int lsm_list_modules(__u64 *ids, __u32 *size, __u32 flags)
 {
 	return syscall(__NR_lsm_list_modules, ids, size, flags);
 }
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
index e0e313d9047a..df215e4aa63f 100644
--- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -40,7 +40,7 @@ TEST(size_null_lsm_get_self_attr)
 TEST(ctx_null_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u32 size = page_size;
 	int rc;
 
 	rc = lsm_get_self_attr(LSM_ATTR_CURRENT, NULL, &size, 0);
@@ -57,7 +57,7 @@ TEST(size_too_small_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size = 1;
+	__u32 size = 1;
 
 	ASSERT_NE(NULL, ctx);
 	errno = 0;
@@ -77,7 +77,7 @@ TEST(flags_zero_lsm_get_self_attr)
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
 	__u64 *syscall_lsms = calloc(page_size, 1);
-	size_t size;
+	__u32 size;
 	int lsmcount;
 	int i;
 
@@ -117,7 +117,7 @@ TEST(flags_overset_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size;
+	__u32 size;
 
 	ASSERT_NE(NULL, ctx);
 
@@ -140,7 +140,7 @@ TEST(flags_overset_lsm_get_self_attr)
 TEST(basic_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u32 size = page_size;
 	struct lsm_ctx *ctx = calloc(page_size, 1);
 	struct lsm_ctx *tctx = NULL;
 	__u64 *syscall_lsms = calloc(page_size, 1);
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
index 9df29b1e3497..868641dbb309 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -31,7 +31,7 @@ TEST(size_null_lsm_list_modules)
 TEST(ids_null_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u32 size = page_size;
 
 	errno = 0;
 	ASSERT_EQ(-1, lsm_list_modules(NULL, &size, 0));
@@ -43,7 +43,7 @@ TEST(size_too_small_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	__u64 *syscall_lsms = calloc(page_size, 1);
-	size_t size = 1;
+	__u32 size = 1;
 
 	ASSERT_NE(NULL, syscall_lsms);
 	errno = 0;
@@ -58,7 +58,7 @@ TEST(flags_set_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	__u64 *syscall_lsms = calloc(page_size, 1);
-	size_t size = page_size;
+	__u32 size = page_size;
 
 	ASSERT_NE(NULL, syscall_lsms);
 	errno = 0;
@@ -72,7 +72,7 @@ TEST(flags_set_lsm_list_modules)
 TEST(correct_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u32 size = page_size;
 	__u64 *syscall_lsms = calloc(page_size, 1);
 	char *sysfs_lsms = calloc(page_size, 1);
 	char *name;
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
index e9712c6cf596..66dec47e3ca3 100644
--- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -25,7 +25,7 @@ TEST(size_too_small_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size = page_size;
+	__u32 size = page_size;
 
 	ASSERT_NE(NULL, ctx);
 	if (attr_lsm_count()) {
@@ -41,7 +41,7 @@ TEST(flags_zero_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size = page_size;
+	__u32 size = page_size;
 
 	ASSERT_NE(NULL, ctx);
 	if (attr_lsm_count()) {
@@ -57,7 +57,7 @@ TEST(flags_overset_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	char *ctx = calloc(page_size, 1);
-	size_t size = page_size;
+	__u32 size = page_size;
 	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
 
 	ASSERT_NE(NULL, ctx);


