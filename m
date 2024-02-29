Return-Path: <linux-kernel+bounces-86973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A8286CDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A499F1C211F6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5006CC03;
	Thu, 29 Feb 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peBWEtKl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8416CBEC;
	Thu, 29 Feb 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221776; cv=none; b=rrGG4sCwd3N31HvLnKz6itcJSEGvDYZHgqoqBUkDZ2IBW1JxMe0sgBZ874sHevBlrQv47I4nwapkcq9H6NaetbtlSUhAlip6ayJX7QQNULgJO8Zf1h1rcEfyIL6iXA3FDvatXyA/OFxk71Qve9uOhSOi6zt5GG84exGBCfUovKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221776; c=relaxed/simple;
	bh=qqQqYmeRobIgF1JaLhrO2YJ2mmVBNwvySbsBhS/0UMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObkF9vnE+8t89+vhOJ3bIgrrr7lhR8J7wJlemcb5S8xDLevWDrFGDs0YQqCji6Cq9/f3diRUrnNqxuXtTtwn04HIOghH62tQUCqhro0cL/wUFinzv/Ps9iWtrgY7A+7x/M/WiALV+TvnnkZbLukWe1w5iEhcDOC/ooQWXCxKWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peBWEtKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184E2C433F1;
	Thu, 29 Feb 2024 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221775;
	bh=qqQqYmeRobIgF1JaLhrO2YJ2mmVBNwvySbsBhS/0UMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=peBWEtKlMGXpHRaqN7Ic0cIY9vCxx/CTdNl8ivm7iRhv8J/FEqMkb7TTkRV7g28Uv
	 H9vIPf+Jx66RcXEfHM6NqPtnEypv8QOJNS1L++1KNl/dniSGd8MsHHs9zeWKMbf8TV
	 JxnrJaWiXjkAi/JZ3mjXRcpLdBcb9KgzELPUde1Hlck6XT+oXGE/QRgHGOrUS7N2LP
	 pCckl9roQn0iUaVDpt4OlIAFpNgN55faL8JDY31yuGH0+y/tVvPUmD2guY8ljcjPrX
	 EugE8tMhi35vPs9Fw+kvDCgZX0OS3J+q6Cb34BT7N4hiGheqBW1EXi27dbpxOwhVoB
	 L4Msz6c6mpQKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jean-Lo=C3=AFc=20Charroud?= <lagiraudiere+linux@free.fr>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 24/26] ALSA: hda/realtek: cs35l41: Add internal speaker support for ASUS UM3402 with missing DSD
Date: Thu, 29 Feb 2024 10:48:43 -0500
Message-ID: <20240229154851.2849367-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index 35277ce890a46..ffdff336678cc 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -89,6 +89,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431D1F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431DA2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10431E02", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "10431E12", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "10431EE2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
@@ -423,6 +424,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431D1F", generic_dsd_config },
 	{ "CSC3551", "10431DA2", generic_dsd_config },
 	{ "CSC3551", "10431E02", generic_dsd_config },
+	{ "CSC3551", "10431E12", generic_dsd_config },
 	{ "CSC3551", "10431EE2", generic_dsd_config },
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
-- 
2.43.0


