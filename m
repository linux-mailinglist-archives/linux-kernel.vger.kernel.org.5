Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4072A80BC77
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjLJRwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJRwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:52:41 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE5FA;
        Sun, 10 Dec 2023 09:52:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so644644a12.0;
        Sun, 10 Dec 2023 09:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702230767; x=1702835567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/xSfRIfAoE+xV2upe+TlMguoR16jHyW0kjGiJ1WVl4=;
        b=m3soUrjppBpEEXIPpzqk+qbycV5PtleaxwSZ75/N+SMVeZsU2KftZSonDqjqC9u1SD
         hV+c+ohS6u7bbnQAqfXqJbjfarAto5yk44vLXdbBJUKTvM1XaYIDeBB6oOCjJS/BV7M3
         ydkBs0+f/TKNSUgIwcFK8LW5f2YbjKUNv6Mqd9aULdqhWTltVIpqUwfFBx0Amw8SDTYB
         hEjjqsdsALwaY8v6NZmeeTgOt6bUZmfkmm0oFV/cQAKxwCkS46jdZ2GgaLB4TJWc3z0p
         e2s7MdWR4rlCcsT/XQUCnPdcWOmNh9V8d/PagqHlzgBKtcWZSWL3/aqmDF9aQIAMgJgT
         K/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702230767; x=1702835567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/xSfRIfAoE+xV2upe+TlMguoR16jHyW0kjGiJ1WVl4=;
        b=U5LX2Dt/fECiEHsg2IF/cmy0FVhcbrMybWvepTJACNVU5B/HUSTkeSsRCIGw403Kjn
         1nG9X5SKnBLTpr9ppOAEW7DW5C5vEwlGW7gylcKf4FbLQmkhKCBp0LZ5Pjw0PhwxZes7
         5UMQvFSZuD8aqekBfKWOI5lmaFhGIz7BzE1e3nYB8aQDVNmIHCwsel+qpgmFcz+L5d/h
         6lk/naWth/BTl5zqNzsBprqL/Pxly3IKz6/wQH1CnqbHnQSgap+WfDlRiJJt0eH8znH1
         j8OO7kc5yy4jJaPjsNjBiXBpIIzskapYl/M2soCP6Kd5ezHIbpl/7TeA3nQYpJ+e7Hol
         ly/w==
X-Gm-Message-State: AOJu0YyEFeQ+4JnqGtQdgDWAad+Qj0jqgditiUDyqvUK1m5EvaNMsfBK
        s9SwkdX9x7kJ9u5R45x9fUE=
X-Google-Smtp-Source: AGHT+IFu/zEyV8OL2/e2fr9uzatf6VKha/XZzrpfYgYGNJ/ZcPZ9ZlW39Cr4g0PQmSyj9ibLvOIkAQ==
X-Received: by 2002:a17:902:db10:b0:1d0:bb65:6860 with SMTP id m16-20020a170902db1000b001d0bb656860mr6145197plx.6.1702230767346;
        Sun, 10 Dec 2023 09:52:47 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001cfcf0fcc56sm5157868pln.84.2023.12.10.09.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 09:52:46 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     duje.mihanovic@skole.hr, conor.dooley@microchip.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
Date:   Mon, 11 Dec 2023 01:52:32 +0800
Message-Id: <20231210175232.3414584-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
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

In cases where mapping of mpmu/apmu/apbc registers fails, the code path
does not handle the failure gracefully, potentially leading to a memory
leak. This fix ensures proper cleanup by freeing the allocated memory
for 'pxa_unit' before returning.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/clk/mmp/clk-of-pxa168.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index fb0df64cf053..c5a7ba1deaa3 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -308,18 +308,21 @@ static void __init pxa168_clk_init(struct device_node *np)
 	pxa_unit->mpmu_base = of_iomap(np, 0);
 	if (!pxa_unit->mpmu_base) {
 		pr_err("failed to map mpmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apmu_base = of_iomap(np, 1);
 	if (!pxa_unit->apmu_base) {
 		pr_err("failed to map apmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apbc_base = of_iomap(np, 2);
 	if (!pxa_unit->apbc_base) {
 		pr_err("failed to map apbc registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
-- 
2.25.1

