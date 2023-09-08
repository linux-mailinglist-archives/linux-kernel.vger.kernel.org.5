Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F0798F08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbjIHT27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIHT26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:28:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E818E;
        Fri,  8 Sep 2023 12:28:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87350C433CA;
        Fri,  8 Sep 2023 19:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201333;
        bh=2ZM7QBgu2SZKZzrFPk3w/MrH7pYEn1i7DVyEwj3td6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGMWw9hXc1fMZJKR8lTvaqd8+bp7ZgZPsXbH2dOBc7v4d+68rITYzG11eDYgwC/H3
         nBVV752cPICzYuUTMof3loS2XN5xw8yOPp+iGrr7SxN8diUlorujf6O3IJE6op9L52
         0dYF+y7tflDtpuoOpvYpdtN41QhM2NFMpsqgtPExZOc3wTkhIbHSEpMu3/F9M0DayE
         lmOhTDUKzry4FUlRrthahjI3btagJ2eli91+tXy1N664r2l9OeMF5/dUsk/3kGjrjm
         Wp8HBYfUdVCbnJyuKFUVXWWX0zONcpV62iqzU1qQ4nhjoBLvJHxkj9cfitXuIXbsjz
         IyALuViaERX+Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 02/36] drm/edid: Add quirk for OSVR HDK 2.0
Date:   Fri,  8 Sep 2023 15:28:13 -0400
Message-Id: <20230908192848.3462476-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

[ Upstream commit 98d4cb705bc00afd4a9a71cc1e84f7111682639a ]

The OSVR virtual reality headset HDK 2.0 uses a different EDID
vendor and device identifier than the HDK 1.1 - 1.4 headsets.
Add the HDK 2.0 vendor and device identifier to the quirks table so
that window managers do not try to display the desktop screen on the
headset display.

Closes: https://gitlab.freedesktop.org/drm/misc/-/issues/30
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230621061903.3422648-1-rcampbell@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 1f470968ed14b..9271e47d66572 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -230,6 +230,7 @@ static const struct edid_quirk {
 
 	/* OSVR HDK and HDK2 VR Headsets */
 	EDID_QUIRK('S', 'V', 'R', 0x1019, EDID_QUIRK_NON_DESKTOP),
+	EDID_QUIRK('A', 'U', 'O', 0x1111, EDID_QUIRK_NON_DESKTOP),
 };
 
 /*
-- 
2.40.1

