Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12764799466
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346132AbjIIAmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344782AbjIIAks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:40:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79BA1FF0;
        Fri,  8 Sep 2023 17:39:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62008C116AD;
        Sat,  9 Sep 2023 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219877;
        bh=1NsYcEENslsOQLkhwGj1GLcMmwhA4yLoQ4FBH/lMFms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aSU7VSzIvo4gw7lpGkUZExoam4TPG04mBtVGlxqrS82wDf9S/OC66n0VmlY7t9OK7
         zD9mxFEEsuzbXJCpF4Vb1ReBxn5/lrQLQw2Fy6rAw4rtxr2XQHp0V98Ya7dz5Kl7uE
         GGZBPIXFgZY+8JfING0rPfeJfrc+7ezAYLyI0A+ZzaN2LGXUtJsnWD5Ft7TJxbDeVX
         F5cG6W3oxI+dtt7DKKnKzmvaw6kfocu3X0I9jCgt0poMhG75pHIKIlHpplEN0BneAW
         wyjm/wlCjDyWZC1FNARfEuY0U9JjpKeq2iwcmcLHJ9D4Mmi/PZrBQXiRWNsam7tL6a
         l9oyS3s6IpebA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.4 22/25] kobject: Add sanity check for kset->kobj.ktype in kset_register()
Date:   Fri,  8 Sep 2023 20:37:10 -0400
Message-Id: <20230909003715.3579761-22-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003715.3579761-1-sashal@kernel.org>
References: <20230909003715.3579761-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 4d0fe8c52bb3029d83e323c961221156ab98680b ]

When I register a kset in the following way:
	static struct kset my_kset;
	kobject_set_name(&my_kset.kobj, "my_kset");
        ret = kset_register(&my_kset);

A null pointer dereference exception is occurred:
[ 4453.568337] Unable to handle kernel NULL pointer dereference at \
virtual address 0000000000000028
... ...
[ 4453.810361] Call trace:
[ 4453.813062]  kobject_get_ownership+0xc/0x34
[ 4453.817493]  kobject_add_internal+0x98/0x274
[ 4453.822005]  kset_register+0x5c/0xb4
[ 4453.825820]  my_kobj_init+0x44/0x1000 [my_kset]
... ...

Because I didn't initialize my_kset.kobj.ktype.

According to the description in Documentation/core-api/kobject.rst:
 - A ktype is the type of object that embeds a kobject.  Every structure
   that embeds a kobject needs a corresponding ktype.

So add sanity check to make sure kset->kobj.ktype is not NULL.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/r/20230805084114.1298-2-thunder.leizhen@huaweicloud.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kobject.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index f79a434e12316..7feefcabfc4ab 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -855,6 +855,11 @@ int kset_register(struct kset *k)
 	if (!k)
 		return -EINVAL;
 
+	if (!k->kobj.ktype) {
+		pr_err("must have a ktype to be initialized properly!\n");
+		return -EINVAL;
+	}
+
 	kset_init(k);
 	err = kobject_add_internal(&k->kobj);
 	if (err) {
-- 
2.40.1

