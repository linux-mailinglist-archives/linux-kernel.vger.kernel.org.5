Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16D7F4A26
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjKVPV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjKVPV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:21:56 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FAFF9;
        Wed, 22 Nov 2023 07:21:53 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C144276;
        Wed, 22 Nov 2023 16:21:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700666480;
        bh=JHQBIVvAtxouujp8N06sHZVSSTpxaJ5CroHpbgMgE80=;
        h=From:Subject:Date:To:Cc:From;
        b=QYlGi4rR/O0h+uI6TPBbW4jXdQv4XVNOfV/WObPMWv766uzeZtcaJwJBBlkxNbnuS
         2g4JNEaSnBdEQWHC8LNn6394Ak+gLnrNDUr1KBQvAQzaTtGE4YSRi/5cwM+5c1Y4OU
         voamnmlDebPOif7cniJwLAvjaW/QNf6PjBwl1+k0=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/2] media: imx-mipi-csis: csis clock fixes
Date:   Wed, 22 Nov 2023 17:21:33 +0200
Message-Id: <20231122-imx-csis-v2-0-e44b8dc4cb66@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0cXmUC/23MQQ6CMBCF4auQWVvTGSJYV9zDsKB0lFlATccQD
 Ondraxd/i8v3w7KSVjhVu2QeBWVuJSgUwXjNCxPNhJKA1mqEYmMzJsZVdS0LpDFEC7oHZT7K/F
 DtoO696Un0XdMn0Ne8bf+QVY01tgG27q5sneu6STwoHHxcUjhPMYZ+pzzF62+Pp2nAAAA
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=754;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=JHQBIVvAtxouujp8N06sHZVSSTpxaJ5CroHpbgMgE80=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlXhyKSHEnOeVxC8w9rkJHWfhlX1Z9pE6Q03rVn
 lxBW6uioIWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZV4cigAKCRD6PaqMvJYe
 9eI1D/48oW/RmCr9/xtb5mxj2EhZiv65oCIgRh/JrhyTNY+3mZImlvmC+Eg+U6K/h78sJq1/89c
 VqziH6IwEMVZ9V5oT3w5AECzw28kedZZZozptf0uhU4RGoA+gW148SOAWN4PTnofuHZvZOzh/3b
 /RrD7gl9Hx8CD0s5nxQZJtqXalFknqYEa0uqYmwSBMjtKQkQCyuhnfU9tOdFWCbkMmkspA/Fb17
 qfZy3BEEFke9K4EGKgV/DL0PEY+0VqUhcuT02oTCgJPmGLzv/JQDSQulbjO57f0ZL6SscEdgLmm
 YxQL5+JTsTQgwabF9U/9VyewL/D829SItBS6tOAMW5fuTuzn4rbjLGkfQkotIxWfzUqmtF7xXFv
 2jEFVdUBH2wCMddk/8QDDQgnbrxWkuOBOXqaKFVx5BkWfCAF2bThnzwDmnNjx6248/f1jSlEgxC
 x6CJzwGjGGQa4Nwv128qQKtkn5Nb6riBxgNMiu0prrYn0FxGV13H4GIzYFHIPW4nBui/v0oNWOM
 eGCP9tqmrvnJRVcxsxmqTtTxVXG08Hx1xcwHZ8zKkdtV3sZX8nIqhWfsYrarncKfwAgb8+j9P1y
 8LjtP+VMtJU8zA396LvV5WLj1bmos+SMOigU83Y4rSs1fQSpVdI7ExU5jf5yNYdGYVvNGDgCWVM
 7541bgg2n4bcxFA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes to the csis driver: One to fix remove() another to only enable
the clocks when needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- Add Fixes and Rb tags
- Link to v1: https://lore.kernel.org/r/20231122-imx-csis-v1-0-0617368eb996@ideasonboard.com

---
Tomi Valkeinen (2):
      media: imx-mipi-csis: Fix clock handling in remove()
      media: imx-mipi-csis: Drop extra clock enable at probe()

 drivers/media/platform/nxp/imx-mipi-csis.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)
---
base-commit: 1865913dd590ca6d5e3207b15099a1210dd62f29
change-id: 20231122-imx-csis-79d201dd51b9

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

