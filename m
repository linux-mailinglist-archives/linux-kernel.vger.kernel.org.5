Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882268006BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377995AbjLAJXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377992AbjLAJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:23:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37A2194;
        Fri,  1 Dec 2023 01:23:36 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAuB+NWb1+h9nrirqejk/RLzcirj6WRcoSRAbARMZUA=;
        b=tGDR9eZqdwVBv7/g90Ct9HkZutigEwF7ngGXBC+BJCXQQoFHN4SZeJEcPAk1kEfZK6uhUm
        jev2BdKZEWpF96N55lxD2jYDQO8NnCDrFcmrDHV9VSQg2CvYF1KJoXjQS3Ih7oTZTIgTQb
        p+1WMxrsmgMvM6U3hx8fQKu01nBI5+XqdYV1RBPRjOQ6OHIULZ9D9NIGTKEcGo4pidOeT6
        Rcq7KgFbkeumyAQzK+S8hG2IvvAI3FV21O9L9iJSbHl1tyzcnjjYNy9qJF9yxC3sQzbjGP
        IoepgDGclqu+dwbYuaRJr0BcAsz35D9078zP+x+vnZeL/Nr4u710h/8ErzjxSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAuB+NWb1+h9nrirqejk/RLzcirj6WRcoSRAbARMZUA=;
        b=A9ARbpvm7QOTKyyBB7JLD1eW7y/nyFyioCc01jf3h7pElP7NZmdrLwXNwXLV59pcm5uQGw
        X5zAVFsE//77j/Cw==
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcao@linutronix.de>, stable@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: starfive: jh7100: ignore disabled device tree nodes
Date:   Fri,  1 Dec 2023 10:23:29 +0100
Message-Id: <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
In-Reply-To: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
References: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver always registers pin configurations in device tree. This can
cause some inconvenience to users, as pin configurations in the base
device tree cannot be disabled in the device tree overlay, even when the
relevant devices are not used.

Ignore disabled pin configuration nodes in device tree.

Fixes: ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive So=
Cs")
Cc: stable@vger.kernel.org
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/p=
inctrl/starfive/pinctrl-starfive-jh7100.c
index 530fe340a9a1..561fd0c6b9b0 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
@@ -492,7 +492,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *=
pctldev,
=20
 	nmaps =3D 0;
 	ngroups =3D 0;
-	for_each_child_of_node(np, child) {
+	for_each_available_child_of_node(np, child) {
 		int npinmux =3D of_property_count_u32_elems(child, "pinmux");
 		int npins   =3D of_property_count_u32_elems(child, "pins");
=20
@@ -527,7 +527,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *=
pctldev,
 	nmaps =3D 0;
 	ngroups =3D 0;
 	mutex_lock(&sfp->mutex);
-	for_each_child_of_node(np, child) {
+	for_each_available_child_of_node(np, child) {
 		int npins;
 		int i;
=20
--=20
2.39.2

