Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBB07E95AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjKMDo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjKMDo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:44:26 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E82D1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:44:23 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4ac4cd60370so1848288e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699847062; x=1700451862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48Iu1w7OYQwIayu8Jx3+JPx7265SInmYaxh77kvRm6I=;
        b=ij6+Rm1QPLif1BIMiuQGGjCUc9AtqZEHcxhBIhID6GT4nd0JpJCkQQhLyMqjD+BLFN
         6XyhjdMpYgsHriRoGI+GDhd8bcqlRCKfCBNELefAUl6lfmpKpl2jahXaNH43Epbm6Bnq
         GdbdjtBvhjgkxBXs6gFk/0b5TgQWcnJpoKbdGUlkwkVlwbpdE7dMZCc10Ol+VwIHzzF3
         g4NW0ik2URodVQWlBFBlUxlGijBeluUCKRIgACY1ba6ryJtQ0+vwq1TPbOOrm8KRzZu3
         mxRLzmfGLjhcN8adqHSp2a2XsItYosUsh5IdW53XHBCSvbf33qBx4tNW4IxV0CPRT8Tg
         T3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699847062; x=1700451862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48Iu1w7OYQwIayu8Jx3+JPx7265SInmYaxh77kvRm6I=;
        b=r/WqUYfIKNhel0Wi18tcZIinVWqKn5ZY9CK4SSmm8c26wFgdNVcF8tsTL8TTDbe7xR
         3uW34tdIJVd9DoeYbh+5VeY1xZKVtR7Irxsl0wJ5mMoo/dvmXNc57GNw9+miWEqeYIH0
         9XFXwbp6kY+KCKcqmdatW53ROJC+47rXUi4EqO3T4NqxnJlqydLNppkEbMC5tFTIruWG
         6qoeb7zFs40ERNlTZkuQ5K44MQln9AKN8k/OmDHjnWA1+ByXeAqAxytR22uz09F9OUWI
         d1S1X5nv6GybjlPnikhza4ccUS+T2GCbPajwTFjnfCD9D+H/c4OUhEn4J2jdc8mGRxjq
         b/Qg==
X-Gm-Message-State: AOJu0YwYjquntp6SBtbb7qR7VkvieB4DsT7Yc/CMRg88CVX38TK6YQCj
        u36xOGff/HntcFdgNTEB/VE=
X-Google-Smtp-Source: AGHT+IHq1n8X8+IEnFifaPzZWCJXiigLf0tO99hZvXxJjKCPB7z4aJwQNS190yJF6dTuK70BEhAfWg==
X-Received: by 2002:a05:6122:1055:b0:495:c10c:ec39 with SMTP id z21-20020a056122105500b00495c10cec39mr4911611vkn.2.1699847062482;
        Sun, 12 Nov 2023 19:44:22 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id bu19-20020a056122239300b0049a9ad3336dsm823729vkb.25.2023.11.12.19.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 19:44:22 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>, Baoquan He <bhe@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86/setup: Make relocated_ramdisk a local variable of relocate_initrd()
Date:   Mon, 13 Nov 2023 11:40:26 +0800
Message-ID: <20231113034026.130679-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 0b62f6cb0773 ("x86/microcode/32: Move early loading after
paging enable"), the global variable relocated_ramdisk is no longer used
anywhere except for the relocate_initrd() function. Make it a local
variable of that function.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/include/asm/setup.h | 2 --
 arch/x86/kernel/setup.c      | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index bf483fcb4e57..5c83729c8e71 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -31,8 +31,6 @@
 #include <asm/bootparam.h>
 #include <asm/x86_init.h>
 
-extern u64 relocated_ramdisk;
-
 /* Interrupt control for vSMPowered x86_64 systems */
 #ifdef CONFIG_X86_64
 void vsmp_init(void);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1526747bedf2..ec2c21a1844e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -226,8 +226,6 @@ static void __init reserve_brk(void)
 	_brk_start = 0;
 }
 
-u64 relocated_ramdisk;
-
 #ifdef CONFIG_BLK_DEV_INITRD
 
 static u64 __init get_ramdisk_image(void)
@@ -261,7 +259,7 @@ static void __init relocate_initrd(void)
 	u64 area_size     = PAGE_ALIGN(ramdisk_size);
 
 	/* We need to move the initrd down into directly mapped mem */
-	relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
+	u64 relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
 						      PFN_PHYS(max_pfn_mapped));
 	if (!relocated_ramdisk)
 		panic("Cannot find place for new RAMDISK of size %lld\n",
-- 
2.42.1

