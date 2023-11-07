Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2A7E34F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjKGFnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjKGFnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:43:31 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D79183
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 21:43:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso15482175ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 21:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699335806; x=1699940606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjE6MRKZln7VtAWqDMH/BbdtqTCVNkHO+jOGQ3GR3ng=;
        b=AX+8NgmU7EGW2biZfrlJxeZp8VMxDKSeGVbWLHTYnTnM1b6ZtQE93s5J1qj3PLOgqB
         areCL5KyCLbo9h8ZKMhp+LdXPNhCCzY5b3k5nBbo19a32td8X8qfi4XnRMvqR4zXTlOA
         fHHbgyJoS6MRTD5HEJUXXyDWvu/7XcREV5iPy1YAyuqRmJOlGu3QGxRaTQklwfzTNZ5x
         3EEza5TZwOv3R5T8jNG3ide1/X5V1X0neOE4q1cxK/OkR9zdTTMHUiS48uxzrLwVRtu7
         /afV0RRejtTTY0CJaH7YG4ZNJXijKyVL7w5RQWD4UPLvX4cyqogvu0YwNCsnJYc7vE06
         JG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699335806; x=1699940606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjE6MRKZln7VtAWqDMH/BbdtqTCVNkHO+jOGQ3GR3ng=;
        b=Q7xE1CtAF9pzgDFwggqrwr/RszVG0d7pKm/mhGpHTrJmEE+ebWWhw06mlAEMIGQ0SF
         n/M4/JRz37gJG1vfx/cIhNQcm8SFV2S61zer29pry3C0PrWkzJHZ3WJAs/N8yFI5hzd2
         3EyM94poVBbH74HQeL5n3ZxSPK6jtdHVETfMUFFkj3tSRHgCR29fGUY2sg15jKgkr5Ac
         pwJS8nlqVGpaYOsYWfzvoD4qoO+eURpG7bh6FLVKpcNmrgYf1Ql8P6al00g+Xbv+3p2G
         OtqIXJALVFDgRO604hk6Q3RcB9HhMcOhKZhN5H6Y1lDs5aRiLknQWoSiDSi2omz5KeuA
         7qhA==
X-Gm-Message-State: AOJu0YyjhADHe+bFmNk18ETS2ZQp91rNPfQkZoWLn0l04/KPm6+EqLJ/
        0VyPSRKHwi+UuAK7CSBpKnE8qGeMl6Zb/nlLPXA=
X-Google-Smtp-Source: AGHT+IH+Gm91nZYVteceVDahZxIliP0ESJuCzAMIRZ4I3uVN7mWTtDK4uUS3eOsCi7L5bJHUkClfBA==
X-Received: by 2002:a17:902:d50d:b0:1cc:3875:e654 with SMTP id b13-20020a170902d50d00b001cc3875e654mr24828909plg.26.1699335806334;
        Mon, 06 Nov 2023 21:43:26 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001cc530c495asm6752053pld.113.2023.11.06.21.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 21:43:25 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
Subject: [PATCH v10 5/5] efivarfs: force RO when remounting if SetVariable is not supported
Date:   Tue,  7 Nov 2023 14:40:56 +0900
Message-Id: <20231107054057.1893-6-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107054057.1893-1-masahisa.kojima@linaro.org>
References: <20231107054057.1893-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

If SetVariable at runtime is not supported by the firmware we never assign
a callback for that function. At the same time mount the efivarfs as
RO so no one can call that.  However, we never check the permission flags
when someone remounts the filesystem as RW. As a result this leads to a
crash looking like this:

$ mount -o remount,rw /sys/firmware/efi/efivars
$ efi-updatevar -f PK.auth PK

[  303.279166] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  303.280482] Mem abort info:
[  303.280854]   ESR = 0x0000000086000004
[  303.281338]   EC = 0x21: IABT (current EL), IL = 32 bits
[  303.282016]   SET = 0, FnV = 0
[  303.282414]   EA = 0, S1PTW = 0
[  303.282821]   FSC = 0x04: level 0 translation fault
[  303.283771] user pgtable: 4k pages, 48-bit VAs, pgdp=000000004258c000
[  303.284913] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  303.286076] Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
[  303.286936] Modules linked in: qrtr tpm_tis tpm_tis_core crct10dif_ce arm_smccc_trng rng_core drm fuse ip_tables x_tables ipv6
[  303.288586] CPU: 1 PID: 755 Comm: efi-updatevar Not tainted 6.3.0-rc1-00108-gc7d0c4695c68 #1
[  303.289748] Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.04-00627-g88336918701d 04/01/2023
[  303.291150] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  303.292123] pc : 0x0
[  303.292443] lr : efivar_set_variable_locked+0x74/0xec
[  303.293156] sp : ffff800008673c10
[  303.293619] x29: ffff800008673c10 x28: ffff0000037e8000 x27: 0000000000000000
[  303.294592] x26: 0000000000000800 x25: ffff000002467400 x24: 0000000000000027
[  303.295572] x23: ffffd49ea9832000 x22: ffff0000020c9800 x21: ffff000002467000
[  303.296566] x20: 0000000000000001 x19: 00000000000007fc x18: 0000000000000000
[  303.297531] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaac807ab54
[  303.298495] x14: ed37489f673633c0 x13: 71c45c606de13f80 x12: 47464259e219acf4
[  303.299453] x11: ffff000002af7b01 x10: 0000000000000003 x9 : 0000000000000002
[  303.300431] x8 : 0000000000000010 x7 : ffffd49ea8973230 x6 : 0000000000a85201
[  303.301412] x5 : 0000000000000000 x4 : ffff0000020c9800 x3 : 00000000000007fc
[  303.302370] x2 : 0000000000000027 x1 : ffff000002467400 x0 : ffff000002467000
[  303.303341] Call trace:
[  303.303679]  0x0
[  303.303938]  efivar_entry_set_get_size+0x98/0x16c
[  303.304585]  efivarfs_file_write+0xd0/0x1a4
[  303.305148]  vfs_write+0xc4/0x2e4
[  303.305601]  ksys_write+0x70/0x104
[  303.306073]  __arm64_sys_write+0x1c/0x28
[  303.306622]  invoke_syscall+0x48/0x114
[  303.307156]  el0_svc_common.constprop.0+0x44/0xec
[  303.307803]  do_el0_svc+0x38/0x98
[  303.308268]  el0_svc+0x2c/0x84
[  303.308702]  el0t_64_sync_handler+0xf4/0x120
[  303.309293]  el0t_64_sync+0x190/0x194
[  303.309794] Code: ???????? ???????? ???????? ???????? (????????)
[  303.310612] ---[ end trace 0000000000000000 ]---

Fix this by adding a .reconfigure() function to the fs operations which
we can use to check the requested flags and deny anything that's not RO
if the firmware doesn't implement SetVariable at runtime.

Fixes: f88814cc2578 ("efi/efivars: Expose RT service availability via efivars abstraction")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 fs/efivarfs/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 5751413d124c..2b71e5106d13 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -16,6 +16,7 @@
 #include <linux/magic.h>
 #include <linux/statfs.h>
 #include <linux/notifier.h>
+#include <linux/printk.h>
 
 #include "internal.h"
 
@@ -356,9 +357,20 @@ static int efivarfs_get_tree(struct fs_context *fc)
 	return get_tree_single(fc, efivarfs_fill_super);
 }
 
+static int efivarfs_reconfigure(struct fs_context *fc)
+{
+	if (!efivar_supports_writes() && !(fc->sb_flags & SB_RDONLY)) {
+		pr_err("Firmware does not support SetVariableRT. Can not remount with rw\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
 	.parse_param	= efivarfs_parse_param,
+	.reconfigure	= efivarfs_reconfigure,
 };
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
-- 
2.39.2

