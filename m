Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649F4762891
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGZCJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGZCI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A091212B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690337292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95LJOf0z/Eno4OCFcFMWl++emGtMZCHYgwGRjUbJaTM=;
        b=KvXcXBtt6HwDJEYFMoTGobwo6CAa3Z3vLbiZ6ffGqMcgq9ficLAuM1OSUkn9DItOoWtPmz
        6yNPh2qZoBShfKLPj4pT30fT8khuxd1eoyTI9xcJKQmVdeNZwhF1BWjhQvVqvdT6OidBfg
        28Hq/5Dsvb1n/z3One/UF1Oj0cOh1UI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-7Ry0njhnO4ODIFCvntGHMg-1; Tue, 25 Jul 2023 22:08:10 -0400
X-MC-Unique: 7Ry0njhnO4ODIFCvntGHMg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bb83eb84e5so33573345ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690337290; x=1690942090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95LJOf0z/Eno4OCFcFMWl++emGtMZCHYgwGRjUbJaTM=;
        b=DbwG8r/5awR+Sqvll2GATORTVvsDwz7YhUGrgycH+gk0rkIqqBjkha+EQ14K7Q6TTI
         wUsEYxzn8ORsJ0t6oUqazK5S6tGpbWcXt1l9YVw/eNO2QhYdKaaG4/HzBKQblZXOs4IX
         tvHGINXdZlyw72LF+YDRllU1j/lFP3tt1Khz6R50RaP9UlOqd+Y/280oEjb3OOs3l2KG
         75+gUfi5UcsaBpEjuD++OpaDOp6dj40FsswQYoF0czzHhfQiSr+mDKAnGHwhUn1Mw62A
         qMOL0JOyvCJGeTXh3pGtrw9HyD3HPpCOiMGOZ44hglANHmR4q4OSd7eJW1xjACqL+85N
         +/sw==
X-Gm-Message-State: ABy/qLYyDF6+t/cU9lZ40rVis5afHjq75/yV2JMw6KkDtLpJFWclOIaj
        rZZVq6Tg+ab8eG9rxcjAQXN66To9LdQgyNBhKO9qTP6ykRAamiAye5MJbE5ODGnMFMScSf/qNf7
        yb9T7V1pCQhJdMeUopETPMudo
X-Received: by 2002:a17:902:ce81:b0:1b8:adc:7c3d with SMTP id f1-20020a170902ce8100b001b80adc7c3dmr1085525plg.40.1690337289914;
        Tue, 25 Jul 2023 19:08:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFME03RuiNFMjrYDkMFSyzXe5DoUsVifAoxnjrckHRpcYIqgyVS/r0ZzVYgv+QZMxRzMOzqxA==
X-Received: by 2002:a17:902:ce81:b0:1b8:adc:7c3d with SMTP id f1-20020a170902ce8100b001b80adc7c3dmr1085513plg.40.1690337289554;
        Tue, 25 Jul 2023 19:08:09 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902788800b001b9fef7f454sm11760512pll.73.2023.07.25.19.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:08:09 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ima: require signed IMA policy when UEFI secure boot is enabled
Date:   Wed, 26 Jul 2023 10:08:05 +0800
Message-ID: <20230726020806.926734-1-coxu@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703115442.129725-1-coxu@redhat.com>
References: <20230703115442.129725-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 099f26f22f58 ("integrity: machine keyring CA
configuration"), users are able to add custom IMA CA keys via
MOK.  This allows users to sign their own IMA polices without
recompiling the kernel. For the sake of security, mandate signed IMA
policy when UEFI secure boot is enabled.

Note this change may affect existing users/tests i.e users won't be able
to load an unsigned IMA policy when the IMA architecture specific policy
is configured and UEFI secure boot is enabled.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v2
 - improve commit message [Mimi]
  - explicitly mention the dependent commit
  - add a note that the change will affect user space
 - remove "/* CONFIG_INTEGRITY_MACHINE_KEYRING .. */" to improve code
   readability
---
 security/integrity/ima/ima_efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 9db66fe310d4..138029bfcce1 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -57,6 +57,9 @@ static const char * const sb_arch_rules[] = {
 	"measure func=KEXEC_KERNEL_CHECK",
 #if !IS_ENABLED(CONFIG_MODULE_SIG)
 	"appraise func=MODULE_CHECK appraise_type=imasig",
+#endif
+#if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
+	"appraise func=POLICY_CHECK appraise_type=imasig",
 #endif
 	"measure func=MODULE_CHECK",
 	NULL
-- 
2.41.0

