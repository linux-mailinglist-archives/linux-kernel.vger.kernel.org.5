Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86977F01D8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjKRSFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjKRSFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:05:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C56AA;
        Sat, 18 Nov 2023 10:05:14 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9f282203d06so427491166b.0;
        Sat, 18 Nov 2023 10:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700330713; x=1700935513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+AlUo2GslrTb8lu/H9lXRQ7xNPByNIgHu5m89J0d9M=;
        b=JPn6fCnBUJ5srzH4r0av8zTkBovLoRtgsFTr4Vrf3Uom3q1f8S20MCxYXUs7i9ynwQ
         p3pMzp7Qyyzxb2yjm9cdSwVMp0+rbvnE+oy03j5bFYkJe+pJKXuxI7lywfC7dCa1R3mo
         48nLF3i847nDh2kAHVF2PO3Xzqk0oaKoXK5jZcl/OEG+JUlnq1SaqqgEyx0bXgDOFYeo
         pQ6M12w78yldfZQjnMSIKlRIUaTOdzf9Q32VpwD5+0EISlWS4LzYPqtFQOmIGEPLBq5S
         Ors4ip25g/36p+ajo3Kj3RAjiFfiYESMG51fRjMuFFuWElagtl9Ns9WTqLR9aDcFt4oC
         GKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700330713; x=1700935513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+AlUo2GslrTb8lu/H9lXRQ7xNPByNIgHu5m89J0d9M=;
        b=fJ0KlU2JJliLfzb8maAKxjCWd3jbIlMmdQFEldZShSRN2Jbv+Wz4MZw7KQ7+2DbMvD
         kv4g5bqtkVtGCwvfAfOV6HfvNFp81QCJPNv7QvuStZ1Gmkm/eU3/bXUp3K4Nz+Mew3N0
         VE1EbbcEvtjof74u3abe7k9j8PbB2MDLX8WWQ00uPWk+GWWJsIwhPCJ9M70Elmxt4FoG
         gL7WlUdF1ug2cPlcgbFsgiNUTDTCaHXvBYCtltOhrGFSc+PcTVwdlvYf/1BTQLDCwuhn
         s6Kxy1Ubm7HhMtJuEMe/sGh3mPWzjy9NCglkLZ4H50Q8ToFRxAwaqq78Y9G1xA3t6e5r
         VZyA==
X-Gm-Message-State: AOJu0YwLKESQ/bbM5QCaH9+SVXZ1UmiPwRh1Okw8xM7REK81VKrB8R7H
        2692GdOXTILowN8gwTcrs3EoGNjYGm04uA==
X-Google-Smtp-Source: AGHT+IHIv6I4Gwsd3S6HojvrFo4x61NnzUZVGhsKNL5m5fRKpWQLcETOBzno2YDAq+fnVQHmvTpy/g==
X-Received: by 2002:a17:906:104d:b0:9be:705:d7d0 with SMTP id j13-20020a170906104d00b009be0705d7d0mr2012795ejj.0.1700330713123;
        Sat, 18 Nov 2023 10:05:13 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id m20-20020a1709062b9400b009f2c769b4ebsm2079456ejg.151.2023.11.18.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:05:12 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] drivers/i2c/i2c-stub.c: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Sat, 18 Nov 2023 19:04:58 +0100
Message-ID: <20231118180504.1785-5-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118180504.1785-1-hkallweit1@gmail.com>
References: <20231118180504.1785-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy eeprom driver the only remaining I2C
client device driver supporting I2C_CLASS_SPD is jc42. Because this
driver also supports I2C_CLASS_HWMON, adapters don't have to
declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
It's one step towards getting rid of I2C_CLASS_SPD mid-term.

Series was created supported by Coccinelle and its splitpatch.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/i2c/i2c-stub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index d642cad21..09e7b7bf4 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -308,7 +308,7 @@ static const struct i2c_algorithm smbus_algorithm = {
 
 static struct i2c_adapter stub_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
+	.class		= I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "SMBus stub driver",
 };

