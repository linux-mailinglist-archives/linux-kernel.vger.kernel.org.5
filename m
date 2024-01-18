Return-Path: <linux-kernel+bounces-30214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5531D831BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062E82894C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C413B28DBB;
	Thu, 18 Jan 2024 14:39:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0E0288DD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588773; cv=none; b=nWNZ5IPA2BHQSS6MqyAvZu3N/ZdFv6rwqi8fjwBkVKEgor5KQ/hD3TXxIHoIwA6ZdCcqu8RAHw0OB3hY3giGVkmOExpUhtxhf2wjK/hwjAhzoyc8m1QR5paJDKkfI86WdcWKE5lY+6afsT1hpFDNshv6xOK+fRcWlefsCwWCC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588773; c=relaxed/simple;
	bh=o1pfL9AYoWWMo2KKUd8aotsevnS+yTBUAOMDAmuzcAE=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding; b=tRgWysb5mw60Q3so2UGwIP6er3uvySpeTZp5RV0n7U0cQa/nfLtA4V9g4gpJw3x569q4t5aF4RxacVoMFCiHZ+fheu5OU0/KNJB0Ow8bMpdB8+ltxbLGKpHqybdEKieXRTWQweWtFQitKpG4hzv3V47iIYxaJA59U70mKzxh4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E78C433F1;
	Thu, 18 Jan 2024 14:39:31 +0000 (UTC)
Date: Thu, 18 Jan 2024 09:40:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Kees Cook <keescook@chromium.org>, Nathan
 Lynch <nathanl@linux.ibm.com>
Subject: [for-linus][PATCH] seq_buf: Make DECLARE_SEQ_BUF() usable
Message-ID: <20240118094050.3b890e98@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Another update for 6.8:

- Fix seq_buf warning and make static work properly.


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 7a8e9cdf9405819105ae7405cd91e482bf574b01


Nathan Lynch (1):
      seq_buf: Make DECLARE_SEQ_BUF() usable

----
 include/linux/seq_buf.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---------------------------
commit 7a8e9cdf9405819105ae7405cd91e482bf574b01
Author: Nathan Lynch <nathanl@linux.ibm.com>
Date:   Tue Jan 16 08:09:25 2024 -0600

    seq_buf: Make DECLARE_SEQ_BUF() usable
   =20
    Using the address operator on the array doesn't work:
   =20
    ./include/linux/seq_buf.h:27:27: error: initialization of =E2=80=98char=
 *=E2=80=99
      from incompatible pointer type =E2=80=98char (*)[128]=E2=80=99
      [-Werror=3Dincompatible-pointer-types]
       27 |                 .buffer =3D &__ ## NAME ## _buffer,       \
          |                           ^
   =20
    Apart from fixing that, we can improve DECLARE_SEQ_BUF() by using a
    compound literal to define the buffer array without attaching a name
    to it. This makes the macro a single statement, allowing constructs
    such as:
   =20
      static DECLARE_SEQ_BUF(my_seq_buf, MYSB_SIZE);
   =20
    to work as intended.
   =20
    Link: https://lkml.kernel.org/r/20240116-declare-seq-buf-fix-v1-1-915db=
4692f32@linux.ibm.com
   =20
    Cc: stable@vger.kernel.org
    Acked-by: Kees Cook <keescook@chromium.org>
    Fixes: dcc4e5728eea ("seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_st=
r()")
    Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 5fb1f12c33f9..c44f4b47b945 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -22,9 +22,8 @@ struct seq_buf {
 };
=20
 #define DECLARE_SEQ_BUF(NAME, SIZE)			\
-	char __ ## NAME ## _buffer[SIZE] =3D "";		\
 	struct seq_buf NAME =3D {				\
-		.buffer =3D &__ ## NAME ## _buffer,	\
+		.buffer =3D (char[SIZE]) { 0 },		\
 		.size =3D SIZE,				\
 	}
=20

