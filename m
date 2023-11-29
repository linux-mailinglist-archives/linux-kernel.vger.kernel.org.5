Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784157FE259
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjK2Vu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK2Vuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:50:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD46B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:50:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3A36C433CB;
        Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701294657;
        bh=kBYMx/ct1DJWmWZZrfAgu5rv/aqJOd49LOYKeJgW/mY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CNpv4DHstKF3PxggnUX4FHrJcqYePxrMZsptqwwZiD3jYC0EtBc4FKCErOk8x0Nma
         089hRb3I+KOjo+2Ret3FHt772sG1ChgiBtUkr3F3Mcc2Tapxt74XpXPuFtOyO8/yW8
         R17MS2K9P9TBhLZ7qiibZ+mz/kv1bGxkQ0A1jzi/RtvdD2B2XiJQpZZe2dsddNCvNK
         wBRPLgYsbplXea35qt4vXD0S68urjWegwAAhc6hOal/Db6K7w24LqcqV5mMkacjiyK
         aWv26FyeF+jG0yhW/SOYwhrqwOXgNDtRQHS52vYv7X9f1D+EvVrgy1TsrnnWtKYRrd
         5MBC0PQ5/ypSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DAC46CA0;
        Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date:   Wed, 29 Nov 2023 15:50:20 -0600
Subject: [PATCH 02/16] mnt_idmapping: include cred.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-2-da5a26058a5b@kernel.org>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=615; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=kBYMx/ct1DJWmWZZrfAgu5rv/aqJOd49LOYKeJgW/mY=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7IzazfoDYxcriweVPsbLfsCP?=
 =?utf-8?q?Xs/YDZSjasrRYGN_eexJIWaJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyMwAKCRBTA5mu5fQxySJiB/_9HkMVbp8BLl9a8xkc+YIMjsDXeUD/DHctJI?=
 =?utf-8?q?ej9o90WQvjfYFOqnp97oRSL05awrVwXaUy4ay7+yCJS_h+TxM3omvveG14tjLJ3wC?=
 =?utf-8?q?yk3SZ5mQum5AyAut1Dx7GvAH+aKzPhZyyQZtT0nPq9vJ494NfMFXjQ5yJ_3S4b0Kc?=
 =?utf-8?q?fPnTHEeSpenRnG/gVjMR15wLsSE07DAnXfndDrwZ25uR9RNVxxoQ2/oIyPGlW9O4K?=
 =?utf-8?q?Zj8s0y_ApyXfbn7vle/qhUTdd10Mt0GITrja5wk0lSvSicVeS2eB1a7VlOSSCIz6P?=
 =?utf-8?q?Qhg2BEDCONPD+NTd0khr?= zlm1ANoVLdZpKoEkqw0ZUzJrM5jm8Z
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received: by B4 Relay for sforshee@kernel.org/default with auth_id=103
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mnt_idmapping.h uses declarations from cred.h, so it should include that
file directly.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/mnt_idmapping.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 8b5e00ee6472..65e5d0c32fde 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/uidgid.h>
 #include <linux/vfsid.h>
+#include <linux/cred.h>
 
 struct mnt_idmap;
 struct user_namespace;

-- 
2.43.0

