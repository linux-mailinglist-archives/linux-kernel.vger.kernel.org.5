Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8AB7A71EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjITFWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjITFVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE61E5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5gOGqeDWHWvZ+ziHLozSXMYvhhLuHutHz+RvPyTIpZg=; b=l0DOFm8hWJVSTxdJSFhbJgmYaz
        9WN86N1TagNYlDWl0c9YVZIDmTB8u7tLsrwsu5qz1B88r6XtGhBnNtRTIWeBIiVerxDLOsvnspWEj
        x1WsvVX8S0lOWpQe5ZT5vx7AHlIE31ZLgJZ/kP0u/PJR0siINJNPSnr24apJ+UUbXKpTFpWMEaMve
        4Ko9fGmb3zTJ9oGsxW9m92zZ2cRUIWPjNKoTopMhmsb/pIcs+BE6ivvdF3SFdKT8r3g9nQkq1rTZ+
        g08nMwoXFcHbcs1R+1kWr5pkJ3/vvNdq/z/40h9/oRfihKClg2zZiJjN6cAFPSsEIIT+hsNIymphp
        SKQOJrxA==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipek-001tym-0Q;
        Wed, 20 Sep 2023 05:21:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 14/16] xtensa: boot: don't add include-dirs
Date:   Tue, 19 Sep 2023 22:21:37 -0700
Message-ID: <20230920052139.10570-15-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the -I<include-dir> options to prevent build warnings since there
is not boot/include directory:

cc1: warning: arch/xtensa/boot/include: No such file or directory [-Wmissing-include-dirs]

Fixes: 437374e9a950 ("restore arch/{ppc/xtensa}/boot cflags")
Fixes: 4bedea945451 ("xtensa: Architecture support for Tensilica Xtensa Part 2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/boot/Makefile |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -- a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -9,8 +9,7 @@
 
 
 # KBUILD_CFLAGS used when building rest of boot (takes effect recursively)
-KBUILD_CFLAGS	+= -fno-builtin -Iarch/$(ARCH)/boot/include
-HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
+KBUILD_CFLAGS	+= -fno-builtin
 
 subdir-y	:= lib
 targets		+= vmlinux.bin vmlinux.bin.gz
