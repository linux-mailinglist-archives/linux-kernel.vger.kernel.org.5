Return-Path: <linux-kernel+bounces-90215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA186FC0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB141F22D7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8CE199BC;
	Mon,  4 Mar 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="iHD02OCl"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0E1B59B;
	Mon,  4 Mar 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541668; cv=fail; b=T9FIBiXU515Z1L0PAKQMrlunvAhkdnv6mXjhG49evOdcXT8XGsuyMAdPbQW+4CTdKI9Fr4cB8YsXbNtBouSoZ6LaENjRxjJZYH8toMM7aSo00LTo0T+utUYx4OrybsMNBl76AHDfLSGWSdMFv4N+YleNEq7EoU+juBddYK7pwDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541668; c=relaxed/simple;
	bh=ZlG+iU0kcLTj5LXA9qvf/9TMBfN1vqD4gMX94dODp+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hUovkZyGxxQZto52Voun1Q6ukCAfyW3xgrKknx1OrZpMjf/pgXbWFPwxZu/fbMFQnFbS6tbCKrhwCzOEbDWOyu1s83vIun8JHS4E7K48HPFwJJJv3NhVp8lXa1sAUUZOrOISbKvziR6lXwB/qioTVh6QgXNfy8+ngaI08MVNbjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=iHD02OCl; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUlajKkMwKvFgBjmUT9Mp94JpfcpkSBMuVTJAl9SEIDwSNVi+NviDDK4qQoxfyAoAVKxChlyVGo8aKhMKCZbdSx5QwVSJov39BV66AlVe130t/E+zBfrhmUBkSOCYhDPSiCc+XwzXUlPnmv/Ru0ut8D1yfhB0lFkTOIiatTvBj32JiDxkROPZ7QXidKo5R4OE4RMPz18xUx3yejE0MgljOW/t3SAEPeSs20sDk+1WX248RKZNUX9bmEXAhsbLMoSQ4accBmHJJAhLicAS87wpVhOG5onZDVG3E6WBLZrJ9T1Ee9yiP87bYutHsim7xf92klalj9zLqtQMulfUNpfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3wJrELjKT8hZYaRReF8XKVqzeH55cpVGeMTpLGbQAo=;
 b=afCrNG+5jWrR5x+HrqVboByFI2ZHkF4325ZY7AObkRvEs3vyLRF1ozQwVzP2lgjubVSYL8IAHatgNdH0WO/mHLVYtqUO/Ky2lt7I8SBUeq1Qs9P189hNt4jAZhVb3WzSYGt1MvqziRZ+m0CWIWCH+WpGPavBMAWMZj12m8HeWIhtROLYupPlwosEJpb48fJpDtQYzjuaPLF9kvu9IxBUm+nTCjt+//6I5aUMgnuG+XA/XrC8OOU8JHA3PSABNqk3R0Po7cReP1HKneZyAJiv0F6bTV95ak8QqIfsEnPz1G7r5dWsoeDxAAGbNMoex0P2WD5Yya/mz8EDVZ+4uJZzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=gmail.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3wJrELjKT8hZYaRReF8XKVqzeH55cpVGeMTpLGbQAo=;
 b=iHD02OCl4N6BD3LGgxe6ufhRukUEhQEwClZXGuEz6MfDRiAENUlFkhXOIG9hu3IHcv1ojbeE9LscO89P2sJt2LqbaFoSTAOWoF+kHyqRuVnbIWKWVwdrHbs9tPfkddAiUeeQj9noXTc26ILWx6Jmytn5XhyfA5OqJo7BfTdZMm/5TtVbZDXwHIfHoWjXTSZKPOW88TmY8iIDwNFdbnYt5JLLZX//iE5FF74l/TiZEprihaIfusMhLf8OchTQzicHXuazj3G5GXYdTvYHzBgRjEFQDYcpioAuHcJL6MA/bD0Dz9YzoB3ZFDfvRjLh4rUgw5x8le4M0ciu6BRrS4bQDg==
Received: from SN1PR12CA0114.namprd12.prod.outlook.com (2603:10b6:802:21::49)
 by CH0PR08MB7321.namprd08.prod.outlook.com (2603:10b6:610:112::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 08:41:01 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:802:21:cafe::b0) by SN1PR12CA0114.outlook.office365.com
 (2603:10b6:802:21::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 08:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 08:41:01 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 4 Mar
 2024 01:40:59 -0700
Received: from BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f]) by
 BOW36EX19A.micron.com ([fe80::bbd8:8149:f98d:966f%8]) with mapi id
 15.02.1258.028; Mon, 4 Mar 2024 01:40:59 -0700
From: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
To: fan <nifan.cxl@gmail.com>, "Ho-Ren (Jack) Chuang"
	<horenchuang@bytedance.com>
CC: Hao Xiang <hao.xiang@bytedance.com>, Gregory Price
	<gourry.memverge@gmail.com>, "aneesh.kumar@linux.ibm.com"
	<aneesh.kumar@linux.ibm.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"tj@kernel.org" <tj@kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Jiang
	<dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Huang Ying <ying.huang@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang"
	<horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [EXT] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
Thread-Topic: [EXT] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
Thread-Index: AQHabeE3Eb14wzuJtEy5fkTksq7A5rEnQq+Q
Date: Mon, 4 Mar 2024 08:40:59 +0000
Message-ID: <714c3599236046b182ffd0e0eb5e3ae9@micron.com>
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <ZeU6_BnXIUs6pCym@debian>
In-Reply-To: <ZeU6_BnXIUs6pCym@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH0PR08MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 4789371f-24dd-4868-a4d4-08dc3c26d233
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UfG+ktEa3fBE9DpOldSTwWJVq+yPNi0IcCIgISi9eASJTEkm7yB9+n+siDClfpOqph8fzva2jeDMSf9tow0ng0fhIJfPSt1lQRrpuap7Z157hQ9/0+UGED2VNDljIwdesCVHmPFIISo65SIGW4RbMDid43jJNSBfJRu1w5qMqfz3pKc+IsTcJybmDiHNoiM/uoZqswGOJCKqofJpw+tf2LIOMyMaWidIzDWSdjcnSB+k4rNZMqg2xyM+iaJDORL1zWwvWs6OUT7pTTmKbBg6j50vhTfUeptNvqneeFGmTxmBQ3BT9cFo5rHfKEJSBN3S7LDKbUeLHvO54HYV4ex5HivkirLy4Z1M2yFF7K1ThiAwtf6sOapZSa7wmxj6vwcttq0DxH1uqDEbiC6ksPuXqec/+Fdh272z1NJv1RZd+CChCG7bUrYIjhiXWFsdblyOwxjPy1BVQszAXMtevpvYgDT6BBuxNuhFWDKqX039laj1hSqCbB3dxMbY0x20yk/hmdxCqUwCvR/Ur61tOCvrxSjnbh44uQDXyAxc4Uc3+Jiva67q6hVovep0o4oEQbIOPzmu9X1g45Gk22ph6QD9F1zdcztIhGvCVwZTcQDLU7FX4TFKCVdppg0hM8qPGVHaQ4h110k3avKJ0ggC7EhMv6L7N6PDo4xE10Jyy9+VZAAc7XrR/DAvD56i0y4Jt3k6fcX/cPaIfT4Z8MrnEkfNag==
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:41:01.1853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4789371f-24dd-4868-a4d4-08dc3c26d233
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB7321



> -----Original Message-----
> From: fan <nifan.cxl@gmail.com>
> Sent: Monday, March 4, 2024 8:38 AM
> To: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Cc: Hao Xiang <hao.xiang@bytedance.com>; Gregory Price
> <gourry.memverge@gmail.com>; aneesh.kumar@linux.ibm.com;
> mhocko@suse.com; tj@kernel.org; john@jagalactic.com; Eishan Mirakhur
> <emirakhur@micron.com>; Vinicius Tavares Petrucci
> <vtavarespetr@micron.com>; Ravis OpenSrc <Ravis.OpenSrc@micron.com>;
> Alistair Popple <apopple@nvidia.com>; Rafael J. Wysocki
> <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Andrew Morton
> <akpm@linux-foundation.org>; Dave Jiang <dave.jiang@intel.com>; Dan
> Williams <dan.j.williams@intel.com>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>; Huang Ying <ying.huang@intel.com>;
> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; Ho-Ren (Jack) Chuang <horenc@vt.edu>; Ho-Ren (Jack)
> Chuang <horenchuang@gmail.com>; linux-cxl@vger.kernel.org; qemu-
> devel@nongnu.org
> Subject: [EXT] Re: [PATCH v1 0/1] Improved Memory Tier Creation for CPUle=
ss
> NUMA Nodes
>=20
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
> you recognize the sender and were expecting this message.
>=20
>=20
> On Fri, Mar 01, 2024 at 08:22:44AM +0000, Ho-Ren (Jack) Chuang wrote:
> > The memory tiering component in the kernel is functionally useless for
> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the
> nodes
> > are lumped together in the DRAM tier.
> >
> https://lore.k/
> ernel.org%2Flinux-
> mm%2FPH0PR08MB7955E9F08CCB64F23963B5C3A860A%40PH0PR08MB7955
> .namprd08.prod.outlook.com%2FT%2F&data=3D05%7C02%7Csthanneeru.open
> src%40micron.com%7Cc4f03409bf454cca29d008dc3bf853d0%7Cf38a5ecd281
> 34862b11bac1d563c806f%7C0%7C0%7C638451185012848960%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Dsyvhw1w8%2BoC6ss4%2Bu2X
> HjBuyrpwFK1hIefopgVbRy7g%3D&reserved=3D0
>=20
Referring to the following use case from above patch?

--
1. Useful to move cxl nodes to the right tiers from userspace, when
   the hardware fails to assign the tiers correctly based on
   memorytypes.

   On some platforms we have observed cxl memory being assigned to
   the same tier as DDR memory. This is arguably a system firmware
   bug, but it is true that tiers represent *ranges* of performance.
   and we believe it's important for the system operator to have
   the ability to override bad firmware or OS decisions about tier
   assignment as a fail-safe against potential bad outcomes.
--

> Is this the right patchset you want to refer to? It is about node
> migration between tiers, how is it related to the context here?
>=20
> Fan
>=20
> >
> > This patchset automatically resolves the issues. It delays the initiali=
zation
> > of memory tiers for CPUless NUMA nodes until they obtain HMAT
> information
> > at boot time, eliminating the need for user intervention.
> > If no HMAT specified, it falls back to using `default_dram_type`.
> >
> > Example usecase:
> > We have CXL memory on the host, and we create VMs with a new system
> memory
> > device backed by host CXL memory. We inject CXL memory performance
> attributes
> > through QEMU, and the guest now sees memory nodes with performance
> attributes
> > in HMAT. With this change, we enable the guest kernel to construct
> > the correct memory tiering for the memory nodes.
> >
> > Ho-Ren (Jack) Chuang (1):
> >   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
> >     HMAT info
> >
> >  drivers/acpi/numa/hmat.c     |  3 ++
> >  include/linux/memory-tiers.h |  6 +++
> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
> >  3 files changed, 77 insertions(+), 8 deletions(-)
> >
> > --
> > Hao Xiang and Ho-Ren (Jack) Chuang
> >


