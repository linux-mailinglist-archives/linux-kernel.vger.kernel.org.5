Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC897689ED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGaCS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaCS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:18:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FEB19C;
        Sun, 30 Jul 2023 19:18:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686be3cbea0so3192573b3a.0;
        Sun, 30 Jul 2023 19:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690769905; x=1691374705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGe7yeLSCJNtOm6KMm1pCwSHsNpi9wZaHI6nfPlQl3c=;
        b=h5K+DYPqZFC60a4cycOBBwDw5B5aIbHbzVUDTSJ6TmYOhMYUesVIXYk0R0JFkg2WgX
         BqzQ34i+6GjiKS6oRSCiLl0ic6J9PuUs4c4QS6euPm/SL7qBhmuS6/kg/TKZzh+lNtD5
         K/cb62Lbuse0dW9UGOxZCzJrJBqDiopp9TjAJysFCOBEUGMBIf6InBjVzAcMwhwVWWjN
         OzOpHhxABYLhKR/ifh3OWwHVUjQX04a8Yf/2GsLMwiWsRj4Msd08iBqmJZ7caPgi1w9J
         rV8j/ceCuCZ1VYT+la25Uut6MLD8MoUE5y1wia1maBSuWyvnORxdF6JL1mnTNKn0/Wma
         xr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690769905; x=1691374705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGe7yeLSCJNtOm6KMm1pCwSHsNpi9wZaHI6nfPlQl3c=;
        b=BAe1vPwjkaS/yJyWuLuePiCuGvcMyhwmnDGSIMnoQxuj5P0bXR6OtL574ChxzC487p
         Y7IgGSdgm0Cf7My7x7KDt4pKEPhUinbSOqQg0y0Obl/pQrtAcoT+ieaNGNUyqkZ+FBP2
         AfI7klSDfRud9lB4wb5EmbpCjICtFRM5QTvLe4zkOuNX4PK2SK/Nu6NpLKDZCkyzkxfr
         050nHCB1+bxHn3s5jvKz32kCFQ0kKQiPJ6xAhqr1eOxXbFtxSXNKeV84F+BKwy/PzdSS
         Ylug0Ede4S9aAbJjIL3ZtPPJNRpkZAUrwdNBndDxoOp66Ce6wdM92fO3GckeiRloRRPR
         FUtA==
X-Gm-Message-State: ABy/qLbe1pkPCKZhvQHCIQXoQYRe9fbmx1yAKVC/ayGcRcTsxPjwWuno
        yDnTv60UkFC8ImGRcfiwEGz6RI/heo/PT6yN
X-Google-Smtp-Source: APBJJlFEz/QKJPg44Ka8GKBHJeWwG0oxzm4iA/VEL0cm8A0/7em09GsIoQpzhFflx+zfO6TcGfEObQ==
X-Received: by 2002:a05:6a20:3d21:b0:10b:bf2d:71bb with SMTP id y33-20020a056a203d2100b0010bbf2d71bbmr9643953pzi.27.1690769905200;
        Sun, 30 Jul 2023 19:18:25 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:f50b:8f24:acc4:e5c])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78041000000b00686bcfb5a34sm6460022pfm.124.2023.07.30.19.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 19:18:24 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] fbdev/amifb: Replace zero-length arrays with DECLARE_FLEX_ARRAY() helper
Date:   Sun, 30 Jul 2023 19:18:08 -0700
Message-Id: <20230731021808.24997-1-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Replacing zero-length arrays with C99 flexible-array members
because they are deprecated. Use the new DECLARE_FLEX_ARRAY()
auxiliary macro instead of defining a zero-length array.

This fixes warnings such as:
./drivers/video/fbdev/amifb.c:690:6-10: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/video/fbdev/amifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/amifb.c b/drivers/video/fbdev/amifb.c
index d88265dbebf4..f216b2c702a1 100644
--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -687,7 +687,7 @@ struct fb_var_cursorinfo {
 	__u16 height;
 	__u16 xspot;
 	__u16 yspot;
-	__u8 data[1];			/* field with [height][width]        */
+	DECLARE_FLEX_ARRAY(__u8, data);	/* field with [height][width]        */
 };
 
 struct fb_cursorstate {
-- 
2.34.1

