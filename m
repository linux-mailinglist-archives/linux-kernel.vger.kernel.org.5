Return-Path: <linux-kernel+bounces-161644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B51A8B4EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD93B20C69
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E27F9;
	Mon, 29 Apr 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hDHCWzj3"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2087.outbound.protection.outlook.com [40.92.43.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2D7F;
	Mon, 29 Apr 2024 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350600; cv=fail; b=O98km6Ma0Vzo9XV6w2R2zJYoI5PwrfheA9q7FwkSkIfrxU+Jklr4kzlomvHRTZCLRCJFsbJRcT1Jw7ZhhKY7oM2HXmPPdL9rHs/7xJqWpzJBLljalYeOB3zLZ1LZblrMsmvxN1h53AskF2K4iFFGzfgnXlg2rlxDzzlB1pdhQIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350600; c=relaxed/simple;
	bh=9s2cb0Hen3vsAivsIy3aK+dXpE1H757JhuqE1IVMTgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iM59vkh2REINks+Badm9rfYCDGND+YpZLDO3AKSv2h+IkQj9R5sxVz9WWytcfYhbkSiLpO4l5mLYrQKlna6cUfgSbnBJl5yjVobwm7NDXjfwOFiipeOi+dhXAnK2fxar7c+nHPEf0v6aW+6uyJwHzQUQY20FJks6MtMIy5BfeJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hDHCWzj3; arc=fail smtp.client-ip=40.92.43.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZp15NULFYgahqL2eEZEMB4N5WPG0YFk9KRbi1C/yVoD+FbjUgrXYzfF6JxS70/VxQdIuuUuSsQScMig0w0g6iiINoMjueiRdNHshWaBZrN9tm5u9fuisYFuuQQ6K/hylfC/4OV5PhwJUUeXiRdHeh657VKjgA1Ru9/ZzAUBll+svPyO/XMWwD2LIxp1MYG1sbrCXzwtCrMVSHYrIqrh9M8AJ3RYsCzIcK4wuT8B16bhzIf18i/hKFrTZMRDF2Ir7IJ4es4VhqwSNrKNlKuXjRMAkV4ffo3Vlj8FJ9j/KsITGhOplIyMjIcsdaZLhVDKtk99MxAaP+LsuGc9pLjGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orq55nBc8TAY3tVn0RJDfoRYuHG1FgnZQW7OBatnpTA=;
 b=YrxKqw6YAkg72e3vxPrmwDgT9yGnyyZj8ZOV+jfC2jYiomtvRsZlE8sz3buT3RH/jkb0JHw9Fuvo//KCQvMaFezzzsIAgyRc6kQDfzkwZYmRltdHCCw+ZzcZ/mvkyfkoY9Z452fEVaX4C8n12N+OjDvq++9gjWF2bTf3axWzRnlqDEXjvzYKPnWPJj3mxPtj5blUDehi/GaTsuB4Qui0M66j2q4803kU0w2PggMoUunr1/nPRkNeD0fGo+8herxGmhlGOBD2Ggnm5nANc+G/tciDqn7eQF8MB9LcMe5bLMorH835WQjA31T0B3DpmoGvb50D+69/Eo5olluYx6nPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orq55nBc8TAY3tVn0RJDfoRYuHG1FgnZQW7OBatnpTA=;
 b=hDHCWzj3Lmdp+ROuLHtVEFZcVUoNE64SBX8c2GaoF7mVZUd/M258UTmvwrI7CBbVNi5HrPetL1jxGinMEX0DYbm3AQ6GVFdIC/agRV8QNtrce6wq3EZtD9K6ELS8F3iBtVKEuvPhhehPwHc0SN5HO07WAy87pQ3ZN632OsqRkF0NGCXKGE9ReGelovSi9X8pLLjN8m5250nZk5WJG4AQMUzL11S99RPqjyW06Gk9giC9C33oQh0p4wWGlzLr/6xbSyrL3446rDeZDA9IO+KAziXse6lPOJC9U26RuLRoRjCmiv6CZkU+/pbt4ldvZDp/4Fhgqx5KmRJREgusKACekg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6009.namprd20.prod.outlook.com (2603:10b6:806:339::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 00:29:56 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 00:29:56 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] riscv: sophgo: add USB phy support for CV18XX series
Date: Mon, 29 Apr 2024 08:30:23 +0800
Message-ID:
 <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/4Jxvj+QxUHka3DpugCta0HI3Eh9RRfSxcTNexa1f10=]
X-ClientProxiedBy: TYCP286CA0191.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240429003024.105235-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: df00932e-f418-444b-5e70-08dc67e37e9b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	9Lt8TZnnoqxoLdlku3DiVnjDEayYGExJrMZ9rdLqs1+opBfFJBXVzM5cUei7+ElB78OqA41fVcvEUiRIhOdz24Z2CIPQpRi9pDeZKMswXOdCSJK2Mb0QxyC99+LFHHZSOKndJcuwSh5txyxYXrVmqYr/Kw/6GFleBaz6ZJ2fzg0wbCTPtxKvCKbvjp+4LXZ2uU4gY8F3oEOgmkrjbF4zZ3CjNohg3dXrkZYMnO4hY+8LyvlfkZEw19xmRSe4H5V1qoNVlu/127jTcMWUXa2L5q0oHqXFeQObXUnRKKxN/3ivyHlF84uZH6TCJFjYy2kdnNxgCFDPgN/mVR15j/uGSdiOFEOD6K4ML4nvdmrhA0Z/K11MhzlQJwI/OXO1x2uNlxWmuYhjlJjqBrx9Ghxhw4XTGbIG7tgjT2ZsAJECbRoi3sTWa+apeT9dWyQxIcJsSxkW04bSGL16ITimukEa1vPugaHtAOiUT8d1Xg4dvuHH7oerTjEn/sH97USTULPFE9K36MxQXH63PgPJiUjiFJFpkChOrrsXUtqozoVRLI7A+Ke//HkEgFxkzLMM81GQJED5Tz/HWlUlBFgDXVKsseCVd4Y2UV47+9+LoobtLf9WJz67GnbxxEvOHNj6xVCi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZnoatnzDvkl1xRp1E/A5V1v+AliVfBQ19GRbVVTWIq143LC9hsvu1x6TWJJs?=
 =?us-ascii?Q?Wi6hRhOULXWPS+6BjWB4iwAfWmsowqBxS3JUosVboX0bQe+5agFSWlJq1Z7t?=
 =?us-ascii?Q?mRLMY08+DJq05/6DaYCJRlig28AWTLEd2lzfcRgVcvnEclr8og6Rvgx3BzC3?=
 =?us-ascii?Q?Zqoz+N7Ycmn9gMFrX5rBj5A1y6LIp4B0zJb7ae8K665yeJSCUFmDy/EwGUB+?=
 =?us-ascii?Q?Uk7E+9tNf8GtUyRgkUs4mQHUpPyzF2LSSCxISJKKmdAhdRtk3+64u3AlEuJ5?=
 =?us-ascii?Q?3TmZ3wPe1si8wjmwz3P/NBMX90Fsf6W1KdpjzQNdcWBBHB66lwnVr5PspXuW?=
 =?us-ascii?Q?4miwLroAsZCyYmtfC+pd234NZ8If7sVfkPOrhveNf+01t4CZA02hQ+A5wxzv?=
 =?us-ascii?Q?08niPC/yS7NS4dIdp3jQgwDlfiB79gWk4o+4F72QjY4Yu6q6O/PAwk8fQMsb?=
 =?us-ascii?Q?TZ+gohtQtsgsZCGmAGuqvATXaexLtYhx4I+ZjL0o+Xv31HsnpV8mM3YkvwCf?=
 =?us-ascii?Q?dDvaxy8T7s/JGcWMoKitDdn1E8aOP7MQetOC+z7TDR1RRCq1rg2n+2cIQ3sN?=
 =?us-ascii?Q?XHOjdL+53mOCflgaqYa5KfMgN6RkoFYkDMKohRtzLfsUTc1SYd6E1ZRSAQNq?=
 =?us-ascii?Q?9iYHPMBst6rsihv4m0c/lYBXVoRvDLqz/wI1BhAs0CTZL6XCdrzlgeRNB7lx?=
 =?us-ascii?Q?UZpZF7GVaKLyRL9JX7z05dW39+P+SD8xV3KReBMNa4AQAfVEIqwA2iOzYNj1?=
 =?us-ascii?Q?vrgnyjUjyvLogW7sqbMFSentnt0uRkUBtFm6M9IOj7YOEvICp3NvIdJSXp4n?=
 =?us-ascii?Q?72lrPsyF4rmTH5gAnwNIthTI3WDyMz7EK1N5OgaxzXG1EfEAMs7/xi7973s+?=
 =?us-ascii?Q?sDGK9DCF2YFrjLDPRJ8w19pEFxDyKnx9PKtgnJylOn7Yhwa1ovlQd8hGVArJ?=
 =?us-ascii?Q?+Wc/BreovldgNrX8DhThIjzh0LL9HnTEFgbjQ2psGn3kG4AqkGwMBMREF6TW?=
 =?us-ascii?Q?gTVF/q07GmoU7o1TkwHPImo4znJEAcu9rsRBuAJKI/o6qI17ebxAcxTbakEG?=
 =?us-ascii?Q?ynEISYXDS0Lts5vSedI/jal1OWbj6sSnV+DS4dhph8NOh9b9p4F2K5y1QOPM?=
 =?us-ascii?Q?pZkkCCw0Y4NPGji+UIVcTyCfcF8HEzsxVkm5XmfaSsQcVg3/LZFjdWplIltO?=
 =?us-ascii?Q?W9K0W6pCufm02LzV0HBPIURVUUeFkiFx9WGyXRG7YF2IA1ehjjGQmQkDq1Cs?=
 =?us-ascii?Q?dto0suERTX5c1LO39DMY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df00932e-f418-444b-5e70-08dc67e37e9b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 00:29:56.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6009

Add USB PHY support for CV18XX/SG200X series

Changed from v1:
1. remove dr_mode property and use default mode instead.
2. improve the description of `vbus_det-gpios` and `sophgo,switch-gpios`

Inochi Amaoto (2):
  dt-bindings: phy: Add Sophgo CV1800 USB phy
  phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X

 .../bindings/phy/sophgo,cv1800-usb-phy.yaml   |  68 ++++
 drivers/phy/Kconfig                           |   1 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/sophgo/Kconfig                    |  19 +
 drivers/phy/sophgo/Makefile                   |   2 +
 drivers/phy/sophgo/phy-cv1800-usb.c           | 378 ++++++++++++++++++
 6 files changed, 469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb.c

--
2.44.0


