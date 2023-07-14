Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998E4754057
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjGNRRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjGNRRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC83599
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689355016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mf75CzVatbv3pQWH8r83ggHJgBXSpuprGf6QjemCQEc=;
        b=GootNOsfCV8n89rmaHzesx3XU02fGseHqTkmDYe34QPvfu9JXM2P4NCHo0WYogjwHmlkoz
        28RNZm4bABVg9Tudwplm7g/5+YDtUCzoIj1yibbQ7YqDxZa9kgkB+wEd+eClwq3h1Y/tfH
        TMDfmNg1bwdgBJFv6x/gShCPnerdnZU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-smVA7ZTNOCKP3HkrohivUw-1; Fri, 14 Jul 2023 13:16:54 -0400
X-MC-Unique: smVA7ZTNOCKP3HkrohivUw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3144bf68a03so1247553f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355013; x=1691947013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf75CzVatbv3pQWH8r83ggHJgBXSpuprGf6QjemCQEc=;
        b=dx4OXDl2GzaaiOHaywEoRW28SeEg9g2VBh5M0csmZ57qetw7thQc8Svjqw7Aq1iAp0
         PA5BLH+U/J8i+12FKWjU4bV5qg8qwrjuFifoOFXGJuscp1Cyn9+EsSDW1FfLNDu1274r
         g1jVRcAWwj1F7Ucb8H8F8XRpl3BKnoQLXqJwiVOO1TraH1GTZdt1LXO6oUFnTUQyIfiq
         VdBx9ZFs9NqVOZTodefpbnfZ+E6WbOtbHDB4yUvQISJkgkQXfVmqJYoCeDmTiDfbMTzX
         JrFMTvc8W7TtZ1UQpV3MVLXXDemF51XA8YtX81IJmcUc/QUSiAPQqBasgj2enL/trqpV
         FIZw==
X-Gm-Message-State: ABy/qLbIOL5T/Ak4+Ntli7d4gtmy072NgAwWgTQ75EnbCldu3IFUKLF/
        SR2j/4/9YP6MpiTZyb1WajS1ATjHmBaBGwLuh5BhPyZtz876DtLJAjchSOGiWGggO2yBvlEcMS8
        zn1RtVHc/M5qJENG/zIbd7NWK5Foh5Db9mefmUkVYL8jMAbtFq/H09E6wJMvRxUF1PSJDos/ttc
        Yv7De+M2U=
X-Received: by 2002:adf:e952:0:b0:30e:5bd0:21a2 with SMTP id m18-20020adfe952000000b0030e5bd021a2mr4555843wrn.52.1689355013439;
        Fri, 14 Jul 2023 10:16:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHHYMLvriZ/ew3fit58RdAJhlMPoyTBoUoDcI2u13QGKOg6uAz3m3L/7sXIDsUPeQ4e8DoUOA==
X-Received: by 2002:adf:e952:0:b0:30e:5bd0:21a2 with SMTP id m18-20020adfe952000000b0030e5bd021a2mr4555827wrn.52.1689355013182;
        Fri, 14 Jul 2023 10:16:53 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe891000000b003143cdc5949sm11620842wrm.9.2023.07.14.10.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:16:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Melissa Wen <mwen@igalia.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v5 1/4] video: Add auxiliary display drivers to Graphics support menu
Date:   Fri, 14 Jul 2023 19:16:29 +0200
Message-ID: <20230714171642.91185-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714171642.91185-1-javierm@redhat.com>
References: <20230714171642.91185-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
---

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

