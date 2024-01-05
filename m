Return-Path: <linux-kernel+bounces-17405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C141B824CBF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55149286864
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972F3C2C;
	Fri,  5 Jan 2024 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NjDEfq9M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EB1FC4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240105021132epoutp021cd54385eae1986e6d1bbb85c7445b64~nUZbQJ7LQ1655416554epoutp02E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:11:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240105021132epoutp021cd54385eae1986e6d1bbb85c7445b64~nUZbQJ7LQ1655416554epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704420692;
	bh=BiF0R81e3X0vSBrQ1qwZB0Cd3lb8UdqUlPYMWGu5AtI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=NjDEfq9MEEkWfUYjY1nZR/L2mVnFAWy8rBx/qU2EwXTAKN79fVHTEktd/HtgIOn4H
	 cCJZH5/FtWKg7a1J2iXV2QICTscOADhY2wz69KgTC8eEnzFXpEr9SwFZAlP+P+iLPK
	 LMes/PZII0AktIA1xnWmYiZ4NsMz7lJBsljA7YVA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240105021131epcas1p1997ee50d540a3a5c44182485c7ce0cb0~nUZaq5HcL0052300523epcas1p1Q;
	Fri,  5 Jan 2024 02:11:31 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.227]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T5n4z329Yz4x9Q8; Fri,  5 Jan
	2024 02:11:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	97.1D.08572.35567956; Fri,  5 Jan 2024 11:11:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240105021130epcas1p2b77331ab0fc865cc3763765b0b5ecadf~nUZaEkcic1601016010epcas1p2k;
	Fri,  5 Jan 2024 02:11:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240105021130epsmtrp27df9163631807e0f2a04564b955c49d9~nUZaB_7Tc2541325413epsmtrp2Z;
	Fri,  5 Jan 2024 02:11:30 +0000 (GMT)
X-AuditID: b6c32a33-55c16a800000217c-db-65976553684b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DD.5C.18939.25567956; Fri,  5 Jan 2024 11:11:30 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240105021130epsmtip19351d379f94980019eb6c6fe68db3111~nUZZxf8Kh2136321363epsmtip1J;
	Fri,  5 Jan 2024 02:11:30 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com, stanley.chu@mediatek.com,
	quic_cang@quicinc.com, mani@kernel.org, quic_asutoshd@quicinc.com,
	powen.kao@mediatek.com, quic_nguyenb@quicinc.com, cw9316.lee@samsung.com,
	yang.lee@linux.alibaba.com, peter.wang@mediatek.com, athierry@redhat.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com
Subject: [PATCH 0/2] ufs:mcq:Code cleanups 
Date: Fri,  5 Jan 2024 11:10:39 +0900
Message-Id: <20240105021041.20400-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTP13t7e0Gr14LsG2wIHUboBrS8/MrARzTL3dDJQkzmEgc39AYY
	pW16i7plARRhHTJW50BljFeCyzCOQXhUlNohUiDItiDyqEuHSpjUIYWaCIKuteD873d+5/zO
	Ob/vQWKiUcKfzFLpWK2KUYoJb7z9epg0PIU9y0rtFb7o7+p2Ak22TvHRg8URAlXMLWLo3EAx
	H5lu9wvQ0kqTANWPtfOQcXpQgIY7qwh0atRIIPNcI0A/WZ7xUNv8Uz7696/nOKrT/4ij727/
	SqDyfywCdGLZhKOGtnGAZo9fB7s208O3kuiWxq8J+vKknDbUmwF9sv8aTjumJnD69NU8+pFp
	hKDLWhsBvdASSH9lPsVLXvdJdkImyyhYbRCrSlcrslQZieKklNQ9qbFxUlm4TI62i4NUTA6b
	KN67Lzn8vSyly6c46AijzHVRyQzHiSN3JGjVuTo2KFPN6RLFrEah1MRpIjgmh8tVZUSoWF28
	TCqNinUVpmVn3rlQxteUYsf0xklQAK7xSoAXCakYeMVsAyXAmxRRRgAHZ4YITzAP4JTzIngZ
	1F35A1uTDFcPriYuA1hUc2NV4gRwcqHSlSFJgpJAa2+Sm/elfsZg+cCMwK3GKAWcKZ3F3diH
	ehvO2nr5boxTW6F9sP7FUkLqXWgydq0uuAUu20oxD78J9p+/j3v6bIGFbT9g7gGQGiOhratZ
	4BHshX11i7gH+8AZS+sq7w8XZrsIj6DQ5eehZVVtANDpsBKeqp2wsKiQcFvAqDDY1BnpmbYB
	zj4u5btpSAmhvljkqQ6BVSVDxFp/x9g9vgfT8G7tInBjEXUYPnxSQhhAYOUrHipf8VD5/7Ba
	gDUCP1bD5WSw6TKN7OVdpqtzWsCLFy6JNoLhmmcR3YBHgm4ASUzsK2z65QwrEiqYz79gtepU
	ba6S5bpBrOtUT2P+m9PVri+i0qXKYuTSmLioGBQtj44TvyYcvHWEFVEZjI7NZlkNq13T8Ugv
	/wLeNq7iHXk79lnAxjLjBkxy95v3J4Q1+euVaRdDN/ZGFQXkjTuOHihYCpJzwbxLK/A8/9K2
	MOvO+Y9OxIf6hvDS33BOk8Gl+eUan11zOR+atfGBxZse+e6WVESlhabYG2TrZJKOJ+uJA1Xd
	YYf2W42RA53Tz38PWap5PTqzdTI2bjuTdPP7YVBtyP/N+WZP574bdb0jI6JjH+srIx7v6dH4
	jaozAnzO3DmY33fhXICp+ZDV+63k+10dfxqWCvKKbCKH5MuleKvpU6WFtKvNZ4dsJw/29gRf
	3f0UJDR/cO/ocfsDp98OccPWKP2KPdRRa9G371d0yPGJOq/xw9JvbwYvx/eJcS6TkUkwLcf8
	B3SvXw5qBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTjcodXqqQfNOfYsH87axWTzc8pTV
	4uXPq2wW0z78ZLaYcaqN1WLftZPsFr/+rme3WHRjG5PFjudn2C0u75rDZtF9fQebxYEPqxgt
	lh//x2Sx9dNvVou3d/+zWCzsmMtiMenaBjaLqS+Os1s0/dnHYrF0601Gi3eNhxkdRD0uX/H2
	2LSqk81j50NLjwmLDjB6tJzcz+Lx8ektFo+Je+o83u+7yubRt2UVo8fnTXIe7Qe6mQK4o7hs
	UlJzMstSi/TtErgy7izrYy3oYa7o2PGQsYFxP1MXIyeHhICJxOV5Zxi7GLk4hAS2M0q0/fnB
	BpGQkti9/zyQzQFkC0scPlwMUfOJUeLCms3MIHE2AS2J28e8QcpFBPYzS5xuiwWxmQUyJL59
	PAE2X1hAW+Ld/WOsIDaLgKrE6zOLwOK8AtYS+3bshbpBXuLP/R5miLigxMmZT1gg5shLNG+d
	zTyBkW8WktQsJKkFjEyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYKjSytoB+Oy9X/1DjEy
	cTAeYpTgYFYS4V2/bnKqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQi
	mCwTB6dUA5POok1757AmtHxNn5Uq5uC9xMlX2q+Wd29vx721RzUba69ufvdFZjqnkliRI8fl
	i7l2J2/+jc5ze/R65vlXL4KuCATt4FnVWPDviED9xmNPysosfTafiivc4p7ce/D+9+D4ztlr
	PtkuLO6cnp4tsmYjV/ZUCy4ul5nnO04kS22Wvr26c/XWfcJC6iq7ip35ZhiZN508lJ+Z1NGh
	Pb918fEHilfv79nZ1xTX7t34Jr03O91v3Wubq7yFvmoZz5jzJUpWfz5++YvTqdcFpyYd/lj7
	7TqjUSHzs7VxWRdfS9bK6sS79C+cu3D5hNPtXR/7FF7mPFb4MJV5Zar+rK0ci6w7npx8dmWj
	fXvG7ca7FzYrsRRnJBpqMRcVJwIAgh3lKR0DAAA=
X-CMS-MailID: 20240105021130epcas1p2b77331ab0fc865cc3763765b0b5ecadf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240105021130epcas1p2b77331ab0fc865cc3763765b0b5ecadf
References: <CGME20240105021130epcas1p2b77331ab0fc865cc3763765b0b5ecadf@epcas1p2.samsung.com>

From: ChanWoo Lee <cw9316.lee@samsung.com>

This series has code some cleanups to the UFS mcq code.
No functional change.

ChanWoo Lee (2):
  ufs:mcq:Use ufshcd_mcq_req_to_hwq() to simplify updating hwq.
  ufs:mcq:Remove unused parameters

 drivers/ufs/core/ufs-mcq.c | 6 ++----
 drivers/ufs/core/ufshcd.c  | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.29.0


