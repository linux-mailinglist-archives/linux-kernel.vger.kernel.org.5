Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D126B793437
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 05:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjIFDsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 23:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIFDsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 23:48:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0582FCDE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 20:48:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68becf931bfso2137476b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 20:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693972106; x=1694576906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHbiCFKLUfLil5isbQnLzf0GOgVgYv8bvassy9B1MX0=;
        b=Fbzkun3Uq3JN9ZT88ql5XXwVrkc4MXCoLMVo7Lkny2pPMyswixU/rD67DSB8aIl0S4
         D9jZbWQL2Ie/P2v+ag5pepPT2cTl6wZ6aYEJi6l7xc82VynlKnP4CJZO7z6wG1NLjewi
         y1Z2XUHaeJJpi8F0PE1vg8mza7XoB3KuMpoQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693972106; x=1694576906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHbiCFKLUfLil5isbQnLzf0GOgVgYv8bvassy9B1MX0=;
        b=lPt2vgTWkgo+890w21asl6pN8J2T+nofMI3jZJFRj8wEXK51NDe0btTXwhyvPaS4n7
         Gqi5yI6hpcFecSU5xNqqyWwN1SMJfwRT0ZMISOVdt4rWumS+yjM1Kn8Qwky8DUMaEPFb
         RLpDkYkzprSCWh7TVkJXvfu3cRXO5cYgkuOytqiR0S0G1VP8GVRo5VR/TlNv3anm7Wb9
         e1ADs3L6nV0NVsi6jS7jO7qoQv0476F6UdC4Y7AP+G47TupLpRkEOOTgXGdeZyfbIYwD
         BBPHM60xl0v6anbFCJL6uzmBvezmtMHJkshUBA27xr5ttb4Du+M7gkIK7IuLHjhpIYkz
         M+vg==
X-Gm-Message-State: AOJu0YwZFmUy9hBfEC5sb2nrE1HF66xS2n5NizceWeWFW6Q0NUGF5WIP
        2MSHaFxaQgMlcGDzpptJWa690A==
X-Google-Smtp-Source: AGHT+IEfBFyuRE179ncbBF5Ov7H3fAHeAS4pUc6JiOzfI5o+7NgdVJZxahNYpRadcJ1EHhOWEtI5JQ==
X-Received: by 2002:a05:6a00:2d04:b0:68b:ff3b:e140 with SMTP id fa4-20020a056a002d0400b0068bff3be140mr14996009pfb.8.1693972106237;
        Tue, 05 Sep 2023 20:48:26 -0700 (PDT)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id x16-20020a62fb10000000b0064398fe3451sm9766317pfm.217.2023.09.05.20.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 20:48:25 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Avoid redundant authentication
Date:   Wed,  6 Sep 2023 03:47:55 +0000
Message-ID: <20230906034754.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While executing the Android 13 CTS Verifier Secure Server test on a
ChromeOS device, it was observed that the Bluetooth host initiates
authentication for an RFCOMM connection after SSP completes.
When this happens, some Intel Bluetooth controllers, like AC9560, would
disconnect with "Connection Rejected due to Security Reasons (0x0e)".

Historically, BlueZ did not mandate this authentication while an
authenticated combination key was already in use for the connection.
This behavior was changed since commit 7b5a9241b780
("Bluetooth: Introduce requirements for security level 4").
So, this patch addresses the aforementioned disconnection issue by
restoring the previous behavior.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested CTS Verifier 13 Secure Server test on a chromebook with AC9560.

 net/bluetooth/hci_conn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d5057cef30a..27c0a3080631 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2420,10 +2420,11 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 		goto encrypt;
 
 	/* An authenticated combination key has sufficient security for
-	   security level 3. */
+	 * security level 3 or lower.
+	 */
 	if ((conn->key_type == HCI_LK_AUTH_COMBINATION_P192 ||
 	     conn->key_type == HCI_LK_AUTH_COMBINATION_P256) &&
-	    sec_level == BT_SECURITY_HIGH)
+	    sec_level <= BT_SECURITY_HIGH)
 		goto encrypt;
 
 	/* An unauthenticated combination key has sufficient security for
-- 
2.42.0.283.g2d96d420d3-goog

