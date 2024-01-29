Return-Path: <linux-kernel+bounces-42334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D46283FFBE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB041C22194
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCB52F83;
	Mon, 29 Jan 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD1BEonD"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A43524CE;
	Mon, 29 Jan 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515944; cv=none; b=PhQNj42gFikLHG9b1s+LB9Knay/KJLdvWgb4lzXSScJ2A/F8x2H3Zff+tHLNnIzVQBdBkVL97i0gEhCxAnFrYKPAhWsuL90HRV2PIq0Ea4jNSZ59Y96rgCR/UnskA2cwRzNrFamLS6Sdfwda6aPHSx66pngTPpbpJYFW5UafDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515944; c=relaxed/simple;
	bh=5VqrWAknAf4vZSdzkIS4gQaU0K5FRkZTMDj9ZAY53bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWt0dbZmG0uqdLRypCjFBJRMtcP8BF9eN88+/7fU3MK9lIhzd9Ub9cEwMRVItUyhmW8FAGb2CPhgI8IA1cCUo4d7yKYqdNYWTMFCI3KgXhriIWQzEINwBiEXwpHoAfZoWWA1t8dRasZAB5lW9KQbsaqaEXNOBv8CERdnrMRdj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD1BEonD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so1271888a12.1;
        Mon, 29 Jan 2024 00:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706515942; x=1707120742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSxxqBbmSAk+hLfPyvlrEnyP1Xg9bGPv059b4tYhpX0=;
        b=VD1BEonDOp1QWFRYdPLua3oNYef/CleNJ14CqdqtHPKeuQ/h8KwdT3Z4aPmTr6QVZh
         vbDO7pZIdr0vFafvacp6REOXIOlD3YfEu6XHgVxyiLavN2h/j2VjS5hX+8zKcHssiSbf
         uh7/Y0WP2MJU8xbx+pU6QrfHd+ppNDmll5283p0GDAqZvP0SxR8ZD+SFZ1A/13HcjTP7
         AEaOKXccO0AfzQOdguGwtgIePBx0cfJ9XR+hicAzRveJ9TcsUUpiFo1Iq4qdWMSn7zMq
         ydgpyJD6gdRkiUfLbQp+9FEvD4y5ijRVhg4pnOaxqS1MzKIaLv0tQoVCOIsKn80PZf4V
         giXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706515942; x=1707120742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSxxqBbmSAk+hLfPyvlrEnyP1Xg9bGPv059b4tYhpX0=;
        b=osOGve9cL8B5ar2gUEMg4U21AfyAtOvWXxs15eFoUPTB69qC76Of6OCTSBkLJZE2A3
         NruFcImBsKirWsnLIPkqVIPj2pRfiub3TKqEdIkg+0Kp3hnlix2xvlHb7wmA8cMjlTmJ
         vpQ/19sIQ8hnoz2i8lm36hDm1TQiTqfH2jlba8PjpVYcXNHyy7/K9LPn2o7TsKeQJrLI
         DE+6HKU2YNS+rESPrR+L4wkuYFen+GIFq2VeZE2/zqx++LBW1687+Pg/O8m279Pa2M6H
         cCZ2QfCzBaiNrk/+5nL38gt0AVWdqPAaXTl7bMqTrPLY2LbFHCCPQJYvvnJGEIql/rZP
         lC8g==
X-Gm-Message-State: AOJu0YwACMf0uY2JNoHVghm+5v2uJ3nHFbo2MbAxvRUjTG7qYHohbn1I
	cIgEW9eW9QJIN1+E7svEjqJuluM/5k/SNw341v8RqO+4FQwo+bEKrZ3wmwOr1qc=
X-Google-Smtp-Source: AGHT+IGTXUnS6bRrzQSKuMiJIaKfOGq//Kb0v09jd8dvmDoHQ/HSS6xV9zvUDljJ7xT9I9rpqdMRxQ==
X-Received: by 2002:a05:6a20:d90f:b0:19c:a7c0:acd8 with SMTP id jd15-20020a056a20d90f00b0019ca7c0acd8mr921760pzb.0.1706515942524;
        Mon, 29 Jan 2024 00:12:22 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ja3-20020a170902efc300b001d8cfb5541csm2011229plb.25.2024.01.29.00.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 00:12:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 10BA6184798E6; Mon, 29 Jan 2024 15:12:16 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Sound System <linux-sound@vger.kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jeremy Soller <jeremy@system76.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Techno Mooney <techno.mooney@gmail.com>,
	stable@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF
Date: Mon, 29 Jan 2024 15:11:47 +0700
Message-ID: <20240129081148.1044891-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=bagasdotme@gmail.com; h=from:subject; bh=lVtZEm/LYxr9FC6NvuxOG7LoAhbDsr6Aui6cxNvhA48=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnbY8JczFR23H1eu2rVi1PPdTe++dd+8SyzwP1MwTkmJ 089ypNf2VHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJdDxnZHjSv8f0yPTm35dX ubjNOavQGCRgMssu4cufnL63x5cwntjNyNB0zuslX4PRjK+tGcek6qZ/kVm7bkqRfs+uiAiO2z2 fjZkA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Techno Mooney <techno.mooney@gmail.com>

The laptop requires a quirk ID to enable its internal microphone. Add
it to the DMI quirk table.

Reported-by: Techno Mooney <techno.mooney@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218402
Cc: stable@vger.kernel.org
Signed-off-by: Techno Mooney <techno.mooney@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 I'm not sure about reporter's identity (which also authored the quirk
 patch), hence I derived his name instead.

 Techno Mooney: is it OK to use above Reported-by: identity as-is?
 Developers: In this case, is it better to just use
 `Reported-by: <reporter's email>`?

 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index d83cb6e4c62aec..23d44a50d81572 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -297,6 +297,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 B7ED"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7VF"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {

base-commit: aa8e3ef4fe5332c2ce33507e874b20d9c0077c21
-- 
An old man doll... just what I always wanted! - Clara


