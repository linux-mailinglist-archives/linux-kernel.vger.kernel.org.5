Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8A7E8C7D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjKKUPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:15:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A691D72;
        Sat, 11 Nov 2023 12:15:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d849cc152so2083476f8f.1;
        Sat, 11 Nov 2023 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699733745; x=1700338545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTOgoglzH1EfgfbAUkYEAdJDDyQ75EjhLpLWQWUsyKw=;
        b=OPq1mZjMwX7fzEr3asVl5HeYCbTv3mir9KdSj4ZL8exwwwaA0Yc9tUnW/Fw973fiKj
         lO4eHs0W4rbElQ+5Gs2jrjdnFtzf2KXaImUxFms+8aD2det7xPkcqlAenwH4OJeanCuq
         NVzImi80cWraJQEiHh+Gzt6VRY+qkdsWFRP60y4hHVPvWZStprfyPiCzKFB4UdxC6DRY
         dL0owwXXRfNLBewIuUBQpBY831aafGJFbehQjHjLwn/OS5/YtIdRrdNgqPObiasssUFl
         Myf1IcdnArpH+LpmSPw/QPYaoTZD9kuIXVfV8NCOcqpa+3O7A0DgnZIuRXWILf1qgqPl
         6X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699733745; x=1700338545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTOgoglzH1EfgfbAUkYEAdJDDyQ75EjhLpLWQWUsyKw=;
        b=t/1Vuj7QCGv2utB95FYstD8glToyiwLLrIiZQ86qjVfuJscCwHgpBAw9ZXGKB3PkpU
         K0okqJgBr9yFDgeejROP4Yls8IKfgPGbBdJvfHooNs3XVZMUwZCoBobgVUw8s/uRdbcB
         /ct+J9gRfpFx0a16+zQ5IU22NI5wpZyJNvQEIr3tbeDrfM38yWjvGAnFBr7nqg+Qi5+u
         Rsz0UuSeLQAkm3I68htlwpxLw/hHx/hp/ZN8jTUkj/gI7xAxvoizM1kPVR+HRzWzit93
         nNrjz0oI9ijVNrxBPMdjXn1ypuEDZP9wH9lqQgl4vH1g8l2F9Tpxb4wq/RVBLwpRba7U
         lFAw==
X-Gm-Message-State: AOJu0YwcUdMmTkA0EkiB2+S9mQOWZ1rUAkwLe/AiNmR3cQmlg2tZK2V9
        KyyUZSXUpZgF9keisoR/HTRd+XfKRChnWQ==
X-Google-Smtp-Source: AGHT+IFgiQRYKSq1NmQS1+Bhfx9HsQFZ4b1N8o9+pr49u0Kien+9aI/5q1hIK2Nah+N7Hq5DvP48Zw==
X-Received: by 2002:adf:eb10:0:b0:32f:7cea:2ea2 with SMTP id s16-20020adfeb10000000b0032f7cea2ea2mr1806062wrn.17.1699733745417;
        Sat, 11 Nov 2023 12:15:45 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j30-20020adfb31e000000b003197869bcd7sm2105431wrd.13.2023.11.11.12.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 12:15:44 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] thunderbolt: remove duplicated re-assignment of pointer 'out'
Date:   Sat, 11 Nov 2023 20:15:43 +0000
Message-Id: <20231111201543.338893-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer 'out' is initialized and then a few statments later being
re-assigned the same value. The second re-assignment is redundant and
can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/thunderbolt/tunnel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 7534cd3a81f4..8d45cb4f04ab 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1313,8 +1313,6 @@ static void tb_dp_dump(struct tb_tunnel *tunnel)
 		      "DP IN maximum supported bandwidth %u Mb/s x%u = %u Mb/s\n",
 		      rate, lanes, tb_dp_bandwidth(rate, lanes));
 
-	out = tunnel->dst_port;
-
 	if (tb_port_read(out, &dp_cap, TB_CFG_PORT,
 			 out->cap_adap + DP_LOCAL_CAP, 1))
 		return;
-- 
2.39.2

