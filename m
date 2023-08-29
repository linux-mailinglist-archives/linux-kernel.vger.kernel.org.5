Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB87F78CDC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbjH2Uqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbjH2UqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90FDCC2;
        Tue, 29 Aug 2023 13:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 480BB6393C;
        Tue, 29 Aug 2023 20:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC55C433C8;
        Tue, 29 Aug 2023 20:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693341978;
        bh=D/5R2gh0UNSBdokYwLYROA4OoUG4+BHEBICEdKyk2AM=;
        h=From:To:Cc:Subject:Date:From;
        b=fwWP1Wxr8Z625C8Ti+XBiDzYb5J1vibO/NUUMANGvbDaRMWpdyJ5U288G5h2DNhNw
         zfTO5NBH/YI56Pvc1LDqpv2UDNHMRKVoDOGPMYek0Ge3biGqa5m5IsARtTojV0VTl4
         bo4B3gfvBUi8gVl/srdsU4ZKv8TfzaqEZDbpRVcBgWwkgW5birFdtH0o8xoKm9ct+4
         vyXvFjo2lCZsTK9k7nrn6CLEmnc+BbIORKqkzrPY975IBDUn9e0wFa8egVfQwrTmuI
         QzJCM5JJBIRVZWwCeplwP3tVuGbs5A4hzQfOpsxVswYyV8404q3E5pSnG4zC2uXGli
         sAn36Vl6X4e/g==
From:   Ross Zwisler <zwisler@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-media@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] visl: use canonical ftrace path
Date:   Tue, 29 Aug 2023 14:46:01 -0600
Message-ID: <20230829204600.3210276-2-zwisler@kernel.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Zwisler <zwisler@google.com>

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

Update the visl decoder driver documentation to use this tracefs path.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 Documentation/admin-guide/media/visl.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
index 7d2dc78341c9..4328c6c72d30 100644
--- a/Documentation/admin-guide/media/visl.rst
+++ b/Documentation/admin-guide/media/visl.rst
@@ -78,7 +78,7 @@ The trace events are defined on a per-codec basis, e.g.:
 
 .. code-block:: bash
 
-        $ ls /sys/kernel/debug/tracing/events/ | grep visl
+        $ ls /sys/kernel/tracing/events/ | grep visl
         visl_fwht_controls
         visl_h264_controls
         visl_hevc_controls
@@ -90,13 +90,13 @@ For example, in order to dump HEVC SPS data:
 
 .. code-block:: bash
 
-        $ echo 1 >  /sys/kernel/debug/tracing/events/visl_hevc_controls/v4l2_ctrl_hevc_sps/enable
+        $ echo 1 >  /sys/kernel/tracing/events/visl_hevc_controls/v4l2_ctrl_hevc_sps/enable
 
 The SPS data will be dumped to the trace buffer, i.e.:
 
 .. code-block:: bash
 
-        $ cat /sys/kernel/debug/tracing/trace
+        $ cat /sys/kernel/tracing/trace
         video_parameter_set_id 0
         seq_parameter_set_id 0
         pic_width_in_luma_samples 1920
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

