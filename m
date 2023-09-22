Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAB97AB8D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjIVSGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjIVSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBEAE5C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690d8c05784so2028989b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405259; x=1696010059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRKN2/xBrWvsqRPQDODOVPiV3fGRN8WGAkKDB21KTao=;
        b=nX7UWr7FMEWywGKAmjsGAMAQH6cAAPkQZvU6BekvdN83y7G05XScdHR49JeajRAopQ
         dKTO3LwdiyN97AwonrXZHUXjI4Hc5uOI+RudlBVsz9qQ1cRe4YOKiQZp0FMpcaZ9yfT4
         25uEYudk2Ov842i2inmRxlXmUnXSe6HVssYSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405259; x=1696010059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRKN2/xBrWvsqRPQDODOVPiV3fGRN8WGAkKDB21KTao=;
        b=NVYMLEnSC1tztes+HkloSHrIkPNbFD/hegr5AAfzm6u1H89YfxVpV92LKS9FiiRqdC
         j5t2tkGjZgA9MdTDO4XTMlPprrmeUsMNR39YPB5RPt6uJAKxvGLrrXc4SEQnSmOykTBL
         7dApR4morZOP+PvFt2n0q313DT39PDUcDxcHGkPGbfrj+1GHKSS7fVoDNGfG00fd7VeO
         W2AlT0uzytGGhlVLvqyJnNm3zBx8azNRv+Zu0B5Ovxnrez/spVcPra5cZLXSiDGfzK0m
         sTbsBBGNs3PVibg3PMlvUFB7AF9Fmnhu8+nU9G1jEruyCzS7wNyY8xujVITbnT4Ytbfj
         8UeA==
X-Gm-Message-State: AOJu0Yw+YIQkLEBVkfVhyB0pxJOVLzlbsN7fQzBee13CVtKL8H5NXf3+
        nM0LEyF2MvzeZYo+e7G+ZoqV2A==
X-Google-Smtp-Source: AGHT+IHaCKf2H2xl/vEMZDs+B2JWCIWeEjv/kL2lXURkoNqtvf0o9Oh8l386aSVv3+k7z5cEewn2EQ==
X-Received: by 2002:a05:6a20:7f91:b0:135:38b5:7e58 with SMTP id d17-20020a056a207f9100b0013538b57e58mr339189pzj.37.1695405258962;
        Fri, 22 Sep 2023 10:54:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kb14-20020a170903338e00b001bb3beb2bc6sm3779500plb.65.2023.09.22.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:54:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] accel/ivpu: Annotate struct ivpu_job with __counted_by
Date:   Fri, 22 Sep 2023 10:54:17 -0700
Message-Id: <20230922175416.work.272-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=keescook@chromium.org;
 h=from:subject:message-id; bh=m5lQ9Sc4/fHR/XZEOUiHgj1+UhlsVXVLOdUWy7uMxzY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdTJ38ytmDtxaYz7ESHW4iJMEWaDISXcxNUPY
 fkE4hcFocOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UyQAKCRCJcvTf3G3A
 JvleD/4vxM9D+I+pVT/pVESSzmlw2BdKA8ww1Ze0HR9ifWWboneaUfZDM7gMmUqspaDaCL7H+g1
 Rn59P2QOYB61Ua67yMFGDFiUuQBLWULgd1+hbwV4iCPXLeeDtKF6KS2H13CtmCKui3/sfLZm2bb
 AkHVoh2LqFCxR8NejyT0txBBbE98UFkfbNFQQNg7vzNgFDdDP1XOzXL/ujf5ZQ3FZoryHa4Py53
 Ys46mRjWXc4AuqPpqMfIYAZDVvki6i5Rbox2zSFtRUDpkPf8cI63lIvws23RphDJutzGtV32jma
 ZtVA96fnHaAjIGOyC8Z8x3p06lYhtpUKpIUGHdb35Tc9T6j2oGdfHyvgeUXdNV8FfBvOsUs6Zvs
 xAHKumyqUUKvgP+MrI7ENxu/s4pST3zlfSU82orWyLgvis4FaeD7IZ7h7iIr/7L1CtowukN62UL
 YKBMNCIKulmCuOS2YmNefWgVp3lrwxBZPdkwOrrVwMtfjnyqRB+9jqt3BgtIgxEMhtJAyyHcrzi
 Nh9MKqcBUV0Mkc39kL+ed9pk7kHv67HEmvOPUeUSPr5hnKPfXCyzgJ6Dm8lrt3w6X6yQfhj7Z7F
 FZgjOe1Xd6JGHlvkbLkNyp+RHwdyr4ovCQzLTrPvdrWX49N4f2ID9UdrVZnPwPFQlD6cFKQ9lqg
 CfmV4zY GUVf7B9A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ivpu_job.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/accel/ivpu/ivpu_job.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_job.h b/drivers/accel/ivpu/ivpu_job.h
index aa1f0b9479b0..5514c2d8a609 100644
--- a/drivers/accel/ivpu/ivpu_job.h
+++ b/drivers/accel/ivpu/ivpu_job.h
@@ -51,7 +51,7 @@ struct ivpu_job {
 	u32 job_id;
 	u32 engine_idx;
 	size_t bo_count;
-	struct ivpu_bo *bos[];
+	struct ivpu_bo *bos[] __counted_by(bo_count);
 };
 
 int ivpu_submit_ioctl(struct drm_device *dev, void *data, struct drm_file *file);
-- 
2.34.1

