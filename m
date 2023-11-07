Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDBE7E4511
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjKGQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344835AbjKGP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:59:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1581126;
        Tue,  7 Nov 2023 07:52:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7460AC433C9;
        Tue,  7 Nov 2023 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372374;
        bh=PsjWDKrvCnrYkyQWoxTiJemIijmjf0M5UJ0Pzvb3jBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OssHrQqmgyI6F0q7ncw3ivdswPlnhRVCx9OG3i7W4/uKSjI9Igftf3OFpbeOKJBOn
         /LbKaObMCs3IDAxMednkOw8OWVCe45VU+/ju5olqKPTyGzVHQhLlkJjIh9iXCcaiSP
         YG4lQtdIcXXaEBX+tRF5qe+o0+n4hPLEhAZIx3IRIEb0tnEnmzWLzXNI2HXK5UZx7d
         GSm5mnsR4vTn9HEN4aA+rc+x3pTgffTO1YwPB2u6b6nr0SZrZCxjFxD5orlHcA6p/n
         qqRsRCmQbkuX8UU/zmPAFygC9ZLBBZ3BRez39MhyjelDz1hxnh8BKe4jPcuj+UkrQL
         WNul4jN1BNUXg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Jialin <lujialin4@huawei.com>, Guo Zihua <guozihua@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, steffen.klassert@secunet.com,
        davem@davemloft.net, daniel.m.jordan@oracle.com,
        linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/16] crypto: pcrypt - Fix hungtask for PADATA_RESET
Date:   Tue,  7 Nov 2023 10:52:21 -0500
Message-ID: <20231107155249.3768098-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155249.3768098-1-sashal@kernel.org>
References: <20231107155249.3768098-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Jialin <lujialin4@huawei.com>

[ Upstream commit 8f4f68e788c3a7a696546291258bfa5fdb215523 ]

We found a hungtask bug in test_aead_vec_cfg as follows:

INFO: task cryptomgr_test:391009 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Call trace:
 __switch_to+0x98/0xe0
 __schedule+0x6c4/0xf40
 schedule+0xd8/0x1b4
 schedule_timeout+0x474/0x560
 wait_for_common+0x368/0x4e0
 wait_for_completion+0x20/0x30
 wait_for_completion+0x20/0x30
 test_aead_vec_cfg+0xab4/0xd50
 test_aead+0x144/0x1f0
 alg_test_aead+0xd8/0x1e0
 alg_test+0x634/0x890
 cryptomgr_test+0x40/0x70
 kthread+0x1e0/0x220
 ret_from_fork+0x10/0x18
 Kernel panic - not syncing: hung_task: blocked tasks

For padata_do_parallel, when the return err is 0 or -EBUSY, it will call
wait_for_completion(&wait->completion) in test_aead_vec_cfg. In normal
case, aead_request_complete() will be called in pcrypt_aead_serial and the
return err is 0 for padata_do_parallel. But, when pinst->flags is
PADATA_RESET, the return err is -EBUSY for padata_do_parallel, and it
won't call aead_request_complete(). Therefore, test_aead_vec_cfg will
hung at wait_for_completion(&wait->completion), which will cause
hungtask.

The problem comes as following:
(padata_do_parallel)                 |
    rcu_read_lock_bh();              |
    err = -EINVAL;                   |   (padata_replace)
                                     |     pinst->flags |= PADATA_RESET;
    err = -EBUSY                     |
    if (pinst->flags & PADATA_RESET) |
        rcu_read_unlock_bh()         |
        return err

In order to resolve the problem, we replace the return err -EBUSY with
-EAGAIN, which means parallel_data is changing, and the caller should call
it again.

v3:
remove retry and just change the return err.
v2:
introduce padata_try_do_parallel() in pcrypt_aead_encrypt and
pcrypt_aead_decrypt to solve the hungtask.

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
Signed-off-by: Guo Zihua <guozihua@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/pcrypt.c | 4 ++++
 kernel/padata.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 9d10b846ccf73..005a36cb21bc4 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -117,6 +117,8 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 	err = padata_do_parallel(ictx->psenc, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
@@ -164,6 +166,8 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 	err = padata_do_parallel(ictx->psdec, padata, &ctx->cb_cpu);
 	if (!err)
 		return -EINPROGRESS;
+	if (err == -EBUSY)
+		return -EAGAIN;
 
 	return err;
 }
diff --git a/kernel/padata.c b/kernel/padata.c
index 11ca3ebd8b123..ece4a2b77d32b 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -207,7 +207,7 @@ int padata_do_parallel(struct padata_shell *ps,
 		*cb_cpu = cpu;
 	}
 
-	err =  -EBUSY;
+	err = -EBUSY;
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
-- 
2.42.0

