Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AE7C8E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjJMU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjJMU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:29:11 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840AABE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:29:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0E3EE240103
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 22:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697228948; bh=PZesDCIO0qB1QiAn0VpqqXvIqc6VhWTAaPu3kq45sGo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=p21QMCQZptEMN8nCgKKrSJyOyuSRMzuXEZInHKUlwjZmVMFuJHrKcz8TcT8Q5ijVU
         P43BfasODEUKbqFXO9F01rmPwq5DRdF+NXCZQsVnmK5/FSX3z+04vB1/hnyFk4k4Td
         q8WLruBeboMc5YIg/sVAfI1aeZq1gZRoXo816fyEM1valib3PmSo+RRqJLq3Cdcgaf
         GgEf4Q9OLc32FJE6fz6Lyes1HNk9LPRLIPAFmP5+049kCOcGSijQI7G6dFGi8RupOH
         rYLndMQal2wARJf1uLBEiw2hsixheq5cgvSysDglPh+fDIKoeX3iWSy9JZHDGq8XRF
         V0iUHB9Qub+5A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S6dQB5FQ1z9rxF;
        Fri, 13 Oct 2023 22:29:06 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>,
        Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH 2/2] nvme-auth: allow mixing of secret and hash lengths
Date:   Fri, 13 Oct 2023 20:28:27 +0000
Message-Id: <20231013202827.2262708-3-shiftee@posteo.net>
In-Reply-To: <20231013202827.2262708-1-shiftee@posteo.net>
References: <20231013202827.2262708-1-shiftee@posteo.net>
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
---
 drivers/nvme/common/auth.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7..176855f86f0d 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -187,14 +187,6 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
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

