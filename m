Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9E79F20B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjIMTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjIMTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:31:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A2B7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:30:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8a822508so29491866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694633457; x=1695238257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KdePKCPYvG/rJdITsMLL3gD9ofjtkuxLrsIQxLfm1w=;
        b=yI7WBHRWEjWkSXPqfczf3tdMehqthftv2JK79TJd2yTgfK+FpiDL8u/JxNwr5lMVGU
         lZ2fRUByOvght7u4NtmG8nEZRWCXCl2taHU1ysNvHsPfXtMNU9aVGOLM4QfyqPqXlOBH
         f7VTOQXqlYJhB+JnBwMikJrBiQPwm05DPfr+hdcbHQfrjn7q2VNqQzDehY6ifCrxYM+r
         POGVKBFbeCPNQxgO8icshFSBFaEWox9i6E9vewWfewzMteigheABRiQBY49Ahd4Uf+Nf
         k3xYxqTUD4PK04FomzZ7+c/Sga1zgDAm59MutnHvlzkDiCyGv4s1le8TWGJ5C9uLGWvJ
         1+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633457; x=1695238257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KdePKCPYvG/rJdITsMLL3gD9ofjtkuxLrsIQxLfm1w=;
        b=KhhiGtPNwVubSUToQIJ0SYUT0GEIbSYtgG8a8VOnHdWCTVk8Ja8itAtrb/n7AN/Jqi
         SuYfmy8TcX+ICVursfIcNvt9qMWYn7XOizWzFBcpoi4YentvppHXXq+IgfOK9rkd37rj
         yxI/puQbXIxqMHVNV8ljdAB/CSJEEbJ0lNjpmF17hBq53j6SQplfujf/nTHyOj+PUSAf
         89LydDXvGB0ZICawoO6PvF6clVM/h1Ynzs03/OGZKiEDVz/XF8X3N2DfIA7+8XZBTC8b
         g/jIa8g45lvcLZCjy1pLbKC8ZBU4Nkz0jwtn6PHps7+hSXguoyLVAzH06TKuaZr9FeOY
         GWhw==
X-Gm-Message-State: AOJu0Yx/Vqu2MQ9lEOSWWLY0KYdlY1PKUszL3ccmV4o1+a5MlYc/Hflq
        Y9ZaCHrnm9tqsSiSGpbyvrujSsDSNrSf+8T64HeEkQ==
X-Google-Smtp-Source: AGHT+IHfyxANrlNf7Vf7FAkVxbGlKMNtwLf9b8r6TSfp/OX/2Izrjng4JuXciFg0awSL157gncTJFpJ3iN+g8rl8O9U=
X-Received: by 2002:a17:906:295:b0:9a5:7e63:2df with SMTP id
 21-20020a170906029500b009a57e6302dfmr2693961ejf.1.1694633456715; Wed, 13 Sep
 2023 12:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230913180111.85397-1-hdegoede@redhat.com>
In-Reply-To: <20230913180111.85397-1-hdegoede@redhat.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 13 Sep 2023 12:30:45 -0700
Message-ID: <CAFhGd8puRTCYw2MhecmgW4SQR-_YPyBSy_fbgvE_1c1Onh0veg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/platform/uv: Rework NMI "action" modparam handling
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:01=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Rework NMI "action" modparam handling:
>
> 1. Replace the uv_nmi_action string with an enum; and
> 2. Use sysfs_match_string() for string parsing in param_set_action()
>
> Suggested-by: Steve Wahl <steve.wahl@hpe.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
Reviewed-by: Justin Stitt <justinstitt@google.com>

> Changes in v2:
> - Also change uv_nmi_action to an enum to replace a bunch of
>   strcmp() calls
> ---
>  arch/x86/platform/uv/uv_nmi.c | 104 +++++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 47 deletions(-)
>
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.=
c
> index 45d0c17ce77c..b92f1b4adeb0 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -178,49 +178,57 @@ module_param_named(debug, uv_nmi_debug, int, 0644);
>         } while (0)
>
>  /* Valid NMI Actions */
> -#define        ACTION_LEN      16
> -static struct nmi_action {
> -       char    *action;
> -       char    *desc;
> -} valid_acts[] =3D {
> -       {       "kdump",        "do kernel crash dump"                  }=
,
> -       {       "dump",         "dump process stack for each cpu"       }=
,
> -       {       "ips",          "dump Inst Ptr info for each cpu"       }=
,
> -       {       "kdb",          "enter KDB (needs kgdboc=3D assignment)" =
 },
> -       {       "kgdb",         "enter KGDB (needs gdb target remote)"  }=
,
> -       {       "health",       "check if CPUs respond to NMI"          }=
,
> +enum action_t {
> +       nmi_act_kdump,
> +       nmi_act_dump,
> +       nmi_act_ips,
> +       nmi_act_kdb,
> +       nmi_act_kgdb,
> +       nmi_act_health,
>  };
> -typedef char action_t[ACTION_LEN];
> -static action_t uv_nmi_action =3D { "dump" };
> +
> +static const char * const actions[] =3D {
> +       [nmi_act_kdump] =3D "kdump",
> +       [nmi_act_dump] =3D "dump",
> +       [nmi_act_ips] =3D "ips",
> +       [nmi_act_kdb] =3D "kdb",
> +       [nmi_act_kgdb] =3D "kgdb",
> +       [nmi_act_health] =3D "health",
> +};
> +
> +static const char * const actions_desc[] =3D {
> +       [nmi_act_kdump] =3D "do kernel crash dump",
> +       [nmi_act_dump] =3D "dump process stack for each cpu",
> +       [nmi_act_ips] =3D "dump Inst Ptr info for each cpu",
> +       [nmi_act_kdb] =3D "enter KDB (needs kgdboc=3D assignment)",
> +       [nmi_act_kgdb] =3D "enter KGDB (needs gdb target remote)",
> +       [nmi_act_health] =3D "check if CPUs respond to NMI",
> +};
> +
> +static_assert(ARRAY_SIZE(actions) =3D=3D ARRAY_SIZE(actions_desc));
> +
> +static enum action_t uv_nmi_action =3D nmi_act_dump;
>
>  static int param_get_action(char *buffer, const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n", uv_nmi_action);
> +       return sprintf(buffer, "%s\n", actions[uv_nmi_action]);
>  }
>
>  static int param_set_action(const char *val, const struct kernel_param *=
kp)
>  {
> -       int i;
> -       int n =3D ARRAY_SIZE(valid_acts);
> -       char arg[ACTION_LEN];
> +       int i, n =3D ARRAY_SIZE(actions);
>
> -       /* (remove possible '\n') */
> -       strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1)=
;
> -
> -       for (i =3D 0; i < n; i++)
> -               if (!strcmp(arg, valid_acts[i].action))
> -                       break;
> -
> -       if (i < n) {
> -               strscpy(uv_nmi_action, arg, sizeof(uv_nmi_action));
> -               pr_info("UV: New NMI action:%s\n", uv_nmi_action);
> +       i =3D sysfs_match_string(actions, val);
> +       if (i >=3D 0) {
> +               uv_nmi_action =3D i;
> +               pr_info("UV: New NMI action:%s\n", actions[i]);
>                 return 0;
>         }
>
> -       pr_err("UV: Invalid NMI action:%s, valid actions are:\n", arg);
> +       pr_err("UV: Invalid NMI action:%s, valid actions are:\n", val);
>         for (i =3D 0; i < n; i++)
> -               pr_err("UV: %-8s - %s\n",
> -                       valid_acts[i].action, valid_acts[i].desc);
> +               pr_err("UV: %-8s - %s\n", actions[i], actions_desc[i]);
> +
>         return -EINVAL;
>  }
>
> @@ -228,15 +236,10 @@ static const struct kernel_param_ops param_ops_acti=
on =3D {
>         .get =3D param_get_action,
>         .set =3D param_set_action,
>  };
> -#define param_check_action(name, p) __param_check(name, p, action_t)
> +#define param_check_action(name, p) __param_check(name, p, enum action_t=
)
>
>  module_param_named(action, uv_nmi_action, action, 0644);
>
> -static inline bool uv_nmi_action_is(const char *action)
> -{
> -       return (strncmp(uv_nmi_action, action, strlen(action)) =3D=3D 0);
> -}
> -
>  /* Setup which NMI support is present in system */
>  static void uv_nmi_setup_mmrs(void)
>  {
> @@ -727,10 +730,10 @@ static void uv_nmi_dump_state_cpu(int cpu, struct p=
t_regs *regs)
>         if (cpu =3D=3D 0)
>                 uv_nmi_dump_cpu_ip_hdr();
>
> -       if (current->pid !=3D 0 || !uv_nmi_action_is("ips"))
> +       if (current->pid !=3D 0 || uv_nmi_action !=3D nmi_act_ips)
>                 uv_nmi_dump_cpu_ip(cpu, regs);
>
> -       if (uv_nmi_action_is("dump")) {
> +       if (uv_nmi_action =3D=3D nmi_act_dump) {
>                 pr_info("UV:%sNMI process trace for CPU %d\n", dots, cpu)=
;
>                 show_regs(regs);
>         }
> @@ -798,7 +801,7 @@ static void uv_nmi_dump_state(int cpu, struct pt_regs=
 *regs, int master)
>                 int saved_console_loglevel =3D console_loglevel;
>
>                 pr_alert("UV: tracing %s for %d CPUs from CPU %d\n",
> -                       uv_nmi_action_is("ips") ? "IPs" : "processes",
> +                       uv_nmi_action =3D=3D nmi_act_ips ? "IPs" : "proce=
sses",
>                         atomic_read(&uv_nmi_cpus_in_nmi), cpu);
>
>                 console_loglevel =3D uv_nmi_loglevel;
> @@ -874,7 +877,7 @@ static inline int uv_nmi_kdb_reason(void)
>  static inline int uv_nmi_kdb_reason(void)
>  {
>         /* Ensure user is expecting to attach gdb remote */
> -       if (uv_nmi_action_is("kgdb"))
> +       if (uv_nmi_action =3D=3D nmi_act_kgdb)
>                 return 0;
>
>         pr_err("UV: NMI error: KDB is not enabled in this kernel\n");
> @@ -950,28 +953,35 @@ static int uv_handle_nmi(unsigned int reason, struc=
t pt_regs *regs)
>         master =3D (atomic_read(&uv_nmi_cpu) =3D=3D cpu);
>
>         /* If NMI action is "kdump", then attempt to do it */
> -       if (uv_nmi_action_is("kdump")) {
> +       if (uv_nmi_action =3D=3D nmi_act_kdump) {
>                 uv_nmi_kdump(cpu, master, regs);
>
>                 /* Unexpected return, revert action to "dump" */
>                 if (master)
> -                       strscpy(uv_nmi_action, "dump", sizeof(uv_nmi_acti=
on));
> +                       uv_nmi_action =3D nmi_act_dump;
>         }
>
>         /* Pause as all CPU's enter the NMI handler */
>         uv_nmi_wait(master);
>
>         /* Process actions other than "kdump": */
> -       if (uv_nmi_action_is("health")) {
> +       switch (uv_nmi_action) {
> +       case nmi_act_health:
>                 uv_nmi_action_health(cpu, regs, master);
> -       } else if (uv_nmi_action_is("ips") || uv_nmi_action_is("dump")) {
> +               break;
> +       case nmi_act_ips:
> +       case nmi_act_dump:
>                 uv_nmi_dump_state(cpu, regs, master);
> -       } else if (uv_nmi_action_is("kdb") || uv_nmi_action_is("kgdb")) {
> +               break;
> +       case nmi_act_kdb:
> +       case nmi_act_kgdb:
>                 uv_call_kgdb_kdb(cpu, regs, master);
> -       } else {
> +               break;
> +       default:
>                 if (master)
> -                       pr_alert("UV: unknown NMI action: %s\n", uv_nmi_a=
ction);
> +                       pr_alert("UV: unknown NMI action: %d\n", uv_nmi_a=
ction);
>                 uv_nmi_sync_exit(master);
> +               break;
>         }
>
>         /* Clear per_cpu "in_nmi" flag */
> --
> 2.41.0
>
