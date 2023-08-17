Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D3177FDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354376AbjHQSXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354396AbjHQSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:23:01 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528E3A89
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hnyFmvptwRfHK2s033LR0U+yk18rfVhCUIryK3j2kmk=; b=J+VAtXN/lVjIFqPIVk0iUMnBvF
        i7QVL3btaL9smzodEpYbUGWNeL+FM2/26EFGxEo2ujGpvkG3yMHAr+h60mkgoTXItG+oD7Tg/wfgQ
        WRy0qvqdO9IOkdu1s2xZnVKzjBoQHl7pDEGhjBKYAkO4mvOimLUbf47eYzrmmHWABV5dMcDjX5kRU
        bcSsUwkoCgEH9Z8i2TQAQzeR79/7c20dTGIpi7R5ZZueN/jlr2RT/Qp4VrLi66UQ8hkXQeeeRmeID
        UvO2Qkr2YJpScEnE05CDLLxGkecYAi+pc5Lb0wIox/1WG9UMA8E27DTbhnnWiH6XRVUax7CHotbiU
        +pqK/VQA==;
Received: from [191.193.179.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qWhc9-0021I9-GB; Thu, 17 Aug 2023 20:20:57 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 0/5] drm/amdgpu: Rework coredump memory allocation
Date:   Thu, 17 Aug 2023 15:20:45 -0300
Message-ID: <20230817182050.205925-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patches of this set are a rework to alloc devcoredump dynamically and to
move it to a better source file.

Thanks,
	André

Changelog:

v4: https://lore.kernel.org/dri-devel/20230815195100.294458-1-andrealmeid@igalia.com/
- New patch to encapsulate all reset info in a struct

v3: https://lore.kernel.org/dri-devel/20230810192330.198326-1-andrealmeid@igalia.com/
- Changed from kmalloc to kzalloc
- Dropped "Create a module param to disable soft recovery" for now

v2: https://lore.kernel.org/dri-devel/20230713213242.680944-1-andrealmeid@igalia.com/
- Drop the IB and ring patch
- Drop patch that limited information from kernel threads
- Add patch to move coredump to amdgpu_reset

v1: https://lore.kernel.org/dri-devel/20230711213501.526237-1-andrealmeid@igalia.com/
 - Drop "Mark contexts guilty for causing soft recoveries" patch
 - Use GFP_NOWAIT for devcoredump allocatio

André Almeida (5):
  drm/amdgpu: Allocate coredump memory in a nonblocking way
  drm/amdgpu: Rework coredump to use memory dynamically
  drm/amdgpu: Encapsulate all device reset info
  drm/amdgpu: Move coredump code to amdgpu_reset file
  drm/amdgpu: Create version number for coredumps

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 21 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 75 ++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 77 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   | 13 ++++
 5 files changed, 114 insertions(+), 82 deletions(-)

-- 
2.41.0

