Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AE77FDDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjK2Q52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Q5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:57:25 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3736C9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so50795835e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277050; x=1701881850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=Tp265x1fhPLXtlKDHuVj5etiN7JYsgEtxBISRdzxuZZU0HwArfSUI3KpGecEM84dzY
         Zihc23R+ePWn5NtRAhrQpRqAOUNwio2Yg82pq2u/2OVKbmCHoN0kQ7Jf5d5GDsCBNj2W
         DtQnOKJo0irihLhy3eueXLosXVWrqcQcN7gL65JsJCOv1Sxj0KzWQV5nVGPvnY3j+SMD
         awlodOIqem9lH9wjHogG7ihyUeftCSgHHXSFtfwHY6R5ejzXZaIBCmwOIU8ilTetrPJH
         kOHGq0t0ss/gYnowWWuf0Ie+oDuWc1np+iqxrnMI9H/WrKBClBzqpH50FHMu6l8bzQbx
         PZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277050; x=1701881850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=iAWBRrCHPQpzjOo5tFocZPyMfnVOXwwLD69eGXu1/mKPl4+YLYeEwNzU3xVdtVC4Zn
         61QDtBZPC3h6uMjm/8UGTcWSJJFq8YNXmtkAjsBQnqzh/LTocMhHI4Syc/Gf0NOemebE
         IHC0zbuGzCntZIXWe09ACLIK9qS0eASTezQiCQ5G+1ynO8NW8SV5CoXu0APHTKMW4vDE
         1vpDHptIZ1WmxMqbUp5NppUlgjGowRYQFZWw+rXNMsu5nUpWtNHeFuoVqrGL9uVwzfM4
         p5M3JyEfddQGdqx663nowE8aUMFjpdhLEjYkK+ZfDRRtG5GQDNqXmmmgAfhLUz89PSBl
         7y9w==
X-Gm-Message-State: AOJu0Yx9ngYts59cfIdfy2ulWkw3IKwOF0lgGKXoM+80lcxQUYAFQta4
        oB0WS3jPWTDWjvamz2Eth9Rdpw==
X-Google-Smtp-Source: AGHT+IGJnXl3K0OuahWJysbyTRWRNB8Me8pMC0aRC2KPiav1kUKZXJAHnaxaCezYw9nnmAEbaRY6hw==
X-Received: by 2002:a05:600c:524a:b0:40b:4ba1:c502 with SMTP id fc10-20020a05600c524a00b0040b4ba1c502mr4512827wmb.37.1701277050092;
        Wed, 29 Nov 2023 08:57:30 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:29 -0800 (PST)
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
Subject: [PATCH v4 1/7] Documentation/tcp: Fix an obvious typo
Date:   Wed, 29 Nov 2023 16:57:15 +0000
Message-ID: <20231129165721.337302-2-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

