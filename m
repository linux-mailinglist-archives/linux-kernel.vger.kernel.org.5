Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C0C77D3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbjHOTwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbjHOTvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:51:37 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C019A4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HjXY/VI272vm3UFbdLkzpFUaOQVcjdJ2BDDwBgalhkg=; b=mkzruAgr6zPyMZQl9P6QA1+/Y0
        t79t696J9i8ZI4VTRAyqJEfOB2LuFazfgnV1mfQmxHiSYYqVitqTfMZCpzcBwdRhnOgHpBtDcqv+w
        q74JFECyg2zvLefcaqY5eTTnP+phkYhQk1M31S4fwtQJQnmqNag991jXfTnXyNM2pHuB8ahPiL0Rb
        DTJ7/eePcQpVNh2qRVYuKG3wGWjv0CEqKVx8CxG8+2LpXd/cGuyWl/DUkPk5Swi8rRYyCA4m8eMaH
        k2NP8W3aa1ACFiPXn81IfE1A65c4iM11d+jHCXeZZXZauZzA7T45eYOmCJrojKETYg4MzsJsbAUlw
        ntws1IRQ==;
Received: from [191.193.179.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qW04j-001DUX-RU; Tue, 15 Aug 2023 21:51:34 +0200
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
Subject: [PATCH v4 4/4] drm/amdgpu: Create version number for coredumps
Date:   Tue, 15 Aug 2023 16:51:00 -0300
Message-ID: <20230815195100.294458-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815195100.294458-1-andrealmeid@igalia.com>
References: <20230815195100.294458-1-andrealmeid@igalia.com>
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

Even if there's nothing currently parsing amdgpu's coredump files, if
we eventually have such tools they will be glad to find a version field
to properly read the file.

Create a version number to be displayed on top of coredump file, to be
incremented when the file format or content get changed.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 46c8d6ce349c..6696ff0a94af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -192,6 +192,7 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
 	p = drm_coredump_printer(&iter);
 
 	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
+	drm_printf(&p, "version: " AMDGPU_COREDUMP_VERSION "\n");
 	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
 	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
 	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 362954521721..7b6767ca8127 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -88,6 +88,9 @@ struct amdgpu_reset_domain {
 };
 
 #ifdef CONFIG_DEV_COREDUMP
+
+#define AMDGPU_COREDUMP_VERSION "1"
+
 struct amdgpu_coredump_info {
 	struct amdgpu_device		*adev;
 	struct amdgpu_task_info         reset_task_info;
-- 
2.41.0

