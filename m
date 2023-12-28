Return-Path: <linux-kernel+bounces-12520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E0B81F60A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942E0B2270F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4110463B6;
	Thu, 28 Dec 2023 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VInzAuRr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FDC5671;
	Thu, 28 Dec 2023 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703752943; x=1704357743; i=markus.elfring@web.de;
	bh=zmkIk95uAnIs9Eha5efh2mV5ML9QPD6Kxw6Fd4L0ayI=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=VInzAuRrkOQMpps9N+++fUF5AregOalMHU4QRqu4YesKz9EvgRS8WQvsJGNmYuMo
	 r5Sf610vgM7T1HV0kUggWIiGcKIKAKXse2nmwVt5n2GBePiNTGp6GMD3q4Ve1QlI1
	 w/w5mnkyPJsRux8Pm2V5csAc6cbP2z5F9nIVW4tYy1wFL14GVKliz5z1Gs6E1lAuf
	 kZeZCrO0DWFR1y8q4RnmmHRkxlePqz30AkLmuyjgKKYKysHmlRWsLxhu/j7NJSe6O
	 APAuZGG8S1pB0DEPmN4r/6SrNR0QwYYtPgg6liX2aMPQ0bT2o2zLM+vu2pwefC2eP
	 hJA33wVwTsEKFZ5hTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4bA-1rPtlV0tYI-00BlBh; Thu, 28
 Dec 2023 09:42:23 +0100
Message-ID: <362ee824-fc53-4e19-9529-8b621657635b@web.de>
Date: Thu, 28 Dec 2023 09:42:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] platform/x86/amd/pmf: Return directly after a failed
 apmf_if_call() in apmf_sbios_heartbeat_notify()
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rDi8Bd+8M7STwBu7WjWgU68UfYwOYphhC9zo9TLUjNL2/gw4ycp
 J4dC2LEgVEZ0cy4oZuKBDKYc/rrlyV3gHUvEm7tx3Y8s7JwsP1rBFIBYtsc1HAKJLVinrMW
 5GdwGEUlddGfgLCN/j6TMOPltug/QW9cSIQRzKetAXxOggTRSx0bs5VsUq6Ntph6V8Aa5iU
 wqhVApVWx09AJqMbdLo7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nkcMUES01yM=;nDLmN1ZD4ajl/27Ge923Xf1FUDM
 MP7MVJK28721tsglhTeWNgNnkqAfHa2BNDDbWRUT8eap3W58ga6tjws0Mmp/669BEFcKozGkl
 sZEuZEusG4MGTsc8/C42yFGVQXKND1zsok2rnjiqe3bwTzH+IfVkLNT3x78ONettyfbN6Ox9H
 d2ECedJZdFLF69Jy/L59MiW8hLxXQ8W6F3dEtgk38b8/2hrV8JcPXvDpuJKh91aX3ZA5icmEN
 RRh+NNW1KkFFEs0PfBZEmdksgrSgcP7Ik5zc/0zntnqR7uT614JmX9JOnh/DcIvihTA8PfB5G
 Fk8+1sS7pDLAp4PMZeWQw7z90W0IV6OZIs1Si9cvLBhCClcv0GJq6Nrg07gvT4NAtAipEW3hu
 GcnEGI5xjYgqQQX/uWDpfwKdQbjOr64zOovIlBIOMA/Zlbe3u0N3ZD2zhd9nyIzmm+d6Ql/7g
 +YHTC8AA9rr3LfMsL189/vl7AMfssb7UBj0//07wEuprvWCatqx6MgYTxEyNifTS8kgsnojio
 lkKlb5scziE3v915s6WdyWldPbMuo4XifACJxmnpVGTRegbVWf3v60ZZ6WXOdrpD5HOfTzuPo
 lf51sDc0XPAVSWMcQESKdsCLmuddMYF+ZKhELnXJ7MtyBKtWNyj5QFikjyGLReu0IitwdeBoR
 Z5wvK5STs82RUa8JTeDpJL/UCHzX3zGPeFqNWN/OUQE/XFa8WRNjeDgPqQC5SI0J02OBooV1I
 +f1NXCiD8pV40vgHLMXLJjbL98l/ykK4Jr8IuZJ/AmQ5qrMjSkW8ecU8Zumo3Y383NHjJdavr
 YGGVGfhElG/GBQaIGpUtAI4lxDpa7E/x2eySGjcRXwhb5AdV+9ZySacQDprD/4gvqZDOJykDc
 tzVJVj3oRpBJSXxDHrlBZtKBCoE4bTmfRm2vTS9WqYx6wy+ylmeQPIi/YQKPBY4vQCjCNtXMt
 rZsEJA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 09:30:54 +0100

The kfree() function was called in one case by
the apmf_sbios_heartbeat_notify() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a call of the function =E2=80=9Capmf_if_call=
=E2=80=9D failed
  at the beginning.

* Delete the label =E2=80=9Cout=E2=80=9D which became unnecessary with thi=
s refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/platform/x86/amd/pmf/acpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/am=
d/pmf/acpi.c
index 4ec7957eb707..eb367e38c5ab 100644
=2D-- a/drivers/platform/x86/amd/pmf/acpi.c
+++ b/drivers/platform/x86/amd/pmf/acpi.c
@@ -135,11 +135,9 @@ static void apmf_sbios_heartbeat_notify(struct work_s=
truct *work)
 	dev_dbg(dev->dev, "Sending heartbeat to SBIOS\n");
 	info =3D apmf_if_call(dev, APMF_FUNC_SBIOS_HEARTBEAT, NULL);
 	if (!info)
-		goto out;
+		return;

 	schedule_delayed_work(&dev->heart_beat, msecs_to_jiffies(dev->hb_interva=
l * 1000));
-
-out:
 	kfree(info);
 }

=2D-
2.43.0


