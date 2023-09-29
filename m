Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07907B2EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjI2JMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjI2JML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:12:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF12811F;
        Fri, 29 Sep 2023 02:12:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7ABF4210E3;
        Fri, 29 Sep 2023 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695978728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y6Yspn96ID1Nu2kmrOikYfZO30eu8cRjXf4zvZ40V9A=;
        b=SY4tzRLMcYXa/Zj0Fb1x4yDe/UtynljGrYZuUR6FLPEAVL8JVLgJ229RAG7TAkqsEJ7eHE
        wqHf0BaE/SQihaHhIVovvrrz4b3FOh0W00DFoh/xkWLk9VRoABV9/WbEeo9g88mWcaxIKP
        FuFkvozSIbVNAOO9hWo0Qwb/BnO24tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695978728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=y6Yspn96ID1Nu2kmrOikYfZO30eu8cRjXf4zvZ40V9A=;
        b=9B25+CKUeLE5qpy1n9LJlMrd8lpPOene7NLQkGKbmn6Eh32s28kOHFvPE9AiMGvKw7o3i3
        LJ7ysBqATiNvF8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAC1813434;
        Fri, 29 Sep 2023 09:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DOv5NeeUFmXxAQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 29 Sep 2023 09:12:07 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id ec8c4358;
        Fri, 29 Sep 2023 09:12:07 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] ceph: remove unnecessary IS_ERR() check in ceph_fname_to_usr()
Date:   Fri, 29 Sep 2023 10:12:06 +0100
Message-Id: <20230929091206.13955-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before returning, function ceph_fname_to_usr() does a final IS_ERR() check
in 'dir':

	if ((dir != fname->dir) && !IS_ERR(dir)) {...}

This check is unnecessary because, if the 'dir' variable has changed to
something other than 'fname->dir' (it's initial value), that error check has
been performed already and, if there was indeed an error, it would have
been returned immediately.

Besides, this useless IS_ERR() is also confusing static analysis tools.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309282202.xZxGdvS3-lkp@intel.com/
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 fs/ceph/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index e4d5cd56a80b..e19019209cf0 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -462,7 +462,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 out:
 	fscrypt_fname_free_buffer(&_tname);
 out_inode:
-	if ((dir != fname->dir) && !IS_ERR(dir)) {
+	if (dir != fname->dir) {
 		if ((dir->i_state & I_NEW))
 			discard_new_inode(dir);
 		else
