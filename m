Return-Path: <linux-kernel+bounces-29811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5568313EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A901C22904
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F052CCBD;
	Thu, 18 Jan 2024 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITZ4P6Mq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98952C878;
	Thu, 18 Jan 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564731; cv=none; b=Xin0WNyctG8Ew2jwcvT54Jorg4JQp6rAMGkus4YARKJswpox9eFwf9Tsjs6TOVsQOwHw0cMtmNtfTIbnUxqI+f9NwA33nN9L+CsqrFIgPDMpVtzxwDtR2c1HTKiv/pejbdy0qB3vIFsfkbYqP+PeObgLkYgTqvitO6rpjmP77Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564731; c=relaxed/simple;
	bh=nvYd6isOoXNLl9Y7Tt4RQvNbFL1i4ad9TROebYx41cg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=bpttzLICG8jz52FhMO5KnTXhdXrZbH9ZdQVCzLJ9ilhIfSFIORZnuf2gc01fVtQbkxDrNMdE6bJuf6xepAZX/ndGxmxCYZwK9mAgosx0JGZhXU8wd95rc6F/TaYjhZwM9A+82er6YlXv5q6dC8lOZNyx3URdbsEXkFSBcufwadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITZ4P6Mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2103C43394;
	Thu, 18 Jan 2024 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564731;
	bh=nvYd6isOoXNLl9Y7Tt4RQvNbFL1i4ad9TROebYx41cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITZ4P6Mq4K83xZkDiJCEeANLdmMnsvIczvgPxZogZOLeFKki4/+vqat+l00bCNSY1
	 yn1mL3v3jHxAZJkQkEvOBaOb3n9na/vdomfrRHTvzbCTDYz8/Y3Vw2fRnSC5J5Z2h0
	 DF4dXGGhXr3cfBo/FTOttmKW7ELamSBd50hqTae7NYMSAQ45yMJgJKMahYE1Q5Y1Mz
	 OVJ2zjvaAe5GvtT+yWrS3GmPIqxpeNMbcyDVL7orU9xZ7eE6SYV7GAhCUnto143GRg
	 J914Q1gFIk1c61IJuoMyEOYf7wV159Hr/0LTsZOPkyUk+ftxk0/8kkXwgvkc5cMbGK
	 llyniMC9mXTtg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 24/45] tty: vt: sanitize consw::con_putc() parameters
Date: Thu, 18 Jan 2024 08:57:35 +0100
Message-ID: <20240118075756.10541-25-jirislaby@kernel.org>
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

Make parameters of consw::con_putc() saner:
* x and y are unsigned now, as they cannot be negative, and
* ca is made u16, as it is composed of two 8bit values (character and
  attribute). See the con_putcs() hook, u16/ushort is worked on there.

And document the hook.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/dummycon.c    | 6 ++++--
 drivers/video/console/newport_con.c | 4 ++--
 include/linux/console.h             | 5 ++++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 0a69d5c216ee..1874beed0325 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -50,7 +50,8 @@ void dummycon_unregister_output_notifier(struct notifier_block *nb)
 	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
 }
 
-static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
+static void dummycon_putc(struct vc_data *vc, u16 c, unsigned int y,
+                          unsigned int x)
 {
 	WARN_CONSOLE_UNLOCKED();
 
@@ -84,7 +85,8 @@ static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
 	return 1;
 }
 #else
-static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
+static void dummycon_putc(struct vc_data *vc, u16 c, unsigned int y,
+			  unsigned int x) { }
 static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
 			   int count, int ypos, int xpos) { }
 static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 55c6106b3507..9b5c0118873e 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -367,8 +367,8 @@ static void newport_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 	}
 }
 
-static void newport_putc(struct vc_data *vc, int charattr, int ypos,
-			 int xpos)
+static void newport_putc(struct vc_data *vc, u16 charattr, unsigned int ypos,
+			 unsigned int xpos)
 {
 	unsigned char *p;
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 8fd96a5fca5f..92d57e5b3009 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -39,6 +39,8 @@ enum vc_intensity;
  * @con_init:   initialize the console on @vc. @init is true for the very first
  *		call on this @vc.
  * @con_clear:  erase @count characters at [@x, @y] on @vc. @count >= 1.
+ * @con_putc:   emit one character with attributes @ca to [@x, @y] on @vc.
+ *		(optional -- @con_putcs would be called instead)
  * @con_scroll: move lines from @top to @bottom in direction @dir by @lines.
  *		Return true if no generic handling should be done.
  *		Invoked by csi_M and printing to the console.
@@ -53,7 +55,8 @@ struct consw {
 	void	(*con_deinit)(struct vc_data *vc);
 	void	(*con_clear)(struct vc_data *vc, unsigned int y,
 			     unsigned int x, unsigned int count);
-	void	(*con_putc)(struct vc_data *vc, int c, int ypos, int xpos);
+	void	(*con_putc)(struct vc_data *vc, u16 ca, unsigned int y,
+			    unsigned int x);
 	void	(*con_putcs)(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos);
 	void	(*con_cursor)(struct vc_data *vc, int mode);
-- 
2.43.0


