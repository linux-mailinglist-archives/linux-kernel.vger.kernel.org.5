Return-Path: <linux-kernel+bounces-13659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C92E820A71
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031701F21F03
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B5320E7;
	Sun, 31 Dec 2023 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TJ6Xc3tu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49469185D;
	Sun, 31 Dec 2023 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704012145; x=1704616945; i=markus.elfring@web.de;
	bh=qhknSDGJ/5EFhUiXS84uiALl32Ogpu0VDaqNX9XNDOI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=TJ6Xc3tuT5BWP7DrgY0OAklTPEiHTFgyaKlc0saWRF+9GEaaL4I6iR9aZo4nMM1W
	 VhYyIvgN20v2dCTigXqEf2GsVP0KnA2e4sZFYbE1c6VpBbf1bhBCYHSCcrayRzkCS
	 Gy4yS04lyKn9KBRTsIclrpcUyKDUXIeWkX0ymlWSPr7DXI99wRfdoJybb3MbpQp9+
	 w4zHvLUdB+Xy9w1hXLf41qQ26fR3+Gc9L3lASmJP8I1yDzzxpVaNYBSd2bVY8h4HO
	 EFwZroV/shsOKIWEK7hVakLc7oy9Aobv87Hwkjh63Q2wBJ+xa9Lk6Vy2dj3zDIA7Z
	 hPKC9Pc8mG7aaG6zrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxiW-1qvkz30as4-00kXSF; Sun, 31
 Dec 2023 09:42:25 +0100
Message-ID: <b9e00c7c-2c74-4de4-a794-df3338059a03@web.de>
Date: Sun, 31 Dec 2023 09:42:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] gcov: Return directly after a failed kzalloc() in
 new_node()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Peter Oberparleiter <oberpar@linux.ibm.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <ebffa8ea-8d0c-4b83-805b-754e25bd4603@web.de>
In-Reply-To: <ebffa8ea-8d0c-4b83-805b-754e25bd4603@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dblaX9Kqfi7kqmD1MmvGZyBFiMSa+A/t6npRduaddmwJki6rCCl
 RbORVETR70HNMnFupcJKIf+tvbFJMddVRwjCHvb7XJfq+vy22VtvmzOrj7TS+f2tdwpVng6
 fU1+qKMU1APyCAzKNiiXSu3LKh8Glb48vNR94VexFdp8fpI2RIKz1Sypi6h2s1MB8w7BUZn
 lcHGwmZUY1dJcGhlbYf5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2D6hG3Prbpo=;g3s2eWiHgFOxYVWeVF+VljwWxyq
 c2q3yr+ESxBV1E6YijOOzf/WfamPIUFTzkVOHekJwbeq+Gx+suDNhgcIy4gyY/GeL64v2Gxr4
 UQDfFeVtADt0PC8hNwbysKoC1YPQ6R+ThGrzWMOvtYtD5a71J7L//IonyHzQVjkiQCA6j3C+b
 y7R94ObSvr312sCboO6HOoFQ+fTuzV4dK83jvIRMmWPbn3rj+GBl6/a6QWVwpPN/Llm4GUSq5
 H4B2uqoeavUmws4DomnHW4atYwP/rKAMTkFziS4XuBrbwuiKwUb51GfXqcOKq2W7c6qJ7rqgH
 JrJ855f4+cNo1ZXcjYOcVx4vtrx8Xe4Gl29i6mgAeomcHC6gMSNoIo8kPF2uOJEckCf6V1krX
 ks3htFXFOeicSdxEWQR5iBk/d1yuXUKsU3i6a/PloeeRDMn5IOpEpzapgwXg3eI4hYShnmX0t
 2xrX+qOxYTL30JPhFpqCr6uAekx4c7BY41N2+87QfpPk6Tci5NOQ4QCGsuhlSEtiRjivHHQcC
 8Qfx/npNHfO6LwSoSUlfN7N3/vyQzQzGFe8u+uqC/Ut3JEfIoLVfz3FZp09W2glg7TBXxPoYO
 pxzIhhh+nphBEi/Y0Xk7cqf0X4jIPjOJC9JHHSnv6kFw/mDYScYIL0mk9JB5GYnq6kVEU9Ezn
 ZdjMvEDNl2VcTvdmfI0uORSkP2SRR0S/sk3WYkhrDXVP2TYC6BhliSydDoOOI4OlFbn59Rwwd
 ib+r1XvA8MXaU6uuzQDsIzs8tXKxgmkY49YdL6J4Yn/Eymp0LDAi6YhbLGPwjiTL6nJN6lCtK
 +zDQMUBaomVnr6/X1N/JV0MXIi+DNG/y4OYGZvU+BLxD+h5zpAgKflytDJnFqcuyxpB81vkr/
 sw5GN0TqhT1lpFf6igBg/ckX6SsGrbBhEoLw1xoUlntcPV5TrcR7RysweNUwS4zlelgsgmJIC
 x/ExEw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 09:12:44 +0100

The kfree() function was called in one case by
the new_node() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/gcov/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 0fbfa444a388..10916c70fad9 100644
=2D-- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -543,7 +543,8 @@ static struct gcov_node *new_node(struct gcov_node *pa=
rent,

 	node =3D kzalloc(sizeof(struct gcov_node) + strlen(name) + 1, GFP_KERNEL=
);
 	if (!node)
-		goto err_nomem;
+		return NULL;
+
 	if (info) {
 		node->loaded_info =3D kcalloc(1, sizeof(struct gcov_info *),
 					   GFP_KERNEL);
=2D-
2.43.0


