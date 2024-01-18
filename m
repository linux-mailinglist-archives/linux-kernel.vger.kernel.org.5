Return-Path: <linux-kernel+bounces-29802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30158313CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3352872BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D2286B2;
	Thu, 18 Jan 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmAS91dP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336728DCC;
	Thu, 18 Jan 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564711; cv=none; b=ow4ltEgwI6nEuKRE0qudEszIjTJLtlLX0MS08zByL5H7F6AP/hbxzI4pCyJ8gejQcHC9qMCd6OYAdJ0/hWsmtJmtY3sNaE4N3BQ7IoKzgt+S8l67kxGIp+3/QDT6Pbin37uQ14qQIkUchrg7Q25Md1OEfuOOHPUnBHOjD7ZsGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564711; c=relaxed/simple;
	bh=zvbWFLhlZqiTKCZrUNu1Xqw8wgSMHRcmoYbp1pvidpA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=WO5Lmq6hYBDkzZYgM4GJqr1ec5/ZUmwi2d/DKMl4ek6mql/AyMX7JMnpuFZ3yL+JBS3NxfYz0UGhNe6W/XRRqaP2ISAx9KYETyfEvbUVxjy6tzux4d6diPNJhY9aDdIYKVLMcQEdK4cvGmzdpAcdURBBGF4NtZiiK+4e+KsxT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmAS91dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B85EC43394;
	Thu, 18 Jan 2024 07:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564710;
	bh=zvbWFLhlZqiTKCZrUNu1Xqw8wgSMHRcmoYbp1pvidpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rmAS91dPHhyNlQBbnmbElCsP+mlesFSo6sZNH6OWFBmt7u0gCUOyDc2Yh0dVxa3PU
	 wx60ZzRIJKPcUYocCj+WtMg7WiRz5+MOubUafopRWxaeLafwjwrWUdhnz1rtwi3HJU
	 QwU5KTpRo4aLLwOGrtzO19QEjJEtcuqfPflk02CIj9Z1HDjiQn5hIk/T3XgCPBOzqo
	 fsxFZxPH4n1fWfIv42I7Mh3nWbAVdLrGC+MtxNN5LOlwhSV3QV/V2ieNvnV85UrajX
	 K0EjFh2/L83zWxFiUIgfZjEoxoZ6pyJp13Cs+hP3AKk9gQ5y85s0NnM7HocSD4A/Mt
	 rLSVC6zuLi29Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 15/45] tty: vt: pass vpar as unsigned to csi_J() and csi_K()
Date: Thu, 18 Jan 2024 08:57:26 +0100
Message-ID: <20240118075756.10541-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118075756.10541-1-jirislaby@kernel.org>
References: <20240118075756.10541-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vc_data::vc_par is passed to these function and that is unsigned. So
accept unsigned in csi_J() and csi_K().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c00c568c11a5..4b514187ef15 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1505,7 +1505,7 @@ enum {
 	CSI_J_FULL		= 3,
 };
 
-static void csi_J(struct vc_data *vc, int vpar)
+static void csi_J(struct vc_data *vc, unsigned int vpar)
 {
 	unsigned short *start;
 	unsigned int count;
@@ -1548,7 +1548,7 @@ enum {
 	CSI_K_LINE			= 2,
 };
 
-static void csi_K(struct vc_data *vc, int vpar)
+static void csi_K(struct vc_data *vc, unsigned int vpar)
 {
 	unsigned int count;
 	unsigned short *start = (unsigned short *)vc->vc_pos;
-- 
2.43.0


