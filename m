Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F6E75E067
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 09:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGWH7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 03:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGWH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 03:59:47 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6659191
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 00:59:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.174.92.167])
        by mail-app3 (Coremail) with SMTP id cC_KCgC3aJ3q3bxkHHJ_Cw--.18483S4;
        Sun, 23 Jul 2023 15:59:39 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     ketan.mukadam@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1] scsi: be2iscsi: Add length check when parsing nlattrs
Date:   Sun, 23 Jul 2023 15:59:38 +0800
Message-Id: <20230723075938.3713864-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgC3aJ3q3bxkHHJ_Cw--.18483S4
X-Coremail-Antispam: 1UD129KBjvJXoWrtF15ZrWrCFWxuw48CrW7Jwb_yoW8Jr17pF
        W8uasrAwn8Jw1S9r1UGr4fXFyFka15JFyjgFW7tasxCF1UJFySgry3K342kFyUCan5Jwsx
        tr1DtFy8urZ2vrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4x
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
        W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUm-eOUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

beiscsi_iface_set_param parses nlattr with nla_for_each_attr and assumes
every attributes can be viewed as struct iscsi_iface_param_info.

This is not true because there is no any nla_policy to validate the
attributes passed from the upper function iscsi_set_iface_params.

This patch adds the nla_len check before accessing the nlattr data and
error return EINVAL if the length check fails.

Fixes: 0e43895ec1f4 ("[SCSI] be2iscsi: adding functionality to change network settings using iscsiadm")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/scsi/be2iscsi/be_iscsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index 8aeaddc93b16..8d374ae863ba 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -450,6 +450,10 @@ int beiscsi_iface_set_param(struct Scsi_Host *shost,
 	}
 
 	nla_for_each_attr(attrib, data, dt_len, rm_len) {
+		/* ignore nla_type as it is never used */
+		if (nla_len(attrib) < sizeof(*iface_param))
+			return -EINVAL;
+
 		iface_param = nla_data(attrib);
 
 		if (iface_param->param_type != ISCSI_NET_PARAM)
-- 
2.17.1

