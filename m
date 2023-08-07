Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207A77727B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjHGO20 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 10:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjHGO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:28:23 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26988AA;
        Mon,  7 Aug 2023 07:28:22 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-686bea20652so4553930b3a.1;
        Mon, 07 Aug 2023 07:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418500; x=1692023300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oe/CN6/jCuhHF6++Sm5t23zpKw7bQYwVaG0CyMWDU64=;
        b=IN81SCZEftK27d5We2DHPjzrQEeT2zGY3K6/pxcPEks4D+WqaQich5jB1ncONuRTHL
         uaI8QkYJBvTHkOTLYnT4lW9PpschWneGL9dAFB1mPu5NcL7WLMo4fT2klLB4XzOWOjq0
         YctS0UG6o8H0zZ4RhsivDNe8pNcRIpCeyDDfzxrDXdXOx8yv8T+1U7rcGbshHDc/UdhF
         kG1Y4z+wnA4its0zJUVUDRnw5gFCGBNSRY9obvdrO1MwCPB5Wo5r0gt96LkpIEV7CZCA
         VrbzF6dYXwrFYZ1j+NmmgvJLalcy9as4qoxwZYhgNUidvPP/GFUQOkl4gmGdZ594SZrU
         i5rA==
X-Gm-Message-State: AOJu0Yw6/wzwNtFQHPBmazve2H2/HlF2zMT6uAP2eh71rA0+cM8kIkez
        WrghRMIXgQ1gEO7pDVsGgCipiT6y6OE5eQ==
X-Google-Smtp-Source: AGHT+IGZ1hjWySWWaW3ScwMcO4sFbu7Zt6hRol07Gi2rE0Ma3vw8pHXzlDY4y742ViM9HGzo1Yb98w==
X-Received: by 2002:a05:6a20:3d83:b0:137:db14:e88b with SMTP id s3-20020a056a203d8300b00137db14e88bmr13899304pzi.29.1691418500397;
        Mon, 07 Aug 2023 07:28:20 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id 18-20020a631252000000b0056428865aadsm4867689pgs.82.2023.08.07.07.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 07:28:20 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-267ffa7e441so3055236a91.1;
        Mon, 07 Aug 2023 07:28:19 -0700 (PDT)
X-Received: by 2002:a17:90a:ce96:b0:268:5bca:3bdf with SMTP id
 g22-20020a17090ace9600b002685bca3bdfmr8841244pju.40.1691418499602; Mon, 07
 Aug 2023 07:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev> <20230807-pll-mipi_set_rate_parent-v6-2-f173239a4b59@oltmanns.dev>
In-Reply-To: <20230807-pll-mipi_set_rate_parent-v6-2-f173239a4b59@oltmanns.dev>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 7 Aug 2023 22:28:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v67YWKbit+F1gOuZ2KFNjcD7NzwwKKpue=f8R2Se8Fg1ag@mail.gmail.com>
Message-ID: <CAGb2v67YWKbit+F1gOuZ2KFNjcD7NzwwKKpue=f8R2Se8Fg1ag@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] clk: sunxi-ng: nkm: consider alternative parent
 rates when determining rate
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 8:44 PM Frank Oltmanns <frank@oltmanns.dev> wrote:
>
> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
> parent rate when determining a new rate.
>
> To find the best match for the requested rate, perform the following
> steps for each NKM combination:
>  - calculate the optimal parent rate,
>  - find the best parent rate that the parent clock actually supports
>  - use that parent rate to calculate the effective rate.
>
> In case the clk does not support setting the parent rate, use the same
> algorithm as before.
>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
