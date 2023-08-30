Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC5B78DFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbjH3TIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbjH3OJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:09:19 -0400
X-Greylist: delayed 411 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 07:09:11 PDT
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B418122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:09:11 -0700 (PDT)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
        by forward205b.mail.yandex.net (Yandex) with ESMTP id 19E0E69B3D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:02:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:332f:0:640:4ab4:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id E46DD60058;
        Wed, 30 Aug 2023 17:02:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id G2SS5ILDSOs0-K05UNMia;
        Wed, 30 Aug 2023 17:02:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail; t=1693404137;
        bh=4UuCYf2z5ERazgVTAra1HLGpzXEpox1UP/x9Vsz8zxY=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=qEiA2dnxfjTOmXj1MmyZwpY7734vhltXUdpITsPx4rEhCe7hqAVGl1NEvXOE14Y7D
         6GEi4E0oTDexaCQv7HAB5GsalD798LJnUL4sq7BWgkrzpFWO0+feO1XvoOTjHXbJAY
         mq3pVuXQ3yesVGiumsFbtoqtKoisQqnqj3qSYDFQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@itb.spb.ru
From:   Dembskiy Igor <dii@itb.spb.ru>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Dembskiy Igor <dii@itb.spb.ru>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hersen wu <hersenxs.wu@amd.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] drm/amd/display: remove useless check in should_enable_fbc()
Date:   Wed, 30 Aug 2023 17:01:03 +0300
Message-Id: <20230830140103.311752-1-dii@itb.spb.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not make sense to compare a pointer to array element with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 65d38262b3e8 ("drm/amd/display: fbc state could not reach while enable fbc")
Signed-off-by: Dembskiy Igor <dii@itb.spb.ru>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 6966420dfbac..e87cf54ec658 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1992,9 +1992,6 @@ static bool should_enable_fbc(struct dc *dc,
 
 			pipe_ctx = &res_ctx->pipe_ctx[i];
 
-			if (!pipe_ctx)
-				continue;
-
 			/* fbc not applicable on underlay pipe */
 			if (pipe_ctx->pipe_idx != underlay_idx) {
 				*pipe_idx = i;
-- 
2.34.1

