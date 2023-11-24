Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1FB7F86C3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjKXXgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXXgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AD11987
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700869019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ooa83XnZj65XHeDd7bgPYl/MTM8ubdS8C8vvyOuquTY=;
        b=GQBD/kKaSHHhAo96x70dzi7QBsygR+DT9dHk8VnmIK2A4CGe50/AVVKmBwmTjFcaKIBSPw
        lBprPc3GkMHXSuckxsh5EzcIsRQCUTtfUP363OIAA3zedETKFrFjcHjMxBSysJ4+YIiDfk
        RvoQOP+fDkNrqVnz+/5Eb2ORGWP2SfY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-hJOb4cd1Pmeefn1WnDxRyg-1; Fri, 24 Nov 2023 18:36:58 -0500
X-MC-Unique: hJOb4cd1Pmeefn1WnDxRyg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9fa63374410so189354166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700869017; x=1701473817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooa83XnZj65XHeDd7bgPYl/MTM8ubdS8C8vvyOuquTY=;
        b=rv1Nx4VR+f7SiAgzHw0qTY7lhiprHZmFwMgdYsFk+UuWxAzvquNlBGQOUcBzGMLbHf
         Bqr95/4jJrO8Z8s48QONfLQz/8qf3t19ymwy475YqNGqFpb1rSt1MTUSDgWYiuVJMkck
         VkKt+6lWFEnsHH1DYag6R4YyqHPnNCYU5Lgfz+jlgHmi8hLjsT7vPY54YL/hCUDnTMcJ
         sibMVy6EAeyduyy1QJsJp+m5K81vD352E0kLRCRo4rHmrSrFg90XT3bsybgBWqtYP83K
         GVXnJLTE4010SL3NSc2TV2d0fLOTN2XvIWU6VTU8V7rx4axqr+PAX73J7ZNgD5a4snVp
         bHGA==
X-Gm-Message-State: AOJu0YxZzvsVwvyEFr5Pp2VFDRZXy2iDAHKr6xnSSoYybdkh0pDgNnGv
        Vn1S+fx0UkZqyV6v/ctZmNDk5Ecc0ZP+lZAKqUZm2vCnLGu/CXflQ+U0b9o44urhS51Dkf7grQ/
        NtprXMM/l7vNMHdQq/HcoAOhhtptji3EY
X-Received: by 2002:a17:907:1c82:b0:9b2:cf77:a105 with SMTP id nb2-20020a1709071c8200b009b2cf77a105mr4022197ejc.15.1700869016942;
        Fri, 24 Nov 2023 15:36:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0CnBXqcfXTNkotvwAE2bu91Z/qUjDzY8ANBg3E/5DBlY7f4RMdUUzgTz20lXFJlJNuuFYAA==
X-Received: by 2002:a17:907:1c82:b0:9b2:cf77:a105 with SMTP id nb2-20020a1709071c8200b009b2cf77a105mr4022180ejc.15.1700869016658;
        Fri, 24 Nov 2023 15:36:56 -0800 (PST)
Received: from pollux.. ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709064a4100b00a0b6b09b4cbsm150109ejv.8.2023.11.24.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 15:36:56 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        frank.binns@imgtec.com, donald.robson@imgtec.com,
        matt.coster@imgtec.com, sarah.walker@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 0/5] PowerVR VM fixes
Date:   Sat, 25 Nov 2023 00:36:35 +0100
Message-ID: <20231124233650.152653-1-dakr@redhat.com>
X-Mailer: git-send-email 2.42.0
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


Danilo Krummrich (5):
  drm/imagination: vm: prevent duplicate drm_gpuvm_bo instances
  drm/imagination: vm: check for drm_gpuvm_range_valid()
  drm/imagination: vm: fix drm_gpuvm reference count
  drm/gpuvm: fall back to drm_exec_lock_obj()
  drm/imagination: vm: make use of GPUVM's drm_exec helper

 drivers/gpu/drm/drm_gpuvm.c          | 36 ++++++++++++++++++++--
 drivers/gpu/drm/imagination/pvr_vm.c | 46 +++++++++++++++-------------
 drivers/gpu/drm/imagination/pvr_vm.h |  3 +-
 include/drm/drm_gpuvm.h              | 23 ++------------
 4 files changed, 63 insertions(+), 45 deletions(-)


base-commit: 46990918f35c1bf6e367cf8e0423e7344fec9fcb
-- 
2.42.0

