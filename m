Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8804C7A89C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjITQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjITQvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:51:08 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83499
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:51:01 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59c2ca01f27so238147b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695228661; x=1695833461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFp4/FBehp7bXIUiukwsVd1VDsGADtdLcprhP9iiGVo=;
        b=pAg3CkC/Du4ux91LNo3FyRoTIlxCCG45OZxGbWIvjzdJ+iqtrQJYSlZQQy+0xtvHuV
         U4tGnnZrIVWwWtAyzm99So2MGa8z9OAd9RABEz0vSJFzN7dhZlSYTJZVsg42wZGc7B8c
         tEVfOf/AcovO8hDTUYW9vVDMoFUrItIUVD5f8aGNOWYvIR+/3QtxXwVv2d1XIXHTmxVX
         YlPkrgd/zo15mWlKuM8lAu5DiaJ0UJhSFkhFZIn4WUMmGXs4FWAb1C/A1493H5lCiiyD
         GCgLC1B822J77mtCpkron+zHhlhnpwTXwJOj+DBdyCqdyQoIHNy9agxzbgxqbtNkO65e
         PdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695228661; x=1695833461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFp4/FBehp7bXIUiukwsVd1VDsGADtdLcprhP9iiGVo=;
        b=t4EIv9AJX6tNcvHOymc1tbZTA6hHV9Mb+tNz4t3zIORSugO1D24XEuNN5RkZ+orlWB
         gzrePP/Ct3wP40wZWWVnBhDlMmo8vK8ZgoX7MncyBfXDwI2UVVvxoaA29FuVUyfZM+LH
         CVuzrUkr9gUB8pfoyQhtu12XVUSwLfF2L6VywqkeWyUQb/LfOZArn5gZB7Ghppn9DRwk
         GHGvb8aL1lG5MLU9a2n/VWzwnJhXMBzM8AlaVZ6OpzZ4ISFSP/pYZeJoy4ePVjG6+jhg
         bnMSj62LbyvO55vJ3GF0XMhBoIiakpbBmLIi0WGwuxnkW5va+Ra+1l2y2r9HpNkrsdAH
         U3ig==
X-Gm-Message-State: AOJu0YzdVE+VDu6UnMRdH6x3tFPCQx7kHiL//RR1sCvWVreHtaTEGE+H
        HKydcHOfVIyl2uzU1/MfBeBgTNA0GWUCam/FYpnhtg==
X-Google-Smtp-Source: AGHT+IEuELX3/Oyy6eRXnIacTDFmEDIXHMrCxW6IPWYkJBUy8R78CaXGS8Piry3NQBq/Ct/oKIOvajA2h1foAouaUKk=
X-Received: by 2002:a25:d0d7:0:b0:d81:5ec1:80cf with SMTP id
 h206-20020a25d0d7000000b00d815ec180cfmr3192253ybg.12.1695228660956; Wed, 20
 Sep 2023 09:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230920153819.2069869-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230920153819.2069869-1-andriy.shevchenko@linux.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Sep 2023 09:50:45 -0700
Message-ID: <CAKwvOd=7vk2HKOpgVrRd2RtKSF9tXPqbVmN+5teLTNoBy4BWVg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Replace custom implementation of COUNT_ARGS()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com,
        llvm@lists.linux.dev, alsa-devel@alsa-project.org
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

On Wed, Sep 20, 2023 at 8:38=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace custom and non-portable implementation of COUNT_ARGS().
>
> Fixes: e64b674bc9d7 ("software node: implement reference properties")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Closes: https://lore.kernel.org/r/ZQoILN6QCjzosCOs@google.com

Thanks for the patch!
Closes: https://github.com/ClangBuiltLinux/linux/issues/1935
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Of course Linux would have a macro for this!  I should have known.
Trying to wrap my head around it. Awesome

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/property.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 1684fca930f7..55c2692ffa8c 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -10,6 +10,7 @@
>  #ifndef _LINUX_PROPERTY_H_
>  #define _LINUX_PROPERTY_H_
>
> +#include <linux/args.h>
>  #include <linux/bits.h>
>  #include <linux/fwnode.h>
>  #include <linux/stddef.h>
> @@ -314,7 +315,7 @@ struct software_node_ref_args {
>  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)                    \
>  (const struct software_node_ref_args) {                                \
>         .node =3D _ref_,                                          \
> -       .nargs =3D ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1, \
> +       .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
>         .args =3D { __VA_ARGS__ },                                \
>  }
>
> --
> 2.40.0.1.gaa8946217a0b
>


--=20
Thanks,
~Nick Desaulniers
