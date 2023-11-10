Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4C7E80DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbjKJSSn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 13:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346031AbjKJSQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:28 -0500
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757686BE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:52:04 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a92782615dso21154227b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 23:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699602723; x=1700207523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaVE/Hmtw8Qyzr1hth0Egh6StwsBQoCEgkvrfNpoQBU=;
        b=ox0ceE21bduIPVVWtS2G8yCRG/hBHKkXFsYZ1Q87G3fHNtuGWJz2hcsjLGvTtS36eL
         KJKRXAdA80HaPqyyGvG+2NIg8aJ3DpCSY3yYs57aE2tPiPLkCjK2VoNkWkCtuC2ZMNht
         EBKEPcV5yRqLfdfH8oJLkD40Mx1z0NDcbvmNKjKmFA4n1SqkgFOoPBtMVAQb2FcOY1IO
         KqAzfmDj2i1v8Ol1ZsAGQSVpAxepSxGQt/k8Pr075CVcA2RyeYPDg4QSqQ0CRgqN84y2
         uhDPBUKX34wL45J67jjK7WZFi7V4wzMGPofftnGDQmab48ZMBthH42u2MXpuagfXX2CX
         xNRQ==
X-Gm-Message-State: AOJu0Yz+ILe6TxBHa3xjz4QlJrH2eQ5U4xG2PKmvSlSHab7+Tzxu0XT3
        WfzbVOvCPnbvjvM4GTygMoGzSLhPixIefA==
X-Google-Smtp-Source: AGHT+IFcAphcax0TDkQpRMsdD2hiJl9Q+6huysrJPhsHTGvt9F8VhhaCnE4y97nmZkXhrhFO7VNyfA==
X-Received: by 2002:a81:7c0b:0:b0:5af:b4c4:5668 with SMTP id x11-20020a817c0b000000b005afb4c45668mr7790125ywc.6.1699602723584;
        Thu, 09 Nov 2023 23:52:03 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id t6-20020a817806000000b005af6df31bb0sm8441603ywc.105.2023.11.09.23.52.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 23:52:02 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a92782615dso21153957b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 23:52:02 -0800 (PST)
X-Received: by 2002:a0d:d492:0:b0:59e:9a44:9db9 with SMTP id
 w140-20020a0dd492000000b0059e9a449db9mr7942764ywd.26.1699602722730; Thu, 09
 Nov 2023 23:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20231109202830.4124591-1-u.kleine-koenig@pengutronix.de> <20231109202830.4124591-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231109202830.4124591-6-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Nov 2023 08:51:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ1obmXwtFAic39t93pMdhOTjk_Rxz70_zx7et6g4=7w@mail.gmail.com>
Message-ID: <CAMuHMdXQ1obmXwtFAic39t93pMdhOTjk_Rxz70_zx7et6g4=7w@mail.gmail.com>
Subject: Re: [PATCH 05/12] bus: simple-pm-bus: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Ying <victor.liu@nxp.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 9:29 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
