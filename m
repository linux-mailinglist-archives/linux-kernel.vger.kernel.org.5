Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D98F77D2B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbjHOS6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbjHOS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:58:02 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280801FD6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=++dv1YcZtTUgwkcqesMhrWgRGVjCmLDErvcE127Lp4k=; b=MN1VQgdNk+1D8fu7wLlBepRrRB
        aCCVMsFhnQDaC+5HulasVarDOXq1JfDOKuKpdFvSxaieGhfGSLR8K7Dl0Cl4IOhuSvMWTA5K9c2kS
        meaXoweiHuatFmcmzMHvVAskQz00BoBt7zXwQcQyaT3YcuQOrtrIZh2qaB+7ju6BwgQBMD7yMDJ9Y
        kVIK0xCAslGPixRhDZNX6fChAX5uxj7GJWYzRYLgLUmFkH88FQUPwvIGLnz1TbHwiABezkfSZiC4e
        b/aOMJonS+x4zP+o50CiF+04939vh77T/li2buDWI97L5txZ5pIIb00SZgFr95ZZp9HtTDQ/9dsVp
        b1hpRKXw==;
Received: from [191.193.179.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qVzEh-001Ca3-4Q; Tue, 15 Aug 2023 20:57:47 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 4/6] amd/display: indicate support for atomic async page-flips on DC
Date:   Tue, 15 Aug 2023 15:57:08 -0300
Message-ID: <20230815185710.159779-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815185710.159779-1-andrealmeid@igalia.com>
References: <20230815185710.159779-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Ser <contact@emersion.fr>

amdgpu_dm_commit_planes() already sets the flip_immediate flag for
async page-flips. This flag is used to set the UNP_FLIP_CONTROL
register. Thus, no additional change is required to handle async
page-flips with the atomic uAPI.

Signed-off-by: Simon Ser <contact@emersion.fr>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v5: no changes
v4: no changes
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4b433793f5a0..4d3d6009838c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3924,7 +3924,6 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 		adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 	/* indicates support for immediate flip */
 	adev_to_drm(adev)->mode_config.async_page_flip = true;
-	adev_to_drm(adev)->mode_config.atomic_async_page_flip_not_supported = true;
 
 	state = kzalloc(sizeof(*state), GFP_KERNEL);
 	if (!state)
-- 
2.41.0

