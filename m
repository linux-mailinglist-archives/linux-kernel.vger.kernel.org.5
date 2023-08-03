Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3692E76E7FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjHCMNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjHCMNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:13:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134330FF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:13:17 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a5ad6087a1so525379b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691064796; x=1691669596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN3/UY6RCA2oDcAiQC4DSHQmT3J1AIJKbAMvJpn19R4=;
        b=ZuhuqSedVHSX8Rkghnf9yMCrQ17yyZVxBEC3uzV0zJO+V276F4NU5ImZmz/JdV9sSw
         OEW31RYv+BA02Bql8u+Ig91T/X6xNMl5lVTulhi++RJdhph5U2uen2lnC48c90I8RBOS
         dyMKAV3mpaqXbGZoVVaV/SaBeuYagidIW7uAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691064796; x=1691669596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN3/UY6RCA2oDcAiQC4DSHQmT3J1AIJKbAMvJpn19R4=;
        b=VEVFKTFYx9JrL9iLWUOVvKq0ttWDDHwalF0GyG/uBjTnHyjQr9TbtNJq8fBnm0b3j8
         CYnCW06RowOpu4czxKCkGuHMDcV4GeiSbUF85yjYvVy8Dz4U3ixPk9vD4n1y5NuCq3WX
         dyu5YF9lPh2fv+CdzuYML3zUUSBx1Pk9I0T5iZH9RZkSpr7zlcILECQkhY93omSaHioX
         kwwQeYUJH3pgTqmkoMVjFsOJZ1cY2CLEgdFX4NVbDm7LdVNrdg1RYDlbZPloggKoba8Y
         FRB9vYsRZxC8uDZFlkvUGwxDrIplYXvewQ7PPWPZfi2j1gaGUgxdI9UOfzAN49jx3CLU
         /fSw==
X-Gm-Message-State: ABy/qLZQumFiTiZcgCcrVX4Lnl77ykoArjUZlxLblo6Y/ktkvkdE4tO+
        GIG8gYFZ/3el/KWctMrwFbHrpu3la8/QZRm9cHoICpkM3f65CBwn4n0=
X-Google-Smtp-Source: APBJJlF6igdQxu72feGlaDQq0qUrV6zp5MLXIJoLpPjEOM7vQe1ZnK/UnpmtMvtZn/oxeI7XQ1adQK2jOBQ+oDgR+DY=
X-Received: by 2002:a05:6808:14cd:b0:3a6:fb15:399b with SMTP id
 f13-20020a05680814cd00b003a6fb15399bmr19380000oiw.36.1691064796306; Thu, 03
 Aug 2023 05:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230802170923.1151605-1-revest@chromium.org> <ZMt6gH4FSHsDetkU@gondor.apana.org.au>
In-Reply-To: <ZMt6gH4FSHsDetkU@gondor.apana.org.au>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 3 Aug 2023 14:13:05 +0200
Message-ID: <CABRcYmLWYr19MVsnrw2OEkmkpJLUNjPULgwooKxYO=R2J2mLww@mail.gmail.com>
Subject: Re: crypto: api - Use work queue in crypto_destroy_instance
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, davem@davemloft.net,
        hillf.zj@alibaba-inc.com, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:59=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Wed, Aug 02, 2023 at 07:09:22PM +0200, Florent Revest wrote:
> >
> > I found that the following program reliably reproduces a "BUG: sleeping=
 function
> > called from invalid context" backtrace in crypto code:
>
> Great detective work! And thanks for cc'ing me :)

Thank you!

> This is definitely a bug in the Crypto API.  Although it's hard to
> trigger because you need to unregister the instance before the last
> user frees it in atomic context.  The fact that it triggers for your
> test program probably means that we're not creating the template
> correctly and it gets unregistered as soon as it's created.
>
> As to the fix I think we should move the work into crypto_destroy_instanc=
e
> since that's the function that is being called from atomic context
> and then does something that should only be done from process context.

Sounds good to me :)

> So here's my patch based on your work:

FWIW,

Tested-by: Florent Revest <revest@chromium.org>
Acked-by: Florent Revest <revest@chromium.org>

> ---8<---
> The function crypto_drop_spawn expects to be called in process
> context.  However, when an instance is unregistered while it still
> has active users, the last user may cause the instance to be freed
> in atomic context.
>
> Fix this by delaying the freeing to a work queue.
>
> Fixes: 6bfd48096ff8 ("[CRYPTO] api: Added spawns")
> Reported-by: Florent Revest <revest@chromium.org>
> Reported-by: syzbot+d769eed29cc42d75e2a3@syzkaller.appspotmail.com
> Reported-by: syzbot+610ec0671f51e838436e@syzkaller.appspotmail.com
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/crypto/algapi.c b/crypto/algapi.c
> index 5e7cd603d489..4fe95c448047 100644
> --- a/crypto/algapi.c
> +++ b/crypto/algapi.c
> @@ -17,6 +17,7 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/workqueue.h>
>
>  #include "internal.h"
>
> @@ -74,15 +75,26 @@ static void crypto_free_instance(struct crypto_instan=
ce *inst)
>         inst->alg.cra_type->free(inst);
>  }
>
> -static void crypto_destroy_instance(struct crypto_alg *alg)
> +static void crypto_destroy_instance_workfn(struct work_struct *w)
>  {
> -       struct crypto_instance *inst =3D (void *)alg;
> +       struct crypto_instance *inst =3D container_of(w, struct crypto_in=
stance,
> +                                                   free_work);
>         struct crypto_template *tmpl =3D inst->tmpl;
>
>         crypto_free_instance(inst);
>         crypto_tmpl_put(tmpl);
>  }
>
> +static void crypto_destroy_instance(struct crypto_alg *alg)
> +{
> +       struct crypto_instance *inst =3D container_of(alg,
> +                                                   struct crypto_instanc=
e,
> +                                                   alg);
> +
> +       INIT_WORK(&inst->free_work, crypto_destroy_instance_workfn);
> +       schedule_work(&inst->free_work);
> +}
> +
>  /*
>   * This function adds a spawn to the list secondary_spawns which
>   * will be used at the end of crypto_remove_spawns to unregister
> diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
> index 6156161b181f..ca86f4c6ba43 100644
> --- a/include/crypto/algapi.h
> +++ b/include/crypto/algapi.h
> @@ -12,6 +12,7 @@
>  #include <linux/cache.h>
>  #include <linux/crypto.h>
>  #include <linux/types.h>
> +#include <linux/workqueue.h>
>
>  /*
>   * Maximum values for blocksize and alignmask, used to allocate
> @@ -82,6 +83,8 @@ struct crypto_instance {
>                 struct crypto_spawn *spawns;
>         };
>
> +       struct work_struct free_work;
> +
>         void *__ctx[] CRYPTO_MINALIGN_ATTR;
>  };
