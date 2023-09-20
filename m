Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC587A729E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjITGMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjITGMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:12:12 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFC28F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:12:06 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx0.riseup.net (Postfix) with ESMTPS id 4Rr7Tx4DQWz9tHG;
        Wed, 20 Sep 2023 06:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1695190325; bh=LXUyg24PP8tRYHKeCy6iZ2qc+Z9l5WHqKCjRjgW4+iA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=D/o2/oiW+hocWZ5aYVEN7NYHKqcODZAQeFI9JONAeGBdbwvulM0MftK4W17eC/PDi
         HsQ7s99T9x3j5PnUq3IK9j4IkYFbIzuNi9auipFz8e+swKn+ITlUKR0H1umCe3+f2O
         V/8MPj9IlsYyvFd3iplr4hgZcd6lkPTIdEA3MUdk=
X-Riseup-User-ID: 482A8BD71139B096406354321EE928351695F47675410D9D285B79FF5D40C34B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Rr7Ts6G6lzJq77;
        Wed, 20 Sep 2023 06:12:01 +0000 (UTC)
From:   Arthur Grillo <arthurgrillo@riseup.net>
Date:   Wed, 20 Sep 2023 03:11:36 -0300
Subject: [PATCH 1/3] drm/tests: Fix kunit_release_action ctx argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-kunit-kasan-fixes-v1-1-1a0fc261832d@riseup.net>
References: <20230920-kunit-kasan-fixes-v1-0-1a0fc261832d@riseup.net>
In-Reply-To: <20230920-kunit-kasan-fixes-v1-0-1a0fc261832d@riseup.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     tales.aparecida@gmail.com, andrealmeid@riseup.net,
        mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Arthur Grillo <arthurgrillo@riseup.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kunit_action_platform_driver_unregister is added with
&fake_platform_driver as ctx, but the kunit_release_action is called
pdev as ctx. Fix that by replacing it with &fake_platform_driver.

Fixes: 4f2b0b583baa ("drm/tests: helpers: Switch to kunit actions")
Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 3d624ff2f651..3150dbc647ee 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -118,7 +118,7 @@ void drm_kunit_helper_free_device(struct kunit *test, struct device *dev)
 
 	kunit_release_action(test,
 			     kunit_action_platform_driver_unregister,
-			     pdev);
+			     &fake_platform_driver);
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_free_device);
 

-- 
2.41.0

