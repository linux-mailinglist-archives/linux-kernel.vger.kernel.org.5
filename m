Return-Path: <linux-kernel+bounces-29797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9547F8313C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFA9284C95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D20122F18;
	Thu, 18 Jan 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9VnJe6v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD122613;
	Thu, 18 Jan 2024 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564702; cv=none; b=Z/mO8/rJYTYKZEzl3dQDuUFq/gBiYi0eduJjpsBKZ07ZixqwYZVi0VQrMJSfEpBA5rbjelcc8GVntiIso0A6Rm4WkTViAqohAtE9GOc+Ju1pHscDo/YoEazkP+ZQCN/085xhndqn9jsRoMqfszNB1mqdWkO9ROrkbWc2NSR0SWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564702; c=relaxed/simple;
	bh=0shcMcCLihadWi/wJYrSetusFI9blXYLuPpY44fMuL0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=P17/EPtMRUc3N4zeh981KZJ81QoIaW4e6PqRSFcAbWWwN5fgMk5PN8Wk5mIHXPmVE3lvdkV0h5aPV431AVcOr3Wf3PWdkAPMChP1TKX0AJ4X6c6F5bLuUasvG4E1OHfuFFIcQLyh2Y9TV/tG4Cx98mWpYirW/0xoNRYyxf65Qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9VnJe6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A4DC43390;
	Thu, 18 Jan 2024 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564701;
	bh=0shcMcCLihadWi/wJYrSetusFI9blXYLuPpY44fMuL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9VnJe6v7SeJt/NlQu66AciIFlDw3KGpN3/60g5asVanDT5tXuJDk+GLZPdCPj56V
	 PyNdZWQbjG8spYth3iCH2Sy17BdK7uj4OqZIidGX9NXaaEzdYYuJmVv1hTQet3uxx6
	 gd6YqwE4ZpGBXL58Ig9gEYjIcAResloI1RcdDSLMnbt0dEm74cdKKMi5PUee6I4R0E
	 SPdwDmGtYXLZE6IAtvFhcq6rmlZ6m7r18PriwUC3/T0GN4yzjP7ehtOGGCIpOoUE8J
	 BG/yuTlre2hIjhTeztgI06Gx9sG0r8zjXz7HI5+EG+iLkvVpKXN0yi9kCu+CvXqEZG
	 JyoIISJ8d3nEw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/45] tty: vt: use case ranges for CSI+m fg/bg colors
Date: Thu, 18 Jan 2024 08:57:21 +0100
Message-ID: <20240118075756.10541-11-jirislaby@kernel.org>
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


