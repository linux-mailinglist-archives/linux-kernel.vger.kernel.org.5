Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F451799397
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbjIIAZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343692AbjIIAZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:25:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117692105;
        Fri,  8 Sep 2023 17:25:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2319C116A6;
        Sat,  9 Sep 2023 00:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219080;
        bh=WO6hK4F7wbszPm4mhvb7JalFGwN6ho4o50dfBCfv5eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jfE0EV8ZKG/WlezkLCVrZDqqMr8YxcsoamMYZnCXYl2EJZRt2PMn6rftghIAfjBxZ
         4aVGrUKxLqI4MNMet0UdpyvqF7sMigF3kDjqEz8pKBx0we4WOZ5lyxPSCnr4Cd19h5
         5+nyFGs8W3Y3cUgZI+P4PZfV+n/Hg4ZiTRogD66FAXYR4nIJlBz4JwKcZ4PhEFKFYL
         C8sLh/K3hqmPv+AWofoUo+7/vVpTnNvnrc7LdOm8lx7Vb5RqogpagODq4ZU3OC+Vlc
         M54Pa+Q7sP6nZbY6i/mx1PtlXm9dKqq6DdON/WqJCCY5FkaXkfGFv29/cDw18fYwrP
         2UC2g3qRqukIg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     ruanjinjie <ruanjinjie@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, idryomov@gmail.com, ira.weiny@intel.com,
        robh@kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 6/6] powerpc/pseries: fix possible memory leak in ibmebus_bus_init()
Date:   Fri,  8 Sep 2023 20:24:22 -0400
Message-Id: <20230909002424.3578867-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002424.3578867-1-sashal@kernel.org>
References: <20230909002424.3578867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.294
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
index c7c1140c13b6c..3fce7508a4fc6 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -452,6 +452,7 @@ static int __init ibmebus_bus_init(void)
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 		       __func__, err);
+		put_device(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
-- 
2.40.1

