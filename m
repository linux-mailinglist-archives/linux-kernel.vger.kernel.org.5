Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF04E7B36AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjI2PYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjI2PYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:24:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8445DD;
        Fri, 29 Sep 2023 08:23:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951E0C433C9;
        Fri, 29 Sep 2023 15:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696001039;
        bh=7MUnS5rrD0zWrSC89C22S+EJFgSBQ12YuL/KwhyLmmg=;
        h=From:Subject:Date:To:Cc:From;
        b=efDgvw/6IVLIpaNQ5IedOwDOplM4fB92oegV9FbV+ynNr8SNxHWiQbmEiQFFHKOnb
         BoW1x59hV8tTt0gVGIwC/tE6+64fgRSAXUpI/Jf0UQpK8MfC20QhF7JxdBht9DO04c
         a9UwOEU8wXDwKMmpNV8d+WXNXsvuaBZlCj/Ski73eTb5UrHzM4f9PZ40sgadZSxgNr
         VwsYDwf4JuULJq4lx1ZbSWtieoHdZx/5wSI//RmvuiUxUlbVQ53PNsShzkkD4X01/e
         2Dos7sVjPJEsWK/4U461y/m2Kxm6oK6uBP+Gt6FBeLPzknW7io9M3rP0VuiZ6D9o3k
         yKBFdKY2b0uew==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] leds: Convert to use maple tree register cache
Date:   Fri, 29 Sep 2023 17:23:34 +0200
Message-Id: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPbrFmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyNL3ZzUlGLd3MSCnFRdcxMzoGBSinFikpkSUENBUWpaZgXYsOjY2lo
 AYTQ1yFwAAAA=
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7MUnS5rrD0zWrSC89C22S+EJFgSBQ12YuL/KwhyLmmg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFuwJ+F0ZMV1CNFn+jQhAGs375d23RCILs8xRQ
 BcJArN/Y/OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbsCQAKCRAk1otyXVSH
 0FMrB/9wqL5tz69qs5QCfv7zfdP/lP0vuIK/ZlP+9ANDMdnvuG5+7WtSC7QUykM9/1h+2uItL/p
 hFYyZ7sa2dK3F4nrIWg7cPjBd4bv6ZlphPXhSAdF/3KM1e4M7dCMviMW42gFcnTTDPO3h3ZIEZA
 n7sE7myKl00+UaaGUoY3D8N/uji1Hay6m6l2KkmfTsFCWjCh3MnPShowDquMoVozodxS79HIjSe
 LZ14Ym1kMnV3eJj4x4r8v6bYY88QI/xUEMVN4gq0ZoEz+uy+T9gOuzTLSYK84ok8cn6jHTrssic
 qMWGiwGbixq0QplLWMYyDgEe21Jd4erwtFFMQz1HyeGdyqaA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is a more modern replacement for the
rbtree cache, the underlying data structure is more modern and the
surrounding cache implementation makes a number of choices which are
more suited to modern systems than those made by rbtree.  This series
updates the LED drivers that use the rbtree cache to use the maple tree
cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (4):
      leds: lm3601x: Convert to use maple tree register cache
      leds: aw200xx: Convert to use maple tree register cache
      leds: lm392x: Convert to use maple tree register cache
      leds: lp3952: Convert to use maple tree register cache

 drivers/leds/flash/leds-lm3601x.c | 2 +-
 drivers/leds/leds-aw200xx.c       | 2 +-
 drivers/leds/leds-lm3692x.c       | 2 +-
 drivers/leds/leds-lp3952.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-leds-maple-746230bd3ab6

Best regards,
-- 
Mark Brown <broonie@kernel.org>

