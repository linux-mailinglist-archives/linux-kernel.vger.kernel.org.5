Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE47DB37C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjJ3GhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjJ3Ggv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:36:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E8DB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:36:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso6519843a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1698647802; x=1699252602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLGyBN71ig0nMymCuCLKkacyzibJ7xa5D2WqyZj27OY=;
        b=nFfx/9971KBvMIouFtfUIb8pJ96E0vQxroDTzojN9TjmP18BwFNqSlM5akmj6VSyXy
         Sc6C0cvtdBdpCUEYfyJc68M1k3pH8EEHa0IHI8pUs4H4TfHHrn+6VmtaPab3zV4qq7eO
         hEMg8zxMn2F1yOfYquVtk+I+AUQZBE4jkR9mEUPlj3tdQRw6Vt+TE/GGIon9ElqiD4PN
         yI/S0Q9cfMqMRc3IFlN45DIKDiC21PQzPyHJkTtODRz7yt8gq7gIztre7EgglMOadFu7
         wXYEE5S/ru38L08iXGfo2fTCQxaynkAbRjQh4pNWQNMAlmQN/M3A2wYrpfIt/WXPm+6g
         1z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698647802; x=1699252602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLGyBN71ig0nMymCuCLKkacyzibJ7xa5D2WqyZj27OY=;
        b=kJmjb7pZr1MiG606BRHa1eKcsf+KOuvTCRyJP6Lp9NdNS1c8PWRsXAGIedXxehsbS0
         y0r7BhTrP9wt6U55HC9hgckog0J7Ni7sktMQ3Gm01Qgf23T6inr5zHfEdl0lMTUYg5M8
         msj4/vtn6JN/dXo5ypBU8r1Y2Iqt9JvpASS+0p4FyGy9flc1deI8NEmYbOE7RzUXzV6C
         s54R2zEJ3jWDPwRNzETWz3RjhB/HHgMMQ9jlNSdvgoM+k7xzcLOQkZMND7dnxaQe6taK
         OznY/jCG+FHuKQohHIfd67B71C/2+oWVi7jxG92UdTChiKB/5RqVjhw8qb5haJRaryoT
         eJ1Q==
X-Gm-Message-State: AOJu0YwDqqz47MhzH2dxzahkBQskIOZ+1GhcFB8fO3OYgSjsebX4dLlr
        oTjSbD34OUfjT5KkrOQiyxU2Dg==
X-Google-Smtp-Source: AGHT+IH3pBdnXH3s0zDzHQCMvnm0VDiZYNtQVkUud9hJp7A4dxQxJAB6t/umZcGXjtCCqEtHF9KK/Q==
X-Received: by 2002:a50:d658:0:b0:53d:b5bc:6415 with SMTP id c24-20020a50d658000000b0053db5bc6415mr6595145edj.15.1698647801781;
        Sun, 29 Oct 2023 23:36:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.98])
        by smtp.gmail.com with ESMTPSA id q20-20020a50aa94000000b00522828d438csm5662955edc.7.2023.10.29.23.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 23:36:41 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     akpm@linux-foundation.org, kuba@kernel.org,
        konrad.dybcio@linaro.org, heiko@sntech.de,
        quic_bjorande@quicinc.com, o.rempel@pengutronix.de, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] mailmap: update email address for Claudiu Beznea
Date:   Mon, 30 Oct 2023 08:36:32 +0200
Message-Id: <20231030063632.1707372-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Claudiu Beznea's Microchip email address is no longer valid.
Map it to a valid one.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a0a6efe87186..3b174b06c0ad 100644
--- a/.mailmap
+++ b/.mailmap
@@ -127,6 +127,7 @@ Christian Brauner <brauner@kernel.org> <christian.brauner@ubuntu.com>
 Christian Marangi <ansuelsmth@gmail.com>
 Christophe Ricard <christophe.ricard@gmail.com>
 Christoph Hellwig <hch@lst.de>
+Claudiu Beznea <claudiu.beznea@tuxon.dev> <claudiu.beznea@microchip.com>
 Colin Ian King <colin.i.king@gmail.com> <colin.king@canonical.com>
 Corey Minyard <minyard@acm.org>
 Damian Hobson-Garcia <dhobsong@igel.co.jp>
-- 
2.39.2

