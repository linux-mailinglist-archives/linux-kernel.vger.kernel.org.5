Return-Path: <linux-kernel+bounces-71463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A8785A5A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885B9B21998
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF00374C4;
	Mon, 19 Feb 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="hkfPydXo"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEEB282E2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352249; cv=fail; b=uS4PhXCj8Pv0KoIFo1HXLF8chVF2lG02K5j4Ht54hgIlPcNSnYNFh7RZSJ1ucOLrBSiyS3VUyy5NbIOMF9fEKRBJdqrqD3cG9MTpKhoK7kNawvOg7lliukZAtteAJsrmrbxrZVf4YEaq/Q58zqphQ/bokOucAcTKztQyql0zNmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352249; c=relaxed/simple;
	bh=qbqDMvlJ1rTSPF9t3RG4k5FSJyRZvep51xzNQfiozU4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TDCEleDMaEdAy/7NXcytDP78d9lb+crd3vp0qEWDIl0kSlYnP/EgfEFruLKb6kPgw+UYVebl1HQcx2wGsSLNWe7R9X7ucBLzQabxvzGhWz8eNYDsJzLjbqYWJ++PM+s40ojOwSsnLa7iqQfdWPQZuTO76CK4FnM8IIclt1HUL9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=hkfPydXo; arc=fail smtp.client-ip=40.107.117.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abpaqMXgmPYhjEgO0rKudFVdfWGFU2wr5sX7dNGjik++SZ7pqTGnAqISPon4npNGW9ngrH7EXLSKcBY75dmq1OYhGQ2BGEb7Z9F0iKjIXE2k5PgD7WYd4vdYPl8pVHfOE0wz39nRBpv6Q4/H9oF0M8/FAopr23XyVnDxaW99gcU+hssoJwFF2rczsePTYMvzYgt172gfbyIavB7a5gf7piJUbKcV3LzB3mEQ/DeI/FOWzMwi+nGDv6Wfdb7TjPDocgU8X2srs79rXaKjB3Hej3CvN8P4iLFpjKSlKEzno3LmhGVA5X8Cm30GFk3QcVdtfqK1V0mKDKFgkZF2FGdVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFfkghkmTAOy10L0dVJZM1Co5F9ETd4movKOzLTtlAE=;
 b=Gcy40bThXZP8snW+nMRluItOaaDhKs5UmC1/MP6I/WlgTmanycGWtyJI2IOznv89ZPQdui5DQhWqBwmo1DVlPmhz7zpBeUAcgKB5NoJ2qDpfrQTxEr3MDRrWDMYomk0T2UajJHhZpVcrD1PsKsgPQY3QpZgzVLsfmBEcj39BSHXG4yno4ojjSBczRfvJI2S8eLNxsr3HkSzKmynki5MZwcz7Y8hPdieRPHCPHnaXQYARUj3Oy5Ax/KDpCsImDyZWxsSvbPeQa+Nhge4+4LFPsUU2lGByZ4cFinDLmerDruOr/TGoKLWi+RKichurI9INZFJ0xFRoVuKEs6sP1+YVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFfkghkmTAOy10L0dVJZM1Co5F9ETd4movKOzLTtlAE=;
 b=hkfPydXo2XeGyTFb9eiYEl16Z1+pPSG+n47lNythhbtVCJoTxBJGoTF/qcyl0fhA7sVzzA0UqAhwCNuRc/aVFHjemegvk2nsJgNzIEDZS+vAN5XQm+ft7aXslYEbgh5h7fNWTwNtFf7Xtx7R53TY4JL51VfUuo+eWTclIIDh1m8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SEZPR02MB5864.apcprd02.prod.outlook.com (2603:1096:101:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 14:17:21 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::9b7:25b2:5977:633a]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::9b7:25b2:5977:633a%3]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 14:17:21 +0000
From: lipeifeng@oppo.com
To: lipeifeng@oppo.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	osalvador@suse.de
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Support kshrinkd
Date: Mon, 19 Feb 2024 22:17:01 +0800
Message-Id: <20240219141703.3851-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|SEZPR02MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 37093360-a9fe-4a87-ff4d-08dc31557ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hnqJ8T9Ndm5QhfzRTpSZQoSQvs7zKHoQZrGcsscdV5/cNBNo1By3rV7Ws+GedGOkOBpglbWRWduSy7ZwEYFoKV5cXDx9A26TQFE4bE0UBntHkpg0EA6h4CprX9ATU31FX92l+Iw2axOeMtBmPsmkGDMCvOIZObfScwiVZikOySyqeT8oZwZPVYHn4ZJe7JePhEEAcOzSbqZPFSt0mF00m2Ecf3c9njQoH836Mt1JYgr0vEuITWqkNIYRBIZ1wjunmz3yQVsEClnf88az3zZH4/uu2LTcm7xASR9dBAp5WD70quw70VmQodXPolvO33VS9ISilwLneM3RR5oKfakm8ui2L6dCGHqfyFXRYP3xKIj5rzQFEkQrdLb+R0FQqeYBiU7zAhiu+Mz3oG4cJ6JAZ6bA50akVmaSdJZzMbO7ykBfEFRBwdbK6HrVtESNbt4iQNxev9r2BV9K0+vf6neQQR8LtShH9zUG7MKq1KhYTCbjvjPf5qzs0WLoWMuBewkHStmbC4+NRXBNLJb7mEWGvyigw9XefkPhtYWwLnwNCjlgtC/IFDEmCcFEgvmMbpOqYAshhthr01KRvnpZQcnPObfS/RCElsKTieM2NMLiOSdm57XR3AmT/1raR4te+68h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t/KLub6oGiiZXcenitmS37R4aGIeXcPJIasuek1XgnTsxt9koxtU5/WM9BeH?=
 =?us-ascii?Q?FIbt5NDP4VEFVr2yQhL0qu1SZxigr92WDmBYcROajT8q6BK8tDfycwkXAST1?=
 =?us-ascii?Q?CggfBaHuBd//Ron9S68v3zGP3aNK9AgoCRcqfi0WVrYgqk0m3VUzR2k6tSYf?=
 =?us-ascii?Q?E3e7r4y0xTZAxbX8fO9NdZnYQm/AzDziAVyiVAuRNKNzn1yS91sokUnHesDN?=
 =?us-ascii?Q?6zoQJp6K9SSsLmbfwbnDeNd/AJ1eBVLnlFyJ80GxG3nVunLPUbm0XecDphpz?=
 =?us-ascii?Q?eONL7r+1PwcEOQrv+3FhazUx4/GO9nnLI4t87+PhG71ScW4hhlT7KJv9QbgZ?=
 =?us-ascii?Q?2KpgjBVFno0sOIJwG6V5WbHpWxiVtfy0+T7Eo5yQWlh/ljH9bYjGAkTz8et0?=
 =?us-ascii?Q?zIdqDNWVhgIe+rNnopWK6Iou5PmxNzRybcjeRBANgXtghRUqS0QUeaODxljd?=
 =?us-ascii?Q?ev86ORtJsXyuL+saXaSwQJGybCqRICu4Sc4w1B0jnS2jqcEJU285OOGRQMyG?=
 =?us-ascii?Q?kdeb5QCdpO7TEL5y0kYSYBG0wP3dCf30duQ6p0nuTtvMh2oToy8JmfAtvx8w?=
 =?us-ascii?Q?ls1N74d5cnlrkGhR6NUAD0oDcX3g6D+znx/vqVMK65Ga3c3VuMz/65xjrQPz?=
 =?us-ascii?Q?hSgOyRvPRqLp2zPDKcKh5CtGUmKAe+F4O9P3z8eilTyKew32OBP+Nrq2euSw?=
 =?us-ascii?Q?B8rSwtzKgy9+fqEUkJVvK92BaiWMwGJAaIyPhDWtCyoSh6HwOtfdBMmT+jFB?=
 =?us-ascii?Q?98Oey+Zg7yZYocXAXxz7DMZMldZao1X3wLeVoL+N0jaH3v/qyv6pAVILkWUc?=
 =?us-ascii?Q?zFEv/ETlgbVoYggwi/kTZ86ArvubIPayEHC+u2c5vzqM1LJ6Zgh94iCewnZF?=
 =?us-ascii?Q?qsY0Nxzc9OgEJKnGBi/4Nr2VlpRk+aEUAWWVtttqk3uALgXmm1Hd+8l4rY+j?=
 =?us-ascii?Q?svjsiPYSPDdKqyqMrYRtGxEHCS8d7bSrIpAwuqgQWU1gqNxEkdT1+bJZjPpn?=
 =?us-ascii?Q?RJJ9Ga6DRgvg5MVBgrMgccvXpxwmh5nr32YMtl7QkrNnbqs0HDwZaALTztGj?=
 =?us-ascii?Q?CT+dTuP2FljA1/TaZiAnyFEPmuB9LXAbyEVqxbkL5WDPi19v9y237JHoGxvt?=
 =?us-ascii?Q?BFeIVuOM6yl00a8GiO1fD7Z5H8xf8Zam72Vz/GmMzawhaJtMIwpYoWQf0V1q?=
 =?us-ascii?Q?Op+e55Ep8s/vyR33r3cO2D0zHFSwwY++PwWt7zczBSbvKZCtgUl7Xrn6HPJR?=
 =?us-ascii?Q?Zo5iv1XEnx6bP+L2OsvLinVvoPXpekau5TmbrxhgWeSyPMaqX1Gso0H1jyNa?=
 =?us-ascii?Q?38+rY0KFmGlhU7xrfqZIc05VZA5dwj5iTrzrv0Yg+0TH5lwhOvPjetwj3JGs?=
 =?us-ascii?Q?3q6tgHkY+L2QZI42TqLlcfs4e8XNSALctXQwuYiFgkbJLW4eD229Bg3JuBpC?=
 =?us-ascii?Q?cVgT1jYavlMDOFty6HS26KyjUW5nHJi7Wl31Bks08kAunOpNQC9faTNG87io?=
 =?us-ascii?Q?NcgDmJTeGoXBVFoiATKgL2eUYgOXD1EioqeLbdDUj5vYNogSCJkptO/tJZJl?=
 =?us-ascii?Q?zV68SkXgFRipySJJa3yqE7wOPmLweNCzhR5KE+8WhPAy+HfpBzKnB0VQptbA?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37093360-a9fe-4a87-ff4d-08dc31557ca1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:17:21.4777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k46Zj2o+VCgKclNvmh/xqs8s5df1oshsUbOgvVIOffVMqDtk64Va9fl8W0qhsGtULj27ih2EN+TyJViOLVVqYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5864

From: lipeifeng <lipeifeng@oppo.com>

'commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")'
The above patch would avoid reclaim path to stuck rmap lock.
But it would cause some folios in LRU not sorted by aging because
the contended-folios in rmap_walk would be putbacked to the head of LRU
during shrink_folio_list even if the folios are very cold.

The patchset setups new kthread:kshrinkd to reclaim the contended-folio
in rmap_walk when shrink_folio_list, to avoid to break the rules of LRU.

lipeifeng (2):
  mm/rmap: support folio_referenced to control if try_lock in rmap_walk
  mm: support kshrinkd

 include/linux/mmzone.h        |   6 ++
 include/linux/rmap.h          |   5 +-
 include/linux/swap.h          |   3 +
 include/linux/vm_event_item.h |   2 +
 mm/memory_hotplug.c           |   2 +
 mm/rmap.c                     |   5 +-
 mm/vmscan.c                   | 205 ++++++++++++++++++++++++++++++++++++++++--
 mm/vmstat.c                   |   2 +
 8 files changed, 221 insertions(+), 9 deletions(-)

-- 
2.7.4


