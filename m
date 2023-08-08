Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9A774B1F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjHHUlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjHHUk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:40:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CA146B9;
        Tue,  8 Aug 2023 13:12:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-307d58b3efbso4665694f8f.0;
        Tue, 08 Aug 2023 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691525525; x=1692130325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTKjeSdXeNLUVbHpZpaI+0otxc5jI/cV2lsa+kaijXI=;
        b=gGfPMZAyUzn4eRSNEtWO9UXo0D1Aw6jZ+nKryC0dAMuc8u6wBBo0eeOcrADx6fUkll
         M1sL0Mf9f3CN0+anjB7mumxHL7QT993mviPz/0EC26f0mQu6T4vj7BgtsPDBIbmduA6j
         K1y2UPFgQ11/+8GfsjTcXyNdorTwhGz1O8DJsvF0iflkXkgwKJlZbpZRRKr9/6+z+ogP
         gMjF/t3fgtHk1Yterrb6ZDqPVnDy8b+BoIdhKp9G9HSOv0FosvhHRgNAAPavWpU+yq4R
         eUMBTMCuYqn0CxR95jqLu2UvxAVXaANi9G5+24oO2WeilcTrqgTJi/oMEzblL4kq8iKT
         EgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525525; x=1692130325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTKjeSdXeNLUVbHpZpaI+0otxc5jI/cV2lsa+kaijXI=;
        b=eIDYv2xWlYjhaZOzvDY0JrE7dDrM9Tr1lNZoNtLCPuGHMcqE1Dro8h0XJBgvpqBL7i
         pH+kkYPchdtWUop2rmGSqW2/24waVLfe+VAVjX8E8Lwq731pbINFXX9pFk26gq+6L9yM
         utB/fimqesQ6lmXYkYW16Np4rRYsX5dpW+D7UpdgQS27tnUZlJi+5cIVpPe9YrZpzFbY
         7YtDXGxtgZCS6liJI+klKjwlmzSezEI5XfzY53601knIfnJ9JrmN0A0IH+VJ8BEAJhyb
         JijoFCxuB99dU40zdTgS7TpzpOZxA6PICsZxV/BLGbpJHZ05bJCwQID1i7JMg6NxbnD2
         rBoA==
X-Gm-Message-State: AOJu0Yz6CC6KXnIU8cnB0ruTVOIgOxeAQ/NYSdD44YNlIxrQi0k3s6F4
        dX/O9LadycY4OgI80aBzdq8=
X-Google-Smtp-Source: AGHT+IHSFsB+PJqEIEWPmewue88hEkwpFNUyrLVFd1aweDslbMbifQibxZD79shizKSd2tQQpG0hDg==
X-Received: by 2002:adf:db4d:0:b0:317:5b99:d3d8 with SMTP id f13-20020adfdb4d000000b003175b99d3d8mr374051wrj.20.1691525524933;
        Tue, 08 Aug 2023 13:12:04 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id c17-20020adfe711000000b00317afc7949csm14452247wrm.50.2023.08.08.13.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:12:04 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH] TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig
Date:   Tue,  8 Aug 2023 22:11:12 +0200
Message-ID: <20230808201115.23993-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarifies that the LEGACY_TIOCSTI setting is safe to turn off even
when running BRLTTY, as it was introduced in commit 690c8b804ad2
("TIOCSTI: always enable for CAP_SYS_ADMIN").

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 drivers/tty/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 341abaed4ce..069de553127 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -164,6 +164,9 @@ config LEGACY_TIOCSTI
 	  userspace depends on this functionality to continue operating
 	  normally.
 
+	  Processes which run with CAP_SYS_ADMIN, such as BRLTTY, can
+	  use TIOCSTI even when this is set to N.
+
 	  This functionality can be changed at runtime with the
 	  dev.tty.legacy_tiocsti sysctl. This configuration option sets
 	  the default value of the sysctl.
-- 
2.41.0

