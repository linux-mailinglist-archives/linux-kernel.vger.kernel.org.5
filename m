Return-Path: <linux-kernel+bounces-115274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F27889391
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92861C2E381
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCB415B150;
	Mon, 25 Mar 2024 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0yrrrJG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC18482D7;
	Sun, 24 Mar 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320466; cv=none; b=dDSqZWivbMYESPHFxLM6CVJ35b7VUfE5YDBgH7eObi15uZfH9JUqEmL26DIEVxR/3wLDToZy3ueSjw5+8p8yaYnxuIMruXR9thgy/s+frFxSsSNDQeRaJbfK4GzY4F4U/gWUtUlsWwb/b6STnCY+RTIXur9y5qkJojuovVOWNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320466; c=relaxed/simple;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTDpPQ9gc4Pt9YUuVav1H68vthpWB8ljdzamO/rALqHmYoP50cFVaxkWDr/UpT6UbeirEL0CpvToDoaLjp8p4qrapfA+tqYgA+7vsjGgoFtXBar3qf9t/r6C4aFVYupBaVtLwLdxnvnANUMyQanhZLSJvrLdOTRrSulxbEhHeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0yrrrJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB82C433F1;
	Sun, 24 Mar 2024 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320466;
	bh=FkzDlT8ctDyCauDA5oCuwo7gENN9bz4/MUbxBdnuFjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0yrrrJGYU2qLMFBN5sJXU8CEvqHyhHhxugt5px4E2htdfueVD0pnm6uuTaBXK5gI
	 N78Q/3YCBDipUrFXbkmJKEgCJ4ps4I7PohJPmsbGxPXfTu7xvTZz/rXRRMT0TyC4KC
	 0vZTBOq+Mt4AKNRzTzqKxOY0/US1edkHayAkSbrxOJ6iBNwF7dc8XY1ZyU+xEIPMPn
	 zyzstlb6IzyveaaKlhL2I8ynkMGkjCSmEL7ciH/Pmmq9N5KfUZC6Yaj6UEJ9/od+JL
	 5MHOzdz+PLi72G/XaGkjAWKaC9Br723uKqBCOvQyJC6C2U22P/P8MZqsM7T+/ReUDi
	 w0cDXVCrhwcWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 025/713] soc: microchip: Fix POLARFIRE_SOC_SYS_CTRL input prompt
Date: Sun, 24 Mar 2024 18:35:51 -0400
Message-ID: <20240324224720.1345309-26-sashal@kernel.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 6dd9a236042e305d7b69ee92db7347bf5943e7d3 ]

The symbol's prompt should be a one-line description, instead of just
duplicating the symbol name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/microchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/microchip/Kconfig b/drivers/soc/microchip/Kconfig
index eb656b33156ba..f19e74d342aa2 100644
--- a/drivers/soc/microchip/Kconfig
+++ b/drivers/soc/microchip/Kconfig
@@ -1,5 +1,5 @@
 config POLARFIRE_SOC_SYS_CTRL
-	tristate "POLARFIRE_SOC_SYS_CTRL"
+	tristate "Microchip PolarFire SoC (MPFS) system controller support"
 	depends on POLARFIRE_SOC_MAILBOX
 	help
 	  This driver adds support for the PolarFire SoC (MPFS) system controller.
-- 
2.43.0


