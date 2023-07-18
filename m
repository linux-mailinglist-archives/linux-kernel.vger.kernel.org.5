Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7543E757C73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjGRNAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjGRNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C041BEE;
        Tue, 18 Jul 2023 05:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2607D6157D;
        Tue, 18 Jul 2023 12:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D366C433CA;
        Tue, 18 Jul 2023 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689685191;
        bh=ODoi2e+vcqIb799pflsdMhm1nGdkubtWgbUegajrVfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDalzP/YaXdnw/eO5FhMttHT+uo4cUQ0HEfzV/eVDhjrh2vL2AqqxXcAqh13yqJn4
         AVbM5TSLu3q0pr2cIE2wClirkeGHzrnHwdeCo5pdmULzTvNEpku6b70jtE1ArlykWc
         iaLRyhhRjQiHzGqDFnFYCpXBS8sZnvAGylTxo/SCUEVIt3zDITwUPYFYeNX441iuA5
         UPvKWFmqWGmWjFjxj3GAvUxK0AMTKP3bw+ZiMK2blBchprVp/PM9vi8CkYksqH9lwv
         0KW/Y7eXnjmHRBPOokrRrf/vKW7znD2how5Rm7j4/YU0ipme/NjIaZ8mn9lIi/NwrT
         dtMt3ZU+yjBpQ==
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
Subject: [RFC PATCH 05/21] ubifs: Pass worst-case buffer size to compression routines
Date:   Tue, 18 Jul 2023 14:58:31 +0200
Message-Id: <20230718125847.3869700-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
References: <20230718125847.3869700-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=ardb@kernel.org; h=from:subject; bh=ODoi2e+vcqIb799pflsdMhm1nGdkubtWgbUegajrVfU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWVbT9FzF2aeyo1FL46LhUf9emTqUM1q5dWwJ2Dzr1cTG sRaswQ7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETqRRgZriduT8+o3D0pY5fL upjHTB/UclQ3ycjOPOLy0+e+sqX/b4Z/Wgf3MzUs1I/L09XztZ/lvWNdMcPstI16pS5bDvIdeTO NGwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the ubifs code allocates a worst case buffer size to
recompress a data node, but does not pass the size of that buffer to the
compression code. This means that the compression code will never use
the additional space, and might fail spuriously due to lack of space.

So let's multiply out_len by WORST_COMPR_FACTOR after allocating the
buffer. Doing so is guaranteed not to overflow, given that the preceding
kmalloc_array() call would have failed otherwise.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/ubifs/journal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index dc52ac0f4a345f30..4e5961878f336033 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1493,6 +1493,8 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
 	if (!buf)
 		return -ENOMEM;
 
+	out_len *= WORST_COMPR_FACTOR;
+
 	dlen = le32_to_cpu(dn->ch.len) - UBIFS_DATA_NODE_SZ;
 	data_size = dn_size - UBIFS_DATA_NODE_SZ;
 	compr_type = le16_to_cpu(dn->compr_type);
-- 
2.39.2

