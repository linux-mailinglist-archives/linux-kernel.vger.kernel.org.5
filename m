Return-Path: <linux-kernel+bounces-32859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32F836104
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4691C235B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577D2487BA;
	Mon, 22 Jan 2024 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJv05BJx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96230487A5;
	Mon, 22 Jan 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921539; cv=none; b=Ecv1upz5YwAj81yQLsZAN+7uoe5iiHEeX6WNNU3KeFSUThw5rwgeX/CtHXHd9Pza5la+MZRT2GGkIZ3MUFrpOCSlH7VjPFad/fCSCi02fpOrHYTPjtq7pwavVU2I1tmpfRQM7785KR8Tm1GSvc3uqkil/XV6IeXtmwFSy4CYcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921539; c=relaxed/simple;
	bh=TrJ1Xw/zw5myzyw++fpC3gbOAEuXGL07CMbj1DVOMB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgziTMWOjZultVEM+52p1HttrHQrldB1/w2+XpteDKR3kYNFOJ9W+QvG96oJcQp57K18dU2a97RcucVEGuUx4PrsCT5qKoG71m3Ci+DzmvSudqILXls94odrqabMbBGcBdk6hqwdLDEgHJ+1IBxHpqRH2TrmPkMp1f6169ivd4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJv05BJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA5C43390;
	Mon, 22 Jan 2024 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921539;
	bh=TrJ1Xw/zw5myzyw++fpC3gbOAEuXGL07CMbj1DVOMB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJv05BJxhYaI6lib9o0fW5734nuc/wost4Lr4K3LQP9WmJVD/n7RdQnLPS2uaDSyf
	 41+OW4G47cfwn7xEYQubMLsX5LBzZjhdrGQ4hIqRl6yYOgQJ2bBT74oZ3DV1+F3qR2
	 VHLHk4afo7tB9y55pYWK/8ddxgnCpxlwVK5MJSbDn0C924QThGUZ4gVeLk9w+c0zw8
	 jQ3R9lUDbHTG8HpPXOqE939W5ovBetLtvub6u261c9C6pXNH8k9j44dctVj4Bexg2D
	 k0A5BiTPnAzPTS2MocMpLKUDDyi10+XSEmwTPLjT0NTQZIcxbhWsEd1yCwAXq0oo2I
	 vFHNem+jC/L5A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 45/47] tty: vt: document the rest of struct consw
Date: Mon, 22 Jan 2024 12:03:59 +0100
Message-ID: <20240122110401.7289-46-jirislaby@kernel.org>
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

There are still members of struct consw which are not documented yet.
Fix that up, so we can generate kernel-doc for that struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/console.h | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 1eac3e6e32a2..f1a334ad268d 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -37,8 +37,11 @@ enum vc_intensity;
 /**
  * struct consw - callbacks for consoles
  *
+ * @owner:      the module to get references of when this console is used
+ * @con_startup: set up the console and return its name (like VGA, EGA, ...)
  * @con_init:   initialize the console on @vc. @init is true for the very first
  *		call on this @vc.
+ * @con_deinit: deinitialize the console from @vc.
  * @con_clear:  erase @count characters at [@x, @y] on @vc. @count >= 1.
  * @con_putc:   emit one character with attributes @ca to [@x, @y] on @vc.
  *		(optional -- @con_putcs would be called instead)
@@ -52,12 +55,33 @@ enum vc_intensity;
  * @con_blank:  blank/unblank the console. The target mode is passed in @blank.
  *		@mode_switch is set if changing from/to text/graphics. The hook
  *		is supposed to return true if a redraw is needed.
- * @con_set_palette: sets the palette of the console to @table (optional)
+ * @con_font_set: set console @vc font to @font with height @vpitch. @flags can
+ *		be %KD_FONT_FLAG_DONT_RECALC. (optional)
+ * @con_font_get: fetch the current font on @vc of height @vpitch into @font.
+ *		(optional)
+ * @con_font_default: set default font on @vc. @name can be %NULL or font name
+ *		to search for. @font can be filled back. (optional)
+ * @con_resize:	resize the @vc console to @width x @height. @from_user is true
+ *		when this change comes from the user space.
+ * @con_set_palette: sets the palette of the console @vc to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
  * @con_set_origin: set origin (see &vc_data::vc_origin) of the @vc. If not
  *		provided or returns false, the origin is set to
  *		@vc->vc_screenbuf. (optional)
+ * @con_save_screen: save screen content into @vc->vc_screenbuf. Called e.g.
+ *		upon entering graphics. (optional)
+ * @con_build_attr: build attributes based on @color, @intensity and other
+ *		parameters. The result is used for both normal and erase
+ *		characters. (optional)
+ * @con_invert_region: invert a region of length @count on @vc starting at @p.
+ *		(optional)
+ * @con_debug_enter: prepare the console for the debugger. This includes, but
+ *		is not limited to, unblanking the console, loading an
+ *		appropriate palette, and allowing debugger generated output.
+ *		(optional)
+ * @con_debug_leave: restore the console to its pre-debug state as closely as
+ *		possible. (optional)
  */
 struct consw {
 	struct module *owner;
@@ -96,15 +120,7 @@ struct consw {
 			enum vc_intensity intensity,
 			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
-	/*
-	 * Prepare the console for the debugger.  This includes, but is not
-	 * limited to, unblanking the console, loading an appropriate
-	 * palette, and allowing debugger generated output.
-	 */
 	void	(*con_debug_enter)(struct vc_data *vc);
-	/*
-	 * Restore the console to its pre-debug state as closely as possible.
-	 */
 	void	(*con_debug_leave)(struct vc_data *vc);
 };
 
-- 
2.43.0


