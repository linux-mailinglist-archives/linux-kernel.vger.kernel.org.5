Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D2782046
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjHTVzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjHTVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727A9F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692568451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M4vIZkwPS+ZQov4UL+Fk7Hf/Kd7fgNhda5kiRYBSffg=;
        b=Xn2ohMllJnxsFCBLc+BCKsYKcMshDPAcT8pjiVmRKCk4gRybsJ36PB1pZZJORjIhtIS4y2
        ddDimb6pRZelJxc2Vm31tP18vsFGfhKg8XxKvpKG+VpmDJzZKwobpdxAcvSTAk8efJfNhb
        HoGoIiQJn73dZHXmR0KDuoEAVKibjCE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177--d1T8TUHNVG16aSfWecwuA-1; Sun, 20 Aug 2023 17:54:10 -0400
X-MC-Unique: -d1T8TUHNVG16aSfWecwuA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5007fc7873aso349773e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692568448; x=1693173248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4vIZkwPS+ZQov4UL+Fk7Hf/Kd7fgNhda5kiRYBSffg=;
        b=Q1pe1NCWZ+jzuzAKJbAGtoaArhp9oe45dMgCpIj8w2NGgWRq+dRPcI4vCotVQRrnaK
         zcI8l+M9KVOVc6Ekx5pn5DeFVpgrTHFnErcXL6S0aSIv8qIZQ68Tj5zSd27vP5OD6orA
         SlGn4/CTTQ1k6x+/Ezr56CAefnegMi/EEon90mw7xcglUDFQw6Itu2Ef3IlyPwsqtlw/
         j/MVIq7wEWE7oTQo5Sr1a8+FFi5hVpWfxCeweTD4eUeGJJlEggDbqDZYGIFQhSb2JvPj
         ZXJVwu1ITc2n8xgZwdu4OE23v5OPwGxSoajmkbr07xVUUtR/FETUt3YUbKngwy6hK7Q9
         8NJw==
X-Gm-Message-State: AOJu0Yx6sIx9EoI1K11BCNA94Nk81pGXqgcYlM1y+IY5J8nkdeUTE2rC
        c/LuJf24fLrQSnFwrYmtI09E5RCp7pVlCLNXvupGAYGr8VVf/E9aKsSH/id506dk8rSlZyQX+2c
        23NAFEafqTT7nt3IPdU9auWIqGeWdz8W1
X-Received: by 2002:ac2:4f15:0:b0:4fb:8bab:48b6 with SMTP id k21-20020ac24f15000000b004fb8bab48b6mr3925845lfr.52.1692568448254;
        Sun, 20 Aug 2023 14:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAZXjzsPM9goXTH3dmZ8rgr6Mp+E+RlZMS0dK0JUhqJLysGLS+LL7CvcluY0OjXk0lsaZwJg==
X-Received: by 2002:ac2:4f15:0:b0:4fb:8bab:48b6 with SMTP id k21-20020ac24f15000000b004fb8bab48b6mr3925827lfr.52.1692568447849;
        Sun, 20 Aug 2023 14:54:07 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id c6-20020a170906170600b0099e05fb8f95sm5298869eje.137.2023.08.20.14.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 14:54:07 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 0/3] [RFC] DRM GPUVA Manager GPU-VM features
Date:   Sun, 20 Aug 2023 23:53:07 +0200
Message-ID: <20230820215320.4187-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the DRM GPUVA manager offers common infrastructure to track GPU VA
allocations and mappings, generically connect GPU VA mappings to their
backing buffers and perform more complex mapping operations on the GPU VA
space.

However, there are more design patterns commonly used by drivers, which
can potentially be generalized in order to make the DRM GPUVA manager
represent a basic GPU-VM implementation. In this context, this patch series
aims at generalizing the following elements.

1) Provide a common dma-resv for GEM objects not being used outside of
   this GPU-VM.

2) Provide tracking of external GEM objects (GEM objects which are
   shared with other GPU-VMs).

3) Provide functions to efficiently lock all GEM objects dma-resv the
   GPU-VM contains mappings of.

4) Provide tracking of evicted GEM objects the GPU-VM contains mappings
   of, such that validation of evicted GEM objects is accelerated.

5) Provide some convinience functions for common patterns.

Rather than being designed as a "framework", the target is to make all
features appear as a collection of optional helper functions, such that
drivers are free to make use of the DRM GPUVA managers basic
functionality and opt-in for other features without setting any feature
flags, just by making use of the corresponding functions.

The implementation introduces struct drm_gpuva_gem, which serves as abstraction
combining a struct drm_gpuva_manager and struct drm_gem_object, similar to what
amdgpu does with struct amdgpu_bo_vm. While this adds a bit of complexity it
improves the efficiency of tracking evicted GEM objects. [1] provides an
alternative implementation using a maple_tree, resulting into a fairly simpler
API. [2] points to the full patch series providing the alternative
implementation. [3] points to this patch series.

[1] https://gitlab.freedesktop.org/nouvelles/kernel/-/commit/2a7e1b0ece2c3bba43376783b577d97ae6f6e54f
[2] https://gitlab.freedesktop.org/nouvelles/kernel/-/commits/gpuva-vm-resv
[3] https://gitlab.freedesktop.org/nouvelles/kernel/-/commits/gpuva-vm-resv-vm-bo

Danilo Krummrich (3):
  drm: drm_exec: build always builtin
  drm/gpuva_mgr: generalize dma_resv/extobj handling and GEM validation
  drm/nouveau: gpuva mgr dma-resv/extobj handling, GEM validation

 drivers/gpu/drm/Kconfig                 |   6 -
 drivers/gpu/drm/Makefile                |   3 +-
 drivers/gpu/drm/drm_gpuva_mgr.c         | 688 +++++++++++++++++++++++-
 drivers/gpu/drm/nouveau/Kconfig         |   1 -
 drivers/gpu/drm/nouveau/nouveau_bo.c    |   4 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c  |  51 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c   |   4 +-
 drivers/gpu/drm/nouveau/nouveau_sched.h |   2 -
 drivers/gpu/drm/nouveau/nouveau_uvmm.c  | 191 +++++--
 include/drm/drm_gem.h                   |  48 +-
 include/drm/drm_gpuva_mgr.h             | 302 ++++++++++-
 11 files changed, 1161 insertions(+), 139 deletions(-)


base-commit: 25205087df1ffe06ccea9302944ed1f77dc68c6f
-- 
2.41.0

