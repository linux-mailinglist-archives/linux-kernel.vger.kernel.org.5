Return-Path: <linux-kernel+bounces-49321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC98468A4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69171F24526
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866C18654;
	Fri,  2 Feb 2024 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbqoliew"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23B18635;
	Fri,  2 Feb 2024 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856981; cv=none; b=U/Fw38bDADxMiYXRFGPQtSitxVPNUbdRNCM+JnMaCK5Bip7YkBkQklqsjg3u6VSBjkVWXUrQ5F0umq6DkBpb7QiQViK6QrWG12w6VtcEnOEkA9xvLKndM9I+RiRGqnecMlHh7sMNVJViQgR/DnXvNPeWYn1vHjH6xqFuOAcTmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856981; c=relaxed/simple;
	bh=JA1mO7mmkQWRWZ2IXS92LNrizm+dnPGK0g9gxxuO5o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcOjopFqFo0pFpitRURETXXb3mIIpe2TS7RRtwVrZmxuK4csDZnVHvCjOxBriyaBZxffHumrYyYuGQmgT/cDNHC4ZfInr/OMPoxc/LWd2xjemV25hr8TEP4R5a5a/NI12QKdxnfBVTUi05VKcCkgaBNYnwbcBiriCEre6oFsDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbqoliew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2738C433F1;
	Fri,  2 Feb 2024 06:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856981;
	bh=JA1mO7mmkQWRWZ2IXS92LNrizm+dnPGK0g9gxxuO5o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbqoliewihlJoVWJh4154WINa0cRBw31SKQvFj8IAONpiWGCXclbNYAyEpWhSchl0
	 +ilOZK2FH4UpqUXAOqJSsXip7pX/gKOV7czDx1XAV/cwMl3fg7NOpd64F7RBSgdZmJ
	 Izf/xRd83CIwBFwnL4y/kShrMds+C7LnBDIPM3ooPkNw30mUEjFlVc6xPANg3tQ0Kz
	 2SWIvwKNAQJ6wjgqN3RmZAvk3OUnDSWgmRGPmLzEidgCl7fZtkmEQGkY/T4xFfv6s9
	 RZqyg5Yeb/24tJQwa11gUHmllx5rzoEHE8DqJeri58mv6lQ9edSrT4NCgsp9O76nz2
	 yiSAfK4GsEGfA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/22] tty: vt: move CSI+n handling along to other ECMA CSIs
Date: Fri,  2 Feb 2024 07:55:52 +0100
Message-ID: <20240202065608.14019-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202065608.14019-1-jirislaby@kernel.org>
References: <20240202065608.14019-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CSIs without [<=>?] modifiers (ECMA) are handled in the switch-case
below this DEC switch+case handler. So move this ECMA CSI+n there too as
it fits there better.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 69ebce0878f2..04d109464994 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2412,14 +2412,6 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 				return;
 			}
 			break;
-		case 'n':
-			if (vc->vc_priv == EPecma) {
-				if (vc->vc_par[0] == 5)
-					status_report(tty);
-				else if (vc->vc_par[0] == 6)
-					cursor_report(vc, tty);
-			}
-			return;
 		}
 		if (vc->vc_priv != EPecma)
 			return;
@@ -2506,6 +2498,12 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		case 'm':
 			csi_m(vc);
 			return;
+		case 'n':
+			if (vc->vc_par[0] == 5)
+				status_report(tty);
+			else if (vc->vc_par[0] == 6)
+				cursor_report(vc, tty);
+			return;
 		case 'q': /* DECLL - but only 3 leds */
 			/* map 0,1,2,3 to 0,1,2,4 */
 			if (vc->vc_par[0] < 4)
-- 
2.43.0


