Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A699C7742E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjHHRv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjHHRvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:51:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A047527575
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:22:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33CFF2247B;
        Tue,  8 Aug 2023 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691486155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UqHXroF0EJl+GQpEdHdxmBrPdAQdE5qHCwe+sk9yKxY=;
        b=snqUzZ/B6zgsf/a2M2yhOjHmsHNeE9mHSaQedd9HVD8zCfvICExE8fF8i2wK6Mxfya9hLZ
        2/YPrWwNzvAADwz9fiEJCcm5eGVH4DwVehewaNCgTRA4QOA24R82BZ5h8KzZzAsfuMyASc
        7NNIIhFghv9O3Yq9DX7O1mnhEB4tgtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691486155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UqHXroF0EJl+GQpEdHdxmBrPdAQdE5qHCwe+sk9yKxY=;
        b=A2nzBfaKm1XJcZKFQiPgvBxqO4IyAZZq1GHglpbsmBy2zo0jaP1RAVWN0z6khC9NMN40dY
        wK+XojC5yp1xewAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 256AB13451;
        Tue,  8 Aug 2023 09:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pT4SCcsH0mRCEwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 09:15:55 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Caleb Sander <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v3 1/2] fabrics: Read the supported options lazy
Date:   Tue,  8 Aug 2023 11:15:49 +0200
Message-ID: <20230808091550.25349-2-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808091550.25349-1-dwagner@suse.de>
References: <20230808091550.25349-1-dwagner@suse.de>
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

