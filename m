Return-Path: <linux-kernel+bounces-122271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3388F482
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023C91C28364
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCF5249E5;
	Thu, 28 Mar 2024 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fRz9ty2d"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924EA1BDEB;
	Thu, 28 Mar 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589034; cv=none; b=QcaFWlGRgpE02xkbtVfdv3ct5rmRvT3EA70TaqSoVGkohIcjktTewnEXS+7QwJM661fnB0ts14lsO9sdR10Jsrn6BUxHeHzgJdxIMd+vUqkUTH3QWs0myvGi2xBDxS4HRPapjIOLwNPmDvQlztsP17Uq8l1X9sUOLCpJJCOHO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589034; c=relaxed/simple;
	bh=jXpXmnj6OnVqKyhubDX5ir2p4FFes+gOgiUiATMk5OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVFpRd4/JglZ6uQbmJLWkoCj4/3v0bWLZMwF9FLyxGowTXumcFyANpHq18SnB9CIcXceSrhsZ5H1ml4OdPIDNYvrrA7Ml1vOY5OGJmIDE7RBGAgCBbhPPv5SmduZAoDgIK6qJfR3+YH9+OmtLuI0TEzc3eW8ohSrXjhxTvMMjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fRz9ty2d; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711589023; x=1712193823; i=w_armin@gmx.de;
	bh=NTZrA4QvJZSqwHRW+FevDxzgn/3DYV09kgKCOuqHtsM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=fRz9ty2dvFe4FHG7MIghnw+EiXlYhobWtDmXGz8r2FGOoAnAI6M+/TWdYt5thU1h
	 x6pTaHYkGmNOk4yiqRRWvBCS+EczptK5MhMeF+C+i041T1Lvykeg6abJ7eg5pgDTn
	 Mj3fFKdyS4+EoXqiRCLLWvKs2MyzUQ01KiOtXdEZAj7GWhjbrQiyMUFof8pzCIty/
	 T9H21d5+uwYzFQJ/zvxAzMzQAv5Ly6NWMa/q2OMVltNxehw+zmbcs5doOiSbpjv2f
	 2rkhzUSthflq7Z1hwx0oHt/ZrbOvUjYxcObZS7bPJLsqmfrx2U3AtdZVIA7ns/plw
	 3qR2oIFbeIX6KXunsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6Daq-1rwHG23RW4-006eLc; Thu, 28 Mar 2024 02:23:42 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: xiaomi-wmi: Drop unnecessary NULL checks
Date: Thu, 28 Mar 2024 02:23:35 +0100
Message-Id: <20240328012336.145612-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328012336.145612-1-W_Armin@gmx.de>
References: <20240328012336.145612-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qQZGorHHshX435JgVGcR7UX7FV0euoTQdDbn4hnw/jgyN6H3u/h
 uAzYwgNvopRA1ZQcWBsbepyrzm+ZqtaGSxGqCAqm8zOp8hlbxZVV4GOrdc9WjGYCnNCD+af
 pBuuhoiKscnMlg/XIxT4OU3JGYY84x3ckAeOuxqIMFQkM4ubTTPidsFiFViEofghczvMPYy
 L3HEkAqYqKWxGYWiPQC9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ufHgX651t2I=;kgTXljFyEPj8G2vsPH+Dlk2+pKX
 pVqH5y71ysJnPVe93Yg+ElYtPtYWG4/5mCTYcoIsC7lOZlEL50TybkPJyTk3EJlwV6EWEbS2U
 KWdA0eYfnZqkFWsc9gTwFjssYor2XP/ZvM9XIQ9jau/1LnszyGszeXtUrums1XAYkHJBagZg/
 ekdwMMV9oc2OaQORq2VLWl5Fn4kHu/4ktTq3poAnNfXpI75S+D5icGbSMr2mQcKlWnUVS8Dsp
 3f0G7HTLnsWgoORpXssIsBJR7qcR7fj8X95XYxTwfNqiq08kNo6FWz1ActZyVQ7kvC6BBfI5i
 ZdBVm2dEUwMfxCfWHI4lTrNFOGLk2SRAH23jE0PGgz1/EO6en5K60lb48SuvMdrtWW6C0mP3I
 UlCUB01cj+6rWF0s4zeINo2QHhgq6eJs7CbMWupRuqgBOdH1Iu2d7tik8ryNCmnEE/EzTxlTX
 lxloXR2KehQuVdDqrbcrvPeB02bcBbcVUlKFqLO4U7bER9OTuV8yVGNknCTB1V7cc1geYlOoW
 kKrIjoR2xXYZvBt16l7g/9HsbjQTSPcIFRTD7bPFKwuj9Go+btuXYnWqoHB2VGtQw2v2XRNOZ
 0GnU4Tf1fK0T35KdVFHEDyfobsEjv+peP6OGqaKMynbdp7sIk5tNWKlN2SXaaViL5G4yDIMFg
 +IpQTekivZN3mWGuLtDTfMOoDCjLQSZLsWr8/xJx6GiaMhrnJxPvOUQvYQ+gr9WtbfC6sx1Pv
 t5/RA3ltwteX3YGRtXNLk3kAgDmZB7gZDMMR2lyOf81WjEwbxc7XV9yLmUNyCypTd/iqB023H
 9DcWfymGiPaCNHIR/Uj9rZfhKPXt2tOFIDv04HahCObzc=

The WMI driver core already makes sure that:

- a valid WMI device is passed to each callback
- the notify() callback runs after the probe() callback succeeds

Remove the unnecessary NULL checks.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/xiaomi-wmi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiao=
mi-wmi.c
index 7efbdc111803..cbed29ca502a 100644
=2D-- a/drivers/platform/x86/xiaomi-wmi.c
+++ b/drivers/platform/x86/xiaomi-wmi.c
@@ -38,7 +38,7 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, con=
st void *context)
 	struct xiaomi_wmi *data;
 	int ret;

-	if (wdev =3D=3D NULL || context =3D=3D NULL)
+	if (!context)
 		return -EINVAL;

 	data =3D devm_kzalloc(&wdev->dev, sizeof(struct xiaomi_wmi), GFP_KERNEL)=
;
@@ -66,14 +66,7 @@ static int xiaomi_wmi_probe(struct wmi_device *wdev, co=
nst void *context)

 static void xiaomi_wmi_notify(struct wmi_device *wdev, union acpi_object =
*dummy)
 {
-	struct xiaomi_wmi *data;
-
-	if (wdev =3D=3D NULL)
-		return;
-
-	data =3D dev_get_drvdata(&wdev->dev);
-	if (data =3D=3D NULL)
-		return;
+	struct xiaomi_wmi *data =3D dev_get_drvdata(&wdev->dev);

 	mutex_lock(&data->key_lock);
 	input_report_key(data->input_dev, data->key_code, 1);
=2D-
2.39.2


