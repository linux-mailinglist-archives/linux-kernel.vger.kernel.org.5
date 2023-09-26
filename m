Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29297AEACE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjIZKw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjIZKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4354FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695725522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X4uB88kvmb2OybCMfZJsL98qGlQf9b7gdl07NjAzN9g=;
        b=JWZyz3tcs7LkUpAvGqLbqcX9NpEYju7XdjJDlRlRigC4eJSvLnEjUJovhDpo+6NCt1NeqB
        Sd0eV6HCYscF6ME3yfQMX1MoklLz/D7CQw1n4XO+TudwfQAoZS38IlPO639eL+/oCOWqbQ
        HDlLsK3ee2HCidOOkwLWv2pKL+fBXKk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-AobS1yzVOduO_Jw3IC8KIw-1; Tue, 26 Sep 2023 06:52:00 -0400
X-MC-Unique: AobS1yzVOduO_Jw3IC8KIw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-531373ea109so6577865a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725519; x=1696330319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4uB88kvmb2OybCMfZJsL98qGlQf9b7gdl07NjAzN9g=;
        b=QfUZo/ME+yqA/PugiOZzdJ6UfnOtXoqS5fQz9BY+0aF+GGNjEwEbmaw5ANt3PFvm8v
         aB2/hnxfUCwM5IHQk8O8HmJg0T0/MA43AEmdwQpEgQf8bjZsEdipToFm0F9KXRVybaZ/
         Cmuh7KYj6I9vVqUs2ixMCdqOOEc3x97w9w55aglLkce/VDrIlPHQg9SrdXfugGC5OtXn
         aXvryiDcgW+zbI8+I7zKc0o7PNFfDsi+/sBTRnaUGrAu2YWlQZv6J7LbL19sRMAov61o
         f7ZWbi4SaF73D2UsM0ZbRkUmCNdUCCdNXrJmh6/LOpRxPpHyTIhAx1EDMUFsf6XrCYAQ
         x+6g==
X-Gm-Message-State: AOJu0Yy3FBmNQUS0N/5H8K3Z1GL2qI2A+5xSo0gvQa1TvcrYzcJbR3nW
        VdPee94Sjk4+KTY5V/iFyQ6FwZISgVSYv0O7/5RbTlDQjrd+mL8dbLY3aq4vFXTfdmY36XBwxRG
        HkBuCWMKg7ZWqSEeRHnpKTu+W
X-Received: by 2002:a05:6402:656:b0:522:3d36:ff27 with SMTP id u22-20020a056402065600b005223d36ff27mr8070678edx.31.1695725519472;
        Tue, 26 Sep 2023 03:51:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH8nf0IVOQ5bt/LShjdqPKghaz5yxg+NopLj8GcqKnHIkhSFwCF49cSfbnTsxDOW26ExwKZQ==
X-Received: by 2002:a05:6402:656:b0:522:3d36:ff27 with SMTP id u22-20020a056402065600b005223d36ff27mr8070663edx.31.1695725519158;
        Tue, 26 Sep 2023 03:51:59 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7d68f000000b005333922efb0sm6627881edr.78.2023.09.26.03.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:51:58 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     dri-devel@lists.freedesktop.org, sfr@canb.auug.org.au
Cc:     daniel.vetter@ffwll.ch, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH] drm/gpuvm: doc: fix filename references
Date:   Tue, 26 Sep 2023 12:51:28 +0200
Message-ID: <20230926105146.10808-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f72c2db47080 ("drm/gpuvm: rename struct drm_gpuva_manager to
struct drm_gpuvm") did also change the corresponding filenames which are
referenced from the documentation, but were not adjusted accordingly.
Hence, fix up those filenames.

Fixes: f72c2db47080 ("drm/gpuvm: rename struct drm_gpuva_manager to struct drm_gpuvm")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/dri-devel/20230926150725.4cca5fc5@canb.auug.org.au/
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 Documentation/gpu/drm-mm.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index c19b34b1c0ed..602010cb6894 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -466,40 +466,40 @@ DRM MM Range Allocator Function References
 .. kernel-doc:: drivers/gpu/drm/drm_mm.c
    :export:
 
-DRM GPU VA Manager
-==================
+DRM GPUVM
+=========
 
 Overview
 --------
 
-.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
+.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
    :doc: Overview
 
 Split and Merge
 ---------------
 
-.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
+.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
    :doc: Split and Merge
 
 Locking
 -------
 
-.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
+.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
    :doc: Locking
 
 Examples
 --------
 
-.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
+.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
    :doc: Examples
 
-DRM GPU VA Manager Function References
---------------------------------------
+DRM GPUVM Function References
+-----------------------------
 
-.. kernel-doc:: include/drm/drm_gpuva_mgr.h
+.. kernel-doc:: include/drm/drm_gpuvm.h
    :internal:
 
-.. kernel-doc:: drivers/gpu/drm/drm_gpuva_mgr.c
+.. kernel-doc:: drivers/gpu/drm/drm_gpuvm.c
    :export:
 
 DRM Buddy Allocator
-- 
2.41.0

