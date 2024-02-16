Return-Path: <linux-kernel+bounces-67973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD17E8573C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F9A1C223D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B0EAC2;
	Fri, 16 Feb 2024 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GAvYfq+E"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FABA2E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708050119; cv=fail; b=RRbaUdBGjkhkEvb8qChEz5QF7x8b720EdghLMl9ftVsPXfjAsu4Errnt/c3ehxiUB5NI3/dM/0i1Ooj8zxsUR8VVfYPx91BkJUCvRXsPxZaZK264qx8WDez3Y6uflNaR8MQ6MnmvIZ53RtkSa+Rbfx1EYkc1/QNIPlEM/RZ8Nuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708050119; c=relaxed/simple;
	bh=s3Vh4u69VfnPEAGq7KXyQtTYmK7fZkfi6xg2PRmvgiY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=Uk9bKlxnHD6VX0G9C4zTFZgjZr09fHdyV1aGEap/js0fvitRLtL+ZBCCacmTm3Vmxp486ielZm3WOLI2P1KrhyrJyTHmMOgxg7ly/ZDNVKSXjdwf5CEF97uGKsSE0LTE47P572ffV7HtMiNMk69XUsJcaf8N5iQ6WqPX+bcP6Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GAvYfq+E; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMOyINZE4e8qYcmmoOUQdEYPuLNJImQOeP0uI+66IRbFVfS+dxif8b7w1RGS668UAkTxeOiH/PdmmR62wUYMPXKW8jiN7FOKQ4Fev9H/sh4Hw0dVXKiVEpTxkJ8gNkvCvR+YlS1W3NRwEZ/VP61sOBvJpx7W7cIjyjKb93tldbtNapgPWm7Yixg2nzyA2fnSG/HbtxRulMlIrJh3ZSAaRTNOzRyVwpi4wk1Pn3xR0hMPJoWYvD7dVqEk9q+pNW/tuwg9RSo96HeYuaeA93SNVL4RzAaY58G8VGan+pROEop3QdiuBQ+4iJcynDn99oXBIItv0kYSXAtrENqp+QZdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w102R3dpBXORyrXpJLkG1YgRdO269Z0eC2q9dog2/eE=;
 b=oZt6FJZnWJwSKffZkiWRETWG80Iy3krksOu1vOxxG4j5DSUdM+apicAMwekwZRrCR4edUoHmvckeq9+QjK7LAmlErDPmUqdAxGhJcM3PEOPI1shyeuwIY7owO045RTMmrDbquDLrNAZa75lnzKSp/bi3D8MNbsaRL/3bqObHw3Yn8ud1TpfXTJSc9zbybjlIAU8hhS/E1GL/PH/wsfLJXVNd7o2UoTNMxjHA5OxjkRQDIf88X9Pxl99ExqoscrnJ0w0rw12wjcdEuyWEtbdygw50T7+HK5GeZp8jAMGfypohkCzMdRvxB1+Wl+bu1wAgs8xBUjCVJe0vaEAAxcHf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w102R3dpBXORyrXpJLkG1YgRdO269Z0eC2q9dog2/eE=;
 b=GAvYfq+EnqBIbf6ufC3LUnJi8J1CVx9IkyDzr0ZHtuKSNSxKPkOhRWDnIqS1RxRxjwLZlYmGssGy7M+V3evgjkRSnT91j2q4bMfgd9u1/abNq6dnv7LT5inM7GE0lN/svWx6UdXhnLAHfZsfnGjJqNvS5vHOlTqlP3xaqU3xA2hbqcWouimwsqTQGpPW75SJHunZ23JdyOQWQ8xaP+rNSU1j3tK+zJILWOLLhyAcN25t/Ki8/Wf21dmglIklBZC41Zk7X8sdFTSNncT3gIGr2sa7MNvLHO6ByewdDrNOSXRBGbLbNrgXGbu2B5U3YtdNcUdwVthZZ4N34+0rjkaDDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.28; Fri, 16 Feb 2024 02:21:55 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb%4]) with mapi id 15.20.7292.022; Fri, 16 Feb 2024
 02:21:55 +0000
References: <20240214202055.77776-1-sidhartha.kumar@oracle.com>
 <877cj67jn3.fsf@nvdebian.thelocal> <Zc2OVIEVe87WCruV@casper.infradead.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org
Subject: Re: [PATCH 1/2] mm/migrate_device: further convert
 migrate_device_unmap() to folios
Date: Fri, 16 Feb 2024 13:21:26 +1100
In-reply-to: <Zc2OVIEVe87WCruV@casper.infradead.org>
Message-ID: <877cj5du80.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0001.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f46a72-ab14-44cf-1148-08dc2e960b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TGcnEoYtA0W0WdY+6hYIleRFK2RkaUx9+i1qEv6UUBmKSBcHkCTt2gBsp3PTdyjCSuNe0kevFdh4iJe987A2uIMGgl/mgv7B61fY2Ca9+pItCLfaXEaWiFId/B4aN8BBU3PtYoRxwD/ruS1gqvl7G4x/hrIBdBg5sZWlWxAT1p3n8V//P+hWRjVUQqLWmbrVmaI2SI66gnn298GkirvRPVoomMS2lwwdlek2AzJDthZEiqG+kRUbnRqeO0a+Du+edBC9nU2c3e2LdDv7iW2IqEXY67e0iZ3KSGnT0h2G5Dxh5mS1wsapgLWpFnSNlOYZAZWBp/uKPCCROCyIGdrQTEIvrxAvTIgF4M8TLLw+HF/OeCtcECfg7W+9el+ADA/iWKW7cI/F/1aw6+POThDll44tsOdWj+L/Rkv1sHzec3RSPyb0AueOTQbT6H5ZHy7RQ+f/wjSq/PHL83+p6lZN8OKNVQXkO6oIkOjJb+iKAPhu6nWRxxZ/GapiE4Nxn9kcA+NmuUiUvD0q6GpXaNtPpt2wmgy4VHsVhOvB9jHq1m0xCzN+ucS53upG/sU29uzU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6666004)(83380400001)(86362001)(38100700002)(5660300002)(2906002)(9686003)(8936002)(66556008)(66946007)(316002)(4326008)(6916009)(8676002)(66476007)(478600001)(6506007)(6512007)(6486002)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bwQogqoiCZWznfYfEfyhH0xFw3Oi6Gq8ccqG8TabZCpqGusNEMp3w03UhUEX?=
 =?us-ascii?Q?1Zpz4zNuWwVzm7V+rVwQVcmfZopSmeDHrvo21azgLEadXM9x1NzRPBnOvm5y?=
 =?us-ascii?Q?ODmfaAm5yRF+8Nng3oHhHR9o3T2xG2CvNeYZwMg2fO77DLGtyVHxY9xuoQX6?=
 =?us-ascii?Q?YmHbGUixVbK4QqpQNEyYyfLIBTRFzr51MWqKZAou5VSC7//BA4e6U2QF/mYQ?=
 =?us-ascii?Q?kAsxc6YA3nu88+ICHPWg7ssqNkxIdsrjRPpLa3mIpSCEtvJa1Pbm//9IR3T3?=
 =?us-ascii?Q?Ys2viH296VhObslAAUUO7uy2vCKtAhTwSL1m1cnIyu4fY8WMQpDo3Jo+1xa3?=
 =?us-ascii?Q?57g0eSrGy/Y2NHMC98m3p5t8V6zzwefmYqtR5p6i4GTXwj8tN23ZNWU3YlDz?=
 =?us-ascii?Q?m3GRPjQqTXT4zPwgwbqJLQsERZ7e174ZslLPjF+S/cRAqugdjSa8i28EXS9e?=
 =?us-ascii?Q?lRvmzZdkf1Lr2MN0+zdSAJ3yY9VKLooM3bvzZbDiWFQhqv9+LXCaRMGRyb6I?=
 =?us-ascii?Q?6Z+ruYxFM9+NoUp517EeEcR8P7ENvhtmrdQBOTa+OePGxs6kCsFOYUeU36Mn?=
 =?us-ascii?Q?E5alRjEgmbsbeKyGvTVl96Po3laTe2swIns8CVPIIpdeU0vioeYwD5VbnD7S?=
 =?us-ascii?Q?4ct8eUfw6/WVs5scBNlg6MNX5WLUYpDJH18y7wBL3kE9ZLeGZyXGuKU6zyTh?=
 =?us-ascii?Q?jzHbXegd9ajSp1RSMELEjj9/15czBA7bI77dZs6o7MTKkZqWWRkKiLfbiBfR?=
 =?us-ascii?Q?xuVHgJhx9WO4ozmfSK8feLe2f+jCi/IZz9Cl7spY14ByrEyFe71WovOO5UTf?=
 =?us-ascii?Q?k5uXVUNjCGDylfCYWrn+ay6JmyQIFPUDAtiyxiK9FMFDqDFLYsqs4JLxANii?=
 =?us-ascii?Q?BIrON/2nOTCvBbAOqehUFrLa+jIaRP2X6Bi+mYeN5OLvKMBrah/hQ92+6/rs?=
 =?us-ascii?Q?2bMm1UxoEIgOcdRMXwLAwvpHwqiyQnX6Jvspw7z6fCZcxq83wIYgtr3kx6WG?=
 =?us-ascii?Q?QEdAKtv3vJdkdlf1yGgxf40Thh7J3YRO5TDHsW8yy/VuSm9mvdzWVcneMnTR?=
 =?us-ascii?Q?bKtjBcxfiYpo0oHgZ7rQZEkhtmIexfwqn8WGL0mabWGk4CVhoc4gd/D6aZvR?=
 =?us-ascii?Q?aVItd5qogMDgALvwu+7waZmOap6Pdpl34VQxxGKizsykioZKvN0VRmSnJBwB?=
 =?us-ascii?Q?DbwSWwxKZ9Toje8BkQ0VioLmRykG7kYsyICKfj4AGMCsit68wokaAujDhX6/?=
 =?us-ascii?Q?xVli6k1zm+jJKzNMMem9LpYezoexGga9D4qpQt4/U6PI7xmxZ3C+PS/ODKfC?=
 =?us-ascii?Q?2YbodgetTV+a7vr8neSBJcg445PYij0vXUtDxY/27WjOpGta+60epFQ7c1f9?=
 =?us-ascii?Q?d0yc7c9O7a1gYuOhqH/CYPgcmbitcLCaO/0GiOzbR5LVWmVPvvXa9Wh1qig1?=
 =?us-ascii?Q?oibL3UHh69S4V3G+TFuwYZ72ET4QXfv1Jm/xjxqbWzsyzWAMaI/M/Nof+gus?=
 =?us-ascii?Q?KWlu1VWtZGCwJezTpPyjFMfHHzBv98zKzPZakqtfD5bjL5V/z4P7IVfw630v?=
 =?us-ascii?Q?snGKoW10DgzeillMZiO2uc6vjFeaJpG7khG8BPLU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f46a72-ab14-44cf-1148-08dc2e960b73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 02:21:55.3567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0p8L450afpBLCh874WsYWBAt7kkrN/+xdY00O8tEi5ur9C8CuC4udetfRQlJeRjXjavGJh46SE3eHKi7tlI/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503


Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Feb 15, 2024 at 09:38:42AM +1100, Alistair Popple wrote:
>> > +++ b/mm/migrate_device.c
>> > @@ -377,33 +377,33 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
>> >  			continue;
>> >  		}
>> >  
>> > +		folio = page_folio(page);
>> 
>> Instead of open coding the migrate pfn to folio conversion I think we
>> should define a migrate_pfn_to_folio() and get rid of the intermediate
>> local variable. This would also allow a minor clean up to the final for
>> loop in migrate_device_unmap().
>
> I think we should stop passing pfns into migrate_device_unmap().
> Passing an array of folios would make more sense to every function
> involved, afaict.  Maybe I overlooked something ...

Note these are migration pfns. The main reason we do this is we need to
track and possibly modify some per-pfn state around between all these
functions during the migration process.

> Also, have you had any thoughts on whether device memory is a type of
> folio like anon/file memory, or is it its own type?

I don't quite follow what the precise distinction there is but I think
of them as normal pages/folios like anon/file memory folios because we
rely on the same kernel paths and rules to manage them (ie. they get
refcounted the same as normal pages, CoWed, etc.). Currently we only
allow these to be mapped into private/anon VMAs but I have an
experiemental series to allow them to be mapped into shared or
filebacked VMAs which basically involves putting them into the
page-cache.

Most drivers also have a 1:1 mapping of struct page to a physical page
of device memory and due to all the folio work it's fairly easy to
extend this to support higher order folios. I will try and post the
first half of my changes that convert all the page based handling to
folios. I got caught up trying figuring out a sane API for
splitting/merging during migration but maybe I should just post the
folio conversion as a simpler first step.

