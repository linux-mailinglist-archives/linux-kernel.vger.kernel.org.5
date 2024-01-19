Return-Path: <linux-kernel+bounces-30809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A437A83248D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5502821C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6263CF;
	Fri, 19 Jan 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdNVXD09"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5BA523A;
	Fri, 19 Jan 2024 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645382; cv=fail; b=PhBxZ2ZIGajvgTCruCfv8X1zX9990EM1BLfcmxI7GthFf0AFlVMcZJf5HxoV5K0xD+ddkyMteesfaAwki6tN2sdE8VWGIMZXUYNA3QYQpJf/3sKVmFfqZRIf/9WqMosFutOliR+lklnDONjYWw1+kFI7vz69QRmN7F8E0pmNcks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645382; c=relaxed/simple;
	bh=m2oRO/COGicK+fv5TVeO2EqjXUgzJtyCPWd6GaqCmFA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=MqMS19ztXKSdc9jMW/99albbBdJv6NsWOVI9gPSbs4rbOYvvw3FQLHy5eWZLEJSz2SLZcyXei6MbXGc9TBwysq4klrd01iKZBva82v7wR9NxmwmFa8er1i1xVDpmsyi2gDI+EIZ9Upy6V2VrWYQF5OvT9zhabdQubvQvAnsh1uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tdNVXD09; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfJUpT2fCrYKeOZM2d7M9ntgmeRzbZLkMwjhg/40gawGWQhZm7Ux+NiCp+aiX887Icj0UpXfnLMHfaVKWPfRSmNYlcc0CZKEB7MrE8PYQH52yEe/FyPKOgNH1Oup92L/kDyDHwzKD/3s5fYM3f6Wypck1UgfRJdTGofsns3dd1N5cYmvockljzqcnxNcw4+A4jSlQ7xfpeMB7JPljGi+udGMv+uMAt3+iSYXMMlgVZBMAMd58Js+hses90QMcWM7+q4pGif5EXfWz6k9LDaVmLwo2BlxQxUbz8os+hOToLmTlw2/BpXslYjPZoGbElI5KLVVFSZS8XofdswXwiJntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2oRO/COGicK+fv5TVeO2EqjXUgzJtyCPWd6GaqCmFA=;
 b=ZU26wmDb28Fhh4t9sP8nqbWQVZzy6SnSQdUas6xivhZKOkrZdC+F0myPTM8uJqMVKhGfTndCQ3Pl3E1z6G2ceMV2cRcctIqxV+UjfpJa0g4Nn4+Xx2uKWEwwnmE9zBMU1JUbu4p+atosDzKGZOjUeggQrRwEVMv9vJG5kXuG9S96YMhqjgyLj93CMWlNI42T+1UUD5pTvXV8oFjItcu4xrxf1huv3okNfBbubOThJX2MaW1tRrNjSQERiLzrWoryARlZUA+JiJi1DEjGKysA85vlBn4oAn/l/yjgqnIdfTXt/dSZ4qMe1Xr9RIkCku+/8G7CvKMcMqaZZKZ97mr/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2oRO/COGicK+fv5TVeO2EqjXUgzJtyCPWd6GaqCmFA=;
 b=tdNVXD09NE/D/Q0VhGpJ71BPqJXtrOAL9XEJYZwR/LSRDv2aM9TSsKp6X+/z2swRoDU6nVylCsQYaFKp4HsE7DiQAHtpxCGaY674kR+faEtynYsD5z6HPW0aq0yBOda6DhA2hdzFlhGd/aS4/ChA1QLBxMhYg3dHvQPoM/YBybiJHVdfzXMOABg8J0ZZQFgebTptwy3ynRBTzamB/i01tTXlf5PWpXF2bQnOPkMoZLxVprfv42Rr0qkwxsc79y2S+P+So67Agdl7wzCosHY6ET7+jK5EhTByLaZHtN+6is7s6tnNd6UT1QgYhV2v1/U4xIDJTZdIYeZcrka0PPTXJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Fri, 19 Jan
 2024 06:22:58 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 06:22:57 +0000
References: <20240119060714.258635-1-chentao@kylinos.cn>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: nvidia-shield: Add some null pointer checks to the
 hid-nvidia-shield.c
Date: Thu, 18 Jan 2024 22:19:20 -0800
In-reply-to: <20240119060714.258635-1-chentao@kylinos.cn>
Message-ID: <87o7dhx2ny.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 851aa52d-cb8c-440a-5ed7-08dc18b71422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A12VdMSQPCSnxUjvCa5+ElG5m6rZLhCJ1JkkPqEuCentmkK/11ZzqXvE8kS6G0HXJMQy1zthobHj+wcJvs6nMaKe5k7FzTioQ34jWuOS+rV4F0ott3DBAH8FY07r6aMQEhhJjGnKen8mzG7v9oq5IexPYR003eBrje37HmV8oPVBFBdSAUDXPwogiXpG6QZG3ZnUbYUL2y8QbkRajN5D1uzRFEWN6qHfJhQknGJORvY0CbpIQ4h5Qa0ToU/QtCXK676V4pNdQ18TaOW9AS3R02b+oaa0tMzCjS7+VCt8NgRgCkckImPklH21g/UlhTSBUgHmlkYElzYZpMVKDlrEBF5J2sQ6/Mx9T2uLifkcmYvG5sd9/Xe8zsxM+gb6bAfNRvUnwxw/C0O8XiphsKrn5AvsjzpQYvE6imiz0AJ1HYT6wsSGhHoNoDt+u9VYLaAx7eEEF5cwfcovr7n6bAvuBpP4KZT+xtG1edfr2ithIOnF9a7251jGK9mLCqGgIzFM/WJb4/lBEnGCDShp8DvyBWxJcnVJ3q+Ghn2/tJkHLSCxUWNl6qfog1YGwREAnDth
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6666004)(4744005)(38100700002)(86362001)(41300700001)(36756003)(2906002)(2616005)(316002)(66556008)(66476007)(478600001)(6506007)(6512007)(8676002)(26005)(6486002)(8936002)(4326008)(5660300002)(83380400001)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZM/Wnz2ZRhd963LSfl1huW22rRjzZXQo64011vyceGQnFNk8fxfH99NOD2od?=
 =?us-ascii?Q?AVfqnx7pH0BhkhvukF1AQs5DXBZ6yqyZgKBKuqVJzqhYwyUHHbOHYq9joC4Y?=
 =?us-ascii?Q?N+uL8ZDRAWlpXC8DeR7BGlD0w37cJ8IrG7lG/dC8S0nPpkav8dZnQtHnC3op?=
 =?us-ascii?Q?z3KRDrECSwbLUfT540HXS81MIS5F+kUdwWupyb1EiNzplwe7FqHMTnoI3EbQ?=
 =?us-ascii?Q?DEFOiEtXPgSB/b4a2Jxbk8weVoCjCHPGbqUpoj6WFHuhZeu+G5xCf6UmPhdc?=
 =?us-ascii?Q?Jxod25BOzdQetVqdNqr1MTY4tvjvzwPJLsGf74ODa2aXpcxKdkRz9xAdXLcc?=
 =?us-ascii?Q?5u1zB2qmbt+R1J0Iu82RokNV2WrCBSz9R9KZlF0fVSP7f7cS+FexU7ctlrtq?=
 =?us-ascii?Q?W98BFNioKDAKZsLIrNDwB3oHmugBu7clwyJmEB5ClcPQDXVJXZ+k1JKKL/BA?=
 =?us-ascii?Q?1F0ay7d/bxKEFy8R6LGMWC8DkEbh+syeENxBtJZsrt1TCKHtsjh1lOuqAze7?=
 =?us-ascii?Q?nKt9O3B4yNjFOeMwGvZBDvBLQv+19zsBCueJdCpq4wWlY7OW4NJazjNk2eEL?=
 =?us-ascii?Q?73uD9omBzHQM0htniUtHWsGmN/6Z73j+Qbdqw+GkRy83PGtYj55nvyqlGmI5?=
 =?us-ascii?Q?vifQZAeCWxA/QG23rASC7OaLx95it2FeYajgftxhIciKD5RxQc1l+BboY3W6?=
 =?us-ascii?Q?EkGHsPY2j6cnHymjoeFo6LtczOkkt2ec6Hwd0DUyzkusm9sH1Duq6ZR9gbm8?=
 =?us-ascii?Q?n/9SS5y7MOocvmFmVzBVM3R6ylZCfIhKWnwl/tLkPZXMdpyt8CeppbfnoRbc?=
 =?us-ascii?Q?qbvtwocyCdVe738P9ZkMLgkt2HrvUflupKrG9Flzrm7MiUArx+GX7dpqIrxY?=
 =?us-ascii?Q?oX7fr43zegW/8O534/hmSK1jhp3vOq80ktwdDOMhY4ye27elJaBiTw/+0r/I?=
 =?us-ascii?Q?RwmiK6FK9NX50Zk3MZ4XvQ9Hs71PuUpbQwwXXtpnZPGylh8gtOaTv49CLu1X?=
 =?us-ascii?Q?Zhe+EAAKoS72e5oSrH0dMt8ITFv/HVa7rkspEfcIKzkeu8XrZWZ6rZq26/pR?=
 =?us-ascii?Q?8YdN7bgIXwKfsgoURgLiFcY+8pP4kzJ+iYwmMcwQjxY1uGptPVNSIODwnpPe?=
 =?us-ascii?Q?sdRy06fBjT2nq+/dvEqEwFsWHciAHqj5nX9jZ7LWsNQlcrsC8FIw1HBmJMH7?=
 =?us-ascii?Q?V6JE4Dbk7G45tQ61hQn+etJQIvmyaTKvFfBxtJV50DFn0qyPoxR5OoxEC2k3?=
 =?us-ascii?Q?AMNxIc78aOIqyScQwC4PFJK+k6/ja9WN81KZ2R6gB0WioW7eiS5MOBtbi0rM?=
 =?us-ascii?Q?D3gN0D6fLOQWawj2dqfwGxS8395LfBdhUKMLmiHUiuHXVcnpxUZnZdh3AjSU?=
 =?us-ascii?Q?usOWPUdKzCQ9csnZy24Pojszj3sZqZ/B0wjfsbEgFPtpL5kmO0/j7TAL+JL4?=
 =?us-ascii?Q?PTCDhe5VWIRvSxRe5MyULAhYAwo24uMTKYcVR7+24uaYJvKnen3tUNitoANo?=
 =?us-ascii?Q?rRosf5tSlGy6J5ckLS1/zCjicpPt7p5jbg7YOU8nueNpHbuKv36vgsL47INP?=
 =?us-ascii?Q?DIEauwvTlyNSoX7Ev87+bjP6kt/ISv0Lyki8VlINqX0TqK7qsIqD6k9FUTdy?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851aa52d-cb8c-440a-5ed7-08dc18b71422
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 06:22:57.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/BaoMYQ9EaBbOylQqCOfY5ckjZ4nKVJEZYrO9tYTErYuhhgwBDgB3dzYJVvAcsF3UZQuo48Cvp3iaipNMnKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020

On Fri, 19 Jan, 2024 14:07:14 +0800 Kunwu Chan <chentao@kylinos.cn> wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---

Just one comment about the subject for future submissions (this one is
fine). I would just leave the subject as "HID: nvidia-shield: Add some
null pointer checks". We know what file is being edited from the commit
content, so the additional filename detail isn't necessary.

Thanks for the patch. Really appreciate it.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

