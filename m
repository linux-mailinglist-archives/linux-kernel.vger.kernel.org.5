Return-Path: <linux-kernel+bounces-30279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729A831C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E323A1F2B432
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D12C87D;
	Thu, 18 Jan 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwDvU6AG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853EA2C85A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591542; cv=none; b=UUQffHGjDzUPiT0KWgp/TjztXiv/MR7iTMiRK8jxibe/Eq+Wi9M23+08OQujhnNWc3WqSsYilr6+JkUZa/3kG0+yKUEPDKu4PwGkuX+Jh1NG3KF1w8WZeS+Yl/2N5QfykQDHKHfYxDlUkvK7VzyE9nlASgIJp0dMFePR5mPcCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591542; c=relaxed/simple;
	bh=KMC85DRJZdm++lhsdhn7YzII9zgUNTcuLEE91FWfuxY=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=kw6HVHgwzId0WkgcXlQcbbMO0MNXs6wt1cONn+hL3/Br6rQRaw+sdEGoIXeSg83gaZ9tQnmmZLIgycvscYr3n/1W30bPGe+qlGP9i0d78lJkMcaWS3ndSiMo1ybhabgfu8S6SsRRil/YR0a6iyQn8Q2bhVgZY8ng8EsdeMBrLg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwDvU6AG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FBECC43399;
	Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705591542;
	bh=KMC85DRJZdm++lhsdhn7YzII9zgUNTcuLEE91FWfuxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pwDvU6AGkVF9wFYcfG21kt7NpsY/SxrK2Iy/JqQlL9ljLEqUd1S4U+pj+6uCewKGu
	 GysB9boz39chxyFuf3lfTPbHXDEcEtGqqXRR2O+K5kr0C63gYHV6mh8nnahiFw9J+N
	 xTQ4FkQL/UwZe3IwYQQprGYkozRRC7X/1KkR9Rm0l/YAQ+hIr32sUOwJsh61Zi3mla
	 XYDb7NKgjiUK9MsjVhRU8Z5ED403xSDQYMzLNGZnbRjc+ChN1KJveP8+NV3wzsExZ9
	 24UWI+W0vQ7B9ZJ0y1wVuIpMujImCVfAa2+x/abl+LCtmKhX4lZ0mPh3QvdCjWM1+/
	 iE9PFqen9jTmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABABC47DD7;
	Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org>
Date: Thu, 18 Jan 2024 09:25:15 -0600
Subject: [PATCH RFC 4/5] powerpc/pseries: Prepare
 pseries_add_hw_description() for runtime use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240118-update-dump-stack-arch-str-v1-4-5c0f98d017b5@linux.ibm.com>
References:
 <20240118-update-dump-stack-arch-str-v1-0-5c0f98d017b5@linux.ibm.com>
In-Reply-To:
 <20240118-update-dump-stack-arch-str-v1-0-5c0f98d017b5@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Brian King <brking@linux.ibm.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 John Ogness <john.ogness@linutronix.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Petr Mladek <pmladek@suse.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Nathan Lynch <nathanl@linux.ibm.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705591541; l=2099;
 i=nathanl@linux.ibm.com; s=20230817; h=from:subject:message-id;
 bh=CZv2kpuUutCPmlUb5oeOcKP+Rm48SwsyFZd4IK8M0MI=;
 b=VVNznsHiVwe7zaiA0/fbe8MyMpQpbpoQiulJKy7zUG3wlvgn6w2XdK5QLCzzLofZfATALOCz8
 dlidtlO/FPgAkWxOCQuJcyLT2ARRHAF958I6ehHVXDfd352+MaTHxLt
X-Developer-Key: i=nathanl@linux.ibm.com; a=ed25519;
 pk=jPDF44RvT+9DGFOH3NGoIu1xN9dF+82pjdpnKjXfoJ0=
X-Endpoint-Received:
 by B4 Relay for nathanl@linux.ibm.com/20230817 with auth_id=78
X-Original-From: Nathan Lynch <nathanl@linux.ibm.com>
Reply-To: <nathanl@linux.ibm.com>

From: Nathan Lynch <nathanl@linux.ibm.com>

pseries_add_hw_description() will be used after boot to update the
hardware description string emitted in stack dumps. Remove the __init
and make it take a seq_buf * parameter instead of referencing
ppc_hw_desc directly.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index ecea85c74c43..9ae1951f8312 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -1007,7 +1007,7 @@ static void __init pSeries_cmo_feature_init(void)
 	pr_debug(" <- fw_cmo_feature_init()\n");
 }
 
-static void __init pseries_add_hw_description(void)
+static void pseries_add_hw_description(struct seq_buf *sb)
 {
 	struct device_node *dn;
 	const char *s;
@@ -1015,7 +1015,7 @@ static void __init pseries_add_hw_description(void)
 	dn = of_find_node_by_path("/openprom");
 	if (dn) {
 		if (of_property_read_string(dn, "model", &s) == 0)
-			seq_buf_printf(&ppc_hw_desc, "of:%s ", s);
+			seq_buf_printf(sb, "of:%s ", s);
 
 		of_node_put(dn);
 	}
@@ -1023,7 +1023,7 @@ static void __init pseries_add_hw_description(void)
 	dn = of_find_node_by_path("/hypervisor");
 	if (dn) {
 		if (of_property_read_string(dn, "compatible", &s) == 0)
-			seq_buf_printf(&ppc_hw_desc, "hv:%s ", s);
+			seq_buf_printf(sb, "hv:%s ", s);
 
 		of_node_put(dn);
 		return;
@@ -1031,7 +1031,7 @@ static void __init pseries_add_hw_description(void)
 
 	if (of_property_read_bool(of_root, "ibm,powervm-partition") ||
 	    of_property_read_bool(of_root, "ibm,fw-net-version"))
-		seq_buf_printf(&ppc_hw_desc, "hv:phyp ");
+		seq_buf_printf(sb, "hv:phyp ");
 }
 
 /*
@@ -1041,7 +1041,7 @@ static void __init pseries_init(void)
 {
 	pr_debug(" -> pseries_init()\n");
 
-	pseries_add_hw_description();
+	pseries_add_hw_description(&ppc_hw_desc);
 
 #ifdef CONFIG_HVC_CONSOLE
 	if (firmware_has_feature(FW_FEATURE_LPAR))

-- 
2.43.0


