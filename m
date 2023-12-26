Return-Path: <linux-kernel+bounces-11693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF7181EA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4392B1F211A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AE14C98;
	Tue, 26 Dec 2023 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ViBQSwm4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF9EAF2;
	Tue, 26 Dec 2023 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703624925; x=1704229725; i=markus.elfring@web.de;
	bh=YYLqMBA68P6qrY58GnIyIrx0OrX5LlW5O/TBIpKpe7Q=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=ViBQSwm4HC7YuaI1t0CE4L4P/ofC46FGipX1JBgEB2stGTc6LdSs6MFdwYJvzXNZ
	 RcU91f1qodRi9jijTbDVVujie/ROhbpr8oES5GF8Ei30OQMoBAPXnZzhW7936eMbD
	 812TmuCkbonhKIWukbyzDFxKEJHLJ8VUVCiRewkVh2fRlbkSzXiDK0zenwXuOlAB/
	 hv3vdDZh8QGUlidkKLXIbGSHik75lsPUKL4lWELCJ35M+8gNzciLl/20B+wHQVf0n
	 WyHUU3COb6Tnf/AxOkIXZhN74HKQVrX23zf5e28Uahc04cGThExt5PDhKeVGHH9Kv
	 0uF3I5YA9kZhpLWDbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1rg8NY0GD3-00SlfO; Tue, 26
 Dec 2023 22:08:45 +0100
Message-ID: <c73761c5-7150-4f20-9b3e-1da680400250@web.de>
Date: Tue, 26 Dec 2023 22:08:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-leds@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] leds: trigger: oneshot: One function call less in
 pattern_init() after error detection
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yTWf/3pMdRLUxPK+7SigLP5bPdm7FDsywYZQ9mwWxZfd5whVnCt
 MpaG/wwAiJ+sAZKc6e6X1Oz/1ZvXtXjnkODZUnt+bPGTOKeqGOVarq7b09RvfwmwaobPYhv
 KDhF1hQXXBN8GuJ0LTAHm1CZ4IxwZK1aaTGupnbJ02bufrYt/IAux3FnT6U3qknPSj45Q+/
 sM4ldrJWXAvku4s9LD7hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gyXZStYDyoY=;GDeU6aTCaab8G0WZXtNI8pnZzWu
 AE4N9T4klh2nfVsoFShDJW1wxRW8rFfrqpo2fPA1EMQ3gvMhs06+w7BRKvHNEBsyBBYQnb4fm
 47do65ab7gRI4Qeg23lUUUYYhg9z558S4k+JPdkk96KJqK21PxbcyyuRcfCqb/77cbigVAAG0
 olOPq2zwGtDuxkf5iES9zBRvPBlrI4CztB0TRxSj4APatPxP+BlumQbKW9TrSogAYGIGMTfxe
 PBOYShATgW2D7tGlodpPfDp1XKEFwkGqs/RSoX+sJ01ouUmVwTFSHq11MPKpoqLGjfUiK5dlG
 Se3gVVyNUtAQmwo6grggI09WjSDeaU8Vun/z+4b6QbOUR6y2KZhNWcCp1bRi6vQF2RucgDq/a
 0+R1bcWHISu2tq1s7M06PabcEPd+G8vm5ciL5ngRt074aoH3GvPN9Ajy7QBAnE2dfhLiHoBmS
 1CLZlkfmaiMqU6MCjH6fkzXSv5ZB/fS5/s3YdSDXep/QdmhN/wkco7s3tfJfyd188vhHMts3+
 X2lQ8clwWngpuOCgo6n+MToFfUOnM5If/rU87/1U6st0oZ77rvpXEh3m3RwKscEzUnnsp0Een
 /ECc7rgoF4bhE1kq+IANw9UP8dGJnPA6hsJeaPQoUBq64lJJOus3xYsrztwOO0t7HXUQJqdSi
 pMPZkR1CxZl9fMcELNN2x1hdnb11WI90NWRU7WU39Y4nkkkeL1eaW+1qIY+oTzTMUVh9QPjeH
 grRxIWi4tyjWTJW086I+88Blwlqp5VOxFnQC8ADJ097tsnRXOfOXOd+aNwzHfU2Zgj+MfOxq7
 M4K0w+9PwvKNwSE+MxO7iKGoJwE+lqBjFiXARibkFLwK0L62KlRJJX0sWvnKD6sudciS20AKu
 bEJD8G9V2FNHGft1QPNc8HDGkIosSoxjuw0mO4f6HbS4tTqCleKdBahpjY4M6Zrphe/bdxMRE
 n0Eupw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 22:02:08 +0100

The kfree() function was called in one case by
the pattern_init() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/leds/trigger/ledtrig-oneshot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-oneshot.c b/drivers/leds/trigger=
/ledtrig-oneshot.c
index bee3bd452abf..31061ec0afe6 100644
=2D-- a/drivers/leds/trigger/ledtrig-oneshot.c
+++ b/drivers/leds/trigger/ledtrig-oneshot.c
@@ -134,7 +134,7 @@ static void pattern_init(struct led_classdev *led_cdev=
)

 	pattern =3D led_get_default_pattern(led_cdev, &size);
 	if (!pattern)
-		goto out_default;
+		goto out_settings;

 	if (size !=3D 2) {
 		dev_warn(led_cdev->dev,
@@ -151,6 +151,7 @@ static void pattern_init(struct led_classdev *led_cdev=
)

 out_default:
 	kfree(pattern);
+out_settings:
 	led_cdev->blink_delay_on =3D DEFAULT_DELAY;
 	led_cdev->blink_delay_off =3D DEFAULT_DELAY;
 }
=2D-
2.43.0


