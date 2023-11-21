Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9935A7F28FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjKUJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKUJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:31:12 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17690100;
        Tue, 21 Nov 2023 01:31:08 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5094cb3a036so7661661e87.2;
        Tue, 21 Nov 2023 01:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700559066; x=1701163866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOnUzuQDBggWhNdHYi2KbvHTCpEUQcBbCUkPZOXLJMI=;
        b=O9RDxc2CR1pFN0BTJw8eXhF1B3+WskvIlSnFHiq6VzA6jN3kQKK3t4sOxuv7CiN2jG
         k1pXMvprQq40GF9tuOMmAhK3fPU3Q5dZBV/lh1hDIcV3M90Z1qj4LYu6K8xjFm9fFeuH
         BIW8dhabKjpR+0p3f9uA+dhcx1zvN9N1PNJMh6hKaZOjTCmHom1O8xb/EGPMyPG6AcvX
         RGBKC3CqDDSQ16MhYf3JOcWPvOF5RJcazvOb9QccGLnrGL+m76nrs8N278rz0tWJK5Ei
         w5LBRilkUAA7x70dk1zOLfdG4OJuYkhxxdNPkcOHinxRDjENw/gLP9jGoj6pzco24S0T
         rjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700559066; x=1701163866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOnUzuQDBggWhNdHYi2KbvHTCpEUQcBbCUkPZOXLJMI=;
        b=EUix3Kt7wsAC3Gb+2RFwbwcn3xaPZSNnXLyQl2k8l1PsUxVoprg7wNk6KAWUJNgNhI
         t/KG+RRvy+sP1bWjQ/dUCrqCM81iLQHUv0hjKZT+98LalDdzADwpNZCd9FsiC9hEETAx
         oLSPFQJ6hDMbxFf7NguLd5LmOtsQnDbkE0QRhJY/NiMdwI4b8QiD+KD4QzOnFwLuqD3g
         bXJe1IdjKdGabS7gPaS5lL7hatMX6UJS5F+hcNrsFu/OODaV4l8+TMfDn4cjUFek6Y8J
         GsCY2WnvYEyOa8JBjuj8IHhuP0wTBj0uz1udnrj0ZnhjWW61Cns+u7F1cAUv+F98VN3l
         dl7Q==
X-Gm-Message-State: AOJu0Yz7TUhLQoNd0EEXGyV3BVoXOCp/tunkRcSFQdthIZAw7UR57Osz
        aakIPUs/TKr0ImZVJHWHCXpxS8zOAfI=
X-Google-Smtp-Source: AGHT+IE4eQB4cA3aYZWK/OPohjS9ZmEPQWNpqmMqWMOp6tks6PP0oZXidEFO3nLSlSCUfTojbZWIGQ==
X-Received: by 2002:ac2:5b1b:0:b0:50a:711d:23f2 with SMTP id v27-20020ac25b1b000000b0050a711d23f2mr6620090lfn.65.1700559066021;
        Tue, 21 Nov 2023 01:31:06 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c069400b0040849ce7116sm20370707wmn.43.2023.11.21.01.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:31:05 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrei Vagin <avagin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/mm: Fix spelling mistake "succedded" -> "succeeded"
Date:   Tue, 21 Nov 2023 09:31:04 +0000
Message-Id: <20231121093104.1728332-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a ksft_exit_fail_msg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/mm/vm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 4aeb8d5299ff..05736c615734 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -75,7 +75,7 @@ static bool pagemap_scan_supported(int fd, char *start)
 	/* Provide an invalid address in order to trigger EFAULT. */
 	ret = __pagemap_scan_get_categories(fd, start, (struct page_region *) ~0UL);
 	if (ret == 0)
-		ksft_exit_fail_msg("PAGEMAP_SCAN succedded unexpectedly\n");
+		ksft_exit_fail_msg("PAGEMAP_SCAN succeeded unexpectedly\n");
 
 	supported = errno == EFAULT;
 
-- 
2.39.2

