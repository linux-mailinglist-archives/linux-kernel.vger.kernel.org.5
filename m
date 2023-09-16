Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2997D7A30AB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjIPNgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 09:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbjIPNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 09:35:58 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8334E197
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 06:35:53 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57358a689d2so1888930eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694871353; x=1695476153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IgdmKyG2oBgLUj8iDGVi77dhR1poilu0MDEaA6E+Ac=;
        b=SZbHFk8KlpVKV7S+Enh6mw2jknoNu5PJBAFAwmn8Op5AnYiBW2jpwlSKyMKt3/vq9F
         Cc0WfxKL6q83bqWP3z01s+r35tFAZplNdOvWfjqDD5jrd9jpzkVpeN/2TK6kbQoUTnl1
         XMq11A5BKp6wOPA8F/U0KuobDmtQhl+fUO3NfxHASXBw1qTwi4B9MGBVkqkbNgWtjOKi
         SfAdeSkYE2Yx5mCZm0BZkJnF2uqh/p7hz9PbEifDgs8zRipmobKqgMtiWNpX99BHuaPX
         ZfKH5GS9lM+LbJt0p+ixoUd3GqnN5yB4navzo8Y+8Gcbi7eh4z9k6rlJrwDAA1hcl8iB
         7Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694871353; x=1695476153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IgdmKyG2oBgLUj8iDGVi77dhR1poilu0MDEaA6E+Ac=;
        b=LL2G0LCBJHPDT650FzPLiSkE1+kuP3mEuav6muYU6erIWhsr6U5YGYPVLPWdi+JhFp
         wM0hGZCGH/0h7fO87LVDeMaTRfPdlSllRlfl9wPBGVdVIQa1f8IVxfrgnt7jYVeiw7dM
         nn2aFbOcHdmUaqCmP4ogAyqRU9oVbFn2lyIJEPRIYYIKkG67wZSkMtLMCaVPmMOXsFbv
         C2Yu8FncZLd9m8riKxVshgdhMNsXvOCCZ51FdFvmOa9IhjrwDU262dQ0CvB2qX9f63uX
         tfopNLwkDLw4U1e/ejZ3XXzuPvD9LoYjd37uitEW8MijmFEQ+b0R9gqGrx5gJhIXMvSn
         4OaA==
X-Gm-Message-State: AOJu0YzP43rVoN3N1mRqbhFQeamuBp6D3twf9qPSwXyP8ZTo6TprA1Bu
        Qst9rOrLOShkRMaKkDA+pd1wXAwcvP0yQqcc9ys=
X-Google-Smtp-Source: AGHT+IGGUy6ANEX5fOPOUnLqUEaTpL7HgmucOkqH1eEGerQE4XJlSW/mAgcK2oYVJHHXQHL0MSTlx7bHAvfVGEKKp6Q=
X-Received: by 2002:a4a:dfcb:0:b0:576:8b2b:1ea with SMTP id
 p11-20020a4adfcb000000b005768b2b01eamr4825690ood.2.1694871352661; Sat, 16 Sep
 2023 06:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230916130653.243532-1-hdegoede@redhat.com>
In-Reply-To: <20230916130653.243532-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Sep 2023 16:35:16 +0300
Message-ID: <CAHp75VdgNraMM15=DLnd66DVEpBX8zwv8VEon7pVjoy9MhHZRA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/platform/uv: Rework NMI "action" modparam handling
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
        linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 4:07=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Rework NMI "action" modparam handling:
>
> 1. Replace the uv_nmi_action string with an enum; and
> 2. Use sysfs_match_string() for string parsing in param_set_action()

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

>  static int param_get_action(char *buffer, const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%s\n", uv_nmi_action);
> +       return sprintf(buffer, "%s\n", actions[uv_nmi_action]);
>  }

Recently I have sent a patch to make all *printf() to be sysfs_emit()
in params.c a s I believe that those are for sysfs only. That said, I
think this is the case here. But,  this is out of scope of the change
and up to you what to do with this (meanwhile you are using
*sysfs*_match_string() which emphasizes the use case already).

--=20
With Best Regards,
Andy Shevchenko
