Return-Path: <linux-kernel+bounces-160166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A748B3A19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03842840BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7502E639;
	Fri, 26 Apr 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJt3iRaJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE661E501
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142022; cv=fail; b=qclikkAvVhNsETRgHX9ky34rf9HWZmRDq5H34VvW70n49EhaG2j+Qp21GHak1WPy3cCHnCPJQe2j8Ppx2WYTAwoTr2cjj61DpjLvLaWFK//jHXaiS1Q15hToS62Gy0OPb9LVstLdoT+OepaWSSnSjOSCt1iDvyqAlXDLGvSD4r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142022; c=relaxed/simple;
	bh=AhWeVCGw7RzOo9+/ByHHqP1Qb6L2YHoAA6fREWTMiFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+RRsWWATtZ5IeNb+gUU8SVIx9OCZwvSAwVbz6fBeu816LnrKHMn68oXzBU1Aj9teR8ylWNGfQdPi9CM64259n9xg8wxxdz4rW3c0EXkrCMgsrlZA97PmkG3CXYU+gMbvoRRUI33UtWic1SBbaoQjXjePfdAjRK6wKhOEJ11yc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJt3iRaJ; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHhK9gHcviuqIdJKvOMmc+diChkaG4izanrQt+w8VXVyBUJz0TJm0V0RkHWDeQlJatAmqZW5cf2qfIV5k7jNkjP+GmxRAmpo/z64gTBEAF70f7pE4ZqWGUtcTFmc+8xGEqsbq2MELjCzgKZWnCSuyl9zZr1xM0cTFAlNrmtiO3mDODlA817b5wy1rzRm4TBgn1a20dPS7KusDC4ZL5VdxVlsebYoTH4VjwDjESC2TySsQ2zf3//sejdkRjJZCeudcnpnSlPDoC1KnyhPXKYSX5DSNf2KPViRigtcwEUCPh1k9waN9iUjy08lD/W3+qsa6Ve/04M1AqjTm8ZJ20u3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc3vbTzxuQ9A803uM4obuJ93GZbOEzZ6wDvyt1iK0ak=;
 b=Kqarx+aled/7T61CK3dQQBwiO7fy1xMdZBpZmuAPB+ZGabM2rkk04oZ5yg9zuDgNzTnf82CqVDN6yF412CcWj64mq7DGuw5tsIeI80qadPv1wOAyqC09SWE17IZvt+yPjrCH+IOYbF3hXU3r/uM1tZCH+3zoedLteJ2GJLi0NLmND7PDaPiSuMr3svTqh7/whD0QF1m3RRpsRVLz4KbH1kzwDvRv71XAoOWDzodCIMFN5hOFpp/nxDm5OI6JYxVmdAzK9M+NudaDFLXiGvCUhy+DciF8ljfc6fIx89Kt5ug14q1sz7kzdxQE7asq3PdOG4Evc7FCIb8cjFFN9Nzj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yc3vbTzxuQ9A803uM4obuJ93GZbOEzZ6wDvyt1iK0ak=;
 b=bJt3iRaJlq5k8lnLigBbKnrJtMHF+uMlZeZ1B1860AF5cbDLPvdf6ItuVrOnFpcRZw5HA/zhDp0g/XgeXhFtIuus5pfywA9tJSDSysEh7JJX/Ecsm5CE0RfknbJfzvDf4LJOWxNY29/KTjfQEJbFWELR9nm4JuGVuYxex3A0Rosyf/PRcGONuNAe9DWv0zHfcaSD2JYanjfIKsMkGojxHgs0rF0qcXfl5H7ZEnF8dp1jHrwDZ3yXoyoW90qVxQlMoydP7NGv+BdPMYADUIRLiQTDHTqoOntgbSBPP8rf+/tDJNgPOdsEuEd9wa/fyhNn3Z37lWyilTeMNf/j385LCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 14:33:33 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 14:33:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Fri, 26 Apr 2024 10:33:30 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <683CC7EC-3FAB-4C63-92F2-636C4DBE7729@nvidia.com>
In-Reply-To: <af20fd17-1e31-4e28-8773-1298aa799aec@arm.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <922F6794-1C32-4862-8A67-90D4F7DBC474@nvidia.com>
 <af20fd17-1e31-4e28-8773-1298aa799aec@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_57B41F34-0D4D-4C94-84B6-3A8737B633F1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0429.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a64f87-1a28-45df-7fee-08dc65fdd96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rK88bjHLYJedbMdmRKv8qCU7axKUmlw2aN9DHiv/3Cb3IxB6CZlq6Yg6eoFx?=
 =?us-ascii?Q?czz5iBegy94YbQJaLIwemD83hCO996M/UZz7f8JzIpWqaThHBXVlGYklhtid?=
 =?us-ascii?Q?Nm/36XAHAfJvZ7QOm+ARfEiI+ZvU9jEFoWhtLGIlw+t9YQ34JFc4ACZhjwZY?=
 =?us-ascii?Q?3UEt+1EKJ4wNwW4xm4EW0OP3z6pMuydb00djrnn/rH3g/dRtKznIQfws36P+?=
 =?us-ascii?Q?quWquxZqELq4RBv13pYGCFpg//mSbq7VRbUv3wLwOIyyH3oXObLkaYdg/8rb?=
 =?us-ascii?Q?H9wtsuGC7F6n9FRGT9wbOzrX/cP7lKaYUnXf6sjj/UT2X8i39JbQ9st/F4x8?=
 =?us-ascii?Q?x+lD4Yqa7zjbVIJ1XceAAZgsNYur2JbfijDlvqpGgT/pnX0Ew8WcgCh+jnp0?=
 =?us-ascii?Q?ZdB3kVQSApP9HB6xDAdSmGPWFH/ndSCxT5l+K87MTZZFpfVT1Nuk06gBN96w?=
 =?us-ascii?Q?bg7lHVWkanyezdmf2KISyIGGKuW0qqczeYWnO58izEofgUiUN0W0PdeYHWHr?=
 =?us-ascii?Q?OLy2EcS0xQpcqS7+5Rio/17Bqm1OkFloCEDmdwAzyi7abvF4sa3p1sS4tYZH?=
 =?us-ascii?Q?HHCifungRuZnKgf6aHgB1MwVWvCY2k+Ssfym/YYVIC5vWxFKUTMpTm9HSyyE?=
 =?us-ascii?Q?3qBlgyDGa/M5wfc5x4yrVj9qfFozdckkbcTYMA9wjdNYXwDoOB0xNWr/P7gJ?=
 =?us-ascii?Q?4DN5a9+gVbE9ivGKmsF8qhhGjfUt60aOLHBpGFwUHbGEuOrC3lcVTym1dktI?=
 =?us-ascii?Q?l4kmT5mGLtKe7FREHI5+ozcFzxRY/Ykno0TfHZtS3FL9BQA5cU2ZBw/8zuZO?=
 =?us-ascii?Q?2VCXrizAOQqVCY7ldTUf2PFMI8K1VSnAROomzAYGynbVP3dKTKj8b3Bd5XmV?=
 =?us-ascii?Q?3oLHRTB3Nkxro0eXNib8KQFCXLuFl5UHfdv/WYaJ9irMwCvSa5wpuPoVwRTT?=
 =?us-ascii?Q?A0pqWk0YFwC7S+GPt98gFlArCFCMSfC5jzG3TO/InKXjiXD3rtuQCDHvrAB6?=
 =?us-ascii?Q?qtk8vAwwHX0SWFhcq4C1crvSOOo8JPWJV0XGKe/wOiYFHVvdCRVe7YG1nML0?=
 =?us-ascii?Q?8rkN/9sMPSVgIIAD10+3nUGCyrqSkiBlvhkzpDPUVze/BcDMhGX0BmS8iA9F?=
 =?us-ascii?Q?pPNgsWvzRUwJ5YsLl4sOmxCbojGnIWy/2JgeAjuvBlLBCmpDeVBrJ8T/404r?=
 =?us-ascii?Q?PJD2+ubmJ1OMTkFfG/ExXuL8BT/E+HLHX0s4Rdjc5cFQm7S1ye1e38N28uRN?=
 =?us-ascii?Q?zNFEE4mqUkPZqcETxz5llwsNUGxnxTyHM4FHvFCRVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KFtWhcGjOFz7oTh9utLHZK6iyndbqG4Yemm7HKTZI4cUOi6yu/m8pIfmkUqp?=
 =?us-ascii?Q?mZt2lnPvzWL0CzBvcmWrMTyTDSiaGXjqibLbtgrdQIAZCyvby41GEmCpTI/I?=
 =?us-ascii?Q?HUgJHpnU5GMirOQk64kRbBrkUuBwkrCmVuMRWaQP8ySGe+Fi0fLkszu+no/R?=
 =?us-ascii?Q?cR4h6PwkTSNeBwR2XW55gX0o3+LaUqux5jSbwfn//ApxjEmiuB0cviu02ssO?=
 =?us-ascii?Q?WoSMXmcTv8pSzoew6xiS02UhExGOABHI+Bu4D7DGtOAvxDzw0Hq5F//kkiZg?=
 =?us-ascii?Q?zzum46qRzUyRweT69zGi/7IBUzilZsJnMSF5bgk7lFSO8nLinu+W1Wi6Rrbr?=
 =?us-ascii?Q?fXCsLUYOnUxF6ft1LS3ewmhVhjGVhN7TcOphDKAPONM50UDhbVZQDtUMo+Z5?=
 =?us-ascii?Q?kEBSbpGU8A8M72/6FWtq8z73iMbmffXzPDUtDSP4Fa5H0DxWlc1fWUH5BFTZ?=
 =?us-ascii?Q?TqXpZJgOiW5wA9WAKad2ejlzTz8XXDwx78+Mgu8Xk+nEKLfTWBWIa6LxJb7R?=
 =?us-ascii?Q?hRs3rTmZfzXILs4/9NfQ6D4sFQSJ2x8/ZDh4p4/vvAhSuVw5DVzfZw9Cgwwb?=
 =?us-ascii?Q?ER5ARPXvNwZTCx4lTCm+xlCsHczj6298O/KlrZbe69WCvJooAsBH01/UOTE+?=
 =?us-ascii?Q?AmthsKX0n8g1DRPRhX0bYtAh8oNuF1/JKVE3CXNed81KgyNZfadnR51ACIUL?=
 =?us-ascii?Q?d0sNSoB3DYiAyUzNKWofVk5ELpeR2AWJrBL19RR4xR+fGAWAy6P5LdJB9WFS?=
 =?us-ascii?Q?x12852dAyFanARG1Pl91lKBw7Ayp5R9avKYY1B3ijN9YH1wb3L9RSZqndRDT?=
 =?us-ascii?Q?jOpZ4bQ9BT3nmqXLomLJPjdLuTt61hulGGTZj2/uJPmOOq1lWIDEz02WJPZ9?=
 =?us-ascii?Q?Kq4wx/gwrGm8W3HzqHlDD5PRZzcfTJyy2kQBkM+1z+UKTGWZGL6zgp3fdmIB?=
 =?us-ascii?Q?TUClxMdURaxKK7+L/vGrhONCgOqyXLnVDodtThSn9XvOSP3jkS9LZdRvhxi9?=
 =?us-ascii?Q?1LxJ+t/L3/rc/5o9kR7QYZwOxmyhAlcay9Uv/F3CQSGwfW1ev5msM70mrsp1?=
 =?us-ascii?Q?j9Q7PJfMgW2zBZYUy7Rhj9IUgB/nryFixmbivVQ6Tx7oUVn6C7GmpdE/HiW0?=
 =?us-ascii?Q?SogTZt25i7xnOk2WU+WmmcvbcPQdAW6JPb2DKq+QDfx927Zxq0wozRrzl6Z6?=
 =?us-ascii?Q?CRA1VP7fbew7YZOC5OLrtRCOlbtcGRUxevYF2hRc1PJAFhKa8Qiphwzenp6V?=
 =?us-ascii?Q?oUvFC21puWm0irj91orjK0iWW4K+9o8nbiuJzQ2VAin4/4dRYnAz9/3Ka0TR?=
 =?us-ascii?Q?Zx/eBAI0X7c75lAJGyxvvqxZvAKXF40LYPJ0yIc+SRxUxGkQ/4DnT3uOEwt+?=
 =?us-ascii?Q?7lyHC3LZ/VjDtiQrVMIuOuX/hSsuOX5v95lRnZLCUe8uJX0rOKhdJ7NQT+CL?=
 =?us-ascii?Q?plmqAPyFzWrwxMpIRQhYVVuafTsfQUzLed2ho9w51GnTJ4WPmvHv6QZ08Wdj?=
 =?us-ascii?Q?/l7tOTyAzsRre46vR6FNb70/hedF3CmEtTl6m3QKuD6r8U2e7FduVYTs0kHS?=
 =?us-ascii?Q?SVneSRAAcg6ASG+w+xI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a64f87-1a28-45df-7fee-08dc65fdd96b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:33:32.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0zJKG9p47B8MQIaWi7SKnSZY/e7mUCG7KOwZzF1cuQZTn/laY5ePFzKDIF6X4kh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622

--=_MailMate_57B41F34-0D4D-4C94-84B6-3A8737B633F1_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



--
Best Regards,
Yan, Zi

On 26 Apr 2024, at 0:50, Anshuman Khandual wrote:

> On 4/26/24 00:28, Zi Yan wrote:
>> +Anshuman, who changed pmd_present() semantics. See:
>> https://lore.kernel.org/all/1599627183-14453-2-git-send-email-anshuman=
=2Ekhandual@arm.com/ and commit b65399f6111b ("arm64/mm: Change
>> THP helpers to comply with generic MM semantics")
>>
>> On 25 Apr 2024, at 13:07, Ryan Roberts wrote:
>>
>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>> (non-present) migration entry. It calls pmdp_invalidate()
>>> unconditionally on the pmdp and only determines if it is present or n=
ot
>>> based on the returned old pmd. This is a problem for the migration en=
try
>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only b=
e
>>> called for a present pmd.
>>>
>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>> future call to pmd_present() will return true. And therefore any
>>
>> But pmd_mkinvalid() on x86 does not behave so. Maybe we should fix
>> pmd_mkinvalid() on arm64 by not setting PMD_PRESENT_INVALID when the
>> entry is invalid already. And add a test in mm/debug_vm_pgtable.c.
>>
>> I notice that x86, risc-v, mips behave the same. loongarch also
>> has _PAGE_PRESENT_INVALID bit set during pmd_mkinvalid(), but its
>> pmd_present() makes sure _PAGE_HUEG is set before checks _PAGE_PRESENT=
_INVALID.
>> So it is not a problem for loongarch. Add Huacai to confirm this.
>>
>> Maybe pmd_present() on arm64 can do that too?
>
> pmd_present() should return true even for a splitting PMD which is not
> currently mapped. IIRC in all other architectures, there is a distinct
> identification bit for huge page which stays back, even when the entry
> becomes unmapped. That bit helps pmd_present() return true, during PMD
> splitting process.
>
> But on arm64 platform
>
> #define PTE_VALID                (_AT(pteval_t, 1) << 0)
> #define PMD_SECT_VALID           (_AT(pmdval_t, 1) << 0)
> #define PMD_TABLE_BIT            (_AT(pmdval_t, 1) << 1)
>
> When the PMD entry becomes unmapped, PTE_VALID gets cleared, so does th=
e
> PMD_SECT_VALID, thus erasing its identity as a huge mapping. A software=

> bit PMD_PRESENT_INVALID was added which helps in preserving that cleare=
d
> huge page mapping identity once it becomes unmapped.

OK. PMD_SECT_VALID is just a different name of PTE_VALID. I wonder
if ~PMD_TABLE_BIT can be used as _PAGE_HUGE to indicate it is a huge page=

PMD, since PMD_TABLE_BIT is unset for PMD huge page already, for swap
entry, since PMD_SECT_VALID is unset, PMD_TABLE_BIT is ignored. But it
will require PTE and PMD have different swap entry encoding on arm64.
It might not be worth the effort.

>>
>>> lockless pgtable walker could see the migration entry pmd in this sta=
te
>>> and start interpretting the fields as if it were present, leading to
>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walk=
er.
>>> I suspect the same is possible on other architectures.
>>>
>>> Fix this by only calling pmdp_invalidate() for a present pmd. And for=

>>> good measure let's add a warning to the generic implementation of
>>> pmdp_invalidate(). I've manually reviewed all other
>>> pmdp_invalidate[_ad]() call sites and believe all others to be
>>> conformant.
>>>
>>> This is a theoretical bug found during code review. I don't have any
>>> test case to trigger it in practice.
>>>
>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common pa=
th")
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>
>>> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>  mm/huge_memory.c     | 5 +++--
>>>  mm/pgtable-generic.c | 2 ++
>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 89f58c7603b2..80939ad00718 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm=
_area_struct *vma, pmd_t *pmd,
>>>  	 * for this pmd), then we flush the SMP TLB and finally we write th=
e
>>>  	 * non-huge version of the pmd entry with pmd_populate.
>>>  	 */
>>> -	old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>
>>> -	pmd_migration =3D is_pmd_migration_entry(old_pmd);
>>> +	pmd_migration =3D is_pmd_migration_entry(*pmd);
>>>  	if (unlikely(pmd_migration)) {
>>>  		swp_entry_t entry;
>>>
>>> +		old_pmd =3D *pmd;
>>>  		entry =3D pmd_to_swp_entry(old_pmd);
>>>  		page =3D pfn_swap_entry_to_page(entry);
>>>  		write =3D is_writable_migration_entry(entry);
>>> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_a=
rea_struct *vma, pmd_t *pmd,
>>>  		soft_dirty =3D pmd_swp_soft_dirty(old_pmd);
>>>  		uffd_wp =3D pmd_swp_uffd_wp(old_pmd);
>>>  	} else {
>>> +		old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>  		page =3D pmd_page(old_pmd);
>>>  		folio =3D page_folio(page);
>>>  		if (pmd_dirty(old_pmd)) {
>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>> index 4fcd959dcc4d..74e34ea90656 100644
>>> --- a/mm/pgtable-generic.c
>>> +++ b/mm/pgtable-generic.c
>>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_s=
truct *mm, pmd_t *pmdp)
>>>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long addr=
ess,
>>>  		     pmd_t *pmdp)
>>>  {
>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>  	pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmd=
p));
>>>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>>  	return old;
>>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma,=
 unsigned long address,
>>>  pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long a=
ddress,
>>>  			 pmd_t *pmdp)
>>>  {
>>> +	VM_WARN_ON(!pmd_present(*pmdp));  	return pmdp_invalidate(vma, addr=
ess, pmdp);
>>>  }
>>>  #endif
>>> --
>>> 2.25.1
>>
>>
>> --
>> Best Regards,
>> Yan, Zi
--=_MailMate_57B41F34-0D4D-4C94-84B6-3A8737B633F1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYruzoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU7PoP/jfs5YKnXYr2r55OVOhV+J1mfXbHWK2S+tUn
Q9gWwOmCQhXX4QJQ2rD/Nc/48ypGhhMQO296X36sz8vufT50AWowWQ2s88f7iQ+m
GjmAHr025m0yqR8c/hDFxrGz1AFBV2yz6AEzsQRJSdisJKnehu0zCHIy+BLZ9cxE
B7pl91hsgQlUgc218/nVqLZv3uxakwEcSNCpW5p8+agok6IF8GyzXAMZxYhcAwgq
RXVH9TEAixWO4QFtxigNfNCppubVI/BEs8R+i/ksfMWjCXf2kXWDEGajsZt7CNlz
fxV4QZJZ6RvbrXuNzNt2HcfYG6boU8Jx/Y5pT7s8joTedyc0tf5w1qCRhN9aEuil
Y08MMh5YFGBG8cGF1sEvGn1K+un2YMsaHdXpMxJvVPCz3XBeCWbcP3hei6OVVVER
p6KIKTFi7CtOGrItrtw7vpiFSmKo/1hiV+lAKQb6F/sHceuEEL0e7iRS7Bq81zng
mbPzlf/0bXSsKnZCr1QYYXPXN59kfRJkramIdtFLoWQKLU797J0nqRMcYAld5Sf1
fzGSGoAq9o+0j/Xclrvjd1+edZZoP3NqjlMk1846d7fQNnRulW93NzzgkHFKpwJg
s548SR8OXzOhhYbn+eHjUlNwwWceuUcdPjM/cB8AypvPhw7hslAEy1YR2cGFYSoa
72q9Dd94
=oulT
-----END PGP SIGNATURE-----

--=_MailMate_57B41F34-0D4D-4C94-84B6-3A8737B633F1_=--

