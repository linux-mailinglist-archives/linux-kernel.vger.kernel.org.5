Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7B7B44AC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjI3XoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjI3XoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:44:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3039FAC;
        Sat, 30 Sep 2023 16:44:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6652C433C8;
        Sat, 30 Sep 2023 23:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117439;
        bh=qKVeOaKlCp8jR76QF/2l6qFy9dPguCw0JNXqbvVBfAQ=;
        h=From:Subject:Date:To:Cc:From;
        b=OLZJGsL3dlbWVKDRd8XctYf3lBHYLs+73DoEGjE19kI6bftOtJv1MZGugHu0snnoa
         Cmv0n2vTNCw57J2I/Ug+xVUh1VV0AJ6Y2llRMbh65TGFDl4DHJmLUk5BMyRbObnNWn
         +JAZlI3aKFVCL2YPC+fCPe1P2kj/d+omlMnyJfb3KAfKxMF7hGlVHwldOOGTfS1Me9
         Tsuyh8aRZaDAPGqhd5Mjq7CNpP739KtOjQT1iORQlMiqTy80rEjEflpZrc0EziVu5w
         ITskncuOSmtrcSJAroaUeqh7WjToVqiGOLaX2qe+8M+qdLJhe9KDl3OCb9F+A86qZy
         8pCNaXEmCUT4w==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] Input: Small regmap improvements
Date:   Sun, 01 Oct 2023 01:43:37 +0200
Message-Id: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmyGGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyNL3cy8gtIS3dzEgpxUXVPTtCQjixRLU6PURCWgjoKi1LTMCrBp0bG
 1tQBG1GGmXQAAAA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=713; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qKVeOaKlCp8jR76QF/2l6qFy9dPguCw0JNXqbvVBfAQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLK6QzivnFswvR9zBgeyj5KBnMZ7LGa7Hiy42
 60Lh/8YScmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRiyugAKCRAk1otyXVSH
 0J7aB/9XdAyoHhS18JD650kAbyXPcAbkk5EALNNj+VgpQzQJGCOWtgxHgG4ArpaiZWKnZOoRyL8
 OSLcek+zMiGfZrsD7uMHiNirmtLM9AZLE4CQrTo2J5dp5DEhM9gi5UUrDaSL3bem/EyxFeuLAvC
 NT04UlvRwWCv869inTb6tqct8nyRPFIjeJubj4J2dYxIrjSv/9IjxQIys79+K/XwLXwWh+DFG3T
 PtOM6Jbve3VFcuoSA7+jBlHqEy/FIvbFrAUmM+cTP2r5yczo+BY6DIK8DHqflykqAn3XWG2+Pox
 df0ek1MqzFlClE6kqLanUHLOzMeZ1dDQiISl/+2eYXovpayo
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

This series has a few small improvements to the regmap usage in some of
the input drivers, there's nothing really important here but it's all
nice to have.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      Input: cap11xx - Cache hardware ID registers
      Input: cap11xx - Convert to use maple tree register cache
      Input: qt1050 - Convert to use maple tree register cache

 drivers/input/keyboard/cap11xx.c | 5 +----
 drivers/input/keyboard/qt1050.c  | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-input-maple-55fb28d952ea

Best regards,
-- 
Mark Brown <broonie@kernel.org>

