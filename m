Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE62787E14
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbjHYCyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbjHYCxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:53:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BFD2686
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:53:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdca7cc28dso4794765ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692932008; x=1693536808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka8P5b/GzyZWqOM50pHONHl9tEIZnwSQ0LsDJccYJvI=;
        b=BzlEs8cAdigCMb3vJPqRNzIb1J1HMXhrk6+GbBQGA0k1l767wGfP7XvKmyt9yAyOSA
         4etFUTYoIV32HK7WWxK7y/MW35VnO29t51VsENsZjk8D0lNdCawf9uRWsfhEM9kerzDP
         pqrTeOgtNfEw/WuzoRZxu8+I4r+gFLu83Og5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692932008; x=1693536808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka8P5b/GzyZWqOM50pHONHl9tEIZnwSQ0LsDJccYJvI=;
        b=QzPf0dKBaHHz7fwgN16SXpg5eirbIyusR2CUQrmL7CrzZUeTuxHwrpJ4KoPpP/h2S8
         J9CtcFzKoG+yD2Acxjivy9Y0gxaEc5SkBjxRGGQx9EnXDya9RBFAe/FtcTKwGd2wMVhJ
         E+guyTX18k3cZfIrhRqn0uZvcRKSdB9JY94iDjESH2HR3hp1HXXRd+7211lFfe1OSYIp
         xG6RpmtsnAHaLH4ug9dmnubhgv9xy7DJ+dQITtuQu31bOtQxsjEovwUDWttZnabAK2p1
         UF5CUYUpaUMZgH0t7zEDQlgPTIDeWLa4tV8MBXdakVTVXcVzwpmAwBZQUxUcv8tyaSE6
         8DEA==
X-Gm-Message-State: AOJu0YyutPeGpcHGxM1VPBGWeoFQRpzMtYHE/8thp++zlC8EUC7CFSR2
        rWzLj3BL90h7+plf1gsZ+VaFJA==
X-Google-Smtp-Source: AGHT+IH938af/Jkw37fRHmw130aKNQYszXvCGp+5zNX3Tkto4r7N0993i9603PTTX5fDrm5uQLkqvg==
X-Received: by 2002:a17:902:f54b:b0:1b8:92fc:7429 with SMTP id h11-20020a170902f54b00b001b892fc7429mr20923761plf.53.1692932008269;
        Thu, 24 Aug 2023 19:53:28 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:9fe1:d4b1:42cc:882f])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902a3ca00b001bb0eebd90asm420847plb.245.2023.08.24.19.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:53:27 -0700 (PDT)
From:   Reka Norman <rekanorman@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Daisuke Nojiri <dnojiri@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Reka Norman <rekanorman@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 9/9] media: cros-ec-cec: Add Dibbi to the match table
Date:   Fri, 25 Aug 2023 12:44:02 +1000
Message-ID: <20230825024735.1443836-10-rekanorman@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230825024735.1443836-1-rekanorman@chromium.org>
References: <20230825024735.1443836-1-rekanorman@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dibbi has two HDMI ports which support CEC:
Port D is EC port 0
Port B is EC port 1

Signed-off-by: Reka Norman <rekanorman@chromium.org>
---

Changes in v2:
- Use a NULL-terminated conns array for the Dibbi match table entry

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 993deb85d3e2..21361eff50ff 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -295,6 +295,7 @@ struct cec_dmi_match {
 };
 
 static const char *const fizz_conns[] = { "Port B", NULL };
+static const char *const dibbi_conns[] = { "Port D", "Port B", NULL };
 
 static const struct cec_dmi_match cec_dmi_match_table[] = {
 	/* Google Fizz */
@@ -313,6 +314,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Gladios", "0000:00:02.0", fizz_conns },
 	/* Google Lisbon */
 	{ "Google", "Lisbon", "0000:00:02.0", fizz_conns },
+	/* Google Dibbi */
+	{ "Google", "Dibbi", "0000:00:02.0", dibbi_conns },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

