Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF659772AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHGQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjHGQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B01736
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691425965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8RzhR0Defsn9yPdyrBq2FgdXanmnGOPFDzct4NabJUc=;
        b=aNDgVs7+bPuafNZ6NYVvMsJBg9X0avokbYOoN0GLY6RArOlO+9hYDBwGSzFHFnCnRn/VBr
        zwl76XLwk+bdYiQ9+ssyHNyoG2Pu/Y4qu7uQW3vLAQ/7uBjW4i4j6QhITf4MyFA1QwFa6Z
        lMR/Bm4LuFENy52EpbpI2uzdz49KxXs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-JBDaZUsTPQG-3gcBv6d6qg-1; Mon, 07 Aug 2023 12:32:44 -0400
X-MC-Unique: JBDaZUsTPQG-3gcBv6d6qg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe55c417fcso4051292e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425962; x=1692030762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RzhR0Defsn9yPdyrBq2FgdXanmnGOPFDzct4NabJUc=;
        b=dRfKJtxpZs6ihthl1aMA00ZoBl7Dx0R/ER7aSFExbN3WdpxEMDTTpgsquBFdQI1q0F
         0k6APoHxCJCyiF+TT77sBQ6euTBk5xFVZuN6UI35Me9s/fgI5GSZ41Zki/OUyFL8+1EH
         YpvzqEr5owxzx3dgEeEEENcEceKnnn/wHOgeiN+k6brN97GBmMhQzl9FYUQo+8xEcCd5
         LaT9qPBm9CR/+Ny+ea9YV1nSyPt2iyaDbMKYImwE+N+ZEFp1fydQhJp9PGgVEzlwHE9/
         AoWcAsEbgYp2sh0CLaVbUHsJ0VN1EIdWK5i//0JP6ODkG4aYCRIOY4OxNIXvtPg+QHgf
         fVaw==
X-Gm-Message-State: AOJu0Yxlp4d7oKPK2Fcxzu8450oE4hJGrxrX4mJ3iPLFHmm5FqErrcIX
        u5XSEzTHHb4FvYY0UeBJPlGDshKKcC2lJQmR4qMCE/H+6xY+i53oEjuRjPDlOESu+c6+LmL7ib/
        rTBfRhufCNL667/ivqRPi76OqFvwmk4qo
X-Received: by 2002:ac2:5e90:0:b0:4fb:c657:3376 with SMTP id b16-20020ac25e90000000b004fbc6573376mr5710687lfq.29.1691425962408;
        Mon, 07 Aug 2023 09:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoveHUcxmtOtYeVGuvV0X+WYxTBKr9SEAQjhSbownwD6MHWzDQxtVUZ5WIVK3lj030C9Zegw==
X-Received: by 2002:ac2:5e90:0:b0:4fb:c657:3376 with SMTP id b16-20020ac25e90000000b004fbc6573376mr5710669lfq.29.1691425962042;
        Mon, 07 Aug 2023 09:32:42 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id d17-20020a50fb11000000b00522572f323dsm5394761edq.16.2023.08.07.09.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:32:41 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com, sfr@canb.auug.org.au
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 0/5] Nouveau VM_BIND uAPI Fixes
Date:   Mon,  7 Aug 2023 18:32:21 +0200
Message-ID: <20230807163238.2091-1-dakr@redhat.com>
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

The patch series provides a few fixes for the recently merged VM_BIND uAPI
mostly addressing a couple of warnings.

It also contains one patch to slightly reduce the memory footprint of
struct nouveau_uvma.

Danilo Krummrich (5):
  nouveau/dmem: fix copy-paste error in nouveau_dmem_migrate_chunk()
  drm/nouveau: nvkm: vmm: silence warning from cast
  drm/nouveau: remove incorrect __user annotations
  drm/nouveau: uvmm: remove incorrect calls to mas_unlock()
  drm/nouveau: uvmm: remove dedicated VM pointer from VMAs

 drivers/gpu/drm/nouveau/nouveau_dmem.c        |  2 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c        |  6 ++---
 drivers/gpu/drm/nouveau/nouveau_exec.h        |  2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c        | 23 ++++++++-----------
 drivers/gpu/drm/nouveau/nouveau_uvmm.h        | 14 +++++------
 .../gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c    |  5 ++--
 6 files changed, 24 insertions(+), 28 deletions(-)


base-commit: 82d750e9d2f5d0594c8f7057ce59127e701af781
-- 
2.41.0

