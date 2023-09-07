Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED477973FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbjIGPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbjIGPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2701BFA;
        Thu,  7 Sep 2023 08:30:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 795081F893;
        Thu,  7 Sep 2023 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694076850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HvIYKMndiy2O//rAfImHIjA5JinGDuMthkWNJO8tSAE=;
        b=dVu2JJh7yaOY3KO15y15P2xGo+rQlLwdEsUXVbjxeD+OG6vEQutU2d+kpg2OwSYckqBUdo
        NeIP54Wrl0g6C7mzMC2iuHt8TDj87YHOqiaDX3vDxvs07y19jO4el8e/9mquPCOzGXE5q8
        V09/ANszk/cYozHJ5lUoHhPpMDZTIfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694076850;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HvIYKMndiy2O//rAfImHIjA5JinGDuMthkWNJO8tSAE=;
        b=o/eFein2w2VFC1VYfEDiQiQc44H1XZ9Ks83W8x+iJX3S/iu5ZjxKk1mj2RPq0vk8EaqH78
        skRnFsliyUf/TBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A6AE138FA;
        Thu,  7 Sep 2023 08:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GhMoEbKP+WT6JgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 07 Sep 2023 08:54:10 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/7] fbdev: Split off code for boot-up logo
Date:   Thu,  7 Sep 2023 10:51:59 +0200
Message-ID: <20230907085408.9354-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
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

v2:
	* unexport helpers in a separate patch
	* squash patches that set up fb_logo.c (Javier)

Thomas Zimmermann (7):
  fbdev/au1200fb: Do not display boot-up logo
  fbdev/mmp/mmpfb: Do not display boot-up logo
  fbdev/core: Fix style of code for boot-up logo
  fbdev/core: Unexport logo helpers
  fbdev/core: Move logo functions into separate source file
  fbdev/core: Remove empty internal helpers from fb_logo.c
  fbdev/core: Clean up include statements in fbmem.c

 drivers/video/fbdev/au1200fb.c         |   9 -
 drivers/video/fbdev/core/Makefile      |   2 +
 drivers/video/fbdev/core/fb_internal.h |  17 +
 drivers/video/fbdev/core/fb_logo.c     | 508 +++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.c       |   2 +
 drivers/video/fbdev/core/fbmem.c       | 542 +------------------------
 drivers/video/fbdev/mmp/fb/mmpfb.c     |   7 -
 include/linux/fb.h                     |   5 -
 8 files changed, 530 insertions(+), 562 deletions(-)
 create mode 100644 drivers/video/fbdev/core/fb_logo.c

-- 
2.42.0

