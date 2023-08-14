Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFD77BBE9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjHNOpU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjHNOo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:44:57 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B95DAA;
        Mon, 14 Aug 2023 07:44:56 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-589addee1c1so37731857b3.3;
        Mon, 14 Aug 2023 07:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692024295; x=1692629095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwU/r/qd94pSxsahlS/bje8+Exn7vF9dOtcbN2fPBKg=;
        b=JC7HAr1uakP30okvM6VwLmpZkwtD3YKIX2TJpHZxC7dIClpy+h0voJ3sazD9w7gLRg
         2YlcfyphrtBnxW69hhW97y1fiCcZhMGa5pp9NxaN+qTBT9iVxHPYlZ7g9/rSBrF0DPEE
         dsOTam4wYFgfkJxtDo4fwLtFe7FtMFq/9Dc0eNDAjq5MnRc7waFwh4TV9tWBHnVk3jP9
         wdYuHbgdz18zP3s0Buh/eb1GOfWWN8aKiudZpoqJbVKS+rx146uWglKcXObjgBRalIJS
         7Zt16Wsr7Rk/ETvIWviQgEY2nf8O/Tbb6BwDtg+upaFB/mxEFQ549yUGIkvPO04z7pKF
         NyxA==
X-Gm-Message-State: AOJu0YydtNpW1IgqYqjapbaV55/kybh2V/ART8kzwq9VzBxhYGp0uVE0
        ajmlDK7AuMmCSJT6kh5yspLekghWByitiQ==
X-Google-Smtp-Source: AGHT+IG/ZlF50OzyxGv412r0W3t4ELYPwt4EELsqQq+Iw/+7mVn7bYPhVzm39mZO2hVlyGw2+dY3+Q==
X-Received: by 2002:a0d:e945:0:b0:586:a012:c703 with SMTP id s66-20020a0de945000000b00586a012c703mr6914477ywe.30.1692024295553;
        Mon, 14 Aug 2023 07:44:55 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id s10-20020a81770a000000b005845e6f9b50sm2803908ywc.113.2023.08.14.07.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 07:44:53 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-589e0eef06dso12370887b3.2;
        Mon, 14 Aug 2023 07:44:53 -0700 (PDT)
X-Received: by 2002:a25:cc8c:0:b0:d62:5d0f:a692 with SMTP id
 l134-20020a25cc8c000000b00d625d0fa692mr8297513ybf.53.1692024292989; Mon, 14
 Aug 2023 07:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230810091510.13006-1-jirislaby@kernel.org> <20230810091510.13006-29-jirislaby@kernel.org>
In-Reply-To: <20230810091510.13006-29-jirislaby@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Aug 2023 16:44:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7JPU3x4eMyFz7eS+xMWVw-uZFgF6H7q1iPPW3eOTV1Q@mail.gmail.com>
Message-ID: <CAMuHMdX7JPU3x4eMyFz7eS+xMWVw-uZFgF6H7q1iPPW3eOTV1Q@mail.gmail.com>
Subject: Re: [PATCH 28/36] tty: propagate u8 data to tty_operations::put_char()
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:16 AM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> Data are now typed as u8. Propagate this change to
> tty_operations::put_char().
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

>  arch/m68k/emu/nfcon.c                  | 4 ++--
>  drivers/tty/amiserial.c                | 2 +-

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
