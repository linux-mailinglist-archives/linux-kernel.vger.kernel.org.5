Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7107999F1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjIIQ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjIIOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:35:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F24188;
        Sat,  9 Sep 2023 07:35:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c1c66876aso373710766b.2;
        Sat, 09 Sep 2023 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694270100; x=1694874900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OcoS3310g647rr45WAahT4wieNKXZV1ehdAfbJOYnL0=;
        b=HE0CsYtSDkoL4nHe5dCLUAYfzE+DF9eAfbC0zFrQsBUFktbGj2GBlxgw4psDMlgTVH
         du/GAud53aBDJENlCIQBFJetFei6K/80WCD+oJ/SCdN9FELuT+W7PAwTUAHm9rkv8qNl
         renXBl978zBQgKSnvciZKiRDkaWD07SVM1tHyyk4aXWUHcj+THe03Gh/TGshIQ/GMXYo
         ztrXe8EbV1Cwa0LUttU1pKAfrtIfE9Uf3tXaJnFAbcG+kMG6Cpp3BxtvdCNKKPNDxo84
         fTy9NBcITqUVT+TTMVfCnZ1nXpBqsU1FLaIi4wpR2sqB5EaBXP+jOyl5jty7FG4li+eq
         dbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694270100; x=1694874900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcoS3310g647rr45WAahT4wieNKXZV1ehdAfbJOYnL0=;
        b=KOmuDSawAIt68SDSCmL4Pqu15NWAwP5AMS35niXjkdCuP9/OMk7XXolCIr+aL4ec1+
         UY3YVOJD2fSvXey84gTU7l5LK55INoWzV/Wt/G9+JUX+LuXpsgpsZozTcn7CZIbuLCKu
         7GucQZq/xLORd9j3sb5Acmd9BrUEIOmR5JBGmwRB68LxLvSZY1HFIS0DxKCupT9nRgHl
         plIOatyjSAv/eUcBBxr6kF8bors3BDRgbeZ4akOWTWQZUvJDAxHhHx4Eq3GvG+5Xu9J1
         YXjx4J1NjfohraKpYXJWcjr6xEfq1qyfNLW+w7zpib7ke7sah83g6fd1CPWXPTNLfH1E
         UbXg==
X-Gm-Message-State: AOJu0YzFyDaPVhZnot0HNJHh2qKS/MBDZI1ZV+iaf766maOysb+F5cNO
        oIHYP/SxBQQcEWhPvchO3Ww=
X-Google-Smtp-Source: AGHT+IFlVgTdo2XTLCW29VqKt/y0FCLUxSw1By0An0SjsxdcSJwx4OiYtrxd+746N0mdFikPKQWw/Q==
X-Received: by 2002:a17:906:3152:b0:9a2:2841:7908 with SMTP id e18-20020a170906315200b009a228417908mr4343437eje.24.1694270100473;
        Sat, 09 Sep 2023 07:35:00 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090695c300b0099bc8bd9066sm2433945ejy.150.2023.09.09.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 07:34:59 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 0/2] pinctrl: pinmux: Update error reporting in pin_request()
Date:   Sat,  9 Sep 2023 16:34:55 +0200
Message-ID: <20230909143457.9149-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pin_request() may prints two error messages for same error.
Additionally, it also prints error message when status is -EPROBE_DEFER.

Fix that by removing duplicate error reporting and use dev_err_probe()
instead of ordinary dev_err().

Best regards,
Jernej

Changes from v1:
- fixed dev_err_probe() arguments

Jernej Skrabec (2):
  pinctrl: pinmux: Remove duplicate error message in pin_request()
  pinctrl: pinmux: Use dev_err_probe() in pin_request()

 drivers/pinctrl/pinmux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.42.0

