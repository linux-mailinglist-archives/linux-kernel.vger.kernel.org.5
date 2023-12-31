Return-Path: <linux-kernel+bounces-13743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E0820BDC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C511C216C4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2588801;
	Sun, 31 Dec 2023 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QnIxKZPM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87C63A7;
	Sun, 31 Dec 2023 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704037144; x=1704641944; i=markus.elfring@web.de;
	bh=ZBp8NyuXlvFPMABKUXF8u5UDLChRQXub7cPUR3cIVjI=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=QnIxKZPMK9+YyKmT3slf6m6F9R2FY4N0VZWMk1DGku7qZQIgPkyQAi6NQQyKSpER
	 gNVpQllYSFGMscovXE2hzHOQZK3ctdd4ZlQwji8zzIvwzV3aEwwxsM4q1X2k9DjOB
	 LFaZlkwFsd6qanvmDmFDAhI8OyLx2W4zin2Z+LblMFZrCTx1K/MI+0LVeT7bmK654
	 glFmIP2xBraApiMNmf8km9aanZgKZF49yk6UEPkUsKcituSQPBeljnqhv1FFsNODp
	 EnlfvbA4Cx4AW/UAak0dsdy19/27IPAu3Pt9r7VB9XppyZ2gnuiSMHM+t4EJFQUuI
	 RklHZMptE+buQDSycQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1rJxu40kLo-000R5I; Sun, 31
 Dec 2023 16:39:04 +0100
Message-ID: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
Date: Sun, 31 Dec 2023 16:39:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] packet: Improve exception handling in fanout_add()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YuiPoJK/DkWYUtBEuYaPtFkOwt5+qDZ+CpW20nQ/SsrN29Hf2MG
 zfl4iwkrCLCOpZSKJncaR/9pFlhaLpSm6kjB0c5NiKIAXXHtYK/1bKGkQV9QMf3ap9dyVla
 1SrT7wDeY9K4wI7L8naBNw/aoisFycfYx+RqkwBqAT1fTRwSoJUonUm5bRRW9SwN0/fs9bn
 yKKU0YZONZCadetKs65/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PecX/maW88s=;PRkbnBeZHNnfH6i7gmhwN1xAa65
 CEQsb2bwOI4O+ELnibNzZmCTKgR1Fx8p2S+7jEalI8stWrYWSWF+VRTqfYI2KAPocipY2SneW
 kALaiXIjH8v/MIPsmvB89xTY6QnTJMX7ro9pcokqRfjxscUDUjsUD6Iw806XVYYcPKSmooHXs
 68A8xUw00Yi9mxE2b4M7grV7tYdkZsoRY1IeKztDoQnFuvZgThFWgUUtJjcBFg9wz3IOUU+Jz
 iufdnUzdYuNCQIOam2+wBsXgHrMTR4VzSIIhkoIOGj0jcVHX3aOE6a7m9OxCCm349cC0b2XtB
 YTREly5DBOIN17sz95wELvnGRD3ZSNJjdTTc9JxgBkK66Yyj7vwz/kSpZFeE08Ty35B4tsoYD
 gZALL2DOaOwAnM+k6LuhLzWPJ8EYiFaiDWMMP2VWo/LKjohFArbKlYPQFcAsJivXkXMzVA+lz
 2v0/Tj4/Idj/ZMnpslzqzVFnC+Pv+pVa+XFHXtTLjyARn9apzLnqh6N9KNPD197gedWt2Nwbh
 yj7xxYsenWjewWwdn/jvAc7LcggMJ135yoVpMSumYoCItSFnbPxKJOapOq6dmHvPLwOy6awOo
 UmKFlnxUSoYq73wfctggz7ay5mFeOPK5X4exq4i8zUCulZ9udWiuUGzdoDCXFYITboImGwIXj
 cyYrcOWt94y/VrHeSwk6dBdsU4gaRBtsNQ13oUOrxtUbH+lcZ+gkKlKPCxbBPbo8CZsssxunz
 V7xUsslfvz21f+u8haZwKXIEN0DlK2sYbraJARBUFN/xWFzvvCCcWvJQNji2Kn5UuWjtaTSHI
 17+KirMbBNpK4D/3+WFj5+9fkUfx5b1ZotX3eY4cWzttAwE44pMmzNhzjLIbxLB4AAydJH2wg
 AJzO4nWcr9dW3iD/NTkN+y22izte0wJ4xo16Vni5wVSJxHEijmhmTcIuOo3DMNbiEG/u38T4Q
 4l2v6HUQVU6njCwUDctC0Uhp9m8=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 16:30:51 +0100

The kfree() function was called in some cases by the fanout_add() function
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/packet/af_packet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 5f1757a32842..0681d4f1ed85 100644
=2D-- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1712,14 +1712,14 @@ static int fanout_add(struct sock *sk, struct fano=
ut_args *args)

 	err =3D -EALREADY;
 	if (po->fanout)
-		goto out;
+		goto unlock_mutex;

 	if (type =3D=3D PACKET_FANOUT_ROLLOVER ||
 	    (type_flags & PACKET_FANOUT_FLAG_ROLLOVER)) {
 		err =3D -ENOMEM;
 		rollover =3D kzalloc(sizeof(*rollover), GFP_KERNEL);
 		if (!rollover)
-			goto out;
+			goto unlock_mutex;
 		atomic_long_set(&rollover->num, 0);
 		atomic_long_set(&rollover->num_huge, 0);
 		atomic_long_set(&rollover->num_failed, 0);
@@ -1812,6 +1812,7 @@ static int fanout_add(struct sock *sk, struct fanout=
_args *args)

 out:
 	kfree(rollover);
+unlock_mutex:
 	mutex_unlock(&fanout_mutex);
 	return err;
 }
=2D-
2.43.0


