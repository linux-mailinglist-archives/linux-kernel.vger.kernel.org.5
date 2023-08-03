Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CEC76E976
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjHCNGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjHCNGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149704C18;
        Thu,  3 Aug 2023 06:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8B4661DB5;
        Thu,  3 Aug 2023 13:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62881C433CD;
        Thu,  3 Aug 2023 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067876;
        bh=B0ccqMDH+AdwAIknI9mc/N/RE4LfBQNH+2x2/BA7yZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BO22zNhs3Sa8KgtAkQf9FwOBVJk+7NMnXn5hYUMVwKrHn/Sl1kOIb82ojmdgFsLCV
         109LDOgAUGFwNuLVcK0ZHH8Y58Q49OmVAOg0wQmSHkwG7kqEQqFHxJhrPv7adgd3/J
         p9OjKrWn1G6VrE4ipwGN5YHnKEw+0jhryDetWTqelwTBeud8lcmuutIOCPtru5C4Z/
         y2NB+APbpdOdae7chURFqC5k/ZF+JBUjyTZo/w9eE7G5XIvi7p/qJN/jzuHX5c0Fwy
         pTaFVVeK7ig07+TWnJkFI+Vk3hR6vL96NRgYSx2dVSStPCChLGSYzCvSj1LPLBy8G7
         y3Tk+91B1WbrQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/4] Bluetooth: MGMT: Use correct address for memcpy()
Date:   Thu,  3 Aug 2023 09:04:27 -0400
Message-Id: <20230803130429.641927-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130429.641927-1-sashal@kernel.org>
References: <20230803130429.641927-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.42
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit d1f0a9816f5fbc1316355ec1aa4ddfb9b624cca5 ]

In function ‘fortify_memcpy_chk’,
    inlined from ‘get_conn_info_complete’ at net/bluetooth/mgmt.c:7281:2:
include/linux/fortify-string.h:592:25: error: call to
‘__read_overflow2_field’ declared with attribute warning: detected read
beyond size of field (2nd parameter); maybe use struct_group()?
[-Werror=attribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

This is due to the wrong member is used for memcpy(). Use correct one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 815f2abe918ef..81e8da4502a1e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7277,7 +7277,7 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	memcpy(&rp.addr, &cp->addr.bdaddr, sizeof(rp.addr));
+	memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
 
 	status = mgmt_status(err);
 	if (status == MGMT_STATUS_SUCCESS) {
-- 
2.40.1

