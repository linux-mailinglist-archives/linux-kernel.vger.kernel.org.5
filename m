Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5557B2082
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjI1PHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjI1PHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:07:52 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA061AC;
        Thu, 28 Sep 2023 08:07:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5780040cb81so10379247a12.1;
        Thu, 28 Sep 2023 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695913670; x=1696518470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Qz6HI6jlkhdd2Zf0WXt7AO/8I8qoc77cV4VvCrPgng=;
        b=eNrGGvPuVYbfM4US8wNefBav7a1ihh6tvRHodl3YLk7WO4RFIPiz+xwyUToDWIc0no
         FWgkk+GOXN4ZiLzOjB8yM1XFw+AdoQF8y/TkCbea+/tRndub07Wz1T8IECloqg0YbC2P
         om73C07p0FNaZyH4pfy85nmgtoM/vkdPnu5gE5YhTJUi+IUoxMPe9c77LWIfvp8JJDx9
         SP5uGhsolMxkfK8qw86GpdkRp+ahfZlEEccpXa6yPQ1zxadAhejOjLXbn4NSPyzxEVgN
         4rb+cca6kTVxXvVtk+qSlw5QKnh/9QFntmbwlfrHmCtK+ZRORCyAVu5nDJ2xnrThEmtQ
         YwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695913670; x=1696518470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Qz6HI6jlkhdd2Zf0WXt7AO/8I8qoc77cV4VvCrPgng=;
        b=mtTPH1Rc88NOA4p9nQd4E3UfxamQsCqQm7ogp72M11JDb1a2eXYzojtE7WP4wuqRKP
         j0yeR6aMth72NCmyP1uIHSYb9HQUywc3CXi8MuuJ24jv4TGIZu1OVtHfhFRltw7dHhjr
         NeHr1EyvoObs6SLqFCEbfNqiTetz7vdDEfF5BN0x7Wx10mnD6L5k7qzTKnK9jq0kI+Om
         nuWUnQY+LomTmLJfITF6gyacn0C0ULMbDxP6brIfUwN+Kzf87jKvM5j4BltZ4Xj+rihE
         Uc62qDJ/oZ/AjezA/n5qR4GuiMn5P5hUSNsuHZaXpnaHe45fF11m7KzaIjNUZZtAhBrP
         J7GA==
X-Gm-Message-State: AOJu0YztPmdfXIpteT2L+thkgLmxYGcIqvaH3boxCpt1gLG/hAhCYgVJ
        z3wYglDjeguNiwfYWzoxDXGL5P6t+lkbuBDyaFhjUPe+
X-Google-Smtp-Source: AGHT+IESmof8pQRREMh16diAI2K+Cue3aE5DFelWF1s3vxtAYM/mobog5IUcgN2D4wJRkJwCpcKftD02v+jf0rONjTU=
X-Received: by 2002:a17:90b:1d86:b0:26b:59b7:edb with SMTP id
 pf6-20020a17090b1d8600b0026b59b70edbmr1409193pjb.33.1695913670652; Thu, 28
 Sep 2023 08:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com> <20230920022644.2712651-2-jcmvbkbc@gmail.com>
 <2023092835-applied-shakable-f5dc@gregkh>
In-Reply-To: <2023092835-applied-shakable-f5dc@gregkh>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 28 Sep 2023 08:07:38 -0700
Message-ID: <CAMo8Bf+fKpvb5DgN3P847qKNxUa5Y3Q+e4AOikHGrhyZiDCWSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] serial: core: tidy invalid baudrate handling in uart_get_baud_rate
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 1:17=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Sep 19, 2023 at 07:26:40PM -0700, Max Filippov wrote:
> > @@ -539,6 +537,7 @@ uart_get_divisor(struct uart_port *port, unsigned i=
nt baud)
> >  {
> >       unsigned int quot;
> >
> > +     WARN_ON(baud =3D=3D 0);
>
> Why is this needed?  If this isn't happening today, then there's no need
> to check for this here.

I'll drop it then.

--=20
Thanks.
-- Max
