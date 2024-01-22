Return-Path: <linux-kernel+bounces-32818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6133983608C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE32832F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418743D0C8;
	Mon, 22 Jan 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMOU/m4R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A763D0B0;
	Mon, 22 Jan 2024 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921464; cv=none; b=aQMk46oIiasFi42IM5EF8zkT+PabGuBjUoOEF15VNURwPhVhbS2yFXO5yKgtByIHd3+Xn8KABH539Zc9h5uYzVjcRztDXyPfndfPDxmyKxbijCUj5dSkDpWEukuXjojYhYNh1LdMvUWGGJz9KZG1m6FIM4AgLaExQcmPNoPGjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921464; c=relaxed/simple;
	bh=wjvcMWVgxrLbYPn/W5a6My3T4c3HUQqRmsrqTj7fe3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awOIk9l231IMa2Gz63D+qHVH1lZxGG3SozTriTmGjSmVgdxQPv4v9cZ3+EmMSg5tYN3cVy6CJrjpDqxfStFKE2jRUQD4TdtkFqVehdXFkhIecUJjMRXKjLeKGa/tj+AglLkX+DVqnMO+mn2pPAuTp2UqFg41BHHwPSejffe/t2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMOU/m4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDA6C43394;
	Mon, 22 Jan 2024 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921463;
	bh=wjvcMWVgxrLbYPn/W5a6My3T4c3HUQqRmsrqTj7fe3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMOU/m4Rrq6p51P5wBNl7gwLx98U/BwrNTcAyfevBzdE/GDRWta4Yt93ICp9vUPyy
	 YU5LtQxzQECvNMLYGFV+HdUJn9eSJXk7B+h0NeKK/KiGU6YQn+0K8TMXBP10bdaw6y
	 ieJir2XXwOQXqLePrenB6wINEQqvw2IO1GS1AGLTctAKPkcfGO35slXb8ADXM11Wmd
	 4ZQxZEF1HGNazBOvnAaWS45pMH6FkTqu6MqNrmMPyVVT4hHFnveDUpQL4TNFesRl26
	 RDbc6PdPghtD7wpcGT9PjTn+dRtfmJJbNCovGbNg+W65prOvdOy182tkh0+AfQtir/
	 41GD5O13biQXw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 09/47] tty: vt: define an enum for CSI+m codes
Date: Mon, 22 Jan 2024 12:03:23 +0100
Message-ID: <20240122110401.7289-10-jirislaby@kernel.org>
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

It's always confusing to read all those case 0:, case 1: etc. in csi_*
handlers. Define enum entries for all those constants in CSI+m and use
them in csi_m().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 98 +++++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c87837306074..b2ba1b943eb6 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1676,6 +1676,39 @@ static int vc_t416_color(struct vc_data *vc, int i,
 	return i;
 }
 
+enum {
+	CSI_m_DEFAULT			= 0,
+	CSI_m_BOLD			= 1,
+	CSI_m_HALF_BRIGHT		= 2,
+	CSI_m_ITALIC			= 3,
+	CSI_m_UNDERLINE			= 4,
+	CSI_m_BLINK			= 5,
+	CSI_m_REVERSE			= 7,
+	CSI_m_PRI_FONT			= 10,
+	CSI_m_ALT_FONT1			= 11,
+	CSI_m_ALT_FONT2			= 12,
+	CSI_m_DOUBLE_UNDERLINE		= 21,
+	CSI_m_NORMAL_INTENSITY		= 22,
+	CSI_m_NO_ITALIC			= 23,
+	CSI_m_NO_UNDERLINE		= 24,
+	CSI_m_NO_BLINK			= 25,
+	CSI_m_NO_REVERSE		= 27,
+	CSI_m_FG_COLOR_BEG		= 30,
+	CSI_m_FG_COLOR_END		= 37,
+	CSI_m_FG_COLOR			= 38,
+	CSI_m_DEFAULT_FG_COLOR		= 39,
+	CSI_m_BG_COLOR_BEG		= 40,
+	CSI_m_BG_COLOR_END		= 47,
+	CSI_m_BG_COLOR			= 48,
+	CSI_m_DEFAULT_BG_COLOR		= 49,
+	CSI_m_BRIGHT_FG_COLOR_BEG	= 90,
+	CSI_m_BRIGHT_FG_COLOR_END	= 97,
+	CSI_m_BRIGHT_FG_COLOR_OFF	= CSI_m_BRIGHT_FG_COLOR_BEG - CSI_m_FG_COLOR_BEG,
+	CSI_m_BRIGHT_BG_COLOR_BEG	= 100,
+	CSI_m_BRIGHT_BG_COLOR_END	= 107,
+	CSI_m_BRIGHT_BG_COLOR_OFF	= CSI_m_BRIGHT_BG_COLOR_BEG - CSI_m_BG_COLOR_BEG,
+};
+
 /* console_lock is held */
 static void csi_m(struct vc_data *vc)
 {
@@ -1683,33 +1716,33 @@ static void csi_m(struct vc_data *vc)
 
 	for (i = 0; i <= vc->vc_npar; i++)
 		switch (vc->vc_par[i]) {
-		case 0:	/* all attributes off */
+		case CSI_m_DEFAULT:	/* all attributes off */
 			default_attr(vc);
 			break;
-		case 1:
+		case CSI_m_BOLD:
 			vc->state.intensity = VCI_BOLD;
 			break;
-		case 2:
+		case CSI_m_HALF_BRIGHT:
 			vc->state.intensity = VCI_HALF_BRIGHT;
 			break;
-		case 3:
+		case CSI_m_ITALIC:
 			vc->state.italic = true;
 			break;
-		case 21:
+		case CSI_m_DOUBLE_UNDERLINE:
 			/*
 			 * No console drivers support double underline, so
 			 * convert it to a single underline.
 			 */
-		case 4:
+		case CSI_m_UNDERLINE:
 			vc->state.underline = true;
 			break;
-		case 5:
+		case CSI_m_BLINK:
 			vc->state.blink = true;
 			break;
-		case 7:
+		case CSI_m_REVERSE:
 			vc->state.reverse = true;
 			break;
-		case 10: /* ANSI X3.64-1979 (SCO-ish?)
+		case CSI_m_PRI_FONT: /* ANSI X3.64-1979 (SCO-ish?)
 			  * Select primary font, don't display control chars if
 			  * defined, don't set bit 8 on output.
 			  */
@@ -1717,7 +1750,7 @@ static void csi_m(struct vc_data *vc)
 			vc->vc_disp_ctrl = 0;
 			vc->vc_toggle_meta = 0;
 			break;
-		case 11: /* ANSI X3.64-1979 (SCO-ish?)
+		case CSI_m_ALT_FONT1: /* ANSI X3.64-1979 (SCO-ish?)
 			  * Select first alternate font, lets chars < 32 be
 			  * displayed as ROM chars.
 			  */
@@ -1725,7 +1758,7 @@ static void csi_m(struct vc_data *vc)
 			vc->vc_disp_ctrl = 1;
 			vc->vc_toggle_meta = 0;
 			break;
-		case 12: /* ANSI X3.64-1979 (SCO-ish?)
+		case CSI_m_ALT_FONT2: /* ANSI X3.64-1979 (SCO-ish?)
 			  * Select second alternate font, toggle high bit
 			  * before displaying as ROM char.
 			  */
@@ -1733,47 +1766,54 @@ static void csi_m(struct vc_data *vc)
 			vc->vc_disp_ctrl = 1;
 			vc->vc_toggle_meta = 1;
 			break;
-		case 22:
+		case CSI_m_NORMAL_INTENSITY:
 			vc->state.intensity = VCI_NORMAL;
 			break;
-		case 23:
+		case CSI_m_NO_ITALIC:
 			vc->state.italic = false;
 			break;
-		case 24:
+		case CSI_m_NO_UNDERLINE:
 			vc->state.underline = false;
 			break;
-		case 25:
+		case CSI_m_NO_BLINK:
 			vc->state.blink = false;
 			break;
-		case 27:
+		case CSI_m_NO_REVERSE:
 			vc->state.reverse = false;
 			break;
-		case 38:
+		case CSI_m_FG_COLOR:
 			i = vc_t416_color(vc, i, rgb_foreground);
 			break;
-		case 48:
+		case CSI_m_BG_COLOR:
 			i = vc_t416_color(vc, i, rgb_background);
 			break;
-		case 39:
+		case CSI_m_DEFAULT_FG_COLOR:
 			vc->state.color = (vc->vc_def_color & 0x0f) |
 				(vc->state.color & 0xf0);
 			break;
-		case 49:
+		case CSI_m_DEFAULT_BG_COLOR:
 			vc->state.color = (vc->vc_def_color & 0xf0) |
 				(vc->state.color & 0x0f);
 			break;
 		default:
-			if (vc->vc_par[i] >= 90 && vc->vc_par[i] <= 107) {
-				if (vc->vc_par[i] < 100)
+			if (vc->vc_par[i] >= CSI_m_BRIGHT_FG_COLOR_BEG &&
+			    vc->vc_par[i] <= CSI_m_BRIGHT_BG_COLOR_END) {
+				if (vc->vc_par[i] < CSI_m_BRIGHT_BG_COLOR_BEG)
 					vc->state.intensity = VCI_BOLD;
-				vc->vc_par[i] -= 60;
+				vc->vc_par[i] -= CSI_m_BRIGHT_FG_COLOR_OFF;
 			}
-			if (vc->vc_par[i] >= 30 && vc->vc_par[i] <= 37)
-				vc->state.color = color_table[vc->vc_par[i] - 30]
-					| (vc->state.color & 0xf0);
-			else if (vc->vc_par[i] >= 40 && vc->vc_par[i] <= 47)
-				vc->state.color = (color_table[vc->vc_par[i] - 40] << 4)
-					| (vc->state.color & 0x0f);
+			if (vc->vc_par[i] >= CSI_m_FG_COLOR_BEG &&
+			    vc->vc_par[i] <= CSI_m_FG_COLOR_END) {
+				vc->vc_par[i] -= CSI_m_FG_COLOR_BEG;
+				vc->state.color = color_table[vc->vc_par[i]] |
+					(vc->state.color & 0xf0);
+			} else if (vc->vc_par[i] >= CSI_m_BG_COLOR_BEG &&
+				 vc->vc_par[i] <= CSI_m_BG_COLOR_END) {
+				vc->vc_par[i] -= CSI_m_BG_COLOR_BEG;
+				vc->state.color = (color_table[vc->vc_par[i]] << 4) |
+					(vc->state.color & 0x0f);
+			}
+
 			break;
 		}
 	update_attr(vc);
-- 
2.43.0


