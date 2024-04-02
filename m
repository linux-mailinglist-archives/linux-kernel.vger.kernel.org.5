Return-Path: <linux-kernel+bounces-128806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82E895FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95081F24CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDA22E3FD;
	Tue,  2 Apr 2024 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="myO5Dx2G"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3064A1E531;
	Tue,  2 Apr 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097999; cv=fail; b=eKMkKrY1NtiV/onLEyR5PYDOuieam95LgNDf8x5ZaC4qlc2pCekIjHl5VAvwUOI4TIQHkRvRUdTIArM3Zoy3oXZNNv3v387Z/b8tHRACh7c3M8k6XRrAnVrTH0ihxdsJW70vv0pyy5cJ+Xlu/4H1lvTDAYfcLTwaYBtEOAi388c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097999; c=relaxed/simple;
	bh=k+nWOgMc+AVH9NBJykPI+Tw2+BqOJTcHABNFcCwqUrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XeqPU8rwYAc/t7tpGpnbhOiXShxo9xW9xFtcmqEU2imzPedK/D7bVr/d9A3qeCNNWH81UQ9qvO4vNzhYLlhhW7asziUMaqmHSMaKjNWP2LnmpJhwYa0Firl0lgpynVBQ9zNLlQ3Utkk1EqxtGjZnVsC+T6acmV7rJbFFtIRvMsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=myO5Dx2G; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjwG5U8VslcnJHKo76/DH1iBmkE+IY7Zff2nRiggkkIV4G8iOayhDV9Se3pA8dfZbrH/qq2QoSTSUGJvuKzEcPJw13+mThNXOO6w4qVYnRKFFk/0wRFFEqiinqUTb+4sgwciOJbvxJLdkHhwolh3sZ9/q0rPBA4tWiljaSXv8pd0KJf0FUDzSBaxV+OD9G3FamgIqhxchwsevGy+VBEUtYWeUjvIvfOtBTjlqFOzFvTbS1xK92aTz5c3iEcZ0Xm1FRYJ+boJ+f/8lavv+6cvbB5roapxrzSVcIhGQd5iHxa/LeiM49oWtXTQUykPf3dNyQnIJidfv2Vai/XKEhzLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+nWOgMc+AVH9NBJykPI+Tw2+BqOJTcHABNFcCwqUrI=;
 b=iFDR1BRnXMQm//RRXxmruG4u2O3ehtg7HcIcH9BbLUXQUaTxBWVFsUhc0LcYLNo2c2uxD3vkG7f+BHDrhaVnTQVp2T4Yc3QANuCtxII19GmHQoGGM7p11am6jyL+s8tGZv711g8lbBJxYjndGdOawsOErAVVr/AdHc1naiL8TJThJmsHN1saMtLArL4gp7N/DV43TnOSsu0pF5iWAz4MMG4K7Ckt/+dSrFiY0U426575kKf/3tjDN51mcRnLN6SYfIThOKd5LJSlq8yfGFGLxNzxIdGjwsit8Kw0icbVwzUe9HbV/xhiz4CeeXN14LxcOveiHwiv6Sw8o6FHS3breg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+nWOgMc+AVH9NBJykPI+Tw2+BqOJTcHABNFcCwqUrI=;
 b=myO5Dx2GbsKyWdniTx1PKy4/Hq9W723fmokA5KuGT2PellGYV6w09d4GnepcWLrMtKmCvHfkKEWn+8z7EwmYrKz4DqyjC8jHPUmyOqjTthS9NC0eUTPloduJN3/rMbpskYZAfSpOVPFkh3URL5uSA5NZ9Su/eFVs7GwSEEh4R6J0Dw6/LD8ZnIyeyK9+eZN0VdBp/Ks8GmyvqzBl9nwJTQ3ZahqNjwoh0A6uuexi24Vp4E481Phh4Fayh6RSAmarQVQIbWWOjjZW9nUTY9XMswduHmZ/Va0qy15VRNlJ/qtNpdb4LdMGpMob3lyMzFzFaQpiQIiYInSHJ67b1JV7NQ==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:46:34 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 22:46:34 +0000
Date: Tue, 2 Apr 2024 19:46:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240402224632.GT946323@nvidia.com>
References: <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <20240401123003.GC73174@unreal>
 <20240401075003.70f5cb4b@kernel.org>
 <20240402184554.GQ946323@nvidia.com>
 <20240402143607.0357d71a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402143607.0357d71a@kernel.org>
X-ClientProxiedBy: SA1PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::10) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS7PR12MB5982:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZqWftw9d/T6wvcJ8buhGIzTrLa4zy/3tVYNE5k7Xj05y0KkzvO0ttcQ4oY9/V9vDnEmyDkAxX+dSE8B/mFyVSqDL8ypo125A2bXjFZCmE96vQm69gQ5LBpdfAmSfth7XrjnnmISVSnwVmhEW0ujd16f0aw1/X06jKJoaogLCcPJcB96uUNeTcOi25DtZtajZFSCv005m5SInisQtYkO4WhG62/4svlGvr9pYQgJfMZQa3gH8YJ4K/ajprZlM+i0avaa0OduGGzUD5oF/kJod/p26CZ9pEJSqK+dnS3UIEaOXbrVpPVGHzjKSL+ividUINJVWidad9BJbZgzKOz2/CgeDyBv/SYMX9gmXQoA8j9mC65RmtG0aD3fO2QT/5CIAX0L0bOMVngIw1pPs6QSDpMBhjnL4G7upVxHTZaZd5XDEuvmdbMCl9/2lJipNfYuEgBYCKBH1WjpMN7BLivdwc1Cr2BUmpvHRzeJRXjY27XfRCs5cFZtBzyLkMhmtvxvTyGtYLH+ka3YuSKmdIGqf8impFiDz9Tw7aAlCyBGlk82wvujWBb4AjLyWZafuCgoDPrY54T3r+GLhDTblCvgxSt7aN6N4IpsR7UuKFkg1XZxeicnQU05682zHMn9sD+PcrdEgjGSDf6rIp8h3bElL2pxb6qPG+F59NvPulnRTT00=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bquabETt/oZEQpfVuuvF1vJFkhrUpsaYQnjZcW0UBg8cgPck5919NArehhP3?=
 =?us-ascii?Q?CDriHiTs+t0YLbNSgyhu/86y1NzPmrRzn2ofq8FKich08LR/zQCNrHXdy3PL?=
 =?us-ascii?Q?0fPDN5tkJaUuFdAP0gup7AApTMvZ4xf7LdHXq0s46HcX3Ox2oVgFonkHrbDA?=
 =?us-ascii?Q?gNYn8Snw4cIqV13WomAtTVkrbVgzf+KYRINhcJ1MQrF0CC7YcPKyvm+eCiMh?=
 =?us-ascii?Q?V2mpZzEbLKBXRpKHG16oj79B0xMugNGKRg9rDjim7yapoT8Z5K4MbSDAsbnm?=
 =?us-ascii?Q?eQqL7WqsOfofZ49HgA59G1r1BrxE1aY9FmYkBT5VHO0v/ZgteMkM8RbkY/Ya?=
 =?us-ascii?Q?917S6nCHGBNzY7YT27YdLkfraPtP90MwBejnB2AnWwL2EosMBezjmVxeSMHJ?=
 =?us-ascii?Q?AvbAb23lXPXRaVojaCmMAH7AxpfXbt8Kr0fCr2gSoa7Uz9ovYeNvugpcRUPZ?=
 =?us-ascii?Q?lxSy7q10HDNqBsMzmwB8CMiPbtTSfg8q7OBUXJsBzF84hel7hZO0EFaZ3Piz?=
 =?us-ascii?Q?hFsrGIxcytFTcab6iKP/PkzFEUqXZUHcCeTQ4yPrvMLj5ECC0rjgOR3LrOJc?=
 =?us-ascii?Q?Og7eVND+6hoVBoPkkxhX3qXFuX8cDRf/6F8XIh1F8bDGp0YYJAtN7jgT43KS?=
 =?us-ascii?Q?K8U1zwehSBlES1mRdawgQOd9cX3eCJL6eSny1iitEjdAb8zPuEYmlGeEJXrB?=
 =?us-ascii?Q?ycfCmsADWUChZkiH0lP7V5YFjLiZ8GuK4zROsKJDEq6nSJAQQ5wPztXqtbPC?=
 =?us-ascii?Q?Au5g8n0Nj2ZR4LoBlUKA/9H+0mPLcLFAupRA9YS/1PaYewdk45rVvkjr6FcB?=
 =?us-ascii?Q?zoP+En6UUOycRShREY7Tyvo9XCMIv2Pyge7hxCGgb5GHJiv9W2ztCP28jlzh?=
 =?us-ascii?Q?S0EOefldKJ0TxzgCeAQ9rWt2RiFsiEKQPK92Kg3O7Ucy/PDt4L95ShnNhQx3?=
 =?us-ascii?Q?yQ1Awose7hzlJurQSHBsElLHemiQcX/lsn+LT6YcnEZFPfOC0NOOQiisfViD?=
 =?us-ascii?Q?krjnOjuvPklK8mppFwrUObwaulc0Aigw9ZJF0jCx6XDdKr9U6Nf0PushKAi8?=
 =?us-ascii?Q?eRxsKDANDC5iI5W+St0od8OPWuzIsZXIJcVjLRRxCFLcSRYWSkrZQPiqB0hn?=
 =?us-ascii?Q?vwXtTdlQCphLW2EkzM1xxYZmPU81pJy6KVmBtIhUb4q/GQto0TI9TUaIGE6t?=
 =?us-ascii?Q?mVCFIkXcC67Zb2+aSBEHhF8fOaQs/E8CH0g8W72ZduiXUNA4/teshmtxfxKS?=
 =?us-ascii?Q?OO/0/SwelfQ1hgFz5XHT/kSXXGGf4NSTOXty5T9D98Ym15yhaR5/xqjWB0ts?=
 =?us-ascii?Q?wacAfyBZRlK07g6DGB1Y9pSMWuYmkZb01lYSkq2eZurFhRSRrg0BCu8ijamr?=
 =?us-ascii?Q?gq4nndleqsTsPRQwnU1j0kKdk5yHHbxseaNkvsuw1gPZ3BbEdHq1fjNrd+Xn?=
 =?us-ascii?Q?KCXUI21JOAjpAbxJs4mxIQN7rwfQjuoGj9xqGduq2UBJaUpLmqol5z7+C55A?=
 =?us-ascii?Q?6csULc6rtr9w4MAb/r0vp6FghcsJTVv42GS7qs7IpLOOOkQz0yhfNnG6fZdp?=
 =?us-ascii?Q?OxKC5N823aVXelmjvh2UB4Lw5ghSrIm1bxXnmOWA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1220773-a3f1-4b21-853d-08dc5366bf29
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:46:33.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okXt3mA2zFRu3OzfWtLJx1ZdLN4/2CGpK6PMW6nkL5QvOLT0hl1ahDzbcuh4hgBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

On Tue, Apr 02, 2024 at 02:36:07PM -0700, Jakub Kicinski wrote:

> > FWIW, I've been trying to push RDMA away from driver created sysfs for
> > a while now. Aside from the API complexity, implementations have
> > messed up using the sysfs APIs and resulted in some significant
> > problems :(
>
> Sure, agreed, but off-topic.

It is not - I don't want a huge amount of sysfs in drivers to replace
what fwctl will do for pretty solid technical reasons.

I do object, as snarky as I was, to you saying RDMA should take on a
whole bunch of read/write sysfs in drivers that netdev would not
accept as a "reasonable" direction.

Jason

