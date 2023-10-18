Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B047CD471
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbjJRGZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjJRGZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:25:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABF2C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:24:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so6336224a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697610248; x=1698215048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0LSTDW6faOOZtWiReUGEV1kCZbo9a6/NHU8SOiXxrc=;
        b=FLck6fm3Q50JXB/FT7td+1zfeI+Pj4RhU0M8Dt//vNxC6vtJw93rxQc6VSyEGKz1Tp
         FOZan8trl2/3xGDNeX7Y/0qxJqIqCr50BIHBZOGf8iDwK+mZiwRGMYKMxmSJXoqC2XaO
         ZnF/o1KGSZ/gn3Jj6V5YDJyw8vRrvwIGGIAnnTdx1r1w5n3N3cFJ/aNybbfETGPK6RD4
         3uEHOajYE9VeDSwafuEC5eIAdsxqiEMB1KUKT60ZLyGdZf7iXgFf8xdPyJXYfppozTMJ
         1P2o0VGytDp54t5YPwWsBmLKMZZa5mOEg2OTQ7723PQEx/6GKS8Y+GPs4knFTVHMWITH
         xs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697610248; x=1698215048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0LSTDW6faOOZtWiReUGEV1kCZbo9a6/NHU8SOiXxrc=;
        b=aCVR34M4nLy4VRdHPtxRHzkJnRgWhLx0bwtCJCY50hfZeZZxokv5Ums8FY2joN7BEx
         pfqGpFR9sF6lr3rlj2uyMAMT5bEAqWKBixRo5Lab/ib5G27PQBkhMeewwb2/77jAEd+L
         HPm5pi5mdFUVzTxlSAJydbEv1nfZCec90hw2TLqRzpl2QrTPnJgBqJ20mFo+/eAyskCr
         szCi3ozwgXQY88ErQfchJwD0gtlicA9wR/Df0haCO/NQ6FpR9tX06HanKomKVqSdG0up
         RravFugP+19cK4fb08R+UY6IDcDCPSJ1smrXgJKGe8CWeKnfWXBRHXPo9SxL6iPcMucQ
         ndPw==
X-Gm-Message-State: AOJu0YySTOH5R5RKIotIrJ+++tagzUQpu7t/CsXEKFp2dwmDz8waDc83
        2lWh9vZjrgfOUkIQVLOBpZEXmYOM6/v+zyZ/bKY=
X-Google-Smtp-Source: AGHT+IFkxm1MnB5ryqx/bxdOF9swb/7TUQl4dvCNn74j4MyU/6anDE4hDdxSnnwnnJXSJnG7ob0naA==
X-Received: by 2002:a05:6402:4314:b0:53e:1b:15f5 with SMTP id m20-20020a056402431400b0053e001b15f5mr3286742edc.39.1697610248609;
        Tue, 17 Oct 2023 23:24:08 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id h15-20020a0564020e0f00b00530a9488623sm2242277edh.46.2023.10.17.23.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:24:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/2] ARM: dts: samsung: exynos4412-midas: fix key-ok and use Linux event codes
Date:   Wed, 18 Oct 2023 08:24:04 +0200
Message-Id: <169761020952.14892.6591419387867673696.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017101402.62740-1-raymondhackley@protonmail.com>
References: <20231017101402.62740-1-raymondhackley@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Oct 2023 10:16:37 +0000, Raymond Hackley wrote:
> Input event code 139 stands for KEY_MENU, instead of KEY_OK as node name
> key-ok inplies. Fix it with correct event code 0x160.
> 
> Use event codes with linux-event-codes.h included for input keys on midas
> in addition.
> 

Applied, thanks!

It is however very late in the cycle, so there is a chance this will miss the
merge window. If this happens, I will keep it for the next cycle (no need for
resending).

[1/2] ARM: dts: samsung: exynos4412-midas: fix key-ok event code
      https://git.kernel.org/krzk/linux/c/25e20eedc1d63dcdf6f781588e8dbc37cd0aad16
[2/2] ARM: dts: samsung: exynos4412-midas: use Linux event codes for input keys
      https://git.kernel.org/krzk/linux/c/4a48fa417abc5b86da393c93ab63a9160076a248

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
