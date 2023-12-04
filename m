Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AB804075
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjLDU4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346439AbjLDUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:40:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BB21BC8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:37:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEF5C433C7;
        Mon,  4 Dec 2023 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722238;
        bh=Psb9RTZFuE/U1pj2kV4Ja+LRykSEd4btKLMZAtk5CkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5pIZjRkQ9rib2vSnlMKC6E+BzFIxi1+bXKGcW5fkmeHgmW9n9hoWrS26cY3l/C9K
         KTNeOszjSoWyk84cRbKV2Z7nlYHY5Aqzu7Dsbj5vMwhU7ACy9qdpn7f6MYN7q8BhNn
         64xtXpjF5tkIzaeTCAihpSJ1gg4yfwVlNJZEmsiAnfJQodkmaf1xo3U8HOEC9jD16o
         yCXXqWe+m+aY6Qn1zxELA8tbG3jwHSECwsTRkKHwffZ3lFRrMC34decI05ciY7Hv7G
         3nUGG5btWegQbx0gfqoA6PlIgZWIa6dxEjcONT6uxOxptKLA4zB8Q5i0SZVauMYSce
         /CK3UdSm7gAzg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Yao <yaolu@kylinos.cn>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, srinivasan.shanmugam@amd.com,
        shashank.sharma@amd.com, Hawking.Zhang@amd.com, le.ma@amd.com,
        andrealmeid@igalia.com, qu.huang@linux.dev, tom.stdenis@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 6/7] drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes kernel null pointer
Date:   Mon,  4 Dec 2023 15:36:49 -0500
Message-ID: <20231204203656.2094777-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203656.2094777-1-sashal@kernel.org>
References: <20231204203656.2094777-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.202
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Yao <yaolu@kylinos.cn>

[ Upstream commit 2161e09cd05a50d80736fe397145340d2e8f6c05 ]

For 'AMDGPU_FAMILY_SI' family cards, in 'si_common_early_init' func, init
'didt_rreg' and 'didt_wreg' to 'NULL'. But in func
'amdgpu_debugfs_regs_didt_read/write', using 'RREG32_DIDT' 'WREG32_DIDT'
lacks of relevant judgment. And other 'amdgpu_ip_block_version' that use
these two definitions won't be added for 'AMDGPU_FAMILY_SI'.

So, add null pointer judgment before calling.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 48df32dd352ed..3e573077368b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -459,6 +459,9 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->didt_rreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -518,6 +521,9 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
+	if (!adev->didt_wreg)
+		return -EOPNOTSUPP;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.42.0

