Return-Path: <linux-kernel+bounces-10563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F581D642
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AF31C20E5E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66BD14AB2;
	Sat, 23 Dec 2023 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="t/UBIEnj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52815482;
	Sat, 23 Dec 2023 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703359224; x=1703964024; i=markus.elfring@web.de;
	bh=8Z2UWZfzwEDJ7zyg5026yhkAS0hTMuV2wF4BEAAq9kI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=t/UBIEnjvN7oB2bLLPsljeNxUqzFoOzsE4QDzqSCJCT4qjZ5OkeI4PtPH4ljvZqf
	 YMwYjZOL+1iCxOq2qK+7k3d5sHs0/xdmj4DEfeCID+xyYH2bBVp5SU65XHf5Mkz5R
	 WQpxXme1hPC2ytox8SsFv4iuUzJcluig9q5FvvpbjqHE/DAjg0RRbbeBcWcPRtkcz
	 B68xFK+/Y/h5tq0YVnwggj7fsB/uKKcefoVO4wKzc3LmHpk0iVBPRzgouXDk4L2wo
	 8bYAxHszh3mo7VokvyMQHQ6JsIktTgkSnXkJ35GtA0gWNNOZEikb8PyhDpdmn9YyW
	 56vUHm+aQaC/HA2QtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14ta-1rA9Gk1bMA-012k71; Sat, 23
 Dec 2023 20:20:24 +0100
Message-ID: <1f1c21cf-c34c-418c-b00c-8e6474f12612@web.de>
Date: Sat, 23 Dec 2023 20:20:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] powerpc/powernv/vas: One function call less in
 vas_window_alloc() after error detection
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
In-Reply-To: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PUZbbeRbt872OFeEXt9lEIn6ld+RqZBajG+dMGfiFv6L0AVghxM
 EirMQ786ltRpWXGQhVE0xl7H5xadbtnvbZb4IQsQOPy0Wb6/4zdbbuUHYoLQdG5mWhHBw0I
 zXGAz72cNkVS2hENSQ69tkYsbF3syfbS8S957H5pltWdGr6Sb1HVau+idUfaoxGy/Kv721n
 bUFHjuaFVb4uh9UggISBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sRhiRg8KBnE=;3gh1F8RKi1A1XBfWCxrCMFStW86
 g2+Afm0rgbdJcl0jdkSvChRNZIjHRm59WkygVdikuNzy2701I4ltV4W5PnDzt26VOg9k5kdMO
 Dh4Cq568qqQQFQn0Ee9JduIu+XayPiijIBe1hiLdNTe23f9vBPfzwU/6dJy1BDDMTndxuOgJl
 sKW70/lDemFNUnCOBIBHXa5wzVdafefxL2ocd2DWACtoMPxWUmPSRab6nUgg6yjx4bazK+qbW
 y8dE34CTcXhhPrYxDPG0P3yoQrFNgz3hV6/R7Tc52SV9L6Nc6PfKD09vg+ZJuqpLMRapg2GdL
 NxRQmasHCQql7JSnCsU7LkG6TQO7m9Gjtn0daqHAZ9REWol/Zu2/Ag1tmj95oUO2bPvprbh5P
 t4qWzcMf+xN3SSK+bpH5butBFWKBJoCRGqHq4QkAIrugTOUC8a0ny6cIIxuBqCGVJCJN/3rbR
 YtIhyDt/1QuoBHuC+PKF/wyK1zIcQ/KC6jjmFG5M7rZ+ozd2KHszq7Hw3iGLISiaLXdgz+IIb
 8sOKeWqlP7ybPXmZdXRedDdJx8Ls8tv7vFODK/54caYSCg/Km3HoTmemztsTJ5Un1dGdld4Y9
 7FvGjGagZgui7IDCkhfOILp8GcXFFj+xZQVbmIkkRCB41Q6Pg4h4T/4Lc/hXct3YQ5E1A3Q4b
 cEx6PiMN5UIHOr5clOkgFMWU1gkXlHy0Q/Z273rzco5qGpAs9Tw2ZL34TwilpWwHlRQP8urfh
 NL8vfFUHai683txyUZedqnNv0x6Y2Ef/wq8EEoWqpzbLykjNr0mWE5qweeL8UGoKqolN2D5OQ
 bONt5GAegXVuA/mk8eRCrwUyJfi3pBAWaJMWMgfeb0rRFOCKCr6o3zcX1sg4GS97uhg70Zvfm
 Uie1U+/gmDl8p8TevuxVw3V8vP5WMzqYzAeVfKcTZCvljc4UVdBlnlwMXBtfzi/a2bbz+S23c
 D7woujjRuruYUtUv6+xm2nrnQVo=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2023 19:35:13 +0100

The kfree() function was called in one case by the
vas_window_alloc() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/powernv/vas-window.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/pl=
atforms/powernv/vas-window.c
index b664838008c1..b51219b4b698 100644
=2D-- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -545,7 +545,7 @@ static struct pnv_vas_window *vas_window_alloc(struct =
vas_instance *vinst)

 	window =3D kzalloc(sizeof(*window), GFP_KERNEL);
 	if (!window)
-		goto out_free;
+		goto release_window_id;

 	window->vinst =3D vinst;
 	window->vas_win.winid =3D winid;
@@ -559,6 +559,7 @@ static struct pnv_vas_window *vas_window_alloc(struct =
vas_instance *vinst)

 out_free:
 	kfree(window);
+release_window_id:
 	vas_release_window_id(&vinst->ida, winid);
 	return ERR_PTR(-ENOMEM);
 }
=2D-
2.43.0


