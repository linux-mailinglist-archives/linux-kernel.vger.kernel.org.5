Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543F377FEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354838AbjHQUWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354830AbjHQUWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:22:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0F4359C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:22:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6889656eb58so185211b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692303741; x=1692908541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQWTQHtC1ITha/tOEZ9DX/iOFJ3wpSlHPk0KGWIN+BE=;
        b=IAxdc2j2QTjPlPywoE11+AaxM9vPILUqMj103UtiRZvlm2AdOrRBhW08TzXFxh0CSF
         9VkutAjQVk5ucHl7yCtFEuzSfZGMCxSOn8dIsc6tM5bm1daac88Mc+OTJAs0t2MfOs3h
         NnGcACX1ls5v6sgq2427aZRJqr2eK92x6n+w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692303741; x=1692908541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQWTQHtC1ITha/tOEZ9DX/iOFJ3wpSlHPk0KGWIN+BE=;
        b=kaDSKqS6VFBR9DCCN2Yb2lCtmBr2+aOLmOm98O7s5bNJjVp6CBMg8+4ANYsxXQkZW1
         Am4ClRcrQqcdwf0gho5cdDJIeQ8hZCuf3+82gSHvONazEyYasKPsF3mv8GiTNcR61cVN
         0FmaszuXKCKfoRbbJ11Ne0vPI0x6FwwVnUPE8qG1oYM9H/EiCVNT7iWnFJzNwpebyjao
         nbFHF/9Ul2sLu6Uehg/BZcUXOWX1HlJuFWa9bdw4VmgWRVmzXhC1yLnbZ35cvS0ogDa3
         Fjmb5ZIDpT+JxkWeVTI9wKDkncKPYLls9K15rOdt6Ef2iiJqdkIInkt5PsE4ESTQWpn/
         QLKA==
X-Gm-Message-State: AOJu0YxRQ8eU52K7bjoyIUX08zbhqqZdbjZZNge7M5XyEaw0iahevRxU
        8gdEA2fECcHrQK7a5MODMnyoRQ==
X-Google-Smtp-Source: AGHT+IH0a7s6AYYQXpvO0xlNMu3ZvWTFwdxg4ZxRGN+ufbgm5n14hckHsT5PGrY2DP6SM76vFO1geQ==
X-Received: by 2002:a05:6a00:1952:b0:686:7621:5494 with SMTP id s18-20020a056a00195200b0068676215494mr681891pfk.27.1692303741176;
        Thu, 17 Aug 2023 13:22:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b006884844dfcasm168593pfh.20.2023.08.17.13.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:22:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] selinux: Annotate struct sidtab_str_cache with __counted_by
Date:   Thu, 17 Aug 2023 13:22:17 -0700
Message-Id: <20230817202210.never.014-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=keescook@chromium.org;
 h=from:subject:message-id; bh=5Z4+8RXLjnXvukVAkS7m5m0h4iQubudAZnU60GhPgXg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3oF5KSG7/oZzgaaPj8L+TfV6vQF49o7iTLsqc
 CsYE4XVyXKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6BeQAKCRCJcvTf3G3A
 JgINEACRVV1slxrlC0ri8tUBcUXOZbMOJUzsOq8h62tcR9gcOtuvpI2j7ncVYE2gzQMF/lfe2EM
 eFkQuRsXwRWYkINbr5swbgpGKslbMiORIP/wAcv/7LDEKBlnYDP87Oko3qg83DdFUCgfrc+9rYX
 1CPvNfgia4Ch+n1glNONk16VQ18zFnOdzIdmD7XXKVBpMSgz3nhHhmzfEDKwpPJcMryd/4KOglv
 mtxax6VU5t0XHzhLHpbQyzsrkvRGJoDa7kVMqahwhEvAFCnQq7cRi/c4CQulbhmivf/ptML/DtB
 5bCKzdZQjuTw5dOTvB7Q+2O1Gbfov/jbt5Wxaz9axEH83pcM/BWxpzLU62KolOZ5Mf5N8GvPBMI
 HbU1WtKFmctbKwjRwkZaa5LzGtg50Sc8Y7E087X/3CqERSG8rg1Wb16y+2Jeo344hhpfTW99DY4
 +H4zIrXdT8z/JpFr/jur1LOuspwfoqFP4Cu80UX44Y/7G4PokWHijVukaYR5jRCF0/YAKc5DaWg
 p65cb1RgbhovtG1xRdv1vbk7A/4Goi9Tx5OqyydDqw08ma9/HXD0rzkvVVaRNZJ8fuQt6CmCTrX
 5QoJhPToUTVGWVeYgfz5yWWL5UUos+kmjpgvPL+xAAyvufz60SoS4NyB6/UwhkS2YdIgiFV3Fpi
 tH6g9Ya 25O81AvQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct sidtab_str_cache.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Eric Paris <eparis@parisplace.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/selinux/ss/sidtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index d8ead463b8df..732fd8e22a12 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -25,7 +25,7 @@ struct sidtab_str_cache {
 	struct list_head lru_member;
 	struct sidtab_entry *parent;
 	u32 len;
-	char str[];
+	char str[] __counted_by(len);
 };
 
 #define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
-- 
2.34.1

