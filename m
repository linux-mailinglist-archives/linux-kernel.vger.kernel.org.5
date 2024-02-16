Return-Path: <linux-kernel+bounces-67896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9742F85728D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DC71C20CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4E46A0;
	Fri, 16 Feb 2024 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DeLR8/fN"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D98A21
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043401; cv=fail; b=VeuN48UqwnFjzHk9TwiQjXCo6foyleyakv4RW3WWgjzZZgamrwv8iWcSsKN4cyx/jwAvYK3VHHDJpUlPDAzaZj3ZgjA+Tz3PqSSSDTtziB98v4enbn0hzjU7rP3pwLVypw/m1XCn2Vifq6H+rjezyfiwv/yfgROX5akQO4bwVbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043401; c=relaxed/simple;
	bh=bLpVfdJKtTIAY+uX8ZAKtu/I+FmqzH1f32vHZAjCaYs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRfek44Z/w99KVqeYcV14FFeoo0cOLkoX3lm12oCqqaVwGeLW7J+v4O4U7odnWKTF5F9/bBKmmZV/s6GucKHpdu9iEHyA8+d5qPf2D9f6vqYz4nsxHpi8hNWn2mPaUOx5BTdsNv2NCQ7OwsD8R64/7uXZGDvBza7e9iu/Gs/ozE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DeLR8/fN; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRF69FE6SBkC+04u5r2xZPcGJaUpsaUM64/cA58O+yr0NjdB3rmiKYKD1F+F885H0ZP0SLoRlnhWPrDF/BAXVu0j9c5RkXxWqJFBMKOEnpxK2EPGWhE0B69+NS81phy1lI9VULFnUweMIcnasuo9toH8YXVAv7BOpLvB8RCAKBTjbDaNMlsrpQHTd3+2Ut9zc4+90aV87I+uPJIQePUS/kqPRDSoVggt4x1ZrOhoGKjvgluFqNd/XQRral+VuEEF8soBf+TXukzJjGZWmBu5hAdIPkTcp0DPuOK8g2iSIlccP7FDKIzwmHXS8EhEqw1za75y1ZNqRqYXCK5p0M/fjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdTmzYklbNoOZBdysL9Dp47ykjJqdkdvgnJOmsThicU=;
 b=i/I3CEshJHekF6R2PoKK6F84ZCXwQy3cryxF3UBUIpXcM804xzzrZGeoIPUwAiQsavLsZ6jOjLDPOfxYXpZ4nWKQp6Ice0AnF3eLMfpJWha8eHm9Agpp6gYlOmkm/TTzigGvnUQMZSJOxm9PZcMgJheCrqpSWv7LqSdkxxryrRitdURclaBFKhl/W3lQaeu9FzdHgc79u7rMciGSZTMqr2hzTSsLeXLIiMbFG3PAsW0XbuP84LG7Hf/bZWimnXJtA5oQQdwUXgoOj1/X1HMCcCeMq7i62SqdUx0iWSIJZitkLlAtZECXPmI3qcjSB2Kcp+9piTkAnIANqOMyeXU4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdTmzYklbNoOZBdysL9Dp47ykjJqdkdvgnJOmsThicU=;
 b=DeLR8/fN8IDGFaIqr0FIkAY6PMLqFyTCrkcT+Abt1dlJrrFLkfBvNGc48hhb/ip6AB7cpJ9zN1QmQkpGY5kCtbJTJO0iYEu25fCa3swJrE5biKA7IbWO5JIE++pVcCdMy7f+MEIb0kXBQ1hZnenQcxRdYW6rQUf94o3U3mC3AeqUCWWB2xX8RyYDCCJ02pethq+Lux7IsJMCOZ0SBeos0KyJFfYtpfSbG0uh0Wrr/Tj6LgC6VrUsteXkdseiMlja89bI7+a045Kp+O1TZPwbTyfONYXUhs+BpX6v79VaNPaNL4EkkKgQVZ8P7ENmqsIptPqG0NBi5SwYOENJuNPLEw==
Received: from CY5PR17CA0021.namprd17.prod.outlook.com (2603:10b6:930:17::17)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 00:29:55 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::80) by CY5PR17CA0021.outlook.office365.com
 (2603:10b6:930:17::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Fri, 16 Feb 2024 00:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Fri, 16 Feb 2024 00:29:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 15 Feb
 2024 16:29:44 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 15 Feb 2024 16:29:43 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Thu, 15 Feb 2024 16:29:43 -0800
Date: Thu, 15 Feb 2024 16:29:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <axboe@kernel.dk>, <kbusch@kernel.org>,
	<joro@8bytes.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <murphyt7@tcd.ie>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <Zc6sdQVL6O8XN1kr@Asurada-Nvidia>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <20240214164138.GA31927@willie-the-truck>
 <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
 <20240215142208.GA753@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215142208.GA753@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM6PR12MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 667c9ad2-7b83-488d-1a4e-08dc2e86662d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hVW/QabgAGBwz6ORuwG9TmCg+0DFk/xH/XHNRfXRd9HQIQyU/caiWMKUH5aSVQs9yFJBkS395Blwz7bSb8478Af4lG3MYIPgL165dHTC+5Xo+u2qP2bDE8ILcTxk9zYtKJ0kIAwAskW9fRnpT0DLOgGwt3wWVaTx0T8O6qK3Vjathzm5Y1dasOCDXzaawmlmZ4wO2sBBY4XmN1aV9UDtNG33a8lx+LXkHa1sC4K86Uli8t7FsyuXolWuH+rCy54fT9QxvE1d9+CCXRS/Doh0l71aoNYgxG+DvDN6LC5OjpvHZ/dg1sPyRsZTqWNCHBi0u+6GrtlgfCUFuKIvLJ+wT5D0kxCRG5q+XvM3W7mOwtO0plmIPbiSb4U7CquM2W0QrZyANospzuIpMwVcPdfR5jFX3ewpEqfbbB3uG8RggoGBR/CBM4xeSiELtS6MIzqsR8OxNGwlPTLIjxXs182Ymwyl1Mt1C9oHm0CNPalsNIFX7FrVLOBGVLu8XUVrrBjBv0RgmXGh8zCBtkXeJC7C4gj9NT43PbDzQV5hbLs6wkFZFDnn1fgHVjc31pja1eMgONZD893Kb9ar6ZUau3oBMlJ9swlyTqlgxnuJk2fFRRWhOl1dG2udzNXuOQ/Awjby5R+k8zxx4SQeqtwpEoJlwZFGoJp+xyqMVSJ+2zLXTnY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(230273577357003)(186009)(64100799003)(1800799012)(36860700004)(451199024)(82310400011)(40470700004)(46966006)(4326008)(8936002)(8676002)(6916009)(7416002)(70586007)(70206006)(2906002)(83380400001)(26005)(336012)(426003)(82740400003)(7636003)(356005)(86362001)(5660300002)(54906003)(41300700001)(316002)(478600001)(9686003)(55016003)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:29:55.3557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667c9ad2-7b83-488d-1a4e-08dc2e86662d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975

On Thu, Feb 15, 2024 at 02:22:09PM +0000, Will Deacon wrote:

> > Though I am building with a v6.6 kernel, I see some warnings:
> >                  from kernel/dma/swiotlb.c:26:
> > kernel/dma/swiotlb.c: In function ‘swiotlb_area_find_slots’:
> > ./include/linux/minmax.h:21:35: warning: comparison of distinct pointer types lacks a cast
> >    21 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> >       |                                   ^~
> > ./include/linux/minmax.h:27:18: note: in expansion of macro ‘__typecheck’
> >    27 |                 (__typecheck(x, y) && __no_side_effects(x, y))
> >       |                  ^~~~~~~~~~~
> > ./include/linux/minmax.h:37:31: note: in expansion of macro ‘__safe_cmp’
> >    37 |         __builtin_choose_expr(__safe_cmp(x, y), \
> >       |                               ^~~~~~~~~~
> > ./include/linux/minmax.h:75:25: note: in expansion of macro ‘__careful_cmp’
> >    75 | #define max(x, y)       __careful_cmp(x, y, >)
> >       |                         ^~~~~~~~~~~~~
> > kernel/dma/swiotlb.c:1007:26: note: in expansion of macro ‘max’
> >  1007 |                 stride = max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> >       |                          ^~~
> >
> > Replacing with a max_t() can fix these.
> 
> Weird, I haven't seen that. I can fix it as you suggest, but please can
> you also share your .config so I can look into it further?

I attached it in my previous reply, yet forgot to mention before
hitting the send key that here is my gcc info:

# gcc -dumpmachine
aarch64-linux-gnu
# gcc --version
gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0

