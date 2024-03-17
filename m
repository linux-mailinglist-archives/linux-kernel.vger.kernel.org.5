Return-Path: <linux-kernel+bounces-105353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071D587DC88
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1359281A98
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097F12B8B;
	Sun, 17 Mar 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cniOK1Do"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD1E574;
	Sun, 17 Mar 2024 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710662190; cv=fail; b=HNYYvJE3WY5zHqYDLPhcoXPzLhh27QFV8kS7PRMShl4fyifYgvjweKsuyBZ3nkvFTd/S1hKIO1wuO1ux/KTrBIem8NDoMJeElthY5CtMXoGVTIWGXnfjIU5hPUQCsbxvnNTGzY0tLyfTM1b01EpQH4fYvGTJqFxqd2uVLkABndU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710662190; c=relaxed/simple;
	bh=qwHdg0LVMpIM5riRQGsn3v7kBoYTxkt5Ed47X2R9Bb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EWcToPunyz1ufukfaCCBAqmbFr9WPEzSfUCqHRL+xeJiDYdUcbQLEXcd4te4EamBbt79N83sHx0xS8nBxtf17Azg62yFxaKbcVMsJ5fxYqDYRMdk2Gyx/bo5POK9J20XhyEikuVkqYBxakkA4rlE1P4mmFg6H/j+whevXbb80ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cniOK1Do; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoKDVBxsPhhzOcgVuWQ66yncJFUb7tDjL3+y8Kt35VYTLy5QbQu7jZ/86XlnO6akflN9ePig7+RFQ35ntM7iYWezXwyuYmiw0ySxCC3SIwbWftQb+qOCi9VdpJtcZOb2SNVhQRN6CWpS785aN+m42ryC0fIhcm80CJFcGZTlyvSsXYiHi/6vpg/SBCjxx4JnbsNYoBeuvF2Fz/0e94vAO8wBA29b6bq2io7oO+XiTI2mX5w0mrZirHOW9N9NGoP2MyQHtm5Drt9qi/CktZ01CLf/Vb9R30TmpMauSfM5gsAC4hdkOMOSXKKkQpJqIVavHQKhTKxNtiGsEBuXBWLYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAIuK0gTt8I+xBeZWc3Gpleq9uX2wPjIWRS8ccCMa6E=;
 b=XZ8zLl79P+t48CQyJklbul/2B+BrEhgB4ihdXzHn9Nrm6FiPgYlvOyztNp9AiVl54IEmI1yN3M6dVlZl0XA1cfDkVXeqwi1a4M41M0rrrNyp89mdvj4zHNZpfNoR0V0k0VJMR8KWeUfM7xTeDoIVFydUlQwTquTV/4rTgdunczPWD1EFjjv13rs95R/GdLsbvc3fxGGZ6bG/d1zOpxtjbUoL+00aUUo4KIXT7e7yTgx+fwT/fakBsUygK+wXLmUq4QF8b2twaWkSZIChOoRO5Ixcwv8KuYXEVyoizAsaVPuF0yT3MqFxHrQHVSTU/9opaO6IhR4jy+27F8ci9Ysx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAIuK0gTt8I+xBeZWc3Gpleq9uX2wPjIWRS8ccCMa6E=;
 b=cniOK1DoWB+wXS3cLybU4Pii2Lph+HZOfC8iQlHI1m+0j31ggUKgKXdqbNi1LdefY9fxYfPZm+4TWWpfWhecId2AJV/x2id/GfYnjUTGsYIGC1gdNdx50Q7mtiLwB+XKp+t9RfX0qFgieGmfm+gEyC6O7Q68cLb+bdte5e1f/2Qa+7lqoUp6p6U1/QmPXTtginQQw73XgpSZMJX238QmN1HPWENhXoQx5pgo4/+QDXs1LvANyg3xXTNIzxQj9BkjTQSTm7/MSJ+FLfcwHuKubvmTbdcIX7LWARWbhnZzQ5Vdq146zK3WxZAbm7VmaXmyq1WhAcTGqSIoT0a9vPx47A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Sun, 17 Mar
 2024 07:56:24 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7386.023; Sun, 17 Mar 2024
 07:56:24 +0000
Date: Sun, 17 Mar 2024 09:56:20 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
Message-ID: <ZfaiJC3ORw3xdNo9@shredder>
References: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>
X-ClientProxiedBy: LO4P123CA0281.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::16) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0cc3f2-1030-49ab-57a5-08dc4657bdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0i8vOQz8flcQ64bduvM8fjWsVFZMsRg3TX8hq6K6EvPEXX7sKbGIalQAifIArZSsury8OJ2vgV4XX+WlvbpBL9y/WTDvYe8bH5Km89gg57CjQ5KaaVZ1G2wvJO2BX754vbUTWiy9a6kxKk/gSOVTCediSkAhkNAxMcWFu1SmBT6AStRvTih/4JIBCYApLXT6Kwq6HOLSBrUHE8xoEkWFOO6qmYmAlUOwRBw2ypn0OYJJGF/u3LQUuD0AV1Kl0efLd71xwS7z26N82WLE8o9a6W1hbbmAyaHExlaXPVpuhm7FaQRWop0GJjZQYzUCXFRd3tzC3Ue0Owktw1eHbpgKAASvo6J4PdF1hBiF6b+rKcqguFcuOQJO+3LXAUrw30LuD+Oq8ZATHVEP8sjlCCVlrop24QdYXHg/qPeLMLWKnzbu3m/jWgiq5EwlCVDZUYKn15WbYmrPEn7kMsJeLzWENMnJJLF2q2wV7uTfcv7IqB1QnLBZc7PUo5RfxAQzcG6k6zMCENFUoxoMVOW5157S3Rhwb7+LRWccwNNsTz9JHqq49aztlEjJjAm+dbGJSnnHj79WTy/dOoMcWhf6WL93MweKDzS39cIk+dDc/X4ROdREvBnqY/Rmelh1XbYull+AkfrfDT8w7iMPtprpRtDSC9VFwnB/BFKRcD037RCd5wk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lIc6bWGVM+NI3DSNxjjqP1euWzP9J7ypF6Mssry79gbNoer26z+UKGVHD76v?=
 =?us-ascii?Q?2sJ4/QqH+GuXCpw5NPSp5ru1SIlBfyzIwDoYgtt5F6IOlioCCKxfkA3rAhb4?=
 =?us-ascii?Q?Ppfh38T+Q7tQf9uG1DA9xcQgVFUFdf7/T+Zln1oyvkS/awRM8FdiWV7B94E+?=
 =?us-ascii?Q?Fhe/Mpz8tkJZo3P4YezO28EAInQvCJhTliUm6+aOMQ8qaeSUztM/3ewJ2vPh?=
 =?us-ascii?Q?DcKcZkEpI2Pht48aTwsLTb+ynML6qfQnWT/tmkxesS00NoYKDWQ3jLQ/oxXK?=
 =?us-ascii?Q?TQMDBJsZk6a6O0u9aPtk74LMw7HwHEuC3+6XiE3Muwpk/vYrUZ6BL5GQIGzd?=
 =?us-ascii?Q?e+jaM/n04qpDvfWzVfQEzErbH+kIFt/Uq7oSOPF+2tMCsigU9tH8OIpfTXGX?=
 =?us-ascii?Q?45CnwR9Up0HXq2D7q2sFWBf2RDm0ca0Ziaua2ik7KkLkCITXFCA19qmeSRi6?=
 =?us-ascii?Q?WAfFU2x99NC8h1oGJfxPa6r/CVJP7PAfM3CWvOdL/ev3eiiVjP7yqAa4DzxS?=
 =?us-ascii?Q?+cp+2VMKltUROJhwyTjt18wl5Jn0jqkjiZPMDmTR7QYkH9hP8n3XxBI6czH0?=
 =?us-ascii?Q?eIYMqFsEidJ43Ln1DEx+0HYbTfjUqN/ycoeyh1VlspIg5qX5MD8iVe0p9F8O?=
 =?us-ascii?Q?QLNSB3YaSeLrWn3IIcPz0loK7f01wG90+oDkdG1BckDIc1+yZfFet6+DROJq?=
 =?us-ascii?Q?6MBvuo3ONlNAv7Jv0rJWvEoBB/GA1PRfU0TVowP9JL3yVDp1yPJCN8cUJItK?=
 =?us-ascii?Q?ItsFtxCTM+TmvM8qGTj+9qGKmGcf8B0O8k1lxrzYCDTO41K8iVwa7nFAOF1N?=
 =?us-ascii?Q?invamFEVtCM3/kBr8hotVQr8f+qiOnTbaWIl7XsQQ6JwwOrkslBjRNdvEeby?=
 =?us-ascii?Q?O3e3VN44OK8EveCbQ1lGtiK9p/yIJM2mTOFuuzAaVf/OIFpvR38g3PajkhkD?=
 =?us-ascii?Q?hwTXDKVgM18/sk7yV1ee0PsaAdzcaCDysK2pAH88+oTIXRkBX/ez5uFDevVI?=
 =?us-ascii?Q?4cuNTo+ZWd8GsPohzDpUDPZcFvWETIicALGAn/75oOmjiRTx7yECdLdRMJiO?=
 =?us-ascii?Q?SS9QlQj49K0Q6O9msamm9YTxLyrIReu9L8zxhuArAMCFO5ETvkZr2lmW+4fY?=
 =?us-ascii?Q?Gw3DkMlwEAzbDLWEpUv+/M6Wr62CTf7AnXsxVnmOOYxySRGQG1gCuI4xoHtG?=
 =?us-ascii?Q?xebk6B3x423OFEZEf0SI/BTJDu4gMsPxLgnFxNiM0jvRRqBHf7/DZhsyKX+j?=
 =?us-ascii?Q?QqEIqpPPE9CJcUoTrFecgovYZpR6zrhsFK2WtZo1gXlc04JLjfpyLNMUYptx?=
 =?us-ascii?Q?MGYcdVMBo/mE5O/CBRaZnjIWJgYRRLR/yeuKx2NG+kCPJ2H+7BYDjxPetJPd?=
 =?us-ascii?Q?9Q00F3R33qU4XX8Xb29xlI3CQ7pzfabPB/9kbm3KW4sSC3Wu58+eDbtzk7hx?=
 =?us-ascii?Q?wIwYtUXPYW0ZcwPsGCc4afiiX8l9Ua8MW0K9JcoqLNvZCqsaMU5RP3UzZUr/?=
 =?us-ascii?Q?NqysH9Zh8XkIulmAn5Too1QonWx4mSiGqMYN3PJBr5gslT6RdU11pX1OhVl4?=
 =?us-ascii?Q?Mkt/qY411K18oxe0U33dupUa3AAeqy6MC1y2PmE5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0cc3f2-1030-49ab-57a5-08dc4657bdb5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2024 07:56:23.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIBIiBCR5C2/7LYnB1TwIoT6HiPGMis+lJx0R8Yo3t+r9cyHX5omF2CRR07raoTjvui4nQz1KQbevZEELi+YPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

On Sat, Mar 16, 2024 at 12:46:03PM +0300, Dan Carpenter wrote:
> The nh_grp_hw_stats_update() function doesn't always set "hw_stats_used"
> so it could be used without being initialized.  Set it to false.
> 
> Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

