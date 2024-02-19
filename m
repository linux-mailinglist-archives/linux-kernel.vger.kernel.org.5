Return-Path: <linux-kernel+bounces-71699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0F385A933
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB88A1C21B12
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A4340BEB;
	Mon, 19 Feb 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.ch header.i=flurry123@gmx.ch header.b="AuWU4DoH"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4A23B9;
	Mon, 19 Feb 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361139; cv=none; b=sEr3+19qZFOQdr/+lrqlvl5jpMbOqU43T7ANWgMQmApUJxNIcz0TpPa3s4091chWCHyqy2nWzaiw71Dli3YOkZKaZ5E7J7hg8zcLc4bojF5Pasib4eRjrn8FgWC1pnEvakNmjvy2K5x8q+jaJGbivSAyPL66vhdRAJpKxiV3rVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361139; c=relaxed/simple;
	bh=RgXJPggqNh6tAcIkHk12m5lmoiPOLzaukfcYgsksZ1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfdU+dJgkPwnATDam0VleAmSfvm9Xogi1R08Uby/nORHCxx/74vI++kgTsp1m6HNql/q/uWvbDjCEtqn2UyANyoKm9Or1mZPmmqWpFf2D+2ygJQOkQZd+I4jwGRGDnpMRwK+IRKjbO699M8yfelGWn75flSyYtBBFtvxhqN5yo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.ch; spf=pass smtp.mailfrom=gmx.ch; dkim=pass (2048-bit key) header.d=gmx.ch header.i=flurry123@gmx.ch header.b=AuWU4DoH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.ch; s=s31663417;
	t=1708361133; x=1708965933; i=flurry123@gmx.ch;
	bh=RgXJPggqNh6tAcIkHk12m5lmoiPOLzaukfcYgsksZ1A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=AuWU4DoHemp50Dy/ciMHHwaZwxg+v1N7CRVYXsMn9b1tA533ymz5uJI/1pWBbdsU
	 TE+hdzzi9u3rQU+HWfGs3NXlCYyhYn7XJqm1v/gSOruUnAPe6zE9gYh7I7MExyjWI
	 7pPwvnc1wNllq78gm2SYdGJdTDbYwFVJDa0XoExabvdCLxN+kT/4vUYwQvu1omFpP
	 tazQAJV8JCgsxPQnZ9uELN2P0X31pcVl8ObM206x2udtZJ6JTuyAeEeJqv6n6HufV
	 9k5GxffCFXNzLeNYLsJzsg9TgBzMqFWiowL43CCf2P6tdRJVK9tN7LBADLB1J+n/L
	 rjnKBvb/DWTi58RLaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from void.speedport.ip ([84.155.142.60]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1rP1tV2sRU-00UtPz; Mon, 19
 Feb 2024 17:45:33 +0100
From: Hans Peter <flurry123@gmx.ch>
To: tiwai@suse.de
Cc: flurry123@gmx.ch,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com
Subject: [PATCH v2] ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)
Date: Mon, 19 Feb 2024 17:38:49 +0100
Message-ID: <20240219164518.4099-1-flurry123@gmx.ch>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hw3fAqoOe+YqwRJ1TtbtUUbGpRYR+fgp/QJmGoFwBFDjk6LZVf5
 2Fi0hqAuNyXveFbYnetm/Wxj5q9iHY34AP3AcOhTvcrde3CinPQmI5xvxjRM+euMNUBr46v
 I8GGo9251dQE+R/Lc1WT1ltnfHRf4i84FpEImW7sH8p34TqT3zTaQM6od6FA4ogFF4ZlAqR
 Z1rdr/lUGndKjAp0Nn29g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zgx1vwtlwyM=;XYqM1cpTFWtMujCCamFHVUe1FTa
 x4LF+zNn+G3EDabD//qwWeDeriN0PE7Tqm/RFDKYnwvpsKLnAuueWOV5p8fXJgxwVdstc+p9h
 pZXwesLZlrZqWfQ+Ns2XmtdzWpPvr34zt1S1OEPPqXkrUwJr6AZpraom56D25Pq0Eqlqxvea3
 YqDZurGlBm2DeVGR3lf0r7qWSYnVLR0sv+/s3A14IjOCn3tvEZH7RUcWuz2rNlNlIicLUnZxb
 AeNbLV9xbxdgl6xoAUoUEuWKhPtUQUNy1EY0wRNng4Z5upwTNE8NUxwHLQqxUoO7VbcrvWVg9
 mFozY4RIeTHKq5wZ5pDIfv9STX2RuBuyLgPVG5PziarSOSwapjRdmhLepLED5djR4rJbiUWsR
 dUEKTcZ2z9F07TuYYPi3g+xfTm9No7jq1+nq/IVLl5ZNwyG+VWCRdr1eAwM86LhHa2yqEWaU1
 sYrq6iXW6LAVUJNWFIZ4EvUPX7slglZOn69ZVoHx7nZO4ff/qxuMzLOfl+505CGVs2FDXXVFu
 KcDyU/HO2wkWur9+cbjYF4t7FxfiBRZekpZTYlJ78LBUtXlLoYDEiXCEpwsJlOGs5Xt75aC3y
 f5ajppmNrNeKJjwO785nfapJHflp31Vn6MAA203lJBA69Ehs3KHuJeH0uNLJXgOLo77lztzY2
 gEu9PIdzCNoQWa6EDKsOhGpSli/cLSo2PyNFEF6sX02Db2HupYpg19cTHr6EdXAH1c3sCSeuP
 Vcj9eXikDzcqu1mA7Wvub8zLDwtDs43fALGWVpiTlpLfm0evkYh+5Kq7fISRAo79yUijyuK5a
 z0+W97Kxm/7ZHLjLaGEoU0eEmmRSURKd7oqrIABoNe3bk=

On my EliteBook 840 G8 Notebook PC (ProdId 5S7R6EC#ABD; built 2022 for
german market) the Mute LED is always on. The mute button itself works
as expected. alsa-info.sh shows a different subsystem-id 0x8ab9 for
Realtek ALC285 Codec, thus the existing quirks for HP 840 G8 don't work.
Therefore, add a new quirk for this type of EliteBook.

Signed-off-by: Hans Peter <flurry123@gmx.ch>
=2D--
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ec1312bffd5..26a90c92c3b8 100644
=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9927,6 +9927,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]=
 =3D {
 	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXU=
P_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aa8, "HP EliteBook 640 G9 (MB 8AA6)", ALC236_FI=
XUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8aab, "HP EliteBook 650 G9 (MB 8AA9)", ALC236_FI=
XUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8ab9, "HP EliteBook 840 G8 (MB 8AB8)", ALC285_FI=
XUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS3=
5L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC",=
 ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC",=
 ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
=2D-
2.43.2


