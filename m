Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8127F69C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjKXA12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKXA1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:27:25 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B2310C2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:31 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c83d37a492so17885741fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785650; x=1701390450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=kuZ0+Y15aZOHrCN9ILYMuzyTZdieBL7vLkhqKn9r8miQfqXTteHyAKyIrWNKqfIRD0
         PcltV302f7NG7g/Ou+M02IdWVYcKpNMCvCLdxFcXyNi1uEtXYg1mI2nCz2U24Zow4Lvt
         mvtPfh2uN9WRwsiYo1GXP7uiUCs/YClsiwzXKWYfhqRZO7jviNxuuAZ9MknB2jp5Iqgy
         Q8+9hg8DGYwLkXY/TZUETAVEJ+4QzNXHovp4+ZZqWJKs9UpskErUvXHWgjhEG0IcbDwT
         rI0IOpQoBlT5kHCtS6PiIRK1RmNRB/T7gav60+N/QsIvjSZ7u+EUbU9TFpDeprbZZY1f
         W3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785650; x=1701390450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=F4meHhGimDVU/ErGf0lnXqJDaRmGhL7nSHBfamEElYiwwjnjeQBZqCpPHaGHUKIkAg
         q+1pp/KtSaE53gk02LCQQJuYp+WWEK+be4QI2knkkxIBWzWrZnIir/uX312O03QyTQaV
         t7fHjnjvfmnNFFH7DqlZs3s0Z9Yiq01R/+Rjk+QpzqHYrZQ1WziduSWYkqjf77M3fWxN
         Xd2jxxyIEP2WBkiCyP9g1tcHfUx1pp0Bd8D8i3o8OvfhSW3DHRFudliYXE/ecjXMHTJx
         dtip09mD6HZt88u81RCOKdTIimyYT+D+ek8XCkQGauG/4heTG/06rlQ4Jwvp9X79ms2D
         4k6A==
X-Gm-Message-State: AOJu0YydD1UCxbUW8BGxr/rqtK3vOO/VQjdd6LbyBIjhyfQRKt272hiK
        SGdyC6mKLI53MqEbHf0fY4CP1w==
X-Google-Smtp-Source: AGHT+IHvSX4dfruCcOgcRtZCAUPbc5qH1FOaW1B+QFPdn0Cp+RKfLN7Aj9D7LHFfPa23KeJI5ynAGQ==
X-Received: by 2002:a05:651c:1208:b0:2c8:8813:2e7b with SMTP id i8-20020a05651c120800b002c888132e7bmr649558lja.2.1700785649997;
        Thu, 23 Nov 2023 16:27:29 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:29 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v2 1/7] Documentation/tcp: Fix an obvious typo
Date:   Fri, 24 Nov 2023 00:27:14 +0000
Message-ID: <20231124002720.102537-2-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124002720.102537-1-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, my VIM spellchecker is not good enough for typos like this one.

Fixes: 7fe0e38bb669 ("Documentation/tcp: Add TCP-AO documentation")
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reported-by: Markus Elfring <Markus.Elfring@web.de>
Closes: https://lore.kernel.org/all/2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/networking/tcp_ao.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tcp_ao.rst b/Documentation/networking/tcp_ao.rst
index cfa5bf1cc542..8a58321acce7 100644
--- a/Documentation/networking/tcp_ao.rst
+++ b/Documentation/networking/tcp_ao.rst
@@ -99,7 +99,7 @@ also [6.1]::
    when it is no longer considered permitted.
 
 Linux TCP-AO will try its best to prevent you from removing a key that's
-being used, considering it a key management failure. But sine keeping
+being used, considering it a key management failure. But since keeping
 an outdated key may become a security issue and as a peer may
 unintentionally prevent the removal of an old key by always setting
 it as RNextKeyID - a forced key removal mechanism is provided, where
-- 
2.43.0

