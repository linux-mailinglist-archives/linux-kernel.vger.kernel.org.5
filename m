Return-Path: <linux-kernel+bounces-115299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39162889A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36A51F23089
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923801D564A;
	Mon, 25 Mar 2024 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjkdiMeU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0B80610;
	Sun, 24 Mar 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320513; cv=none; b=Q5AYd/ogRhIp9hpgDs86IJRzWgO4DPrfFnzcvPOQp81AV3/NzIkYdlliADQj3556Y195DIK9PRtSV9ULIjwWjEdC6Kg0Eljc0U9t3yGnYr5skYBlytoslM3fWRf8hLQWOLW5nwOcCwYho2KlOuOXrQj94Q8AjPAnvE2wkUT2cBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320513; c=relaxed/simple;
	bh=lNQsheyNDdU4fFjsczF/E8ef3yJSjcxsBtth7BKLDKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpOORBlRYhh9Dxl8LpGIg9gDsRdiXF7X95Pl1uzSA5MtghJaat64WggY7YhWG9g2cgZH3BsAxGEFC95O0NFQyWIg+kKUEnEHWm4P7RUFyH5zPYmT96mpRb/QpMy9mkDv0mf6v1JkByYFfulZIapIzBAO4x75ieBM1JTGRKsh+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjkdiMeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44313C433C7;
	Sun, 24 Mar 2024 22:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320512;
	bh=lNQsheyNDdU4fFjsczF/E8ef3yJSjcxsBtth7BKLDKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjkdiMeUkD3TxiNsCG1lU5rX7MwMgrtIaxG3wdwpYXGWOyUuVgLNmpGiXJMHvcErM
	 5RhnbW5iWG8L3J8c/YQ7vs/IYf2l9f3uEvN4WE1/MhM3CqGKOadfYkKmRHO4Q8zsQz
	 /Hzq3orBg/esZmGrk1P/C4DuC+0jIRvAcNthV/fvwpQt7qCuvQCMzXOM0oscs2esxs
	 YyxoXXOBihBzLJI83HqEcrkrw4W/nJZDqaWxCLLMmOVpmhs0jkufNtwzWT4NYASZne
	 mOAiWh7nkShwpwAVQjEF3nj7ashSbyNjozVVaaKasTBFpy/hexy9ig3eYtr4uKH3fO
	 CTL/4G7k0EvpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 073/713] ALSA: hda: cs35l41: Overwrite CS35L41 configuration for ASUS UM5302LA
Date: Sun, 24 Mar 2024 18:36:39 -0400
Message-ID: <20240324224720.1345309-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit b603d95692e47dc6f5f733e93c3841dc0c01e624 ]

Whilst this laptop contains _DSD inside the BIOS, there is an error in
this configuration. Override the _DSD in the BIOS with the correct
configuration for this laptop.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240301160154.158398-4-sbinding@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 6cf4c02f9effd..5a5f4b499fd94 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -83,6 +83,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431863", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "104318D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "10431A83", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431C9F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431CAF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431CCF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
@@ -420,6 +421,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "104317F3", generic_dsd_config },
 	{ "CSC3551", "10431863", generic_dsd_config },
 	{ "CSC3551", "104318D3", generic_dsd_config },
+	{ "CSC3551", "10431A83", generic_dsd_config },
 	{ "CSC3551", "10431C9F", generic_dsd_config },
 	{ "CSC3551", "10431CAF", generic_dsd_config },
 	{ "CSC3551", "10431CCF", generic_dsd_config },
-- 
2.43.0


