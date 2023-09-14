Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8944979FEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbjINIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjINIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:43:27 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7A11FC2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:43:23 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-57361de8878so409287eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681002; x=1695285802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcnj2jl85WCt6XjMogIPi+D+NjI0MJKsl4u3FKX3EwA=;
        b=a32Xgi1UmJRMHAAC/Kdar66rCOxrtiBoN4BojWAf3v8FtCw5kypDXe3p1WcQm1oZnQ
         mV8iU0SyatBl9tPNB30nbCwgi76CIJMBVly5GH1/tXasZNkbcaaVUNMA5ErIeZtDXJrh
         2NsuhTYVg8vqfwFuQPwEBiUvFzVpwaoqSU32pwElRlV02fhGSYQhZ6BX5RlpQF8wff3c
         q11brcPhsiVUN5IdQ63NYeYeeneb3ch/HB156JXQnZdF1UlvgOw0sICbYSG7L5czLw6E
         yX9DcVvs6bH35ykArn8BZoxHMocKNPzd0stDKcO6yvmQPUHMR/+D8U/B0lqJHbBJLIyt
         W0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681002; x=1695285802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcnj2jl85WCt6XjMogIPi+D+NjI0MJKsl4u3FKX3EwA=;
        b=rb3nz4tNmblkCVQAOpdn4/BKc6ZDX2JGSMvK1KLC0jRgrx+ijVIEnQmsjoetswxxHB
         uGowGSrDukkUKUzfSF6PlnRS/aOONQPCljafKw/aiIo57jSneAXpE+w4w8XGuDdNKplN
         1A38bBo2Pdl6GhBO41IZ6XuVIWvc6aWrvx+eJEXH060MqMOdsNEtJlFP57QI6iQ4V+bK
         mCUq4l8utVBmISpu07h8yjMiPwJg75hqv5LELqBaOV5CUms5IMafKQ1XCdp9zQoNZcng
         FKXno9q4bEP4lDMQcHuYMskOfQriOFQzDz2/nXOCnjSKJ0kJsAcbqKpZmzxNr+wSgFfv
         pTdg==
X-Gm-Message-State: AOJu0Ywv1sjmkkECAvgumcPA9/HrtvGCalV7aueE3574M0jADW7CdvVA
        RXG0TmyAmSaUnWfZTvIkUai6BE6Osd2c3v4EK7o=
X-Google-Smtp-Source: AGHT+IGMenVZ0+Tf9KvdkJ+cAFBA60vup6qPwUA7dKQpGkNJAXpkYCR6+y2HEz9Rmdi4BpRvX5tT0ECjU21qXmn8tQw=
X-Received: by 2002:a4a:2a47:0:b0:567:4e58:6aaf with SMTP id
 x7-20020a4a2a47000000b005674e586aafmr5121606oox.6.1694681002226; Thu, 14 Sep
 2023 01:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230913180111.85397-1-hdegoede@redhat.com>
In-Reply-To: <20230913180111.85397-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Sep 2023 11:42:46 +0300
Message-ID: <CAHp75VdTO2=2a_7tqH72tji=UWhmjNpaO+tE8sq+ufdjY6+Low@mail.gmail.com>
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
        linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 9:01=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Rework NMI "action" modparam handling:
>
> 1. Replace the uv_nmi_action string with an enum; and
> 2. Use sysfs_match_string() for string parsing in param_set_action()

...

Don't you need to include string.h?

...

> +enum action_t {
> +       nmi_act_kdump,
> +       nmi_act_dump,
> +       nmi_act_ips,
> +       nmi_act_kdb,
> +       nmi_act_kgdb,
> +       nmi_act_health,
>  };

> +
> +static_assert(ARRAY_SIZE(actions) =3D=3D ARRAY_SIZE(actions_desc));

I believe with enum in place you don't need this, just add a terminator to =
it

enum action_t {
   ...
   nmi_act_max
};

and use as an array size both arrays.

...

> -       int i;
> -       int n =3D ARRAY_SIZE(valid_acts);

> +       int i, n =3D ARRAY_SIZE(actions);

Since you are changing them, why not make them unsigned?

...

> -       pr_err("UV: Invalid NMI action:%s, valid actions are:\n", arg);
> +       pr_err("UV: Invalid NMI action:%s, valid actions are:\n", val);

As mentioned previously the val may or may not have a new line in it.
I dunno about comma removal, but a new line presence can be easily checked.

Either way it's not so critical, hence removing comma. or replacing it
by '-' (dash) may be enough.


--=20
With Best Regards,
Andy Shevchenko
