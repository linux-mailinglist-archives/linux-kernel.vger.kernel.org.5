Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2697D288B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJWCb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjJWCb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:31:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D41D41
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:31:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3942461aso3643724276.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698028285; x=1698633085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i051oq9Sq7RRdnOZ5mTNUWUdMgsVYPFmVIteiDrh8b4=;
        b=u3qzpSbEXap2gGwunk6cD7S1RCS5jd4dtHS927yHWmoZZdZQm+i808y6n+rovcukoJ
         4s1XSvXwqfa22YHLllAPaB7fW6B084ecKrav0vCx6KNVl/LytxApxc04G+AKQMnzT7f4
         ZEALfrzGksOPSaehu+V9m8URwhbSidSPXcX34jVnfjuTJ0ATqn3k9J4y1aJ78Et6oJhc
         xveKrJiwyBxk8ynmGaPPdCUP214QaksNboVhdnbafkz2e/FRyoOUXJPPK5dORaE9wBZJ
         qcWtiDbbeKJHUfevqkKvq1voxPi47x9BUConHFLl2pxYpE1WBE6GZOdUR8ka9zbBlrKJ
         7pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698028285; x=1698633085;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i051oq9Sq7RRdnOZ5mTNUWUdMgsVYPFmVIteiDrh8b4=;
        b=LyP+1LeBYKh9q4SkqK9/WxNjPkO94B9ovswjkiStFVbtpucCyx+YTYIvrc5cAn0oDJ
         yD61yBd6OrMO7Z5qqFCJeOllGFw6s3EklroWgIwTbi64Z/eKM36oVKE5bKd6s2F69Ka2
         C7kP5e3D03BytCdGddxNqaycrZbPxinCky642AV/LVk8NAG0kWYZQTUhGI2R5Zctpmp1
         t6BmBIc+DBh3HSdainYa6DZjPw5cNyWH14TaxGm/AedR9U9Cg+2qBemta4WtygP0AQED
         K9WCvhwd8JQl1wvopJdt0PzJKJ7TEWUbucwyaVnYV/dTveiSIfTlMK3FmkUFQMaZxuHz
         PsUw==
X-Gm-Message-State: AOJu0YwKJ4mFVVVYjWkg/Xxl/1SHZVQsjYKR9RfxK8UrVriXIfmoclkw
        CxQO1owZKM/7+50STNNiR2oeioM3u9yHSDs=
X-Google-Smtp-Source: AGHT+IEDHKZ2WJeGWk0321vcZMf4DAg9fPUhtFHtJdXcej40bv7/okhqiWF2bcMvcq2G55IOELysT0o7SeVgSEg=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a25:3491:0:b0:d9a:3dac:6c1a with SMTP id
 b139-20020a253491000000b00d9a3dac6c1amr155361yba.11.1698028285033; Sun, 22
 Oct 2023 19:31:25 -0700 (PDT)
Date:   Mon, 23 Oct 2023 02:31:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231023023121.1464544-1-jsperbeck@google.com>
Subject: [PATCH] x86/kexec: set MIN_KERNEL_LOAD_ADDR to 0x01000000
From:   John Sperbeck <jsperbeck@google.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin " <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Zac Tang <zactang@google.com>, Cloud Hsu <cloudhsu@google.com>,
        linux-kernel@vger.kernel.org, John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The physical memory range that kexec selects for the compressed
bzimage target kernel, might not be where it runs from.  The
startup_64() code in head_64.S copies itself out of the way
before the decompression so it doesn't clobber itself.

If the start of the memory range selected by kexec is above
LOAD_PHYSICAL_ADDR (0x01000000 by default), then the copy remains
within the memory area.  But if the start is below this range,
then the copy will likely end up outside the range.

Usually, this will be harmless because not much memory is in use
at the time of the pre-decompression copy, so there is little
to accidentally clobber.  However, an unlucky choice for the
adress of the kernel and the initrd could put the initrd in harm's
way.  For example:

    0x00400000 - physical address for target kernel
    0x03ff8000 - physical address of seven-page initrd
    0x0302c000 - size of uncompressed kernel (about 50 Mbytes)

The decompressed kernel will span 0x01000000 through 0x0402c000,
which will overwrite the initrd.

If the kexec code restricts itself to physical addresses above
0x01000000, then the pre-decompression copy and the decompression
itself will stay within the bounds of the memory kexec selected
(unless a non-default value is used in the target kernel for
CONFIG_PHYSICAL_START, which will change LOAD_PHYSICAL_ADDR,
but that's probably unsolvable unless the target kernel were to
somehow communicate this to kexec).

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..d6bf6c13dab1 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -36,7 +36,7 @@
  */
 #define MIN_PURGATORY_ADDR	0x3000
 #define MIN_BOOTPARAM_ADDR	0x3000
-#define MIN_KERNEL_LOAD_ADDR	0x100000
+#define MIN_KERNEL_LOAD_ADDR	0x1000000
 #define MIN_INITRD_LOAD_ADDR	0x1000000
 
 /*
-- 
2.42.0.655.g421f12c284-goog

