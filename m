Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0367C5A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjJKRwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJKRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:52:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72CB8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:52:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7178C433C8;
        Wed, 11 Oct 2023 17:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697046753;
        bh=0gxXft5Dmd/xRZK1WzgEBNDiWxqzsx2oS4+h+BmCYqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iy+wfx9x+yTJATOATcp98r5KNcZxUID/VRAgEhg+oe81hvpc1Dwk9xggv9a5qiagZ
         7YRFbZv07Wra1O2MF4XPLHZVXGdk1txr/5cqCO1S8XaNhagStHAF8CvJ6qNCx9Uxrv
         luTR6ZF4UQBwqIT0D8qYcIg0bEczzRqJJ8hTP/2o=
Date:   Wed, 11 Oct 2023 10:52:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] *: mark stuff as __ro_after_init
Message-Id: <20231011105211.3135013317249184bcc81982@linux-foundation.org>
In-Reply-To: <4f6bb9c0-abba-4ee4-a7aa-89265e886817@p183>
References: <4f6bb9c0-abba-4ee4-a7aa-89265e886817@p183>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 19:55:00 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> __read_mostly predates __ro_after_init. Many variables which are marked
> __read_mostly should have been __ro_after_init from day 1.
> 
> Also, mark some stuff as "const" and "__init" while I'm at it.

I did this:

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mark-stuff-as-__ro_after_init-fix
Date: Wed Oct 11 10:46:42 AM PDT 2023

revert sysctl_nr_open_min, sysctl_nr_open_max changes due to arm warning

arm allnoconfig:

fs/file_table.c:137:35: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  137 |                 .extra1         = &sysctl_nr_open_min,
      |                                   ^
fs/file_table.c:138:35: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  138 |                 .extra2         = &sysctl_nr_open_max,
      |                                   ^

Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/file.c            |    4 ++--
 include/linux/file.h |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/fs/file.c~mark-stuff-as-__ro_after_init-fix
+++ a/fs/file.c
@@ -25,10 +25,10 @@
 #include "internal.h"
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
-const unsigned int sysctl_nr_open_min = BITS_PER_LONG;
+unsigned int sysctl_nr_open_min = BITS_PER_LONG;
 /* our min() is unusable in constant expressions ;-/ */
 #define __const_min(x, y) ((x) < (y) ? (x) : (y))
-const unsigned int sysctl_nr_open_max =
+unsigned int sysctl_nr_open_max =
 	__const_min(INT_MAX, ~(size_t)0/sizeof(void *)) & -BITS_PER_LONG;
 
 static void __free_fdtable(struct fdtable *fdt)
--- a/include/linux/file.h~mark-stuff-as-__ro_after_init-fix
+++ a/include/linux/file.h
@@ -113,7 +113,6 @@ int receive_fd_replace(int new_fd, struc
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
 
-extern const unsigned int sysctl_nr_open_min;
-extern const unsigned int sysctl_nr_open_max;
+extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
 
 #endif /* __LINUX_FILE_H */
_

