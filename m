Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5864077CD68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjHONj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbjHONjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:39:04 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBE81987;
        Tue, 15 Aug 2023 06:39:03 -0700 (PDT)
Received: from lvc-arm12.ispras.local (unknown [83.149.199.126])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0C3D440D403D;
        Tue, 15 Aug 2023 13:39:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0C3D440D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1692106741;
        bh=ppofgqq6GQi8Ti5gFxuTUknu7evg6JxYTDtGc4lyKUo=;
        h=From:To:Cc:Subject:Date:From;
        b=LSHfQi3VUwAtAV/y9CXJnx36zPh+eKXeopAGHkkxdOrfKcEyuzPPxjLuXDQRWKjfk
         8elkJ+TLrPHKp1HbJVUHWlt1HEKF9GZWok0PMSLu4X4O6MXnEYF76VepFznDCrZB7U
         XQHT5l1Sr9QxMaeFY77QMnpVp4k5MNIaKiZoM4OI=
From:   Katya Orlova <e.orlova@ispras.ru>
To:     David Howells <dhowells@redhat.com>
Cc:     Katya Orlova <e.orlova@ispras.ru>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] smb: propagate error code of extract_sharename()
Date:   Tue, 15 Aug 2023 16:38:31 +0300
Message-Id: <20230815133831.3537-1-e.orlova@ispras.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the EINVAL, there may be an ENOMEM.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 70431bfd825d ("cifs: Support fscache indexing rewrite")
Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
---
 fs/smb/client/fscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index 8f6909d633da..34e20c4cd507 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -48,7 +48,7 @@ int cifs_fscache_get_super_cookie(struct cifs_tcon *tcon)
 	sharename = extract_sharename(tcon->tree_name);
 	if (IS_ERR(sharename)) {
 		cifs_dbg(FYI, "%s: couldn't extract sharename\n", __func__);
-		return -EINVAL;
+		return PTR_ERR(sharename);
 	}
 
 	slen = strlen(sharename);
-- 
2.30.2

