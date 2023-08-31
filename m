Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76E78ECD5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbjHaMOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346168AbjHaMOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:14:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C191CDB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:14:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso14529341fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693484057; x=1694088857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiuC5i4eTf+8kd4+n3VGXg0ewbk5oQ2uYsewIUt7i4U=;
        b=PsrFlTBLY3c1+6EBS5jIC3R6ePgNLJvw++Zt2Y6zNimh0AZ4H10BU/OAr5A6K0DITp
         vF6rL2Nvlw9bxRcexC5xDMvMLK0DjUHEO0SP3rRWCWOlkW7f16YMfGYxEBL01Adlj/dP
         D2KZ4GSG4LMjeQAN7uJkjvLiDidtCqKuf5h6/qS9HLrC+bjPqQamOU6dMqUO/JHzmasl
         sSDUtp3bxILNZNcENEwLBYEFjpQ+95tqv4h/MFe4mAh/w+DV8/rHLoTkZMm9Kk2VZ7+W
         vtNPIjVP/y/h2ghfjbnc3RByeUqD7Yzs3/XVMMvS1q2ShG/bjgX2giGQJ3TVgl0yCTeN
         ipjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484057; x=1694088857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiuC5i4eTf+8kd4+n3VGXg0ewbk5oQ2uYsewIUt7i4U=;
        b=QWaLLCiBAgPqJ47bquK9tsKspvVCAAMOtuaVn8EZ5vROKRSt1tSjZmSvO9ndqVAdDT
         jKkfZlLWweIjNi3xQ8aV1TaB/jWHvkJGWk31ehLxsmkrb7ZLtskFR5CJhN5G4PbB794T
         /qTlxjjG3m7pDIy4xuCIoVYmXs+CePm2EMIze7nF0OrVDdNPhL5SJa97FrYfjgfQJ0tG
         bjZPZLbloQ6WczD98WIxBu4wzvJQCreJpExDxmrHsI+S6ZIEkktDINoC+tsMVWddLlO2
         aUWl63qm4GwimAsajavbc/TTmhZGqNs45M9SMYxuHQyATA1VgJHYmnrPS7KE5FPv/0cd
         pffA==
X-Gm-Message-State: AOJu0Yz3Nal8oeSekXSsB59+lPVp4k7FKNvBO3+3SMnt2NTmDSXkjy+v
        bw+Sg8vzgUNzVMX5rU55dsw1Eg==
X-Google-Smtp-Source: AGHT+IGUlmhtHNixYlFDBlrEAdg8lNFS0rXHUF2BAERbsOsVUY9ByUobP+oZxi0KqtkYDstfKjekZA==
X-Received: by 2002:a2e:9045:0:b0:2bc:e827:a4f9 with SMTP id n5-20020a2e9045000000b002bce827a4f9mr3763293ljg.30.1693484057465;
        Thu, 31 Aug 2023 05:14:17 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p9-20020a1c7409000000b003fee53feab5sm1799448wmc.10.2023.08.31.05.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:14:17 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Date:   Thu, 31 Aug 2023 14:14:10 +0200
Message-ID: <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds sysfs-driver-regulator-output

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../ABI/testing/sysfs-driver-regulator-output         | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-regulator-output

diff --git a/Documentation/ABI/testing/sysfs-driver-regulator-output b/Documentation/ABI/testing/sysfs-driver-regulator-output
new file mode 100644
index 000000000000..f9b0a8f810fa
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-regulator-output
@@ -0,0 +1,11 @@
+What:		/sys/bus/platform/drivers/regulator-output/*/events
+Date:		August 2023
+Description:	Provided regulator events.
+
+		Read provides various events the regulator associated with the
+		driver has encountered. All REGULATOR_EVENT_* are
+		defined in include/uapi/linux/regulator.h
+
+		e.g.
+		cat /sys/bus/platform/drivers/regulator-output/ssb_rssd32/events
+		0x0
-- 
2.41.0

