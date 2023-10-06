Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696547BB3CE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjJFJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjJFJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:05:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B5683;
        Fri,  6 Oct 2023 02:05:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b29186e20aso328541166b.2;
        Fri, 06 Oct 2023 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696583157; x=1697187957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K4HOKOpHHPlHT6d0maywPvHxqU0NRGC5LpozW09vLNA=;
        b=eoAlB5AEPTIAp458718A2eTT6rq+NhLuK7B/w/JYo2F84yhZETyrDATwtxETxi2ADO
         RtHtXZhrCsFS873GNWludaqOC7Ya0WYZInO2HEAUimJW72qW87/L9+HqaLMSUbF0B0hB
         QgovWZQCYmZ7NvkL9jaPRfwBREGh4tl5LGCo3DZMgnzmroqW9sFizis5R9bsOI/6+1+p
         oeooJ2GPx0yNUi+DNK6JglC6vayeMbQzb5a9jJPR9qUw8llNOEShk02KTr3e5Q5peTCy
         rsjtmCyEQBf+n8m9we9kVvk6XsOoHfGVHs4PPGwWeLpCZUAJH52dYCeUxrhKSeGCcFX0
         QUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696583157; x=1697187957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4HOKOpHHPlHT6d0maywPvHxqU0NRGC5LpozW09vLNA=;
        b=IfZNJ1Yf7byLChVVfzLjwjvmZrgfURoXifi+unO+XyMN3MegunztPVJP8q95wD+MFS
         S2Ekd/pKJe/pZZS0V8d/eAZ0sj5o5VEUI9L/8h+9F3CTZyA9oBbsF7Z9chEoTlKKfSDt
         BHj5uFP+NDvK/xUVBe/JE39CZnYBnVFlUiKeIkpB7b6Jg3J08qTgW7HdGO9oYwaxEk8Z
         ZLerE9AScVR9GvsZoqEAVfdjH5Mrx6sgDtAdWX2pw9E30qNPHhWcni/ILvdh1wWkiwoo
         TA48iX6ZGwzayuglYSGc8OlQ5B1hJY7cHNzrB9MgsjpgKdFwKTWH8v3InywtJ4XqMQF5
         OKTw==
X-Gm-Message-State: AOJu0Yz1VYwugyU713e4RpT15IVsCg5EkQ7ZoWLiYEA+1GqF1wPD0tgm
        /XZQ+gwqbnHkgZkLwhgH9HANNT13h3a9hdHrlXg=
X-Google-Smtp-Source: AGHT+IFTJ6rcB8I7EMJ9//iL8v3mQ1Z6mTmHYep+kIZhraf0HNeWOZ+eLaVLE2kaKvyRE3E39yRd1Q==
X-Received: by 2002:a17:907:78d1:b0:9b3:264:446 with SMTP id kv17-20020a17090778d100b009b302640446mr6986948ejc.0.1696583156474;
        Fri, 06 Oct 2023 02:05:56 -0700 (PDT)
Received: from mkorotkov.rasu.local ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b009ad875d12d7sm2509128eja.210.2023.10.06.02.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 02:05:56 -0700 (PDT)
From:   Maxim Korotkov <korotkov.maxim.s@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>
Cc:     Maxim Korotkov <korotkov.maxim.s@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] rtc: efi: fixed typo in efi_procfs()
Date:   Fri,  6 Oct 2023 12:04:44 +0300
Message-Id: <20231006090444.306729-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the first check of the value of the "eft" variable
it does not change, it is obvious that a copy-paste
error was made here and the value of variable "alm"
should be checked here.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 101ca8d05913 ("rtc: efi: Enable SET/GET WAKEUP services as optional")
Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
---
 drivers/rtc/rtc-efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index dc6b0f4a54e2..fa8bf82df948 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -227,7 +227,7 @@ static int efi_procfs(struct device *dev, struct seq_file *seq)
 			   enabled == 1 ? "yes" : "no",
 			   pending == 1 ? "yes" : "no");
 
-		if (eft.timezone == EFI_UNSPECIFIED_TIMEZONE)
+		if (alm.timezone == EFI_UNSPECIFIED_TIMEZONE)
 			seq_puts(seq, "Timezone\t: unspecified\n");
 		else
 			/* XXX fixme: convert to string? */
-- 
2.34.1

