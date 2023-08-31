Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0978F60B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347808AbjHaXS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHaXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:18:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EBEE4F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 16:18:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-500b0f06136so2643005e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693523901; x=1694128701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQdtXN7BCCE8wEkmepaEXr3RJP5QKmKAaoV5neq+eqc=;
        b=yN63nfJfFDiBqYz5HRS9uegI7knu+HAYoU+ujzg8YQXBE5tpUoXA5hiNWhShas9LMm
         TQVatLZT3q/DazHhtbd+xxJ8oNtzcZcZlLZNWm2GB2LxVJc2YaMJTjN3kK5lKSF5fOoq
         Bgs2VN0SsBns9UsBSBp2SdY8Q0yxlJOA2eaqVYf0uUl8qxvM0FTB1nXvxBROmdtV9fLw
         XLxM/JSHXmK7jtaJRDLYCFBmIHocpWe4bN0DNE8n2NBX+qtlrBggtpioBbgUoJX/DntB
         dLReTwcohssgjvZ7NqTZubyXKkWyLZXjwOZbBs2CFEe3B55vSiZJplge5L0XWStHe+La
         vl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693523901; x=1694128701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQdtXN7BCCE8wEkmepaEXr3RJP5QKmKAaoV5neq+eqc=;
        b=KkYbQL4dkWa6uBQHnKEOQe4UdcT5Fc7Kb3Vg2z09qDSCMYUJDw8Jupq1Spk3cEqKC2
         SxgNecnjugpYx0bWii2gqDN2Inmp/cDc/C16nxXny9TBBMLXsV/lHWJjBrHbpvdQvTD/
         nMnkzsVMuoz+lvJkkebk55wtoo2Ft+InVBAAtahX5AZkupklFzwbIcqNv/Bid1Fxl+Le
         6/ZeZVJKCjKaBsj8lwCRz6G7JWNj1s+tq4HNfy0XNuc668UDfo4uCEdOk9TczojjtNfT
         XVd6J9jI6Npvm892hGxEZjMVILpmM6FJcMSFvkt4Ty664y1H680wBT8ofikj4jDbqHb4
         NDmQ==
X-Gm-Message-State: AOJu0YwQWXACrqxmfXdXg4Sinzpjh3iAlqqRKIqk3EsV1EhiUl7MILJr
        AqgoDMIgG2budXXR1QaCTZmWfMaBAK1gb+blf6kstg==
X-Google-Smtp-Source: AGHT+IGF7FARKDfzgNhZTrXEMgQ33Qx24qL0GzFdC/NvjWYOlsJlssFkiz5fqsRhqRad7l2kK7m8mYKpWFTOO6p+9Lw=
X-Received: by 2002:a05:6512:69:b0:500:95f6:ba3d with SMTP id
 i9-20020a056512006900b0050095f6ba3dmr388357lfo.21.1693523901350; Thu, 31 Aug
 2023 16:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230829-missingvardecl-audit-v1-1-34efeb7f3539@google.com> <202308311409.F4EC8BC674@keescook>
In-Reply-To: <202308311409.F4EC8BC674@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 31 Aug 2023 16:18:10 -0700
Message-ID: <CAFhGd8rZdRw1EX-=d7o57TqUc2OacNK-Uciniup=bvtyfsoxgw@mail.gmail.com>
Subject: Re: [PATCH] x86/audit: fix -Wmissing-variable-declarations warning
 for ia32_xyz_class
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 2:11=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Aug 29, 2023 at 10:33:16PM +0000, Justin Stitt wrote:
> > When building x86 defconfig with Clang-18 I get the following warnings:
> > | arch/x86/ia32/audit.c:6:10: warning: no previous extern declaration f=
or non-static variable 'ia32_dir_class' [-Wmissing-variable-declarations]
> > |     6 | unsigned ia32_dir_class[] =3D {
> > | arch/x86/ia32/audit.c:11:10: warning: no previous extern declaration =
for non-static variable 'ia32_chattr_class' [-Wmissing-variable-declaration=
s]
> > |    11 | unsigned ia32_chattr_class[] =3D {
> > | arch/x86/ia32/audit.c:16:10: warning: no previous extern declaration =
for non-static variable 'ia32_write_class' [-Wmissing-variable-declarations=
]
> > |    16 | unsigned ia32_write_class[] =3D {
> > | arch/x86/ia32/audit.c:21:10: warning: no previous extern declaration =
for non-static variable 'ia32_read_class' [-Wmissing-variable-declarations]
> > |    21 | unsigned ia32_read_class[] =3D {
> > | arch/x86/ia32/audit.c:26:10: warning: no previous extern declaration =
for non-static variable 'ia32_signal_class' [-Wmissing-variable-declaration=
s]
> > |    26 | unsigned ia32_signal_class[] =3D {
> >
> > These warnings occur due to their respective extern declarations being
> > scoped inside of audit_classes_init as well as only being enabled with
> > `CONFIG_IA32_EMULATION=3Dy`:
> > | static int __init audit_classes_init(void)
> > | {
> > | #ifdef CONFIG_IA32_EMULATION
> > |     extern __u32 ia32_dir_class[];
> > |     extern __u32 ia32_write_class[];
> > |     extern __u32 ia32_read_class[];
> > |     extern __u32 ia32_chattr_class[];
> > |     audit_register_class(AUDIT_CLASS_WRITE_32, ia32_write_class);
> > |     audit_register_class(AUDIT_CLASS_READ_32, ia32_read_class);
> > |     audit_register_class(AUDIT_CLASS_DIR_WRITE_32, ia32_dir_class);
> > |     audit_register_class(AUDIT_CLASS_CHATTR_32, ia32_chattr_class);
> > | #endif
> > |     audit_register_class(AUDIT_CLASS_WRITE, write_class);
> > |     audit_register_class(AUDIT_CLASS_READ, read_class);
> > |     audit_register_class(AUDIT_CLASS_DIR_WRITE, dir_class);
> > |     audit_register_class(AUDIT_CLASS_CHATTR, chattr_class);
> > |     return 0;
> > | }
> >
> > Lift the extern declarations to their own header and resolve scoping
> > issues (and thus fix the warnings).
> >
> > Moreover, change __u32 to unsigned so that we match the definitions:
> > | unsigned ia32_dir_class[] =3D {
> > | #include <asm-generic/audit_dir_write.h>
> > | ~0U
> > | };
> > |
> > | unsigned ia32_chattr_class[] =3D {
> > | #include <asm-generic/audit_change_attr.h>
> > | ~0U
> > | };
> > | ...
>
> I would expect checkpatch to warn about bare "unsigned", which is frown
> on these days. :) I think __u32 should be fine here...? (Why is it __u32
> instead of u32, btw?)

Yeah, checkpatch doesn't like it. I was just trying to mirror the
implementation in audit.c as closely as possible:
|     unsigned ia32_dir_class[] =3D {
|       #include <asm-generic/audit_dir_write.h>
|       ~0U
|     };


>
> But otherwise, yes, looks good.

Thanks for the feedback here. Should I send a v2 where I changed _all_
instances of `unsigned` in both audit.c and audit.h to be `u32`? Or
perhaps, `unsigned int`.

>
> -Kees
>
> --
> Kees Cook
