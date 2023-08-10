Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4B778160
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjHJTXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjHJTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:23:41 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342690
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=X3u49tpdY4rOV9dSlCIkVQr0V84jvH6SM3HD26dSfQE=; b=i6dJSdfyzBQV0GLzrx6TLIHktO
        yH/lzXsJ9dHB4QtkdbIToajfZC7vYNv50Raj5ns+p76LlJN8vsuJyDx/GlGBiZULzS2HXTzcO/++I
        UfLfnQDMEj5nfyjl6Iw2LtgRpCRBcas91egZHoeAZW9V3SG7UQzx3wX4orjiW3SHYryvvT8SOtN6E
        P3M6514cINffFmFrlMSUltzN4w20ig6Bzods0zg6Wy0espZ4+Ua+OTljQxk0hbsNPPSog/2UFwo53
        3MzlApL7HEGBbB8Y6gLmgyPnWJ0/G8dWDuL1Ux4DUCpML6NQkLLWc2+vErC+x8GRiIEPs8uNFy4im
        GItUkjWw==;
Received: from [191.193.179.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qUBFv-00Gp5H-C4; Thu, 10 Aug 2023 21:23:35 +0200
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
Subject: [RESEND v3 0/5] drm/amdgpu: Add new reset option and rework coredump
Date:   Thu, 10 Aug 2023 16:23:25 -0300
Message-ID: <20230810192330.198326-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
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

Hi,

The goal of this patchset is to improve debugging device resets on amdgpu.

The first patch creates a new module parameter to disable soft recoveries,
ensuring every recovery go through the full device reset, making easier to
generate resets from userspace tools like [0] and [1]. This is important to
validate how the stack behaves on resets, from end-to-end.

The last patches are a rework to alloc devcoredump dynamically and to move it to
a better source file.

I have dropped the patches that add more information to devcoredump for now,
until I figure out a better way to do so, like storing the IB address in the
fence.

Thanks,
	André

[0] https://gitlab.freedesktop.org/andrealmeid/gpu-timeout
[1] https://github.com/andrealmeid/vulkan-triangle-v1

Changelog:

v2: https://lore.kernel.org/dri-devel/20230713213242.680944-1-andrealmeid@igalia.com/
- Drop the IB and ring patch
- Drop patch that limited information from kernel threads
- Add patch to move coredump to amdgpu_reset

v1: https://lore.kernel.org/dri-devel/20230711213501.526237-1-andrealmeid@igalia.com/
 - Drop "Mark contexts guilty for causing soft recoveries" patch
 - Use GFP_NOWAIT for devcoredump allocation

André Almeida (5):
  drm/amdgpu: Create a module param to disable soft recovery
  drm/amdgpu: Allocate coredump memory in a nonblocking way
  drm/amdgpu: Rework coredump to use memory dynamically
  drm/amdgpu: Move coredump code to amdgpu_reset file
  drm/amdgpu: Create version number for coredumps

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 67 +-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 79 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 14 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  6 +-
 6 files changed, 111 insertions(+), 70 deletions(-)

-- 
2.41.0

