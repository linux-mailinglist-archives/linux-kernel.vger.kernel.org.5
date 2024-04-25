Return-Path: <linux-kernel+bounces-157895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC68B1844
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3ABA1C21457
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201D6AC0;
	Thu, 25 Apr 2024 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qst3plvI"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C84C62;
	Thu, 25 Apr 2024 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007038; cv=fail; b=fvAFNXCdc+6N3BxtX0UuEkamr6dZJDIFxiDj1oY3+1aa1kH/ZZk3QDxdQDD5OzazZWfqHA35IUFW0B30OiMZzxNRZVERWoNYMwmOmOXXaSbxFJfXTPEc1eBvKsTr3DNjgsuFXuOkT7wo2LZgRs3CSHz8Y4Y3vOqouKCA7+HyZTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007038; c=relaxed/simple;
	bh=tGugT/kUwdkvouSlIZKFI50NLYR3rM4zw7Ph/3/Z7yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kR0W+jyEYkkfKKyWko/TERDuFAcTO/kZretvHg0F8HgsdfxJy6M7ftOPlwJDdy2/0mJVprXJ8MiRzw5ceyasTv6R9Up9zrS6Vvl8fKcP8/kZxfstWkdHvFSYRKH6j27Ln6nLdI1T8Riibiab8vlmljCpYwsMZpoH0dmOJtrbDCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qst3plvI; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYOufW1VEUg2+CXRBJ9UlP15etilhLjA2YbIjIHO8h10dfx3tP2SbC2oW3HnDZJ91A5ZvuAdCghapLx2j043iSdAaK+PesYnRKEbS06eB/e2C1LPXoHJTWf2k3jYHeqUSbibovzqGtCRf9uCOD1/U4Fo5l2vqaxmNR1ABmn6QnI/zw+FyANnfvel9kQ0W13GFV35hl+PIWbFnTUOSV1bIKiiMpoWyJxqgWg7pwFTTP/mqdTlOeq7HOAvp8giN1ba9/lNs5K6FusZnTbETbtyEkgKHl4O875Jv2HykQzdYGy+i5pLU566YdxAiHwW4hQPHJtJzTkhmQoJSnTFBK530A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDwgJDGcTdCSKo0Z/vT6rCkS6WS0Br40H3XwlBz4XAY=;
 b=KWU8cD3PIHpMNbBge2UjOlzR6dzVHKDWDUGudTzoZp3ioGSm4jBCRvg2UZw+/oOeZY5mEpPER+/E2fsLFcAzOPpdEmsdcXvf0+AD5k/KXt+p+u31xRQ9Ylw8qznY9kjPEsgk/wM4jC9YuhCOaNNnUW1Qr5f05eNu/R9z9qNWYhYMi4/tXa9DOPky5CmUXBOYKvL5PK4iSH/hipnw/jg5ff7vKel5hbB6mKwoRLO9Zufg4W4J82fhoGvWmevOBr7CBOjLWs4ntOk5eyJimpOjLJGH3TKdvidqxO3jcPresvazd0ITQ7N2PvL6mgHSWdt/BcgcYS9/iO4F3/vV/XAI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDwgJDGcTdCSKo0Z/vT6rCkS6WS0Br40H3XwlBz4XAY=;
 b=Qst3plvIDs4wDorVaAI9yai0Yb0hVEUdKGG8ShiWLR9mAwHSaiKzcq80keMPzgkPuOH5POmNXGcRfqubk/g21ho0n3lZzwu07pM77CR6mM6ajAxGLeBcm2Apa2o1Q6z7xjqC5Y1RYfkw94vc55vRCPbjw4Kfdj4gWkpebHazcKM0ZodYU9pBuT0H3cXR9BkPVlYTwDk3BdrdU88nqEDpsoLV8DCszdWQT//NGjNiD5AI4KKWc5LVJ/VSxwqtmVC5qULw1dusHrkWTCB0IP9fJ/Ifys8X/d4dyn+2dSfATxk0BpExuIAKsI06nxVNldkLyaJLVTvN6QESlMpapdAmaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 01:03:54 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 01:03:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, fstests@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 hare@suse.de, john.g.garry@oracle.com, p.raghav@samsung.com,
 da.gomez@samsung.com
Subject: Re: [PATCH 1/2] mm/huge_memory: skip invalid debugfs file entry for
 folio split
Date: Wed, 24 Apr 2024 21:03:51 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <17447911-9578-45B2-A601-28CD0C5036D4@nvidia.com>
In-Reply-To: <20240424225449.1498244-2-mcgrof@kernel.org>
References: <20240424225449.1498244-1-mcgrof@kernel.org>
 <20240424225449.1498244-2-mcgrof@kernel.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_9740574E-5EFF-4817-ABFC-FF68F0E0C5B8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:208:32d::26) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: c476c72f-deaf-4ef2-1e8e-08dc64c39382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3z63hxFIo7YMNSIPxbdqNfL6ugFJ+SZUrZRG5aFIyAE1bxZA7wBJFzUFEINn?=
 =?us-ascii?Q?ebKld8ZFO/YAkLZc7N8ZhRq38Aj/Bl/ZD34h2rrIN1TZUWS837AGahZs4Ihq?=
 =?us-ascii?Q?KcLUrE13fyXMUB/DbgNYilKOLY1gGatte23PNft0PjcqPl3qTdUZJHyIE33O?=
 =?us-ascii?Q?ph2s8670q6zZY/Kyllxrxk4hkmpV6AIF3D0SDHWsfOSqyCxIp3U35of2ajfx?=
 =?us-ascii?Q?s+Bqqc+Twj+92R42fO2waTPpP8sATVaFA5m1tGflGThWS7MKfdm/ldOicDuF?=
 =?us-ascii?Q?AjJ4Y7zRCQhNUpeROaaTjuiqgv3RNwUr2C1aKMVghFo3kKii14kdHi57MIsv?=
 =?us-ascii?Q?uG72BK04xNToVHCY9xj+R2D5M8KQRHDy5spdrx1lXLUjbJR/peOrFRfdDuIr?=
 =?us-ascii?Q?Pd/M/JQqdeZQtvfMt0JNTLp2ZyQrJ06rA+0Skbd61RzFF+5Uy0z9tIGYzdZk?=
 =?us-ascii?Q?5+Z76L+dM+OSzD0NJMYCg2KWpvcPNwEkpc0ebdvq2L1EHAYisrmSvDbv1OD4?=
 =?us-ascii?Q?ux6kvNsbMMqktaRq0EpOM9KWt1t+YzsFVNBIsDsKUyCJDHuhU/IPxdGnu46E?=
 =?us-ascii?Q?TUG0VIg9gazUEstaC3kK2mDS9UyrBxEFTt7qDtyD0fT7XkdUSVyrISDVpArc?=
 =?us-ascii?Q?fB1tgmKe8NW4tuC8e3ShQ4F2WslU1qKq3DI4+n27myzXKbbQmm6bywAzyZ4P?=
 =?us-ascii?Q?/LVrycGBtu9EP1hKhaykP4KfSmWJvAjtmAiltyL28jV1jSnUPOR1+X9X7Ni/?=
 =?us-ascii?Q?uBTZg9PZX7uMqMAcsq7tqEAZpUQ4fHbhqdrmAjRqnO7pKFKVSpiTwVQZzdU+?=
 =?us-ascii?Q?DpLjtasOZts1j1VBtR4almFCriyf5RyWr5QNJhJo/I3fRVmOpJVpnO7sNXXE?=
 =?us-ascii?Q?Y+EkUw56mNE0cwHVcAuMJHOjP1GpAjPBhxl2KTlJhpwJfzu2pM+DT/nUjQEn?=
 =?us-ascii?Q?cOsbpGKYUnZjkRrtUT5u4HjY0WiGwnW7qX+KyeZH3QSvIuAjeX5WGm2xezP/?=
 =?us-ascii?Q?2VCpyFh3mogSOWTkkNOpVbu9KJWLgN34PeTdE18EvQm0oanlUmc6LzCn7MaK?=
 =?us-ascii?Q?wVIbqRdKxER+8sfzEEvU8jG+L4v+1RxRsWJWo9el05EP1Plx+P0nIl5Pv1vG?=
 =?us-ascii?Q?326vJBXtXfKS1YUKDsYPNBMISPXYcfLDiFnWQBbMQiBmMb2UZKD+jVLNbSXU?=
 =?us-ascii?Q?ldhgmHzQ2zdyvguweHERAouwg7bGlN9htGefoDev0o0nqLKcyma6O9SJLWeK?=
 =?us-ascii?Q?d9gX0R1AhkRXv1TZu+MQtSZ2Qdg8TRgpgptc/pOY2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ggsiJWk7Y46QeoOHkRIaJFlz5qoCP+le3NQ9/93aZ1P2yJs5emGr5JLqOsE?=
 =?us-ascii?Q?2jQ1F4hykO+j1o3Bi9DO6ZyUJdN25OvdMk9Q8ycb4Owmx2cn6ENwfIURgOPX?=
 =?us-ascii?Q?aqYEJCMmGV2NDVmLN8UJge+sKCe2g/joSAQly5NxmhxZLmyKHptWIOMKDzfj?=
 =?us-ascii?Q?A8AAqzvsMlipUJ5giU5GycwwvMitQD3sDN5Wbf/fuhfanQPMsER1X/48d+Vh?=
 =?us-ascii?Q?H2I2AWFWRoKjDCrbi4dVZc89+MA1VUw6JPx6KDB/fEK1BMtmCJdidNbFC6pf?=
 =?us-ascii?Q?R5e/Ji1rXFQyCtrJN48959W27x1sIllYZzJPxv25y+ojO7bFu/K9NJw9sJJ4?=
 =?us-ascii?Q?H/dUps7h7arqDzAq5XdajoL87hMnfl6U36JmTab6SwQk5xb+WPVi+neekeTq?=
 =?us-ascii?Q?SxPXD0IGK/SMeLQfRTzAyNo6EoU59esw2xH6sVBMUsm/Qr9leV+FyZ/NJz2/?=
 =?us-ascii?Q?g+6Ur+b6ZQkU0bI0bs+pT0i5dAKJe6+3Xzv/w/qv+05dEyV8Vuy1IQaNV2Jh?=
 =?us-ascii?Q?cqwFj5xOazYPl1qc1IaRxlRyk9N5xBfqiKhVdnw62t+yuDJ8ZvUY4KGEtnFF?=
 =?us-ascii?Q?y2aUxhUqDETSOMLr8kFZTKsKKDprEBm6o+S+6wlDusL2Vot6qahN2JnkxXGO?=
 =?us-ascii?Q?cUdf7DQato1PNTe7l27kL+idKstnTCNBUpdeaDHTHMBR6nPQzGoP4ViFywGN?=
 =?us-ascii?Q?sDpOd6W1RjksqaTfi1rncXuB+GvislVtaGxzHgUSdz74w3YD6lwxQaWLCYQh?=
 =?us-ascii?Q?Yjv7a8ZRGXNU+PVhX8VTVblU6QM0WUBtgJiVUxdebkFHK/Vg6KIlTqDQlgNN?=
 =?us-ascii?Q?PTifNJvBRnUM1SYPglyuO1POXEHc3CgfdU5sk1z1s7n4+I5plr0wAIcfSBup?=
 =?us-ascii?Q?hBa9N5vomt4qU85l5Pdwfhrwy9EA43BFrTRZ7U9Me0tL8DnB5kMItbDp5fFB?=
 =?us-ascii?Q?SGyE0Q486nE9ZOFdQrGa0n63yAjCyYlqRffUIfAQupdyp6sVJS/p/dalEHyc?=
 =?us-ascii?Q?PS06M+KNoki6X1BiKbm0EJVNVskL1R8RGgX+tCkKpbXm1a1qP2lG9uVJ52vk?=
 =?us-ascii?Q?in3NQmPYZFftn9/Y5nQ7YT8lhVC1VcuEXZLA30D5+SA1Lx8vGUtl4VJHOIQ4?=
 =?us-ascii?Q?OhW7SSLtAg0jgVi0+SGxZFMAaQaU84QQldSqEdobzLnQDyUtyPrGAnu7dHdQ?=
 =?us-ascii?Q?gyK8syzjoSNz6Ow5lxd0kv5zdF3nMHZCHMUd+RNhOLOgq8esXRqxiHBkZ56G?=
 =?us-ascii?Q?yECQzjdkkzrDTpU4qkpSPauVZntnKYslfSr8ofdSvMpJ1+ddu2Yw6Wlo5uZ3?=
 =?us-ascii?Q?FIorDyuFF/1Kv2/fkMkHKO74khqQJ8xB4PSlHRqivRHgb0UsHlSHH/6/AmAv?=
 =?us-ascii?Q?oLSo9Qd2pct6XvdEzuB318zaoOdej8uHYjIskiUAAPNteIBuOo3cXPmbYU5k?=
 =?us-ascii?Q?IPtgbH4etivzh7EKMfrXtUYmS6rYE78TR3xcM9BOTbJCYsH3ndipNNXlgfiD?=
 =?us-ascii?Q?JI2xRssACBsGS5J/DPDVqAgxqL2oSOWSxjJPnnFchGa9xvsLHK1isfvOzhx/?=
 =?us-ascii?Q?9Gfdks4sFTV2XWmgjZ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c476c72f-deaf-4ef2-1e8e-08dc64c39382
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 01:03:53.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anzrd1B7CZXOxAdPkwvAXUk4Xj5iUp+2utZ8gYviFdZwJIRIiuEe3dFX0iiOLF7h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

--=_MailMate_9740574E-5EFF-4817-ABFC-FF68F0E0C5B8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 24 Apr 2024, at 18:54, Luis Chamberlain wrote:

> If the file entry is too long we may easily end up going out of bounds
> and crash after strsep() on sscanf(). To avoid this ensure we bound the=

> string to an expected length before we use sscanf() on it.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/huge_memory.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9e9879d2f501..8386d24a163e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3623,6 +3623,7 @@ static ssize_t split_huge_pages_write(struct file=
 *file, const char __user *buf,
>  		char file_path[MAX_INPUT_BUF_SZ];
>  		pgoff_t off_start =3D 0, off_end =3D 0;
>  		size_t input_len =3D strlen(input_buf);
> +		size_t max_left_over;
>
>  		tok =3D strsep(&buf, ",");
>  		if (tok) {
> @@ -3632,6 +3633,14 @@ static ssize_t split_huge_pages_write(struct fil=
e *file, const char __user *buf,
>  			goto out;
>  		}
>
> +		max_left_over =3D MAX_INPUT_BUF_SZ - strlen(file_path);
> +		if (!buf ||
> +		    strnlen(buf, max_left_over) < 7 ||

What is this magic number 7? strlen("0xN,0xN") as the minimal input strin=
g size?
Maybe use sizeof("0xN,0xN") - 1 instead?

> +		    strnlen(buf, max_left_over) > max_left_over) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +
>  		ret =3D sscanf(buf, "0x%lx,0x%lx,%d", &off_start, &off_end, &new_ord=
er);
>  		if (ret !=3D 2 && ret !=3D 3) {
>  			ret =3D -EINVAL;
> -- =

> 2.43.0

Everything else looks good to me. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_9740574E-5EFF-4817-ABFC-FF68F0E0C5B8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYpq/cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUmT4P/R+oohmGw1KcWzYc7dC6XEMLGaCGSBSbR4J5
BiX5+tfz/Lx6bHUShfd2YTFY0iLONnpWcGWwX1jN8WOxSk39Y+KolgJNgfFGrkJe
Gqqnt6xVHfNFYHIjcdPvxNLmkC2m2FzZAeAC7MYa4rdSahNfHWTAf4xahS4RcO9n
znct+lfBhLm+96PG5Nyi0AENc5Bhdx+ZBne4TaloVjfhmfC7YBa+eN796thmEBOz
2V0uHx/CPUGSGPPoAnb5ChYKrTcy83IvZCYMLcLzotKGF2bQLKi438bzqCXLDVby
3QuDh1ZrVia6kwqeBZZJ6UNBx+b1mkRruLnAcpNXpxVypZKqZ3nhPrDwvrbZLeTd
BR1Xa/zKb04qqCx39yEdDXVSOp+btJWtsPqJu8uMR7N7FELKmnehKZ4/guRGa0iS
F+DXMJ0Q72BdsnMxPMzryS6cnMfvXz3G4kO5mfxz80lcodAaunI7zx+9T+Gl+kdE
s03iD5iLUihQTH5w5Unn+Tf/2MYZQpObhOKRe67G7PckPPeANhe4JQqDxJ+0tALZ
hrSu4D99FCwAyZDpQl2gnSYmkU6YUiS5jnld7Wl3rnFIxHYiwja9niB0WP17YcC5
3SVwG03AWAJRWo7+mmVCQYZUrBL9xdpMH0UM3UW17TutEl3ldwc58MGhFzuse/Xg
0xOLitQ0
=gZPz
-----END PGP SIGNATURE-----

--=_MailMate_9740574E-5EFF-4817-ABFC-FF68F0E0C5B8_=--

