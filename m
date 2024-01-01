Return-Path: <linux-kernel+bounces-13942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8184D821551
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 21:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CA71C20EBC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD22DF6E;
	Mon,  1 Jan 2024 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d92POTct"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20572DF4E;
	Mon,  1 Jan 2024 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704142695; x=1704747495; i=markus.elfring@web.de;
	bh=sA32SvjB/NKMDJYtNtuhacTnJuVL4TMScfX+6yDDU+M=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=d92POTctyyYL/EQXpfT9TAVwxetY4izRtKWNPX4YRsBWWElaxNGi2B3hQ3pBZLBv
	 /vC70M4I5H1yxCHjW2eRme8Jpa6/uqDnqRPP0yXlKZMwM08TtwaypJqi8pfUkvXJp
	 CLLhxkSCv8KGJHsQiBVvYn8+KVbDR/sSIa+f7xrLlrhhVaAmGDgXVgqB4XEWjSyka
	 UnKh1zMv4iC0REM0sftcC9xnwxXsvi0BB0RrNYiu+d/nQE6WKWFoYJF7xeSINb8oj
	 ZFJLcJ4cBZS6fvKz0MUPr2SNh20tVxX/Pd8AbbI9Qc5f5ir22/SPr7sadPAgpbtRc
	 LLfBkuhkCcc+f6f4+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkWK-1qo6HZ1gKM-00dS9R; Mon, 01
 Jan 2024 21:58:15 +0100
Message-ID: <81f7db31-a258-4dc8-b6e1-c1ef1844a9d2@web.de>
Date: Mon, 1 Jan 2024 21:58:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] net/iucv: Improve unlocking in iucv_enable()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <cde82080-c715-473c-97ac-6ef66bba6d64@web.de>
In-Reply-To: <cde82080-c715-473c-97ac-6ef66bba6d64@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+IjDA4UC/RVeZxJ6sYxiZtXJDjVa+jXZ9pTwjWz9OI5Ww9FtraV
 ePEmmC62gasC9V4/8/hDEKrHDSqO/6oBSvi8X5dXWZ+rGxULRF9USDaTROSAh6+C6b6Lp0p
 SRiozFoUfmrIVJKJvLdH9kEsXUIgYHuN7qcFDPs/eh3L6OKML0f3jnn2PSyC8wz9rSHo8OG
 fa9GRsgjq+MokAvsHOdKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:240G1l8Yb/A=;hxnMEr1FcOxImCKrWxAcoqNns+T
 IDWiLLC3ze9lC7+sNDGIHWAmUBoK+J3Zmr95nbfw0XOA1+XabOZXbZy3IMjNc5dQMdKl6gr69
 W5v6dAl8eAnaCRXxtjUU7nc3pbKV2t2h75MuzGmabRCkQp/+L2NmLdd5R+XaZHcfQc+mhxNG6
 XSWe6BFEzudr2z6xjX/SQ9w/8G6NBi16TBx5umvrf5My9rflFWBvMTcomSc0O44BpvFqlmf3b
 jmiSfSRbQLMqOXW61d2jHB4i4Z+NJ2xPL49QFByP2MQFiQPl6cNnn93/7v/s44CezPCvEsXq9
 buphS+MbpomWvQQxXFcEVkn/Z6W9KHc3JzWpDqSzp89exU1mSS5KcVTHmGylM95LHuOXBD/OX
 FZTbKGynyjJ+UEPFPsqGbwew6eawXBLPTU7rpEYU2qqfqoxc8Dq04vrnaPUgKdPFJidJXzSv2
 vmgehAX3ck7EkWho1KdhZCPDTLsH2xAGtIPf09/zg6MvXoIOuxxakWiSlUsJTxI9xJ4SNb3Em
 zkPeiSGDTPq6IpalL+KVkbL/faMVKAxQysMDUtnZPJC1B13exRcMvyg7DgF1v0KGcEiM0/Ert
 BHqmKacg24lRxxwjJemFG+KbuiP8HIv5SihrHfCPQkmKOa1zsfiT5XW8yZJa/G9fuA2Umzm3+
 9obl4t7srPR6mxiErlsFN0FSyPdT5zASt9orIGzw6YtlMJMCN6NGbOGXXGPrOLR09YxuzDWWg
 znkVn8ocAQTBkp51Bj9LlurzkpJoPGdteuXXUt3a2ip2C0V8gP881v6uu/KoydaBgk+hkLzs/
 PmzJzOOF+l/jn+Li2dycMh6x8I9/Wd6wBcx2CSFAns3GFuJaqLQO4ZnEUA2fI5PoonBI4oIEI
 XwTKGE+rsPQytrbBAvDKm4RYB5+YkrBY4h11gnsE07Oss17dGoO1Hegy5pRzSjxGQI5Eho3yL
 K3jAfA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2024 21:15:11 +0100

* Add a label so that a call of the function =E2=80=9Ccpus_read_unlock=E2=
=80=9D
  is stored only once in this function implementation.

* Replace one call at the end by a goto statement.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/iucv/iucv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 0ed6e34d6edd..71ba309e05ee 100644
=2D-- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -555,13 +555,16 @@ static int iucv_enable(void)
 	if (cpumask_empty(&iucv_buffer_cpumask))
 		/* No cpu could declare an iucv buffer. */
 		goto out;
+
+	rc =3D 0;
+unlock:
 	cpus_read_unlock();
-	return 0;
+	return rc;
+
 out:
 	kfree(iucv_path_table);
 	iucv_path_table =3D NULL;
-	cpus_read_unlock();
-	return rc;
+	goto unlock;
 }

 /*
=2D-
2.43.0


