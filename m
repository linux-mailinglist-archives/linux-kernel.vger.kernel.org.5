Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4B7689A0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGaB3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaB3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:29:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013A0E7F;
        Sun, 30 Jul 2023 18:29:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-563d3e4f73cso2182174a12.3;
        Sun, 30 Jul 2023 18:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690766990; x=1691371790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xIIhCDOH7Yz5qlTpKDXtZZdnWeyGOEAV1deFecuA5Bk=;
        b=CIMHYVILe2Ga9K6PB29WGrUwogEpNfAI7k3CSKpE0izeGeu8/SbFoosF95BUu2DCsx
         JIB03K673qERBb7DmlesQTmPnwqNekjJgmLl4poc4fJ8Xrpf7Vv6zofSocLGa+hTKJEe
         tp8ZpygEwFs9xQ2VKk0m/VYYxlUlFie4AvCeLh+285B+aaSZfp3jrDyYGjNV2eM+IFCp
         NuuCt/aWv95SnxXDenDbb5sdaxKqLOmyzIS7inIh0xrIsfN3BLs8pz1mlhxejez3zC1C
         NKbfK0rzDVia3XNWtO7FikMzlTKFIeUqqyzygJ06vKXErfk6xQdfojA/q5tiIFnamii1
         so9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690766990; x=1691371790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIIhCDOH7Yz5qlTpKDXtZZdnWeyGOEAV1deFecuA5Bk=;
        b=YQsbHgO1t2lORpnvEkuJZuE+Pz80KWM3665FCoBPOF82Wpn0HX29mRSrdTULlFN15y
         0FfhyH7BuuTCp3aYLtAOoNmCozNhrVcB56zuLqe38XEtJeHeqZ9pYTNWXckHfutfMJV2
         Xn8cAGmj6L7Ql9fP7hAu188h6QmgLUkUXjTs+HePj1xxi+cW1Uvj6ViZlYLopctEkOxH
         Y/yN4SOQUII3z8nGRUTtnetXJ3SgwKWJvpccLCEQs8C+/l0Pxlf5DlrS0FydkatMBRiT
         zPg4l6gSIIbrSe6kctCEkE0Ncp+DtyqfVKE2fzfUqBBk+eSKNlNw8KqLcPGkEIVyM0Zt
         m14A==
X-Gm-Message-State: ABy/qLZ0xAXEAdOJITLNXksRsZf+DrETvwYz7JUitAu6/JZ14iF+dxea
        4Rt9/eee7nGVRqiqnLFkJALRPJAK3gU9wQ==
X-Google-Smtp-Source: APBJJlHZ6HcObPOdibXv5PwgRtX5UYPrYVpL9EBylHOssbj0fI2JjX1oSSInlzrjssBpbInxGRzJ8g==
X-Received: by 2002:a05:6a20:840b:b0:137:514a:9835 with SMTP id c11-20020a056a20840b00b00137514a9835mr10050395pzd.9.1690766990276;
        Sun, 30 Jul 2023 18:29:50 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:f50b:8f24:acc4:e5c])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001b891259eddsm7141277plz.197.2023.07.30.18.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 18:29:49 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] ath6kl: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper
Date:   Sun, 30 Jul 2023 18:29:41 -0700
Message-Id: <20230731012941.21875-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because zero-length arrays are obsolete, replacing them with
C99 flexible-array members.
Instead of defining a zero-length array, use the new
DECLARE_FLEX_ARRAY() auxiliary macro.

This fixes warnings such as:
./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..bb3771a3897c 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
 	__le32 cmd;
 	__le32 address;
 	__le32 value;
-	__le32 _pad[1];
+	DECLARE_FLEX_ARRAY(__le32, _pad);
 } __packed;
 
 struct ath6kl_usb_ctrl_diag_cmd_read {
-- 
2.34.1

