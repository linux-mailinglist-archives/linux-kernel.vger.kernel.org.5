Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460A777B088
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjHNEg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjHNEgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:36:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308BDE71
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686b9920362so2495932b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691987790; x=1692592590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw/GQaD3rU/TBdDdqv1FKm319ZdMh7XMHhK4oOmrPsU=;
        b=KatNqGsGMaYxzyICLAb1aNPS96VJXjgi4wqOangQ1EE3F01ND5r4MCspJg8i4p78so
         u+ujbs8pFRq4DfPYFH5HQ2ZBjvthy6kKTTak+DBCypQ5F6GgbI5F1IiZ5JfNyVXtLGxu
         bUt0mJTRZT9bO5Cq8yEcm9x010l0xHCmkMMt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691987790; x=1692592590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw/GQaD3rU/TBdDdqv1FKm319ZdMh7XMHhK4oOmrPsU=;
        b=bP+Oz8jtL5aXpqrFi+Lr0orSlVkhx2Nw9fOLlPU+u5vrAV6v3I+HXEtez0LOwL9W4L
         ZMbF76T0YIiFov92aqRQnZGJT2YrcLKNg19AAR5x53L/URqzGX2jSWIaDGpgnUdUwFZZ
         LF/f0o+wL71u4VIvR4bgd1tyTIFetpDrjUIehNWQKVm1Vm1WI7NqmDRBH06AEO17sccG
         mGJUqdco5Ju/O+4/M605luDVTjDV9h9+DDIf8jFZrdyUBAcQBvB0X1TbIp9xtFfwm9uc
         6qfmZLaHHqZx+6c/351SafBlyuZoB5TPbdih/z+x6U2DOjss3+SG0Z9TPWVm3RI8PCz1
         da0w==
X-Gm-Message-State: AOJu0YzK78NY38XS021k3+8bV9xJ79Crw5TkW2PzQpROnvVUfKhU4IpS
        /8943KuEc1JjFEXTd1G9V68z0A==
X-Google-Smtp-Source: AGHT+IErHRAwMUUMfXSyxd/9DtxgxyWOztaiQGKgeItEKpDF/uQEjh27Qutpj+qSs8LmqlSMCPq4qQ==
X-Received: by 2002:a05:6300:8003:b0:13e:e450:f4c6 with SMTP id an3-20020a056300800300b0013ee450f4c6mr7113497pzc.27.1691987790656;
        Sun, 13 Aug 2023 21:36:30 -0700 (PDT)
Received: from rekanorman3.syd.corp.google.com ([2401:fa00:9:14:4ae6:d1a4:27c2:80ff])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm6761865plb.265.2023.08.13.21.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 21:36:30 -0700 (PDT)
From:   Reka Norman <rekanorman@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Reka Norman <rekanorman@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 9/9] media: cros-ec-cec: Add Dibbi to the match table
Date:   Mon, 14 Aug 2023 14:29:18 +1000
Message-ID: <20230814043140.1108917-10-rekanorman@chromium.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230814043140.1108917-1-rekanorman@chromium.org>
References: <20230814043140.1108917-1-rekanorman@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index cfc0a204d591..29f9a464857b 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -311,6 +311,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Gladios", "0000:00:02.0", { "Port B" } },
 	/* Google Lisbon */
 	{ "Google", "Lisbon", "0000:00:02.0", { "Port B" } },
+	/* Google Dibbi */
+	{ "Google", "Dibbi", "0000:00:02.0", { "Port D", "Port B" } },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.41.0.640.ga95def55d0-goog

