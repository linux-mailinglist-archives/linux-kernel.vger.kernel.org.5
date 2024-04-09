Return-Path: <linux-kernel+bounces-137539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3033089E39A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CC11F21A86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE20157A49;
	Tue,  9 Apr 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a0mEvOMh"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2167.outbound.protection.outlook.com [40.92.63.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51127156F28
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690957; cv=fail; b=Pzafj/B/jLPfEgiwP78ixBy3I3kLOmvr+O4k3x5REKyUSTHum406jtVDRYYcbFDakkZK/7jqkgRYRkaDO7lXiEs9IAwjd+ZO5kI+r5XYPXjRmMZJnbmjIx8PyvYigLJcIfGHwQGby7VlPtHswAAhQgpOMO0X/o4qzsSQjZ0/vb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690957; c=relaxed/simple;
	bh=/abSMjJnhJy/GRrcxzc9Ti/wb5srA4wWKpF9gUoN+rs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XkYNBD1WwVfknyljogolUdcZMs161RNEdPjuRZurISSMkYG5+ywsV5mYwHisKc8/zRtsdM8a8tFKZUe+VDL99TsmNh/D31kW9G5uW9Yq9+YMfqrWPCTUmmGlqa4z22WKEMe2SKiuUBJJ8rZ83Q1yv+LuYsPTRa0wXceXk5+WpTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=a0mEvOMh; arc=fail smtp.client-ip=40.92.63.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCQYWpKob8/Z/+DGsEd76YLzaKr0fzdQ9UyRNfz9iwo1S75uvL4/wHPnhqhWp04dSvgv68tXt374Y3WHfdbPM4E8/YIoLOxxD16cPMoFVsMJwoQaMTfb5qlCcR72tUvxosgIQEsN3ikiV0IMpAfYfAqNefobnyfqYvEo/PKnSQF9fCR1LYSq5sq0fT9qJYiENQ3fniVtFe1nbgob2oSqg1dm8CS/fz/FoUzauYi8rIIuBVnHnpeGWcbtkCdEFcnsgaxGGGsArjWQ0XMq4fUYzh3AmA6bEH0eFwF7752EyE7SD+09MmOxhljDeOEi55I/9VO85U4G2eI7/EU5RFw48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJkBVwCzyu/YWCxQ0ka0xHlkDWiVkGpFD4enGMeb+nM=;
 b=I0AXp7LecHXEBVHhzCcCtqm7bghavsqJnYMZK+C9HICBdCYYFlHeeVC10ppyR8EJ2Z3miHNiul1eyjfFpNb4kunbGRYlmiAEQTEX5y7epCEdpoUW/+I99WxM2XM2ErHFs0Zruhy5KlQ7T7KCACMXrPHYTirEzlhvIaAPmDXzFOpbuhl5lviSXjNIP+/luUBrTqDEUpe5gWWYxATcyCN8fGLd6uzZ5u0AqwmUeJ+zJnEGY1hakqfRjCG8UsuSF9L+b7hfvAr9FmDi1RfikkjgPe01IQgoR+cChjm8UrftuGt8tyIJzhgcZcRXgtSX0Gtfs8//AgeFoba78IaIrN+m0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJkBVwCzyu/YWCxQ0ka0xHlkDWiVkGpFD4enGMeb+nM=;
 b=a0mEvOMhUwyBGpummFd9LXRKlpGMpuFh6bTAMiw6lvYnnX+At+sjA6BThhSEkfaedkzEj/n5yErUJ9Mxbb0MGzciRg/06VpSomntvKweGK4/cn74qHRwdUtchSd1P20EfA7UKj851FL9+P4fGEMsPuEHyDV1/tsOMV/X/F3JaMY0BdlYSct9mT7UIEagJ52jHldt6dA1J/WEpUSpt9COAzNX+A9efPZzfcRlv8qSpNH7BrEg0cUIwty0X0bSWPFRzS7grydpFNHiDnMnB0gzSskjQB54SXrF20zmUtmOxzvaHkD9pgF+/89hRSvVX0iTUfAFnE8nRopKNB6t1C1wZw==
Received: from ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:108::8)
 by SY7P282MB4618.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 9 Apr
 2024 19:29:10 +0000
Received: from ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9f2e:2acc:8692:8c4f]) by ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9f2e:2acc:8692:8c4f%6]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 19:29:10 +0000
From: Holger Huo <holgerhuo@outlook.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Holger Huo <holgerhuo@outlook.com>,
	Holger Huo <i@holger.one>
Subject: [PATCH] drivers/nvme: Add quirks for device 1cc4:6a14
Date: Wed, 10 Apr 2024 03:28:50 +0800
Message-ID:
 <ME3P282MB24818FA28E7C73BC01302882B5072@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [q6e2MVHbtPtY/uBcIX6LRzZBwpjzf8lB]
X-ClientProxiedBy: PH0PR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:510:4::19) To ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:108::8)
X-Microsoft-Original-Message-ID:
 <20240409192850.218284-1-holgerhuo@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2481:EE_|SY7P282MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: a55dc67c-99e9-4e20-5581-08dc58cb5489
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3oqFuGM6J5e7QNfoBoQGPrJ/hW50Py8P/cAde+aZcp501ioihScf5OZGAU6LeVB7FimqQ1BuuhpMBlTJpylu4P+jeNWoNia9+bN5UATDxX+nJqGWDSJkcboEzxaTZUC2hxqvAFd2VKFYvtz0ih2N0w4cuYU6M9bxKCoj/qmTG2h5FWmz+a93AOZ4HV3q0OHKsZ9P7OPzwcrgQkj01+naO6r+ZaJO7oTROXn/YlGRYSOo7y2edamTwvNSYWrO/ROh5HRK+Gn54G2tSmfz945XkK2lplSgp/qaoWNC/x2nODMV8v38qsJh+AdZyAp4TlkDII9cSjYqrlGmVO2m1W1BK38JUp/3wBn35EIcgCxbFPlczf6jGNTJ1IWiHSnzPAlQAwt6pz2ZYkYgC5cDyK+vSFWhWrLxKBSe/+AoCuPJEvoSxyUdEXLxUhB9bKntzz4SaSZwWf+mxrdbfKYdrOk3fAYXURVZg0im9heF2A6v+OekG8u/hVbrNRS6pxWBAcFAKYQdig5gVen4vQvkpA6qG0K0B1YrVtw+wWkTNfqkHwIQ3SM7nA3jqkk6iF/B7FYbOjVJabMrNh+szqplmzQA5v4URK6Rfx7xWE/hPM3IrYMzWn6x0temc3p6paqQ30FF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SFosHq2N5QkRLoJWZQkJOQ6hLfnsciA4Iq5LE/K4KbV3pwsJqJp4ovV3jmiI?=
 =?us-ascii?Q?e5mcsLIUKq5fWIVcd4QPM/8wuPmfBBE1CFkbOiOw6E7M8nPsuK+4ns3/fLlh?=
 =?us-ascii?Q?fLuXlSpZ3EQ3DB8nqWvJf6f+v5MWTL9E8B58v17NFAVpCLqdQiCSJIF3GpdL?=
 =?us-ascii?Q?t87rJtCwEzOtHWM5q5u2BMQiyAFwQpRcRJhEPOyzOXOIVMYDdY6lDzJI7WRx?=
 =?us-ascii?Q?r+FeqBxxXG+D1EpHLiLiqnh6m8aK4WoDV4lz11GgQnAeixB7X5ab4SWU4Foq?=
 =?us-ascii?Q?u4htFWCyNIfNz5JCOKbmHBky4042Mc0j9jlk6aHdyjjzw8iZzVstRWR70qUd?=
 =?us-ascii?Q?V67fzMaoesP16IktKTIy3Na8rTysVmNGGvJgwgx6dFcDDYcV6wJnGJZ10H87?=
 =?us-ascii?Q?ppqtLy71sPuCnL/nwbfK4QbVaW4hr1FRPmHVmiaFruJr4uCVpjLHH99pa6sC?=
 =?us-ascii?Q?Ga3YxuxrDqkjH9WOpCulGtbxOQoRNnNLOMlpvGB77Wizm6WXYLca+h27l2lS?=
 =?us-ascii?Q?nHzsnZcg6S1ZpJ00A97o+4MKZvL4gHLoGuiH9LwG8bEP5Lh69DiC7ACttdfC?=
 =?us-ascii?Q?mNWYM47LuJmNngIMG68cDkJFULbK6UYnCncRofgLzcBmNGE4YKLZ5zsNQ78w?=
 =?us-ascii?Q?IFb7SIhfkn9u0YG45kJY6CFDVndwkNkM9wPLozbvBu75NUP8qPwye0wrk5VO?=
 =?us-ascii?Q?Thg2lhk22XkK/PNDEiXzJq8aXOaMmBVQV+Vc381quO2l7ZwIDmF2afKD0b4y?=
 =?us-ascii?Q?h2iUGwP61TxOagkYUyZPGOyYZgr9ENbROg0PVHc/oQzVDIkiCVAMC1VWKQVw?=
 =?us-ascii?Q?C2wKZdRdGhTCVut1ChyuOi1eY1tIDy7upTWbkpUrdae0vyNKibXbRr6lpP18?=
 =?us-ascii?Q?+ZSuoSRrt1oJvtesdSkPYNWhtlnY2jueokTgjVPDAq5Sjn896dcIBHHYZvo1?=
 =?us-ascii?Q?XkFxrAKHeLQ5pe/8Lmihqzk+zCcNrsvCkEs3KkF9WfS28055fpy0Pwx0V6Lz?=
 =?us-ascii?Q?58TxvsTyKdrIMl5d9tmzaU5Orh7qFE1XSuEVSAPDsQUnQWIj8DsaZTgt18Ze?=
 =?us-ascii?Q?5xsObibRGpeVGPume6zfKMMXwzPbMXIsZ3dUKS36lga1cd0og27xxMO6mN2d?=
 =?us-ascii?Q?WjXdW7iwdAzq78H2dbbKOh92fVKkxd6MA7rOiZYFJOfpd44VglU5WBqU1APB?=
 =?us-ascii?Q?j3iYqfG8ICHQ3c9RqqFz3YheNp6STKIKWMf7hc9/JbLF0xTyFdNQsPR/m8M?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55dc67c-99e9-4e20-5581-08dc58cb5489
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:29:10.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4618

This commit adds NVME_QUIRK_BOGUS_NID for device [1cc4:6a14], the
Shenzhen Unionmemory Information System Ltd. RPEYJ1T24MKN2QWY PCIe
4.0 NVMe SSD 1024GB (DRAM-less), which can be found on many Lenovo
notebooks. This SSD produces all-zero nguid.

Other SSDs manufatured by Shenzhen Unionmemory Information System
Ltd are likely to face similar issues, but I currently have no
device to test.

Signed-off-by: Holger Huo <i@holger.one>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692..b478b1736 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3482,6 +3482,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1cc4, 0x6a14), /* UMIS PCIe 4.0 NVMe SSD 1024GB (DRAM-less) */
+                .driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.44.0


