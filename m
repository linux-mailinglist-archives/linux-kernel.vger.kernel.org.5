Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32244799388
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbjIIAZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345538AbjIIAZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:25:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C302137;
        Fri,  8 Sep 2023 17:25:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6D8C43395;
        Sat,  9 Sep 2023 00:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219060;
        bh=XaLwkZbgwq8VhhUfEF5Ts7Ebf7d63rJcIgkvJ+CxlEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ut/m9OotkCk/bDNgndiVb9/P+uIBFIAebGR87N+02hiShNuNYdsM2gLbrmuf/fsdG
         AWtw9RaferEVV0JD2NT0fWXWrJq2RwGQFoeQ4nQLf2nhDbq04AMG5GHOcDOe0CC6+O
         08hhohYjKhYfgF1Smw7ainbLgs2hg0oYB+oDUq4miMAAOTQIOEsQ98hzHpskJX7AeF
         GGVNFhRSrrWl7VqRWFIxY86ofNu7sDB7KudfiwhiUpiJ91vQqM1kTe+4vOlzCzozEX
         vP3ovRNHPnY/qUPHUPgg/3vab8udYd5vtcXUYrmJCl4HaDDQJ09BKJVUxS/BDNbsF5
         Y7Y1LwRY+k+rQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     ruanjinjie <ruanjinjie@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, alexs@kernel.org, robh@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 5/6] powerpc/pseries: fix possible memory leak in ibmebus_bus_init()
Date:   Fri,  8 Sep 2023 20:24:04 -0400
Message-Id: <20230909002406.3578776-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002406.3578776-1-sashal@kernel.org>
References: <20230909002406.3578776-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.256
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ruanjinjie <ruanjinjie@huawei.com>

[ Upstream commit afda85b963c12947e298ad85d757e333aa40fd74 ]

If device_register() returns error in ibmebus_bus_init(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop
the reference count that was set in device_initialize() when it fails,
so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20221110011929.3709774-1-ruanjinjie@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index b91eb0929ed14..55569e3c9db72 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -450,6 +450,7 @@ static int __init ibmebus_bus_init(void)
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 		       __func__, err);
+		put_device(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
-- 
2.40.1

