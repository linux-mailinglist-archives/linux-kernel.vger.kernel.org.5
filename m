Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91887CB6CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjJPXAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjJPXAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:00:01 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D495
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:59:59 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 7A71D240028
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697497198; bh=e/5Tq8mpMYFzV9iwEEcLoCLz0k+o4VrsmcZ/cYdtLww=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=mFwnzH/dCSbg254F+1fJ/qnNuV9LnSM9dAXfq4u+EzeUtGgSte60xd6Pp0ArZ9Fk+
         kc+DoD7qHcW6vQXObYxgEIJIKcBhkw+F74AJ10Ubrcr3I5T6ZJv7+EGS2sESsBd4q0
         vPESqkUkInNmBOuFUamKVnp4iAfVdgt8tGdRuxHuzHiomI9LJqbW7QcqqIwG6VjErw
         JXj3OPW0VIttmEusrAnzxLYKuPeC30Bqe1segyOb/xp41bTQBigoEV9avfPm2c3m9z
         xJsc+fz7R4NFN4H0Ml/t/NiDkZtU8LOd07RneZ5eNR3yNgRKSIzhq+41C8iGZW1+7T
         07Ydq+M9ydyJw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S8Xcs0mk7z9rxR;
        Tue, 17 Oct 2023 00:59:57 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>,
        Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH v3 3/3] nvme-auth: allow mixing of secret and hash lengths
Date:   Mon, 16 Oct 2023 22:58:57 +0000
Message-Id: <20231016225857.3085234-4-shiftee@posteo.net>
In-Reply-To: <20231016225857.3085234-1-shiftee@posteo.net>
References: <20231016225857.3085234-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now use any of the secret transformation hashes with a
secret, regardless of the secret size.
e.g. a 32 byte key with the SHA-512(64 byte) hash.

The example secret from the spec should now be permitted with
any of the following:
DHHC-1:00:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:01:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:02:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:03:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:

Note: Secrets are still restricted to 32,48 or 64 bits.

Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/auth.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 647931acc1ba..c2273bc0fa56 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -182,14 +182,6 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 		goto out_free_secret;
 	}
 
-	if (key_hash > 0 &&
-	    (key_len - 4) != nvme_auth_hmac_hash_len(key_hash)) {
-		pr_err("Mismatched key len %d for %s\n", key_len,
-		       nvme_auth_hmac_name(key_hash));
-		ret = -EINVAL;
-		goto out_free_secret;
-	}
-
 	/* The last four bytes is the CRC in little-endian format */
 	key_len -= 4;
 	/*
-- 
2.39.2

