Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8268F75D9D4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGVEu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjGVEtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC1F4683;
        Fri, 21 Jul 2023 21:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7595B60A4E;
        Sat, 22 Jul 2023 04:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC532C433C7;
        Sat, 22 Jul 2023 04:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001319;
        bh=lUV+hV9+Om7+zu7Ta7+cYxJn7GpO7yeT62vr+Z7xZLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYOnQB7LGmg6UQ7ATyc5uftAZKL+fpYqV41VkuWTsdYUh9V2Mc7FxbzKtA/qVshgI
         B3ljmZn6jRLhZ/XlfMVWcYSVyx2o5c4qTd9N32cQuV9I95ed+8u6FykKZKkihv+8S6
         AYsfV0td7uVd0VezHUy/wmq5BI65RhVxFGBXZJY8NZSU97cO9PqrybHCsK7Ms3rfO6
         wOPj5b9smmmlz0svNP8y/BOXJvoeA68U/0wCoRJJkH6N5jEfuXq8uaWsMnebmXyR99
         jJ8FDBInwRkw6In4widAxuK9TPsse2RTjzZMQ53eYai5ZmlF7H6dC0AWrYfY5QHvZk
         4p8u/5ySS1Uwg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 17/19] kbuild: rpm-pkg: build the kernel in-place for rpm-pkg
Date:   Sat, 22 Jul 2023 13:48:04 +0900
Message-Id: <20230722044806.3867434-17-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722044806.3867434-1-masahiroy@kernel.org>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, 'make rpm-pkg' always builds the kernel from the pristine
source tree in the ~/rpmbuild/BUILD/ directory.

Build the kernel incrementally just like 'make binrpm-pkg'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index be9602fa98da..bf2da97f29d0 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -72,6 +72,7 @@ PHONY += rpm-pkg
 rpm-pkg: srpm = $(shell rpmspec --srpm --query --queryformat='%{name}-%{VERSION}-%{RELEASE}.src.rpm' kernel.spec)
 rpm-pkg: srcrpm-pkg
 	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -rb $(srpm) \
+	--build-in-place --noprep \
 	--define='_smp_mflags %{nil}' --define='make $(MAKE)'
 
 # srcrpm-pkg
-- 
2.39.2

