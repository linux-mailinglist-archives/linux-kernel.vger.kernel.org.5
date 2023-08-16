Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01B677DE11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbjHPKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbjHPKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:02:40 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580EEC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:02:39 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A07FA40E0196;
        Wed, 16 Aug 2023 10:02:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BQ9N2dWi0aiA; Wed, 16 Aug 2023 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692180154; bh=Cys/IyeqTrL4SPpTDB0UXFPjUx1lfw4Hf5gKLKoX6E0=;
        h=From:To:Cc:Subject:Date:From;
        b=IP3hNbkpdQTOTuJaSingsntPAxBgC5WsTB1KogG9K0UfIpxs9FBFiGjoJJL72QJUP
         5QQJUAo84iII8ryeeD2cZEOB6f91pl8HsWWaL9i7mzP0vu9C/3hM1v42l+ZK7XkW8H
         PV4VLqY16GFNiYsVDY0mngKM+7Mbj66M3y3z8uIyZycbG0+fxKydDBt/q4KM96rGnA
         nVBFbTaRRqU1lwA2oU6GMkqWdwvCOU+BuvtdY70+qH9SDmq2ZARCHmwGOCLBDEpwl1
         CghAq9dEIL3CkR25jaVYpWqIkvIdzcuyB/9Kp1wg65vEPFQDy9nPWqxx7V9TMVwG+s
         6d6bRrXOYAQ8zpCvuCHz0jk8Xfy1JtZxMolCH7mh6zFNl4OOOnV+XF2AGwXbL1VJYz
         IdhyPuseZD70fXAEh6JJiSL4EvC1QqJ9Ve0QkSGvR/QY7D2fsPE8KxBeNlhkl5fC3X
         A7hkz7/aNeNyWWhYGnP0YE/5npHOvO+dtr5jCbf/K4LaRJzDsjoJAFQlwhiXtLiYnA
         +Co8qwPz7jJrgraNBngPZZvxB7gS+9oX4YDOOqp2dZ95Wk2vuexiv3C9zWqI61bxKv
         yu4PxIiO5x0G4ZXpy45jS8i2g6Byx4uwMeORXCdwGvgRhLURYIBEhDZu/FOVkgSgjo
         xvM+DS/ylp1WTU4yiLvTmDLo=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A22A40E0193;
        Wed, 16 Aug 2023 10:02:31 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib/earlycpio: Mark find_cpio_data() __no_stack_protector
Date:   Wed, 16 Aug 2023 12:02:21 +0200
Message-ID: <20230816100221.12209-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

find_cpio_data() is called by the 32-bit x86 microcode loader while
paging is not yet enabled and the CPU is running off physical addresses.
However, when stack protector is enabled, the compiler adds the stack
protection check for this function:

  c1846480 <find_cpio_data>:
  c1846480:       55                      push   %ebp
  c1846481:       89 e5                   mov    %esp,%ebp
  c1846483:       57                      push   %edi
  ...

  c1846676:       e9 85 fe ff ff          jmp    c1846500 <find_cpio_data=
+0x80>
  c184667b:       e8 20 9e 02 00          call   c18704a0 <__stack_chk_fa=
il>

which cannot work yet.

Prevent that from happening.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 lib/earlycpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/earlycpio.c b/lib/earlycpio.c
index d2c37d64fd0c..d3efe707c3f7 100644
--- a/lib/earlycpio.c
+++ b/lib/earlycpio.c
@@ -56,8 +56,8 @@ enum cpio_fields {
  *              the match returned an empty filename string.
  */
=20
-struct cpio_data find_cpio_data(const char *path, void *data,
-				size_t len,  long *nextoff)
+struct cpio_data __no_stack_protector find_cpio_data(const char *path, v=
oid *data,
+						     size_t len,  long *nextoff)
 {
 	const size_t cpio_header_len =3D 8*C_NFIELDS - 2;
 	struct cpio_data cd =3D { NULL, 0, "" };
--=20
2.42.0.rc0.25.ga82fb66fed25

