Return-Path: <linux-kernel+bounces-100857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7C0879E43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511602840BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A5F14375F;
	Tue, 12 Mar 2024 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Rd5jfqxL"
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993D143C4D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281639; cv=none; b=ILVQOr9zIqHHJpCBhEa2l1kZs8mLPtncEuEkBcWPsRYJGgb7CRQ16bxoky3CHZBd2kho50zIGKOqNslh0iu7lJva013LDZVfXQJvn0HK6nV/sesTCC76FliRkTPjlIoj3IhcsHHQY9KMyEX83gSTOlEMcxcx+9MWnrbaNBWoK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281639; c=relaxed/simple;
	bh=fs/NVySv0/zFbXC8d/Uii9GD/vXrMvpB9JCTh9QPGro=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=klH+0LEq9gZXu784AWnuxZKahg3Pv7IFpkarJIAksLWJ1kqb79TnqXAMePOzPgfQiDSAMsQJ2RyavzGogMoLKvWdpL40RQ3f2YmJTlWWKxCyODscE0R/alvJjJXvulgS5uC5GwebqBPwhOpIqZHXQXA9JPW0fQgYDyxI9bVmdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Rd5jfqxL; arc=none smtp.client-ip=66.163.191.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710281631; bh=SkgzDSeZw/3dL/2QTpQ0//8+wr7IucOMz8AgktOlwuw=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=Rd5jfqxLnJPKJzWvq7WvmfF24lUkq8zHnVFK/m+42DVIQ2tTclnZ0scr4BRGDPRL9DQvC5xwwVqsw5DzrHuVOIiYY3SIFh8qHOE4d8E+ZrQri4ZzZT61i135xfAKFEKHTr2kS/sznfedA/Tap0Tbu1KTmQItz43w2Xus7jnebzZRdE91gThy956pnVR7I81E9ckpQ20+v/byVc6BLwZjJLcB5I9yI7gwX9S6RB6X31InrReIpfHiDie/55VKbLtGTbBwnIk43gCcKN8jra5GQglHdL1AftaMYA3lBMnitOuGdfvIekFf23zQPmfNq7UZiQdbh/9LOyOK8BAZ5wtOTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710281631; bh=GoquhIfjCWqhtiNVfTdpq3Vvy0rallbYGHPpYxOWwDr=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=MXjx5Hl1GDLIkwyMVRVhR/YGtbRjH7aO/6QeJbl2vjLHiqgauzjuKzvZHVG9CQTvoDP8CDtVSuNkGMjWDTF4KfBEGyWBK3hIUnDKqWaQ4jU7pIOv2YPQnAey09hv3xU/IldCDe9QNDgvU7SRJwL7myM9JaNKH9Uu0+p4IZ8ZFc2xToIKlkns4WruBxHIxYeU0PeMSewAi+pmgzT7CDopv1Aw7WnnnuROIgexLshmBvdGmYJcS098iN/V3UZmyjC5drk39sm70SVZ2S/tAXeUs6GOKxwgO9LPPQJnu6zGbYijKqZmhGYM+NRAn+stX7uJhhpnReaZA5TIFOHvCObVYA==
X-YMail-OSG: eIi0th8VM1ne1o.w2gM61zP8bBsn1D7wDxhzb.bgMN_eCnhbPnIkXv3hRPzku3W
 fwh2czF9patqDsevo9gyvfowb1UJeGGEcdY_P1_FTuKJ5c4Ai_jEhAiSwRZ6Y7v4KDcTdDXdaw2z
 9uR4.lAiUY2QYV.kYUzXFo47nZwJjqeRWhagKqPEvUtc8O3TYxx0bosZsMxqCvPL3Osxoma50FM8
 NlVZdgeU6ChTmzzIxZnL3jaqeqJ698iHgnhE_LAMqWp1fNCSOI1qE1lQW4lfvYEZACyfBZ_f8Ju.
 xVS5D78FopLUmgmsErbu0dgpO5iZU1Fm6h304ITiNzmD1yaKVAo6ZdpzhNNInW9S2pUNK8WnJoT7
 zW6dSH63dscWMoEzOcyM21w6v7SPGzFnuQGo4pNbJOsBTKa1pRskxG.1yqoPPD7yKeIikCnFmXaV
 2yBFuBldzzDNhRCV749PN_QPd1Mc3TAVtNlU6wCz7n4FFlq.P1IL5BB2xniP5r22d7IuPtjEBVy5
 BLI0WhoQX0hdiBI_rdRtpd7jqSvjgfwRgty31uMHewrDw5Ou6ZOxLopqLNl7JdzuklA3Ppib6oC4
 PjU5OK23y4w2vnXpu.qjgx8rkToEMqPH92cFm8zl5i1c3sXLQS3E5rNlHfLPMSbKW7brvOfOSP7D
 TrhwxW_60LA9GuZX6UD7M.1bcsqGJlhL33pWbBCYX3DNN_XnU5rafAzMn2kpHuSF06HoPY4CYFxn
 4R0E9GHAP_HQXuLkwfVGb8xr7oJUiIloJ3PLTcLxbw5wK4MNUhuNOioZFQ2mkuvi4wj.BIsQL7l6
 eVue2QQ6stjzTqFnokrzKRp9D2NRprYWrwp4GevjfWnjJq2TgVnWPdIA7v8JAUL7v9mtzKX__yE5
 23oesi0Ct9CTDb7GiE0AJYTBrIhVrqx_gjE6fm8t7GuH8MECROOEqpWUOJkzDwhuFsHFDyHMX24D
 vdVIHTg8MEMy4WNjcGpZO3UdY_387bu6XHlSOnbWMRKJ.tJrn2_uX3_spQyacWXUlHkbY8H_Z6.4
 CjUYfdXiWScrntc1XiUSP3x_05WU0LJMrkuTUFXczEhfrQsti3z7ak_Zvc_gWzCvUdZeZtaCGeig
 iEEOlDvs0gYEZ.EfjLOu97rdZaDJz3EouSg_7o4G0kJHuW9GM6DiOWJySc_rLKpSnZ0eAe99Ej8X
 vfLiy0uhhJifUyIYsyIzRL1LHW1XMfHA0Ifuah0h4g_XChmnHidy54DISINjclYMBXeVpCt4LuIR
 CC7xj0BnYeYsAm_QdUJMqEaBOZ9pthRBZmBEV2in_0nu0XsBtiIwxkbqKqeWFGbQyJhmzsHLvWC_
 tMxfr3shd4OGr2Z_.ScS1JiFkL75ziIeDmf0Bv07C_vm5eidyk3Y9tKzyqcoNhvUNAUiMtu3SQvf
 xvpS6zugin2ZBTHEiRtCDNDgnSaexom4gwrAYUvYO4LgXmjmzaJm_rRz5qx2pfAktHcxFXTVgfrf
 82GBrmJ7bOrZUczamfOsV1tERBtYknLl1ola6aNJpeyOY2mM7XOwL00u_W3RSugdm1Gp6mH1JoYV
 R48galyn8zsd70jn27S6njKYd9.WL9ohEWtEMYXTbUqV9fbOCrkpsv35_FuO_fayVjNtIeSU4mS6
 fpruKcv_XfAFjnY.XM6AKNBxvTrHUJoD2tdGtMp4Yb6eBb.jfDKEiBqbkb_A_LY2d4CIy2tuuG6l
 g0pKIUHula3eCRs8eee7PV14atHxKz2hCSF.Qo1TMTr8JvWv2RwfSnaIJGyNC4bGX95WS1Ti8P4V
 YtJH6hPdS60s9x0ovd6R8gUdANupf7V5diVDhomC5KCFWHll_m2eBYT97oH8.OFLDuSFWxV_EerZ
 4nzUq2ILABPLbL5tFhB_2xy2o8IQvGJEXQkZuBJEyMFueTRJsHlxYA6ZvoJsdSlNUNe6YpLrAovO
 D_5LDg0gTE52vgTfGMOkuVG5hlHAqW2V9GYzJ8ThHGfQHIWBMJQJ4Ru.whvBRB7waMirJwZjYbd9
 0Lxe3JHICB9b5R1r4h2tmCx9ATdR4mbjn7YWYk8JYGIoXeWGUQQtkyx2MKybeuW2thpenLIRL1BW
 2vVubBP0b9UD7saSzcTjib4b9r1vZu1odO5p6sFtGDvOU4yVQ8AB6NP57ThBMu3f1xs.es.yt8TX
 Mgcu3cZXKGGnMCaprDcoPKvJOoNkmYSjjCgML.MNTlSFbQXBZW_UbRfhYs7BMwcefAZSNL674zIg
 UStB3Jl2jMHZbqmt5d4m28yM.87TgHvWbpa5WNCqGc1FqKK9paoJIhNxamwxCEr6p0oR0OcEqR9B
 _ytl6CA55ClCyvDJgAA.o
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9ae51792-311b-4df8-9935-5fc1babbc821
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Mar 2024 22:13:51 +0000
Received: by hermes--production-gq1-5c57879fdf-bmngc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 445fd6fc5bc99a4f17bf05f96870067d;
          Tue, 12 Mar 2024 22:13:46 +0000 (UTC)
Message-ID: <00734a64-a5fe-420c-bf6e-bee27c9d83be@schaufler-ca.com>
Date: Tue, 12 Mar 2024 15:13:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
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
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] LSM: use 32 bit compatible data types in LSM syscalls.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <00734a64-a5fe-420c-bf6e-bee27c9d83be.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Change the size paramters in lsm_list_modules() and lsm_get_self_attr()
from size_t to u64. This avoids the need to have different interfaces
for 32 and 64 bit systems.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h                        |  2 +-
 include/linux/security.h                             |  6 +++---
 security/apparmor/lsm.c                              |  2 +-
 security/lsm_syscalls.c                              |  8 ++++----
 security/security.c                                  |  6 +++---
 security/selinux/hooks.c                             |  2 +-
 security/smack/smack_lsm.c                           |  2 +-
 tools/testing/selftests/lsm/common.h                 |  4 ++--
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++-----
 tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
 11 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..1d3b498f5230 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -265,7 +265,7 @@ LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
 LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
-	 struct lsm_ctx __user *ctx, size_t *size, u32 flags)
+	 struct lsm_ctx __user *ctx, u64 *size, u32 flags)
 LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
 	 struct lsm_ctx *ctx, size_t size, u32 flags)
 LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..d5044c290b4c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -478,7 +478,7 @@ int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			 size_t __user *size, u32 flags);
+			 u64 __user *size, u32 flags);
 int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
 			 size_t size, u32 flags);
 int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
@@ -494,7 +494,7 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
-int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
+int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u64 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
@@ -1434,7 +1434,7 @@ static inline int security_locked_down(enum lockdown_reason what)
 	return 0;
 }
 static inline int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,
-				    size_t *uctx_len, void *val, size_t val_len,
+				    u64 *uctx_len, void *val, size_t val_len,
 				    u64 id, u64 flags)
 {
 	return -EOPNOTSUPP;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9a3dcaafb5b1..77d1293f6a44 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -779,7 +779,7 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
 }
 
 static int apparmor_getselfattr(unsigned int attr, struct lsm_ctx __user *lx,
-				size_t *size, u32 flags)
+				u64 *size, u32 flags)
 {
 	int error = -ENOENT;
 	struct aa_task_ctx *ctx = task_ctx(current);
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 5d391b1f7e69..3a76f335e46e 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -75,7 +75,7 @@ SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
  * a negative value indicating the error is returned.
  */
 SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
-		ctx, size_t __user *, size, u32, flags)
+		ctx, u64 __user *, size, u32, flags)
 {
 	return security_getselfattr(attr, ctx, size, flags);
 }
@@ -93,11 +93,11 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
  * required size. In all other cases a negative value indicating the
  * error is returned.
  */
-SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
+SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u64 __user *, size,
 		u32, flags)
 {
-	size_t total_size = lsm_active_cnt * sizeof(*ids);
-	size_t usize;
+	u64 total_size = lsm_active_cnt * sizeof(*ids);
+	u64 usize;
 	int i;
 
 	if (flags)
diff --git a/security/security.c b/security/security.c
index 7035ee35a393..7721330f6d65 100644
--- a/security/security.c
+++ b/security/security.c
@@ -785,7 +785,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
  * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
  * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
  */
-int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
+int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u64 *uctx_len,
 		      void *val, size_t val_len,
 		      u64 id, u64 flags)
 {
@@ -3918,13 +3918,13 @@ EXPORT_SYMBOL(security_d_instantiate);
  * If @size is insufficient to contain the data -E2BIG is returned.
  */
 int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
-			 size_t __user *size, u32 flags)
+			 u64 __user *size, u32 flags)
 {
 	struct security_hook_list *hp;
 	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
 	u8 __user *base = (u8 __user *)uctx;
+	u64 entrysize;
 	size_t total = 0;
-	size_t entrysize;
 	size_t left;
 	bool toobig = false;
 	bool single = false;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 338b023a8c3e..92677eb3ed31 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6556,7 +6556,7 @@ static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
  * There will only ever be one attribute.
  */
 static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			       size_t *size, u32 flags)
+			       u64 *size, u32 flags)
 {
 	int rc;
 	char *val = NULL;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0fdbf04cc258..0bb295184806 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3641,7 +3641,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
  * There will only ever be one attribute.
  */
 static int smack_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
-			     size_t *size, u32 flags)
+			     u64 *size, u32 flags)
 {
 	int rc;
 	struct smack_known *skp;
diff --git a/tools/testing/selftests/lsm/common.h b/tools/testing/selftests/lsm/common.h
index d404329e5eeb..af9fd720a9fb 100644
--- a/tools/testing/selftests/lsm/common.h
+++ b/tools/testing/selftests/lsm/common.h
@@ -7,7 +7,7 @@
 
 #ifndef lsm_get_self_attr
 static inline int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
-				    size_t *size, __u32 flags)
+				    __u64 *size, __u32 flags)
 {
 	return syscall(__NR_lsm_get_self_attr, attr, ctx, size, flags);
 }
@@ -22,7 +22,7 @@ static inline int lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
 #endif
 
 #ifndef lsm_list_modules
-static inline int lsm_list_modules(__u64 *ids, size_t *size, __u32 flags)
+static inline int lsm_list_modules(__u64 *ids, __u64 *size, __u32 flags)
 {
 	return syscall(__NR_lsm_list_modules, ids, size, flags);
 }
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
index e0e313d9047a..20be5454ad05 100644
--- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -40,7 +40,7 @@ TEST(size_null_lsm_get_self_attr)
 TEST(ctx_null_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u64 size = page_size;
 	int rc;
 
 	rc = lsm_get_self_attr(LSM_ATTR_CURRENT, NULL, &size, 0);
@@ -57,7 +57,7 @@ TEST(size_too_small_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size = 1;
+	__u64 size = 1;
 
 	ASSERT_NE(NULL, ctx);
 	errno = 0;
@@ -77,7 +77,7 @@ TEST(flags_zero_lsm_get_self_attr)
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
 	__u64 *syscall_lsms = calloc(page_size, 1);
-	size_t size;
+	__u64 size;
 	int lsmcount;
 	int i;
 
@@ -117,7 +117,7 @@ TEST(flags_overset_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size;
+	__u64 size;
 
 	ASSERT_NE(NULL, ctx);
 
@@ -140,7 +140,7 @@ TEST(flags_overset_lsm_get_self_attr)
 TEST(basic_lsm_get_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u64 size = page_size;
 	struct lsm_ctx *ctx = calloc(page_size, 1);
 	struct lsm_ctx *tctx = NULL;
 	__u64 *syscall_lsms = calloc(page_size, 1);
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
index 9df29b1e3497..52d014b0ff37 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -31,7 +31,7 @@ TEST(size_null_lsm_list_modules)
 TEST(ids_null_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u64 size = page_size;
 
 	errno = 0;
 	ASSERT_EQ(-1, lsm_list_modules(NULL, &size, 0));
@@ -43,7 +43,7 @@ TEST(size_too_small_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	__u64 *syscall_lsms = calloc(page_size, 1);
-	size_t size = 1;
+	__u64 size = 1;
 
 	ASSERT_NE(NULL, syscall_lsms);
 	errno = 0;
@@ -58,7 +58,7 @@ TEST(flags_set_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	__u64 *syscall_lsms = calloc(page_size, 1);
-	size_t size = page_size;
+	__u64 size = page_size;
 
 	ASSERT_NE(NULL, syscall_lsms);
 	errno = 0;
@@ -72,7 +72,7 @@ TEST(flags_set_lsm_list_modules)
 TEST(correct_lsm_list_modules)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
-	size_t size = page_size;
+	__u64 size = page_size;
 	__u64 *syscall_lsms = calloc(page_size, 1);
 	char *sysfs_lsms = calloc(page_size, 1);
 	char *name;
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
index e9712c6cf596..ec7a4df6d4d9 100644
--- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -25,7 +25,7 @@ TEST(size_too_small_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size = page_size;
+	__u64 size = page_size;
 
 	ASSERT_NE(NULL, ctx);
 	if (attr_lsm_count()) {
@@ -41,7 +41,7 @@ TEST(flags_zero_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	struct lsm_ctx *ctx = calloc(page_size, 1);
-	size_t size = page_size;
+	__u64 size = page_size;
 
 	ASSERT_NE(NULL, ctx);
 	if (attr_lsm_count()) {
@@ -57,7 +57,7 @@ TEST(flags_overset_lsm_set_self_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	char *ctx = calloc(page_size, 1);
-	size_t size = page_size;
+	__u64 size = page_size;
 	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
 
 	ASSERT_NE(NULL, ctx);


