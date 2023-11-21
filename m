Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164127F3992
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjKUW5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjKUW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:56:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4CFBB;
        Tue, 21 Nov 2023 14:56:53 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc29f39e7aso40274025ad.0;
        Tue, 21 Nov 2023 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700607413; x=1701212213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VvsEAsvFJCAuzTkOhawjNcVDzfJqg2jxoNzCw1vuYxM=;
        b=Yp9JIov+wo0DTDXoobNFWkySiptxCV3/DkKvymOHb/eK6z6/I5CB6en5pHK3b4G6pm
         xRunPR/DDdojptiJz5F1r2OyrhmOIG1hB/uSfPGyySZhphmtrOpzByjwpsiznR4cSKX5
         zf1LR910qlKxYv2fG3k7aWNG302y0xH3ZC7M6oatdtQm7FQA24VyrVQAAay3ALIVVbE/
         ivS82PbhCpc5Rrft5W7SC3TVj9I+lNWx5b9ywoDc7xXj8DBvQIvfhOp53YMSWbo7bMNI
         aKfK0+N3cIq4Pny7xnfznm3j0PiywWAXHYaz/OOy+FWwslRj7dNEz74hP4h9euWM2IpK
         YDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607413; x=1701212213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvsEAsvFJCAuzTkOhawjNcVDzfJqg2jxoNzCw1vuYxM=;
        b=EZZ+vQFdtvMuAfpLGQ+PiLGwO7rF8TJ4I6+GoOAtsbcc0B7Jy6fPCxljTnND2PEcgr
         WnygRDpYLZcw8KUhtSQ8XMFoctyTOwdx7J+fdM/Q2y0r7ii9ZgeBodijfhh8XDNi397A
         dAkDfvZ7PVgYeIcz34QADZXyC3XAEpaN1wiqBS2DiiRyUemLss52yRIkbcVjMahz1+Na
         6WAWr41T8jk9U4Smu2sh6qBJfVj5JCwOddjl05SvhwCioq3/5OGDAh3StFSU1cxCWu2b
         N5yYBXmNhS16pNPCFQSlw7KeukX4oDq1bUSKOijD3XXrmLLycKsSFF6tuorTjYKF/Ca8
         7kDQ==
X-Gm-Message-State: AOJu0YwFpLGEnvY01HBQk8MTTjRuldcxVG8XEkccbnkkPneFK9JRr13Q
        3v639ajHIChQv0mKs4T/TxfIBWfeqPI=
X-Google-Smtp-Source: AGHT+IEixIM7V9jXUvQI2iY90FGeBw9eNcXJcsg0YhY579MahaeWwDFx+r2X2Fo8ANAZMdHPBZ1vYA==
X-Received: by 2002:a17:902:d346:b0:1cc:3932:4a87 with SMTP id l6-20020a170902d34600b001cc39324a87mr588713plk.56.1700607412734;
        Tue, 21 Nov 2023 14:56:52 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7377:923f:1ff3:266d])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001cc47c1c29csm8413189plt.84.2023.11.21.14.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:56:51 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/14] tools headers UAPI: Update tools's copy of drm headers
Date:   Tue, 21 Nov 2023 14:56:36 -0800
Message-ID: <20231121225650.390246-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/drm/drm.h      | 20 ++++++++++++++++++++
 tools/include/uapi/drm/i915_drm.h |  8 ++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 794c1d857677..de723566c5ae 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -1134,6 +1134,26 @@ extern "C" {
 #define DRM_IOCTL_MODE_PAGE_FLIP	DRM_IOWR(0xB0, struct drm_mode_crtc_page_flip)
 #define DRM_IOCTL_MODE_DIRTYFB		DRM_IOWR(0xB1, struct drm_mode_fb_dirty_cmd)
 
+/**
+ * DRM_IOCTL_MODE_CREATE_DUMB - Create a new dumb buffer object.
+ *
+ * KMS dumb buffers provide a very primitive way to allocate a buffer object
+ * suitable for scanout and map it for software rendering. KMS dumb buffers are
+ * not suitable for hardware-accelerated rendering nor video decoding. KMS dumb
+ * buffers are not suitable to be displayed on any other device than the KMS
+ * device where they were allocated from. Also see
+ * :ref:`kms_dumb_buffer_objects`.
+ *
+ * The IOCTL argument is a struct drm_mode_create_dumb.
+ *
+ * User-space is expected to create a KMS dumb buffer via this IOCTL, then add
+ * it as a KMS framebuffer via &DRM_IOCTL_MODE_ADDFB and map it via
+ * &DRM_IOCTL_MODE_MAP_DUMB.
+ *
+ * &DRM_CAP_DUMB_BUFFER indicates whether this IOCTL is supported.
+ * &DRM_CAP_DUMB_PREFERRED_DEPTH and &DRM_CAP_DUMB_PREFER_SHADOW indicate
+ * driver preferences for dumb buffers.
+ */
 #define DRM_IOCTL_MODE_CREATE_DUMB DRM_IOWR(0xB2, struct drm_mode_create_dumb)
 #define DRM_IOCTL_MODE_MAP_DUMB    DRM_IOWR(0xB3, struct drm_mode_map_dumb)
 #define DRM_IOCTL_MODE_DESTROY_DUMB    DRM_IOWR(0xB4, struct drm_mode_destroy_dumb)
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 7000e5910a1d..218edb0a96f8 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -38,13 +38,13 @@ extern "C" {
  */
 
 /**
- * DOC: uevents generated by i915 on it's device node
+ * DOC: uevents generated by i915 on its device node
  *
  * I915_L3_PARITY_UEVENT - Generated when the driver receives a parity mismatch
- *	event from the gpu l3 cache. Additional information supplied is ROW,
+ *	event from the GPU L3 cache. Additional information supplied is ROW,
  *	BANK, SUBBANK, SLICE of the affected cacheline. Userspace should keep
- *	track of these events and if a specific cache-line seems to have a
- *	persistent error remap it with the l3 remapping tool supplied in
+ *	track of these events, and if a specific cache-line seems to have a
+ *	persistent error, remap it with the L3 remapping tool supplied in
  *	intel-gpu-tools.  The value supplied with the event is always 1.
  *
  * I915_ERROR_UEVENT - Generated upon error detection, currently only via
-- 
2.43.0.rc1.413.gea7ed67945-goog

