Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09C75CF72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjGUQeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGUQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EBF448B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA46E61D26
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D99C433C7;
        Fri, 21 Jul 2023 16:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689957101;
        bh=m8JBAZgVHHJ/zOTmvjiPf6fxQCeFkFncJTc5I6KWCLI=;
        h=From:Date:Subject:To:Cc:From;
        b=jfLNWf4WAeyvZuf62pFM1M0NxNsm5Rja/JdDBM8ykvNYTpdswa/1FH9xcBB80WMpz
         S3xWsHPPd3AXWpA7ksht9IhqcNvbdYpLK8RsNasxax5DuW3o2qdhojlx5U/to/Rq89
         rLkqhda2+pLn092brXH/AJ/XgZUN6Ey0ge1p5jSoVMPkCC8geK2N3W64zDq5w/1BYk
         gbEtH/i7YMxHE2arTvxsB2g/Ryh+Ui4hSgzi6OFYyA3i72ti8KNlU2/AnNZpwqQnBh
         1jxnEfakFbY/BJglBp9NP0okVrHZ/nsUONm/4zM82tkLAGimxasqgDj0FcGYLeJ0wx
         gvyCo48TwMgcA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 21 Jul 2023 17:31:36 +0100
Subject: [PATCH] regmap: Remove dynamic allocation warnings for rbtree and
 maple
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-regmap-enable-kmalloc-v1-1-f78287e794d3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOeyumQC/x3MQQrDIBBG4avIrDug00VKr1KysPonGWqMKIRAy
 N0jXX6L905qqIpGb3NSxa5Nt9zhHobC4vMM1thNYuVpB3FcMa++MLL/JvBv9SltgQUSbbTuFTB
 Rb0vFpMf/+xmv6wZFjM33ZwAAAA==
To:     Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=broonie@kernel.org;
 h=from:subject:message-id; bh=m8JBAZgVHHJ/zOTmvjiPf6fxQCeFkFncJTc5I6KWCLI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkurLqVjtG08KhD3cLQGIvj/ht5M3auootBVisEoEz
 rZcOwUCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLqy6gAKCRAk1otyXVSH0FsPB/
 9OY463f2P8ko1DD8xWlQM0YRT6eWU2XfsIL4QY6FsewKgNTRBUjjKIx+ZRAYeFB3Pvxr2yAuMUraHZ
 KDzcp84an9ZB6YMb85JkBwASZshqmogd0BTG3pWPuuYXHyeEilaM0rreHPFuo223Z2bRpG8Er6r+fa
 q3jLKOMCtm500TxlA6+VW+cFLFlQvvVIGk+WCzNLXc+cKpEhtBFcm6sI/g8L93WNzVRhbgHXH51yX+
 4IVZ54fWq4wBZIhCyrDvFNU+VMUaq5p8MtAIHNdHYdNA+4SWDrgnysPeDMZMvTBCnC4jI2CvyQw8iZ
 qxDGY9F468YlonJ2lA277WrwEKqJE1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Dan and Guenter's very prompt updates of the rbtree and maple
caches to support GPF_ATOMIC allocations and since the update shook out
a bunch of users at least some of whom have been suitably careful about
ensuring that the cache is prepoulated so there are no dynamic
allocations after init let's revert the warnings.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 6c637b18d6b0..8b37451fa931 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -723,15 +723,6 @@ struct regmap *__regmap_init(struct device *dev,
 	} else {
 		if ((bus && bus->fast_io) ||
 		    config->fast_io) {
-			/*
-			 * fast_io is incompatible with REGCACHE_RBTREE and REGCACHE_MAPLE
-			 * since both need to dynamically allocate memory.
-			 */
-			if (config->cache_type == REGCACHE_RBTREE ||
-			    config->cache_type == REGCACHE_MAPLE) {
-				ret = -EINVAL;
-				goto err_name;
-			}
 			if (config->use_raw_spinlock) {
 				raw_spin_lock_init(&map->raw_spinlock);
 				map->lock = regmap_lock_raw_spinlock;

---
base-commit: b0393e1fe40e962574613a5cdc4a470d6c1de023
change-id: 20230721-regmap-enable-kmalloc-2e2d0d018cef

Best regards,
-- 
Mark Brown <broonie@kernel.org>

