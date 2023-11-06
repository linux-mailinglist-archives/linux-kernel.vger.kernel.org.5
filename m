Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD827E1D93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjKFJyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:54:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF5B6;
        Mon,  6 Nov 2023 01:54:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d267605ceeso620158166b.2;
        Mon, 06 Nov 2023 01:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699264442; x=1699869242; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otIX8+idMS2A1yjtMOT40Sxj9HPBhYuyJPN9t9t9cSU=;
        b=EHcUx1ukOxbDPHnTrT//Ek7SZ/fyDELBgRjzV41dFnXLrmpgcbf0p5ZuJGixtQ+gwt
         jvXh4dpkB1FROOUo3JSP5Y7KKl7h5P520nnyrKp5dLqUtIxa1KbLvBH2NwXaM6WysXtU
         qB8k+w499eDbMCVHiMNM+NknZGCJg2A/39nWYBAI/mIhSA88EVoEOtPanevZmaFH7ELi
         6t4Sx5Y4BqMg5pV0NS4AuCTEL1D0Tbaeo5/FEN6zx6nOGyNXFA6ZevSH2WcSqih9n7FM
         cXQDGYhCbpSvI8WAuueTk0TQt8FKU8LGMsBGq3prhPMXZeA92i+DbhMifYDQ9R6scAXi
         aTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699264442; x=1699869242;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otIX8+idMS2A1yjtMOT40Sxj9HPBhYuyJPN9t9t9cSU=;
        b=cEs2h+kREJcgEZodifaTVXUwcWp8pXwnSbd57YNK2SOIJ3PrUzOpxnH3A8p2nJSqNy
         NOuWWhg3jJTVDcoK9mkGg1ydyVO2pft0lL30paWfREUf3Qp7Kyoe0qNIrqCI5ACIHd1q
         KmSklb8RfJ+j7eWVxN0q/V/m17CMwkVdWqpgbx3f58NFVMqNpU7tJufCoIHxAvBFPAZX
         ASqn1eMgu+8nHIZAXgeOWaV7i8hli8WsJBYcXJCTM+P9HMYXWtFtc6mag+Xj4yuwzZ5L
         Ucae6tIZyucYr/aiCmiRc9v4KadbYYbGyjM1Kwz1wIgeSndz5DSWGbZw0D7b07EQErZd
         epfQ==
X-Gm-Message-State: AOJu0YwMbdmRYLNS+8GIUPjSTLGvLz/RfwRNrSafnjFZOeAC+8N0hg1I
        VSIujTFFPxsfKJPMqsbfzWU=
X-Google-Smtp-Source: AGHT+IEa/iGSQXVfW4lCHwK5pPS3XxlZeD5ZwgxpdBfFYaqagOnnjZDZjh8ZU9LX+MWw6I95hlcrpQ==
X-Received: by 2002:a17:907:72d6:b0:9b8:e670:657b with SMTP id du22-20020a17090772d600b009b8e670657bmr12498126ejc.64.1699264441587;
        Mon, 06 Nov 2023 01:54:01 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:c1b6:41cb:bf88:2048])
        by smtp.gmail.com with ESMTPSA id h26-20020a1709063c1a00b009b97aa5a3aesm3895568ejg.34.2023.11.06.01.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 01:54:01 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Nik Bune <n2h9z4@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for DIALOG SEMICONDUCTOR DRIVERS
Date:   Mon,  6 Nov 2023 10:53:49 +0100
Message-Id: <20231106095349.9564-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bd888a4377ae ("dt-bindings: watchdog: da9062-wdt: convert txt to
yaml") converts da9062-wdt.txt to dlg,da9062-watchdog.yaml, but misses to
adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file pattern in DIALOG SEMICONDUCTOR DRIVERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0410322b740a..bd9077b1fd41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6123,7 +6123,7 @@ F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
-F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
+F:	Documentation/devicetree/bindings/watchdog/dlg,da90??-watchdog.yaml
 F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
-- 
2.17.1

