Return-Path: <linux-kernel+bounces-32015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FBD835554
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80214281CB0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3620364D0;
	Sun, 21 Jan 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="hb2ctEop"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6965364AD;
	Sun, 21 Jan 2024 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705833879; cv=none; b=geE8JBOz328jzwBk/pURVX552sPCJJ1lBFZrlm2FQrIT1MT+HR25lWh8Ckd5AgajOJyB/UysYfRIGNOhE0oZuP8KrVPZ7DUYDh6dAxtefFLZpE+mdvU853m72wWjn7C9cc7uA1aDc5cIReG7s7PhPWYM3olqbaOcDiI5jKN4uvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705833879; c=relaxed/simple;
	bh=RPCcOTTQ2/QJrCVFn+PrAgK6vltHWBOiPyWQ49750so=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ev2uZfau+kJz8Oid5DXPpG95xf258aiWibAHW9FRqCLKm4H4zf+G3kpQZO/If4Nz3thiWj53AapRzAAJFJQULhaWe6t+PHxm1WXYH/xx3kfmkio5bTkz9Z6apl/V78yK2Hq9DB9kXSOKZkMBZHVfNRiC9g9Q52sWaV2PxMlqcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=hb2ctEop; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705833847; x=1706438647; i=erick.archer@gmx.com;
	bh=RPCcOTTQ2/QJrCVFn+PrAgK6vltHWBOiPyWQ49750so=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=hb2ctEopIU/QKXf9M0liOanu4zkVJgwo2uDZQEpXMyp97z0DjAdqHrPdIgWemUhH
	 KDVTt6xOxrTFQzucA61YzkpqJJSIIyWrayRcrsVgqM3KQyrHMFx2I71DCqEBrwZUs
	 tonZDxHXD2DzoXXIFwShYyO93ESMsHuJa5+3HfHZ7y59oG+y10NpCi1i9bvM1N3Ki
	 bxJjZmY6d2iGI7hXpejkU1bHiZEm07MmsZCbk/IWS5/cIro2wEhe50fOph8Boc62r
	 YxE/vArceWDUY4K1j4xStekBzw/Bp4xJ+upjSQgYk8Sd1a0f2MhH20kYmT4GudyXG
	 +87W+LU8EiRA1s+Wnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MOzOm-1rk7YJ2Gg0-00PM4y; Sun, 21 Jan 2024 11:44:07 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] Documentation: power: Use kcalloc() instead of kzalloc()
Date: Sun, 21 Jan 2024 11:43:44 +0100
Message-Id: <20240121104344.5001-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KJSV+DZUjVe7Gh+FcQDBwvgwYswAOy6jcdLWJW+0PTa02ZPGOMC
 IiftB7LnAex/ZBdpuu5HteWTF/1i/jCRlAuCVFwKahxeJBiKKBw4ADJnWHIhhDQyRcyNuo+
 JdUhaqpNQeIeR5dBzSQLQm16RRBZLEkqGXsRvujaHSQZMOd7VQzV9AzboSN7a5ra+YldiMv
 Anav7vcXhx/pe8YlYACBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dcIaAJexKl0=;cVNvZ5I8HLKLzFl3wr+iiSeDjzL
 1ZON+ViU7WGhvkuahOyp1h4r4UBuqB5OC5CoZKKwsG1t3ScVoXbdxEMrGDINdaObI/WoCFL2N
 yz73p9WbwsWKEb1bUnuHMpn8D+Cq1aiFsgsC3eh1KN7zQCvswg81KyDHFaBio/YQyTnfnV3SF
 rQvuBX/XA0nlCED+HhYizCKdzmMjfYvR873OZ2sj0Hhq3ox8MrSzH6ggRRp6tXERi7I8yMSyX
 UXYWL8aJx1q2BSunW9N6yX7vYWK47xg0IX9xsu2qpwq1a07vibr5Sbb98MoZTCg5QQlRWBKi4
 r0BdM63UJlnzT2r7Q6WjIuwlVOKUxKIQS09Ic8x0Z5tkQz23rr/DBn47Jv+zk3LkF8tUnnygB
 bKgo5JNEpglKudKEiPrIiXHIyTEtTnkKV0LFB2isaMNE7eN785TFi8eq2QU3+NAIlPsvKzac+
 3GAV3gqGjBFMJIznhOqZi84aB+ZixxCv6BsI8G+G3TIHs+QNokU/EhuXiqMK65+Sa5BKNmGhj
 53PB5gpX3YMM0WvL0dZU0VPEBX46yyF2qEljixNezkmjuLYpmHpU3V6lCpjYIINXkuj3W8ibn
 7HjFfvZSppKmaicaMtXY+TF4Dinerdd3AzxV6C7RmEFugH/Ew5fxX+NQ8D+T1AjlycOPFgP+W
 LxxQe719VgGf8Lr/StLjTEFsIu8D78B7RrQw9bXUFL04SNXB1WvIWRZQX0fTwdUGxlcAGRsUG
 iV0UBYtM1KolLlmS5j+ss5Q5Ri2v2un4lO3XLShrul3dQRQ7DLvuVeU5LOTk0fCkzTGXlCrVe
 xpH6lz2ICvF3H8Qm5vZi/cLODrNGUUAs17hARpOGf/SEtVvcVqDgr47gWJmhdKub6Kca2gJeK
 99fmRa8p8Y7ssYFwVh0qaJkgxAS95bnO7Wrdkw9epoRtfZmya3412COH2F9nQTnHZeDtlVXwI
 IP98Awf77QPnCjWVASpMOTlz8PU=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, in the example code use the purpose specific kcalloc() function
instead of the argument size * count in the kzalloc() function.

At the same time, modify the translations accordingly.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Hi,

This patch is a merger of two previous ones [1] [2].
As Hu Haowen and Jonathan Corbet suggested, the translation change
only makes sense if the original file is modified. So, with this
v2 version the original file and the translations are modified at
the same time.

[1] https://lore.kernel.org/linux-hardening/20240120120527.3866-1-erick.ar=
cher@gmx.com/
[2] https://lore.kernel.org/linux-hardening/20240120122204.4287-1-erick.ar=
cher@gmx.com/

Thanks,
Erick
=2D--
 Documentation/power/opp.rst                    | 2 +-
 Documentation/translations/zh_CN/power/opp.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
index a7c03c470980..1b7f1d854f14 100644
=2D-- a/Documentation/power/opp.rst
+++ b/Documentation/power/opp.rst
@@ -305,7 +305,7 @@ dev_pm_opp_get_opp_count
 	 {
 		/* Do things */
 		num_available =3D dev_pm_opp_get_opp_count(dev);
-		speeds =3D kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
+		speeds =3D kcalloc(num_available, sizeof(u32), GFP_KERNEL);
 		/* populate the table in increasing order */
 		freq =3D 0;
 		while (!IS_ERR(opp =3D dev_pm_opp_find_freq_ceil(dev, &freq))) {
diff --git a/Documentation/translations/zh_CN/power/opp.rst b/Documentatio=
n/translations/zh_CN/power/opp.rst
index 8d6e3f6f6202..7470fa2d4c43 100644
=2D-- a/Documentation/translations/zh_CN/power/opp.rst
+++ b/Documentation/translations/zh_CN/power/opp.rst
@@ -274,7 +274,7 @@ dev_pm_opp_get_opp_count
 	 {
 		/* =E5=81=9A=E4=B8=80=E4=BA=9B=E4=BA=8B=E6=83=85 */
 		num_available =3D dev_pm_opp_get_opp_count(dev);
-		speeds =3D kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
+		speeds =3D kcalloc(num_available, sizeof(u32), GFP_KERNEL);
 		/* =E6=8C=89=E5=8D=87=E5=BA=8F=E5=A1=AB=E5=85=85=E8=A1=A8 */
 		freq =3D 0;
 		while (!IS_ERR(opp =3D dev_pm_opp_find_freq_ceil(dev, &freq))) {
=2D-
2.25.1


