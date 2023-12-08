Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5EA809CA1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjLHG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLHG6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:58:01 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86CD1718;
        Thu,  7 Dec 2023 22:58:06 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SmhmS6xz0z4f3jqZ;
        Fri,  8 Dec 2023 14:58:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 181101A0A9B;
        Fri,  8 Dec 2023 14:58:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hB3vnJlRn4+DA--.35987S4;
        Fri, 08 Dec 2023 14:58:00 +0800 (CST)
From:   linan666@huaweicloud.com
To:     linkinjeon@kernel.org, sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH] ksmbd: validate the zero field of packet header
Date:   Fri,  8 Dec 2023 14:56:47 +0800
Message-Id: <20231208065647.745640-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hB3vnJlRn4+DA--.35987S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1xWF1UuFW3Xr1UKw4Uurg_yoW8Gr18pr
        45Ary5WrWrXr43CF4ktFy8u3WYgr1kJr47trZrCwnrZrZ7tw48tF1IqwnIgF1fXFyrJFy0
        vr4qvanYka40kaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40E
        w7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UKoG
        dUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

The SMB2 Protocol requires that "The first byte of the Direct TCP
transport packet header MUST be zero (0x00)"[1]. Commit 1c1bcf2d3ea0
("ksmbd: validate smb request protocol id") removed the validation of
this 1-byte zero. Add the validation back now.

[1]: [MS-SMB2] - v20230227, page 30.
https://winprotocoldoc.blob.core.windows.net/productionwindowsarchives/MS-SMB2/%5bMS-SMB2%5d-230227.pdf

Fixes: 1c1bcf2d3ea0 ("ksmbd: validate smb request protocol id")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 fs/smb/server/smb_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 6691ae68af0c..7c98bf699772 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -158,8 +158,12 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
  */
 bool ksmbd_smb_request(struct ksmbd_conn *conn)
 {
-	__le32 *proto = (__le32 *)smb2_get_msg(conn->request_buf);
+	__le32 *proto;
 
+	if (conn->request_buf[0] != 0)
+		return false;
+
+	proto = (__le32 *)smb2_get_msg(conn->request_buf);
 	if (*proto == SMB2_COMPRESSION_TRANSFORM_ID) {
 		pr_err_ratelimited("smb2 compression not support yet");
 		return false;
-- 
2.39.2

