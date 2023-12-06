Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9901A806C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377579AbjLFKow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbjLFKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:44:50 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0674F1A2;
        Wed,  6 Dec 2023 02:44:57 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce32821a53so2303569b3a.0;
        Wed, 06 Dec 2023 02:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701859496; x=1702464296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUbG7u0jbaZMkf4gI0vKWjEkxNyQgQiNc/X6JTyz4gI=;
        b=IFaFwG6/45k4eNk0ftGX+GZyObRX9W4aaF7P6ZeNPvKSAP1+YgD8Ge2a7PTlEw8XeI
         70H+VX5FxmrtKZhMtvnS7elnI0+ptxmmAk90FJ9xyssluED29Z+RMSkviJp5+6eMxu63
         Qhpei5nZRoa2sG5fwdHuwB6L0X/QlSifehePKUi/EuXLtor82KV1/PtHzgTQibUFuOfC
         QwgDcyavJkl8I3oFUDLmRiVrbhcVmjLa4r4dhhw9flJDlM2U3E2kPyGl6D8x4SA8L0db
         hQZ0UKpYENt7Kq3p5CUZ8DLzvu6v6d70yvzqG44Xt3dTPcyktWrZBimijObyo8D+Gkl9
         Ocpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859496; x=1702464296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUbG7u0jbaZMkf4gI0vKWjEkxNyQgQiNc/X6JTyz4gI=;
        b=H4atiZXlv6Gu7Z0H4LRZDZDpECgihT9Jb+MbUlK5CwKdi8cyLw/lZtg1sYJ3+/xaCF
         ZpOuwFOudxEXcXowdxzjgeTPJh+M31PYbjpS/mnqxV5UoAzKe9itSTstXL1gcO5MIDjF
         fPJ23QXgO+aT5KNNPXTRi3ml/qYWOTfH21otu3phHkTbRBOvK3/URGUnWmlIA5AvOZCy
         JS7ipoywqkQD7up1503+5gFLnuwS1aa37E32XMI78CVVj25xqz/3USNWT479eu9dNT3k
         ZN1PmyuejTMGZJc+bNevAsiJn050BmjWsnbt8EtUscwhSYOCJqUZbjVUnqR1bLh/1+ed
         uXnA==
X-Gm-Message-State: AOJu0YxTmr3Sum1QlVU1+CpP15Pw9OkQJNAP/e8otPsUfZAF6JeDORvR
        C7mtBhoTdIon3wItySP8vetgJ1gmUg4=
X-Google-Smtp-Source: AGHT+IEOvnRPONAZ08KIyNsSU3q0UEwbfqeKstt/+KCr2hQhuCEy/WZh5KH+oIOiJ56oeNICNJZnig==
X-Received: by 2002:a05:6a20:c1a6:b0:18c:23b0:39bd with SMTP id bg38-20020a056a20c1a600b0018c23b039bdmr529458pzb.16.1701859496131;
        Wed, 06 Dec 2023 02:44:56 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090a2a4b00b00286596548bcsm10020811pjg.37.2023.12.06.02.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:44:55 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 3/3] ACPI/NUMA: Fix the logic of getting the fake_pxm value
Date:   Wed,  6 Dec 2023 18:43:18 +0800
Message-ID: <20231206104318.182759-4-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206104318.182759-1-ytcoode@gmail.com>
References: <20231206104318.182759-1-ytcoode@gmail.com>
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

The for loop does not iterate over the last element of the node_to_pxm_map
array. This could lead to a conflict between the final fake_pxm value and
the existing pxm values. That is, the final fake_pxm value can not be
guaranteed to be an unused pxm value.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 drivers/acpi/numa/srat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index d58e5ef424f2..0214518fc582 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -183,7 +183,7 @@ static int __init slit_valid(struct acpi_table_slit *slit)
 	int i, j;
 	int d = slit->locality_count;
 	for (i = 0; i < d; i++) {
-		for (j = 0; j < d; j++)  {
+		for (j = 0; j < d; j++) {
 			u8 val = slit->entry[d*i + j];
 			if (i == j) {
 				if (val != LOCAL_DISTANCE)
@@ -532,7 +532,7 @@ int __init acpi_numa_init(void)
 	 */
 
 	/* fake_pxm is the next unused PXM value after SRAT parsing */
-	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES - 1; i++) {
+	for (i = 0, fake_pxm = -1; i < MAX_NUMNODES; i++) {
 		if (node_to_pxm_map[i] > fake_pxm)
 			fake_pxm = node_to_pxm_map[i];
 	}
-- 
2.43.0

