Return-Path: <linux-kernel+bounces-17086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8357B824817
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226331F2149F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB20428E26;
	Thu,  4 Jan 2024 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="OkdMnE5y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964028DB0;
	Thu,  4 Jan 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse.fritz.box (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 01BF82FC0073;
	Thu,  4 Jan 2024 19:22:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1704392537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKQS4AwlSL17ZE3tRGxXuQK7iAc6fj3KFZMSPVfU4pw=;
	b=OkdMnE5yYzSnkjr8qaei7lbEsVaM28faOqbY8ipEZAroqBo3Fkn/b222HVO7Tke+bt8h6v
	V58kJzs2ay4dteIG5I/JuwwnqCL0C5xO6JX8ji2vy38+KRCvvGX7RrFafesc/xzM1oTzm9
	OG6TCYy/ZMtR+zxoS3tfx/Fx7laPRlM=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: dmitry.torokhov@gmail.com
Cc: hdegoede@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v3 2/2] i8042: Use new forcenorestore quirk to replace old buggy quirk combination
Date: Thu,  4 Jan 2024 19:22:08 +0100
Message-Id: <20240104182208.779486-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104182208.779486-1-wse@tuxedocomputers.com>
References: <20240104182208.779486-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old quirk combination sometimes cause a laggy keyboard after boot. With
the new quirk the initial issue of an unresponsive keyboard after s3 resume
is also fixed, but it doesn't have the negative side effect of the
sometimes laggy keyboard.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-acpipnpio.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 10ec4534e5e14..e631a26394e92 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1142,18 +1142,10 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
 	{
-		/*
-		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
-		 * the keyboard very laggy for ~5 seconds after boot and
-		 * sometimes also after resume.
-		 * However both are required for the keyboard to not fail
-		 * completely sometimes after boot or resume.
-		 */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "N150CU"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
-- 
2.34.1


