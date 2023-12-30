Return-Path: <linux-kernel+bounces-13381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C3F820439
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156E82821E5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D12589;
	Sat, 30 Dec 2023 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JGa6o1ox"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66023A5;
	Sat, 30 Dec 2023 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703930114; x=1704534914; i=markus.elfring@web.de;
	bh=7hagqCEjKrE57PtopHnSuOX+w+TMvxsBegLDaXo0Kb0=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=JGa6o1oxw0k67h3KuXcBNezZeqaQVg4RYFegayDvsMmpvLdrFj3wdi7k/53OcZRd
	 YmoU8zVPYVwQF7IkrG2yeyZD3HugmksJ+9oQP4yZ8O9qaF1n+YtJzzTWSljonUHcd
	 OpmyG3XbwLBLNT2M03+d6oRbhSEYsH5WTPqCQYX6PpF/HH5zkgKEPoavMUHNogkCr
	 VMq2/chsfGUbD5xiw02jc/NfALg/sJHaw/O5M83OQgBSjmj8NPr1+7kp1yT5S/FuE
	 CfzRN8WrYKkAMe2r9BlMwfeKix4mAxTA1NfjKgNT6dsJpDjbSSwgQ1P6HxdG01a1s
	 SVk5sjgAYZ1uyFmT0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1rFfFE28CM-004Hne; Sat, 30
 Dec 2023 10:55:14 +0100
Message-ID: <49472d26-29e6-443f-b0f5-21967a67dd4a@web.de>
Date: Sat, 30 Dec 2023 10:55:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Phillip Lougher <phillip@squashfs.org.uk>, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] squashfs: Improve error handling in
 squashfs_decompressor_create()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zIZCN2IxrquqiixhE0hQxGRDU10391YouoqgzwH7Rw1rkkp88rI
 8Wqc9A0me1A+YSBDFDnsB6yLGNQb5bJkS9lMj00wODaF88/LXHymCHLaVyY0k2AR84aSI+G
 7PInNJ82uifUkieWNPHY2f9m5wkNUiPNgVrgLv4rrPYNOJwmmi1tUxWKMMBlL4EcYLa3SDY
 FREUnscBQHrFKNpUAxRbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AdBholhUsCU=;684vah8ghC2pt9ND06Ye301jzWF
 VGmoXmlYUwykEcCy44yESwt8uOTNzDWUlmt7NUJkhdtNA5MunDDMMJtluocDYmIailILMefTc
 iW5eIQyJ4mMokvHS3zWuABQ3et7GoEvgpkbaeOVFGH5aRev21dY1C9k2Or3evZpNC/pMBDV+J
 PE00iqUVhhvejWoccAvVPwrjng4vRskPq3JJ6z6v0Xp6mVE4vDPqHwOUdEbihddXod9tBSzU2
 R2ryoNMPBAx3MmBCVySnnU2A9x2pUHLvg61CSAueYMDENoVcL4frOdef2ZmJ2mxETNiIkgrG1
 RtCiPXOHD/J8hH84fPMS7pZGzgjMfJCw+MCpYNrw47Fai9reU+lOgv0N63DzzWazXshGhMgMi
 HTFGyrT97PY+CbMZbEycPOfWrrCdaFwqnKns8KY+GbZ+hSCaFo+q/99UIlDndlIwB3ZFJBVCD
 OPUWsLFJO3TCYow2ET9kufNBdWaYaZwqWXL6gvmOuvYHqcXdxhHOHPwGG9Wtn4So+aswj5QK+
 amH2T70uIGql/5p+JES6bce1rxU2XZC1QrN85yeOCrcYN+KE3X8koYRkzvwxlYNAcjTyS26D8
 xR2KOucdhFo03mGAkhdhFGSe2wvq1qXM4zgorIKXDKtmrExl+L/FKK0+79lkkHmtKTxWI02mB
 D/SjFwYV5gbAXePhVvKDiBrPhYdCcA+DzJM6tlJQsSAiqtf7jPsW6pimVYnTpzudL/AFIMSZU
 FNahou3gq3zHv5nNpLyn/JBeJzKbzfSjfzL34MdktTm7ywhUqfJBlt5WlnYODugxGuyzKPorB
 r1zJrjUq3nGNOPXaupE9je3cX+LlD3mXlAliYInvPz+/HxA0H6R6HPZPShBvhS61UG3U8BQk3
 kIKf3eh3pzPSLViA++D11V+eVEYXRdH3k4364XnIZeeVLq9eldag6i3GApjGy8w2zAY9npQWA
 8qm6B4uQAcRAx/QE6tNVP9JhIMg=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2023 21:30:26 +0100

The kfree() function was called in two cases by
the squashfs_decompressor_create() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
  at the beginning.

* Use another label.

* Move an error code assignment into an if branch.

* Delete an initialisation (for the variable =E2=80=9Cdecomp_strm=E2=80=9D=
)
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/squashfs/decompressor_multi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/squashfs/decompressor_multi.c b/fs/squashfs/decompressor_m=
ulti.c
index 416c53eedbd1..81fd15d5163c 100644
=2D-- a/fs/squashfs/decompressor_multi.c
+++ b/fs/squashfs/decompressor_multi.c
@@ -62,12 +62,12 @@ static void *squashfs_decompressor_create(struct squas=
hfs_sb_info *msblk,
 				void *comp_opts)
 {
 	struct squashfs_stream *stream;
-	struct decomp_stream *decomp_strm =3D NULL;
-	int err =3D -ENOMEM;
+	struct decomp_stream *decomp_strm;
+	int err;

 	stream =3D kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (!stream)
-		goto out;
+		return ERR_PTR(-ENOMEM);

 	stream->comp_opts =3D comp_opts;
 	mutex_init(&stream->mutex);
@@ -81,8 +81,10 @@ static void *squashfs_decompressor_create(struct squash=
fs_sb_info *msblk,
 	 * file system works.
 	 */
 	decomp_strm =3D kmalloc(sizeof(*decomp_strm), GFP_KERNEL);
-	if (!decomp_strm)
-		goto out;
+	if (!decomp_strm) {
+		err =3D -ENOMEM;
+		goto free_stream;
+	}

 	decomp_strm->stream =3D msblk->decompressor->init(msblk,
 						stream->comp_opts);
@@ -97,6 +99,7 @@ static void *squashfs_decompressor_create(struct squashf=
s_sb_info *msblk,

 out:
 	kfree(decomp_strm);
+free_stream:
 	kfree(stream);
 	return ERR_PTR(err);
 }
=2D-
2.43.0


