Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5517AD747
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjIYLwl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 07:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjIYLwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:52:38 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B57B9B;
        Mon, 25 Sep 2023 04:52:32 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59bbdb435bfso72837577b3.3;
        Mon, 25 Sep 2023 04:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642751; x=1696247551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI0HHzOCVMwTunWGzqcCRD7tcpAmjOBuqvI8GGa/sWs=;
        b=rYaVlH4vITYu/C6jjhlLmIZHKTY+hN3QpgruqccMSU5CJu7+Vpx9Ee68+B+TCzuSd4
         bv6PDfZ55qxGPoAWyFR/9YZ68ak6A6fLHu9gXY+XuOZERbAYZq9xMqOOaX2u+H3KaIZI
         rPWvRbvsdgYndxyEuVomlcal5n+7eqcDT8scJEBwTavqLgIXehItgaNUEbm94yKw5ik0
         WnFPwTxBnGNJ/C0eegLAy0lg3/mCYuoOLzeISeMAT5lpJv9X05BkUdq3p/W3urFDy6Ik
         8OxGH83RYhqEMfnL2L+8duxcEbaKSKEowcpCQs6/ULqCceNwAVAwB8C1I442vPwVFz2x
         WkgA==
X-Gm-Message-State: AOJu0Yw36OkT78gc27PAiPnHixqN3fCiHYCikurdDoFma408tg3N8Lw4
        WHyx0NKcDvS3VPjfVkroggXLKMzGkK5wcw==
X-Google-Smtp-Source: AGHT+IGSRvdhafQcsbGwCa/MArnOYvD43G3mbb4HCtSzB9lIhtSok14ScdEEHGoLIMITLogQnMDyOg==
X-Received: by 2002:a81:ae09:0:b0:5a1:8b2:4330 with SMTP id m9-20020a81ae09000000b005a108b24330mr798825ywh.10.1695642751423;
        Mon, 25 Sep 2023 04:52:31 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id m128-20020a0de386000000b0059b50f126fbsm2349062ywe.114.2023.09.25.04.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 04:52:31 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59c0b9ad491so72978567b3.1;
        Mon, 25 Sep 2023 04:52:31 -0700 (PDT)
X-Received: by 2002:a81:9194:0:b0:59b:c11:ad7c with SMTP id
 i142-20020a819194000000b0059b0c11ad7cmr6654246ywg.18.1695642750888; Mon, 25
 Sep 2023 04:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com> <20230922080421.35145-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230922080421.35145-4-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 13:52:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdPXRSVV1TC7mzB=crYp5AN_7g9LbCgMPjKsxNhdsXwg@mail.gmail.com>
Message-ID: <CAMuHMdXdPXRSVV1TC7mzB=crYp5AN_7g9LbCgMPjKsxNhdsXwg@mail.gmail.com>
Subject: Re: [PATCH 3/3] media: dvb-frontends: drop check because
 i2c_unregister_device() is NULL safe
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 22, 2023 at 1:45 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
