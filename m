Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD7797BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbjIGS1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbjIGS1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:27:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18497A8;
        Thu,  7 Sep 2023 11:26:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8A122188E;
        Thu,  7 Sep 2023 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694093971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ONVEnMgIAJoISYkHQWGBUujCSKf8Jj5CBHejZD3NRXU=;
        b=Ot0ZXYMhWCH6YrumHfZiW5d4VcULsXKDoxYDDRVHhWb+YW+KLnxNJ1C2oNJDwyaZx/r4Pw
        /GJGebh124YT69EwqpgvEc7crQXbH28M7qjq81GvSzdc02qgJq23n/+yErFgwZdeMop3af
        0Q8VGt9jSCyPm05SHapVX+ro4caQ054=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694093971;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ONVEnMgIAJoISYkHQWGBUujCSKf8Jj5CBHejZD3NRXU=;
        b=18OV6yQBF1R5JpYOREwYfAmKOyHd9KlXkRL+pvtMKbYq7skR6jRkCj4FT3ETDdd2lVPQLl
        TatBCGsOhqUH0GDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C674138FA;
        Thu,  7 Sep 2023 13:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ckGRD5PS+WQCQwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 07 Sep 2023 13:39:31 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c734c5a8;
        Thu, 7 Sep 2023 13:39:30 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Milind Changire <mchangir@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] ceph: remove unnecessary check for NULL in parse_longname()
Date:   Thu,  7 Sep 2023 14:39:28 +0100
Message-Id: <20230907133928.11126-1-lhenriques@suse.de>
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
ERR_PTR() if something fails.  Thus, the check for NULL in
parse_longname() useless and can be dropped.

Fixes: dd66df0053ef ("ceph: add support for encrypted snapshot names")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ceph/crypto.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index e4d5cd56a80b..7d0b9b5ccfc6 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -249,8 +249,6 @@ static struct inode *parse_longname(const struct inode *parent,
 	if (!dir) {
 		/* This can happen if we're not mounting cephfs on the root */
 		dir = ceph_get_inode(parent->i_sb, vino, NULL);
-		if (!dir)
-			dir = ERR_PTR(-ENOENT);
 	}
 	if (IS_ERR(dir))
 		dout("Can't find inode %s (%s)\n", inode_number, name);
