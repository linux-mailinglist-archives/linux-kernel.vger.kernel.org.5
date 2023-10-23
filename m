Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE0B7D3D49
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjJWRTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjJWRTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:19:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810BD10A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:19:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA74C433C7;
        Mon, 23 Oct 2023 17:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698081570;
        bh=rtGC9q+xTKcoJi0PVoRTofhcAysSBuznbE/0Yvfa5p8=;
        h=From:Subject:Date:To:From;
        b=TJS+Hd/WrKC9a7VIEKKRkahLxhb+2ojZurwU0Vh5q+rUrGPh7gGmuqnxKWyBrzEN+
         fCbe9KZLur5dMfOXqqvKAgyVuEVxv79CxRBIfMJwbD1OBhLC2bpgZ3P4P8BaIafptb
         VuYYZu+wWUcXbyBxu5Tx/aqj8aFbKsX/cjqdMnINk+J86wL5j9AnCtaJAvo0Uuk/dx
         n9Z7PA3WdISBiy2YijJO0HTrnfd7sREgKP6GSsrRMrrlG8fpVw77mCpenL2t6qTP6H
         cNSOTAhzUsrZxm95ocbHaHC+HR93w7GuqIuwKDYXBvKxbByyLJWS04DdzLh0bIlCip
         0dnwA2Bhyy3Mw==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] regmap: kunit: Add test for cache sync interaction
 with range selectors
Date:   Mon, 23 Oct 2023 18:19:10 +0100
Message-Id: <20231023-regmap-test-window-cache-v1-0-d8a71f441968@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6rNmUC/x2MMQqAMAwAvyKZDWgLin5FHGIb2wxWacUK4t8tD
 jfccPdA4iicYKweiHxJkj0UaesKjKfgGMUWB9Uo3RYwstvowJPTiVmC3TMaMp7RaFKLtg313QA
 lPyKvcv/raX7fD9gy6C9qAAAA
To:     Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rtGC9q+xTKcoJi0PVoRTofhcAysSBuznbE/0Yvfa5p8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlNqsep4g4McOGqE9/2GK0kbavNE+0vyYNWJyxbinB
 gSEGaPqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTarHgAKCRAk1otyXVSH0DSGB/
 0SdwUvZAvicPsBpAk3uQ4CienxiKgeonw+ooS3SMlIgUmoffmXXjeY+N7rk9kJxrW6Dh/DAHsCCupS
 pyE8Gyffu5k2QO/wT/cyx44qmKchLSmvHTG3GMjdOl+UkiTZKiXEe8dq3llGHkyWGRZrW+03PHm1g1
 ro5VvOmJYP/laIakQ25AU2yRZX2iFJeYJCTl9ErvKMqsJlL/PBmK8Hpds3JY52rIy8fUYZfzAJdAAG
 B0mY/pu0SuPXl/HjkNsaQ2Fx/qdXIyyO6RGRN8U4PaV3DO0PcjECxfaWKSof/Lg6HXu24EYDJfMNlN
 756xAL/gZfRRrHLYyx/yiZsI/5+sPV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for a bug reported by Hector Martin, plus a fix for a thinko
in the tests that I spotted while adding that test case.  I've not
included a fix since I believe Hector either has or is working on
something and I don't want to invalidate his work.

Hector also reports that there is a similar interaction around cache
initialisation from device defaults.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      regmap: kunit: Fix marking of the range window as volatile
      regmap: kunit: Add test for cache sync interaction with ranges

 drivers/base/regmap/regmap-kunit.c | 68 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20231023-regmap-test-window-cache-c3a2b3d0a769

Best regards,
-- 
Mark Brown <broonie@kernel.org>

