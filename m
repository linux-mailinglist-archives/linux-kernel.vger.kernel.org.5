Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C477570E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjHIK1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjHIK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:27:49 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBEF210C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:27:42 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 648B540E01A1;
        Wed,  9 Aug 2023 10:27:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 52PuPSpKsuIJ; Wed,  9 Aug 2023 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691576859; bh=sSG8SuLREEWpITGtVL2ale4erYRAEQ6yV/T4GIjhK/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrFhL/OLe16B3WTHoznti3hfzmMOwRm/Gw++gpceuIDHnsqGCBrnR8SWHnIQIU6wE
         9lBv9KuIVGsvKD7/HllTilBei0ztMA6N7n4GfecP+ZNXquihB7SAHDVyqKDIJ4kKac
         cbWmRO8pC5eB/4YLuoLELwyLHTvgCVdEWo8alCIRrIhu9VYOos0hrwnha7kCVouF+A
         rc7lD9QmvUMeBCr/wqzcOSevpjVhtpYBhNar/WGQpVXvzsR3uCNgyTFMldOfNeq00Y
         AOc6XnPTQslMXslTRCyG4vytQeLCGPMQYTwHlnQJCNZqGlbdT0HExm5lTQeichgdi8
         8ozmVULwuoUIs381Cgq3lr/uC9yg3IfGEhTp+rGYh/6kI25TPRCoPAj2yec9SV6hoe
         cvOdHuOs0dZsB8ceY6wnNP3Z0oIA/qOS8+QroBR7keJ+ojnK66wmm0TaTy1ABIPPJC
         nd97TbGO8+u48HxaxAmhH8YtQq3kVNcrPDuhXwzvEw/WZz4lOrjGtqkuN+1BXvEVr0
         41RxJm2qtoNinTWcKFGoQnhbWB67jOl5S0ZQuJ7GEBACPPedbMebYbY6Rd/s6G1wBj
         cYzwPzEFCoDGNgvQvcPjPxm27+ztGw/3+Vz4BrLrfuJGB8t2cqZv3ZuTcYk2mIJaxy
         VN/1M8mxzK51t0Q37vtfTgdY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1822C40E01A3;
        Wed,  9 Aug 2023 10:27:36 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] Documentation/srso: Document IBPB aspect and fix formatting
Date:   Wed,  9 Aug 2023 12:27:00 +0200
Message-ID: <20230809102700.29449-4-bp@alien8.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809102700.29449-1-bp@alien8.de>
References: <20230809102700.29449-1-bp@alien8.de>
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

Add a note about the dependency of the User->User mitigation on the
previous Spectre v2 IBPB selection.

Make the layout moar pretty.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/admin-guide/hw-vuln/srso.rst | 71 ++++++++++++++--------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/a=
dmin-guide/hw-vuln/srso.rst
index 32eb5e6db272..af59a9395662 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -42,42 +42,59 @@ The sysfs file showing SRSO mitigation status is:
=20
 The possible values in this file are:
=20
- - 'Not affected'               The processor is not vulnerable
+ * 'Not affected':
=20
- - 'Vulnerable: no microcode'   The processor is vulnerable, no
-                                microcode extending IBPB functionality
-                                to address the vulnerability has been
-                                applied.
+   The processor is not vulnerable
=20
- - 'Mitigation: microcode'      Extended IBPB functionality microcode
-                                patch has been applied. It does not
-                                address User->Kernel and Guest->Host
-                                transitions protection but it does
-                                address User->User and VM->VM attack
-                                vectors.
+ * 'Vulnerable: no microcode':
=20
-                                (spec_rstack_overflow=3Dmicrocode)
+   The processor is vulnerable, no microcode extending IBPB
+   functionality to address the vulnerability has been applied.
=20
- - 'Mitigation: safe RET'       Software-only mitigation. It complements
-                                the extended IBPB microcode patch
-                                functionality by addressing User->Kernel=
=20
-                                and Guest->Host transitions protection.
+ * 'Mitigation: microcode':
=20
-                                Selected by default or by
-                                spec_rstack_overflow=3Dsafe-ret
+   Extended IBPB functionality microcode patch has been applied. It does
+   not address User->Kernel and Guest->Host transitions protection but i=
t
+   does address User->User and VM->VM attack vectors.
=20
- - 'Mitigation: IBPB'           Similar protection as "safe RET" above
-                                but employs an IBPB barrier on privilege
-                                domain crossings (User->Kernel,
-                                Guest->Host).
+   Note that User->User mitigation is controlled by how the IBPB aspect =
in
+   the Spectre v2 mitigation is selected:
=20
-                                (spec_rstack_overflow=3Dibpb)
+    * conditional IBPB:
+
+      where each process can select whether it needs an IBPB issued
+      around it PR_SPEC_DISABLE/_ENABLE etc, see :doc:`spectre`
+
+    * strict:
+
+      i.e., always on - by supplying spectre_v2_user=3Don on the kernel
+      command line
+
+   (spec_rstack_overflow=3Dmicrocode)
+
+ * 'Mitigation: safe RET':
+
+   Software-only mitigation. It complements the extended IBPB microcode
+   patch functionality by addressing User->Kernel and Guest->Host
+   transitions protection.
+
+   Selected by default or by spec_rstack_overflow=3Dsafe-ret
+
+ * 'Mitigation: IBPB':
+
+   Similar protection as "safe RET" above but employs an IBPB barrier on
+   privilege domain crossings (User->Kernel, Guest->Host).
+
+  (spec_rstack_overflow=3Dibpb)
+
+ * 'Mitigation: IBPB on VMEXIT':
+
+   Mitigation addressing the cloud provider scenario - the Guest->Host
+   transitions only.
+
+   (spec_rstack_overflow=3Dibpb-vmexit)
=20
- - 'Mitigation: IBPB on VMEXIT' Mitigation addressing the cloud provider
-                                scenario - the Guest->Host transitions
-                                only.
=20
-                                (spec_rstack_overflow=3Dibpb-vmexit)
=20
 In order to exploit vulnerability, an attacker needs to:
=20
--=20
2.41.0

