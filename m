Return-Path: <linux-kernel+bounces-134756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A2389B670
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07827282178
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5969D4687;
	Mon,  8 Apr 2024 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cpU2mBU8"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2028.outbound.protection.outlook.com [40.92.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664D1851;
	Mon,  8 Apr 2024 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547404; cv=fail; b=ZnAF3QT92B2WECGGVXtijAEN4Ixyy5TsvyF/0EUkzwtZsqbDkWsOy1ZkorzSg8ch9CEct8DinBCLD3c+cahP3s/NlWThtwjVWRMj2/EkH+gkdpw0Ikd0i3oKtXak2X25fIdpjvGpisp9ydGj3wzXNfYwSyCGKYAYP+jBBYmCNoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547404; c=relaxed/simple;
	bh=RW3Vcu+pBuM8Ouz89hCFm3+7XrBJRg4T1ezg40F76/U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=inc9DuiDOsJY1jOMfJBCGcOOcXioiclMiLWszDV6LpeMFHDh6qY/jyj57KqDMohswBtpOIsYQ2fcSHE6guBtKaPfMsc9FYwvv8uCs26JfsX2kAOnL25i22HdGXMHGxb1KnzHLVQP0Mu327BI9t6jqXAFqe8Q82al66mWvMqiigM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cpU2mBU8; arc=fail smtp.client-ip=40.92.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9MZnMY71IdcNy7CGuTk+9z3pAiG0LvCOkG57mdhkRo2RcRLgktXUavlFuJTHEOwT6ztnriCmppbZpua9v8DRPIaeqf5euQhtrCyzWRS79pJ3w3E4gROYF1p98IqhTRbCqStK5XfzHWjdQCtUrBrrnCPbR7vKCjRQHK0DKu0+6NJQZ/Gm721LnchGcNp2CUMyrHCTLT6/UE/EYKb0F2FdT8TVg7uYbjqeqF/hPU9s0qShYjPucgIVA6k8byHzYMY9WUAEiQ1LX/GegkwCGnvn+Fu98EhzbbfaQFlaaujrEa2Z18QxGJargqso5OQtFuiiH6+MgzF/VqpPCt/jDQtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh/VM2PvaWXby6D1nbK/G/Ihjx2YeKbQpPxdCvQ3goc=;
 b=KLF56n8MSIaz7usdXeeNOi85Cr8xwyS9aDgLJ5HIFLQEtVGtCrbQUFu1F7MjyeSoV4RPvHPYkAw5lw1J4VEEZCpF7kO5vwgKxUW9p1EGES1HpX2/SOyShmkQVaxwz3IMuRpQ5MpxkHEghmuBuyZ5QcdJZpg1kyTyRuwsOR0NRirlsYCNl7RoTZGxb/twRj1uXZ1mA+1Q+DXhRtzalxV17E19IpxkXFB0DBAi23y/O+hh2/VP/t9X85WEj60ypx32t6RBzyHgmFi+RhdxCjKCmnbWn1FEqGhGyI+N3UHHwqRFwJWO7J6u3I5nKCZA/hxIQ9g9HecDbr291m2RWoFJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh/VM2PvaWXby6D1nbK/G/Ihjx2YeKbQpPxdCvQ3goc=;
 b=cpU2mBU8YtwEEPUvNGNbNgawIl5K6up0jO/y5J0C9vm1mDsqkusuoKkPIqaMHJNB1D3MdcD9UO/8qiScNly7aC+P9P4dXhlf4eAk34t7/e+dlvch5mo2YfqAy2T7GToA3rU4pjK7UwO9lUfJB8FAlP+smHZdLleeuuGNbhcJmKLOLSPjXWc+QxBNc2SkdcP9OkWfHNCn36SSdjgYl980e6Mv/5X2PBdHbGZlGraPsQksB17I/KGvSVe5wCkmzo/cHAzbfACzH+7Ko4hLxYNklSWI4frIF4nK/OvsCreG7xanBuY0dBLUwUo2lQ8wwSFPloHhVGN2edj1ivbitGe47Q==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by KL1PR06MB6041.apcprd06.prod.outlook.com (2603:1096:820:cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 03:36:36 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::45cb:f62c:d9bc:b12b%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 03:36:36 +0000
From: Guanbing Huang <albanhuang@outlook.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v5 0/3] serial: 8250_pnp: Support configurable reg shift property
Date: Mon,  8 Apr 2024 11:36:21 +0800
Message-ID:
 <PSAPR06MB4952B86F64A6CEB853114EA4C9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [p97xvQlQGoN1tk5Eyn2ARy0a0ypZKaFe]
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID: <cover.1712472167.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|KL1PR06MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c2ec61-78f1-40e0-bbe7-08dc577d180d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UoGlc1BrzhyqAR6AWi1SmadhVnd8WwNi2msCt7IBkuoigJIuqbcm3D3WrVyBx5QWpeY7Y0gD+6jCNUkWmT3VbTOi7si4JwHVbt30VJLQ4k2aq9842CzW+t3qGr6SYDFBVHBfR47jX/XTaTlUyvZwMwCH5UQQrbxRKqBrT00DzDdaoAgqYXTPz5Ywic757Rksdpsct654ClpvTLGChZgG/EMvMNn4TxIVLoiFwfeNbR4mD/qKDxR0tFDn/0RTtEYKfYmSuM9xYQHJEa8HftVPRAWNJaXtHaDxbZ6O4ilm4OphEpx2A8oFcY4AGfsGGAPX9d2j8Oy70kt6LXRaMqT4aLYz0gjVJt3e541aqVKEjIpF+fF16XAHvhLlxlPEzRrs9OO1HnIPNmT7TzQEJKa+uX4LlL3Uiq2a00fBweCpxMjyc3H/+gxq+DGo4e+78pG5Tis/550Y5ZN0j2OsEuYzaiEtldwTj8fU8vrJVkAe+r5VfPhTTw8dWJF9n2c9POjMRrbbPouN/kOWYxy23J/8o4C4zns3x2qONXL7dYVTG137VRqz8fzfXXkcMho3bpYr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nNNQZiNGct6q5Xxa5toL2/5lu+PCQLcBx7BTsFgQ6MQtDMfu38vne8BFx2qd?=
 =?us-ascii?Q?U+PE5Xq8qraP+MP20ZUT8yvlXU0wJeMlIvqxCVkZUMfuL/qW8CKcSmR62gdB?=
 =?us-ascii?Q?IBGR/HJCiTZ3Cp1e4k7zUnIWNxMaN+xl1151TdCIAG2KTQeJO+ZqyBtpLu82?=
 =?us-ascii?Q?5fkYT2poZ8+U+4h8A9gEQ6Xzc8bmo0FxZjeRyOC3/E3YyqEGZmghz4699HPJ?=
 =?us-ascii?Q?aaMOf/B+krCCvieWkM/XGz+DsEID00wtcsbGOKPpqY98uYBviDmyeuuPFphG?=
 =?us-ascii?Q?66Zh0Z9+z+7YuV9Iv+nHaP0sHlXzuTyUlOlcdB5cgpMgKMdJjzB+vi80/5S4?=
 =?us-ascii?Q?SbLFGfU4H+jFuemuzdqEohU1nMzNnSCRiATiDvBDlnvjPZxc+oq7F6o2fnd6?=
 =?us-ascii?Q?3VfdVjRmHSlwndzrU8nEM5zpacptoWUHd9ucz+I8TfNmR6LiksrzjFPr1sGW?=
 =?us-ascii?Q?JbM2wuz3qM9BoeXB9lIwxI3CBIrdOK1QxjLdBcngJdVNb7qhNrTk7d0zSkMM?=
 =?us-ascii?Q?IZd7HM6GgNQyF2z9qaDyc8IBnvHS1sKBnq9bCds43zCVn5sfZEdjYzELYB0J?=
 =?us-ascii?Q?oqnQa457T7N0SRiCG1/gSASd9/Cj6HVyHvxxwitSebpSYUdEICJOQXeaCGq5?=
 =?us-ascii?Q?gkC2ebIBO7YLFO1le0dIMjQOkDs05D6WhmiRDIDk639e2t8GT9FOrD3z92YP?=
 =?us-ascii?Q?BJ1+drlcx6ymushR0xBhRJhbMsnRVoGUhZ4hxxedcdRkyZssXsUZjciHYZLl?=
 =?us-ascii?Q?EWs9AWH8XBktnJ2oEUFs7ZBgDmkkYg+veg/SDdYzNLUf4+XhnZPz9cjU2D0f?=
 =?us-ascii?Q?HVGA+7IPp2b+aDao9mY3gYJORTKV32nCjuddkhM8UomSgwB00ztDjoZFo9/r?=
 =?us-ascii?Q?HUVYxXJ793fymWTp4kKrKj1ILi9EiAQyVnsaJi2vt6dWdl4qdYZN4Rx4ODkN?=
 =?us-ascii?Q?/wIHv4dH7Orz/+PUmfRP6mjXHj8KnWqm/lxd+5v2zaMINte72TUr56EYJMpE?=
 =?us-ascii?Q?qk5UYRuJzlWxvLNzdds4igihKh9QCPW6Lp7O8D+g8TwhI60zJahUsjiR5Z7M?=
 =?us-ascii?Q?kbUfLuZSEgEYXVsa/xbWoyq0s78tXRx6w6/WTxZyZMRaTx0hc2h9v7aM9j37?=
 =?us-ascii?Q?DKhVgA1TFOZ02QdYDXV4PMvr5yHt4mKdaNdDTlLore6hL82gQhZ4i9kVeFwb?=
 =?us-ascii?Q?ARzoOcKKRZ8l61AJsbTF0A+5Czf5sXzPrgtYemIu5uU1KfNphb1AONnKvCs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c2ec61-78f1-40e0-bbe7-08dc577d180d
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 03:36:36.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6041

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

To address the issue of configuring the reg-shift property, the 
__uart_read_properties() universal interface is called to implement it.
Adaptation of PNP devices is done in the __uart_read_properties() function.

Guanbing Huang (3):
  PNP: Add dev_is_pnp() macro
  serial: port: Add support of PNP IRQ to __uart_read_properties()
  serial: 8250_pnp: Support configurable reg shift property

 drivers/tty/serial/8250/8250_pnp.c | 40 +++++++++++++++++++-----------
 drivers/tty/serial/serial_port.c   |  7 +++++-
 include/linux/pnp.h                |  2 ++
 3 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.17.1


