Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D100E778A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjHKJ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbjHKJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:58:53 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EC3594
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:58:45 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61A4040E01A2;
        Fri, 11 Aug 2023 09:58:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YNJCMIl7mimu; Fri, 11 Aug 2023 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691747921; bh=pTJZp8CvSa7EAMihFPW4TbWTb6SjgsxGRtf+EHHuJD0=;
        h=From:To:Cc:Subject:Date:From;
        b=egQ0fIEIItFsEj0PFPkQlTogGMmspnGg/88gZDeB8PyX3zxNGQckeRbMC/jpHrUpa
         MR40rhHI7+BTy0UylRfSoayMnP8hbeUISD45SBcU2Q1mszh3bkqiV6sbG576GlBKch
         bMS1q8pVKjLro6M8K+1A0OPU/ep+WskUvQK4U0k57dbIZuP3L4hkf4/VMRXEEpqQKk
         KwFqsFgYyuDpgyVE21DFfJtEcroWna4eB1MBd9aiMwBp9vC7csXaVxZQGDpxHfoZ4m
         DNcUmetnlKhuE7kybNLU/aXDC8pTg+YgC8O27kvypdsDjNuIsLlkTDBQR+zAfFapDJ
         BBT58TOFuU5iJ/yg9l3aZq79byXEI5aUOgVQq0RSOmHBpWClW/XNzkToCrAZsHE4E5
         0A96MQxoPndF1dazq8dtsq13U2aVOzRMJDp1FgyyrJMjk4XYapIGCTi4lpaEFdieNO
         ONV10Gt5z4Cf9fDrw3AGk1wMgFy1on7k8ULZLZOezEz0q54b42cos4WNPFtE2bamAQ
         2T1HdffbBD5Gk3sraQ2LH3E2lp4BpYtL2D6GVNwOal40y6KmWCsQHeQGfu1EiN22tW
         R44euJ76kHjCK4eIX48MDn3B62TpFVjHDJA+YT9UtzLCwUUM5C5cTEjMrgM4w/1qIV
         ZihmZiNSkVxcRV5LgV7F98og=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53F9F40E01A1;
        Fri, 11 Aug 2023 09:58:39 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver core: cpu: Fix the fallback cpu_show_gds() name
Date:   Fri, 11 Aug 2023 11:58:31 +0200
Message-ID: <20230811095831.27513-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
X-Spam: Yes
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

In

  6524c798b727 ("driver core: cpu: Make cpu_show_not_affected() static")

I fat-fingered the name of cpu_show_gds(). Usually, I'd rebase but since
those are extraordinary embargoed times, the commit above was already
pulled into another tree so no no.

Therefore, fix it ontop.

Fixes: 6524c798b727 ("driver core: cpu: Make cpu_show_not_affected() stat=
ic")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/base/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index d7300d885822..fe6690ecf563 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -532,7 +532,7 @@ CPU_SHOW_VULN_FALLBACK(srbds);
 CPU_SHOW_VULN_FALLBACK(mmio_stale_data);
 CPU_SHOW_VULN_FALLBACK(retbleed);
 CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
-CPU_SHOW_VULN_FALLBACK(gather_data_sampling);
+CPU_SHOW_VULN_FALLBACK(gds);
=20
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -546,7 +546,7 @@ static DEVICE_ATTR(srbds, 0444, cpu_show_srbds, NULL)=
;
 static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL=
);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_over=
flow, NULL);
-static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gather_data_samp=
ling, NULL);
+static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
=20
 static struct attribute *cpu_root_vulnerabilities_attrs[] =3D {
 	&dev_attr_meltdown.attr,
--=20
2.42.0.rc0.25.ga82fb66fed25

