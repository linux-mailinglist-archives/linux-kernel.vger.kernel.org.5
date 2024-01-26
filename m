Return-Path: <linux-kernel+bounces-40542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAB483E234
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB2E1C21D79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11922331;
	Fri, 26 Jan 2024 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IxqrsFmI"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2328F21A1C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296151; cv=fail; b=mG1CA98tPFFtijcfT05JMj1gJZvdRNZFwjGgnGvgNUM4G9RHyM9emeU/tMfxk+zsMrA9Mn3o7zqLXdeIvn1qh66tyfgNdZhamjIpRvVFe6xnNkiQlvi1eHOmsFCjFwi94Jgg52FKm6BWtfiIFVfKNf8JbV1QpqTVE8wsyHr38/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296151; c=relaxed/simple;
	bh=IwhE9cp+VgkvF9lU56mdK9ZIni/BtgCfXTaydy00O9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kjPwjasecde+ttzUBgkfWj8Y8quCzE2dP7lnI5hSk0OTgpG3uJTBYXw97d1GEYaDgrT4gWwiRUmp+OnvgoBe7fOoZvO+AVbx8Ycu6V3Z4QxPGrKxlBdeAEb03onXZlz3USasXeLblsty+tt1k5vdq7VTupAV5GXhPbbIiAY0QJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IxqrsFmI; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h17f8Arl3T+ELUuaDLC/yPjEedu7diVQrcyJ/etkbICRf7sWFgr1WDaZ0PyPhvOgSfnjjDYDF1qrA2wMQUHfxz5u1pM4NpBJ6ZSF6gvax0K/ixEoWGjzhMxXcr/JKWCKHktdfePVtOGDWKEBK5NPEJdwsAjHJXuU9OkbFx4367aDagzVVSulgmyPNeDpT8nOLQrtAOhrf6tbdEYFWWXAFdRGC023Wt7S31VRr4ffU8ChmsiN5EBuhra9f5w4+codOhi23t6V4/LPUFNk9CFkQkZltrMhjLcJ6lSUYYuGF5+IGRzBNiy0Dcsnbs0wJlPuuEdbvUQ8FcGCl68MrImblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzFZ5YQ5WFxwLDEXqaaQwhC5BWNXo00KEVE4k9SM9Ck=;
 b=W6faNFEzA1GsUw89uLapr/nj9f4kYIdHUKsl+MPL7YcDHnbAHDzWXimBcVCYEJw/ljxhZablfod4gn4mr5XJ5gv8kuwsFKYdCn1sn7nS23sKe/snTwyxeHHgzVdcQUQjM6jwsnQDmYJf+9Fyj/lT1tuTIeGJNMw7reblCdndYQapMokmSCJWy71GNM8USym6sp2tNE/RcfAmJ+/N1Vl7WNLS5xIWnzJ/w7A9JGWTlrlCLC4OzVw8kP39LQfx3jTSZDBzAKls2vYtGDyXyzaCaNbC5MhQGJRNnPRlsiakrqPUUevqPET6aegJypsByCibLC/mr+XxKQiabRsrc/jIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzFZ5YQ5WFxwLDEXqaaQwhC5BWNXo00KEVE4k9SM9Ck=;
 b=IxqrsFmIbnRQeXj/yP+LMXU9hJ3JrMloHOW3WEGxk/9OCrC+3DckwH/xb0iSYYQFhfHv5BpOqIM/KjmwGZDpMEI0WQEkD6GmVS2g5/yltyfSSge01BgEjlS18rgF1hNts/JtSX4IjiZzCVp3w+gBeD1H6yv9DnQt/dRdXl3y6kdYbOAg2izbBzP2LLwlH5OzHJdHK1dy2xF0XYWUa2WmYotUg/UGYjUo5LHGgpiDybG+MVEbOoalSXXD2rqV5Yhxh/72ougoA7JzJDdInc0Ccjh7MLCVNzlxcl8SUVX1lvDfYBFbIVoKTaWl7QUGAuM1UYAJYFO1YI+Eg5SF078bkQ==
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 19:09:05 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::89) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 19:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 19:09:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 11:08:47 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 11:08:46 -0800
Message-ID: <46490518-0cdb-4d11-be9a-374ed5792da8@nvidia.com>
Date: Fri, 26 Jan 2024 11:08:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bug][mm/gup] 3 Warning Crashes: kmalloc bug in
 gup_test_ioctl, is_valid_gup_args, pin_user_pages_fast
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Chenyuan Yang <chenyuan0y@gmail.com>
CC: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>, Zijie Zhao
	<zzjas98@gmail.com>
References: <CALGdzuqqU1PJ3BZ2PRtCHXyrsZ2xtzk38abB0=K7V-kOCYgHfA@mail.gmail.com>
 <ZbPnsnwnVKvI1rQ4@casper.infradead.org>
 <CALGdzuo7V-3-US9U+rjyBfmZD=d-gUfAxJejsTUsmnSZNDnh5A@mail.gmail.com>
 <ZbP7ThrtxhIBJChT@casper.infradead.org>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZbP7ThrtxhIBJChT@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: ce296e42-0bef-43f7-0381-08dc1ea243d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w//4X+9SYv4N0U4PAfS9go4H9/e4usrueqUuIViPkqL2hfOFvc+n83oDjWuKvc9oWpmT1HlWBZl1YsPkMihRm29hds9Tre7US39HJrYMY39JWY4d95AYp7F7qVVbeTUm6pk+dviTBd635iCsyV0TZGRHvMnNEQ7LkoLKxRKDVyiNAsC2WXamBRAjhtqeqOrWtWJvZTfAXwOZZ6N/py7zNcpXQurrvM3bMy6ejWX3rRZgdSuZn1iZdbuiwkJfc4hOR+vghLIPpjL7QZJZw8ETnqpidFkOdmAih17rnldHU3Zp6Xvykf6uyad3dXLUbrhGdcLwGFaMVk8k/kxw7YZIpd/apZuGgMCJNa74zO3uglTkQcal1eTEEGZQnoM0Vj787QUNQ7NlBPLiV2D0KiWkcB7mB+/serZFcHW2Lf/KhamLfd04ZRP+14NK9EDuknqWdsy/0gp/7arEQdtDgQpAns28WvZeCl57/jHBXG9dsEBLOX6dvqwcsxD3/guD96bZpxDWM0Gtul3lPh0uJnbD6d9z5flkrXkWenA+RhkY2hO1urvEdphntVyYf6UjtpNSu1szmiQ8JQrPpkCPWgE99MNdX5zMBgjtcaBoDSMqveI2J5Q1Wu3KzILxvCCU1U0NUqWoX0UjXvzvgBZ2LeRKaf2teTj30Hxoo+wqoybSr4dZn7Rd17xrrwAu81byapX24uG8KGefWxchnxoYaw1oC8ElgsZxM542ybuD9JCE3JIvf1NNblIVhjdD6III6rJk/1sIKq11BuBdNTd/z75hb4OwpL8jSIpF6I7dEwK4/lzy4nJhvcMnmHlLgY+ssRnD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(26005)(47076005)(426003)(16526019)(2616005)(336012)(7636003)(16576012)(36860700001)(5660300002)(4326008)(8936002)(8676002)(70206006)(478600001)(2906002)(53546011)(54906003)(70586007)(316002)(31696002)(110136005)(41300700001)(82740400003)(356005)(86362001)(36756003)(31686004)(40460700003)(40480700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 19:09:04.9239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce296e42-0bef-43f7-0381-08dc1ea243d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

On 1/26/24 10:34, Matthew Wilcox wrote:
> On Fri, Jan 26, 2024 at 11:31:26AM -0600, Chenyuan Yang wrote:
>> In this context, I would like to seek your valued opinion. Do you
>> believe it would be more prudent to avoid fuzz testing the
>> `gup_test_ioctl`, or are the warnings in `gup_test_ioctl` an
>> anticipated outcome?
> 
> It seems like a waste of time.  Debian certainly disables it, so
> unless you can find a distro who enables it, I wouldn't bother.

+1000! The purpose of gup_test_ioctl is to provide a way to invoke,
from user space, direct testing of some kernel interfaces that are
not actually exposed to user space for production systems.

Fuzzing this interface is exactly what you should never do. :)

> 
>> It seems that `gup_test_ioctl` can indeed be exposed in the kernel by
>> accessing /sys/kernel/debug/gup_test.

That's a debug interface.

> 
> If someone wants to fix these things, they can, but it just doesn't
> seem worth doing.  Part of the art of fuzz testing is finding things
> that are worth testing.

I'll go just slightly further, even: some conceivable "fixes" could end
up hurting test coverage. Without providing any real benefit.


thanks,
-- 
John Hubbard
NVIDIA



