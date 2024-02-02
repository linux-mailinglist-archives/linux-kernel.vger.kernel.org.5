Return-Path: <linux-kernel+bounces-49322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC18468A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44401F26819
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E018C19;
	Fri,  2 Feb 2024 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsC1hGXa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108EE18B1A;
	Fri,  2 Feb 2024 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856983; cv=none; b=Dc2fg2dNjRVT+EWWi04z+wE9AgHMgLo0emsXAQ8PkBz99eS/zlMn10ojKUbc+yG1w/OX/IELWzkAcq5/Dg70DTXQzwnd4TuIgwxXTLO9xzVJOo3BKmKDj/qOZc2IxcwNa93GocflMiOv0VqO1tyNqudjK4UTieHA9cz8Qavttw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856983; c=relaxed/simple;
	bh=zkznFitIGz2Pjh+DWBKkgJYWUMuKCoX2dndhJadUQuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPI9/88JNKa7u7vKAUl9rJt2x0XGHXa+GJJf5A30kFMeSwhp0NY4qam+7cblhwDsQuZhhRDxruzrYjzVurQYY8TUqGwSpjXnrRQGx7FqODe9I9YTyqSFRCjYoCIrYXUdNpl00CUsqHYEl+C3jQllKv2kxBoUPiCp/rAfmiBekno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsC1hGXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78580C433C7;
	Fri,  2 Feb 2024 06:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856982;
	bh=zkznFitIGz2Pjh+DWBKkgJYWUMuKCoX2dndhJadUQuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsC1hGXai8T/J6kGDOoqZZn+xt85UFy8vY+mX3xA/YfJZ2XfS48vU2OTg5yVRIyB9
	 AEh21ZTb7aYIXdB5yyg1hu4pXaRv3cXW3F/uR8KZUVpNvUevxaLbsdsi8fsIQ1EkjX
	 aOVWKsXEKicbmZzKOd0x1i/gW4cknOBqCeOTWgSeAEp6dRyXmkpUmmh8+dqQfv/6Xy
	 xj7sRtR4JC3scoWps3WP/mt18u1I7RBeJeYaPCLxqlOw80TgNoXyfGc0OE4/WOnhTj
	 JTjTmOa2aHEPEKqk7Mrn+pSUvbUtQyeYAw7RwmGjeho8WHa/UuMlMSm3O62JeFxGLX
	 EZgDxl1afKvIA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/22] tty: vt: define an enum for CSI+] codes
Date: Fri,  2 Feb 2024 07:55:53 +0100
Message-ID: <20240202065608.14019-8-jirislaby@kernel.org>
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

Decrypt the constant values by proper enum names. This time in
setterm_command() (to be renamed to csi_RSB() in the next patches).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 04d109464994..9db545f305dc 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1955,62 +1955,76 @@ static void csi_hl(struct vc_data *vc, bool on_off)
 		}
 }
 
+enum CSI_right_square_bracket {
+	CSI_RSB_COLOR_FOR_UNDERLINE		= 1,
+	CSI_RSB_COLOR_FOR_HALF_BRIGHT		= 2,
+	CSI_RSB_MAKE_CUR_COLOR_DEFAULT		= 8,
+	CSI_RSB_BLANKING_INTERVAL		= 9,
+	CSI_RSB_BELL_FREQUENCY			= 10,
+	CSI_RSB_BELL_DURATION			= 11,
+	CSI_RSB_BRING_CONSOLE_TO_FRONT		= 12,
+	CSI_RSB_UNBLANK				= 13,
+	CSI_RSB_VESA_OFF_INTERVAL		= 14,
+	CSI_RSB_BRING_PREV_CONSOLE_TO_FRONT	= 15,
+	CSI_RSB_CURSOR_BLINK_INTERVAL		= 16,
+};
+
 /* console_lock is held */
 static void setterm_command(struct vc_data *vc)
 {
 	switch (vc->vc_par[0]) {
-	case 1:	/* set color for underline mode */
+	case CSI_RSB_COLOR_FOR_UNDERLINE:
 		if (vc->vc_can_do_color && vc->vc_par[1] < 16) {
 			vc->vc_ulcolor = color_table[vc->vc_par[1]];
 			if (vc->state.underline)
 				update_attr(vc);
 		}
 		break;
-	case 2:	/* set color for half intensity mode */
+	case CSI_RSB_COLOR_FOR_HALF_BRIGHT:
 		if (vc->vc_can_do_color && vc->vc_par[1] < 16) {
 			vc->vc_halfcolor = color_table[vc->vc_par[1]];
 			if (vc->state.intensity == VCI_HALF_BRIGHT)
 				update_attr(vc);
 		}
 		break;
-	case 8:	/* store colors as defaults */
+	case CSI_RSB_MAKE_CUR_COLOR_DEFAULT:
 		vc->vc_def_color = vc->vc_attr;
 		if (vc->vc_hi_font_mask == 0x100)
 			vc->vc_def_color >>= 1;
 		default_attr(vc);
 		update_attr(vc);
 		break;
-	case 9:	/* set blanking interval */
+	case CSI_RSB_BLANKING_INTERVAL:
 		blankinterval = min(vc->vc_par[1], 60U) * 60;
 		poke_blanked_console();
 		break;
-	case 10: /* set bell frequency in Hz */
+	case CSI_RSB_BELL_FREQUENCY:
 		if (vc->vc_npar >= 1)
 			vc->vc_bell_pitch = vc->vc_par[1];
 		else
 			vc->vc_bell_pitch = DEFAULT_BELL_PITCH;
 		break;
-	case 11: /* set bell duration in msec */
+	case CSI_RSB_BELL_DURATION:
 		if (vc->vc_npar >= 1)
 			vc->vc_bell_duration = (vc->vc_par[1] < 2000) ?
 				msecs_to_jiffies(vc->vc_par[1]) : 0;
 		else
 			vc->vc_bell_duration = DEFAULT_BELL_DURATION;
 		break;
-	case 12: /* bring specified console to the front */
+	case CSI_RSB_BRING_CONSOLE_TO_FRONT:
 		if (vc->vc_par[1] >= 1 && vc_cons_allocated(vc->vc_par[1] - 1))
 			set_console(vc->vc_par[1] - 1);
 		break;
-	case 13: /* unblank the screen */
+	case CSI_RSB_UNBLANK:
 		poke_blanked_console();
 		break;
-	case 14: /* set vesa powerdown interval */
+	case CSI_RSB_VESA_OFF_INTERVAL:
 		vesa_off_interval = min(vc->vc_par[1], 60U) * 60 * HZ;
 		break;
-	case 15: /* activate the previous console */
+	case CSI_RSB_BRING_PREV_CONSOLE_TO_FRONT:
 		set_console(last_console);
 		break;
-	case 16: /* set cursor blink duration in msec */
+	case CSI_RSB_CURSOR_BLINK_INTERVAL:
 		if (vc->vc_npar >= 1 && vc->vc_par[1] >= 50 &&
 				vc->vc_par[1] <= USHRT_MAX)
 			vc->vc_cur_blink_ms = vc->vc_par[1];
-- 
2.43.0


