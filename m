Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88DF7989BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbjIHPTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244456AbjIHPTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:19:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03E1FC6;
        Fri,  8 Sep 2023 08:18:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889DEC433CB;
        Fri,  8 Sep 2023 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694186331;
        bh=2K30IgWgtATYzYBqUXdhOY9Vmr0FQNltvy2dR5bV6xY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gUtbxxmmXVR5oOCQGPHnJbqMA3aEDumNGO7n4XI34qQZ5AOximOABS2g1qHkYkqb4
         0vJ6CjM6HnLn0w22T06UYi1DTYY3zzXQ6AKKrOGzIUMFUOdGd0rvn4EOoJh4n1w0Mk
         eDRkZovIJj9zKc9DcA4R+DGQgrvUie5suuy3AELKSHUKa8pNgD4ROHMduJXygAQOxw
         mMW7TC90WevP3Iqz+ss/dFRRMWuAMjuoBL8Jj+yJ7qjrw9YGi0tQ9rk29J1WbLz2LN
         278tzAYYn+3Te7HwROQaUDrrNuC/qw5Z87nQ+CupGlitM2H5Co7VePNDwIHXN3MJJy
         /WIUYk7v9td1Q==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-500913779f5so3759760e87.2;
        Fri, 08 Sep 2023 08:18:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YzEQtwo15uEeAvUHiUVHmaAdjKDrWbZB0RyUYWAPEKd83j3soiY
        /eboLNAeqc10BxY2KrcEmhQSlbUgiXCkdiRkDA==
X-Google-Smtp-Source: AGHT+IGG5jRUpBNeSXjeSHPTSlaJAXcBbVQov0w3yTxU0+/SuBOS+pAK4V4XgqqDGUtFlpARuMmtqskh82mEne9vFFc=
X-Received: by 2002:a05:6512:3496:b0:500:863e:fc57 with SMTP id
 v22-20020a056512349600b00500863efc57mr1923461lfr.25.1694186329768; Fri, 08
 Sep 2023 08:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
In-Reply-To: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Sep 2023 10:18:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJB_pK-Q-Y-v6mWV1KwfL8sjFGgCcSL5gdrZm-TqxvBJg@mail.gmail.com>
Message-ID: <CAL_JsqJB_pK-Q-Y-v6mWV1KwfL8sjFGgCcSL5gdrZm-TqxvBJg@mail.gmail.com>
Subject: Re: [PATCH] of: dynamic: Fix potential memory leak in of_changeset_action()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        kbuild test robot <lkp@intel.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 2:03=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Smatch complains that the error path where "action" is invalid leaks
> the "ce" allocation:
>     drivers/of/dynamic.c:935 of_changeset_action()
>     warn: possible memory leak of 'ce'
>
> Fix this by doing the validation before the allocation.

I'm going to add a note when applying that "action" can't ever
actually be invalid because all the callers are static inlines with
hardcoded action values. I suppose there could be an out of tree
module calling of_changeset_action() directly, but that's wrong given
the wrappers.

> Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to not use "%pO=
F" inside devtree_lock")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@intel.com/

Despite what that says, it was never reported to me. IOW, the added TO
and CC lines don't seem to have any effect.

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/of/dynamic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 0a3483e247a8..f63250c650ca 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -890,13 +890,13 @@ int of_changeset_action(struct of_changeset *ocs, u=
nsigned long action,
>  {
>         struct of_changeset_entry *ce;
>
> +       if (WARN_ON(action >=3D ARRAY_SIZE(action_names)))
> +               return -EINVAL;
> +
>         ce =3D kzalloc(sizeof(*ce), GFP_KERNEL);
>         if (!ce)
>                 return -ENOMEM;
>
> -       if (WARN_ON(action >=3D ARRAY_SIZE(action_names)))
> -               return -EINVAL;
> -
>         /* get a reference to the node */
>         ce->action =3D action;
>         ce->np =3D of_node_get(np);
> --
> 2.39.2
>
