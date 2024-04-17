Return-Path: <linux-kernel+bounces-148969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A828A89D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F581C23A40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03270171646;
	Wed, 17 Apr 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cjLhU7tc"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055516FF52;
	Wed, 17 Apr 2024 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373512; cv=fail; b=jduI+UOyQVuRTjrr/oqOHrEBQ96zzxifeJ3UNV1cADBq9mggWdQAczGQ/FgCfuvcmofkqrEKfizaQWa77ImK3/2/8sOx5nB/+Tv+RvoK8t+icYwaFNbKnTSpFu7BWl2FoHtajMQ/ZkZHBV7eeyH+LZ/pIyJs6UWQaYVCup01d+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373512; c=relaxed/simple;
	bh=vfw50eBwPhAEiXkT8poLDj4RJZPos9fLTJn1CTeGns8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZEocpSpcsrD2f+3xG5OMmDmIhXqbgZzyjhKMZI1a68GJoziy96Jtzzmq5/jCjrSp2oKO0DbCq4TFJURa4JqrDkNC5qMHZ0nx+mtwsQ8se5kRDIeuQwso6cZew5kUjGCk3hoQTCYmyqVxoq9qX+LIuhkYZPEwFWt1Gjl4GnvEHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cjLhU7tc reason="signature verification failed"; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+B39hVuRSMi8zdpT2CqrlDoe/4bTGCSOJIPX/8O7pEXvKrlVqFn+TTygv/zy8YiqSDSJ00sTjndno8Ecf0/SdVDFfOFVPyYf0ryNYmaorXVvWKbSBAIqJEejMVm9m3fFJC/DrcOyZaqTXeNMA+irBBakFXxqLW3OdGWMDWRwOV6f2oj1Bytzo6HD5g9xYdbwcTQf+j3xhlk9i5LZoGg5UBUdlcc03LdoTz3LAUKjXPSJxalSxzCJ605/Hh+JqypuguiD29IU8lKqGcTt7IyGykrm100WMynCOvPajFou5k4WrU6gajO+eea0X7QhUuLaLO+mn+pbg5IkbJeGQ77Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouyjCA0kVZ04iCEEwdn1Y1QGlwZKCwsIZDD+bRKxwyw=;
 b=Np1sdeobxQz5LO27KP80uhvuqR4jui07aLuJ+OwY8KuHERcXW8DOHBPBiVTguc+UUEyMTd1KzEq8DTC/m8yZWpEavjdS5yBc1+Itpv5g3VrOCs29ah8cAH9mwWvWR6Amsmv6HuGX4ujoBLxM3CZ15PDYF4IWlRKw67u58kCqWybfM1gg7A+hzEhbRuheGzQz0JtLuSsPTgEfFkAkIpogxN6EMsQN+kfjeK2E7kHQySNC4EGSSw7o1stAic9+Htr107v4ILSKSSYjdwCX6F6lo+KdIaqcKklY5f2wJnVD7nuJypP1QYceWdgBPwqblLtgO3bJqjtDXdf8ZsRv2ZNlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouyjCA0kVZ04iCEEwdn1Y1QGlwZKCwsIZDD+bRKxwyw=;
 b=cjLhU7tcsoQx6EkKE2PZKs8n25uIlUu1OZ/1Od1t2rqZJABBemwgdGwJXY7qxChm7SvZuz5aeWU4syQhHRuIyjH+B6LbRR4JbDNA2CScruoFxRG2pokRaSaQJ6nmr3ehjdwV0s3Rgl3ZAHQ6LX5H+hX9O/VsVGAImkigCPTv6yShBCgvqa+wsPZeZmi7pNTS5pMlOsRpmGZFedNZjdUYgC3QyRc8ve2oaoWnJKubvM10dLxkO9bfKWTw7KLnXAtM1fd9T5AgkVUTGMYyojJy+nNXB0ZsWmmwBOeN9Di/wRsMgh8xdsEG/DbB1QOj+UsZzWTuO7wSqCxyLI0ZAd1acw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 17:05:06 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7452.046; Wed, 17 Apr 2024
 17:05:06 +0000
Date: Wed, 17 Apr 2024 20:05:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next] mlxsw: spectrum_flower: validate control flags
Message-ID: <ZiABPNMbOOYGiHCq@shredder>
References: <20240417135131.99921-1-ast@fiberby.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417135131.99921-1-ast@fiberby.net>
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH0PR12MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 6628a444-253e-4faa-96ed-08dc5f0087a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SgcLOdm+7+QGb68UiJ1C6K6WvHyNFg9yzcEz0mRtk6NL6tNWV2HUf84VGno9yWOdMp4bacHYyGUC3J0zll22a4vCwU95d+Dt53Volkx41cCzU4GSucdw6lX+UHfBzv61EmEa51BEJ9GPt6kJOHk9mqEKHPrbGONeUx5RTkbobcMr40Ptm7DIugCHHfV2RU4b9DhzHBf3+eMmL8ZF/0cbSIi+S/uayRS9jtVtE3llwFtHucreZOWbkHig3x98GC+Me4jJAzCV5Mog/OgIfweDOEVzECcVZ/Jmmg7dPsoBZkpsE+ZkpP1vMLdNCcjDMrFhw+D8Ya5145sr+PJ2VN6qw9cHkys/TNn+xmIN9fV8GkUB2oeO9uqAW43OM5H6XLgfFA4JO3klyMSFRv6/+EC3IHBPpXdZBeCaCmzbs/r4k6opM9j2ckrQbjndPrYi/oq+pfOzXoODvqz0+GY+6brXKtuNfAGA0oMGf75fsiU/ixKQXVNaY/qp5JlKmP+zhc+/0vLMmDUgnXnOWF1u4pcXs1WS+sah1K2o/x8W11dhc2H61MEF90PT1VLq+QVuytmOCCM0Nu6EFuvzp4krJlQ/TXJyvuuOlEZL8Ut+xge6ZiEyA3/NIHthQ++ZAwMX5QCRcEDrzIKF1Q5943DQI0w4l2uK5PQwd5OQ9ho7M/rNPTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?6ZDcvGibTmPJ02jTAdcHBipzPH5Q8FwllN0nqFAgUVciLZyK9S5fngnZtm?=
 =?iso-8859-1?Q?qxEan8BNuV8Fhv7aIrnqmW2gV0Z6JRdLwJoEcZ8E0JsEKshc1tMg38vjNC?=
 =?iso-8859-1?Q?iU+n011l1ozh1VMxeKwIYIXQL+1KgVkwwZKh8x+ePI0KykDxQxYs/88TLu?=
 =?iso-8859-1?Q?jLbxtgv1sK5kaaakd73Ygu+WRcJ2IETrxh0WKNn+MnnVeYiWrA29xhbZYh?=
 =?iso-8859-1?Q?duhoKjsOnzLF9ny93nhHD7ZljoJTgK1W2v40GJxU+ia6MsbvFMITY7iX1t?=
 =?iso-8859-1?Q?6jcA2DqTE3V7gBa/pOllXXZ4ZmLQXSOAawolG0izlZZRz2f10VgGIClzBD?=
 =?iso-8859-1?Q?0v9veXkyRkG/9CNGL0Y8srVzchrVPn5kf1TtYFfOiAW//2fu/g1QESFuET?=
 =?iso-8859-1?Q?i7Q4NiXHEyAvjhyJdugfsOqrRcEkR9F8cTkBILis8RcYPVAyZlqEeusK2m?=
 =?iso-8859-1?Q?jEWVeyn60EV0YRyho/IqU9amHECCdFhTmb+3b8XBoZDDI3f+YkDNGe1gtY?=
 =?iso-8859-1?Q?PF3xfnHtIzlvMhIq15SLTN2MuVPDNuxobWieaohQ893s2Lu5p1+znt1qIg?=
 =?iso-8859-1?Q?F2zQjjHKp1mWKPXogp8cumx+fPGlrHRAYB9wPR6jjuC5MYtZqDY6DA4LLV?=
 =?iso-8859-1?Q?VH5HOoDHOkFSFrXhFkBNU67p6PbNMDvVqtDM2PKcyA95ZHW9zoK6ft92XL?=
 =?iso-8859-1?Q?QXGKZJCXkcleFfa07bN3+xvPriE4Le+wBHbNKmvVeYmbYySOdepp3bbE/N?=
 =?iso-8859-1?Q?HzB+rqzU2bmLJyJuCwV4/Itv3ZR14L6TU2YCO7M+W63ACE9dd/cK7KHrK5?=
 =?iso-8859-1?Q?4IM3fVG76m3DhYIzDYU1TUbMVJZXQZL9GWBKLD9eCiYvGoIflKHJOwCuCp?=
 =?iso-8859-1?Q?olW+uvVWtk5hIM3ce0YXq9nIDlh9Y2NH8pm6eNt6uVRm3O4BUuA0VIlhv/?=
 =?iso-8859-1?Q?QbgJLtfBVkOKrjNviTtP5+uaWZD/l1Y0a0z878qEpTyWLTCZBt3R1FTIo4?=
 =?iso-8859-1?Q?zu2qSq7cg5qNqQ1XR04PLFOvY02LVi5VlMtNBggybrC56H5lGrJx0CKQbB?=
 =?iso-8859-1?Q?50X8MsF5hCVqbvF7plAwRDe/QCmkzpakr3VNHratuft23Nv1Mze6YFPGpT?=
 =?iso-8859-1?Q?1f1wbNunBg/LbIkfkqB3DqysBQEiir8TgnsD7bgZzjUV1ly3td0JRTmmbo?=
 =?iso-8859-1?Q?3zm8kQOkQ2H+RIxckFyMiUxoo/tacrDXZZU6almahZAlJVdlqE6vsbTVhb?=
 =?iso-8859-1?Q?dQc4yiAFQDKvEoUrGwZORrDkTe+0W2MB1d2pQiESspUUbsymlt6j1Id8jl?=
 =?iso-8859-1?Q?a4D81n3lD2H6oKVWW9/acVYyMB7xtiR7Crk1TVs3hQaiCtuPZijFIc+7Gw?=
 =?iso-8859-1?Q?O0Vk19ntCguTzpTgOwuB/M3GRmVakiiNcyTcnnCZlchTK5ZmJH70Sn6sZR?=
 =?iso-8859-1?Q?8Ocs0ArBXXcpCYq97/uRJGPOpjU71qrS2iH8+075HIGla0bkUMDh+18skP?=
 =?iso-8859-1?Q?VPHmW0q5qnTPhszMpU4k9pUSnHVikm0hJysUN6diJu2uiu/jiuQIccV74d?=
 =?iso-8859-1?Q?0mvHW4sFf4pj/RQKdHdqOgkwAxDE8Pwh+amFtNAISgWbDd1dFzogAO9sH4?=
 =?iso-8859-1?Q?jKt7VjXnySYobCaSRTImO7U0LLCxBXT+NF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6628a444-253e-4faa-96ed-08dc5f0087a3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:05:06.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9gXmp2+bRurQsAbnOg1hrKw3wmrEgQ9sUnIkdhlg0rZJD/Ho3eoq3Z4fdK9OZhPBLhE0fXp3FbpnSwcGr7oNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885

On Wed, Apr 17, 2024 at 01:51:20PM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Without patch:

+ tc qdisc add dev swp1 clsact
+ tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw ip_flags frag action drop
+ tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw ip_flags nofrag action drop
+ tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw ip_flags firstfrag action drop
+ tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw ip_flags nofirstfrag action drop

With patch:

+ tc qdisc add dev swp1 clsact
+ tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw ip_flags frag action drop
Error: mlxsw_spectrum: Unsupported match on control.flags 0x1.
We have an error talking to the kernel
+ tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw ip_flags nofrag action drop
Error: mlxsw_spectrum: Unsupported match on control.flags 0x1.
We have an error talking to the kernel
+ tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw ip_flags firstfrag action drop
Error: mlxsw_spectrum: Unsupported match on control.flags 0x2.
We have an error talking to the kernel
+ tc filter add dev swp1 ingress pref 1 proto ip flower skip_sw ip_flags nofirstfrag action drop
Error: mlxsw_spectrum: Unsupported match on control.flags 0x2.
We have an error talking to the kernel

Thanks!

