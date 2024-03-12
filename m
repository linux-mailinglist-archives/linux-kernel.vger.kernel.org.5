Return-Path: <linux-kernel+bounces-100899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257CF879ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A76B24B42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0B2E41A;
	Tue, 12 Mar 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JtE1An01"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2081.outbound.protection.outlook.com [40.92.40.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F71E865
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282750; cv=fail; b=WxTxJhrcipe+4IIoDZfIXBbUff2jZhj7EBvI8MsQpaSxNna2ykwwk7UpGk1EFRNZi9HOnilg19ukrqxD936CkwqjPwjQ+/et4W+iyXPGGHvfsy97gT7RofwawzrWjnj1C7n+5kA2DZjlGBnGlVUwy0BVu2mOfJ3SSSVacadXou4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282750; c=relaxed/simple;
	bh=B8ZDGG/01RD6oa7mHgA30555UDbdNpkdGdBjpA5cndo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tF1JdesT1ch76yto8aMvr/a0JsaxYBlJCM1oGdlit+jt/Sm/u/4rGyMW5RDpFmgKeWdQLkG/D9BgN1OoR+Wo8X9B132cJJ3ApA1ths1sAXgqT92ueds85DMKpclVyZK+Fh2NoWQt6/CZ192GPaW7I2d9pTjoQjCou6OK+9ZyGXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JtE1An01; arc=fail smtp.client-ip=40.92.40.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPB1gYX4uZiacLJtdJ3h8DvvzE7b46YWpEHbpsi0lP6UNniQPU46+C+TMY+ZKSGeYq6OO5lXXMEH+3hxAfJfPddpc/G3dxO6k1MjDBCqvVx5ABeahWnDzA5zKKeDMs9r4CxZ5qkJQpIzch8rAESzb4gbnJTjlzpkVKV5dMR9+XoMUE08Nb1T+DmFesM6AKJAY1+RcZFzpzGOgJc+CrfF9mRXaJ4UqaU6vxv4FDR2t/VYFg2s647UKmwssoIhdT5DE1zdjQDW4sYxIDb1YXP+6fRmst7Nb6nmRlk/Bya512pniOJx3F9xiVq5203oe2R1r8SpvaWE58m//YSd32f8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWA3A38p8IHTYsSQ3nPbQyWryWmiAHS7lNbh1fmAdNM=;
 b=n8hgVXFSJ2IQspxORQgxJcDZnW2dO5K6nfKvzURrgdmOafLe/KuywdMfqIuCipNF89Byq8bQB8gKc9DfoAALrslG9ruDe8SPXdDj9VbmvScKput2bnlitteiNp5bchw+AldD1IDSrx0miAMfMmZ2xaZuf4GxpeLYpN6pxZt7ezDa07E3BM+1+efSHpofILlq8QWUNXp5Bxly/AgII5lssb6ZWijpebdnSl9+d2A0Tq0yZ9d/EZokODeuxjPpw2mDB+iYKJgG6rjWeP+7qeqsIDJv6r8QA4dt2hI/LRJieiWvczUofkXM7oENmEGM6Mm2Z2jUTJ2aNDHouzyJHtwGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWA3A38p8IHTYsSQ3nPbQyWryWmiAHS7lNbh1fmAdNM=;
 b=JtE1An01Mtasle1x5IwIhO2YSfdrVRo83lYAA3PgyoPf7vqXEfW1LpP0whfXv7xVfYf7VMPkiRsleBaEtL0TvWdZns7IOiqruZHcgjluByHRzZ0vyqkFe129ljMe89Zg8g3D4m+lAYHJCTyHo7XgDsH2O9qeZ0r3cDV+AtqbEwttm/xzitxzAV7rwA6hwWIKsXARX2Iu64JCufUg1EUHK11YVZ+7zidS93R09Bb+CYg3quaQU8Sy4XB+Q6zO6f2D4KxMZX4IRTh0V6xPtSPVXsrGRzqt25+4lWcdJRb2xsEvzkvU5abknzIdKzrGwsFn8RDDGBZE1mSN1NItk1C7Tw==
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 22:32:25 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::f933:4f7d:1a1e:d7c4]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::f933:4f7d:1a1e:d7c4%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 22:32:25 +0000
Date: Tue, 12 Mar 2024 22:32:22 +0000
From: Shivansh Vij <shivanshvij@outlook.com>
To: David Hildenbrand <david@redhat.com>
Cc: shivanshvij@loopholelabs.io, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Houghton <jthoughton@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: adds soft dirty page tracking
Message-ID:
 <MW4PR12MB68753331C2CC131C9D99564DB92B2@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <MW4PR12MB687563EFB56373E8D55DDEABB92B2@MW4PR12MB6875.namprd12.prod.outlook.com>
 <ff65f353-6aa6-46a0-94fe-892e7b950d35@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff65f353-6aa6-46a0-94fe-892e7b950d35@redhat.com>
X-TMN: [Dh3EUcjU+RgNzSOvC43Lg4hs9/uKLeiC]
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To MW4PR12MB6875.namprd12.prod.outlook.com
 (2603:10b6:303:209::5)
X-Microsoft-Original-Message-ID:
 <ZfDX9rRuX6tPKlIa@ip-172-31-12-205.us-west-1.compute.internal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6875:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 86be3df6-d32d-4d22-3953-08dc42e44a65
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x0yUEfz5AghqXCftQ+lFY6hPMjG5EWrx+1Lgx+Ub3oc3Io+xvkLSO+MbargdMVqzaE4qMsPIc5qwDBNoCI/XZO/wGAuCKdvBRf6yVu1W370xK6ScBNx7Fk+uINMtmq956V002P+pttWugXl8eMGtgZPBwKqDR18cEGwf61zHsehuLpxf9oc7u/BgQcJDjCffaKWWQrse4V5e6gpQLf4x1Y6fOB0bBqhEp5Ur2471a+qG8SXMvPLs5SCwwBwJviUdBK/KUTd5q2JMAeqGggDjXQqULuS08XlLcPkK/Vji90FMlPptM3iRYwr29Dsz639foYhJt1czzmnhx2xqXLFJFWHqMo+iShHfsPz9l3mW1y78quA2HPD/l6vkBaTXDNhy/cJSbYiACwXQC3j+5nxzeYv5j9YzYsl+opvc+OlWncWuAnAndk9vjuvZFy46LXqefJUiAxItvKy8nQeF3ypWN27z3gMubQ+hsV7tpyrxNqMkNsK3ARcko9mNYW9xevtS4ylGE6GQCMggPK3SHv85qWDD8s6U/11qF5b6pbHwjzYgEheG2THcTTMHAjf/l6ReGk3esbGaR0ZxqY4juEEJjemnzvChzNI3VtLABHjf36ItwkfHb6hAXX9wppxW8bz7gvA53cXsbWBux6t6yeMhuSgYG7fvdj8N/Dfsgn4gFmA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sqnNWqcaKGgXwk5o/XKu3ePz8o+qMAMw/iRMweBGG15N2Tl7n36wlt4+F7vx?=
 =?us-ascii?Q?cSM/dyIqghJYUT5u6iCuoU2PAoBG4NpU4COZYV2PNc7qP+TV6ofw5eLLnNAT?=
 =?us-ascii?Q?qLueRI5KDIoVvLILxSwWSOMp98PATqqx8YW8MOL5WRS7CrZtQoxf0lYrUWmc?=
 =?us-ascii?Q?pN5J63FodzHdkkv/1o3VVu4Mi/wggEasCXFO4r2IQMNI7d/gOVDkHeART7EZ?=
 =?us-ascii?Q?6fjzZ9WxlG7OBjWiaPU2RPdcKCZ6P10KDmMpXUsducK3Q7v0VxqyThV3hrcl?=
 =?us-ascii?Q?NqtJqzOoOFDcyho8x1xq9rMuEnQ4pQbUpt7V3c3EWcY0R5mkoBTBJYfJ1A+W?=
 =?us-ascii?Q?yL1EOVLSC9LY5h6UpFD5YmWEgEdLkzeQbVI46XW2fRZ/TB3EzsUam1Pc2WX0?=
 =?us-ascii?Q?99lesx0u9JvQMcqZNHxylC//qIQPddcKYKOE0Fnvn/ZYkNoSi8bSZfj6kNa7?=
 =?us-ascii?Q?2N6bI5q57lLC/gl4hqyLWQUNUmmi72UT3TC7O0ompHjhlKyGoJgJMazhm2p5?=
 =?us-ascii?Q?RkvpNz9GBp1nr39goBnwRtlba1KsS5GmzHNJwK6EMdrn267tZxlCv/TxJJud?=
 =?us-ascii?Q?HVUgy42M9kul0gE1yFmMKUjVuRDgjfZ5iR7ICnqRuh1/I6cZARHVqakQ09Vi?=
 =?us-ascii?Q?j6dhMERyzTTki40OXcGEChEmVY+2y51HQE0/HMko91vg01gsqO8r/gBsm8Aq?=
 =?us-ascii?Q?e1fmS0ZNdkvlzpMlEp/7rPFnYxP3I9kfWCYbGrI1atMnNrX1Xqtk9vyTfK9s?=
 =?us-ascii?Q?Crf09GCuhtUnnXRAYydBJUeBfThip5VxYfVG9N5oYgszT36GTG4OFjvZJqRS?=
 =?us-ascii?Q?Wmx3W0yCMSKmW1aEuaG8N9YIpvbBe1OqXi+lQ0sPSwg7kGs8xE6q7CSt26Nn?=
 =?us-ascii?Q?zD1RvU1hPg6uO262Jj9UaSLXswi4Pbz5zjyfc5MkhxwaPxymr0pZI4NG+hKz?=
 =?us-ascii?Q?Pr2qIsYc/ATDwBvr6sqGtQp0UR87ePTCOZQt6S3RnoVqr2uKfjmqvRPHVrZS?=
 =?us-ascii?Q?NyYnrE5rrDHAz9VsLkq9jv2N9cx6Ehsk1SdLsP3yxrZbNQy3Nb8ajIMEuVmo?=
 =?us-ascii?Q?Ayh1HQyOgzeedt1Y1f5XinTGVyKBpkFYLDRg3zCa2yKdDnU2+/j9gI+iPDxU?=
 =?us-ascii?Q?4RTVKH11Z0+ww0tvoW4MAuHYyAT1hnQrjfElSNK+CuStlJfQ4TWTSAXIlAFK?=
 =?us-ascii?Q?GUWkhaqIpwdq3I/VW26CSfT8gZBM3wuH4mUcfIXovLcaqfflK1fC7bmc9nK7?=
 =?us-ascii?Q?EtybJ9rmQvdn/wp8kMHh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86be3df6-d32d-4d22-3953-08dc42e44a65
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 22:32:25.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080

Hi David,

On Tue, Mar 12, 2024 at 09:22:25AM +0100, David Hildenbrand wrote:
> On 12.03.24 02:16, Shivansh Vij wrote:
> 
> Hi,
> 
> > Checkpoint-Restore in Userspace (CRIU) needs to be able
> > to track a memory page's changes if we want to enable
> > pre-dumping, which is important for live migrations.
> > 
> > The PTE_DIRTY bit (defined in pgtable-prot.h) is already
> > used to track software dirty pages, and the PTE_WRITE and
> > PTE_READ bits are used to track hardware dirty pages.
> > 
> > This patch enables full soft dirty page tracking
> > (including swap PTE support) for arm64 systems, and is
> > based very closely on the x86 implementation.
> > 
> > It is based on an unfinished patch by
> > Bin Lu (bin.lu@arm.com) from 2017
> > (https://patchwork.kernel.org/project/linux-arm-kernel/patch/1512029649-61312-1-git-send-email-bin.lu@arm.com/),
> > but has been updated for newer 6.x kernels as well as
> > tested on various 5.x kernels.
> 
> There has also been more recently:
> 
> https://lore.kernel.org/lkml/20230703135526.930004-1-npache@redhat.com/#r
> 
> I recall that we are short on SW PTE bits:
> 
> "
> So if you need software dirty, it can only be done with another software
> PTE bit. The problem is that we are short of such bits (only one left if
> we move PTE_PROT_NONE to a different location). The userfaultfd people
> also want such bit.
> 
> Personally I'd reuse the four PBHA bits but I keep hearing that they may
> be used with some out of tree patches.
> "
> 
> https://lore.kernel.org/lkml/ZLQIaSMI74KpqsQQ@arm.com/

If I'm understanding the previous discussion (https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230703135526.930004-1-npache@redhat.com/) correctly, the core issue is that we actually do need to use a special SW PTE bit (like the PTE_SOFT_DIRTY that's in this patch) - but at the same time, the PTE bits are highly contentious so it would be ideal if we could reuse an existing bit (maybe one of the PBHA bits like you suggested) instead of creating a new one.
 
Is my understanding correct?

Thanks,
Shivansh

