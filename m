Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A677459A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjHHSnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjHHSn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:43:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB91387D3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:37:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4396C21B9D;
        Tue,  8 Aug 2023 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691478554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UqHXroF0EJl+GQpEdHdxmBrPdAQdE5qHCwe+sk9yKxY=;
        b=SPkzLMFoMYQVFRBS+m5ctBCNQBVnQaSth4BNFuJth9DzXG5o+wfOzK9riRinpOR2pqhq+T
        K7gKxpokIKcYk8z6u90kVMaz+TSTHuAt8f/bb2JA7evvy2x6wK7BwJl2gQWXXkedAOa3D0
        88LL4iMmrcr7sQQ5amcddbEbAdswwAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691478554;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UqHXroF0EJl+GQpEdHdxmBrPdAQdE5qHCwe+sk9yKxY=;
        b=t2QEvqsRlxTYwQ8fhoFUVUtDzkBSp8XVSKi1f58iPWFKBDZwvrP847wpQwaYBQK8qOyNan
        bmiJnNbStw8lJpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3590013451;
        Tue,  8 Aug 2023 07:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EZbkDBrq0WRoVgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 07:09:14 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Caleb Sander <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v2 1/2] fabrics: Read the supported options lazy
Date:   Tue,  8 Aug 2023 09:09:06 +0200
Message-ID: <20230808070907.18834-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808070907.18834-1-dwagner@suse.de>
References: <20230808070907.18834-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

Read the options in when we need the for the first time.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/nvme/fabrics.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 800293e2a8e7..9725eeb3cda8 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -357,10 +357,18 @@ static int __add_argument(char **argstr, const char *tok, const char *arg)
 	return 0;
 }
 
+static int __nvmf_supported_options(nvme_root_t r);
+#define nvmf_check_option(r, tok)					\
+({									\
+	if (!(r)->options)						\
+		__nvmf_supported_options(r);				\
+	(r)->options->tok;						\
+})
+
 #define add_bool_argument(o, argstr, tok, arg)				\
 ({									\
 	int ret;							\
-	if (r->options->tok) {						\
+	if (nvmf_check_option(r, tok)) {				\
 		ret = __add_bool_argument(argstr,			\
 					  stringify(tok),		\
 					  arg);				\
@@ -376,7 +384,7 @@ static int __add_argument(char **argstr, const char *tok, const char *arg)
 #define add_int_argument(o, argstr, tok, arg, allow_zero) \
 ({									\
 	int ret;							\
-	if (r->options->tok) {						\
+	if (nvmf_check_option(r, tok)) {				\
 		ret = __add_int_argument(argstr,			\
 					stringify(tok),			\
 					arg,				\
@@ -393,7 +401,7 @@ static int __add_argument(char **argstr, const char *tok, const char *arg)
 #define add_int_or_minus_one_argument(o, argstr, tok, arg)		\
 ({									\
 	int ret;							\
-	if (r->options->tok) {						\
+	if (nvmf_check_option(r, tok)) {				\
 		ret = __add_int_or_minus_one_argument(argstr,		\
 						     stringify(tok),	\
 						     arg);		\
@@ -409,7 +417,7 @@ static int __add_argument(char **argstr, const char *tok, const char *arg)
 #define add_argument(r, argstr, tok, arg)				\
 ({									\
 	int ret;							\
-	if (r->options->tok) {						\
+	if (nvmf_check_option(r, tok)) {				\
 		ret = __add_argument(argstr,				\
 				     stringify(tok),			\
 				     arg);				\
@@ -913,9 +921,6 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
 		free(traddr);
 	}
 
-	ret = __nvmf_supported_options(h->r);
-	if (ret)
-		return ret;
 	ret = build_options(h, c, &argstr);
 	if (ret)
 		return ret;
-- 
2.41.0

