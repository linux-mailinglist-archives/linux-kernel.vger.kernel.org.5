Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9927AD73C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjIYLuc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 07:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYLu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:50:29 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E9CF;
        Mon, 25 Sep 2023 04:50:20 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59f6492b415so33107097b3.0;
        Mon, 25 Sep 2023 04:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642619; x=1696247419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0UP6u4hsoIodJSqXKIKtd9qcKxG8HgXyNCB8NOU6N8=;
        b=VhOdTjvwLzYLwnWJdjeHLEVuK62BJIMcuDKk8TCRoZN+Dgu6lHJus9BjjqV/FgezID
         5IpGkMLZ+ecoTSUbwFGaSQpg96dk6aH4aniFXAbMTjO4ANslT/M55jiISH7ix4oTaMY4
         qSjhmQQYH0DYHUo6NOfsbJiWoYjahLlu2Q1t5mBX0kGRrzjgG804QuqeiT9CDhZH8t2D
         +BK37FYUN4AfNI7qIMKOCYVqrKOX/2swF4ze4N8qO7iQBxL+wSwp+jimWWeLlJzfhRQ0
         LZ19lDR9PPqjfpP/Sz1QM8poZxqARA1vAtUK3I6AkGHP6ZhaPNvqvZTEPftQcGf+oWi4
         VKtg==
X-Gm-Message-State: AOJu0Yyxrd2xqx0u/twerxgTrIx8724x4X6IjS7kUvSd8rVP+J/ihGQl
        YdHYaD3zg0e9rMj0oPa1VenF6sg21Yf7JQ==
X-Google-Smtp-Source: AGHT+IF3hQbGDFG4xsWrXN44k+lZXvDn9DdrGufy7HI5WFryR59ieMmttDzkI2jvblwygZ56JnfsGQ==
X-Received: by 2002:a81:83ce:0:b0:59f:6a25:959e with SMTP id t197-20020a8183ce000000b0059f6a25959emr2383797ywf.10.1695642618989;
        Mon, 25 Sep 2023 04:50:18 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id f128-20020a0ddc86000000b0059c8387f673sm2375733ywe.51.2023.09.25.04.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 04:50:18 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f6492b415so33106417b3.0;
        Mon, 25 Sep 2023 04:50:17 -0700 (PDT)
X-Received: by 2002:a0d:d542:0:b0:59f:66a1:bfca with SMTP id
 x63-20020a0dd542000000b0059f66a1bfcamr2229179ywd.26.1695642617660; Mon, 25
 Sep 2023 04:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com> <20230922080421.35145-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230922080421.35145-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 13:50:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXNWL7dMuRwcdcFaSy5ew9gvcdWzXVMp-QjzSDcxbRFFw@mail.gmail.com>
Message-ID: <CAMuHMdXNWL7dMuRwcdcFaSy5ew9gvcdWzXVMp-QjzSDcxbRFFw@mail.gmail.com>
Subject: Re: [PATCH 2/3] media: i2c: drop check because i2c_unregister_device()
 is NULL safe
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 4:45 PM Wolfram Sang
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
