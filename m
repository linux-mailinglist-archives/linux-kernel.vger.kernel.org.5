Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9595C80BCC0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjLJThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLJThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:37:04 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80661E8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:10 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d05e4a94c3so32649035ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702237030; x=1702841830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGvQkmHI/tfswWBbqQpidgaN+RSpZU90FgpOfkdldLY=;
        b=a0lWAmhw9OUCYBlLGDmZsQKvuA0C5LUpPB2Nu7MVPp2cBPTjbfFOGehO2JzmvOMsF7
         qgX0NMssAxmFx+9P9FQRUgvYcqwPCXxP/gsS9B8gG4dmlHHc4f57dxbwd4v5rGF7VQTM
         9bYSRmlAz/1G4PyGHJLyZKCHwpPI6F4rOCsa7wi2u8RXv6eH1bdASyUZix7K1zuFBH7r
         kiPCc2atgLNmRboDSx68mmrkAk0O3uL4KBU5f9UlOMnPey7dukMWm86aB1Nb1NG8Y5zP
         Xp0lzc4iB2dP3034X6eTFg1zhYETOZIOqBLG5+eMyTHnHyEkqYprA6uBMElZ7RPfgbF+
         w1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702237030; x=1702841830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGvQkmHI/tfswWBbqQpidgaN+RSpZU90FgpOfkdldLY=;
        b=tw+V9vEVhD2XXNuKv9gjWMCChfcwnO0PZmWP3cfjk0tWB2Fupy0hH0BkSIWe7vFvmP
         oMJu7/gHNYdN8KFcEwCGE5Crh8R4Il0rO4H/N7l/XxSpzRx0hPgbGQES0g7yHKEAC48X
         Q+s4GzKpDVNTZn5NJe2RN3l6eKzbtnNQEWb51b51bh0R0UA/1iNEZhLU7YaFQA1eaa0h
         M8zNk0sX/rT7qTyOFD+2zPeTh3kmGIT8GK32nRMVpEumioRA4BYW69mg45fRd+0u3UGU
         OzrgM81WxW9HWOd1BMNoJUDTftow5YHARc1Op4VtGiM6/jrdStQygPSEvs5n6b3/0XV2
         GKqA==
X-Gm-Message-State: AOJu0Yxo7MmeAk5Ss3InDuTh3jI8CJqJBwLK9ggvtllUL8PHvGhAvEUF
        3U4b6TJSrXxTVO3VMTrkSx3AOQ==
X-Google-Smtp-Source: AGHT+IFn+Rbm8Lhkot6oQkSbdtOhnzqfLtM6bPltdj5vLC0YYwYcnYzpWCLBpXMRePkV3WAlXgjBFA==
X-Received: by 2002:a17:902:b28c:b0:1d0:6ffe:a16 with SMTP id u12-20020a170902b28c00b001d06ffe0a16mr3348585plr.116.1702237030045;
        Sun, 10 Dec 2023 11:37:10 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm5117419plk.171.2023.12.10.11.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 11:37:09 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 1/4] Staging: rtl8192e: Remove variable bFirstSeg
Date:   Sun, 10 Dec 2023 11:37:02 -0800
Message-Id: <20231210193705.2131807-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231210193705.2131807-1-tdavies@darkphysics.net>
References: <20231210193705.2131807-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable bFirstSeg as it is defined but never used.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0a8c44e497f5..c0a24826cd3b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -103,7 +103,6 @@ struct cb_desc {
 	/* Tx Desc Related flags (8-9) */
 	u8 bLastIniPkt:1;
 	u8 bCmdOrInit:1;
-	u8 bFirstSeg:1;
 	u8 bLastSeg:1;
 	u8 bEncrypt:1;
 	u8 tx_dis_rate_fallback:1;
-- 
2.39.2

