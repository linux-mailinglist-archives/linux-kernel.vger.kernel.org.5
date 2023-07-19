Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC4759007
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGSIRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGSIQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA05171E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689754556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pl7rDesBC4To4uNjgzRPqO8NIm8bPxHEaiAgd1Bj9kg=;
        b=PfSa6n63zHE8uNzDWqdIszLbwAAWuipTPAHdMKmS5SispHpM2kYNzUdDFTqtgFOxUL3T3E
        3xTbB5/Zo1MIz3LudN3xAtbiZHVsW+rI110E4PUfg2mFrmQvyee8h4NzZBDKPG344UYFLJ
        wBgVMq1wiYEpEezBLL0qG+5Trv8UXD8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-qhygSuatNCWqqhMFycYFFA-1; Wed, 19 Jul 2023 04:15:55 -0400
X-MC-Unique: qhygSuatNCWqqhMFycYFFA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3143b999f6eso3821324f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754554; x=1690359354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pl7rDesBC4To4uNjgzRPqO8NIm8bPxHEaiAgd1Bj9kg=;
        b=I9M2kn3oBS8clLE9pNcc+qxFegiqnvlOpf0W0AjiCnthEv+PQ8SY1QH9KpYKv9lukF
         FHOaAbB2lchfPc+OV+KAID0tngg0gF4tjOa2k3LL2e9e1t0WmsjkSJhcyfZt9eN/nQpT
         6RUI6nVltUPO0pxelR3LYEvIYxpTnMQUXgvxcGha6uDUDgNAYWWArAiX2HSebLxaEBZC
         0UpWnhm22MorhWqI91e3IAMuKBfBsAao88k22K90Ypdg6UNM0mu6/ZB5yZhmnewcr0lj
         QZ2RDDOAOJWt2d69XBYPiloOs0KuyGDQXFUf6NdItEXMoeX5xYirh1mix36GvWzxuHAH
         /Udg==
X-Gm-Message-State: ABy/qLZNy3VuwqycnB9sSx6mCNUHz1p9B75j71E9g3F73mWCnjOleDRm
        qokkTxjpXgDZAj+wyBlCMORnceHofPqpDzDZ/0hWfbxANp+wvwlV/aKMmVhXnzLxewv3y8PKwru
        IOcJitcESZnryjuLzwXqZAVmqWBXPJNqEodCqyVHZIlc0iyRf3F2TeSdEezoI70nWUTTy/s1bpD
        OtSbX/xJY=
X-Received: by 2002:adf:f087:0:b0:314:4c78:8b84 with SMTP id n7-20020adff087000000b003144c788b84mr4142575wro.17.1689754554457;
        Wed, 19 Jul 2023 01:15:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpqnqhnG2ZCWh/0oWIuDm9np5hx9FVZp0cyJdayt5CqHwUybqL7yFTlLi+cxoPwsgimsvCTw==
X-Received: by 2002:adf:f087:0:b0:314:4c78:8b84 with SMTP id n7-20020adff087000000b003144c788b84mr4142546wro.17.1689754554100;
        Wed, 19 Jul 2023 01:15:54 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d5385000000b0031423a8f4f7sm4574354wrv.56.2023.07.19.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:15:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v6 1/4] video: Add auxiliary display drivers to Graphics support menu
Date:   Wed, 19 Jul 2023 10:15:35 +0200
Message-ID: <20230719081544.741051-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719081544.741051-1-javierm@redhat.com>
References: <20230719081544.741051-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers in this subsystem are for character-based LCD displays, which
can fall into the same category of the DRM/KMS and fbdev drivers that are
located under the "Graphics support" menu. Add auxdisplay there as well.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Arnd Bergmann <arnd@arndb.de>
---

(no changes since v5)

Changes in v5:
- Take the auxdisplay/Kconfig source out of "if HAS_IOMEM" (Geert Uytterhoeven).

 drivers/Kconfig       | 2 --
 drivers/video/Kconfig | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 514ae6b24cb2..496ca02ee18f 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -129,8 +129,6 @@ source "drivers/dma-buf/Kconfig"
 
 source "drivers/dca/Kconfig"
 
-source "drivers/auxdisplay/Kconfig"
-
 source "drivers/uio/Kconfig"
 
 source "drivers/vfio/Kconfig"
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8b2b9ac37c3d..e5b1cc54cafa 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -25,6 +25,8 @@ config VIDEO_NOMODESET
 	bool
 	default n
 
+source "drivers/auxdisplay/Kconfig"
+
 if HAS_IOMEM
 
 config HAVE_FB_ATMEL
-- 
2.41.0

