Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729A279A1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjIKDXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjIKDXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:23:44 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABDB1727
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EsQxGpmTl6fVVk5TnRnxhwh5yeoTGl0hLF5hWy+ixQ4=; b=GtCN67Yv/GOJLHfyipWkUzzY4T
        ysJ3Par1ipJ15UCgHTxqnyIIi9tPyTandW31WqjGovb0EIh+sKzD3dixrFhktXC2O6Q5ToSWI9FUV
        285ISMlLzJuU4ns2+VjuEus26/7KI0bQc5NvgxSp6INZFwG0U+4Is2zwFFL8KohF2pOfdYqfsqO6v
        8H8eA+4TEahEPCLkNbJ4AaybzsbChV4hIePyUNlDpipoJTLfV/0xuYNrIFvO4/s1MT+zpEbnRPDSa
        Jywnx3Cv45ka3+n4ZlvitCSj3TMDGN0sX6/fZW4CLI9K5U9jWVC3SXKBhF5WHTHKDYGPSzDk3jnte
        KeQnn80A==;
Received: from [187.10.204.7] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qfX9z-002C6C-VD; Mon, 11 Sep 2023 05:00:24 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Shashank Sharma <shashank.sharma@amd.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 0/5] drm/amdgpu: Rework coredump memory allocation 
Date:   Mon, 11 Sep 2023 00:00:13 -0300
Message-ID: <20230911030018.73540-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.42.0
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

v5: https://lore.kernel.org/lkml/20230817182050.205925-1-andrealmeid@igalia.com/
- Added Shashank Sharma R-b tag

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
2.42.0

