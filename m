Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4021772C31
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjHGRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjHGRL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:11:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC8E65;
        Mon,  7 Aug 2023 10:11:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe11652b64so7387754e87.0;
        Mon, 07 Aug 2023 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691428314; x=1692033114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KhCpc37sMq8hfJahbNI7sAkZNZxhd0cG15a8ZsTo7w=;
        b=Sh52DhymwxQXUXmMTjKNMSN1j8bLQn0UKLirqyD6CTjQY6jT0qgixd5ekHUsNSvjAT
         NlctFiVmROOkJknjucfzWTja1FcU6YDglvns52lOeWG3kVzAEAwAYT6FegYBnEFOATV6
         uN/xcY8WqD1IN+5GQ3ReC/fSjiAkkyTzqc+OZFgPK5m9GvioP2sNfl6IgdnDVmxj3jAb
         p6Ar8cCtSlv8+arYuzGOaqPHU/93hu0gzwdL0g4azaB6+tludIQBKv28zo80yUwuc7bV
         /wLlRxRObF/x1PzqOTKKtsAnvBkP1Zzhv8KQk0eQ5JwrtNhc2zxAGi3XVWLe4JWvwsPH
         io4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428314; x=1692033114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KhCpc37sMq8hfJahbNI7sAkZNZxhd0cG15a8ZsTo7w=;
        b=JVolW9NyUux8obmOVL9CVfArQln5TlrqnRkxTlMT48d98/KvFfc+Xs0QTwNE/WvQzi
         O3cqTTDz1Tjp9h91HuoTDAuNvI1xJVauLg/0YQE/b3M6NJDCzAhTw/7rEaFoI7qSX5lu
         JHEIp+MULEZskAE8AQbHcsiFsfr72MwhMilYvfHeXKB8Z0ZelSkaPZpiz/+QWHRThzKK
         xw51z83q4LjOhM/jqlCLu4AHkVCWEdYxyMm0WLQ0ODtZx36dRWGJEyO9tJ/ZLU0yQvkN
         EU9JYs0FJUXvcHe4smE5MCmkKFDffgZtsEEa0YKYDPBJAepaRIV7RWTwNrCz2cFLkksW
         C5FA==
X-Gm-Message-State: AOJu0Ywdf/vB43TOXk0gJ5x21/bqMaaLa4g+7XOXEP7ZVrQcNAXewV+K
        wVR8bRbL71HuLG6L0GiJYulbVIz0jPONWg==
X-Google-Smtp-Source: AGHT+IET/AFGK+4+CLYk42xKMODKni6DQCsckrcFGBs624e3hfN1sCJq6kNnpt0/pNFm7ohbZ0kn6Q==
X-Received: by 2002:a19:6742:0:b0:4fb:7d73:d097 with SMTP id e2-20020a196742000000b004fb7d73d097mr5892482lfj.39.1691428314359;
        Mon, 07 Aug 2023 10:11:54 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-033-028.95.112.pool.telefonica.de. [95.112.33.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402148a00b005224d960e66sm5420814edv.96.2023.08.07.10.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:11:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] selinux: make left shifts well defined
Date:   Mon,  7 Aug 2023 19:11:38 +0200
Message-Id: <20230807171143.208481-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807171143.208481-1-cgzones@googlemail.com>
References: <20230807171143.208481-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loops upper bound represent the number of permissions used (for the
current class or in general).  The limit for this is 32, thus we might
left shift of one less, 31.  Shifting a base of 1 results in undefined
behavior; use (u32)1 as base.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: split from parent commit and apply cast to correct shift operand
---
 security/selinux/ss/services.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index dacec2ebdcd7..1eeffc66ea7d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -207,22 +207,22 @@ static void map_decision(struct selinux_map *map,
 
 		for (i = 0, result = 0; i < n; i++) {
 			if (avd->allowed & mapping->perms[i])
-				result |= 1<<i;
+				result |= (u32)1<<i;
 			if (allow_unknown && !mapping->perms[i])
-				result |= 1<<i;
+				result |= (u32)1<<i;
 		}
 		avd->allowed = result;
 
 		for (i = 0, result = 0; i < n; i++)
 			if (avd->auditallow & mapping->perms[i])
-				result |= 1<<i;
+				result |= (u32)1<<i;
 		avd->auditallow = result;
 
 		for (i = 0, result = 0; i < n; i++) {
 			if (avd->auditdeny & mapping->perms[i])
-				result |= 1<<i;
+				result |= (u32)1<<i;
 			if (!allow_unknown && !mapping->perms[i])
-				result |= 1<<i;
+				result |= (u32)1<<i;
 		}
 		/*
 		 * In case the kernel has a bug and requests a permission
@@ -230,7 +230,7 @@ static void map_decision(struct selinux_map *map,
 		 * should audit that denial
 		 */
 		for (; i < (sizeof(u32)*8); i++)
-			result |= 1<<i;
+			result |= (u32)1<<i;
 		avd->auditdeny = result;
 	}
 }
-- 
2.40.1

