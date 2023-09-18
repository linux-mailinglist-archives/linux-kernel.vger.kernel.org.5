Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C88B7A531F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjIRTav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIRTau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:30:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2710D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WjAGfeimratsUjROsssvUEhysKjXohiEHjdvItodlXc=; b=UqnMbUb6aiH8ne5wsoeSYpw+iI
        7jD6XuSual3ZoBM0Hxbeq9Iw7qGSKuNr6XLbj5LqIe2PM0HX/77XJO9GdR/ZvYN2eEhFXBkZzXmkH
        7jn7y64xp6y8d5rJQDdDptd9I7YcI3ydmjWRol+xe2g/TKrO4PVn4u6ITdckqJCRJDIOE9MQ2JDgZ
        zrun5Sg5lWgMA02zwXvwlDNL+lM066/7Rb2jFTbMHIU+anlWdOVetNr14gQ4SCeDLRrf0FpBvADbd
        8ECqEMcFbDfXhOG17B4LJ5PeDo7G6Q9tJMNiWQj3vU29KbNH2v3PjUF2n+QrVi29YQeKliAcagYEm
        Dl2AVrPQ==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiJxE-00GCGq-1N;
        Mon, 18 Sep 2023 19:30:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Lee Jones <lee@kernel.org>
Subject: [PATCH] mfd: cs42l43: add REGMAP_IRQ requirement
Date:   Mon, 18 Sep 2023 12:30:42 -0700
Message-ID: <20230918193042.31524-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cs42l43 core uses devm_regmap_add_irq_chip(), so add REGMAP_IRQ
to what the core driver selects in order to provide this API.
This fixes a build error:

aarch64-linux-ld: drivers/mfd/cs42l43.o: in function `cs42l43_boot_work':
cs42l43.c:(.text+0x19d4): undefined reference to `devm_regmap_add_irq_chip'

Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: James Schulman <james.schulman@cirrus.com>
Cc: David Rhodes <david.rhodes@cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org
Cc: patches@opensource.cirrus.com
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -241,6 +241,7 @@ config MFD_CS42L43
 	tristate
 	select MFD_CORE
 	select REGMAP
+	select REGMAP_IRQ
 
 config MFD_CS42L43_I2C
 	tristate "Cirrus Logic CS42L43 (I2C)"
