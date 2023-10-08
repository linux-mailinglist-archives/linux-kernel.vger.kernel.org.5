Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439327BCA9C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjJHAST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344227AbjJHASS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:18:18 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23D0BA;
        Sat,  7 Oct 2023 17:18:16 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af8b498d31so2522927b6e.1;
        Sat, 07 Oct 2023 17:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696724295; x=1697329095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbxFTb9zCi/xU8GbQKw8uOhAsqQaEk8kDXfV6PtDCSI=;
        b=gAoifgL0kIMs9PfJIV14m3FQzGjLZVwj37amsaTYkUraKaws5lNIRUmvljRUDS7Bf2
         qThJXb16kH84theOSYSioHw4zSh67FXNmTzICNZhIiUA+40vzl34eXYkQDgqkQLoJafq
         xW1rQYnr04Q7onxETHfDDuOs9ckxtooc3MTaljAQOod/6zpgIqNqB50VI7qyp0L8Kur9
         99r0IbqfV+qV3opZt69GsWUCqYNBplyq6+oEwpKivmy7xbFOGLP0SaZUz1Cas8hmK7Eh
         Vmvc04JK3oCWaKMnofoaShOhHWPGIZEsF1T9qSP/1nBX+KwhkBHlbc+ai9r5QXR876lX
         fQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696724295; x=1697329095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbxFTb9zCi/xU8GbQKw8uOhAsqQaEk8kDXfV6PtDCSI=;
        b=ouQdtJybiZCKeFHzuLo6Y/NNSw5TIcPPUqw84QUYlLy+VWrkyWxNwDdLKQkRWSfSTs
         Fvxj1yao0kvot7qz4aCq81zd8A3SlkwlUrrx8XslvXIgusCEuK7oAD0c/mLdALnUNuua
         7KqhBI0voyyth+1i7mxJdo5N36lw5BfMg1n2RyG/1BdskvfBhrQswy3lHb0An/qQJgJ1
         LWxvIxDaQjWAkTdmemUfOXvpZHmMJbp/FnZULTBHEokbkEZFlyXaAH9+Vr6qbAMs3X+0
         SIUqsunlSzT6Lo4a+1TVwJm9oEtCohZ1yLuC9wEdkUjr05ouqAaVDkAMMaBb5JSkhrOx
         68fw==
X-Gm-Message-State: AOJu0YzhfqapIf17U7+4hDUUo3/5JzLlL5mihzL/kL93XFm+RnpJk8QL
        jXqz5rdkAQ565U30x1ZdnY4N1lfa+ng=
X-Google-Smtp-Source: AGHT+IFU9dWcGkH5VmGETiPuKIVFRnONNPfRMllLOARcaW15fxFNVlBPaVVwUjuaZpi9RrnBmvz9bA==
X-Received: by 2002:a05:6808:1309:b0:3ac:f107:52b with SMTP id y9-20020a056808130900b003acf107052bmr15821445oiv.2.1696724295515;
        Sat, 07 Oct 2023 17:18:15 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:df1:8b3d:75d1:b108])
        by smtp.gmail.com with ESMTPSA id ey5-20020a056a0038c500b0068fe9c7b199sm3743278pfb.105.2023.10.07.17.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 17:18:15 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] serial: add PORT_GENERIC definition
Date:   Sat,  7 Oct 2023 17:18:04 -0700
Message-Id: <20231008001804.889727-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current pattern in the linux kernel is that every new serial driver adds
one or more new PORT_ definitions because uart_ops::config_port()
callback documentation prescribes setting port->type according to the
type of port found, or to PORT_UNKNOWN if no port was detected.

When the specific type of the port is not important to the userspace
there's no need for a unique PORT_ value, but so far there's no suitable
identifier for that case.

Provide generic port type identifier other than PORT_UNKNOWN for ports
which type is not important to userspace.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- move to the end of PORT_ definition list
- rename to PORT_GENERIC

 include/uapi/linux/serial_core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index add349889d0a..0a5090e08657 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -245,4 +245,7 @@
 /* Sunplus UART */
 #define PORT_SUNPLUS	123
 
+/* Generic type identifier for ports which type is not important to userspace. */
+#define PORT_GENERIC	(-1)
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.30.2

