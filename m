Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E043D7FE2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjK2WIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjK2WIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B6D1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701295722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EwDzdDItBJXcdcquSttPHmAm63Z9qClgG73YO2gODcE=;
        b=Wgyh1fYhd9fRxOW3tcH6zj8Wu7qu4VRR3bBhNhj1TR/YI7lInm0OrqDhLC+YIPcQo4e1pX
        g9ISt+XrmYJxfbqztXUpBnqIRWoQMjzszOr9LCYtLQv+oYLxgo/vzyT7W4wM+cN/mCFHw9
        qrLUIUPsWvnFLtttTXzKXPr9EGKoUl8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-1ShP3SOBO0eR23hRXbIJzQ-1; Wed, 29 Nov 2023 17:08:40 -0500
X-MC-Unique: 1ShP3SOBO0eR23hRXbIJzQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a01991968f5so26051566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701295719; x=1701900519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwDzdDItBJXcdcquSttPHmAm63Z9qClgG73YO2gODcE=;
        b=Rf5vZhfc91yGunVYVIOmwZvvfX+nfd4IyupbOg6t4f8bIJpg6c5dbg5KO6GQKUmUNY
         +WjaOjbU/s+8iIg4m9BwyVrIywCbVyr/bJ5YrMG3YTljCGqDMwJbHV1oi9e3YnB+kmPO
         3d0QdQyIfayhCj1jHjWF/1OBV41zqsDuQMSW2MV1pZix3H2B4yUBs2lTR/zwoqRWBAWm
         KNMpfg5TpVqSGd+tQiY3FmXvAFVONpbKkA94wA+vXTr3WiqRD4fuVweLNGhEZVxnKUbJ
         uffQTdxba06uHdPlQwDGrhWpBFDr5KzCeN0hIK+gw1O/IR3uBdig4Zdql2s8S7yWUHI3
         4q0w==
X-Gm-Message-State: AOJu0YxPBej4+WagE8ZC0rGDIyrR8Xcca7HiHodpPFKvWsu8EfAbWBs2
        OfeuXX0ijL78NCDJ58TisKBw1cbzxphYvSAQjRjhqWb1p+C2b9hu3k5P3mVBoEbyy6LKVxeFE6Y
        25Wq6aK4AxUvY2vhN3iOFyZy5
X-Received: by 2002:a17:906:3fd6:b0:a02:8820:cfa4 with SMTP id k22-20020a1709063fd600b00a028820cfa4mr12351654ejj.32.1701295719412;
        Wed, 29 Nov 2023 14:08:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSpZxd6lUeE167toP/YcYRTZtdRiDojthFKJUloBIdXRvKtOG8bdnDO/aG82E9od51VGUg8A==
X-Received: by 2002:a17:906:3fd6:b0:a02:8820:cfa4 with SMTP id k22-20020a1709063fd600b00a028820cfa4mr12351649ejj.32.1701295719172;
        Wed, 29 Nov 2023 14:08:39 -0800 (PST)
Received: from pollux.. ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id b6-20020a170906660600b009fc42f37970sm8450609ejp.171.2023.11.29.14.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:08:38 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 0/2] PowerVR VM fixes
Date:   Wed, 29 Nov 2023 23:07:59 +0100
Message-ID: <20231129220835.297885-1-dakr@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some major GPUVM changes landed just before v8 of the PowerVR series. Since v8
went in rather quickly (review process was finished otherwise) I haven't had the
chance to review the subsequent code changes.

Hence, this series with a few fixes in this context. Plus a minor GPUVM patch to
make the drm_gpuvm_prepare_* helpers useful for PowerVR.

- Danilo

Changes in V2
=============
- GPUVM: update function DOC comment to indicate the passing zero fences to
  drm_gpuvm_prepare_* functions results into drm_exec_lock_obj() calls rather
  than drm_exec_prepare_obj() calls.
- pvr/vm: use drm_gpuvm_exec wrappers
- drop 3 patches which were applied already

Danilo Krummrich (2):
  drm/gpuvm: fall back to drm_exec_lock_obj()
  drm/imagination: vm: make use of GPUVM's drm_exec helper

 drivers/gpu/drm/drm_gpuvm.c          | 43 +++++++++++--
 drivers/gpu/drm/imagination/pvr_vm.c | 91 +++++++++++-----------------
 include/drm/drm_gpuvm.h              | 23 +------
 3 files changed, 77 insertions(+), 80 deletions(-)


base-commit: 83dc1029dcf50b5b849b26679a1b3f860b85d79c
-- 
2.43.0

