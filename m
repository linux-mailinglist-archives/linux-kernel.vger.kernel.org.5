Return-Path: <linux-kernel+bounces-65590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCBE854F29
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79942807AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693D604CB;
	Wed, 14 Feb 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SqNdONiI"
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6A604BA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929640; cv=none; b=m9HoiNKauM7M0YWg1ojVdR5f7oTi1p1AijM2VqEtO+lD6hxU6M6rHVTFB0o/eRKYqUjAt8Z9jRsVEPDy9HjfVJ67ELGXAadxNcFpm1cPedWA1WCCIhXptcVune95Wng3CLhrPtBx4Q+nGqKOATsewQt03kPAHhj3KyHzW0MEg88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929640; c=relaxed/simple;
	bh=S2KZ2enedGMLMJHEQxj2M3r7Wi/81OS673GMiVnIQjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFOE2rsHpaOemvLz6n6GDu6OVZMI6LPpfgc3j7f9qvzYqMgDkD6K9r7OekgSCi5z8JaLnqT02LZMJ8TD4p/uOxLBjGTe9/rArQU37U21i0f1yJ+0iX1r+QJ/XHWjqchv8P4Re4jXMF9ksKysIspgEO/2z/zVH5bGOQG+z269Hg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SqNdONiI; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707929636; bh=QV6Qmu5RAnBvR3jxVL6PNIGOhMF7Mmkic6h/GwMh+sw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SqNdONiIoT9m2BYz+2N5a/VRnvoqWQid+tsPM0RBORHXETK6G021fnZQuAcEEV9qMLT7rU895O2DPZzMrB8S/ADEKAMmhSUf5w/Gh3oddZvxLtPQ5vr/iHOUzYgI1a/E5fFGncI1+xHGm3XAeHMeEJMRuZRCcQIHfYdkVXA40TjhuqjCh4se0cGEvm8orRQtEmulFLPTTu5jDJUBhK/C1EV99kb/HmHsUzu3xjwkYn/c4zA5fP2vD5ABbSoLMYyRldQtNO6qMNasDsTZsrhQb45FzLg7MQJ98dkbhY1W8XIn3Jt1VQ2nEk+J4HNJEZ352GpddSBazm9wu0eJ+6paAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707929636; bh=o6AzljrIqHspiiSZ11KvN6zZg4BgWAay1RMMPp3WEE4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZgPVY0SVVWPjZ8/pDbUi8jzjSRFs3iZKfhyQ6jJnA7mKE5RfcrbbWmqG6NICUdYVkXq+Ur8PA2K9ONgdYJiGdcitrA1MuYK9AdDMniaztk47ehCUvID+mjEGkqmAqepNq0Zv2Hhrh6J8mQdBVdg5kCkQOff0k58ahMMMcBcS9x/YmWmhoE1CSRjH/L8ys1T9YJpwiya82eLiBZJakPxaJ+F7BZ3sePl9DGJ/F2xPzaOcdFYIRloXLPb7AVY8IlsgCG5yBn6CPX9As+1lBa/RBEFPsUBc0VisJLRQITwJLwf7yEjgysKlSwHbxu+B+b3w8fjNjDsRqX5n1HK0nan7Jw==
X-YMail-OSG: sQxGJlIVM1kWNzzsnRbdEMf2A9A0laGxfrj2Igum5kgeW3zH4SmPHHW4SE7dgaz
 __NENRkG4iJUOtCj8rwzqfD9FWEUwap9Nt8PKeqN5Cq52Xmr2q4VskuVGuNpMRjTwtF_hlCat7JX
 EyHRHIrmAhSbMa5jesY9Zu5S4uwPCzDFNA0zOrWh7dk_.JkYMcodB4gHZXXNbldPkW3_zTQ4uwLR
 rTGG5NAG7p1eb6GQYQL3XQXTzi3f_DoGjAjaMXhjAU6TKHo.LEn4MliNXrsrVKi9alFNy9wMic9i
 pCYrEQdbvJXaSxywVP9nw.5vaHxd4HAJa4USgmHLe6_Tqyg94nso31Y7gJA5jyBuL4tKpCcQo9.z
 LZ8ginzAQ8BA5Z27mpe6AbHLcK1St.bPv6LU1oBeZAUHI_81GTq3mLmL2lo3a6tHyl8e.8Zfxa7g
 ZC4Otfj5X5DVW78vcl_wnwjbtpULQb7JHhdomllOnLXvJhGchFar2MjlsSugHL2Sx1uJ2tixt0Sd
 f37jAxi0GxVpiwfl8XSZZCh2fDDLzHgZNnltEwFrELBFKYfJsV7BAe_TrKcybmtP14gW7u6i3tKA
 7XqzRhOy60OxOLQrLP9gA.3725ZJR3v_rkcg7n9xfit8z_wWjrk3xRHbZdadQ2leYBBxh8cQyL_R
 iIztfix2OYCBcMcOmihDPQx2Rkg8tmdQoQKXW9nyKgRheyZYpnJwhCq4vk5MbHjXRsCe_ohSwjO7
 0_eY2cgv4vv5W2wLyVodjBokU_AZ7jbXEqVHuIIkIRVxcS_nvJnabDH9e26361hqXBDywD4OF1mF
 qZB9hyhuybqYNfMm722H9i010yPyHea26WdbK7sYZkGUHv8TwoXw65.WGeHJS_zNI25PpkJjAGYM
 pJvvIGjWAhTYBW00jkRLBplS848zM5FeNmhiQ_v.9F20cwmHGXAmj4NWKtsgcGFSV1h92fHX1HXn
 .u.zOVhv8Sv2djzzPuydAkZeqytuTAkoMGMnKXWpPChRyWTZ5gp0yf6oLC3WMYqztMf_g4sDpWtq
 RR85E16uBzPhtoAr3fHi0mWiA2ScHRDjulK.1kxW1BsgRa4E5SAfU3_o9MZLEmohsErLUooQ3od3
 MewtJSMpGtakKk1CKaesKTLZ12KYzHviSXzHSgHafczaXPlvSA2oRFx6OFGIyvYiq17rZLnrv2Is
 CA1TR_qRTuBHozb7C8116jaD74.fCvtohh_xBJPEzRL3K0gvKQPnuVAOLf7mGL85Gp6Bm4dynYbC
 h6RB_EAnBc6VDp7TMkvmFGj5Ijye6k.8B3311iGU1oeKvIXec2.7NSYSWIA523vY1Kec3x.so_SV
 Lzm7BZXmxZcv2yuht9Ir8aXEblbhDK2lLVU1cBmBEBUji4KEfe03KuMDcx9MCI7rIkuGN0KiFbDU
 YUV4W1AxDGtTSXgv8K.V4cRfoJio7GcWesOCYAZ39CmoSyFGLx042wDmByDUCiysYTXEe7VhZl7L
 BAdPz0ptJTnSgoHKefMUM3aWlhSvHcdLhjfJr0SyhCxO6F5wzGzkfJknulJ5HAcCF7lQir6OUEjT
 HbnUR_UU.rL13HnG_o7geQI1eFQxDVo9JYKWO79VRlFwMaNq0VQ7Z0mtM.TaLRDrbTVdLKPYRn_l
 .eOqA0DjasBG2KcTu7OajjIGPUGwEyhlZZ2WZd7wX1DUMDuMUl8cMm8d4tmcQnDifAhgE0Xf8XBv
 w_pLmkwvvMUgmDA.v2VxygHutcbyzMfz58GSsyQl9sWdGJIPgzpNcRDeGBXrw8WxdqQ80EH1vRmE
 ykVz78CszDfMU8uoSiQiN29tXzxwEh_p.RaGLzkiJGqYgD5GnB.k8wkRAwV1_jt4YsnZhRd9wQOl
 _LfQAUD7rMbvI004ShHHXjuAk7Z8.cWiF.UOibdOlOvAR3LH9Ju27y22ZbDjGbhEThF9J0CrVC3c
 BcDSFU1_gKGD5p9OQH.Dd1u369lNKwwzNG.awU3K4D8XF9Uaq8P4YiSngg4vWcKARRzvUch.aAHC
 VTS9U1wWFn5FnUxBVm8BY8R.fIu7_orVszfiLhbRRvKxvhNHJuiOIN4RiZPdUCdEdv47ysytPM_H
 iM2b6lb4Sht2CH7Isyqc.qz.KNisDPSrOt9H4EZyFyD.wPN_QQ0W2GIAs8G9AG08CAeNWuAcbKQW
 hZNB7vfpZ4jm8Pl5iNCdc2WaEe5zxQ3GhWZAJ3E.C9WP2eGAHxPOhXCcwJjFIhIrJylQicdsd2_g
 5p5JA2ZwPqsTV2Zi1d_hSfVpW7EjvgV6GDA3VdneD4m8QJYORBnIw_mGeBKzNPRZDyLzlpmqv2yT
 sr2g34TNrNg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b2d54cc7-2a1e-4b70-8a78-7d780da9cd88
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 Feb 2024 16:53:56 +0000
Received: by hermes--production-gq1-5c57879fdf-p26ct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 52fffae420452d8de6fa8aa4633005de;
          Wed, 14 Feb 2024 16:53:55 +0000 (UTC)
Message-ID: <a4a77e0e-8d5e-4c9d-aff4-9fe0d8b89cf0@schaufler-ca.com>
Date: Wed, 14 Feb 2024 08:53:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: fix integer overflow in lsm_set_self_attr()
 syscall
To: Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240214160538.1086089-1-jannh@google.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240214160538.1086089-1-jannh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22077 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/14/2024 8:05 AM, Jann Horn wrote:
> security_setselfattr() has an integer overflow bug that leads to
> out-of-bounds access when userspace provides bogus input:
> `lctx->ctx_len + sizeof(*lctx)` is checked against `lctx->len` (and,
> redundantly, also against `size`), but there are no checks on
> `lctx->ctx_len`.
> Therefore, userspace can provide an `lsm_ctx` with `->ctx_len` set to a
> value between `-sizeof(struct lsm_ctx)` and -1, and this bogus `->ctx_len`
> will then be passed to an LSM module as a buffer length, causing LSM
> modules to perform out-of-bounds accesses.
>
> The following reproducer will demonstrate this under ASAN (if AppArmor is
> loaded as an LSM):
> ```
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <sys/syscall.h>
>
> struct lsm_ctx {
>   uint64_t id;
>   uint64_t flags;
>   uint64_t len;
>   uint64_t ctx_len;
>   char ctx[];
> };
>
> int main(void) {
>   size_t size = sizeof(struct lsm_ctx);
>   struct lsm_ctx *ctx = malloc(size);
>   ctx->id = 104/*LSM_ID_APPARMOR*/;
>   ctx->flags = 0;
>   ctx->len = size;
>   ctx->ctx_len = -sizeof(struct lsm_ctx);
>   syscall(
>     460/*__NR_lsm_set_self_attr*/,
>     /*attr=*/  100/*LSM_ATTR_CURRENT*/,
>     /*ctx=*/   ctx,
>     /*size=*/  size,
>     /*flags=*/ 0
>   );
> }
> ```
>
> (I'm including an ASAN splat in the patch notes sent to the list.)
>
> Fixes: a04a1198088a ("LSM: syscalls for current process attributes")
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
> ASAN splat from the reproducer:
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in do_setattr (security/apparmor/lsm.c:860) 
> Read of size 1 at addr ffff888006163abf by task setselfattr/548
>
> CPU: 0 PID: 548 Comm: setselfattr Not tainted 6.8.0-rc4-00014-g7e90b5c295ec-dirty #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
> <TASK>
> dump_stack_lvl (lib/dump_stack.c:107) 
> print_report (mm/kasan/report.c:378 mm/kasan/report.c:488) 
> [...]
> kasan_report (mm/kasan/report.c:603) 
> [...]
> do_setattr (security/apparmor/lsm.c:860) 
> [...]
> apparmor_setselfattr (security/apparmor/lsm.c:935) 
> security_setselfattr (security/security.c:4038) 
> __x64_sys_lsm_set_self_attr (security/lsm_syscalls.c:55) 
> do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
> RIP: 0033:0x7f29a170ff59
> Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 64 89 01 48
> All code
> ========
>    0:	00 c3                	add    %al,%bl
>    2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>    9:	00 00 00 
>    c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   11:	48 89 f8             	mov    %rdi,%rax
>   14:	48 89 f7             	mov    %rsi,%rdi
>   17:	48 89 d6             	mov    %rdx,%rsi
>   1a:	48 89 ca             	mov    %rcx,%rdx
>   1d:	4d 89 c2             	mov    %r8,%r10
>   20:	4d 89 c8             	mov    %r9,%r8
>   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>   28:	0f 05                	syscall
>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	ret
>   33:	48 8b 0d 07 6f 0c 00 	mov    0xc6f07(%rip),%rcx        # 0xc6f41
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>   3f:	48                   	rex.W
>
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>    6:	73 01                	jae    0x9
>    8:	c3                   	ret
>    9:	48 8b 0d 07 6f 0c 00 	mov    0xc6f07(%rip),%rcx        # 0xc6f17
>   10:	f7 d8                	neg    %eax
>   12:	64 89 01             	mov    %eax,%fs:(%rcx)
>   15:	48                   	rex.W
> RSP: 002b:00007ffd41c781a8 EFLAGS: 00000202 ORIG_RAX: 00000000000001cc
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f29a170ff59
> RDX: 0000000000000020 RSI: 000056518c581260 RDI: 0000000000000064
> RBP: 00007ffd41c781c0 R08: 00000000000a3330 R09: 000056518c581260
> R10: 0000000000000000 R11: 0000000000000202 R12: 000056518bd95060
> R13: 00007ffd41c782a0 R14: 0000000000000000 R15: 0000000000000000
> </TASK>
>
> Allocated by task 548 on cpu 0 at 61.045304s:
> kasan_save_stack (mm/kasan/common.c:48) 
> kasan_save_track (mm/kasan/common.c:68) 
> __kasan_kmalloc (mm/kasan/common.c:372 mm/kasan/common.c:389) 
> __kmalloc (./include/linux/kasan.h:211 mm/slub.c:3981 mm/slub.c:3994) 
> load_elf_binary (./include/linux/slab.h:594 fs/binfmt_elf.c:880) 
> bprm_execve (fs/exec.c:1783 fs/exec.c:1825 fs/exec.c:1877 fs/exec.c:1853) 
> do_execveat_common.isra.0 (fs/exec.c:1984) 
> __x64_sys_execve (fs/exec.c:2129 (discriminator 1)) 
> do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
>
> Freed by task 548 on cpu 0 at 61.045380s:
> kasan_save_stack (mm/kasan/common.c:48) 
> kasan_save_track (mm/kasan/common.c:68) 
> kasan_save_free_info (mm/kasan/generic.c:643 (discriminator 1)) 
> poison_slab_object (mm/kasan/common.c:243) 
> __kasan_slab_free (mm/kasan/common.c:257 (discriminator 1)) 
> kfree (mm/slub.c:4299 (discriminator 3) mm/slub.c:4409 (discriminator 3)) 
> load_elf_binary (fs/binfmt_elf.c:896 (discriminator 1)) 
> bprm_execve (fs/exec.c:1783 fs/exec.c:1825 fs/exec.c:1877 fs/exec.c:1853) 
> do_execveat_common.isra.0 (fs/exec.c:1984) 
> __x64_sys_execve (fs/exec.c:2129 (discriminator 1)) 
> do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
>
> The buggy address belongs to the object at ffff888006163a80
> which belongs to the cache kmalloc-32 of size 32
> The buggy address is located 31 bytes to the right of
> allocated 32-byte region [ffff888006163a80, ffff888006163aa0)
>
> The buggy address belongs to the physical page:
> page:0000000021a8da3a refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6163
> flags: 0x100000000000800(slab|node=0|zone=1)
> page_type: 0xffffffff()
> raw: 0100000000000800 ffff888001042500 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000080400040 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
> ffff888006163980: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
> ffff888006163a00: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>> ffff888006163a80: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
> ^
> ffff888006163b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff888006163b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
>  security/security.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 3aaad75c9ce8..7035ee35a393 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -29,6 +29,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <linux/msg.h>
> +#include <linux/overflow.h>
>  #include <net/flow.h>
>  
>  /* How many LSMs were built into the kernel? */
> @@ -4015,6 +4016,7 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  	struct security_hook_list *hp;
>  	struct lsm_ctx *lctx;
>  	int rc = LSM_RET_DEFAULT(setselfattr);
> +	u64 required_len;
>  
>  	if (flags)
>  		return -EINVAL;
> @@ -4027,8 +4029,9 @@ int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
>  	if (IS_ERR(lctx))
>  		return PTR_ERR(lctx);
>  
> -	if (size < lctx->len || size < lctx->ctx_len + sizeof(*lctx) ||
> -	    lctx->len < lctx->ctx_len + sizeof(*lctx)) {
> +	if (size < lctx->len ||
> +	    check_add_overflow(sizeof(*lctx), lctx->ctx_len, &required_len) ||
> +	    lctx->len < required_len) {
>  		rc = -EINVAL;
>  		goto free_out;
>  	}
>
> base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66

