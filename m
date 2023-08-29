Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9C78C766
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjH2OVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbjH2OVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:21:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DBF1A3;
        Tue, 29 Aug 2023 07:21:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF1D821852;
        Tue, 29 Aug 2023 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693318888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oHxOxL/1egaGXDwHf1bGqXTPMgGpjhtV5fYRp+DeRzQ=;
        b=vG0N6gdK6Rr6aFpRFOs0d4GM+EMoR/nIkJZIvZxp0d9y/1ZrTZKNc66ovHOXjjcMolYuaJ
        EtdWzzis3s6HvsckwFy2eUCFugPH5V14j3yiIucxj2Xq/ixZGX0CYimaKSt1IhIxubFkeI
        Mof9NVLJEAhQ5SpPvC67Q/l6+lrGVoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693318888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oHxOxL/1egaGXDwHf1bGqXTPMgGpjhtV5fYRp+DeRzQ=;
        b=PxfSSy24/ZVMovXysk6HY6nuve7RlW/8QwrrW64wVMEUwnd5Zp7Ap8Vjlnf1GuYRj0IytX
        wb04wXyNpnu9eaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F7F4138E2;
        Tue, 29 Aug 2023 14:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HsL5Iej+7WREewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 29 Aug 2023 14:21:28 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/7] fbdev: Split off code for boot-up logo
Date:   Tue, 29 Aug 2023 16:15:39 +0200
Message-ID: <20230829142109.4521-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot-up logo is a feature of the fbcon console; with only a few
external callers. Move it from the core fbdev code into its own file.

Patches 1 and 2 remove the logo setup from fbdev drivers. The logo
requires a configured output, which is provided by the framebuffer
console. Drivers should not implement their own logo.

Patches 3 to 6 move the code for the boot-up logo into its own file
and add a number of simple cleanups. It's now separate from the core
fbdev code that maintains the display framebuffers.

Patch 7 then removes a number of unecessary include statements from
fbmem.c.

Thomas Zimmermann (7):
  fbdev/au1200fb: Do not display boot-up logo
  fbdev/mmp/mmpfb: Do not display boot-up logo
  fbdev/core: Fix style of code for boot-up logo
  fbdev/core: Move logo functions into separate source file
  fbdev/core: Build fb_logo iff CONFIG_LOGO has been selected
  fbdev/core: Remove empty internal helpers from fb_logo.c
  fbdev/core: Clean up include statements in fbmem.c

 drivers/video/fbdev/au1200fb.c         |   9 -
 drivers/video/fbdev/core/Makefile      |   2 +
 drivers/video/fbdev/core/fb_internal.h |  17 +
 drivers/video/fbdev/core/fb_logo.c     | 509 +++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.c       |   4 +
 drivers/video/fbdev/core/fbmem.c       | 542 +------------------------
 drivers/video/fbdev/mmp/fb/mmpfb.c     |   7 -
 include/linux/fb.h                     |   5 -
 8 files changed, 533 insertions(+), 562 deletions(-)
 create mode 100644 drivers/video/fbdev/core/fb_logo.c

-- 
2.41.0

