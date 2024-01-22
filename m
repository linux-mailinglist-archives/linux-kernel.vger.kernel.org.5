Return-Path: <linux-kernel+bounces-32819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6100083608E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C3D1C21216
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590703D38D;
	Mon, 22 Jan 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH/tJrxp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB023D0D2;
	Mon, 22 Jan 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921465; cv=none; b=HM6ML9CNwaF/ZiCNAoeRBjMc2JoDP6dBt1E0StHX7+NIoerEzT9++fldv3QdUpWaY4m9POprawVzALHYIFojnfPQDUBX3aicdNsnoqLabu5C+Vb2ZfouNquogIdmmENUOHGCK02vR3rNR9/WtIcPcFHdHZiZ95ikSkH283rzFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921465; c=relaxed/simple;
	bh=0shcMcCLihadWi/wJYrSetusFI9blXYLuPpY44fMuL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtOkYP2DV6yLGOdf7CFcWRYN5Tc7NrTxPZxLZFhvs5ETNVDgrreLvh/2zFOlw+1ZpoM+FCUVxmR9ADupD2BQzz2gVKJwP11QfLpSNUEvfNMK8IucalswSznaVSNH1hy1J1DKVLVqkamq4A2/8Sxi1GkbnFqmUbAHEFTbAtKpcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH/tJrxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EB5C433F1;
	Mon, 22 Jan 2024 11:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921465;
	bh=0shcMcCLihadWi/wJYrSetusFI9blXYLuPpY44fMuL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AH/tJrxpatrVWahHG3egSW7bgPLKozH/88LOL6Tw2pyJLH4lFisTOgqclQfMCeiyz
	 FrfopkroAJGUj4yD6W9O0bUMqgEGb/WJIXAJt+KzlCPZ3ksQu6HjOrDkX0fsJVU9RA
	 XeTmebzDLG3ZEFG4Evg0U6EXof4wVrqWRsA5WiEPp/EMtPMgcB6cpAIf6hm+8p76aB
	 ZS+sSolLFR3el1Kn7QjSBLS5QX2ayXk3+ZDXEl0vR+lD+x08ZTUuFGQaXBJZ3lodoR
	 A6v0xSF22z2tTVTqIV8Offk/hRIEBSvMq6UVTBVORcdZwZmOspoD8xdrfu3pX5692M
	 +fdBljKFB7EmQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 10/47] tty: vt: use case ranges for CSI+m fg/bg colors
Date: Mon, 22 Jan 2024 12:03:24 +0100
Message-ID: <20240122110401.7289-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing the default case with the iffery by case ranges makes the code
more understandable at last.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b2ba1b943eb6..66ebc90a9fe9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1795,25 +1795,22 @@ static void csi_m(struct vc_data *vc)
 			vc->state.color = (vc->vc_def_color & 0xf0) |
 				(vc->state.color & 0x0f);
 			break;
-		default:
-			if (vc->vc_par[i] >= CSI_m_BRIGHT_FG_COLOR_BEG &&
-			    vc->vc_par[i] <= CSI_m_BRIGHT_BG_COLOR_END) {
-				if (vc->vc_par[i] < CSI_m_BRIGHT_BG_COLOR_BEG)
-					vc->state.intensity = VCI_BOLD;
-				vc->vc_par[i] -= CSI_m_BRIGHT_FG_COLOR_OFF;
-			}
-			if (vc->vc_par[i] >= CSI_m_FG_COLOR_BEG &&
-			    vc->vc_par[i] <= CSI_m_FG_COLOR_END) {
-				vc->vc_par[i] -= CSI_m_FG_COLOR_BEG;
-				vc->state.color = color_table[vc->vc_par[i]] |
-					(vc->state.color & 0xf0);
-			} else if (vc->vc_par[i] >= CSI_m_BG_COLOR_BEG &&
-				 vc->vc_par[i] <= CSI_m_BG_COLOR_END) {
-				vc->vc_par[i] -= CSI_m_BG_COLOR_BEG;
-				vc->state.color = (color_table[vc->vc_par[i]] << 4) |
-					(vc->state.color & 0x0f);
-			}
-
+		case CSI_m_BRIGHT_FG_COLOR_BEG ... CSI_m_BRIGHT_FG_COLOR_END:
+			vc->state.intensity = VCI_BOLD;
+			vc->vc_par[i] -= CSI_m_BRIGHT_FG_COLOR_OFF;
+			fallthrough;
+		case CSI_m_FG_COLOR_BEG ... CSI_m_FG_COLOR_END:
+			vc->vc_par[i] -= CSI_m_FG_COLOR_BEG;
+			vc->state.color = color_table[vc->vc_par[i]] |
+				(vc->state.color & 0xf0);
+			break;
+		case CSI_m_BRIGHT_BG_COLOR_BEG ... CSI_m_BRIGHT_BG_COLOR_END:
+			vc->vc_par[i] -= CSI_m_BRIGHT_BG_COLOR_OFF;
+			fallthrough;
+		case CSI_m_BG_COLOR_BEG ... CSI_m_BG_COLOR_END:
+			vc->vc_par[i] -= CSI_m_BG_COLOR_BEG;
+			vc->state.color = (color_table[vc->vc_par[i]] << 4) |
+				(vc->state.color & 0x0f);
 			break;
 		}
 	update_attr(vc);
-- 
2.43.0


