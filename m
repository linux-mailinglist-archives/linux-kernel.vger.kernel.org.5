Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A6757C76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjGRNAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGRNAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502401B6;
        Tue, 18 Jul 2023 05:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2866614FB;
        Tue, 18 Jul 2023 12:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0484EC433C7;
        Tue, 18 Jul 2023 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689685196;
        bh=GKaoOTrRRgm3th2yeQunqYwl7QvKD9b4yz/UgiWU3NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5dvqAwNacmP9ofhTkW3T21chYyCqFIyw+EZKp42wVyn1aBnT5CMtykmkhXPBNAq/
         dGkTWQjllhBsahtnxuWrT87+tMg5Aj23IVinvMXW8KOejUf8GgnDVVVmMVKVvh2QtE
         R0+XyqV+Xe9Ab43eG/9cXVw4nBOiwYdiyBav7XTJ2PoskZrgMQQ8fTOZMOsQtUA1NO
         yIPJjP9XtCxFVuinva0jPVu4cDhNmqsnTt8xiABPoaB0ZVmS+o/RqHoyAe5Fplb5Us
         e4ZptUjNImOL1KKyHCWo/EJNvdPApIHEdnjfzLoE3LCknGqVwsN0292H46WRVCLqVX
         ANtj4BazzH8OQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Haren Myneni <haren@us.ibm.com>,
        Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Richard Weinberger <richard@nod.at>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Subject: [RFC PATCH 06/21] ubifs: Avoid allocating buffer space unnecessarily
Date:   Tue, 18 Jul 2023 14:58:32 +0200
Message-Id: <20230718125847.3869700-7-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=ardb@kernel.org; h=from:subject; bh=GKaoOTrRRgm3th2yeQunqYwl7QvKD9b4yz/UgiWU3NQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbTwlX6/4+66t8K795H8qq3nyxPGW6+prOkJjeOC3pB VKTDl7pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMJ38fIcIktU2XVksXxPvnz 7ZMjji6vymHbt3vhb8tlaW3L36gWdjAy/KlaojvPzyKk+4acZfHypV+1GfmK5ggkHxKI0X7uaXa XGwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recompression scratch buffer is only used when the data node is
compressed, and there is no need to allocate it otherwise. So move the
allocation into the branch of the if() that actually makes use of it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/ubifs/journal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 4e5961878f336033..5ce618f82aed201b 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1485,16 +1485,9 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
 			      unsigned int block, struct ubifs_data_node *dn,
 			      int *new_len, int dn_size)
 {
-	void *buf;
+	void *buf = NULL;
 	int err, dlen, compr_type, out_len, data_size;
 
-	out_len = le32_to_cpu(dn->size);
-	buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
-	if (!buf)
-		return -ENOMEM;
-
-	out_len *= WORST_COMPR_FACTOR;
-
 	dlen = le32_to_cpu(dn->ch.len) - UBIFS_DATA_NODE_SZ;
 	data_size = dn_size - UBIFS_DATA_NODE_SZ;
 	compr_type = le16_to_cpu(dn->compr_type);
@@ -1508,6 +1501,13 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
 	if (compr_type == UBIFS_COMPR_NONE) {
 		out_len = *new_len;
 	} else {
+		out_len = le32_to_cpu(dn->size);
+		buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
+		if (!buf)
+			return -ENOMEM;
+
+		out_len *= WORST_COMPR_FACTOR;
+
 		err = ubifs_decompress(c, &dn->data, dlen, buf, &out_len, compr_type);
 		if (err)
 			goto out;
-- 
2.39.2

