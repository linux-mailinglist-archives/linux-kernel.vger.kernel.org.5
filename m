Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765357EEC52
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 07:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjKQGkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 01:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjKQGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 01:40:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E6D52;
        Thu, 16 Nov 2023 22:40:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso228590966b.0;
        Thu, 16 Nov 2023 22:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700203242; x=1700808042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsHnJGv78zqzqvzSBU7Yn+nGTyU2xuEXFjTMy+L46O8=;
        b=JSRGMuM+1ltvy84Ef1mjYthje2YFCDMaGRAv8aE88OVUGuFjR+KMGaVvOpd05YRz57
         sGxs74Zg4YHQaY4UTiCSPxzzSnAVJCgRM/jbNQy/UmzaCCLl9/a+sALseC9NM+aI6WuZ
         e7JRhZdvhr6WpsDcBG29JELmigAIDNrcIyBJgpwSoHvwlo+rA4+WrEI4awLSysJr6BXG
         vzCC2MYr3HdwKxwf+2EN71zi9bKv801dTexeF9UT4OSPgnnzQLnUaSzaBxYlv7rEqpRQ
         30pZu7E5J4pQOw35L4+8BXzpVrhhhPWOGkqV0E5zujDIhVZG5VYezH74YpSSz9RJ+tg+
         gbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700203242; x=1700808042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsHnJGv78zqzqvzSBU7Yn+nGTyU2xuEXFjTMy+L46O8=;
        b=h+dnfeq38Q4GNyh0JDsR2NMiNvspmZgMJxreXaNGIoFAVMyH1TNuoVia1LzBCpx9qG
         /USuy2eJCDs0C2G5m0h5HgoV+og+rX5tiEuCJsTAQCKNJvfy5QhCXMpygY6MJQU2JQQQ
         BOqiQtVmGLKGrtHX8qr5jDnFO1N0us1NruNCw/YzM18ZH4qNk/8Wr5u4QSelwKE/a/Mr
         DjemEOX5ZArjHm0nq5foWYKEKpakkiy31ZC4J4jVyo8l9QkhqIrKgD3dd/yeckkMNDtj
         xgFqLv7ifKULirdxyPstAMvb17a/luFioG/WkCJQp5MYSWJcjHmEqOeYgnRXnZnQHrSj
         jGdQ==
X-Gm-Message-State: AOJu0YwDrA7jqmewCSOW4I/t+VY4lFRSSzMboMHivoQKP1YDXdYTNGXa
        3zOlmuUMyOHH++xtsMrwwxE=
X-Google-Smtp-Source: AGHT+IFklLfJ/0lws8a+VAe6MfS2TsLhh5FiUGEMmj0AlJRoWQaURcRg3TiQ7ii6v8ZCQGiOzahTwQ==
X-Received: by 2002:a17:907:984:b0:9e0:dcf:17d8 with SMTP id bf4-20020a170907098400b009e00dcf17d8mr15777550ejc.71.1700203242014;
        Thu, 16 Nov 2023 22:40:42 -0800 (PST)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm447514ejq.33.2023.11.16.22.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 22:40:41 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Fri, 17 Nov 2023 07:40:36 +0100
Subject: [PATCH 3/4] ABI: sysfs-class-hwmon: fix tempY_crit_alarm access
 rights
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-hwmon_abi-v1-3-8bfb7f51145a@gmail.com>
References: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
In-Reply-To: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700203237; l=1409;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=FAaz0JyjLpwKKeXAsKli/EtU8qFxsDz77oHVb7sXDBA=;
 b=pFYkFaTT6FBXwHOfIomatXJrB4ld5btqjXF2rTDe7xfDie6Flj2CDCyDYQZKMmf7Aa+GzF5lO
 etcDxJBZNM0C434q+vBAIOS8zXF+6CLuVfgpvmOM+bMLvaEhs+CsFRs
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This attribute is defined as read-only by all drivers that support it.

It seems that the access rights and description for this attribute were
copied from the intrusionY_alarm, which has indeed RW rights and must be
cleared by the user.

These are the modules that currently use this attribute:
- adt7x10
- i5500_temp
- jc42
- lm83
- lm90
- lm95245
- max31760
- max6621
- mc34vr500
- tmp401
- tmp464
- tmp513

Fix the attribute description and make it read-only.

Fixes: 365b5d63a505 ("ABI: sysfs-class-hwmon: add a description for tempY_crit_alarm")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-hwmon | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index dccbcdc2dad8..3d5e6142ef0c 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -434,12 +434,7 @@ Description:
 		- 0: OK
 		- 1: temperature has reached tempY_crit
 
-		RW
-
-		Contrary to regular alarm flags which clear themselves
-		automatically when read, this one sticks until cleared by
-		the user. This is done by writing 0 to the file. Writing
-		other values is unsupported.
+		RO
 
 What:		/sys/class/hwmon/hwmonX/tempY_crit_hyst
 Description:

-- 
2.39.2

