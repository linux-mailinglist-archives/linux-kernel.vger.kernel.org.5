Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59D376F359
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjHCTSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjHCTSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:18:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC2C35BE;
        Thu,  3 Aug 2023 12:18:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76758b855edso114661785a.0;
        Thu, 03 Aug 2023 12:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691090319; x=1691695119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn6LA5zi+jJ8uMg/k1zD8LVyDKk8sr2d1EdjLuZgbUk=;
        b=lVwCNrhvJUgz2qvTclStLwRiLou7BWCen3WdwmijmaUWDNcEMjcIJqsp0GjikxGNzH
         v6U1IxbkSeyJ+N/SCWp7yrI3QODMrQRzuzF6Ljo2aFG6IylWrUj02yDidWEyht5JXu85
         8spILvAnS76WEGH0WfzMHtvsfKiNxxa+6ymre4QYiLL/qDJgh1Eqn7xlOG5XMalGU3NB
         clNOVKvO0uPM7ICVauhRL2tskGLFY5AJDCyEKtJ4wzPEl/lzvxk69C7KZFfcGFyWMhRT
         Hyrz2AkBNMe2h2IdQwsIvdCFl3gKH76c9VtNhR/0Md5DjAAL/ctefxtKgFv0wzMR/D2u
         nq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691090319; x=1691695119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cn6LA5zi+jJ8uMg/k1zD8LVyDKk8sr2d1EdjLuZgbUk=;
        b=KVwyseG4nJ0WMWJDGo1pCpQn29yznnSTBdmO3IPAAGoxUQxU7tUViaPublMtQn0x+t
         Txm/zGUUMEab3NT9ZOf/7f+M5cB+tTl5xXgPShigfbSkp24nq8PLrki064djTi6MOizx
         /U5kQyUlisrxyNDGLDbAgDxp1z7Q1W7sgUsbfYhfs3daAKfqjOl6Jxjhug5sSxGtP9Bb
         GzJhYyKlDOo+oG5chzGC+lcC1NF4+z5XyL7P5vrn0b8q2nOGu6H503MacSoKArJoWnfl
         xmPhZicROK4DNSULX19qhRv6KUicTVIqwgAUAFYFSAOvxsKcs0awWylqKEYzBAvWWWJK
         CAig==
X-Gm-Message-State: ABy/qLbEugcWMzQcw97cj0JqqYlKbwSWLrQ5NQ5+AhWGrPlbLsz8DzRZ
        BJMFemv3g82bNII9S5XKqHjF1Wkqs+k=
X-Google-Smtp-Source: APBJJlESw8lMtsxA24LFj9NOntuxQMkmaPyUBjtM3XmbQ2WMAmkT5wO2PSDyPabRhRa3p3o71LtNdw==
X-Received: by 2002:a05:620a:454b:b0:76c:a3bc:7fc2 with SMTP id u11-20020a05620a454b00b0076ca3bc7fc2mr21287793qkp.34.1691090319445;
        Thu, 03 Aug 2023 12:18:39 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id n20-20020a0ce494000000b0063762ab2f90sm108897qvl.83.2023.08.03.12.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:18:38 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev
Subject: [PATCH 4/4] arch/*/configs/*_defconfig cleanup: drop CONFIG_NFT_OBJREF
Date:   Thu,  3 Aug 2023 15:18:18 -0400
Message-ID: <20230803191821.36793-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230803191821.36793-1-twoerner@gmail.com>
References: <20230803191821.36793-1-twoerner@gmail.com>
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

Drop CONFIG_NFT_OBJREF as it was removed in commit d037abc2414b
("netfilter: nft_objref: make it builtin").

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/configs/omap2plus_defconfig       | 1 -
 arch/loongarch/configs/loongson3_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 98fbd16e17ce..b2f0862f4bd9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -98,7 +98,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 04665c517c74..4700655b2bcb 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -137,7 +137,6 @@ CONFIG_NFT_MASQ=m
 CONFIG_NFT_REDIR=m
 CONFIG_NFT_NAT=m
 CONFIG_NFT_TUNNEL=m
-CONFIG_NFT_OBJREF=m
 CONFIG_NFT_QUEUE=m
 CONFIG_NFT_QUOTA=m
 CONFIG_NFT_REJECT=m
-- 
2.41.0.327.gaa9166bcc0ba

