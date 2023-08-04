Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D276FF21
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjHDK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjHDK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:59:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AE01724
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:57:56 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC7642E4;
        Fri,  4 Aug 2023 12:56:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691146609;
        bh=2xH8BFLdtXeXvTOfhye94ba30yDscr1R4VyzuaQczrU=;
        h=From:Subject:Date:To:Cc:From;
        b=wDMyYg3US9vsw2CQk/7cRHCr5amz8SOUx1LcT10DGKx2bXLqc1OinUNMU+hPioxbx
         BmY26m6B78JsXS/8Ua4vRyL9lI8fJWU9DwOYGRNwdGb6AUE2eHHVxjRFTXml4fubwo
         UU4fA2j9inEfnyDlFzDlC0UEdvaovTuentJEUdWY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] drm: Fix errors about uninitialized variables
Date:   Fri, 04 Aug 2023 13:57:38 +0300
Message-Id: <20230804-uninit-fixes-v1-0-a60772c04db5@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLZzGQC/x3LTQqAIBBA4avIrBvwJ8K6SrQQHWs2FloRhHdPW
 n483guFMlOBSbyQ6ebCe2pQnQC/ubQScmgGLbWRVvZ4JU58YuSHCipr46jDIJ030JYj0x/aMS+
 1fmoO9KNeAAAA
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=605;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=2xH8BFLdtXeXvTOfhye94ba30yDscr1R4VyzuaQczrU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkzNmwUYgCBLt9WfYfPQrKEScAsg6zd2GwWS6Ms
 sxUS/QtfzmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMzZsAAKCRD6PaqMvJYe
 9cL0D/9cQZr9FCZmkYpHu7h2D+yQnbuUK6gPqfbDMVhxF2IVEisTZsiObJ/fzA82YnNlZiZ4grl
 YQBdEdZxWZtYEDNAeBumtM/M3ADUCwEUT2VqgCdSe4PUJ/H2M/mBPiz4FhXWGf/bdHYZiW3eGni
 rhKiPZvshAOdFWawbxjJ6o6NMS1CY9xAuyTvMrWUCoBKp+n2huCIwtRJpTajQ7G0netPHnN7jAI
 wJbiApXemetlRHWos2V75Aahx7hfCLTp/tJprDCZwuGYQkNiXt1VBh4q91id31vm8+Mp2KA+Q7A
 zDIq3kX29vVkX3JNPWbVdvmL4OqQ++YK3I2P2OUMIjXD976PMgRecdS3VTxL/xfjrcW0BP1/4QH
 wHE6c8QSL6zyy6rf6ZyDAxoBVPTKQ5rFh4FF5U7MO/UH0Oy92PsgtXeR9fV26BlYcaZcDd+OP95
 vl0teMNDkxQQj2SVJ4RN1iit70klpEHe80xJ10g4O8LYD/wogRBOfGhr0SjwNQ+1bxG9KpSB9iO
 xFAtj/uCyDOTst4EGTR2txOD7A2wkblvw6rcD9k+5f9RQthX6B/FTqslv6HlSSj8S5Jllko4b88
 T7aTde3bgInnsJ+K/ENc4Sg25trJ7hRq25F9k8u7uxkWAVsRZmc4/dMGbeCG01lvRxSoddvy9uA
 R7fTBXxSa+dxdTw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two cases where smatch reports a use of an uninitialized variable.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (2):
      drm/drm_file: fix use of uninitialized variable
      drm/framebuffer: Fix use of uninitialized variable

 drivers/gpu/drm/drm_file.c        | 2 +-
 drivers/gpu/drm/drm_framebuffer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: b0e9267d4ccce9be9217337f4bc364ca24cf7f73
change-id: 20230804-uninit-fixes-188f92d60ac3

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

