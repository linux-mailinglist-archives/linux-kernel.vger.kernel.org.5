Return-Path: <linux-kernel+bounces-11152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF5481E223
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 20:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A381F1C20FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E3753807;
	Mon, 25 Dec 2023 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ewJKlnWB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B2537EF;
	Mon, 25 Dec 2023 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703531926; x=1704136726; i=markus.elfring@web.de;
	bh=IaAm0WH4z0TXKCwsXTfWMMZiVW5H3xtLRNKz36NJgmM=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=ewJKlnWBon/YFQvM0LsjiHpYgHYALpKQn17J9D8AEMznf7v7cDZctq6JcEzh8nz3
	 AEMIQOKMjDrnG9b7E0y5sAYyp1o35gXrHKAAR8s1FZU0Ng3EBYnX771dmtyYA6rTp
	 QLZh5827+wkZonIYpVk1d1MxzteLtswFeTsKjdp/UqoGcjy2G/roXUcCh3nZvRD5N
	 WiMrpll4WYbMlH6h0Jt/YYSfKCENFYU2a1otZPgqNAF9nJMyaIwOTtArk/kxbKoYy
	 Y8NfzW5NBqUcyziXtkwsWo/Wle3sq3U+kead83/rXt+naPytC8d3gnywNt0F1Lh26
	 tz9cjlkqnC9ahn7Y1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Jl-1qtoKb1un5-00pEOD; Mon, 25
 Dec 2023 20:18:46 +0100
Message-ID: <07ca2474-560f-4cbb-9740-db987227416a@web.de>
Date: Mon, 25 Dec 2023 20:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-tegra@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] firmware: tegra: bpmp: Return directly after a failed
 kzalloc() in get_filename()
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Dx6vLiujrwX/styXNp1tR5nNZwKVUpxfUgckaGAeQMhLhd72JR
 g0k1oxnB2Q1MhQ/TSR/IL3LKWsuqy+7AKhSTDj3Pr6sfEtwvaC2JVFbseTlG2oBlnCls4d8
 SBqOZFh5sZKijbwlfQLmykM/YS3eFE59/s0L5WrFqcju9/NvOeKEbFzQwJRp+XdiaJVbkhV
 GX2BiN4pFB+1gRGNF4drQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9EhpqDUh4eU=;/MCHgEjnuTlr8ORYlyOXc1Ibztp
 P/eDlh0Xd+VwkT1u2/mXCgGa0USATF/EuWmdAFDe1/szSxKf5GLUmE3cd9TZX4wh0DdT6Buf2
 J0ZBXt2zDnr9ABwV80Nc26px4XJct7b1M/KpCpPv73FF9vZ4HD/1I2hi7XSoLRSsg+yn62Qcj
 clL/Do5LfXZ81gDQOCaQtImxCDgY4aqmnfviideEoQ4Vx/PgUY58pHe3she58E7CxCwKdVPw1
 ABQxnrQ0mx2iuIvYf7TfPWlgx1rH+gghNu8XFJftZw4NIlZ5W6CW9XiZGWyqKqAPnb3ABlag4
 HClPdWbN6x5Duk/c1zdKLE9o7GrGzzrAjm/0VCKuxiUxZBpKcUyBjdDYRg1jL12t9VLUc8eUR
 I9fEWTWTLwvgqpztDIoNn7rkdeu90iqM0xZi5JN6TFQ/m3DKF6NuCqfTWrO/arBGuMpY29VWM
 YUtI6to0e8O7Z6c10nfbFW0ZkvcT+tFVUxxDD7yCuKUv2ZFsm+bpCb6fiBB/LnWN4+kDtRAzP
 X3vkUQZA49LI2dgeQHtjJIibEY0notIcdDLkW9KLjN1fvEeSWVgWln9i8DVCi6sWhpOiGEwp6
 s5I7FzyatBNPgruwLuADNTDj3rfXrFlo59zgn7S1zSkLcs6OGiA3dGAjagN5AB+RrjKFI8mdn
 /N07gXIcvYNZJBAfSzp/hJVxyplUFjV6zCEYZcUXlOLgcdqPOduphTekxQO+59rix1Ihy5+IC
 n7LxF9c1hOHSxdnhwUklF0FuSVtboT4ZmkQrckEYwtMNtBrQ+LXaET6fs957iv88kN7CvIdAr
 EI742ipRd1pzF7p1KBU/rbkVLqSAuDL5o70sxru9jvvJfkoASUH1WcfO8nXsSlGp+V1ERAjya
 NAHQTFWsfnKtsoObvMiACa3sRALKBRGVgmz4lugo9HFoVV3kNKYqT6Dw2+pFBYuoXz5M+FOHL
 7jfSNg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 20:03:56 +0100

The kfree() function was called in one case by
the get_filename() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/firmware/tegra/bpmp-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegr=
a/bpmp-debugfs.c
index bbcdd9fed3fb..4221fed70ad4 100644
=2D-- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -77,7 +77,7 @@ static const char *get_filename(struct tegra_bpmp *bpmp,

 	root_path_buf =3D kzalloc(root_path_buf_len, GFP_KERNEL);
 	if (!root_path_buf)
-		goto out;
+		return NULL;

 	root_path =3D dentry_path(bpmp->debugfs_mirror, root_path_buf,
 				root_path_buf_len);
=2D-
2.43.0


