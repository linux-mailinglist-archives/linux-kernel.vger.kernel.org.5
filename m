Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32A07FEB5A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjK3JE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjK3JEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:04:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC2D66
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:05:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so613791a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1701335099; x=1701939899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOSpfehJAtjXcmrtCVFOpVd435b0i7EUig22DPIw/j0=;
        b=M9sgkwCpSOHJg0JDkTgxuaLywR7N1s8k0JfIuEX0wzK9dUrwg7YBkIDo4826QvpRBz
         m/3roaXe16E02Gbd8i+z4eJHnBkKolxN8JXEOfES6hf+SRgOwNEVL6hNtKgpa2nzBUdq
         ynH6Vd1BSYcyB8Ssgdy+YLQ+i1sOuI2cZBfrYXYbxNWZ7UCvg9KENP31SQfnXhNtOi+I
         d0Y+w2Gv+x5Pj8ayXFJk2mXUjFltYO7CXYVWnCAaSnLZtl7pMPezEbtQReqX8KZPUgim
         Pl0EsQ9PGwa+1SMi4vdEgjaZGxYs0khwj78sYuGXUFI6CuIPdyBj1gq6KzaWqKt5hQo/
         1Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335099; x=1701939899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOSpfehJAtjXcmrtCVFOpVd435b0i7EUig22DPIw/j0=;
        b=qNXH9XbbIF/4vGu2OFbs3iloHlob8Bt07DbzT2xeRbDtGMdz8h8ghk3OfEJbY4nHJ8
         ThFYf3WForVmI/w2UT1uLLersfjMuMYD+z2uqoSlGH36XG7rNzinLdAjz3h89/xRjp6j
         yG2RgxnZYNQ7KheUInQncmOPYh5eLUu9L5TsESs9Qw6QsmkTJ+ZKUYPL5dVtN7NK3RHF
         t8WFoshmqqxePCj+ua7AVgY9MnALplyIsqrMPIn33uaHAo720Dt44bxWt9e/fjMvrvwr
         maNXb5YEM8oV5oXoADWDRsdf/GXPYqJxhJmWFUFE6F///H8VS5ruupefLbDoiEu8nOYe
         Zp/Q==
X-Gm-Message-State: AOJu0Yyd55beNdXKWK8PROfxrwsy5XGYS3GXYRosej7N+TBSnSKnPwgp
        NpdhRe8VUibCAmVyNHD+PLvtAw==
X-Google-Smtp-Source: AGHT+IHZPozvOcPGcqYRKlWe5NehhcGCx0qBGfvZfu9zNrnHos1zKESsl8C4bT/9i+D6muX3zwgtxw==
X-Received: by 2002:a50:d68b:0:b0:540:346c:7b2f with SMTP id r11-20020a50d68b000000b00540346c7b2fmr14685967edi.40.1701335099379;
        Thu, 30 Nov 2023 01:04:59 -0800 (PST)
Received: from fedora.sec.9e.network (ip-095-222-150-251.um34.pools.vodafone-ip.de. [95.222.150.251])
        by smtp.gmail.com with ESMTPSA id c3-20020aa7df03000000b0054b9a6092d3sm347554edy.12.2023.11.30.01.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 01:04:59 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     naresh.solanki@9elements.com,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: peci: Bump timeout
Date:   Thu, 30 Nov 2023 10:04:21 +0100
Message-ID: <20231130090422.2535542-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PECI CPU sensors are available as soon as the CPU is powered,
however the PECI DIMM sensors are available after DRAM has been
trained and thresholds have been written by host firmware.

The default timeout of 30 seconds isn't enough for modern multisocket
platforms utilizing DDR5 memory to bring up the memory and enable PECI
sensor data.
Bump the default timeout to 10 minutes in case the system starts
without cached DDR5 training data.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/hwmon/peci/dimmtemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index 5ca4d04e4b14..4a72e9712408 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -47,7 +47,7 @@
 #define GET_TEMP_MAX(x)		(((x) & DIMM_TEMP_MAX) >> 8)
 #define GET_TEMP_CRIT(x)	(((x) & DIMM_TEMP_CRIT) >> 16)
 
-#define NO_DIMM_RETRY_COUNT_MAX	5
+#define NO_DIMM_RETRY_COUNT_MAX	120
 
 struct peci_dimmtemp;
 
-- 
2.41.0

