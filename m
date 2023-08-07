Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186ED7734B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHGXNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjHGXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:12:41 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BCE269F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 16:11:15 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583a8596e2aso47407917b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691449785; x=1692054585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzp+pWkWPNK9//byCg1TUGOI9l5DmbcmCeyfwExDPLU=;
        b=CGx1t8rf9WuhqD86aU+0PIZbrvpp6TfIeIkwZs5yNftqSXQZG1YgZxi6snwnk6uuC8
         2jrbjQQuiY1gh+bBF6Fe61F8hre7tMSHG7sztJl6qwvswDlqNEJXQeNg0iEZ4cMy+VbW
         2qexbbIVvDouSnX0HUrdx+ArjXRIw1vgQZC6l4gRtfqCX6gFKEl3iT3LTXsQCasbLVGp
         IIGJu97J0EeJUMQMaG3xS5N/3OPtRceL6d0/+4DIqI4HOwPsDm+bXySUoM+a97p4dHzm
         Hd22p2mw6iIPHuhz7V4oomVPPSKl8wDfsrvhThSq6KpolV2hwGC0DJxgenngmQ9VXztp
         yZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449785; x=1692054585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzp+pWkWPNK9//byCg1TUGOI9l5DmbcmCeyfwExDPLU=;
        b=OJ7Zs+mYCwpQ/7LVmjWsLNMW4lcBhAmR73bIFbK1bjsIU2pY57Bu0YuT8inVdgs/RR
         md9D0KIhwhRNsjXOTneHd8VWoIMVdL/ZiKln8SquYWxsgtrKaXvvpnU2PM+R/E+nAu7a
         F1zJD5HxDi7kXtnjoRZ+zCV8M1q5xSl5zBhz2gUnZZHvj7CqkISpNqWjsYhkSZR0NHwc
         rzfZ5ByytB3WddyR2S1mdq2syzJ21BPGuLkjolo+8WSRyfa03zYFmNfltOVME64b69Md
         Z/YGhRoVJzcamb8HmM1cD2o123E1aAmWRKhe9JnkxuDjF+EyxY0q/XrJnRiHaqjzK4wu
         j+qA==
X-Gm-Message-State: AOJu0Yx97PDJLqXw4eAMSm9YEZt4m1vHaXpVBxKK+UjFgsb3qEB5nTFF
        WQXOY7UhgqGwbLHGaHxW5R1Qu3ozmDaRifoOA7sv
X-Google-Smtp-Source: AGHT+IH2mExZ9xa9pJyxwWXq20aTdJVPcWQju/ZYA7cZkJHumKub1Y+Y5TPz9EF3i5nowqgwKxkb+4qoVPvM2uULsd8=
X-Received: by 2002:a0d:cb01:0:b0:569:479f:6d7f with SMTP id
 n1-20020a0dcb01000000b00569479f6d7fmr8169671ywd.43.1691449784772; Mon, 07 Aug
 2023 16:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <ZNCWUQXKrZnCeB/5@gmail.com>
In-Reply-To: <ZNCWUQXKrZnCeB/5@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Aug 2023 19:09:33 -0400
Message-ID: <CAHC9VhT+DPRrSnmh_2PCAf05jPCE-EPaMU_TLB=jJ+mJ+NALsw@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: constify the 'target' parameter in security_capget()
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        john.johansen@canonical.com, ztarkhani@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:59=E2=80=AFAM Khadija Kamran <kamrankhadijadj@gmai=
l.com> wrote:
>
> Three LSMs register the implementations for the "capget" hook: AppArmor,
> SELinux, and the normal capability code. Looking at the function
> implementations we may observe that the first parameter "target" is not
> changing.
>
> Mark the first argument "target" of LSM hook security_capget() as
> "const" since it will not be changing in the LSM hook.
>
> cap_capget() LSM hook declaration exceeds the 80 characters per line
> limit. Split the function declaration to multple lines to decrease the

"multiple" :)

Don't worry, I'll fix that in the merge.

There is one more nitpick below, but I think this looks good.  I'll
give this a few days to see if John can ACK the AppArmor bits, but if
we don't hear from him by mid-week I'll plan to merge this.

Thanks!

> line length.
>
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> Changes in v2:
>  - Squash the patches 1/2 and 2/2 into a single patch
>  - Simplify the commit message
>
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 7 ++++---
>  kernel/capability.c           | 2 +-
>  security/apparmor/lsm.c       | 2 +-
>  security/commoncap.c          | 2 +-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  7 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 6bb55e61e8e8..fd3844e11077 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -36,7 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cre=
d *from,
>  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>          unsigned int mode)
>  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> -LSM_HOOK(int, 0, capget, struct task_struct *target, kernel_cap_t *effec=
tive,
> +LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t =
*effective,
>          kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
>          const kernel_cap_t *effective, const kernel_cap_t *inheritable,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e2734e9e44d5..fef65d0e522d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -145,7 +145,8 @@ extern int cap_capable(const struct cred *cred, struc=
t user_namespace *ns,
>  extern int cap_settime(const struct timespec64 *ts, const struct timezon=
e *tz);
>  extern int cap_ptrace_access_check(struct task_struct *child, unsigned i=
nt mode);
>  extern int cap_ptrace_traceme(struct task_struct *parent);
> -extern int cap_capget(struct task_struct *target, kernel_cap_t *effectiv=
e, kernel_cap_t *inheritable, kernel_cap_t *permitted);
> +extern int cap_capget(const struct task_struct *target, kernel_cap_t *ef=
fective,
> +                                         kernel_cap_t *inheritable, kern=
el_cap_t *permitted);

Don't resubmit the patch just for this, I'll fix it during the merge,
but generally nice to make sure the wrapped lines are aligned with the
previous line; look at the security_cap_get() declaration (below) in
this patch to see an example.

>  extern int cap_capset(struct cred *new, const struct cred *old,
>                       const kernel_cap_t *effective,
>                       const kernel_cap_t *inheritable,
> @@ -271,7 +272,7 @@ int security_binder_transfer_file(const struct cred *=
from,
>                                   const struct cred *to, struct file *fil=
e);
>  int security_ptrace_access_check(struct task_struct *child, unsigned int=
 mode);
>  int security_ptrace_traceme(struct task_struct *parent);
> -int security_capget(struct task_struct *target,
> +int security_capget(const struct task_struct *target,
>                     kernel_cap_t *effective,
>                     kernel_cap_t *inheritable,
>                     kernel_cap_t *permitted);
> @@ -553,7 +554,7 @@ static inline int security_ptrace_traceme(struct task=
_struct *parent)
>         return cap_ptrace_traceme(parent);
>  }
>
> -static inline int security_capget(struct task_struct *target,
> +static inline int security_capget(const struct task_struct *target,
>                                    kernel_cap_t *effective,
>                                    kernel_cap_t *inheritable,
>                                    kernel_cap_t *permitted)
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 3e058f41df32..67bdee3414dd 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -112,7 +112,7 @@ static inline int cap_get_target_pid(pid_t pid, kerne=
l_cap_t *pEp,
>         int ret;
>
>         if (pid && (pid !=3D task_pid_vnr(current))) {
> -               struct task_struct *target;
> +               const struct task_struct *target;
>
>                 rcu_read_lock();
>
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index f431251ffb91..12dd96c3b2f0 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -144,7 +144,7 @@ static int apparmor_ptrace_traceme(struct task_struct=
 *parent)
>  }
>
>  /* Derived from security/commoncap.c:cap_capget */
> -static int apparmor_capget(struct task_struct *target, kernel_cap_t *eff=
ective,
> +static int apparmor_capget(const struct task_struct *target, kernel_cap_=
t *effective,
>                            kernel_cap_t *inheritable, kernel_cap_t *permi=
tted)
>  {
>         struct aa_label *label;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 0b3fc2f3afe7..5fd64d3e5bfd 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -197,7 +197,7 @@ int cap_ptrace_traceme(struct task_struct *parent)
>   * This function retrieves the capabilities of the nominated task and re=
turns
>   * them to the caller.
>   */
> -int cap_capget(struct task_struct *target, kernel_cap_t *effective,
> +int cap_capget(const struct task_struct *target, kernel_cap_t *effective=
,
>                kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  {
>         const struct cred *cred;
> diff --git a/security/security.c b/security/security.c
> index d5ff7ff45b77..fb2d93b481f1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -893,7 +893,7 @@ int security_ptrace_traceme(struct task_struct *paren=
t)
>   *
>   * Return: Returns 0 if the capability sets were successfully obtained.
>   */
> -int security_capget(struct task_struct *target,
> +int security_capget(const struct task_struct *target,
>                     kernel_cap_t *effective,
>                     kernel_cap_t *inheritable,
>                     kernel_cap_t *permitted)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 79b4890e9936..ff42d49f1b41 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2056,7 +2056,7 @@ static int selinux_ptrace_traceme(struct task_struc=
t *parent)
>                             SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>
> -static int selinux_capget(struct task_struct *target, kernel_cap_t *effe=
ctive,
> +static int selinux_capget(const struct task_struct *target, kernel_cap_t=
 *effective,
>                           kernel_cap_t *inheritable, kernel_cap_t *permit=
ted)
>  {
>         return avc_has_perm(current_sid(), task_sid_obj(target),
> --
> 2.34.1

--=20
paul-moore.com
