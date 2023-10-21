Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF17D19D4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjJUAJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJUAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:09:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E66D6B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:09:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9bc6447193so1712493276.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697846956; x=1698451756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aAAEOjN763/uoJltIk1A5v8Y5KhewbirWplELVB65Hg=;
        b=FEzexuUu2gcyjH/m+gDOPV0n1SYa1thoit5FP4FvyxKLGhkaVAJTIJYlugs40FEnYh
         SNPyFghvuKez04npHDSy/eWRyFQVUjHvo6h9Ro6IoRKjlrhW0pUzrnqLglaRvgnkxJzu
         2uewqy1+yyx/R0hbwRRXsJ5ZgvT9X+ko26jAlWsapOtvyzmBxp27NmBnduYEBD0X3HQj
         CHlk+Wdc7dhkAQJPTu90uQARCkKRtvRAs3bdX03zFcaQyzZuNex8rxmcw6xdNIo/bCX/
         UOmz5Tv2iOOULyxVzpYce+cvx6w0ZfZGmSvFsbjOAJ8CGFOxLzeqPiTTyeqcs8gLVS/I
         9Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697846956; x=1698451756;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAAEOjN763/uoJltIk1A5v8Y5KhewbirWplELVB65Hg=;
        b=LJY2XBMl2y4Z5FmaYxydqTLosxLwJx3m8wQQCNwMbY7sH8kgMKBQJjL1wn/q4EyKFS
         Y3wMNc5uevS3VPJi2EGOsM0eqVaAN6ofiNNcoaXJ9Bm0Dk/uzC98PcNlcPC+u+Je1I7X
         eqC0zmcVw/Lcv0clOLbnIvLLUJww65jiNfUdBIbdVC3VeLVlf3T1y4ABX6OoMaGT7lVc
         Ftf3UlvxOadC0PM1HGAw+XfVvQR4MBpMe7no5fA8CvZ+T3w2OHDmHYOW3c+b1I5BjeF5
         qFItlmaQ4XGuTIb8TyBv/cJMC05bqpDYOHGdnJcT2xsp6eYamsG4KcJZtp430rjLCQqW
         GJSQ==
X-Gm-Message-State: AOJu0Yw4wzrC0z97KPzsMN8bp9LZjWM1/qG9/9omR0WwNSkCbNNIgONU
        Uq4iTsjWFKhYfFXpopVu8y6iq/en4QiVdoQMpw==
X-Google-Smtp-Source: AGHT+IFpzvvP/9vgkVU2kVoCF+uGskkvTbuaun/yXzswon2zQMJ9UpaTPtQnAg54Y5CT+D17i4Ceq6Ey02j9Tbzzvg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d252:0:b0:d9a:6658:1781 with SMTP
 id j79-20020a25d252000000b00d9a66581781mr67180ybg.10.1697846956675; Fri, 20
 Oct 2023 17:09:16 -0700 (PDT)
Date:   Sat, 21 Oct 2023 00:09:16 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKsWM2UC/x3NQQqDMBBA0avIrDuQxAq2VylFTDLqLBrDjA0V8
 e4NLt/m/wOUhEnh2RwgVFh5TRX21kBYxjQTcqwGZ1xrjTOom6SQd4zChURR8kdnLCwbr8OFwX8 VA0Y/2i76O/UPAzWXhSb+XavX+zz/bFkoD3oAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697846955; l=4664;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=KLFJyNnpM1iVE3WDYzVJJsiktCAThrMEX50yU5r+lYk=; b=e8EZde/IM2Lq6ijjTb85ST0CmHeBuSAs4OUmV50+qTd8PO+Az/pSH2VINMLGHg6qz1KlFbldz
 tk2ycf+PdWJB3PzOu2tAX06XZVnpTD5ejcZdyfi0K4KMoOEPiPt7joV
X-Mailer: b4 0.12.3
Message-ID: <20231021-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-v1-1-8abb919cbe24@google.com>
Subject: [PATCH] rpmsg: virtio: replace deprecated strncpy with strscpy/_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

This patch replaces 3 callsites of strncpy().

The first two populate the destination buffer `nsm.name` -- which we
expect to be NUL-terminated based on their use with format strings.

Firstly, as I understand it, virtio_rpmsg_announce_create() creates an
rpmsg_ns_msg and sends via:

virtio_rpmsg_bus.c:
336: err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);

... which uses:
virtio_rpmsg_sendto() -> rpmsg_send_offchannel_raw()

... which copies its data into an rpmsg_hdr `msg` in virtio_rpmsg_bus.c
618: memcpy(msg->data, data, len);

... and we end up receiving here via a callback:

rpmsg_ns.c:
30: /* invoked when a name service announcement arrives */
31: static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
32: 		       void *priv, u32 src)
33: {
34:         struct rpmsg_ns_msg *msg = data;
...
50:         /* don't trust the remote processor for null terminating the name */
51:         msg->name[RPMSG_NAME_SIZE - 1] = '\0';

... which finally leads into the use of `name` within a format string:
rpmsg_ns.c:
57: dev_info(dev, "%sing channel %s addr 0x%x\n",
58:          rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_NS_DESTROY ?
59:          "destroy" : "creat", msg->name, chinfo.dst);

Taking another look at this comment + NUL-byte assignment:
50: /* don't trust the remote processor for null terminating the name */
51: msg->name[RPMSG_NAME_SIZE - 1] = '\0';

...  we probably _can_ trust that this string is NUL-terminated with the
introduction of strscpy(). However, since there might be some magic
happening between the announcement create and the callback that I don't
understand, I've opted to leave this comment and assignment alone as it
doesn't hurt.

We can also observe that `nsm` is not zero-initialized and as such we
should maintain the NUL-padding behavior that strncpy() provides:

virtio_rpmsg_bus.c:
330: struct rpmsg_ns_msg nsm;

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

Now, for the third and final destination buffer rpdev->id.name we can
just go for strscpy() (not _pad()) as rpdev points to &vch->rpdev:
|       rpdev = &vch->rpdev;

... and vch is zero-allocated:
|       vch = kzalloc(sizeof(*vch), GFP_KERNEL);

... this renders any additional NUL-byte assignments (like the ones
strncpy() or strscpy_pad() does) redundant.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 905ac7910c98..dc87965f8164 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -329,7 +329,7 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
 		struct rpmsg_ns_msg nsm;
 
-		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
+		strscpy_pad(nsm.name, rpdev->id.name, sizeof(nsm.name));
 		nsm.addr = cpu_to_rpmsg32(rpdev, rpdev->ept->addr);
 		nsm.flags = cpu_to_rpmsg32(rpdev, RPMSG_NS_CREATE);
 
@@ -353,7 +353,7 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
 	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
 		struct rpmsg_ns_msg nsm;
 
-		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
+		strscpy_pad(nsm.name, rpdev->id.name, sizeof(nsm.name));
 		nsm.addr = cpu_to_rpmsg32(rpdev, rpdev->ept->addr);
 		nsm.flags = cpu_to_rpmsg32(rpdev, RPMSG_NS_DESTROY);
 
@@ -424,7 +424,7 @@ static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
 	 */
 	rpdev->announce = rpdev->src != RPMSG_ADDR_ANY;
 
-	strncpy(rpdev->id.name, chinfo->name, RPMSG_NAME_SIZE);
+	strscpy(rpdev->id.name, chinfo->name, sizeof(rpdev->id.name));
 
 	rpdev->dev.parent = &vrp->vdev->dev;
 	rpdev->dev.release = virtio_rpmsg_release_device;

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231020-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-dba15db4e890

Best regards,
--
Justin Stitt <justinstitt@google.com>

