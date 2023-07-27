Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D651F765FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjG0WtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjG0WtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:49:21 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1151FC9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:49:20 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-79a46f02d45so667572241.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690498159; x=1691102959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NYvlsFz+3bTMfsTHbgY87g/2XWXC64dEH3md2UPJ6g=;
        b=bEhEEN4aoXgcgHk+7n4UIOPmdxMoQPFwdze+KHGhhUBZ5Ak4zM9xoDWKBQegUlH/o7
         BStTXrDJWU2jomd5NOCIoRJGqSxTBQaJTtKUEW8eIg4sPZVH8sUwSxz51RS2evN/OEh9
         zJwPquuESOUYwnk5GyJlbxbtXxtv3gVbrQCB8zee/hny6Oz8lg0yh/V4tjE4kjKTkwMX
         B9PClknNpeEICAlRKvJE+8th8h16OyO3xNr+1/gCRnbIVJYbEiy4yvZor+W8JIaMJZk8
         m76qHkVn4y6ZWmBNkEVRZfKgOZ3T46OqYVOtF4eHpP6NBy7u2rlntuIEcQiVresy9Nl1
         ieSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690498159; x=1691102959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NYvlsFz+3bTMfsTHbgY87g/2XWXC64dEH3md2UPJ6g=;
        b=EDmmsZFq2R0lhE/eL0f5QNMV/4apsQHV7p2EvYDY34rfQXHyp6bPgkEDVnblj047rf
         ID6K8QuOB15Od5XblsyGUgERMX1pmAgtGjbdM6mfa6i8ZbqkoFykdQYQGBD2tuF83Sbc
         bVa5hLNqYJ90QQhDqLUlx6qfsE6wZf4Jy92HZ0kRy3ay6XScoT/9qPsc09nJbSYsOseY
         pSs9JE8ylIgjHUwFS7EbBFroUAJbuFVOxNIrxty0ghGBNiHnTPrxJ1X4kFotJHxIjw1O
         zot6pIWs2iSB1bAUYKs2FniCpk7vgq1jFeQJmdtcZPG/O621O4RRG2miNGOmBEVeL3gZ
         GT1w==
X-Gm-Message-State: ABy/qLYVI+TsZ2a+sM0ud8ymoLg/gwCmlqQAcLPpIGsbLXHRrreE4Ks5
        96w4vgDPXYFcFMvH3os4vy4/+wDBBKbuFNi+qQFJmg==
X-Google-Smtp-Source: APBJJlG5eey1nYvnY0wcglb8pf7X62F5klJT4/NorDW09IyuqZbR3TF0CFSBVUD8fKyYR8ID3jyhQ9/thieq5ybt0NQ=
X-Received: by 2002:a67:fb46:0:b0:443:70ec:d28b with SMTP id
 e6-20020a67fb46000000b0044370ecd28bmr845103vsr.19.1690498159357; Thu, 27 Jul
 2023 15:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230727-amdgpu-v1-1-a95690e75388@google.com>
In-Reply-To: <20230727-amdgpu-v1-1-a95690e75388@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Jul 2023 15:49:07 -0700
Message-ID: <CAKwvOdnQJcn_9h1v6b9JBNG+Mj-WczMOXmjiS9TnxUrqMjTQZQ@mail.gmail.com>
Subject: Re: [PATCH] drm: fix indirect goto into statement expression UB
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 3:47=E2=80=AFPM <ndesaulniers@google.com> wrote:
>
> A new diagnostic in clang-17 now produces the following build error:
>
> drivers/gpu/drm/tests/drm_exec_test.c:41:3: error: cannot jump from this
> indirect goto statement to one of its possible targets
>    41 |                 drm_exec_retry_on_contention(&exec);
>       |                 ^
> include/drm/drm_exec.h:96:4: note: expanded from macro
> 'drm_exec_retry_on_contention'
>    96 |                         goto *__drm_exec_retry_ptr;
>       |                         ^
> drivers/gpu/drm/tests/drm_exec_test.c:39:2: note: possible target of
> indirect goto statement
>    39 |         drm_exec_until_all_locked(&exec) {
>       |         ^
> include/drm/drm_exec.h:79:33: note: expanded from macro
> 'drm_exec_until_all_locked'
>    79 |                 __label__ __drm_exec_retry;
> drivers/gpu/drm/tests/drm_exec_test.c:39:2: note: jump enters a
> statement expression
>
> The GCC manually currently states that:
> >> Jumping into a statement expression with a computed goto (see Labels
> >> as Values) has undefined behavior.
>
> So the diagnostic appears correct, even if codegen happened to produce
> working code.
>
> Looking closer at this code, while the original combination of statement
> expression, local label, and computed/indirect goto GNU C expressions
> were clever, a simple while loop and continue block might have sufficed.
>
> This approach might not work as expected if drm_exec_until_all_locked
> "loops" can be nested, but that doesn't appear to be an existing use
> case in the codebase.
>
> Fixes: commit 09593216bff1 ("drm: execution context for GEM buffers v7")
> Link: https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html
> Link: https://github.com/ClangBuiltLinux/linux/issues/1890
> Link: https://github.com/llvm/llvm-project/commit/20219106060208f0c2f5d09=
6eb3aed7b712f5067
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/drm/drm_exec.h | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index 73205afec162..393ac022ed3a 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -70,18 +70,9 @@ struct drm_exec {
>   * Core functionality of the drm_exec object. Loops until all GEM object=
s are
>   * locked and no more contention exists. At the beginning of the loop it=
 is
>   * guaranteed that no GEM object is locked.
> - *
> - * Since labels can't be defined local to the loops body we use a jump p=
ointer
> - * to make sure that the retry is only used from within the loops body.
>   */
>  #define drm_exec_until_all_locked(exec)                                \
> -       for (void *__drm_exec_retry_ptr; ({                     \
> -               __label__ __drm_exec_retry;                     \
> -__drm_exec_retry:                                              \
> -               __drm_exec_retry_ptr =3D &&__drm_exec_retry;      \
> -               (void)__drm_exec_retry_ptr;                     \
> -               drm_exec_cleanup(exec);                         \
> -       });)
> +       while(drm_exec_cleanup(exec))
>
>  /**
>   * drm_exec_retry_on_contention - restart the loop to grap all locks
> @@ -93,7 +84,7 @@ __drm_exec_retry:                                      =
       \
>  #define drm_exec_retry_on_contention(exec)                     \
>         do {                                                    \
>                 if (unlikely(drm_exec_is_contended(exec)))      \
> -                       goto *__drm_exec_retry_ptr;             \
> +                       continue;                               \

d'oh that's going to continue the do {} while(0) ... let me send a v2...

>         } while (0)
>
>  /**
>
> ---
> base-commit: 451cc82bd11eb6a374f4dbcfc1cf007eafea91ab
> change-id: 20230727-amdgpu-93c0e5302951
>
> Best regards,
> --
> Nick Desaulniers <ndesaulniers@google.com>
>


--=20
Thanks,
~Nick Desaulniers
