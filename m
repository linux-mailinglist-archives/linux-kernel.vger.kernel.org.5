Return-Path: <linux-kernel+bounces-57536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A563484DA5B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14078B21A9D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E5692F1;
	Thu,  8 Feb 2024 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oY63nPPw"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0726C67E6F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374922; cv=fail; b=jr+l2FlXaZihFebWacYOHXepTGB+077mEumWi1oMd24H120RnxE0bkL+VEwy6ROTpWYeunH3mmR8oTQ6EnWqYedoA5Z5UD1Slu49BTmQ1VVR3p10OLQMS/FZoRWJy3m1QY/Vt8OT+RP0ulKEoRJWn7ZwuLN7oO+apFSNKmxGiDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374922; c=relaxed/simple;
	bh=+o0vXU7b1JBY608S8Yr2XwZISNjoetGos6riJE5rzOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WHMdOIufR9UrrfVGNqZKD6HvGnw7JRZfbZ7oDFWzg04ySReuO9creGh/Qht551xmBSmFk7t3cnm/5NdHOehar2j6/IIWFLMsu9dLxhfDsi/fEV8aXYCZLy0nt60KngBNw3/qXwuD6hKE4ioYbU+vXwzIMw1WlLXWjgs5sB5VoPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oY63nPPw; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaS3hwyW2VnTxnGTK80HCudCRKl1bYx7hVTI5LuaihPKO6vsltBnF/SF1sj6w/N8/Lj9I7HI958YZOygbzW2tmT6WBuAddr/g3P/FhIhJDjD4bdczh/h+ldmXaYbt+v2Tzd6CPLAHb70tFwXqiv85cmO7jc9c2ReNVaIKiGMu7jigHfc6h5eO3R00XeKSs4EH39T9dvA37+EhXuDhu8Sra37ZQ/TeTuU33SzYw7BDwmpaxo2fKPhlq2hS7EGkFQjYx+mz5h6CIAznRsGcx4BUA+nfcjRgPOaHHcO/+rd/g1UyE0DEWDL71o4YQlEwnPdWB6mS7luWL5ftim9mbDsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITP9ZF4/xRpcxYTF8bYt/ybIPxetBX3E0y+gyh/KsCY=;
 b=EstQHdnMQrndO0w5Q3k15AXcf7ideKNo045rcKeszfiVTywYncvrvnctVVuUEIUXuF1utL2CqMEltrNWeSFmV6cGBtfbLgWCjN4s1cQj5OWtrf0kDozM091K/1nSKJmAmHI9K8Sa+W+lW+O6nVaCh4uqo7uzRMcI+KHs9f3FSeLWzY2Qo8FnSWMwq8z6LjVcwZT1EqYM9v4jD9ZBsWQVGK5rbqt56t2L5luPXM8MwUmfXmGX80CJd1mLD8ETfTgI6C8KI/apvxu5qTWfI245C4chwuX8Ilt61Mf2+0ymjgo1lCsLu7W1BDnFvyOJtMKpVtCD0Ii05Hfuqh1tMqH/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITP9ZF4/xRpcxYTF8bYt/ybIPxetBX3E0y+gyh/KsCY=;
 b=oY63nPPwg2C+TPLQ/sMcF0NQcD+i1ubX7MnUfE2eEP2ASvnWNjQYhIOM+CkX5bPfeDwC9gGclECaN514EtkNxY2prh4TcRnGksAsGvQJhVhWi4nbpkbg9oKEeb3qmCyhk8gz0MeR/9tVC3DDp23lm+wPYGrYkdJaIbMunGQA3+w=
Received: from DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10; Thu, 8 Feb
 2024 06:48:36 +0000
Received: from DM6PR12MB4154.namprd12.prod.outlook.com
 ([fe80::6b2d:9a4b:4c75:9c89]) by DM6PR12MB4154.namprd12.prod.outlook.com
 ([fe80::6b2d:9a4b:4c75:9c89%4]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 06:48:36 +0000
From: "Akula, Kalyani" <kalyani.akula@amd.com>
To: "Kundanala, Praveen Teja" <praveen.teja.kundanala@amd.com>,
	"srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Kundanala, Praveen Teja"
	<praveen.teja.kundanala@amd.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 3/4] nvmem: zynqmp_nvmem: Add support to access efuse
Thread-Topic: [PATCH V4 3/4] nvmem: zynqmp_nvmem: Add support to access efuse
Thread-Index: AQHaVcyGu1zT8gGX0EiQTXcAtXl0ULEACgvQ
Date: Thu, 8 Feb 2024 06:48:36 +0000
Message-ID:
 <DM6PR12MB41543B4250DE257853937EC7F8442@DM6PR12MB4154.namprd12.prod.outlook.com>
References: <20240202113843.17999-1-praveen.teja.kundanala@amd.com>
 <20240202113843.17999-4-praveen.teja.kundanala@amd.com>
In-Reply-To: <20240202113843.17999-4-praveen.teja.kundanala@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4154:EE_|BY5PR12MB5509:EE_
x-ms-office365-filtering-correlation-id: 4714d833-4a7e-4286-630e-08dc2871f991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5rHQFMbhZdhBdxaMNa9Jut1SKnokCD5Eu523/4XHqou/odWkn/ZuuC0SNNkADKOdUiJPohoAGsPFoDavh9FkCDw27rS8RL7UQyt6Cmk+mH/NLfnVhcsCrBLkIfbam/MSF1q4cr6YKo3NRU8OJLw5uKKkOEdJ3uGg2dPDAq0/EA84SocCTlXDBCj3nFcwL7n9slEUfRB0fGtku01oAoQwb/3OiFuyX65iCM07fH2tXugcsB37TwV5Nx8tnbrt8QKmeONNjYRe3gpWMq8V6PPDYlERlydHRj06zyv3t8aiq+G65VcIkzkYc9UtTkwbDBpOt1G4nHGdOiES2gOGZI1h3rWugUR6M4HotGEw5ai6Gt4A1NYIQNvPOWcNrsYezrNsdIVT2aiBwPFuhcMWn3fqlHTQyhl3XMSFu6+JIIfluf3Ww30X1TPLD06cO8NK7EomM3d86lb4cE9i/nll6lmErwzwm9c6RX1oztp7sdOrjORlv1/4fXdxfw+xTK3BC1yJstUgp9w00NM5UFt5YOaImusEaz0mq/m8h7ZecH3DHumuc6hRoV9U5+TjPnzteLUkDbuujkP7wwCF3dplg/VDxsBgrGHK/xbRX9+8OXmC+VfdFgXXeHJ0sKV25XSEQBWK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4154.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(110136005)(316002)(52536014)(41300700001)(2906002)(83380400001)(38070700009)(26005)(33656002)(122000001)(86362001)(38100700002)(4326008)(8676002)(8936002)(66556008)(66476007)(66446008)(66946007)(64756008)(76116006)(9686003)(6506007)(478600001)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?61rZWucfIXz2eDacHB0DFZzuW86JkPjvbC91iqNkhcn0gL5xTJhcIt6NOkBF?=
 =?us-ascii?Q?HQdKMIab+F+UxLX5LtdDyVG5sUvVBwFu+CGJniWQcGB98nSVg8HczM8HUOxg?=
 =?us-ascii?Q?L+q9SAYk/LCGc0dcChBqlP/PIacOEzWk7VuaaqepKtSggq4Nzx5OqfvHdbZN?=
 =?us-ascii?Q?RWG5O2Zb7nahowg9W5ZAgJNtR71QwOV+e1g8ZwVhu8l0rhwGCwW8eqecrsNU?=
 =?us-ascii?Q?eU0hUnPNVqucxcyxUMkHdG+IZQ9q2ZGIZXcV+z1c1HcyEDYqv/hCN54INMc9?=
 =?us-ascii?Q?N4kIEa9f6ggi4ocf/m3VHWl0w/cVdF7zRNmKg57jrAxof7UNZMA+gJyOClLs?=
 =?us-ascii?Q?nrI/7DVUTKRZ84PJrzNOqsTaken97G9pGXeNDXQdPQHBvDh41GSPnwXfz8lF?=
 =?us-ascii?Q?5VI7d422HE1UCw7dytH0mL3XNutoJmbGAsOKElOcQBG5XBbQrdFDPMiBPNzv?=
 =?us-ascii?Q?+bC8Dlu3gUzMiEZ6cByIN2VnIOjWFU3mp26zerGKTJBngR4Q9QLNJo7deBvo?=
 =?us-ascii?Q?TfqOvJyC39x8MmY6JtyKQD+oSQtr0mGkhne6B2djpO+6YNqKz+nZaAfTQjvu?=
 =?us-ascii?Q?TnCH3vJEx01pwovig63/itI+LPQXH+fnKJ74wxvO9YdCe+V6iIX6+CRwkx2W?=
 =?us-ascii?Q?Yy4w/cWtLHKqYVWzLW0QnfJyTTHbPYlOH6xbk5vcuj8AzNp0q914+gf6pkBp?=
 =?us-ascii?Q?hIR0kLnWAOK0j3d6TVwZj5fYLkrV4+dMPunXglT/NzvIz8DpikqwhLx9/q7w?=
 =?us-ascii?Q?5VScfSGR10Ld91LLzMuKvzVgUyCiM5eWzk1nHbMyqg90NZc8O+9R1hdaYWLZ?=
 =?us-ascii?Q?OcmfVFfJa5jjiov/Ia4ZwPy5S1l3YhEdt65/nco/4aY9kSi4Ezwn3DB4JLIM?=
 =?us-ascii?Q?Ixqtbvd3YRhAAvd9itEiIdIq3XBw6wvSr0NQtXCTKOujiDL2xr611t/OzPqK?=
 =?us-ascii?Q?DfY4GB/Y7O9WsKCDOkgO9+u8Ie+DUeIjF4yAOJfuxGbGMt+aZ9YX38nbNHRG?=
 =?us-ascii?Q?fAkSypiKe7SQqJ3FOdoTTUt28T6JqU4jBkRtSh4hk2+jkzAoc7ixT4HBH3fC?=
 =?us-ascii?Q?mkY+1BZ4b1/QutQqMjC+xigHneIIKM27BT9YMxmz7odtJDllQhuevum9fgtk?=
 =?us-ascii?Q?1GCkPswL599F6i3JJL2mJM5jSvQ8rAf4rQaThrSeXlTkE/dpWzj3rVFG2TSg?=
 =?us-ascii?Q?f+IoKDNEbNrY6ZTV85TZ1pDQ1fDsepGlvYtOx0ZYGtg4UNgTKW16Goamw5+0?=
 =?us-ascii?Q?DXKgu8FC/Zv68BmSUsyjmwxUSLWbV22QiS9XFhrEtBJItjhp9eXUknIxB2X/?=
 =?us-ascii?Q?riwmZxFPIne9swlXiLmOVwUs5AtbQqlLDZr6tEaxdclfRebuX7nOv5kv+iQK?=
 =?us-ascii?Q?Gir7PpJf/DVkrWmloWAqZVTlBnEhvswBt6eJxI1S3J12ozPeEWLSCK/32nvF?=
 =?us-ascii?Q?0AFWT06mtHyhx7DBM48ndEs6iHdslcZAO4v8AvGIbvYhtvVtxJIv3wlO93YO?=
 =?us-ascii?Q?ygyw+znaLSE7vXBpIClQORo74rwcDvmmEkePkB2b1tkXslWRkPbj8kuuHoY2?=
 =?us-ascii?Q?jN2j5POHPD1FjBmpby8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4154.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4714d833-4a7e-4286-630e-08dc2871f991
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 06:48:36.2808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsAbc2jRWeovZuDyQVhu4t3v7+WuljH88mzl5HQrCO8jYSjsbKXqUXgV8aIbO9+VcD5sMfLIL6XbCVeqiOi34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509



>-----Original Message-----
>From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
>Sent: Friday, February 2, 2024 5:09 PM
>To: srinivas.kandagatla@linaro.org; Simek, Michal <michal.simek@amd.com>;
>Akula, Kalyani <kalyani.akula@amd.com>; Kundanala, Praveen Teja
><praveen.teja.kundanala@amd.com>; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org
>Cc: linux-kernel@vger.kernel.org
>Subject: [PATCH V4 3/4] nvmem: zynqmp_nvmem: Add support to access efuse
>
>Add support to read/write efuse memory map of ZynqMP.
>Below are the offsets of ZynqMP efuse memory map
>	0 - SOC version(read only)
>	0xC - 0xFC -ZynqMP specific purpose efuses
>	0x100 - 0x17F - Physical Unclonable Function(PUF)
>                efuses repurposed as user efuses
>
>Signed-off-by: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
>---
> drivers/nvmem/zynqmp_nvmem.c | 186
>+++++++++++++++++++++++++++++++++--
> 1 file changed, 176 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/nvmem/zynqmp_nvmem.c
>b/drivers/nvmem/zynqmp_nvmem.c index 391d8e88b270..8682adaacd69
>100644
>--- a/drivers/nvmem/zynqmp_nvmem.c
>+++ b/drivers/nvmem/zynqmp_nvmem.c
>@@ -4,6 +4,7 @@
>  * Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
>  */
>
>+#include <linux/dma-mapping.h>
> #include <linux/module.h>
> #include <linux/nvmem-provider.h>
> #include <linux/of.h>
>@@ -11,24 +12,189 @@
> #include <linux/firmware/xlnx-zynqmp.h>
>
> #define SILICON_REVISION_MASK 0xF
>+#define P_USER_0_64_UPPER_MASK	GENMASK(31, 16)
>+#define P_USER_127_LOWER_4_BIT_MASK GENMASK(3, 0)
>+#define WORD_INBYTES		4
>+#define SOC_VER_SIZE		0x4
>+#define EFUSE_MEMORY_SIZE	0x177
>+#define UNUSED_SPACE		0x8
>+#define ZYNQMP_NVMEM_SIZE	(SOC_VER_SIZE + UNUSED_SPACE + \
>+				 EFUSE_MEMORY_SIZE)
>+#define SOC_VERSION_OFFSET	0x0
>+#define EFUSE_START_OFFSET	0xC
>+#define EFUSE_END_OFFSET	0xFC
>+#define EFUSE_PUF_START_OFFSET	0x100
>+#define EFUSE_PUF_MID_OFFSET	0x140
>+#define EFUSE_PUF_END_OFFSET	0x17F
>+#define EFUSE_NOT_ENABLED	29
>
>+/*
>+ * efuse access type
>+ */
>+enum efuse_access {
>+	EFUSE_READ =3D 0,
>+	EFUSE_WRITE
>+};
>+
>+/**
>+ * struct xilinx_efuse - the basic structure
>+ * @src:	address of the buffer to store the data to be write/read
>+ * @size:	read/write word count
>+ * @offset:	read/write offset
>+ * @flag:	0 - represents efuse read and 1- represents efuse write
>+ * @pufuserfuse:0 - represents non-puf efuses, offset is used for read/wr=
ite
>+ *		1 - represents puf user fuse row number.
>+ *
>+ * this structure stores all the required details to
>+ * read/write efuse memory.
>+ */
>+struct xilinx_efuse {
>+	u64 src;
>+	u32 size;
>+	u32 offset;
>+	enum efuse_access flag;
>+	u32 pufuserfuse;
>+};
>+
>+static int zynqmp_efuse_access(void *context, unsigned int offset,
>+			       void *val, size_t bytes, enum efuse_access flag,
>+			       unsigned int pufflag)
>+{
>+	struct device *dev =3D context;
>+	struct xilinx_efuse *efuse;
>+	dma_addr_t dma_addr;
>+	dma_addr_t dma_buf;
>+	size_t words =3D bytes / WORD_INBYTES;
>+	int ret;
>+	int value;
>+	char *data;
>+
>+	if (bytes % WORD_INBYTES !=3D 0) {
>+		dev_err(dev, "Bytes requested should be word aligned\n");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	if (pufflag =3D=3D 0 && offset % WORD_INBYTES) {
>+		dev_err(dev, "Offset requested should be word aligned\n");
>+		return -EOPNOTSUPP;
>+	}
>+
>+	if (pufflag =3D=3D 1 && flag =3D=3D EFUSE_WRITE) {
>+		memcpy(&value, val, bytes);
>+		if ((offset =3D=3D EFUSE_PUF_START_OFFSET ||
>+		     offset =3D=3D EFUSE_PUF_MID_OFFSET) &&
>+		    value & P_USER_0_64_UPPER_MASK) {
>+			dev_err(dev, "Only lower 4 bytes are allowed to be
>programmed in P_USER_0 & P_USER_64\n");
>+			return -EOPNOTSUPP;
>+		}
>+
>+		if (offset =3D=3D EFUSE_PUF_END_OFFSET &&
>+		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
>+			dev_err(dev, "Only MSB 28 bits are allowed to be
>programmed for P_USER_127\n");
>+			return -EOPNOTSUPP;
>+		}
>+	}
>+
>+	efuse =3D dma_alloc_coherent(dev, sizeof(struct xilinx_efuse),
>+				   &dma_addr, GFP_KERNEL);
>+	if (!efuse)
>+		return -ENOMEM;
>
>-static int zynqmp_nvmem_read(void *context, unsigned int offset,
>-			     void *val, size_t bytes)
>+	data =3D dma_alloc_coherent(dev, sizeof(bytes),
>+				  &dma_buf, GFP_KERNEL);
>+	if (!data) {
>+		ret =3D -ENOMEM;
>+		goto efuse_data_fail;
>+	}
>+
>+	if (flag =3D=3D EFUSE_WRITE) {
>+		memcpy(data, val, bytes);
>+		efuse->flag =3D EFUSE_WRITE;
>+	} else {
>+		efuse->flag =3D EFUSE_READ;
>+	}
>+
>+	efuse->src =3D dma_buf;
>+	efuse->size =3D words;
>+	efuse->offset =3D offset;
>+	efuse->pufuserfuse =3D pufflag;
>+
>+	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
>+	if (ret !=3D 0) {
>+		if (ret =3D=3D EFUSE_NOT_ENABLED) {
>+			dev_err(dev, "efuse access is not enabled\n");
>+			ret =3D -EOPNOTSUPP;
>+		} else {
>+			dev_err(dev, "Error in efuse read %x\n", ret);
>+			ret =3D -EPERM;
>+		}
>+		goto efuse_access_err;
>+	}
>+
>+	if (flag =3D=3D EFUSE_READ)
>+		memcpy(val, data, bytes);
>+efuse_access_err:
>+	dma_free_coherent(dev, sizeof(bytes),
>+			  data, dma_buf);
>+efuse_data_fail:
>+	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
>+			  efuse, dma_addr);
>+
>+	return ret;
>+}
>+
>+static int zynqmp_nvmem_read(void *context, unsigned int offset, void
>+*val, size_t bytes)
> {
> 	struct device *dev =3D context;
> 	int ret;
>+	int pufflag =3D 0;
> 	int idcode;
> 	int version;
>
>-	ret =3D zynqmp_pm_get_chipid(&idcode, &version);
>-	if (ret < 0)
>-		return ret;
>+	if (offset >=3D EFUSE_PUF_START_OFFSET && offset <=3D
>EFUSE_PUF_END_OFFSET)
>+		pufflag =3D 1;
>+
>+	switch (offset) {
>+	/* Soc version offset is zero */
>+	case SOC_VERSION_OFFSET:
>+		if (bytes !=3D SOC_VER_SIZE)
>+			return -EOPNOTSUPP;
>+
>+		ret =3D zynqmp_pm_get_chipid((u32 *)&idcode, (u32
>*)&version);
>+		if (ret < 0)
>+			return ret;
>+
>+		dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
>+		*(int *)val =3D version & SILICON_REVISION_MASK;
>+		break;
>+	/* Efuse offset starts from 0xc */
>+	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
>+	case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
>+		ret =3D zynqmp_efuse_access(context, offset, val,
>+					  bytes, EFUSE_READ, pufflag);
>+		break;
>+	default:
>+		*(u32 *)val =3D 0xDEADBEEF;
>+		ret =3D 0;
>+		break;
>+	}
>+
>+	return ret;
>+}
>+
>+static int zynqmp_nvmem_write(void *context,
>+			      unsigned int offset, void *val, size_t bytes) {
>+	int pufflag =3D 0;
>+
>+	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
>+		return -EOPNOTSUPP;
>
>-	dev_dbg(dev, "Read chipid val %x %x\n", idcode, version);
>-	*(int *)val =3D version & SILICON_REVISION_MASK;
>+	if (offset >=3D EFUSE_PUF_START_OFFSET && offset <=3D
>EFUSE_PUF_END_OFFSET)
>+		pufflag =3D 1;
>
>-	return 0;
>+	return zynqmp_efuse_access(context, offset,
>+				   val, bytes, EFUSE_WRITE, pufflag);
> }
>
> static const struct of_device_id zynqmp_nvmem_match[] =3D { @@ -45,11
>+211,11 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
> 	econfig.name =3D "zynqmp-nvmem";
> 	econfig.owner =3D THIS_MODULE;
> 	econfig.word_size =3D 1;
>-	econfig.size =3D 1;
>+	econfig.size =3D ZYNQMP_NVMEM_SIZE;
> 	econfig.dev =3D dev;
> 	econfig.add_legacy_fixed_of_cells =3D true;
>-	econfig.read_only =3D true;
> 	econfig.reg_read =3D zynqmp_nvmem_read;
>+	econfig.reg_write =3D zynqmp_nvmem_write;
>
> 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &econfig));  }
>--
>2.37.6

Acked-by: Kalyani Akula <Kalyani.akula@amd.com>
=20
Regards,
Kalyani

