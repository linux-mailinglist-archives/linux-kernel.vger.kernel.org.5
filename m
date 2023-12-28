Return-Path: <linux-kernel+bounces-12840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D981FB11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4511C23600
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D4910799;
	Thu, 28 Dec 2023 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Jg1UeUG4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3710780;
	Thu, 28 Dec 2023 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703793721; x=1704398521; i=markus.elfring@web.de;
	bh=PVt/wnLfLIOxg7hwOL8VokJSMcclQsyGS28j2xPRa3s=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=Jg1UeUG4b5dA5mBxS00OhEUEFOY6PWxUmO+fqcixfAK1EKVCsawxvoeopACBcDOI
	 jyTkiefOlZsNdjsTnypsyNIeUgR02+nAcFIP5vUg+RVm4OFj356adHfFGE/ph1Iye
	 We1VLpzTGkuQw6FGx1hb2klLhDaYzMtGHhcn9KD4ZzOpxaiZHyyQuy0CXR1wLuY7d
	 7iCHihahotflZJ2bIjIJIubcS7OjDZfJXtKPv8B9HBdYGwkX6hc+qG2S7Wp04+X9Z
	 +oMgs9G17Aa8jl2lSqhQjKtcUQ15TVqpnJQQRGkQzzxrXSIMovSeQ1PjsN0nJM7si
	 mL3cPGbEUHVDgSt4gg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4NDG-1r9QAY3VIc-011dqP; Thu, 28
 Dec 2023 21:02:00 +0100
Message-ID: <7203d3fc-f1e4-4fb1-8dd3-068b0ec6c752@web.de>
Date: Thu, 28 Dec 2023 21:01:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
 =?UTF-8?Q?Christian_Sch=C3=B6nebeck?= <linux_oss@crudebyte.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fs/9p: Improve exception handling in v9fs_session_init()
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mbz/HHyunIoY6d+awK+8Eugj0y8BJ2S9vxuYKR+g8zrXJGsu7IJ
 Q/oyt3rpR7w/Go5ntSypHJK039EFq1aglrCWAT3Ao3j0k08OpoMe+apx4tioIcXL+27sRpF
 jeIonoLK5hDRRzDyAO5M/IqD8TespeMwsAqKqk0tQoJpmF5IUc63XsRaAJ26eTqeGZid+6O
 4E5qTVaytTCyk//uCmO6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0jWWBk4hVZo=;RRSYg94h3fJJARj0fM8mFORlhrk
 lCbDc1wENsZKRDW748d//lEXloj2bQQW0EFYtsshQuaaxz6vIxB/TIgPEUR/df2LPfBLVFjP3
 +QkmwH7q1p2ObRo4QY145HtZ0zoBCzahVL6jBDJ1ppLVlQqirVJLEusJGyHayL/KA92Mcj8RW
 mNCsJYOoo3d/GgcHkbc/agReX2KkJvb75XLiqmI2N4yOE65ge7SK/WPgZ0daUwVvPIncxvaaf
 0Y2OWhsxyjZ1gRvtXE1jBsMpdcS0XjDGoBV610ykqv4GCqgZMu3cTjDc4B1RvGFa7k4NNNTgu
 Q/C2vwOkO0gI5dE6wWEBzWzzMNWzpYlnAOem4yi4/SmIkOcv6ZLuQw2L0XUFTF/4LWvXcYyCr
 8P6TYmYfOBbv5qHfsGKKfFjJKpcgs4eHNrk7fSJ9m19Tab9Wjak3kDfv6b9FQRi6bskPKXuHI
 a+WZx9rg23UMOuJGMjucsY4OND5NsQQ4z3dfoZ/YANLmD6hQ6sk3HZlrSQ87+YiGaaZ76ZhHU
 pgYRAf2AhVQezbhDsNzps6M6ORS12FBYwYEjq9I2rK55ueRu3MQeQtAYupQzlpHXphY4WPkHk
 mMnELKelutd7UVx6hbicm2lGJPYswRfSlH5Gvf55O1pq3O25mIKHGd4mlGRdF7YikTPYfpgb/
 YbkbgxL6kLUvHoC4Qhcxcb0sXixB961FcKTXUWRStWqhTP/zzPQsKfDTltSKeDGfI9oRZfRm/
 YnF8ZDxzlPh4VX7PdDh0dJ39xuonDuxK2CB/nfn2AlZTURXKUoNJtRxpVbKS1aCoSC8S9CBWV
 THqVGEhLwrby/61/9Bi3VY4gUazqRU7Egh/yefnM3pCxx8f2YPYGw0ZZGN0miJn8vbsKM/+lk
 NI/qmQ+gwIpP2Mze2c3qE2F1IPX7AFQc7UW9UK5WmmNEViPclpyeknwzQHYk5EtArOoqTpI8j
 6iHvtFCs5c9K3OOzckqSv10TxVQ=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 20:47:18 +0100

The kfree() function was called in up to two cases by
the v9fs_session_init() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a call of the function =E2=80=9Ckstrdup=E2=80=
=9D failed
  at the beginning.

* Adjust jump targets.

* Delete an initialisation (for the variable =E2=80=9Crc=E2=80=9D)
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/9p/v9fs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 61dbe52bb3a3..874a36303b72 100644
=2D-- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -392,15 +392,18 @@ struct p9_fid *v9fs_session_init(struct v9fs_session=
_info *v9ses,
 		  const char *dev_name, char *data)
 {
 	struct p9_fid *fid;
-	int rc =3D -ENOMEM;
+	int rc;

 	v9ses->uname =3D kstrdup(V9FS_DEFUSER, GFP_KERNEL);
 	if (!v9ses->uname)
-		goto err_names;
+		return ERR_PTR(-ENOMEM);

 	v9ses->aname =3D kstrdup(V9FS_DEFANAME, GFP_KERNEL);
-	if (!v9ses->aname)
-		goto err_names;
+	if (!v9ses->aname) {
+		rc =3D -ENOMEM;
+		goto free_uname;
+	}
+
 	init_rwsem(&v9ses->rename_sem);

 	v9ses->uid =3D INVALID_UID;
@@ -489,8 +492,9 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_i=
nfo *v9ses,
 #endif
 	p9_client_destroy(v9ses->clnt);
 err_names:
-	kfree(v9ses->uname);
 	kfree(v9ses->aname);
+free_uname:
+	kfree(v9ses->uname);
 	return ERR_PTR(rc);
 }

=2D-
2.43.0


