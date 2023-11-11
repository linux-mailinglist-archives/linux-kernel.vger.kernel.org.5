Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74A7E8B0B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjKKNZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 08:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKKNZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 08:25:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1273860;
        Sat, 11 Nov 2023 05:25:33 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso2626626b3a.1;
        Sat, 11 Nov 2023 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699709133; x=1700313933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwtFYnbCixJ5Fw6NUaR3fegQwEm8FPc3qFzpDeBrueY=;
        b=kdWSE9MMxcI+tm+OdKDxN3Q05fvAQCS/PFX7XRYa5BSL8StKy3avy29o7FbVBlFWzp
         8+K/0d6/e2g9J0f59Th8iHd26xr6Y+QsNKQ+83Sy2nPYH4VPHghuiN8NZR1/aBrJ9hC+
         VbPmU9FlybJbay6PZg0X1lGVUh5Nd5SPmU7gluc+DEBbZ6E45qpaS/n0mMFITeAwx/nJ
         aWAdhP54pXR95R/QykPwIA88vkPeaq50KIBcgpNlbq4qoxXanyASDLU6ehC90L+CN9hD
         p/r29Kq07jz+4EFyDtNKig1rCFKBlmYI8EDSyju7YAYb+izVFE6j4q1Mi0POAQkOCXKw
         n9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699709133; x=1700313933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwtFYnbCixJ5Fw6NUaR3fegQwEm8FPc3qFzpDeBrueY=;
        b=hDyuL8gOBy4ntqveMFxthT/jCVdvQLcqwcnZnsB6DfdAZvKsHQpgo19S9T8PLYWbq8
         s/HEO96hY3IYPFR5zEIu7ACrosradZMfPV0ZdHIbzLNiAQ8WihfHA3meOrqo0ui3i+v9
         FJFFsv5xQMBHpQdcstCb1FizbMNA+MDqKK9WmJzsyke+Brtc+exvvtSOqQRDC+OsF1oO
         Xj8bpJmPtojk8XpE7vgZz5xnJqq/kEAfqDMLwbK+4tq+sbr+yTa8INg8stbt9FfiJauL
         nPx01HbOiiVBcVQwTq7MPZGWIcEtOGz07fOVlqW4ZmddjZ2xAADFpVEQKhxAWGfLEJwS
         KHCA==
X-Gm-Message-State: AOJu0YyCC/NoHJyobx06SJg2evMDGv2PnH9X2j39ULtz9w3vHWhutvFc
        t0dULoXV5FqervuzhyTRl38=
X-Google-Smtp-Source: AGHT+IHzPYtkMKz6ouq/FZCD4NwGSwnTHf+SSme6Hnr+Nv2gUfZx1e8fPlKl8X1fv5+5mGe5ARLPYQ==
X-Received: by 2002:a05:6a20:8e27:b0:13d:17cc:5bca with SMTP id y39-20020a056a208e2700b0013d17cc5bcamr1333545pzj.18.1699709133206;
        Sat, 11 Nov 2023 05:25:33 -0800 (PST)
Received: from localhost.localdomain ([112.96.225.120])
        by smtp.gmail.com with ESMTPSA id ka16-20020a056a00939000b006c4d2479bf8sm1265616pfb.51.2023.11.11.05.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 05:25:32 -0800 (PST)
From:   "shiqiang.deng" <shiqiang.deng213@gmail.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "shiqiang.deng" <shiqiang.deng213@gmail.com>
Subject: [PATCH] ACPI: custom_method: fix a possible memory leak
Date:   Sat, 11 Nov 2023 21:24:02 +0800
Message-Id: <20231111132402.4142-1-shiqiang.deng213@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cm_write() function, memory is allocated,
and at the end of the function when uncopied_bytes is 0,
the memory is freed. If uncopied_bytes is not equal to 0,
a memory leak occurs.

Signed-off-by: shiqiang.deng <shiqiang.deng213@gmail.com>
---
 drivers/acpi/custom_method.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index d39a9b474727..5103c7c3a6ce 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -77,6 +77,9 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 		if (ACPI_FAILURE(status))
 			return -EINVAL;
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
+	} else {
+		kfree(buf);
+		buf = NULL;
 	}
 
 	return count;
-- 
2.30.0

