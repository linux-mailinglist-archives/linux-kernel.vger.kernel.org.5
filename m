Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C5D75B8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGTUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTUpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:45:40 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D834271D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:45:39 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1ba79f16f4cso957166fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689885938; x=1690490738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHsGXiGkuWqSHYjU2GwfA7kVibipd2+moLCxICYQn+M=;
        b=RAQqLxmaaibIjLwhM/v97UTdtbVYfL5AmCWq2OuYRj+1+VmyybvPFfcm7hJNUQuNdz
         tZicPp4xhB5BLqQhOiBE9eKi3VUBvUCfBjIgG7EV9388Us2wiKpvh8JWRO8LGMvavSGM
         3bFp52Upf9qB5HLrm2isbOu9rk+dFKTrKNO9x8riRUCXEdmq8tlOMBVDaVXtO9u/b9z7
         KVlMRNv6jUvDTejYV1gMj3lO0c7Os4DBZt+6cxiSliLYC+gdYHKdftzRqrpIPBYgX/U3
         TikK+DyHqiveGowqIQhNkvdxGgCQ69Mu3NJ+TehsoPfBqRe394G+f76B1kJXwswDjfRw
         caOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885938; x=1690490738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHsGXiGkuWqSHYjU2GwfA7kVibipd2+moLCxICYQn+M=;
        b=cu5N9JNovwlTFGYUOo3IkuFKV6d8XlveXXn63mhgB1Vr1hbPMCXEdZhDTu1BCX9ezp
         DCCSVZQAHhVdah5bZzG+1cuopIV+ewGGAbhn1mXo9/tz9YZlGlM0QhI81bHaDUiOfJ7k
         i8YA9e/0FSgM/H4jQZt/5ngBxz/L886O723xaAQiHTt1IKM2PUWApG537Sa7E/rOJKja
         qvmpkxYc75l+9M//nESN2r2n79gPnHovPixuLUu9PSUNKXpDrG8xuT6YfNcrCyUZk61k
         97cQpYAhmGO96eYWcuVrFH7u5JbMoJEGbRf7GNK+O7ctF6bC0oYXraeRW3PKH9tpdVRB
         L36A==
X-Gm-Message-State: ABy/qLYDqkOR4F0+2ehenpLdxjEqg6xFFIXWPSxD41ztqT+8alSYxQAJ
        Ko9kfsxdeujdPNzIhytpkkrOeaun2NRjycG0ycLN
X-Google-Smtp-Source: APBJJlEzJ0xo9wTZEMRWe9dCX85QX06mllpofgOIqhs6sXC4hNlvtsTQPJx65w+viEjsYVUIa25+nRyTwbuiiMnSkio=
X-Received: by 2002:a05:6870:4712:b0:1ba:8307:9a14 with SMTP id
 b18-20020a056870471200b001ba83079a14mr649551oaq.11.1689885938363; Thu, 20 Jul
 2023 13:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230720103549.25255-1-cgzones@googlemail.com>
In-Reply-To: <20230720103549.25255-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Jul 2023 16:45:27 -0400
Message-ID: <CAHC9VhQKMcU=Bmt=CBVywRFDg+=6YGd+UOkNQ1gKytTgAMOgGA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: log about VM being executable by default
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 6:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> In case virtual memory is being marked as executable by default, SELinux
> checks regarding explicit potential dangerous use are disabled.
>
> Inform the user about it.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6f53fa71fbdb..3a7ece84c2cc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7265,6 +7265,8 @@ static __init int selinux_init(void)
>         cred_init_security();
>
>         default_noexec =3D !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
> +       if (!default_noexec)
> +               pr_notice("SELinux:  virtual memory is executable by defa=
ult - related checks disabled\n");

Let's keep things concise and simply say that "virtual memory is
executable by default", dropping the last part about "related checks".

>
>         avc_init();
>
> --
> 2.40.1

--=20
paul-moore.com
