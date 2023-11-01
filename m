Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA57DE8FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347312AbjKAXcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346432AbjKAXcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E703C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698881492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/VNYdgSll2ACKqst9EYQmPz34iqqPWKPy+dBFz8o6o=;
        b=hBUGpwMa8tyloWvB4/imFtBqClPZ2bbFUerNa3LkLMrPo8x47XmDgW1o59TPhNqvDMDXyQ
        lHAaEKQW9sLkE8Vq7QZLj017HEwdDiBGpsC/RruLqKlilNpPr1Y+I9++DQ0GQa+0HGtfTv
        TSRhYGWY4kvy+3ilWq9SJL8DoYcno2w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-Wta0nFRJOI6SbnAp6x2clg-1; Wed, 01 Nov 2023 19:31:31 -0400
X-MC-Unique: Wta0nFRJOI6SbnAp6x2clg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54366567af4so358108a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 16:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698881490; x=1699486290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/VNYdgSll2ACKqst9EYQmPz34iqqPWKPy+dBFz8o6o=;
        b=TkmKTf9fHXTSJDQQfT/PaQW/y+mKCNNPoMdw3DuWMXMko120JMuzUFnDvZFKKxawUP
         WF+Nbpnky8gc1lKq8pjd+kyIiQAikwAQPV9p5KA49p4rcvYmXur/zMacuv6JZpjHbM7/
         hQLxBJnUfkuYp7la7troDJADASyEbfQIOqMJ2wOkHlm6M0brJWAD2zhm7JulDfD80Ml7
         OFSAyK4sDGtzBRsacHjf6j02kTIkt0/mQhkK6nBfuLP6qolbui9a+SzqwgvWEMtL8eZt
         rctzTJPCWUyNAhq6nre+h7zfQgBatXKmHJqUYuYZUElGCMTa7iuF99k9ph6pgGW8N5Eb
         rf4Q==
X-Gm-Message-State: AOJu0YzEJvYOb1EXaNHuR5nDyvpKK9ZocLGN9VSqTIVsfI1dh8kGX4rZ
        vQECUe+frLlX3xgecFg9LDGN/tA5Xrd0djDrb6puuyOHos0PUKldu2uq6YcgTkKm1LkYX0K+L7z
        2qldqT6aw5PUm2mvezvd+WU7i
X-Received: by 2002:aa7:d6c4:0:b0:543:42ac:c9f3 with SMTP id x4-20020aa7d6c4000000b0054342acc9f3mr3612990edr.19.1698881490028;
        Wed, 01 Nov 2023 16:31:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRYXLwVkzVGPU7LguN6QpCv28Yb/7P5U0T7qrfr5WzCGdt3zscx7X5wozPytxOnq0whY0MOA==
X-Received: by 2002:aa7:d6c4:0:b0:543:42ac:c9f3 with SMTP id x4-20020aa7d6c4000000b0054342acc9f3mr3612974edr.19.1698881489858;
        Wed, 01 Nov 2023 16:31:29 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id c2-20020a50d642000000b0053635409213sm1641016edj.34.2023.11.01.16.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 16:31:29 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v8 03/12] drm/gpuvm: export drm_gpuvm_range_valid()
Date:   Thu,  2 Nov 2023 00:30:55 +0100
Message-ID: <20231101233113.8059-4-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101233113.8059-1-dakr@redhat.com>
References: <20231101233113.8059-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers may use this function to validate userspace requests in advance,
hence export it.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 14 +++++++++++++-
 include/drm/drm_gpuvm.h     |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 445767f8fbc4..2669f9bbc377 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -649,7 +649,18 @@ drm_gpuvm_in_kernel_node(struct drm_gpuvm *gpuvm, u64 addr, u64 range)
 	return krange && addr < kend && kstart < end;
 }
 
-static bool
+/**
+ * drm_gpuvm_range_valid() - checks whether the given range is valid for the
+ * given &drm_gpuvm
+ * @gpuvm: the GPUVM to check the range for
+ * @addr: the base address
+ * @range: the range starting from the base address
+ *
+ * Checks whether the range is within the GPUVM's managed boundaries.
+ *
+ * Returns: true for a valid range, false otherwise
+ */
+bool
 drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
 		      u64 addr, u64 range)
 {
@@ -657,6 +668,7 @@ drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
 	       drm_gpuvm_in_mm_range(gpuvm, addr, range) &&
 	       !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
 }
+EXPORT_SYMBOL_GPL(drm_gpuvm_range_valid);
 
 /**
  * drm_gpuvm_init() - initialize a &drm_gpuvm
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 687fd5893624..13eac6f70061 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -253,6 +253,7 @@ void drm_gpuvm_init(struct drm_gpuvm *gpuvm, const char *name,
 		    const struct drm_gpuvm_ops *ops);
 void drm_gpuvm_destroy(struct drm_gpuvm *gpuvm);
 
+bool drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm, u64 addr, u64 range);
 bool drm_gpuvm_interval_empty(struct drm_gpuvm *gpuvm, u64 addr, u64 range);
 
 static inline struct drm_gpuva *
-- 
2.41.0

