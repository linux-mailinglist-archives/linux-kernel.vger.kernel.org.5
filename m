Return-Path: <linux-kernel+bounces-49337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE1F8468CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D133D1F22D44
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7F6495E4;
	Fri,  2 Feb 2024 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lghqeEoq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FF48CD2;
	Fri,  2 Feb 2024 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857003; cv=none; b=fJnueGg/Xs9gKLOl5mWoAfoBQSwHHU5V0xCIIZxb0eBVVYAlvAgP12xoALfGkTA72pzIR9HegGimcqeTqNmNxDxhaYLr5JJgU3gsN73py98y7q3RCQLbkblgGF/FYe8MTv8RO9gQjAImppfa9bNeZXpoCk14t3o4xHLC6aIPWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857003; c=relaxed/simple;
	bh=VOEOzfnSThEWfOBJs6nKpRIEyLceRRUxrYlGmQrTE5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB8T/rQ3wj/AEKpX5J75zBrPBFGUggNQi/loWc5NJY8MWwv4MgdlLBetrE829kZZ46iAr6gU+i4S62cLPki0rIWWFZQOnJ8ZffJvKXI/++z+TACLGJZjH2JwqyfnQM8CqWOsfniw8QBEJV8ditq1xWLQI/5KhuKlktv9XIL9ff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lghqeEoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86348C433C7;
	Fri,  2 Feb 2024 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706857003;
	bh=VOEOzfnSThEWfOBJs6nKpRIEyLceRRUxrYlGmQrTE5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lghqeEoqNlo0iQxUcgQ+h3jWhF9iNmNOdEM7gxs9NG4VGihXIase6yX9+SkohvOUO
	 SPrmVPygwVB1KzXFVkFLnPWQiqnrC+5ZrXfn/iPfYJAs8MxXK7IVqh7mgvX6s1IOwc
	 EMk3PmDozw1IBfCjtZWsHP+ugyNUxcNRv27jGlnrht1MXtVuuZmhAWthAzn8nkoKvx
	 bjW97dH+bkhYeHksM13x8wbfCx7MW8XjHJAtFTJ12gHYkL1+PHP214DPsVCtanQMlu
	 kRWivQ4F7XWBUXlRKZooHPztyIuYjnjU4idT3UqS+ht+mO6zU5+A5yGsJMSd+gpmO1
	 23QZ7jjI+7sow==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 21/22] tty: vt: use ASCII enum constants in vt_console_print()
Date: Fri,  2 Feb 2024 07:56:07 +0100
Message-ID: <20240202065608.14019-22-jirislaby@kernel.org>
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

There are still numbers used for ASCII characters in vt_console_print().
As we have an ASCII enum now, use the constant names from the enum
instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b3c61ec92df9..e35f7a31a7bd 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3240,22 +3240,23 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 	cnt = 0;
 	while (count--) {
 		c = *b++;
-		if (c == 10 || c == 13 || c == 8 || vc->vc_need_wrap) {
+		if (c == ASCII_LINEFEED || c == ASCII_CAR_RET ||
+		    c == ASCII_BACKSPACE || vc->vc_need_wrap) {
 			if (cnt && con_is_visible(vc))
 				vc->vc_sw->con_putcs(vc, start, cnt, vc->state.y, start_x);
 			cnt = 0;
-			if (c == 8) {		/* backspace */
+			if (c == ASCII_BACKSPACE) {
 				bs(vc);
 				start = (ushort *)vc->vc_pos;
 				start_x = vc->state.x;
 				continue;
 			}
-			if (c != 13)
+			if (c != ASCII_CAR_RET)
 				lf(vc);
 			cr(vc);
 			start = (ushort *)vc->vc_pos;
 			start_x = vc->state.x;
-			if (c == 10 || c == 13)
+			if (c == ASCII_LINEFEED || c == ASCII_CAR_RET)
 				continue;
 		}
 		vc_uniscr_putc(vc, c);
-- 
2.43.0


