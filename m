Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB276F92D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjHDE4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjHDE4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:56:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C244226;
        Thu,  3 Aug 2023 21:56:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686c06b806cso1209054b3a.2;
        Thu, 03 Aug 2023 21:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691124977; x=1691729777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eHfAQPBbBkch39+4DVNDl4OjmPDthClYpWhqWwd4JE=;
        b=TjBfgpSkhP8bGjYxDPmWGrhGPMznIowaeh4SWMkAGqMzsdhQUe2aigQ0Eg2SCUGh8l
         kPjGjo4kAAc2RCm9Us/KbQF1SkMMJT8TVIc4f/h8zs+IGawEUeCLOJFSxpEIyrptbIfB
         ETAiEfBqtE/H/w4H2U6ewoUAa+e+HVhWuaHToNdRA+hWi3lWo5JA+9RtAWPJpOb6mSk8
         FUy7J3Er7AMgyQBK2UIfPwlbGn8f/OiWj1l044yc78tVUysSJteh7VTn0TEu8x2zT3LK
         tEunxS0wlCTH4C1tq8o6wWIfEHsyEk0X8pB3UaCIFFhxyFwuemyXYqsRN8Yp2nl5rNO7
         mMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691124977; x=1691729777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eHfAQPBbBkch39+4DVNDl4OjmPDthClYpWhqWwd4JE=;
        b=HAVib4hEYEr1+TzmKxeakscbacKO3J5pecG5NcjSSuwgiiQgkoa3NjxELB/BrfPyVC
         vHcz+DGe7ol+cS/XfppAU4qbE5DTYuXNJPctvXv8TWDO5nluMilUqlHHd44VEc/RuphD
         +dA6V1zlbUJlqzj/V5j9Qlg6IhL6NQ7O5M0RyG0FRGMteMPawfL8er/59CdOP1iuAP19
         etKddEZqNIp7Ei8ZH+vUdL4U11HqE5oHCnWwwPsvY5ggLBKEAtF4Tub57AcSUzylPdze
         uLmP9yrRjChb8OJecLPuFiEf/5XzXHOl0Ww6NcOSFSWOPYiodSHQoh/W6mQMn5ISjDyu
         ITUg==
X-Gm-Message-State: AOJu0Yzq+7sVdIOgLyc1Dt8p6P7TTu9aH+q31zqjoTcq/u/ugqP9kw1T
        Ul8iw9mwIwksJanM+dHj67M=
X-Google-Smtp-Source: AGHT+IENLKZYCcOhv/BWrcaX4ZEruyz71Ke6GAWDWoyw47ImxqKKmIpDnPRLxx5DXy/ng8trLzyDbg==
X-Received: by 2002:a05:6a00:1488:b0:687:2d68:f30d with SMTP id v8-20020a056a00148800b006872d68f30dmr683853pfu.23.1691124976588;
        Thu, 03 Aug 2023 21:56:16 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:9428:7df2:aef6:7a3e])
        by smtp.gmail.com with ESMTPSA id fe23-20020a056a002f1700b006875be41637sm669371pfb.145.2023.08.03.21.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 21:56:16 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] ath6kl: replace one-element array with flexible-array member
Date:   Thu,  3 Aug 2023 21:55:54 -0700
Message-Id: <20230804045554.6934-1-rauji.raut@gmail.com>
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

One-element arrays are no longer relevant, and their
place has been taken by flexible array members thus,
use a flexible-array member to replace the one-element
array in struct ath6kl_usb_ctrl_diag_cmd_write

This fixes warnings such as:
./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 5220809841a6..c8ecc9e85897 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
 	__le32 cmd;
 	__le32 address;
 	__le32 value;
-	__le32 _pad[1];
+	__le32 _pad[];
 } __packed;
 
 struct ath6kl_usb_ctrl_diag_cmd_read {
-- 
2.34.1

