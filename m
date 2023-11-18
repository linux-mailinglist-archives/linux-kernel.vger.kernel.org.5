Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F97EFFD5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 14:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjKRN2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 08:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjKRN2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 08:28:14 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EF7131;
        Sat, 18 Nov 2023 05:28:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c2a0725825so406922966b.2;
        Sat, 18 Nov 2023 05:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700314088; x=1700918888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjRg7NGUQPfxOSlfCXCbAcbz7uHVwoni3DCMCnip4wU=;
        b=m2hTOLBQAQiRbHf2zgNFapeZXHK1pmihkv3SJU53LxkjE05dxWeV1rg6bYa6xUW/JV
         2bFsgS7fGNhPWweB1yNrfK7K4OqAY9iPxsSECN93GBqSI7QMapJjRz8e5Gru9xDVNLH0
         ILkZuaLA2gvB8R/Xz2KmEEeWT3ZVZKCBfjnJ4xB+F0xay4d1zGdpyMEhjwPah40YWLRf
         PzGVMC4fIqthWzyenLlhfxHKbq+uMFJLqijdUwZBpAfXxKkA7A7SoHxXikg/pltqZ48i
         I1TH0HtuuA+q9aoknek+u5DdemeNtgvqJiCpmyYW73VnOXEee7AOIOgsR5sNfWdN9pr7
         ushw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700314088; x=1700918888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjRg7NGUQPfxOSlfCXCbAcbz7uHVwoni3DCMCnip4wU=;
        b=jzo8fgrMAuhg9qr5kMpyWzSXcqh6pYRNsP/RI5jHa5Il/Y1sPex678TbAu+Qf/iuYi
         EUxHJYRXCrA578zENBhlJYAxM4d9DRi3CiWxWTgh4K4ca6vAH9P1EYUhFx32PM+Sa3JY
         qQDgWq+mXVCl1ZoLWgfhPXRnXaIY0NhbCZlfbM1Qcnat3qoelaUgD+DOEpeOOkxw2Afg
         5Ni7hvv2OcBGPO7gK3OYRtTjjKNVsE4cvOYrbMOA8t4SPdrNW3wAbtRIYLR0ovxVZYje
         DrEh0xUH8ExSTF0XtW6dPb930WydXQCnOJu98wBBM8Mv/PecOO+d+oThBwVj/5HzuR85
         QGRQ==
X-Gm-Message-State: AOJu0YxAGT1AA848SQvCFUQF7Fi2C8eKZZqhXMp5iHUtN5efW2Crkz4m
        apCBJWqc6oZ4dx1hyBjslf2WpaJKL3KwmGqwhw4ZbW/F8bN2vA==
X-Google-Smtp-Source: AGHT+IGZaajQ/24RQ52ADMl3xDdYk/JIWqcHZy898i7FE89b3T6YfDO3QBEory4JWhR14iCnRUWOGKMKMM+vi5qC3FQ=
X-Received: by 2002:a17:906:f106:b0:9cf:18ce:95e6 with SMTP id
 gv6-20020a170906f10600b009cf18ce95e6mr1550870ejb.62.1700314087783; Sat, 18
 Nov 2023 05:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20231118113357.1999-1-kamil.duljas@gmail.com> <20231118120235.GA30289@breakpoint.cc>
In-Reply-To: <20231118120235.GA30289@breakpoint.cc>
From:   Kamil Duljas <kamil.duljas@gmail.com>
Date:   Sat, 18 Nov 2023 14:27:56 +0100
Message-ID: <CAFR=A7nkyx_Lf=p0BS-S68_vxQL97rUoLMZpo4kxHjKykAgTRw@mail.gmail.com>
Subject: Re: [PATCH] genetlink: Prevent memory leak when krealloc fail
To:     Florian Westphal <fw@strlen.de>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, you're right. I did not think about it. So if we have a static
pointer that may be resued, should not restore the pointer as at the
beginning?
static unsigned long *mc_groups =3D &mc_group_start;

At this moment we don't know how much memory is allocated. What do you
think about this?

>                               new_groups =3D krealloc(mc_groups, nlen,
>                                                     GFP_KERNEL);
> -                             if (!new_groups)
> +                             if (!new_groups) {
> +                                     kfree(mc_groups);
> +                                     mc_groups =3D &mc_group_start;
>                                       return -ENOMEM;
> +                             }


sob., 18 lis 2023 o 13:02 Florian Westphal <fw@strlen.de> napisa=C5=82(a):
>
> Kamil Duljas <kamil.duljas@gmail.com> wrote:
> > genl_allocate_reserve_groups() allocs new memory in while loop
> > but if krealloc fail, the memory allocated by kzalloc is not freed.
> > It seems allocated memory is unnecessary when the function
> > returns -ENOMEM
>
> Why should it be free'd?  mc_groups is not a local variable.
>
> >                               new_groups =3D krealloc(mc_groups, nlen,
> >                                                     GFP_KERNEL);
> > -                             if (!new_groups)
> > +                             if (!new_groups) {
> > +                                     kfree(mc_groups);
> >                                       return -ENOMEM;
> > +                             }
>
> How did you test this?  AFAICS this results in use-after-free for every
> access to mc_groups after this error path is taken.
>
> Existing code looks correct, we can't grow mc_groups and return an
> error.



--=20
Pozdrawiam,
Kamil Duljas
