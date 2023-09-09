Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EFA799699
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 08:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbjIIGgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 02:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjIIGgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 02:36:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421B61BC1;
        Fri,  8 Sep 2023 23:36:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so5796543a12.1;
        Fri, 08 Sep 2023 23:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694241377; x=1694846177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxDt+J4qs95QgkCUW3xamlXKdUL8C9wCvkelnFrCtns=;
        b=I8XFWy6jeUVDdlq7B0lT+Cg13X3wLBVTo8UPgAT5IwbHhylXPLKT/lcocpMQXg+wKN
         7RSKX4+6Ad0guLx28QWxysf9UbAmT/0XcrBlZp0UiZT6QMsDY9H0tv0YH99doYArtT7V
         zkYcgm1toW/N9fBqUNYM25Y5bXj5YsKCm0+U2/WsGTxAT9nbGe113SzhcMweohtXspgx
         /Xdbd1KDeipBcnheSLa+MMJG82Mb+YnQbTboYn52sSXlo5NK0OZ3Ehnn+m6phlayV2BF
         qBl+S3De228OpP9PKr7cCqG5FNFOReNQQC0xtr3VGfhZ2rpUfIOhs54UvRODCVrYTwVJ
         HdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694241377; x=1694846177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxDt+J4qs95QgkCUW3xamlXKdUL8C9wCvkelnFrCtns=;
        b=quT84RCKut01OLfW6ZAwDg8Qd6dIa8gyn8oaiDG0ApPrfU0JwR0y11t55Z2mmTjeU2
         SDTY3dha/mFma7PjxoijQidfPR5qHhpsKEnmei/XYnYxLowkIldhAsTKxsRAMYL0m19Q
         RmsPk6kuV3+xDsdKWoy6E8Enxj/dVgi9y95/ORBCLlAWBibUGe3y9zbRiJ5ZR3XzzBva
         lysa+rcL7aR4tG5aiRJSoOGWta4Gd6jlUK3iv2ZuniAqF9c2uE62fxqvODfKe+ANbcvN
         h7xQROcVNfFnuzrbt2s2MmAVqpXwv861cpW4pequ/dMIlmUg7TfAxXFWVwUofvTan6Hn
         uChA==
X-Gm-Message-State: AOJu0YwVRKfgzDxhgdXoKKZ3JL/FxD6OvyQX8wjlR00cKmPzot5iJxc2
        LvMXVq0hQPbuBuzAeLXkgZ4=
X-Google-Smtp-Source: AGHT+IHXfl3Vj/OEpdCs17Y509NAivDrg0Kp33zpuiucSp2ZkpTdr/4KIu8QP04zDXD5PzN3iNufyw==
X-Received: by 2002:a05:6402:124f:b0:525:8124:20fe with SMTP id l15-20020a056402124f00b00525812420femr6174280edw.18.1694241376487;
        Fri, 08 Sep 2023 23:36:16 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z26-20020aa7cf9a000000b005232c051605sm1817525edx.19.2023.09.08.23.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:36:15 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/2] pinctrl: pinmux: Update error reporting in pin_request()
Date:   Sat,  9 Sep 2023 08:36:11 +0200
Message-ID: <20230909063613.2867-1-jernej.skrabec@gmail.com>
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

Jernej Skrabec (2):
  pinctrl: pinmux: Remove duplicate error message in pin_request()
  pinctrl: pinmux: Use dev_err_probe() in pin_request()

 drivers/pinctrl/pinmux.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.42.0

