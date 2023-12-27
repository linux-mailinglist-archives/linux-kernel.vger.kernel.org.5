Return-Path: <linux-kernel+bounces-12241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E986781F1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28AC283CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6EA47F6B;
	Wed, 27 Dec 2023 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UNjV79qz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE31E4A9;
	Wed, 27 Dec 2023 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703709024; x=1704313824; i=markus.elfring@web.de;
	bh=3e+8QRChfVb09sDrJsxnoK5ykgPCKLhPa32lTc9es10=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=UNjV79qzogBTjGdqiZ0euZ44SodPIeei0/XLX0Uud4zFijZfCY5yucJ+LbI80PUH
	 rGOPpBg/A3VVNhdFt9K35o0M6mEfgBYaDwYcQOYuNkB7Mfr8SjVbJW8QUCSEDwazz
	 SbqmhpS8ewiNFJIUks3NKq07AgswEIQbqZgCmXMliH0SamBrf/Kfp3N4l+FMLDfnq
	 JX9kMMfFXYznH5uA+IKCj9ykB9828njTqISukYtuHX83g0ijTfGMll4yjFH8glk9p
	 Va/gULPrawy1UojlIzACPCojz8njo9vaVAJZXs1Gg1teaaSTwWigdeDCtSTbDbzO7
	 9VUmFseiYn2RofPVMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1r6izN0e1F-012z0o; Wed, 27
 Dec 2023 21:30:24 +0100
Message-ID: <d0a481c0-89ea-48ad-add7-5871d12bf804@web.de>
Date: Wed, 27 Dec 2023 21:30:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] of: Less function calls in of_parse_phandle_with_args_map()
 after error detection
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m86qlpsvLCmHOR8Ift9YFMKmHZVSvX/D0xpjcbjNaEeqpznf/d6
 9U2eFisQAIkQG7GeWkq4ivCFJHbJjn+ZcdZs6Ld8eK+7U5xky4sKkdZqpWpvbIBys8uqD/A
 zddn1awvMFLS8+l1Df2TFBVNacgotB82B0r8jt/v48vox1p9FMFLi+0MO2ujZfLlVK2yTCo
 K24Bk2UBs/qd+p+CSBl9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mG3OEyBhpRI=;GnZ/IxrdZ5m9z3sapBfs9ly6BZn
 M3bs8oW/TjOX5EUE+m1up9BDXMxGO94lCYCy/+ypnROpvH7Xqp51mtk16PDRx8aH8WF7D/woj
 dd8GUK4IHZAYPEb7eBTAk2SQQr5jeuHrypTnGz1n177v+zGh/1W6GMAg8aW9DHEYp/0UFtDP+
 1xsOzXT2roKxnvpkd3WKji6F1Rv+Yz6F74Ob30l+IQ7wCWzrF4ULRPZAOESPHyG0Ngh8G+Rh/
 H5JjdqkUqf6NqD4qzJoxXX3WySIxBxKOe/lrjRUr7kvz2G9gGk/36aME8sJtkmoAS0HuGnGJe
 vZQaYQZZ/wThhEFEJjhCG4ACyF2Eni6XzVkHLXIUfXucaO0C9Zi++0fPUH+egG+KrufbdYrXL
 qI4huzrXPBAikr96mo77lafuJoTUvV2SgqWws7/s5zVmd/Y2YQaGi1fnhxFEp0TmwKKcIKCuf
 BWJZdhBql1X8InSBXHtEo4oZxQhul7kPAYvJn5529QIySxIIyYonCeeB2oOIudD4ACPsoKar1
 LkAAGTKSJcF45nhmkPaPV4DdNuDg9CKXStCT1BPN7cFA5srnr7/JHPhsCyCBWwsGkM202SN9P
 MC8c7Vof634auMROJBAFWVB19au1gTi7ORCVbD98vGXKBGWC+uq2MLsaOLKRkfeoqIMVzDINf
 hKGoFKd1NkMZFnaqMZtf64d/OBX+sORAGW3xDN3gLDfUUzbrtLDcn828ItvEoA4tjzbN0p5jM
 PGnI+OAcLadhQ84tuUlQBSqfJJytqvVKXAqCWHijwcfNR9QYCmv6XAvHAU7TKOmo3zedZaZwD
 dD3sZEth7G9LKPbiCfXNzngq+T28WQ+QG1PDd2QLh3p4wL8XJi1eDKxsaZ007uw/koqCye/C9
 2/TsVdEAVWgBXn0BJQCKLtTKX5lCmsPaZKpf6BgSsMEj6HoJ+jsH/2tyLqirWFRkr1mS3cw0m
 5QLLkHMDvCSrXBjfPkR2RADMppw=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 21:21:41 +0100

The kfree() function was called in up to four cases by
the of_parse_phandle_with_args_map() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Adjust jump targets.

* Delete three initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/of/base.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8d93cb6ea9cd..b0723d017912 100644
=2D-- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1341,8 +1341,7 @@ int of_parse_phandle_with_args_map(const struct devi=
ce_node *np,
 				   const char *stem_name,
 				   int index, struct of_phandle_args *out_args)
 {
-	char *cells_name, *map_name =3D NULL, *mask_name =3D NULL;
-	char *pass_name =3D NULL;
+	char *cells_name, *map_name, *mask_name, *pass_name;
 	struct device_node *cur, *new =3D NULL;
 	const __be32 *map, *mask, *pass;
 	static const __be32 dummy_mask[] =3D { [0 ... MAX_PHANDLE_ARGS] =3D ~0 }=
;
@@ -1362,26 +1361,26 @@ int of_parse_phandle_with_args_map(const struct de=
vice_node *np,
 	ret =3D -ENOMEM;
 	map_name =3D kasprintf(GFP_KERNEL, "%s-map", stem_name);
 	if (!map_name)
-		goto free;
+		goto free_cells_name;

 	mask_name =3D kasprintf(GFP_KERNEL, "%s-map-mask", stem_name);
 	if (!mask_name)
-		goto free;
+		goto free_map_name;

 	pass_name =3D kasprintf(GFP_KERNEL, "%s-map-pass-thru", stem_name);
 	if (!pass_name)
-		goto free;
+		goto free_mask_name;

 	ret =3D __of_parse_phandle_with_args(np, list_name, cells_name, -1, inde=
x,
 					   out_args);
 	if (ret)
-		goto free;
+		goto free_pass_name;

 	/* Get the #<list>-cells property */
 	cur =3D out_args->np;
 	ret =3D of_property_read_u32(cur, cells_name, &list_size);
 	if (ret < 0)
-		goto put;
+		goto put_cur_node;

 	/* Precalculate the match array - this simplifies match loop */
 	for (i =3D 0; i < list_size; i++)
@@ -1393,7 +1392,7 @@ int of_parse_phandle_with_args_map(const struct devi=
ce_node *np,
 		map =3D of_get_property(cur, map_name, &map_len);
 		if (!map) {
 			ret =3D 0;
-			goto free;
+			goto free_pass_name;
 		}
 		map_len /=3D sizeof(u32);

@@ -1416,27 +1415,28 @@ int of_parse_phandle_with_args_map(const struct de=
vice_node *np,

 			/* Check if not found */
 			if (!new)
-				goto put;
+				goto put_cur_node;

 			if (!of_device_is_available(new))
 				match =3D 0;

 			ret =3D of_property_read_u32(new, cells_name, &new_size);
 			if (ret)
-				goto put;
+				goto put_new_node;

 			/* Check for malformed properties */
 			if (WARN_ON(new_size > MAX_PHANDLE_ARGS))
-				goto put;
+				goto put_new_node;
+
 			if (map_len < new_size)
-				goto put;
+				goto put_new_node;

 			/* Move forward by new node's #<list>-cells amount */
 			map +=3D new_size;
 			map_len -=3D new_size;
 		}
 		if (!match)
-			goto put;
+			goto put_new_node;

 		/* Get the <list>-map-pass-thru property (optional) */
 		pass =3D of_get_property(cur, pass_name, NULL);
@@ -1465,15 +1465,18 @@ int of_parse_phandle_with_args_map(const struct de=
vice_node *np,
 		of_node_put(cur);
 		cur =3D new;
 	}
-put:
-	of_node_put(cur);
+put_new_node:
 	of_node_put(new);
-free:
+put_cur_node:
+	of_node_put(cur);
+free_pass_name:
+	kfree(pass_name);
+free_mask_name:
 	kfree(mask_name);
+free_map_name:
 	kfree(map_name);
+free_cells_name:
 	kfree(cells_name);
-	kfree(pass_name);
-
 	return ret;
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args_map);
=2D-
2.43.0


