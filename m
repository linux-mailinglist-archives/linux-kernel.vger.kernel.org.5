Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6AE7A9F65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjIUUVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjIUUVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:21:16 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7254E5EC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:17:21 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-274b4d91172so834048a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695316641; x=1695921441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6b+r/qO6jTNd+eQdEZK212ydTtWtBK6Hb2cWKKJgo7o=;
        b=WROqpbfZnTgwEOtha9R2oDR7HNUNqAa1qBePPoSRL8GtUVyeZarPnzCyJF1mXY5h/S
         5C98P7vm5opFqXSkNqdtJIoklDV4q0WFIgsfVeWOiR/KSwTgTCCf4tB7XptHrHPficvy
         /qfW971yb16gfIbBYm53oTzcLy1tOAjhG9j9dzZ6C6aSwsCPF03ttpdocxL8yBViT5Y+
         zvhFzYcBf29LQ9LoCR7IXnEePLrDMBw2CiGboJRe4hlZppR/wzYOkAhmPOwpGZ3U9ufu
         lpVcsRvdbKjLata4hW9tChTWhlyK+XbjnAScVRDOk/TBNScvnQ4dYG48E3YnZe3J1+O3
         H/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316641; x=1695921441;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6b+r/qO6jTNd+eQdEZK212ydTtWtBK6Hb2cWKKJgo7o=;
        b=KXUdYO1mkcVT2nNXU+Dm7u5dQgHc9pGfWdLVdXUaGvIJtw41NP3q9DFp8KKQEtPz2O
         g3XfHBC1adpDzkvTddVatTbPFZVGdKVxd9vU8PtR94xk8JyMIz5lqE2NfWfwmwfFRy9E
         MwH9yHIBsTiBFEtRvAA1Z8OJmAMYZKiHlW1PJ9/KWtylKZyq0BW2O1FNlv++by9CDEWo
         ERbppPml3juT/sfG5T9T9AUULfx3MLaioYdEei5HekmKj6D9X2U8Lj3QjqZ/yip8OWsq
         s3+C8dQcQv6uZMGmf8lUBaTOuv5zsR0zdeZzS7xxA5boZdxeeXdnXBLUE7+RK6/Rls03
         jFUA==
X-Gm-Message-State: AOJu0Yydg0y/jD/tYRgGarNZHIm8cLHkQP8VhBXr8dRqCfKgzNcGR4Uj
        3cVi1Eo3xa05w6DAJKrK6cmzp88=
X-Google-Smtp-Source: AGHT+IFLA7pELMkRmPVUcV9dQSyP5wShtjA3I4pLFmR0wr3ICAIAxSCbstWOoMP3LDJ/cCr9C0wtfNw=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:925])
 (user=ovt job=sendgmr) by 2002:a25:408f:0:b0:d7f:8774:dfd4 with SMTP id
 n137-20020a25408f000000b00d7f8774dfd4mr62822yba.12.1695278727640; Wed, 20 Sep
 2023 23:45:27 -0700 (PDT)
Date:   Thu, 21 Sep 2023 06:45:05 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921064506.3420402-1-ovt@google.com>
Subject: [PATCH] ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig
From:   Oleksandr Tymoshenko <ovt@google.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     ovt@google.com, rnv@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal of IMA_TRUSTED_KEYRING made IMA_LOAD_X509
and IMA_BLACKLIST_KEYRING unavailable because the latter
two depend on the former. Since IMA_TRUSTED_KEYRING was
deprecated in favor of INTEGRITY_TRUSTED_KEYRING use it
as a dependency for the two Kconfigs affected by the
deprecation.

Fixes: 5087fd9e80e5 ("ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig")
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 security/integrity/ima/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index ecddc807c536..4e559bd1fd41 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -269,7 +269,7 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 config IMA_BLACKLIST_KEYRING
 	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"
 	depends on SYSTEM_TRUSTED_KEYRING
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   This option creates an IMA blacklist keyring, which contains all
@@ -279,7 +279,7 @@ config IMA_BLACKLIST_KEYRING
 
 config IMA_LOAD_X509
 	bool "Load X509 certificate onto the '.ima' trusted keyring"
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   File signature verification is based on the public keys
-- 
2.42.0.459.ge4e396fd5e-goog

