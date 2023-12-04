Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558A8803DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjLDTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjLDTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:00:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC494D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:00:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1b22a31649so215724566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701716454; x=1702321254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=LJ1MGQVlwAtkjU4Ku120jh+vw9q8rexA2ETFL/QP+d/i8tjeMk9bzZSmMhk3Cj7RXs
         1NTGAEv31a2k8mGm0RSMe6CRyA5Vh4r6U5nA665TYS2yug/w4bdqShqYTq07Te4bNbi+
         yX8ZCHjOeuOClFtMCBIIF622wlbmYWqLSmv4ji4DpGR61kqaa9bVPzmkE7oqe/2VWBAT
         S68z299WZJvA/bTCVUbRUD2d1MdvRRvQXLfu/taF17hiQNm49fIyyEWU3v+SppxJyHqN
         UT+yNFlKf0gWBLTs8lXbnjID7V08/E2a6ryQDCqzdVtTfcUtHu7VTfCvCNncNRdP/NWZ
         8oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716454; x=1702321254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=AeNDC+iMZkofPOPV825L39bkoMRaNN2gc/xZxFxzMEpYP7Vkdd9obHjt5hEWfYJnO8
         6e7a9N5UUpozrfBOtvaDoXHwumSL7obi9BPnCcSYo1Z5gnRTROUUDjQqzlKxe8Az2zP2
         oy9NS/gmnz8Gj/Kx+SOEyOOhAdYQ9FjdCuwN0Ro0pc1S8eN+NwBBQS981u5UCKHu4dmB
         YQTQb1Me268lxqks2eGbdzyxacnOqCIXseBevrJHON35PuxLvrMrJO3jKxQHBs5sbVkD
         tYs4bw2fxuAiAKZgciWVBNyTUyP3s0+Qwqnm+PbQ27GfeYQRrg4NeZHIIijb10IICtGY
         VUpg==
X-Gm-Message-State: AOJu0YzWS80A92mpVCTd2cI9PEWB5MCcDrZCwNgCPjBNuCvuoj7PQ3A+
        ckXyOvLVJdkb+wCVWzqL6gR33A==
X-Google-Smtp-Source: AGHT+IEBSRn3oKvt5apwbQOiHdDXP4js5GvWCvcA+RT5ywwGc9MIO2ZiEaQ9HWp6znRjwgNDnQys6g==
X-Received: by 2002:a17:907:38f:b0:a19:a19b:55c2 with SMTP id ss15-20020a170907038f00b00a19a19b55c2mr3409428ejb.82.1701716454475;
        Mon, 04 Dec 2023 11:00:54 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id dx9-20020a170906a84900b009fbc655335dsm5577614ejb.27.2023.12.04.11.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:00:53 -0800 (PST)
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
Subject: [PATCH v5 1/5] Documentation/tcp: Fix an obvious typo
Date:   Mon,  4 Dec 2023 19:00:40 +0000
Message-ID: <20231204190044.450107-2-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204190044.450107-1-dima@arista.com>
References: <20231204190044.450107-1-dima@arista.com>
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

