Return-Path: <linux-kernel+bounces-129277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872EA896826
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260BC1F2127B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2994139CEF;
	Wed,  3 Apr 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvSPhldb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE3139569
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131663; cv=none; b=KPa0x/lrmY/IdWhwpr9IvHaVUwKhLr/PtNR03AKTCqaIh1R8CsKv1+jG0SVio4jz2Gtzb6y8h7TI/lGYElLKX1BUYNyqnOS9QtWgsvvpm6Cxm10DWo11beUzSOKGBFTbY0M2ypugvy7kwFYlesfP8RdnEQz1Z8iq5LqLqLoQvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131663; c=relaxed/simple;
	bh=DfgrdIQHoOxH+2TugFyR/+ff9D+Pn9X95ms+e4KOlOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nV9D0liGRjQKRJApddDNRY9ccYROk5iShXMmUcFqQddbvBMBbtCY/uCu5BSD66zsrJjKIGfLFKJl2/W0OUDo4+yPyhvnixRQ16lD2AFS+VBTlwQXM1Q+BR4laQ3IbSwLr5utiA3Zdu97hCYMX2illWpnLlDvBzlgO4rAOj+dOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvSPhldb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951BCC43394;
	Wed,  3 Apr 2024 08:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131663;
	bh=DfgrdIQHoOxH+2TugFyR/+ff9D+Pn9X95ms+e4KOlOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvSPhldbzQ28ytw8g7KXAHbWMo76SFb4yERsC/I1lFWdR1BNpTRt8Tq6F39wtGTGF
	 sGx5JswGoJMQmUaFaiUv3ObDX1+KLIKtUDSD3YQ72PQEuNXEDWpAXRnAPek4RE3gFk
	 c1GbLt9ef7ZK8kkt7hLYPklbVqmnZbyc27QgskspyHof17Z/W9JpBs464et44/aaKI
	 jDA6i2Zg6aIEW7xL0vdTPbiBFIlMHlYCnzjKoEaS1MmycqX7BDD8ZAC9/Ntfn9vXMR
	 8xAVyO7U9KINKcEGrzL/jMwW5DrMaV/MoW8gTP3iP1MNACqRSR51F83VTRy3Qk6Hwn
	 rcI3LyP40at0Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexander Graf <agraf@suse.de>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Scott Wood <scottwood@freescale.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/34] powerpc/fsl-soc: hide unused const variable
Date: Wed,  3 Apr 2024 10:06:19 +0200
Message-Id: <20240403080702.3509288-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

vmpic_msi_feature is only used conditionally, which triggers a rare
-Werror=unused-const-variable= warning with gcc:

arch/powerpc/sysdev/fsl_msi.c:567:37: error: 'vmpic_msi_feature' defined but not used [-Werror=unused-const-variable=]
  567 | static const struct fsl_msi_feature vmpic_msi_feature =

Hide this one in the same #ifdef as the reference so we can turn on
the warning by default.

Fixes: 305bcf26128e ("powerpc/fsl-soc: use CONFIG_EPAPR_PARAVIRT for hcalls")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/sysdev/fsl_msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 8e6c84df4ca1..e205135ae1fe 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -564,10 +564,12 @@ static const struct fsl_msi_feature ipic_msi_feature = {
 	.msiir_offset = 0x38,
 };
 
+#ifdef CONFIG_EPAPR_PARAVIRT
 static const struct fsl_msi_feature vmpic_msi_feature = {
 	.fsl_pic_ip = FSL_PIC_IP_VMPIC,
 	.msiir_offset = 0,
 };
+#endif
 
 static const struct of_device_id fsl_of_msi_ids[] = {
 	{
-- 
2.39.2


