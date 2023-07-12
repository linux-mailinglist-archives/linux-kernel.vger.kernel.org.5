Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19E75101E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjGLR51 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGLR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:57:26 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC912F;
        Wed, 12 Jul 2023 10:57:25 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso4392949b3a.2;
        Wed, 12 Jul 2023 10:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689184644; x=1691776644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxuOcBIWNZMHeehblHokbsTjPg+FYuoiZM6k4SdRa/E=;
        b=kbWzEL+qwKYUMZxSrhPviCboIDFkfpXRhCctEQEnd/Et++X+6CfK4VUism/gjwTyoK
         XsyBX6uYQ8/rcNPc9NaDZqqgfuaBGgTplHwHtn92HZqAFbKelCd95qYilCA9bc9B2kHM
         kNIkcZhTLc7fyitWcDxVFv8Jwfme1/RL8kq5HhKUfEEd1omVIvNsNOpLhw474YZrNIDd
         pWY1oYDQI6mFlIwUpz7paOEw80kYuai9Sb/AplJu178ZrOoMC6FDohJxw7iX031/ab9+
         9ivnRVt4+6XaJtE3y4dg+OSqg0A/gEIzdFQxatnGppJQEQ3nsbWIGy5lw3qkGeqNXelP
         G0Lw==
X-Gm-Message-State: ABy/qLbFtiO2blJwQQhrK1AcyFlT7/qzJpEq8u07SSC4MaeiXJJHy/gY
        iviYTa6YMKlypoL2jFjr7Ys5mQi4lOidb0lj
X-Google-Smtp-Source: APBJJlGXhDTLXf8ZFjSkv9P3Wn7sqtU4bjueNT2Jcfco/V0zO7SkAYJVoLII8s1vlwNoq6h6dLRIaQ==
X-Received: by 2002:a05:6a21:7906:b0:132:db89:9a48 with SMTP id bg6-20020a056a21790600b00132db899a48mr1790575pzc.6.1689184644080;
        Wed, 12 Jul 2023 10:57:24 -0700 (PDT)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id s4-20020a63b404000000b0055adced9e13sm3602673pgf.0.2023.07.12.10.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:57:23 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-55af0a816e4so3779488a12.1;
        Wed, 12 Jul 2023 10:57:23 -0700 (PDT)
X-Received: by 2002:a17:90b:1e05:b0:263:ba18:3bcc with SMTP id
 pg5-20020a17090b1e0500b00263ba183bccmr14485877pjb.46.1689184643375; Wed, 12
 Jul 2023 10:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-pinctrl-sunxi-boudns-v1-1-85f37de79b9f@kernel.org>
In-Reply-To: <20230712-pinctrl-sunxi-boudns-v1-1-85f37de79b9f@kernel.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 13 Jul 2023 01:57:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v66ErOTdk0k+weHg6rsyOmsxUEiwRqCeBN3ERK0GmhO6iQ@mail.gmail.com>
Message-ID: <CAGb2v66ErOTdk0k+weHg6rsyOmsxUEiwRqCeBN3ERK0GmhO6iQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: Add some defensiveness for regulators array
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 1:20 AM Mark Brown <broonie@kernel.org> wrote:
>
> The sunxi pinctrl has a fixed size array it uses to store regulators used
> in the driver. There is currently nothing that ensures that the number of
> elements in the array is large enough to map the regulators defined by the
> individual SoCs. While this is currently the case having an explicit check
> in there will make life easier for anyone debugging memory issues that
> manifest in the driver so let's add one.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
