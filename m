Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF4D79865C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbjIHLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjIHLU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:20:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266101BC6;
        Fri,  8 Sep 2023 04:20:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 86E611FDD5;
        Fri,  8 Sep 2023 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694172022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UKGf46dM5wy/YYrh7hZTASNpomZS91f4ZJYwdzVJII8=;
        b=VH//U6Qqhr+hJGKABtr4Py8qagMFNul82uBfm7ux5FJDXah8pvUNpBJ2/Qjj0QfHtzfPmU
        6mbU498nGQq4Yg5KEDNdnzH/9jzC2jqry7UXzTEawEnrwL5S0phYfDjnWsTFiLE7OClPQi
        P1yn/DLEEujkLrZLFWVViz7uDD7VKsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694172022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UKGf46dM5wy/YYrh7hZTASNpomZS91f4ZJYwdzVJII8=;
        b=fSx00NrPUltgfeHdaDbXmUEpSqSeq1SMe2OwKwbaHibDCHDWOATFu0zOecFAOerTEKHF1w
        vKp+cCuM3PSSdJCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEC2B131FD;
        Fri,  8 Sep 2023 11:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TGoSN3UD+2RiFAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 08 Sep 2023 11:20:21 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b9c0145e;
        Fri, 8 Sep 2023 11:20:21 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Milind Changire <mchangir@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] ceph: remove unnecessary check for NULL in parse_longname()
Date:   Fri,  8 Sep 2023 12:20:20 +0100
Message-Id: <20230908112020.27090-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ceph_get_inode() never returns NULL; instead it returns an
ERR_PTR() if something fails.  Thus, the check for NULL in parse_longname()
is useless and can be dropped.  Instead, move there the debug code that
does the error checking so that it's only executed if ceph_get_inode() is
called.

Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Changes since v2:
As suggested by Xiubo, moved the error checking into the 'if (!dir)'
block.

 fs/ceph/crypto.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index e4d5cd56a80b..e1f31b86fd48 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -249,11 +249,9 @@ static struct inode *parse_longname(const struct inode *parent,
 	if (!dir) {
 		/* This can happen if we're not mounting cephfs on the root */
 		dir = ceph_get_inode(parent->i_sb, vino, NULL);
-		if (!dir)
-			dir = ERR_PTR(-ENOENT);
+		if (IS_ERR(dir))
+			dout("Can't find inode %s (%s)\n", inode_number, name);
 	}
-	if (IS_ERR(dir))
-		dout("Can't find inode %s (%s)\n", inode_number, name);
 
 out:
 	kfree(inode_number);
