Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E3791FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 01:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbjIDXYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 19:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbjIDXYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 19:24:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C929DB4;
        Mon,  4 Sep 2023 16:24:11 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so31226941fa.2;
        Mon, 04 Sep 2023 16:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693869850; x=1694474650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89D7o49G0wQ/V5O0EAZttNXedphXx9AjufFjeiwpyRE=;
        b=TDbKyjMfIIYy3JHwDPJp00B4mtNd08NcRKe/4ZogvK94u5zdVJKcOcFvOEQGorAlap
         6sVcaBMfP0fzwazhNvq893FQKW87sU3tW5x6x9I6F8di1g2qAi1XSWF6MLPplfm0DuHL
         YCFoRyZufp1euOHeFGY/poKZWzpv2njzRLTHJ9ELQHKMFeK3+pPwfnECwwJ8X86z/G8I
         6hkY1H+8FGQco4TTV0kztpBcP+YliwWP7srmUVX0Gb4/3qiCY/pdONsrjcAwWGlIcDSU
         Am02uepkoPuyMQmM0osmdr5izc0AO5Pz0kSTWKQMbQ69VqrnvvF+nNrFgAT/vCGuAGEf
         7UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693869850; x=1694474650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89D7o49G0wQ/V5O0EAZttNXedphXx9AjufFjeiwpyRE=;
        b=L7sj4OMc4PZWSRo0jtGlEpyq50/Sh0sRIc0U8/JZo/Bpo51gkrKsAlKits+8UDeBn0
         E4BeVuG940G9mIMW8uUhtg7rnl4gpZz50ZUPwEWbRSfz9ep/nWveLLzVvQh+l/tN1Pyw
         I2pKhL29iQq+xP6oFU60E4zg7k9sOpESPmIH86AlB5lmyrwmrM6OB4ANxKkOexUce5ev
         Qv5zdUdjVHdZFpZ2eH0IvAT2jLmW75JIe3owt3wXajASi7VOz0EsbNxZgYrhVU54v9kh
         6A0fxhrHj0Cnw4WtR1qAuAcT0irgzfjyHpgdvIJGTLL8RUuz34+H/8YCzyqR+B5vDdzs
         zi4A==
X-Gm-Message-State: AOJu0YxBItSrGi1mGB6MSxXv8XLsYT+8DIUx7o7YXaJUXBa6Wy3BWucD
        7X5btKJnYG7ipRCRI4DzNTI=
X-Google-Smtp-Source: AGHT+IEgH8SxwAw88XY34uc0352kFy2PHj4W/6vYs4wixrnKxM+40/ezYlU1pVx9TzD7Y4B81q6Hmg==
X-Received: by 2002:a2e:7015:0:b0:2b9:e24d:21f6 with SMTP id l21-20020a2e7015000000b002b9e24d21f6mr8852412ljc.20.1693869849844;
        Mon, 04 Sep 2023 16:24:09 -0700 (PDT)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id q25-20020a2e9699000000b002b6f1afd00esm2372543lji.107.2023.09.04.16.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 16:24:09 -0700 (PDT)
From:   Rand Deeb <rand.sec96@gmail.com>
To:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     deeb.rand@confident.ru, lvc-project@linuxtesting.org,
        voskresenski.stanislav@confident.ru,
        Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH v2] ssb: Fix division by zero issue in ssb_calc_clock_rate
Date:   Tue,  5 Sep 2023 02:23:46 +0300
Message-Id: <20230904232346.34991-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ssb_calc_clock_rate(), there is a potential issue where the value of
m1 could be zero due to initialization using clkfactor_f6_resolv(). This
situation raised concerns about the possibility of a division by zero
error.

We fixed it by following the suggestions provided by Larry Finger
<Larry.Finger@lwfinger.net> and Michael Büsch <m@bues.ch>. The fix
involves returning a value of 1 instead of 0 in clkfactor_f6_resolv().
This modification ensures the proper functioning of the code and
eliminates the risk of division by zero errors.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/ssb/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 0a26984acb2c..9e54bc7eec66 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -835,7 +835,7 @@ static u32 clkfactor_f6_resolve(u32 v)
 	case SSB_CHIPCO_CLK_F6_7:
 		return 7;
 	}
-	return 0;
+	return 1;
 }
 
 /* Calculate the speed the backplane would run at a given set of clockcontrol values */
-- 
2.34.1

