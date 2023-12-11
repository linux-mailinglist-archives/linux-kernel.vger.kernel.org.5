Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14B380DDE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbjLKWAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345552AbjLKWAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:00:45 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C4FD5B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:00:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1c8512349dso663363066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702332028; x=1702936828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DO+nyfi2K4OSqpRKBzov3KLKX0ti76DlsnoVE34DwM=;
        b=DniiHNelBerGiO5/q8XP59I7SM1UZVqVVHGfJvQDtg3HJQ9oOW4tCSAWRRRR/T2tMV
         91qdNyFYznaKgJQnE9AuXnIvU3tO5yzUvL7RZN3DgAPFUaHcd5RVacOEKnkJNNfilqx3
         eYpydkBeBSnZA6gEmloCRQcPHlEdMBsSAYxt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332028; x=1702936828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DO+nyfi2K4OSqpRKBzov3KLKX0ti76DlsnoVE34DwM=;
        b=S1iTAmn/jbtByQpsjBf9e4cYgAVF7PMzImhfE9r4hP6rnV6eAZrBa2aVcMMRPB0fLK
         NP60/BVsKZW4xcUFaIp4Ka5/Lef43RUOf80d827ASRdFMJxCwDuKb+DRR8miRwg0w6cN
         82VHumyIOiBppHi7dcagVjFf4Hf4v+kqcvP3ZihPaq2f1lZy5PIGabXJReROvDaJMenP
         mOEKM8t6LS3hb6hfUFVbLvTG4RsSYvBrfSOvt4QzeH6IEoJuAwEk6xOvrEojvZboR148
         mlAq+sn9laes1Ev/a7oIV+3a4MTQ6vJzh4AVnuYxTzATrulGuWYPMhouH4wiq4sOb4SO
         KKPQ==
X-Gm-Message-State: AOJu0YymStk9ea4KHX7cs2vNDTAEzMPB6Bnxz7sTyrRmadq5OrhKSps1
        JcK/NRm3+yk7ywsnW0j42HRKSMvGxHKuXgeW0Fed3+jG
X-Google-Smtp-Source: AGHT+IFIUt9Rzx0Yec8K0OH/NYqul4xgD5eryyQ/TQsL5FJWy2wNGbBq/XTk6Sw/XJvd3xOXmoESHg==
X-Received: by 2002:a17:906:1197:b0:a19:a19b:c71e with SMTP id n23-20020a170906119700b00a19a19bc71emr2853491eja.110.1702332027734;
        Mon, 11 Dec 2023 14:00:27 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id vu8-20020a170907a64800b00a1d5c52d628sm5335571ejc.3.2023.12.11.14.00.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 14:00:25 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so5485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:00:25 -0800 (PST)
X-Received: by 2002:a05:600c:1e27:b0:40c:256f:756b with SMTP id
 ay39-20020a05600c1e2700b0040c256f756bmr256453wmb.2.1702332024792; Mon, 11 Dec
 2023 14:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20231208212845.1679621-1-michael@amarulasolutions.com>
 <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com> <CAOf5uwmT3uFQhyTOkNDMana5na5jcKm81tdyeann2UnFwaQp5w@mail.gmail.com>
In-Reply-To: <CAOf5uwmT3uFQhyTOkNDMana5na5jcKm81tdyeann2UnFwaQp5w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Dec 2023 14:00:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com>
Message-ID: <CAD=FV=WrBg9PuDW__pZbo5YNuWct17gcK4FF-xKeyxEOsw6Qag@mail.gmail.com>
Subject: Re: [RFC PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 11, 2023 at 1:42=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> > 1. init_kgdboc() runs and registers the singleton kgdb "platform driver=
".
> >
> > 2. The platform driver's probe function, kgdboc_probe(), runs and
> > checks to see if the console is ready by looking at the return value
> > of configure_kgdboc(). If it's ready then we're good to go. If it's
> > not ready then we defer.
> >
> > So I think the bug here is that somehow the console looks "ready"
> > (because tty_find_polling_driver() can find it) but it isn't actually
> > ready yet (because it crashes). That's what you need to fix.
> >
>
> The polling driver look for uart and uart8250_core is registered and 4 fa=
ke uart
> are there but there are not still replaced by platform driver that can
> come later.
> The try_polling find it but it's the isa-8250 driver. It means that
> add_uart 8250 is
> not still happen

The 8250 driver is always a maze, so you might need to do a bunch of
digging. ...but it sure sounds like the console shouldn't be
registered until the correct ops are in place. That either means
getting the ops put in place earlier or deferring when the console is
registered...

-Doug
