Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFA677816A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbjHJTXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjHJTXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:23:44 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D3390
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0So8O3/MNtUi08+iM0GTq8USjRthw2+S2AnIdqjvHuo=; b=GdTQ/igkQRc/hhcxe1Y/3weWmF
        +q/7MKQxvDn81dRdeKQ3qt5mTcOcvoCb7JMYmIAC6iEeF7oj4mkQ0yFnlyvmfnqF87SzmxVlPpZtS
        iCmLKzRcmTnYAjiJuOdJSjeTw6PQ8PRbwjEMnCxWtCUJ23sOCg8Y91nFcJ/PIuxcCAc0M5DehPYJX
        fF0Wsr6+KH7Gy2Wu2DTa/eNkkWhZ9qzfso7SPNTNx/WYoLoTT2yfLJA65bTQa2Q79tETqyH3vRHg5
        peXVRGPXYyuYy/FRoilEZ5vmLF6rh46uUfkCcq4G0A0lSz5Hv8m0k3fIC1PjdjD5csgo5GxH+vQXU
        no4McpTA==;
Received: from [191.193.179.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qUBG1-00Gp5H-La; Thu, 10 Aug 2023 21:23:42 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RESEND v3 2/5] drm/amdgpu: Allocate coredump memory in a nonblocking way
Date:   Thu, 10 Aug 2023 16:23:27 -0300
Message-ID: <20230810192330.198326-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810192330.198326-1-andrealmeid@igalia.com>
References: <20230810192330.198326-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a GPU reset, a normal memory reclaim could block to reclaim
memory. Giving that coredump is a best effort mechanism, it shouldn't
disturb the reset path. Change its memory allocation flag to a
nonblocking one.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index aa171db68639..bf4781551f88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4847,7 +4847,7 @@ static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 
 	ktime_get_ts64(&adev->reset_time);
-	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
+	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_NOWAIT,
 		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
 }
 #endif
-- 
2.41.0

