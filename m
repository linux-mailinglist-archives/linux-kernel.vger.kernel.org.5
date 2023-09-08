Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA83798A40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244761AbjIHPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjIHPzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:55:25 -0400
X-Greylist: delayed 79486 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Sep 2023 08:55:21 PDT
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5DDCCA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:55:21 -0700 (PDT)
From:   Felix Yan <felixonmars@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1694188519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H36z8Kalw/lYouH43EXrAXGy396V7SSzwgzLFYBdMXk=;
        b=rd/7//Goy38Q0g8WTDBIp6yNzVbPWivRD5Z6lNhTVPs+R2Q4ZGybRV1K0fS1egqpxQ/3UR
        Lq7oY23OLhoKmNysoQm6BgpFZoW1mRdTf0YI9Md+v9Y7rw7ZaMZHope4UKhSv/xDL4PG4U
        KESQTsQLhrSIlpqc8VF4XvxU2NnkJzMjxGaR+RLnotwLuaq/s6I9Lp3+08e603kTMk9TBn
        2PMK1V0lTVpoKGrd92+NiDCcmOoPwVwZCkR33LrebJMdCHzRqwV/E2sAiqzK+W3PCONSMc
        x2coU1ISgPYz+7DsyNMvf/+QQ51dUJQfxlLBdZjtzr2FLqhd5GkeEtVC+FPlg4MHHqsho+
        fDk7kNqJmw5nyRY0nK7BbO3RcqEtFkjw4K2uoazoVKCYHu9PGnh9SDmWeIvlEyFvfkYFTl
        tJuu0DHKAP8gv/pTfunh9UqKgW03TI3RPX9NBrKYlP4pLxp/F6zKLj+oNR/habNjk0FRG/
        ElPZJjdLfd+T43xtuEThUZmhVcKH23sY0zeerTZaRv7mtTA1t9Mhn0QhRAuPCsrthmY5tW
        NLupfGx8tYB2Q75nDi+zmiFt4ztwlbVv5rECvtUmV+TwoZhIqqZq4I9Srlgk5vv/U9L1fP
        SF+4Bn2pi0zLDnuq/ld8R1IFa8yPHJ++h/2vOJYkUHI4lyQtRgvUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1694188519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H36z8Kalw/lYouH43EXrAXGy396V7SSzwgzLFYBdMXk=;
        b=zsHuWyCamE0OEQ0Gtpi5DeE0n++7lq+iqQnVeZpK8NIUtL5nWwOqu0VXd9QQIoeJOqhiQP
        wlyNOBOiw5dyd6Cg==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
To:     kbusch@kernel.org, highenthalpyh@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     xuwd1@hotmail.com, Felix Yan <felixonmars@archlinux.org>
Subject: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Date:   Fri,  8 Sep 2023 18:54:42 +0300
Message-ID: <20230908155442.31423-1-felixonmars@archlinux.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVME 2.0 spec section 3.1.3 suggests that "Software should not rely on
0h being returned". Here we should safeguard timeout reads when CRTO is 0 and
fallback to the old NVME 1.4 compatible field.

Fixes 4TB SSD initialization issues with MAXIO MAP1602 controller, including
Lexar NM790, AIGO P7000Z, Fanxiang S790, Acer Predator GM7, etc.

----------
nvme nvme1: Device not ready; aborting initialisation, CSTS=0x0
----------

Signed-off-by: Felix Yan <felixonmars@archlinux.org>
---
 drivers/nvme/host/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..8ec28b1016ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2255,11 +2255,17 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 			return ret;
 		}
 
-		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
-			ctrl->ctrl_config |= NVME_CC_CRIME;
-			timeout = NVME_CRTO_CRIMT(crto);
+		if (crto == 0) {
+			timeout = NVME_CAP_TIMEOUT(ctrl->cap);
+			dev_warn(ctrl->device, "Ignoring bogus CRTO (0), falling back to NVME_CAP_TIMEOUT (%u)\n",
+				timeout);
 		} else {
-			timeout = NVME_CRTO_CRWMT(crto);
+			if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
+				ctrl->ctrl_config |= NVME_CC_CRIME;
+				timeout = NVME_CRTO_CRIMT(crto);
+			} else {
+				timeout = NVME_CRTO_CRWMT(crto);
+			}
 		}
 	} else {
 		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
-- 
2.42.0

