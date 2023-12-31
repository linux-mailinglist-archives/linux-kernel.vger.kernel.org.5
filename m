Return-Path: <linux-kernel+bounces-13660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4392820A74
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DAB1F21FEE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AF6187E;
	Sun, 31 Dec 2023 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DK3xL9UK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EE20F0;
	Sun, 31 Dec 2023 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704012207; x=1704617007; i=markus.elfring@web.de;
	bh=Y0zWZgj6Y0K0bkgqyGjCt7nG5v2aUOSugrldJ+nSJyQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=DK3xL9UKgS34OjC/P921kKVslC2HvqyRcPR+9BfDMbZ5Z6puwnA7xAMvOKrcZjUH
	 +C8xuK8wMgYkQCiX+hTlnGMa112CfKxbq+gMGdxAz4Ar/lPGD41W/WbARCYsAaRUX
	 JXNeSsPPlciZ+HF1/Ko+UCBZCbQHCpSS9BE/DQkcwns1YPgKDmZfV3CEMrvboDVwc
	 nJNrdUqHkbjYRRSoNjPx7Z7QBHnOi8bwJYqWrJNvUj5yDtaYy5vaTrRvh8zpSFxaX
	 5SFqRbG/Cc6K0BYEvpoi10jURm4Y97NcFxie3DoTxksquZfkwnNJqCT6vh3nGusVh
	 aOOGU8zly6ODyX13iQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1rNhxp31o6-004HsL; Sun, 31
 Dec 2023 09:43:27 +0100
Message-ID: <a1e5ed93-6396-4ffe-9f4f-adb36e89ead0@web.de>
Date: Sun, 31 Dec 2023 09:43:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] gcov: Improve exception handling in add_links()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Peter Oberparleiter <oberpar@linux.ibm.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <ebffa8ea-8d0c-4b83-805b-754e25bd4603@web.de>
In-Reply-To: <ebffa8ea-8d0c-4b83-805b-754e25bd4603@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:266UXnCFnJs1UhXDnxzgQk0WSNxoTBvL4Ectx5t/OyYBkhFpbMz
 q9d7wTo/cpcFYxdrHeust6Bsm41z8foE9EaQlGsVN0OdKWvCEc2D6+Sb7uNr345poqRd/yU
 Zmsu/snErGDNozlYGprkJoMT04N49gL92i+3n3Nu4eXdMlJTB9vACJnVBsljKbHXHdNTawu
 88qxBY0f3/BZxoGkVFRzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G+N9Oq2OJi8=;8Tm1thXBTbg3AdxG9He9+sInVuI
 U5TSfmRZFFYED0ouc5m+aBudgP5iqZRhx+SIMGbXP9Xfu4XTsg5WcbCjaIBBUff4ygFeRp+LT
 djCiOnSsmaDztE5Iqv4391AyrbXm/7w9w3KkUhDiEFqHtg84Eu41vBokLKFWoAk98HJFd/Iyc
 xNqySMm6/rUrkFVg56F8xLGWEgJLdNr3LA46+RNoP4BmlRKlDUNr9FVIILHxWetj9I9K6JiTP
 KKRquj0Z3VKB8m9MjI0nUFh6mADRFEFpg3grQIT8Y8NlX3F0t9ItT9rA4TLJios4qnVvxvvBJ
 bIj+o0sYi3aWphbnWFSQsgFNUsSHmO+OEEbtySseaLEQpeOFld44Ui2+nGeRBfFmy2JVBVyF3
 hs76WaXssa/bJaoVTIY+7MSa/gL8Wu42YCVti5CAT9SUSPFu8RimICqK+s3WrK4VNB+LAqJ9Y
 XgmGH9+hY3/2hUaYehPjSeKSf6U6ecJKHiBbgIDvdOLPHk5rUSZAI/aDtCmQ0Gxo5zvgypnRo
 Qz0srOtS3R8vNRJ/7HP34uurPUyWeOytmg9fSpq1aTcO/pBO4RdvT9vU2q4YiOI41FCb7bCf4
 5EOQlqlbF+MX7rGncjLn0dNlxZ7I/B4N9BnFR+qUMotfElLPbdYcx7uzf3DiyVtXpdLFB0aWB
 Zd56tmaaD5tNlc6sWAl7GDvLE0VKohNegHgXUL1X8MDmMV+2Oy/Wfth6uBgfoNpM49yMOJgzx
 TGDCMdsjxMeKITDi+B9nKU4H7CzKmN/7riiLV3VDvlqo2NOG0sZ8QxTGIeV4gRjh2W/yVekdA
 c1FTmScOVe6h/UX/skp7VAYKaW4zjRhLpFQng+AhTpV+3jzqk7tkrlGbCEPgTQ/E33Xjwq+0p
 roef4hExnbsISdt9Qbjv1WLwl7XP0F0jCYMRyGxRPUBU2QNBNWqLiMk7U4C3nt0YuvHzd6Vba
 z1SJfw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 09:23:50 +0100

The kfree() function was called in one case by
the add_links() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/gcov/fs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 10916c70fad9..80c221bb7f20 100644
=2D-- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -490,7 +490,8 @@ static void add_links(struct gcov_node *node, struct d=
entry *parent)
 				gcov_info_filename(get_node_info(node)),
 				&gcov_link[i]);
 		if (!target)
-			goto out_err;
+			goto remove_links;
+
 		basename =3D kbasename(target);
 		if (basename =3D=3D target)
 			goto out_err;
@@ -502,6 +503,7 @@ static void add_links(struct gcov_node *node, struct d=
entry *parent)
 	return;
 out_err:
 	kfree(target);
+remove_links:
 	while (i-- > 0)
 		debugfs_remove(node->links[i]);
 	kfree(node->links);
=2D-
2.43.0


