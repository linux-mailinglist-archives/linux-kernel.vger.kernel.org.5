Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF4806B87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377611AbjLFKMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377499AbjLFKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:12:48 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E301BD;
        Wed,  6 Dec 2023 02:12:54 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E9F5BE45;
        Wed,  6 Dec 2023 11:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701857530;
        bh=56iwrdzPfpuRvwpwNolnnsPRDsW2/EL6hpyFjmdZXkQ=;
        h=From:Subject:Date:To:Cc:From;
        b=j8kh4Alvm9JmS/D0V83aBUOocR82+hCx8q6Tk2O1BXt76lTrYMhMmXnY9jiThxy+1
         dNJKLHn2QJUc7DEHYwEiTxQP6aWIu2X5JDeSSMPb+FXAdz9s+j9ne9Ww7V8Os02jsX
         1iwMN9KjJx1ond3rcXcq49x7YmoXGjclvD0DXyNc=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 0/4] media: rkisp1: Fix IRQ related issues
Date:   Wed, 06 Dec 2023 12:12:27 +0200
Message-Id: <20231206-rkisp-irq-fix-v2-0-6ba4185eeb1f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAxJcGUC/3WMQQ6CMBAAv0L27Jq2tGI8+Q/DocAiGyOFrWk0p
 H+3cvc4k8xsEEmYIlyqDYQSRw5zAXOooJ/8fCfkoTAYZWptlEN5cFyQZcWR30ja1P7sT01tRij
 NIlT0/ru1hSeOryCffZ/0z/47JY0KR6us6xvbeeuuPJCPYe6Cl+HYhye0OecvJ3+tFrEAAAA=
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Elder <paul.elder@ideasonboard.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
        aford173@gmail.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=56iwrdzPfpuRvwpwNolnnsPRDsW2/EL6hpyFjmdZXkQ=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlcEkd50efhFMgtYs/cdsAGwtbB9/Bnm+X2UMPT
 6ssfC08ZHeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZXBJHQAKCRD6PaqMvJYe
 9ct/D/9hZ8NC/pD+4rkFDbATDwbYkUWUNIDgVBbTdkeE+2A70dIVHpNjh8ux0JG9OvFpFd/egcW
 XwYDOGgPd1kuM4brOnoDpszVQchEtzCuRaVGdKek2EpQ7FPPFq/+2ZgS604zDMRlmo3BZptoScz
 1Ofd6OQHl046/Q/b4OyEol17WHBCUvWgvxzFRwoyq+2QDhiaqwxl7PkZ8CVumOrEOJNmKPqGUfQ
 puvmLb1860SpAWVAdRSYNCbCo08FiVuFxHIaGC0TgilYlK5nxiEXuhd4/J2cFRVJbSjoudO4Wpb
 xtt2m724gp4voXkf6NxArHtY0CHDjfBXnrkFPhx4BN/DhpVN2unsLcO5ohkSMoVLRtFZ0sKctvc
 o6b/ncbQ/7jJHvwFbartlbv3AQK/RpnYl/hWxgund6PC8Wk8CJDoEa9CosQ5/q6S/6puuTmijzr
 GTOXd/rq8os1iY0oq1O/9/M7wR2YYHUmejXxDeFXAb95vhcJz3+OPPsMRA1RIQIwRAQWlyjf39v
 Zbr6QmF/BWy5cdoWMfQayQ9oe/MR7hqOBIvgT7VqS9eS+rS8w2MQ2arD5WP2bcachO715jnCQlJ
 q60c+rC0m1FXdBw2lrXwvv0NlG9c8BTAr1ssiyIf6dBz2894vtZUjVeMvDGX/CXAQ3NxvIlGyTD
 fT5oHodtTZvPU2g==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fix a few IRQ related issues I noticed when testing i.MX8MP. These
are based on Paul's recently sent "[PATCH v4 00/11] media: rkisp1: Add
support for i.MX8MP" series, but could also be rebased on top of
mainline if needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v2:
- New patch: "media: rkisp1: Drop IRQF_SHARED"
- Update "media: rkisp1: Fix IRQ handler return values" according to
  Laurent's comment.
- Drop "media: rkisp1: Fix IRQ handling due to shared interrupts"
- Update description for "media: rkisp1: Fix IRQ disable race issue"
- Link to v1: https://lore.kernel.org/r/20231205-rkisp-irq-fix-v1-0-f4045c74ba45@ideasonboard.com

---
Tomi Valkeinen (4):
      media: rkisp1: Drop IRQF_SHARED
      media: rkisp1: Fix IRQ handler return values
      media: rkisp1: Store IRQ lines
      media: rkisp1: Fix IRQ disable race issue

 .../media/platform/rockchip/rkisp1/rkisp1-common.h | 11 ++++++-
 .../media/platform/rockchip/rkisp1/rkisp1-csi.c    | 14 +++++++-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 37 ++++++++++++++++------
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    | 20 ++++++++++--
 4 files changed, 67 insertions(+), 15 deletions(-)
---
base-commit: dd19f89b915c203d49e3b23ca02446d4fb05d955
change-id: 20231205-rkisp-irq-fix-e123a8a6732f

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

