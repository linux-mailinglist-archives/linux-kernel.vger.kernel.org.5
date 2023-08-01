Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748AE76BFA1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjHAVzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjHAVzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A121BE3;
        Tue,  1 Aug 2023 14:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C60161717;
        Tue,  1 Aug 2023 21:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9F1C433C7;
        Tue,  1 Aug 2023 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690926921;
        bh=B054y3pqR16hOaTgxhtMZYYzfM1FPP+fTzP45gff++8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=i3lVzoPkWKvatlAmGtmtZECfXTJmytvIw9nVWdr1PT0cPMUlXdaC4BrjgQUKrc/r1
         HI8JWAgR+bsku8IV6iID66RJ6I4BEEQW0uvKLmlQBNTJnjr0WdA4Aj/3Mc6b+ebeHX
         bLul4tGlWmh8OP9DpwZ0xeRvTiK+0fV+6wSvGiP7pD16WgyKWyvo+A0ak/Iq4cppJw
         mWgtZsU5uBmSNS7/OoaDhUjRIpGoqWPAinj+/lh4hHuxssa+7HY5iofVwVEzcY0LJz
         mns8ArNf+IUHmlGwbWCt9HozXfTCtVPH/oNSDSVahcdLT6y0MJNcoGuqrwdkISq2Kh
         gmykdmkURTe3w==
Received: (nullmailer pid 2469337 invoked by uid 1000);
        Tue, 01 Aug 2023 21:55:14 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 01 Aug 2023 15:54:44 -0600
Subject: [PATCH 1/5] of: unittest: Fix EXPECT for
 parse_phandle_with_args_map() test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-dt-changeset-fixes-v1-1-b5203e3fc22f@kernel.org>
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

