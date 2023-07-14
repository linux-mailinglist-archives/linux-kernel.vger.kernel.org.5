Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA00753B93
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjGNNNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjGNNNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:13:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413030D8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7810D61D08
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D882C433C8;
        Fri, 14 Jul 2023 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689340416;
        bh=qyBXp2QK6kbJuX1krioi38XzOgvKJd/6ivqrhvvnXpY=;
        h=Date:From:To:Cc:Subject:From;
        b=jdU62uB/PByOkYkon00bBLnsRXmw5c9NtEXCqs7uyIftPYi+M8vsh1vS5em+tNxuR
         KiidzPxv/Zsjapzybn8dQsWd9OxtR1/4MWB8AW3i+XyB9j6nRdvLP70NacK27gGtZZ
         j4YuqVK7ph0Pqby/SjSTQr8ea1RQMuL5rxb5fcTn+B8hKs0lxLPFzYQZTQGgr1AJkb
         IZn+wJ3qX+lGH60G9AX1fpylIoQERKO1ezqPQxoAIHQyC0JSY+HLBGvo0jGuvFqs4x
         gJKUKYR69JKwdnxzzboQoHh5hLfmO2Fr4XP3c03YxQfTDHc/4B2BJSYAObuASOna4/
         KxIonx72vAnCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D9EA40516; Fri, 14 Jul 2023 10:13:34 -0300 (-03)
Date:   Fri, 14 Jul 2023 10:13:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync linux/vhost.h with the
 kernel sources
Message-ID: <ZLFJ/RsDGYiaH5nj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

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

---

To get the changes in:

  228a27cf78afc63a ("vhost: Allow worker switching while work is queueing")
  c1ecd8e950079774 ("vhost: allow userspace to create workers")

To pick up these changes and support them:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
  $ cp include/uapi/linux/vhost.h tools/include/uapi/linux/vhost.h
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
  $ diff -u before after
  --- before	2023-07-14 09:58:14.268249807 -0300
  +++ after	2023-07-14 09:58:23.041493892 -0300
  @@ -10,6 +10,7 @@
   	[0x12] = "SET_VRING_BASE",
   	[0x13] = "SET_VRING_ENDIAN",
   	[0x14] = "GET_VRING_ENDIAN",
  +	[0x15] = "ATTACH_VRING_WORKER",
   	[0x20] = "SET_VRING_KICK",
   	[0x21] = "SET_VRING_CALL",
   	[0x22] = "SET_VRING_ERR",
  @@ -31,10 +32,12 @@
   	[0x7C] = "VDPA_SET_GROUP_ASID",
   	[0x7D] = "VDPA_SUSPEND",
   	[0x7E] = "VDPA_RESUME",
  +	[0x9] = "FREE_WORKER",
   };
   static const char *vhost_virtio_ioctl_read_cmds[] = {
   	[0x00] = "GET_FEATURES",
   	[0x12] = "GET_VRING_BASE",
  +	[0x16] = "GET_VRING_WORKER",
   	[0x26] = "GET_BACKEND_FEATURES",
   	[0x70] = "VDPA_GET_DEVICE_ID",
   	[0x71] = "VDPA_GET_STATUS",
  @@ -44,6 +47,7 @@
   	[0x79] = "VDPA_GET_CONFIG_SIZE",
   	[0x7A] = "VDPA_GET_AS_NUM",
   	[0x7B] = "VDPA_GET_VRING_GROUP",
  +	[0x8] = "NEW_WORKER",
   	[0x80] = "VDPA_GET_VQS_COUNT",
   	[0x81] = "VDPA_GET_GROUP_NUM",
   };
  $

For instance, see how those 'cmd' ioctl arguments get translated, now
ATTACH_VRING_WORKER, GET_VRING_WORKER and NEW_WORKER, will be as well:

  # perf trace -a -e ioctl --max-events=10
       0.000 ( 0.011 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                   = 0
      21.353 ( 0.014 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                   = 0
      25.766 ( 0.014 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)    = 0
      25.845 ( 0.034 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70) = 0
      25.916 ( 0.011 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)       = 0
      25.941 ( 0.025 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ATOMIC, arg: 0x7ffe4a22c840)       = 0
      32.915 ( 0.009 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_RMFB, arg: 0x7ffe4a22cf9c)         = 0
      42.522 ( 0.013 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)    = 0
      42.579 ( 0.031 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70) = 0
      42.644 ( 0.010 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)       = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index 92e1b700b51cbdf6..f5c48b61ab622441 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -45,6 +45,25 @@
 #define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
 /* Specify an eventfd file descriptor to signal on log write. */
 #define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
+/* By default, a device gets one vhost_worker that its virtqueues share. This
+ * command allows the owner of the device to create an additional vhost_worker
+ * for the device. It can later be bound to 1 or more of its virtqueues using
+ * the VHOST_ATTACH_VRING_WORKER command.
+ *
+ * This must be called after VHOST_SET_OWNER and the caller must be the owner
+ * of the device. The new thread will inherit caller's cgroups and namespaces,
+ * and will share the caller's memory space. The new thread will also be
+ * counted against the caller's RLIMIT_NPROC value.
+ *
+ * The worker's ID used in other commands will be returned in
+ * vhost_worker_state.
+ */
+#define VHOST_NEW_WORKER _IOR(VHOST_VIRTIO, 0x8, struct vhost_worker_state)
+/* Free a worker created with VHOST_NEW_WORKER if it's not attached to any
+ * virtqueue. If userspace is not able to call this for workers its created,
+ * the kernel will free all the device's workers when the device is closed.
+ */
+#define VHOST_FREE_WORKER _IOW(VHOST_VIRTIO, 0x9, struct vhost_worker_state)
 
 /* Ring setup. */
 /* Set number of descriptors in ring. This parameter can not
@@ -70,6 +89,18 @@
 #define VHOST_VRING_BIG_ENDIAN 1
 #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
 #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
+/* Attach a vhost_worker created with VHOST_NEW_WORKER to one of the device's
+ * virtqueues.
+ *
+ * This will replace the virtqueue's existing worker. If the replaced worker
+ * is no longer attached to any virtqueues, it can be freed with
+ * VHOST_FREE_WORKER.
+ */
+#define VHOST_ATTACH_VRING_WORKER _IOW(VHOST_VIRTIO, 0x15,		\
+				       struct vhost_vring_worker)
+/* Return the vring worker's ID */
+#define VHOST_GET_VRING_WORKER _IOWR(VHOST_VIRTIO, 0x16,		\
+				     struct vhost_vring_worker)
 
 /* The following ioctls use eventfd file descriptors to signal and poll
  * for events. */
-- 
2.37.1

