Return-Path: <linux-kernel+bounces-52416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261898497D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FEA284EB5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5675175B1;
	Mon,  5 Feb 2024 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PkBLnIlt"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1517543
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129117; cv=none; b=X8OZNCXKkW6x1tunecyoPfoFMgYNqieUiAbPhOgy29Vjp1FD/e0dPYVv8lA4OIE6jRGm2o5yzLGhgILlwvhf1H/H6RCOudjKUufA1BMGLOUKQy5r1dlaCYLC9dFnVDAVmFJnmnIeEcFNeCfTNF+LteqL1yUNeV/IDmHiYFqS7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129117; c=relaxed/simple;
	bh=+oKF9X0sTiVzE6WgDjbxVkUVPf75ehwg4A6VkNkW7e4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ndNTMrzpqal6QUoY6vurdArrT3BaE9RrNgRhtbwNCSO0nbkr91k4ZIGp59kYzzhR0WwU0dozsR9/tFZvLqCz4g1Kv9IGFjpyqqffVaTE6mq3XL/H8vbLNY7YP6w/CrLksh+1Zhw3cmdMG8i1rAUHPyuWCkkkahUbn3K8J30KGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PkBLnIlt; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240205103154epoutp026b256699ae833a99e262c6afc95576d0~w8OJqqb_81453614536epoutp02F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:31:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240205103154epoutp026b256699ae833a99e262c6afc95576d0~w8OJqqb_81453614536epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707129114;
	bh=HydIl2MoUnMgqf0GoMdDlXsMtaW19N46B8N8u5MBXdQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=PkBLnIltg4NXAlq0121qdlORjAZMK2UWwKmN4aLvF5ssDmlyPJTPN8JCcMQNi52Uh
	 HVADRKbmvXc8Zb5Q1yq9rrwOv79SwYd269TNw3dU1tDTJoLP3jOr6SN6msKJTPupzF
	 H0ryo/UbpnRkv6TCVi6CKmhQ55JxkpAu0ofKVaAM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240205103153epcas5p1ff6ae1b4923573e555e26df38693bc61~w8OIupu1W0525105251epcas5p13;
	Mon,  5 Feb 2024 10:31:53 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TT2jz67xHz4x9Pt; Mon,  5 Feb
	2024 10:31:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C9.2C.08567.719B0C56; Mon,  5 Feb 2024 19:31:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240205081253epcas5p1fabf5b1d38dcf373fef0cfc5cd1f7fde~w6Uxs-5c20553605536epcas5p1U;
	Mon,  5 Feb 2024 08:12:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240205081253epsmtrp1f254357d5a71859f2dfb321b12727e55~w6UxrXJK61538115381epsmtrp1P;
	Mon,  5 Feb 2024 08:12:53 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-57-65c0b91748e7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.71.08755.58890C56; Mon,  5 Feb 2024 17:12:53 +0900 (KST)
Received: from FDSFTE048 (unknown [107.116.189.46]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240205081251epsmtip1dc72d797f90a63c9913abc838b7512a5~w6Uvxdm9E1705817058epsmtip1R;
	Mon,  5 Feb 2024 08:12:51 +0000 (GMT)
From: "Tamseel Shams" <m.shams@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
	<alim.akhtar@samsung.com>, <linux-fsd@tesla.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
In-Reply-To: <6980c4d5-78a2-4c14-b21e-a5ed1e4d5675@linaro.org>
Subject: RE: [PATCH 2/2] arm64: dts: fsd: Add fifosize for UART in Device
 Tree
Date: Mon, 5 Feb 2024 13:42:49 +0530
Message-ID: <0dc501da580b$1dde1870$599a4950$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQL1Dmltm4Jzi85Iod6ksiDc9nSM2wEsxxpXAp+e1hcCkweOfq6S/ciw
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmhq74zgOpBmefGFg8mLeNzWLN3nNM
	FvOPnGO1aF68ns3i3VwZi74XD5kt9r7eym6x6fE1VouHr8ItLu+aw2Yx4/w+Joszi3vZLVr3
	HmF34PXYtKqTzePOtT1sHvvnrmH32Lyk3qNvyypGj39Nc9k9Pm+SC2CPyrbJSE1MSS1SSM1L
	zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
	U5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcWPfW9aCt5wV2//+
	YWxgnM/RxcjJISFgIrH/1XumLkYuDiGB3YwSx781sUM4nxgltv5fA+V8Y5SY2ryaHabl8bfD
	jBCJvYwSizfchep/wSgx4+JhsCo2AW2Jd7vOgiVEBP4wSszq+wg2i1lgI9CWw71sIFWcAnYS
	P88vYO1i5OAQFgiQ2H65ACTMIqAisXr3RLASXgFLiblXHjJC2IISJ2c+YQGxmYEWLFv4mhni
	JAWJn0+XsULExSWO/uwBi4sIuEks//qFFWSvhMAJDonXHU+YQXZJCLhIbJhWA9ErLPHq+Bao
	16QkXva3QdnpEnMf9jJB2AUSy3Z9h4rbSxy4MocFZAyzgKbE+l36EGFZiamn1jFBnMAn0fv7
	CVQrr8SOeTC2osT/3f1QY8Ql3q2YwjqBUWkWks9mIflsFpJvZiFsW8DIsopRMrWgODc9Ndm0
	wDAvtRwe48n5uZsYwWlZy2UH4435//QOMTJxMB5ilOBgVhLhFV93IFWINyWxsiq1KD++qDQn
	tfgQoykwuCcyS4km5wMzQ15JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1M
	HJxSDUwd5zUuKz3mq+N0dy6Yd8Fz37XnJSe5781pV7DXkfx+pbCAxzDl4ux1G78ufZT/WnWt
	um+TlxBT5jSpxGcRhWZbN9+U8fM/oP4xqy+Gqf+l1/5k9bfVuzS4FzedWh21aFfx54MPTOM3
	PdgdeeBSaN+NmtXKDetdfcXNPM4z/5O/e2aXXJ3QC5sw576/PBY8i79/m/mcycHo8tO1PTf3
	uUfLvDTijP48hf/m7MZL3DdjWa9K1Ch88/vwtqPOWszzYFrb2baCckXeOF/tOWf2le7TeaTx
	e9vNL8/E9PavjFfbIsGXFm/xlOHcX9kOV9bkuzzc/EmnHFI3cfe0BnStVz22ea9p8pEpYRNX
	rUp8w67EUpyRaKjFXFScCABlvEj7VAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnG7rjAOpBssesFk8mLeNzWLN3nNM
	FvOPnGO1aF68ns3i3VwZi74XD5kt9r7eym6x6fE1VouHr8ItLu+aw2Yx4/w+Joszi3vZLVr3
	HmF34PXYtKqTzePOtT1sHvvnrmH32Lyk3qNvyypGj39Nc9k9Pm+SC2CP4rJJSc3JLEst0rdL
	4MrYeuYoa8FRzoqzl/8xNTB+Z+9i5OSQEDCRePztMCOILSSwm1Fi8oJqiLi4xLRf+xkhbGGJ
	lf+eA9VzAdU8Y5S4O/UCWIJNQFvi3a6zTCAJEYEWJomnx9aBJZgFtjJK3NxWDDH1JaPE2Z4Y
	EJtTwE7i5/kFrCC2sICfRP/ax0wgNouAisTq3RPZQGxeAUuJuVceMkLYghInZz5hgZipLdH7
	sJURxl628DUzxHUKEj+fLmOFiItLHP3ZAxYXEXCTWP71C+sERuFZSEbNQjJqFpJRs5C0L2Bk
	WcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyZWpo7GLev+qB3iJGJg/EQowQHs5II
	7wThvalCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4OKUamM5L
	LJ295X+S732OP4sZeM7XWSqku9cXnupcsbjsrcax2u1/29U9OP4xf5gY/uyUwU7GzU45BT9M
	uZ+fzje31A+4rHO15Zy30yz20uXXN29KNErbsVXoSILpgaiswy3H9VymvE1xmv2jI7xP60+z
	wSoBkWWOv55v3SQr6SfGz6L31MXHPX4Gi3tP28qi71Hdto8+7M97MF9uVnW25GWBJ2dD95xk
	69mTzfDJjdc5ccv8FbfWzE87wVloOlFzq6ia/rOUCzv+S/j086RWBq62i7y9u/p9EteVnYd6
	GVd/fcip9puncNJeXVPPFSUuM6zb53s5t4i46Ee2pX3R386udU4x6BBT5lqZGvddK16XKbEU
	ZyQaajEXFScCABMDufU7AwAA
X-CMS-MailID: 20240205081253epcas5p1fabf5b1d38dcf373fef0cfc5cd1f7fde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240202212459epcas5p2e1703c35ebe9302ac5b2f3d3fcd853c0
References: <20240202212448.74840-1-m.shams@samsung.com>
	<CGME20240202212459epcas5p2e1703c35ebe9302ac5b2f3d3fcd853c0@epcas5p2.samsung.com>
	<20240202212448.74840-2-m.shams@samsung.com>
	<6980c4d5-78a2-4c14-b21e-a5ed1e4d5675@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 05 February 2024 13:11
> To: Tamseel Shams <m.shams=40samsung.com>; alim.akhtar=40samsung.com;
> linux-fsd=40tesla.com; robh+dt=40kernel.org;
> krzysztof.kozlowski+dt=40linaro.org; conor+dt=40kernel.org;
> gregkh=40linuxfoundation.org; jirislaby=40kernel.org
> Cc: linux-arm-kernel=40lists.infradead.org; linux-samsung-
> soc=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-serial=40vger.kernel.org
> Subject: Re: =5BPATCH 2/2=5D arm64: dts: fsd: Add fifosize for UART in De=
vice Tree
>=20
> On 02/02/2024 22:24, Tamseel Shams wrote:
> > UART in FSD SoC has fifosize of 64 bytes.
> > Set fifosize as 64 bytes for UART from Device Tree.
> >
> > Signed-off-by: Tamseel Shams <m.shams=40samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd.dtsi =7C 2 ++
>=20
> Please split SoC changes from patches sent to serial, so it will be easy =
to apply
> for Greg and others.
>=20
> Unless you want to say that there is dependency, but there cannot be such=
 -
> it would be a NAK.
>=20
Thanks for review. Will take care of this the next version.

Thanks & Regards,
Tamseel Shams


