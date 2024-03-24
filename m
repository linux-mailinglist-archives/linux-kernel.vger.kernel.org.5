Return-Path: <linux-kernel+bounces-115271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65132889CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9745A1C34920
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB39157A7A;
	Mon, 25 Mar 2024 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeczNmOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922491CF8D2;
	Sun, 24 Mar 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320463; cv=none; b=sarqNQkw7g/ckEUCa7x15gVdviRxWjPCXqW7sYQW5RcYeswsp1dG8b7mxEkilvTtq3nWoFHJMOpeKPdTg6H540YLtM9cAJPRLTgFhrOWaNEqcrPKzzUPu+YPki8q9dORpsbfDd1pTdCTZjcoDcK8dWB1zgiyP9gXjnq9blIpoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320463; c=relaxed/simple;
	bh=bIVtbSMKxcSFFD/wdw1wvG/4arj3wpTutJa23UtENBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSyeHbEirW3rwmSFqBnZ4AbNclIUwbWUH6nn0d0NS4XVE8+6TRUoGvz2fmR3aBvpI/hga+tCEVNAQZCxZn8MZXdZZbEqWNcN7mh5Geg0A0MaLUq4bMucOfk7ef0QzFHs3d8SYDnSe0NOO/fSIeN0ffwkwbM9s1EvP1OuEJObAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeczNmOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B8CC433C7;
	Sun, 24 Mar 2024 22:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320463;
	bh=bIVtbSMKxcSFFD/wdw1wvG/4arj3wpTutJa23UtENBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LeczNmOJFHDBgqd25HBDBmrP+YA+yKmdIeCsxcsIJYaXSf7ByVD0CFSganxiUKzTa
	 Orb42AmzbfoCGuPCnjCEt8h4s/OjVkTOPeGXSwuQwPZNZojTi97EnnJjs61LCmc0EE
	 jehm2oSbifDFUsP/UYiKMm0m/Z9csdcjZkqtwk7nbhqkR4WbJ2Ad7QK1yRkhmx7j9c
	 B0mJ39tC+BPaOHEmdbsxdNw+DGcKll2iwxFB/NmqwW7yFhsxRdXdnvlVjgIpN/fg5G
	 fpd+QJzSTQ7qvrTuB1JsTR56a3HQ3Hwd32R5gZPNzi6X11BvzBOVhlVmZAQpyCjP/d
	 ZcSRJNaJVcVqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jean-Lo=C3=AFc=20Charroud?= <lagiraudiere+linux@free.fr>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 022/713] ALSA: hda/realtek: cs35l41: Add internal speaker support for ASUS UM3402 with missing DSD
Date: Sun, 24 Mar 2024 18:35:48 -0400
Message-ID: <20240324224720.1345309-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jean-Loïc Charroud <lagiraudiere+linux@free.fr>

[ Upstream commit 706c1fa1ab09f11a131fc4d699ce4c0224b1cb2d ]

Add the values for the missing DSD properties to the cs35l41 config table.

Signed-off-by: Jean-Loïc Charroud <lagiraudiere+linux@free.fr>
Link: https://lore.kernel.org/r/1435594585.650325975.1707867511062.JavaMail.zimbra@free.fr
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index d74cf11eef1ea..6cf4c02f9effd 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -91,6 +91,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431D1F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431DA2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10431E02", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "10431E12", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "10431EE2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
@@ -427,6 +428,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431D1F", generic_dsd_config },
 	{ "CSC3551", "10431DA2", generic_dsd_config },
 	{ "CSC3551", "10431E02", generic_dsd_config },
+	{ "CSC3551", "10431E12", generic_dsd_config },
 	{ "CSC3551", "10431EE2", generic_dsd_config },
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
-- 
2.43.0


