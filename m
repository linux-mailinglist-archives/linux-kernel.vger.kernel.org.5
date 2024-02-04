Return-Path: <linux-kernel+bounces-51765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71E848F0E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0278B21A1F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB8C22618;
	Sun,  4 Feb 2024 15:57:42 +0000 (UTC)
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D70225B2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062261; cv=none; b=D4JnXyA4m1mWpr6eeePl7QQ800r5BuhC1+qJaANjOdmQbKZ6gMPEyMU0uysMF4Hfdut1bQatWBD8s3mPILNgxFl/7ry1FOc3Q/vluXpwsXA7LTnJYmOFW4kro5R5Td5eRf1KUi6vEitDw6gs0dXLw56AIZO7IliwozXmF8VQfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062261; c=relaxed/simple;
	bh=AXPeDLFZd5lvWg0r9XsdD0jCLFcFq91QvmlBpnnJNyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dIeiQQi8dG9guBh8Cwqc4RgD7o4RiQj3rc+4kX4vezX5HoBpxgvimdj6M/i3lrDYNKuo3YS67IFVIu+j6Kt9NetOr0hfIf0lbUZJNzX6V9Sv2MjgNPBSAF7UBcUCueyIbyNPTuEIKDPe9S2gZJVO5Th1TxH0gBZukmhg3BbrEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id F09E3A02C1;
	Sun,  4 Feb 2024 16:57:36 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLfM5EvYB1wa; Sun,  4 Feb 2024 16:57:36 +0100 (CET)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id C969AA02C0;
	Sun,  4 Feb 2024 16:57:36 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rWesC-0000000ERlw-1iWL;
	Sun, 04 Feb 2024 16:57:36 +0100
Date: Sun, 4 Feb 2024 16:57:36 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCHv2] speakup: Fix 8bit characters from direct synth
Message-ID: <20240204155736.2oh4ot7tiaa2wpbh@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	speakup@linux-speakup.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)

When userland echoes 8bit characters to /dev/synth with e.g.

echo -e '\xe9' > /dev/synth

synth_write would get characters beyond 0x7f, and thus negative when
char is signed.  When given to synth_buffer_add which takes a u16, this
would sign-extend and produce a U+ffxy character rather than U+xy.
Users thus get garbled text instead of accents in their output.

Let's fix this by making sure that we read unsigned characters.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Fixes: 89fc2ae80bb1 ("speakup: extend synth buffer to 16bit unicode characters")
Cc: stable@vger.kernel.org

---
 drivers/accessibility/speakup/synth.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Difference from v1:
  - Add empty line for style.

--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -208,8 +208,10 @@ void spk_do_flush(void)
 	wake_up_process(speakup_task);
 }
 
-void synth_write(const char *buf, size_t count)
+void synth_write(const char *_buf, size_t count)
 {
+	const unsigned char *buf = (const unsigned char *) _buf;
+
 	while (count--)
 		synth_buffer_add(*buf++);
 	synth_start();

