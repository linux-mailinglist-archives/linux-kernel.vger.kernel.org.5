Return-Path: <linux-kernel+bounces-10766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD081DB82
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BC9281EB1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E2CA69;
	Sun, 24 Dec 2023 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Hqu4UcUa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDA746B;
	Sun, 24 Dec 2023 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436243; x=1704041043; i=markus.elfring@web.de;
	bh=Zjk3kgsKNF6CsWK02KUE6jMlFvAiyO4Gho2qFghKcKs=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=Hqu4UcUaOrw87RsWVlIy8U1+gjQ7zfGE6CnY5d8NnAryM6ZNqcB0O2etaNiI7gil
	 nLe9JSwIGKKbFziTZIaisfpKxxwihHyRVhS06ePczm9P8esri1EioaLev/Rvf7P60
	 wNz0XFn1teJ04zusd7JLkBvlPc6eUtDPtMqP6GyO59OVXrQUDWvive9XRXWbylJCX
	 zGY9Efij+L5VM0hJbUmOUmIZv26olhFxDYXsjYdpiFuZXnXLw420dx/9wrBVMDuV3
	 Dvy7c/jff6btR+c46RnyFZvfc/Y2QTtcRC6Qr2DE2VnqthWiTRjMyZLS+PwHV0bhq
	 rXmfBr00q1/mmWlJow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUU68-1rho8Z23xQ-00QqXu; Sun, 24
 Dec 2023 17:44:03 +0100
Message-ID: <f0f00368-9985-4517-8019-010f744a0e39@web.de>
Date: Sun, 24 Dec 2023 17:44:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 05/10] clk: ti: One function call less in
 ti_fapll_synth_setup() after error detection
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
In-Reply-To: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UBp6FJtixv/LocTBx22eQdkrXLyPsrH437F+wg757/SvLLcqXYi
 cEP/Ok44Yhwdi7ekjQIre6glYcW+sC41Em43GGSfaWxYTvmnJdlOL+k7MmWacyMyW+PglzD
 83qp/H0axL0uPwWYH7ryzKDfB8AqeOxEZFdxhkMo6bJHjQnW7iWlaEvR7Lb4wY39UOuQBk9
 YCxNVMKqnnagrbtWG5+/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gfIzGhCG8vs=;Af2OqGuJpj6NMu8KvFm8tK6zD3A
 tMSjSwQhZ0kFr/oqIs5v9QgMNkwIexNV6AZKa8L3YDejI+ReonrbE/QCB7IXb/9wOtRWxqBbm
 8ONdmdCoi9njmoOo2LP0gUluXOvG9k3u/L/KLVvDkxFzkdIpT08tai7HmTIt9WMBQmYesr4/z
 i900TvsAJisZoUvi/x86IG0UIyZ7Zvnw90oGQXqz7Ye7vt5mkao0pI3/zIGXp8FpfWsAN6HNx
 WRpY7WnPYnzyMajzjLBo5+kNXlIQOJ0Pzfkv/RUZYx/XEr0/V5uhERrXLNOIEQgIz5IJhgcoD
 MfSi7yw+PQ26Q/6l0c7+cYzZ7h+DtjE32bEDjaQsRHsMLH2bQVdm7J9oTh4pAZCzdyqMq0S7n
 0MleTUWEPUs2ziJOhJJV9DIvbP+ruLphXexA6XRKwv4iFzsKTb6FTg4Kd57NJvLJr2/gzsPJ/
 PezFow+Z6BVGD0fgys+8ZGWl2DRuUwXf+Xx5h5k1tDF1Yrgp4NRw8XM6kSATJ3DAAtF6RMYdU
 qKhrg//DcjJRUylaXD/n8k7mX8/2/8u5FQ45N2ZefEC+ZrTpohAPJflEAq4efGB1d4zIWggea
 9q7z9nsSKTNhDlidP3eOwo1GdYt2ep+FlOnukcfHQ8mjUuATER/op45ofPG3KAm77nbHCNsil
 +dGZ5Zi4N4Vru5DYIrfKezZwWxQCmXlBfrFpoPh58blbnKpZaj3pRU7FFev51TVJysgKwtWFO
 16HmLNEM2CB67xeJIepYEYO1XZj/7ItI7C22XeTlsysmz9ssEMelp6BDxRnnrntMLE9eZRodJ
 aguKXMI5AMYZ7860tq1j3ejQUpn5UD5zlwdcrEcXVuLNG06rdwyjDaeRAYY8XXvV66AvEPsLw
 4Gf4LE8vQh1IJhK9WFhGhYE9vQ6zVkP0NphVJXQYmfmvPZ5hcm/peO6p2gkCrMAVGM+J6T+3k
 9xSjz0kXLH1EoJEMGaF8dMGWMhY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 14:05:41 +0100

The kfree() function was called in one case by
the ti_fapll_synth_setup() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/fapll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index e9956e3ccd65..d4674ec3d7e9 100644
=2D-- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -504,7 +504,7 @@ static struct clk * __init ti_fapll_synth_setup(struct=
 fapll_data *fd,

 	synth =3D kzalloc(sizeof(*synth), GFP_KERNEL);
 	if (!synth)
-		goto free;
+		goto free_init;

 	synth->fd =3D fd;
 	synth->index =3D index;
@@ -524,6 +524,7 @@ static struct clk * __init ti_fapll_synth_setup(struct=
 fapll_data *fd,

 free:
 	kfree(synth);
+free_init:
 	kfree(init);

 	return clk;
=2D-
2.43.0


