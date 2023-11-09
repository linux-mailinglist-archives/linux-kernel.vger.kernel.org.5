Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09467E71C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345075AbjKISzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjKISzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:55:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94322D57
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:55:03 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bb744262caso295018b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556103; x=1700160903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/asJ9Dj+3Cx6KmENE4+zs0bPzpX4pHWbGWWiop9m2C8=;
        b=Kmu8gqFJEzPv8rm3FO7iehzUCYeFU9Ud0rLFmXNmGg6Z5G3lvBB2rPFFbXgW4U5+h7
         f5hTEu4Y4X4GBM6zlQf4ZT8U5yf7n0s9r0wBt6e1Ge4hOnjEUjoxCbNS1CQdi6ZOOZEK
         fbbJeqo8gNa6RhAkZWG2FEY+EU1osP3SvIPMZrSTh6wjCLfL0WWSo4KIJGxO3DPHbprH
         p1eVdTSZ6AYdHoZyvzP+8Saq6FIzZqJ4VBnhYh/EBzeYeKBggXGDuV8ECVGoaN9l0bXi
         A+0NI4PwKz6+FgQsROIkjimvhhVM7m0FC28UWe0cv/E9Q48BQr1Xk8Rno/mUUa50xmiD
         YQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556103; x=1700160903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/asJ9Dj+3Cx6KmENE4+zs0bPzpX4pHWbGWWiop9m2C8=;
        b=RlhnaLw3fjkrA9BEkv99kHrmfFB3/1nVVJn/z5YP0Lmwn4Uy6RCuLBhJOcU7xqVxAC
         t6dAciHWjbbJqKQr/MrQ2G3e6pGpOmKb44RiyGd0q8gLCGUtaKDlo6moJ4CKVzZi+0qd
         9J6yRh1/I5ygSnAaQBDQ0DkKVU1DARVo20IF8q2EJeOvZoY8Pd7lwcSMVlw/NYBbSOq9
         YxaZjntNnCN1X1te5A2LU/zN31NSB8JRK8ufBvvWzRvtlt2HQWMDjdsHgHQvSEi00pRh
         vwMEoPQpDZAghu3d5FjTm+zgiUhoEI5F4mmAkIU62A0hdBnkliq7+0r6Cic7PcYh8I9O
         z6sA==
X-Gm-Message-State: AOJu0YwFQWzRanASY/GYz539pemBMHrXON+vhOg5MvfKUl7h1NUhX8GY
        LMEIiye+aRJbtu3yZ2qAFhw=
X-Google-Smtp-Source: AGHT+IEBJK90gDyvFSF15Zd7y9xNPqkhfxe80VneNX35DCeNzc+cf8p1xhimbg9FPPlfKaG3sC+8mA==
X-Received: by 2002:a05:6a21:329b:b0:133:6e3d:68cd with SMTP id yt27-20020a056a21329b00b001336e3d68cdmr7081305pzb.3.1699556103276;
        Thu, 09 Nov 2023 10:55:03 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d71300b001c61921d4d2sm3821837ply.302.2023.11.09.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:55:02 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 3/7] platform/chrome: Fix typo 'noone' in comment
Date:   Fri, 10 Nov 2023 02:54:35 +0800
Message-Id: <20231109185439.1535962-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109185439.1535962-1-visitorckw@gmail.com>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'noone' with 'no one' in the comment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index ee1c3124d31a..85764e62cbe4 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -103,7 +103,7 @@ EXPORT_SYMBOL_GPL(cros_ec_sensorhub_unregister_push_data);
  * @sensorhub: Sensor Hub object
  * @on: true when events are requested.
  *
- * To be called before sleeping or when noone is listening.
+ * To be called before sleeping or when no one is listening.
  * Return: 0 on success, or an error when we can not communicate with the EC.
  *
  */
-- 
2.25.1

