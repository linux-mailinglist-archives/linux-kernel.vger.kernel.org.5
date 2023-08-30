Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822B778E27D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbjH3Woq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjH3Wop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:44:45 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D1CD7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CXtTgePGuTixN4ZM+ut8UMc8YK4FbaCi/1IbBCOf0rg=; b=pjRONabdxoBHSbT9CWvrh048on
        zSuPtDsT2GALWXTWn9WbmOdAoWrYLRA/+37Bj9n3GWVL+mEZ2qTz0c4HdcmIKCsxuQtK027f0PsWo
        epILFntqJMwmkPwaC65Y3/2Zny1BfhT126JthEjsHhi4OHE2hAb6uDtI6IzDmJ51l0unnyKsjQBIw
        svZ+W4b6JD7kIPX+l8duGWLih2s8rta+R5klLXDWRcnAoZTgQMAuvT1WcsZ+KmmUttWEvKewtQIqc
        qz6bwWX2BZyn13og675/GtBrduL2hjEEd2wzuxc55qmrLXMs4K7CzOwNTwQQsTUly5qjhP444yqpf
        kEsYVSpg==;
Received: from [191.193.15.45] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qbTME-00Ha7K-Rx; Thu, 31 Aug 2023 00:08:15 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 0/2] Merge all debug module parameters
Date:   Wed, 30 Aug 2023 19:08:06 -0300
Message-ID: <20230830220808.421935-1-andrealmeid@igalia.com>
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

As suggested by Christian at [0], this patchset merges all debug modules
parameters and creates a new one for disabling soft recovery:

> Maybe we can overload the amdgpu_gpu_recovery module option with this. 
> Or even better merge all the developer module parameter into a 
> amdgpu_debug option. This way it should be pretty obvious that this 
> isn't meant to be used by someone who doesn't know how to use it.

[0] https://lore.kernel.org/dri-devel/55f69184-1aa2-55d6-4a10-1560d75c7324@amd.com/

Changelog:
- drop old module params
- use BIT() macros
- replace global var with adev-> vars
v1: https://lore.kernel.org/lkml/20230824162505.173399-1-andrealmeid@igalia.com/

André Almeida (2):
  drm/amdgpu: Merge debug module parameters
  drm/amdgpu: Create an option to disable soft recovery

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 54 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c    |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h |  9 ++++
 9 files changed, 58 insertions(+), 26 deletions(-)

-- 
2.41.0

