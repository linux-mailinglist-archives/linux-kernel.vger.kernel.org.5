Return-Path: <linux-kernel+bounces-161672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94228B4F43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DAAB219D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C2A40;
	Mon, 29 Apr 2024 01:45:46 +0000 (UTC)
Received: from mail.sipradius.net (mail.sipradius.net [162.247.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324DD7F;
	Mon, 29 Apr 2024 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.247.57.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714355145; cv=none; b=S0WyUrVLNZgcNcPMGGgDGPM06U8nTKxX7rZNVxeCxiwsayJqWTuIrk7TrPPe6+aoj2B+ktmbOO52RkQzDgo9JGJNVnzxYZN0mtxWDZXk5L5jOIZUyQyur0EdSZv0iy/HB1QN9s5TnkyEVX9px7+NvJ1Fww7USj9tcEoyzzZlTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714355145; c=relaxed/simple;
	bh=G3qIm/g9sVz5MyZSu9OSYoZ+Z/otVzauJdIA9Mn50zM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=E8VzMD2n4zuH6m7+b0+kJ74exNtkl0EVnrDsB9GF55UuswrWhvIXpWX/rr5eG6ba7XfwujlQPQ5mFp16qIKwPHrRBp8y30RH++RTNQW+7RV32zbi5xLC+lhX6EBqpSAjPds0hJD7Tp7zZHlndN98NiSTpK1XqQ9ryiFj13aCCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipradius.com; spf=pass smtp.mailfrom=sipradius.com; arc=none smtp.client-ip=162.247.57.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipradius.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipradius.com
Received: from mail-01.infra.sipradius.net (localhost [127.0.0.1])
	by mail.sipradius.net (Postfix) with ESMTP id 4VSR444dNLzW3V7;
	Sun, 28 Apr 2024 21:45:40 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at mail.sipradius.net
Received: from mail.sipradius.net ([127.0.0.1])
	by mail-01.infra.sipradius.net (mail-01.infra.sipradius.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IPa_zDlTEISM; Sun, 28 Apr 2024 21:45:40 -0400 (EDT)
Received: from mail.sipradius.net (localhost [127.0.0.1])
	by mail.sipradius.net (Postfix) with ESMTP id 4VSR434DmfzW3ST;
	Sun, 28 Apr 2024 21:45:39 -0400 (EDT)
Received: from smtpclient.apple ([107.202.251.131])
	by mail.sipradius.net with ESMTPSA
	id FBdNEMP7LmYRHQoAB1kcYg
	(envelope-from <sergio.ammirata@sipradius.com>); Sun, 28 Apr 2024 21:45:39 -0400
From: "Sergio Ammirata, Ph.D." <sergio.ammirata@sipradius.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.41\))
Subject: =?utf-8?Q?Patch=3A__Allow_the_use_of_the_uart=E2=80=99s_CTS_=28cl?=
 =?utf-8?Q?ear_to_send=29_signal_to_trigger_the_cd=5Fchange_ldisk_event=2E?=
Message-Id: <76A55B35-0954-4AEF-BAEB-61F2EF32CE95@sipradius.com>
Date: Sun, 28 Apr 2024 21:45:29 -0400
Cc: gregkh@linuxfoundation.org,
 jirislaby@kernel.org
To: linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.41)

Hello Greg, Jiri,

commit eb8cb8d62ff718d2fcf7583da8699ba29196f707 (HEAD -> master)
Author: Sergio Ammirata <sergio@ammirata.net>
Date:   Sat Apr 27 22:22:25 2024 -0400

   Allow the use of the uart=E2=80=99s CTS (clear to send) signal to =
trigger the cd_change ldisk event.
   This is particularly useful for the PPS ldisk as it is common to use =
the uart=E2=80=99s CD or CTS indistinguishably for PPS. The userspace =
apps such as gpsd and chronyd already recognize and use both signals for =
timing data in userspace and will now be able to use CTS for kernel KPPS =
to significantly increase the accuracy of the measurement.

diff --git a/drivers/tty/serial/serial_core.c =
b/drivers/tty/serial/serial_core.c
index c476d8843..8128f64c4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3515,6 +3515,10 @@ EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
 */
void uart_handle_cts_change(struct uart_port *uport, bool active)
{
+       struct tty_port *port =3D &uport->state->port;
+       struct tty_struct *tty =3D port->tty;
+       struct tty_ldisc *ld;
+
       lockdep_assert_held_once(&uport->lock);
         uport->icount.cts++;
@@ -3532,7 +3536,13 @@ void uart_handle_cts_change(struct uart_port =
*uport, bool active)
                               uport->ops->stop_tx(uport);
                       }
               }
-
+       } else if (tty) {
+               ld =3D tty_ldisc_ref(tty);
+               if (ld) {
+                       if (ld->ops->dcd_change)
+                               ld->ops->dcd_change(tty, active);
+                       tty_ldisc_deref(ld);
+               }
       }
}
EXPORT_SYMBOL_GPL(uart_handle_cts_change);

Regards,

Sergio Ammirata, Ph.D.



