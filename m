Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1657D693C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343752AbjJYKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343522AbjJYKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:42:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD6F10FD;
        Wed, 25 Oct 2023 03:42:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a62d4788so8673363e87.0;
        Wed, 25 Oct 2023 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698230536; x=1698835336; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USY4fw267Go83RxyHyFwK1+6pc6Q77CrkKJFbgSONJU=;
        b=ShlEeboAgNI0keEKRxCp1TNhPFyAOyjzExRBcVJ4Z3oV86IulG0uOM0dL4VVVXzabv
         A8bFrjCSoJ90aAMkJ0MW2GsAHvMMmYoFZaCM6+9Xnx3gRSGRnwZ+ajEaa9b2R3rkxE7i
         PRDe1CslYMWmm81JE1cauzr3omMjBBCLXznW78hFyBz93gQ85N0cy6iUMYqgsg4X84qS
         LbLgaFwuRApfltyVOjoauHhfgq7f8athyNYeWOVKsHTrWsDFk1UTfub7s5fKBjuI6XeB
         qkL6knTUYxqbiJkugTeJGWSUe2YAe8A9B2VuC2wDi0zQDacWZZe+/srh/PgI48Q1KqOQ
         SYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698230536; x=1698835336;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USY4fw267Go83RxyHyFwK1+6pc6Q77CrkKJFbgSONJU=;
        b=r+foBiem2wNeURN/xnH8D5gGVbw36TmTzWbyyjN34e08LsnbiWYsdEHlWxGZR+Ck8w
         oTw8Gz0TMaFkBzpzRVMbW5eFpCt6b4aBqldzT8mDBrcyBWuFQJ5cErPD076xk4NPj/4E
         gUGNwwvBJFJoXiJ/xOkMUB1qJzANrqvS4LzOuRtwpNgk69zySKTuUeRS6PiE964SPCVd
         G1m8Wqc6vqJz9meb6ortXTkdbT7xIVvMbFSBSpyFqHQOe9qCUDL/tcCxXm1L5JW2BXek
         dLmtNvAbr5WvJWpRDySrdF8AbKcy5pHHplSJ6Ecjeg9jtWKNRAUUXSY0KpgfvxCzte/z
         UJvg==
X-Gm-Message-State: AOJu0YyCQpp8kydZquV+WIK1ebNkY/ayhRFew93lF1taZEQUOb3/nDch
        rQkUW/AZE/qvgcclheuNlwU=
X-Google-Smtp-Source: AGHT+IH+mKnvmoscLzowQ7hAev3IlVRR9DHwfFnnTp13am39rRDQgcxMoWLTpMzT+6bZeJXrYawGfA==
X-Received: by 2002:a19:5212:0:b0:505:6e21:32e1 with SMTP id m18-20020a195212000000b005056e2132e1mr10207820lfb.10.1698230536071;
        Wed, 25 Oct 2023 03:42:16 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:2cbd:f9ec:f035:ebea])
        by smtp.gmail.com with ESMTPSA id t12-20020a05640203cc00b0053e67bcb3e7sm9179868edw.82.2023.10.25.03.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:42:15 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs: module-signing: adjust guide after sha1 and sha224 support is gone
Date:   Wed, 25 Oct 2023 12:42:12 +0200
Message-Id: <20231025104212.12738-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 16ab7cb5825f ("crypto: pkcs7 - remove sha1 support") and commit
fc3225fd6f1e ("module: Do not offer sha224 for built-in module signing")
removes sha1 and sha224 support for kernel module signing.

Adjust the module-signing admin guide documentation to those changes.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/admin-guide/module-signing.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
index 2898b2703297..e3ea1def4c0c 100644
--- a/Documentation/admin-guide/module-signing.rst
+++ b/Documentation/admin-guide/module-signing.rst
@@ -30,8 +30,8 @@ This facility uses X.509 ITU-T standard certificates to encode the public keys
 involved.  The signatures are not themselves encoded in any industrial standard
 type.  The facility currently only supports the RSA public key encryption
 standard (though it is pluggable and permits others to be used).  The possible
-hash algorithms that can be used are SHA-1, SHA-224, SHA-256, SHA-384, and
-SHA-512 (the algorithm is selected by data in the signature).
+hash algorithms that can be used are SHA-256, SHA-384, and SHA-512 (the
+algorithm is selected by data in the signature).
 
 
 ==========================
@@ -81,8 +81,6 @@ This has a number of options available:
      sign the modules with:
 
         =============================== ==========================================
-	``CONFIG_MODULE_SIG_SHA1``	:menuselection:`Sign modules with SHA-1`
-	``CONFIG_MODULE_SIG_SHA224``	:menuselection:`Sign modules with SHA-224`
 	``CONFIG_MODULE_SIG_SHA256``	:menuselection:`Sign modules with SHA-256`
 	``CONFIG_MODULE_SIG_SHA384``	:menuselection:`Sign modules with SHA-384`
 	``CONFIG_MODULE_SIG_SHA512``	:menuselection:`Sign modules with SHA-512`
-- 
2.17.1

