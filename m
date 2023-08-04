Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC22770C0D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHDWmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjHDWmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:42:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F74EE1;
        Fri,  4 Aug 2023 15:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 263296215B;
        Fri,  4 Aug 2023 22:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E057AC433C7;
        Fri,  4 Aug 2023 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691188936;
        bh=B054y3pqR16hOaTgxhtMZYYzfM1FPP+fTzP45gff++8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NcvEkl0jGpzfdsz6rc52Cj9eN+IhnnRBs69A4mGOw3PBCoGc1UbxBGAqxfr4xUD0r
         8oe6/RGXNiBFiE+JC3PbumsPgO/eJAgvRET0trwoBICaSzpJNwQzFp+2Mja5ckJGCB
         +cwv9Og101zLRjajmXBHK8DmIYv13BbgygMPjyLIPFp7ThjLKEb6LP104Z152E3qt9
         8bpgjgXPgoIwvBuFidAawZZIlv6vdnFrvU/caxg9Ifp7k2z12RjXSufXOpXXzQt/N+
         b79e76OHavtRGucoOa4gv2EAZKhKBK9srKcS2CmcCzfp3Gyo5cjXORuq6Sn0VhoAz3
         Z7kElAKBZy9Og==
Received: (nullmailer pid 2346975 invoked by uid 1000);
        Fri, 04 Aug 2023 22:42:09 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 04 Aug 2023 16:41:51 -0600
Subject: [PATCH v2 1/6] of: unittest: Fix EXPECT for
 parse_phandle_with_args_map() test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v2-1-c2b701579dee@kernel.org>
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 12e17243d8a1 ("of: base: improve error msg in
of_phandle_iterator_next()") added printing of the phandle value on
error, but failed to update the unittest.

Fixes: 12e17243d8a1 ("of: base: improve error msg in of_phandle_iterator_next()")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e5b0eea8011c..d943bf87c94d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -664,12 +664,12 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	memset(&args, 0, sizeof(args));
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle");
+		     "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678");
 
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-phandle",
 					    "phandle", 0, &args);
 	EXPECT_END(KERN_INFO,
-		   "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle");
+		   "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678");
 
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 

-- 
2.40.1

