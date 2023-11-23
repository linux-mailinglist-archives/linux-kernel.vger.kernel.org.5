Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842B27F5719
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbjKWDuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjKWDuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:50:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6401B6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:50:18 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so304539a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700711417; x=1701316217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGO4SfYo4kJMDR301LbewsEuTuF/QqwlGJ7a0/sCoJw=;
        b=C8iBIZvUMSPl3jQ9xplCVgmDfcnv1IR3iK5CryMb1jVuRC4G5yfqCLCwTK1ipEY1oQ
         zaRwF1JcBqPbW3m+toJstZWBGXcTYlgJP8CvKTPPsD+DAznB+PWyHY7hTNbdzkZsUg9m
         f4KuJYU69WF9IJCcX3IwC0vvnd5h1qgApvOgu9u7y8dJxDKOU14sGqEyk0MSSG1hCljB
         kAWxr/oiYkB7SYlKZufzikjrrCzxTmo/hnu4sz0sigdoh1SWJAyrFegazKLgcGxyknxc
         TgwpO2IZXJaNy7eVhKrraRLraE1fkt6zEE/2TpMIB4aZuw/tpfOwius6ROozWwTUQwiO
         0glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700711417; x=1701316217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGO4SfYo4kJMDR301LbewsEuTuF/QqwlGJ7a0/sCoJw=;
        b=xMagZ97PCr1NdiFLo45Z5xOjZ+LyMBc7JGReOQPPZXfR9Og4c+3fcRIKUEf5bcWlMh
         pIwx6WBdn/eRZns3xNkD7EEDKpAG6wzjRvBCujo+HP9g//Dsb1YtHPOPdmZzrqnNHopK
         YG3aWbck5cFhdC1xxr8L8KxhKGmuBENq9CJ5vxQj+5qq6NiAQ2Ab5LFaY43Fe/0p21zi
         hInXIuOh8bxBBH8hkhX3Spln3GWvaHBeuxadFh95WjGB1IgLu8g+cutVi1CpfGlNqTG2
         LlFh1B4IFe/YoiaKmJZ05CHjAtf3Vi/AeFQzAABUegCxWpdBmFDxQcriLpIdc4OSn5ab
         zhTw==
X-Gm-Message-State: AOJu0YyHoso1yQD3je5aHFLE4C2X+iUh9DH+mznEsNJ/i3JXNqYOCl+S
        DX4b01Ehs4AKwZMpgyz9JOI=
X-Google-Smtp-Source: AGHT+IFW9CzBH5jno+mlYTeCbOhiWYAmIUoGRB1IPf5CpkgVwzp63G3vwXDJldQPIJ5+T5233t4NfA==
X-Received: by 2002:a17:902:cec9:b0:1ca:e05a:93a2 with SMTP id d9-20020a170902cec900b001cae05a93a2mr4207492plg.32.1700711417461;
        Wed, 22 Nov 2023 19:50:17 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709026b0400b001b898595be7sm188293plk.291.2023.11.22.19.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 19:50:17 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] x86: Remove the unused bw parameter from the BUILDIO macro
Date:   Thu, 23 Nov 2023 11:49:11 +0800
Message-ID: <20231123034911.217791-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 1e8f93e18379 ("x86: Consolidate port I/O helpers") moved some
port I/O helpers to <asm/shared/io.h>, which caused the bw parameter in the
BUILDIO macro to be unused. Remove it.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 76238842406a..3814a9263d64 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -242,7 +242,7 @@ static inline void slow_down_io(void)
 
 #endif
 
-#define BUILDIO(bwl, bw, type)						\
+#define BUILDIO(bwl, type)						\
 static inline void out##bwl##_p(type value, u16 port)			\
 {									\
 	out##bwl(value, port);						\
@@ -288,9 +288,9 @@ static inline void ins##bwl(u16 port, void *addr, unsigned long count)	\
 	}								\
 }
 
-BUILDIO(b, b, u8)
-BUILDIO(w, w, u16)
-BUILDIO(l,  , u32)
+BUILDIO(b, u8)
+BUILDIO(w, u16)
+BUILDIO(l, u32)
 #undef BUILDIO
 
 #define inb_p inb_p
-- 
2.43.0

