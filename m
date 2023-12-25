Return-Path: <linux-kernel+bounces-11132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A87D81E1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD711C210AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589FA52F95;
	Mon, 25 Dec 2023 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GUGCLXGK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280152F81;
	Mon, 25 Dec 2023 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703526136; x=1704130936; i=markus.elfring@web.de;
	bh=DN1DZ8Q4gr5JZBxx9y14h9ITgGHp31mL41Pkj2olJ1A=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=GUGCLXGK50GeUpvRJtg0JnwjPvlj9KjLdZ6hnHgCZ7nV6QgNCMmrcpzpwAQ70Ol7
	 qO5R2gtqkc1MNHYTdwh7d631z7rgPuH2OicMr6JTF90SXOG9dLzxaT/JfmECvkJ8n
	 +0mXs/5ehrzdTNqomfoAgwGC75lvL2pKxtYdyxt7mokmr4xuIL79ohwQ3iIEyBYcD
	 bv9ryRjlgYqFi+ShqU8vXjnryXZgF3Bx6RraD0a2Ac4H2IeSRg/WW2aeyVQuGTRS8
	 NH2qxhdbeSThfunmlodBXo4K3C1c1ULC1iqhOTD0sqeW4py2h7F6AG+MAk8RM+/dH
	 xmVAZbuSnYkTz+9Ikw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eGT-1rAHrb34j9-011WsV; Mon, 25
 Dec 2023 18:42:16 +0100
Message-ID: <8ecc9bd5-9001-4844-a3ea-f2b522a73cd3@web.de>
Date: Mon, 25 Dec 2023 18:42:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/7] EDAC/amd64: Improve two size determinations in
 probe_one_instance()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
References: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
In-Reply-To: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2mmKeyB1681GDxQi1sKnPOxPX+IaW+IkMgtER2YiMnejmtGjbMk
 3Ko4EESXm92JaHnCN2m0nvkIeD/9+qCD+PJ9jEuMQFRWqwRgx9ByNpHoyRtd04L46Zb3wRx
 8tOs7YLcV+gQktydVjndK5GQX9qI3SopK+lN2So6YhhfQavedtD+5w3lBQZQlf5FXXlZ8JP
 y4KJGoSkRArEGQ/wJuD7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DHtw6zTu/ns=;qWnu/Dj6l7S/ReZRUeGYnZubsgz
 alUOx57ZHhmLeJNK3u+AxhyisQjpXkeYOr6Gk7Z571mItKHhBpGwrNi8hyJERGTCZOoo74tyn
 XxlyWNa2uBWxaYlboMZyHOZA3myfX7qOurv1LV4JKj9UeSClXSm762HBvIqzW03e0YRAwrPJo
 9RO5Ds4F6U52TZ/tzrfojla58eW+qLPlwJy0FENYXfA14+nZefXeivvyAXhHtPkSRR6nje5Fq
 NKA7RSZaO+IZJJFIG/Q3NmB7g+t7kh7uWR2ENHwolyNC1Cj+3lymkqVd/PcLqptQScIHi3h8O
 ePASCHgyQHiTW9wH170nnayAtHFkUApWmPFfx1wAFnJOkbiBVjvjN3xlWmGJWe66EZuQ2Jlsn
 ytZcneh96QyDJr0OgSZFMjZcL0cJ+O2vGTcfSBXxzwQIucogVgAlJbTbr6i3KdGfMwdeAsc3m
 0fO8qO7dR88x2fpB/VcxflEXabc3CLC+RtwTKpkR4/sPEWII1dlGxwIsh/A13oupumo2LNmVO
 t48TTbPeZISVqp9P8VcIpb7WsVeh/y0DCf4Jb2pAD5eOZvmZZfjXZgGHYSOv79Z8wZGSC/vyu
 tJgfBmMZHQdheZA3Txh5l681+c4OcDEGaKUI5eNRu5ShvlwCOD8cNSDJLyK6itGTkZdVgi6/W
 GyA46ziiIrgBci4qobkuYwcqOXVl1mhj1Lw1WMj3FgTfm/2v8MJLbCRIGu79Pljgoc9BK5dam
 JttUoHilFg6GBKKd4jvxqXP3OEMwX5xWP6EjpxwsQk/tTv2z5hj1lMWVhneS9kw97rdluJVf6
 IHUQM4vSFqaqolLsxdf8niYTzHpbUIydjqkZZcrTRC6DjwaEauwFzkOxjft37bqSicfIqThyr
 qp6eK8wrRm8pNkINAZ5EutPoVfwQbJ71wXjOUQ2BXQkSv5LS/8NyAWA6V/5wkZrV6UyNSoiKu
 oI0Sky7sHiQiGaCKjaiv2bUrz1s=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 17:24:37 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 64680de47cab..7536236df542 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4268,13 +4268,13 @@ static int probe_one_instance(unsigned int nid)
 	struct ecc_settings *s;
 	int ret;

-	s =3D kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
+	s =3D kzalloc(sizeof(*s), GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;

 	ecc_stngs[nid] =3D s;

-	pvt =3D kzalloc(sizeof(struct amd64_pvt), GFP_KERNEL);
+	pvt =3D kzalloc(sizeof(*pvt), GFP_KERNEL);
 	if (!pvt) {
 		ret =3D -ENOMEM;
 		goto err_settings;
=2D-
2.43.0


