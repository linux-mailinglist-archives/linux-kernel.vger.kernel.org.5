Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7453D7E0C3B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjKCXeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKCXeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:34:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CB9E3;
        Fri,  3 Nov 2023 16:34:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39B91C433C7;
        Fri,  3 Nov 2023 23:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699054441;
        bh=BlDHKJ8MfuP1syUXuj+F9v0M+e2vkRXHkcoaDgJdNOY=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=L7Vq9hxdy9X4SJeQ3HdjBdrgBfG+nIv6yQeBW/MV2Jm3Vb+ymvqEI7lZJ3rJ3wZq3
         AmcX6RClTFsH/slsJwKv21XfoCc7ihDG7WpvN4nJcPSPrpEwQlthG+NPGrlhXTpxaV
         G5seE6/1enrLwv2P4xH7scFgpVLSEXxO5U1RzhhUiz50ZOK+2El/wYaorqJqSiji1E
         bOa4XAbeYNJqKtGBSjbJG5o4vjCb0JWkn/QEUqfjXaQn9Av4kLhC69aCLRPMkr5ClA
         XEkBJFbv/9HKvvvRT4E1AqmyoEDX1aRwZimiw/FwamOmtX3fU7G9DJ4Zs2O89QvdZA
         GGnS58hEuvPVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 15F81C4332F;
        Fri,  3 Nov 2023 23:34:01 +0000 (UTC)
From:   Davide Cavalca via B4 Relay <devnull+dcavalca.meta.com@kernel.org>
Date:   Fri, 03 Nov 2023 23:33:42 +0000
Subject: [PATCH] rpm-pkg: simplify installkernel %post
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-rpmpost-v1-1-9c18afab47f4@meta.com>
X-B4-Tracking: v=1; b=H4sIAFWDRWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwNj3aKC3IL84hLdNNNkS0tTUyNLQ8s0JaDqgqLUtMwKsEnRsbW1AG7
 r41lZAAAA
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davide Cavalca <dcavalca@meta.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699054440; l=1637;
 i=dcavalca@meta.com; s=20231103; h=from:subject:message-id;
 bh=X5JC+W01uXiyXPVwSIF965qjWZWJ67z2pjY23Aa3nRA=;
 b=P/fwUPABI1VqrtkXrn3F4SbHZSLLxC/fFwBtcokkm2L/H4YTgu3ESNj4oYbXwAiF1LqOCDRrJ
 j9Hs9PSf7MaBETvJfqIJnlqTUHIMjYvwf+QJgK6vs4El3C26IFbFvpL
X-Developer-Key: i=dcavalca@meta.com; a=ed25519;
 pk=9b8tquSs5okUyZ8q4DQqRfT95N/++7b/GgqRBdqUDBU=
X-Endpoint-Received: by B4 Relay for dcavalca@meta.com/20231103 with auth_id=95
X-Original-From: Davide Cavalca <dcavalca@meta.com>
Reply-To: <dcavalca@meta.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Cavalca <dcavalca@meta.com>

The %post currently does a shuffling dance before calling installkernel.
This isn't actually necessary afaict, and the current implementation
ends up triggering downstream issues such as
https://github.com/systemd/systemd/issues/29568

This commit simplifies the logic to remove the shuffling. For reference,
the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
section to create initramfs and grub hooks").

Signed-off-by: Davide Cavalca <dcavalca@meta.com>
---
 scripts/package/kernel.spec | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 3eee0143e0c5..cc4292c03ea2 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -77,11 +77,7 @@ rm -rf %{buildroot}
 
 %post
 if [ -x /sbin/installkernel -a -r /boot/vmlinuz-%{KERNELRELEASE} -a -r /boot/System.map-%{KERNELRELEASE} ]; then
-cp /boot/vmlinuz-%{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm
-cp /boot/System.map-%{KERNELRELEASE} /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
-/sbin/installkernel %{KERNELRELEASE} /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
-rm -f /boot/.vmlinuz-%{KERNELRELEASE}-rpm /boot/.System.map-%{KERNELRELEASE}-rpm
+/sbin/installkernel %{KERNELRELEASE} /boot/vmlinuz-%{KERNELRELEASE} /boot/System.map-%{KERNELRELEASE}
 fi
 
 %preun

---
base-commit: e392ea4d4d00880bf94550151b1ace4f88a4b17a
change-id: 20231103-rpmpost-f5c99552919f

Best regards,
-- 
Davide Cavalca <dcavalca@meta.com>

