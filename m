Return-Path: <linux-kernel+bounces-13946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F074821562
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE848B20F35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190BF9F0;
	Mon,  1 Jan 2024 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KGkfDBAa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A792FBF2;
	Mon,  1 Jan 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704142817; x=1704747617; i=markus.elfring@web.de;
	bh=soggXHKwlX5H4i278ffY+sla9st1cZwXGpXQmiuTWMQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=KGkfDBAaAr7ik0/EV0cN7LvvDwwKPJ7GJ1RSfcV1LPp0ejo+ogtGEnl4CPieSlEU
	 cpNjl9tMVwoGHreF6BQZ28ptv8uWHcOWyajQe9IyqBXIfThzW6k6rv/4Xw1hh0Is2
	 HLRwaGFrI6L9PuQLZGPWMYNMYBtpXPhS6tppItX1AhtCcEjl7bOZczxD+vqlSn6cq
	 QaQ6+GGfBYhoFv1MC18BZgl4n0u1Cx9DU4TNfRRQfMcXpYSXixDUEEqc/q9mAVKXv
	 a4Qo3dMyhI6Z+S2lwWfnYN7qr6LMIAFC69QGQzIB1e9ezcbBCf8uMvfsvVToVMa1w
	 /nKLHO49ieakCVWSGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEbq-1rOn6f0GC8-00DgW5; Mon, 01
 Jan 2024 22:00:17 +0100
Message-ID: <d4b65eeb-0ded-4a04-a58e-496a7609edb3@web.de>
Date: Mon, 1 Jan 2024 22:00:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] net/iucv: Improve error handling in iucv_enable()
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
X-Provags-ID: V03:K1:3sLFUxO0MRy26dd/7tWyoDkY1R9BrJbPkUg+db930Ay14GrrrhG
 AMYI8XZD3UfWYRnl4l8ozmGKCgJyllAecW77Ts5AIxVPtW9WbhpEXrs2+tolQGvpR1OAFfO
 52POuTCOBqOKo/+uesr5uOG3c71HTnhF97Yo9ar0CVYuIPlXg2RYrYcIl3YpyeBg7fswIYv
 IyIXgwrW3XkB7WeD8PMXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u5JaqyafKKw=;Yfgd+RdWhfCOMl/7gO9DZVrO0X1
 mRZq2XL+r7fweRFANlHZxbVSUILJrff9u/NEGrzEBVLmYv+5qo+FDlIEtvK+fuVT611eqRNB0
 wxSBMp2X8vVcV1fWRycf/2B3kjJUd7K+L0gGb2snu3Klpb3l6VWXYyI7gzDUV7G6rrDhaj5hg
 Os3HGDWVunkUFgJ1EVCdrkPUlcqKRwupBE5hgZizYjRSNO84gc8+CtVRBHV49Qd9/5qO//k2R
 7Yf1SmQD3B1NBUL0oGy/hdH44Cu/K25pwKA69lrt2VqZPpUiwsasHwkOSXgbJas5z68Xy/YuG
 dnjWKZvhZ+yGd0BSaeL91K9PGwTnQPYg4a3NlvdbMvJyAdZe+0dYkqwPMsVZc+Fac4CJ2/Y/m
 XpcVAgWBAjonKSXAOzctntIjzZdE/C5LLrS4bC3/cx8Y3KNQSuwoScJ5BNlUWqZTTmnaFZ7ST
 ikOIgk+VuEvml1itpJoz/il5BwiGlH4gPUmzF78zzrjW4oNKKHdoxhxzPLBQhYjnf4n4O5D6s
 wT/0opadKEuZl3sr/PpTCKNApk2SAWQJ9i9dlxrmeL410Pmbr21UuiLaRaDgLmGbzQE6rlBey
 9GwwKLvC1gxcY8iJgSSwJmqbvB/v8QrGAbN7IuH+GEfALxN4pib7PEC1n5iOLo9SMktd2UJ4O
 wzeOW7Te5V9CAlh7S6uOUCIbn4jV3imHtl6ShXU7iTtphJSRT7JGJHsAQxBJny1semAElTK6N
 3d77+BZJHbvhlPjvhtHQLhFBA/tQAoJgars5pbEKg0OpUWs/mgwJdDnGcDGZI8rMwhuwHDvNY
 gSoo38wBbVU+LGJnKudvMBQeYfDtDfqz1sNZ5TJYm0iT/TJQd0QG2qUe8aNBqEZYXZkbdHMeq
 ul6yvzvU9DWguFXgcS51+UkxbfJenfQ2Ce6UoFo9gKpcCrubD1se9nCQUMi0L9Gxqi1GRqKoK
 zaH8Kw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2024 21:44:46 +0100

The kfree() function was called in one case during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus achieve an unlock operation by using the corresponding label.

* Move two error code assignments to other places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/iucv/iucv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 71ba309e05ee..09e78a57bab8 100644
=2D-- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -543,13 +543,14 @@ static int iucv_enable(void)
 	int cpu, rc;

 	cpus_read_lock();
-	rc =3D -ENOMEM;
 	alloc_size =3D iucv_max_pathid * sizeof(struct iucv_path);
 	iucv_path_table =3D kzalloc(alloc_size, GFP_KERNEL);
-	if (!iucv_path_table)
-		goto out;
+	if (!iucv_path_table) {
+		rc =3D -ENOMEM;
+		goto unlock;
+	}
+
 	/* Declare per cpu buffers. */
-	rc =3D -EIO;
 	for_each_online_cpu(cpu)
 		smp_call_function_single(cpu, iucv_declare_cpu, NULL, 1);
 	if (cpumask_empty(&iucv_buffer_cpumask))
@@ -564,6 +565,7 @@ static int iucv_enable(void)
 out:
 	kfree(iucv_path_table);
 	iucv_path_table =3D NULL;
+	rc =3D -EIO;
 	goto unlock;
 }

=2D-
2.43.0


