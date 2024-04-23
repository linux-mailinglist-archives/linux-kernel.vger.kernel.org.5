Return-Path: <linux-kernel+bounces-155041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D59628AE4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C931C22FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5411813D620;
	Tue, 23 Apr 2024 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9lay7NM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3348564F;
	Tue, 23 Apr 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872451; cv=none; b=i0Zp8ZLFTzASxghoCrtiuB8KV2iSfTiYPREY6QyyqKFa36PunO/X4rP+EGYmoELNpdzJlv76S62gmnT7XNQhS6NaeazoMdJYA7n9fDQSXV0i7HfVtBfC/Cin4gjbuDmT2cG6kN0msfDG9DgSdJpGWWIIGTVYyW49nV5LH1N63sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872451; c=relaxed/simple;
	bh=TkcNi1fQ9TF91KAuebmGAZ3Sag/oWc+wWRlrwOCiSVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5RLZA5BMTKWwTC72eoRAoeb6SO1qWP2VzrR189Un9s4Uo6rZ/pH4n4SplZKjF81Z87SueTURBayt1+xTnbVLQoBaYLFfs+3PEWpmqIYuHb2x08wUN1Q8vUCxUlk+x2jKwiaCyVKUA0gf2WtghmbWIrWueh4lRnp5Mlmb3waz+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9lay7NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A246C2BD11;
	Tue, 23 Apr 2024 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872451;
	bh=TkcNi1fQ9TF91KAuebmGAZ3Sag/oWc+wWRlrwOCiSVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9lay7NMoNn2VbPU05cPG1jaLT4S2+HWlgyEpD8IoIlhxZetVvkEqel9a9Eo73hvp
	 tzrFKn2l7pV/mPiLaEvnOpHaZZVWs5H/ciTAbKqRfarbG5/5IS444FvjTSS2XURq3O
	 CFD+veACevhWyhcBeToY+Xbvk1LbiWgv2F2+ktlkOi/ZxzH7N8Wkulh33sEPbt3Jsf
	 zd4jWl6Bo57wOr4Gm2XgHNLkI7q5w4YdNyGt0cPDpgTFSdZcTR88IuaFiaHA+PbGJK
	 3nMRyu/J01N9RfJ3B3s1jzOD7SZeGTnl4M0T6D7BmlZxElZySKhp3R9fUShKmjxRpj
	 9ofeaQ9nvrfaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/16] platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes
Date: Tue, 23 Apr 2024 07:01:46 -0400
Message-ID: <20240423110151.1658546-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit f609e7b1b49e4d15cf107d2069673ee63860c398 ]

BIOS 03.05 still hasn't fixed the spurious IRQ1 issue.  As it's still
being worked on there is still a possibility that it won't need to
apply to future BIOS releases.

Add a quirk for BIOS 03.05 as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240410141046.433-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index b456370166b6b..b4f49720c87f6 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -208,6 +208,15 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "03.03"),
 		}
 	},
+	{
+		.ident = "Framework Laptop 13 (Phoenix)",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop 13 (AMD Ryzen 7040Series)"),
+			DMI_MATCH(DMI_BIOS_VERSION, "03.05"),
+		}
+	},
 	{}
 };
 
-- 
2.43.0


