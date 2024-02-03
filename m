Return-Path: <linux-kernel+bounces-50802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D7847E0C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E48828B738
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE3923A7;
	Sat,  3 Feb 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xc/lu4Jm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749B1FB2
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922629; cv=fail; b=BLsHBmpzSEf8Sh1zG/mpF9gxOi26I5yHgTccy245oqBP0gp/zlhzuMGLgHPZF26sR/uZEzwueW0AXDtWQa2A8eL1RWpSGc89chFCjTp3bMpi5+gvWl9ZSRFHQpYyuRiNPWdW96j4DkfjsS09A/Gyon6jTip+UZCMisyrAF1cKKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922629; c=relaxed/simple;
	bh=ZtN4nIxCUXp+r4ePjJtXjb7mbFkKeb/g+/KmCs6KGuI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=h0sZ6ZbGja1shlsoF7FUYKKhoEFxmgMsNsYk5saDh6oK98SzbZ3Ltw60Km6O7qR0iWFOjoomAawcS+BFjLKdMTlFyNddtHQ0DJEHgU054GOWHw1VrBjw49v9B878fSNLQjAnf1OGsNdtJC5LIJHYdl2H8vEzNgBKBbdCXNcwk9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xc/lu4Jm; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmlQHFyt4Qovp1gTiF9G8PZnOLaFGF94IjSKmXQ4sg1G3akhZiDytZEqefEeKlEk55qeRL/C+5v2VT/NUDQ6GxUCjVnSRUxt3AAFIkSemrpAvRwMtbR+FvzejjfOaV5B8vuX1JUzxX1MRAg/oD5UzXsVJGBmp+EtksfPHBxDYTV64YO92pfD5qBG2/DXIqkrXq30Ll0D4Zc5OjRyNnbyYClPPCgt2XpPnt1B8J3oMdwo8w201wkGmn+9JHJzkJt5nMGO/RndMY9yWToDObkT5bv1If4nNnxNH5juul8RHXsUQCwCJ5AyOdHmInXVpzSRBHkSJDX/am+ApJS04fquSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtN4nIxCUXp+r4ePjJtXjb7mbFkKeb/g+/KmCs6KGuI=;
 b=oAHuwuB1FZkqj7rRt83u+blO40opU5r2EpQhXNBlEkYxrZ7U3qGd5H1qDKW8/g4HPVYLVk4m4mP0dn40FdQTIoey7BMgRXlBnNZxTiK/hobYazZ7mPI5oDiKFaHC2H6QwyxRUsRFOfcmh0H+L4BnkI6R1jU/8IustX427vu5v1TqfCHUmw482fmx0+2eUDo5EXBanDCdH9v/etsJXqZC8yYd5gF60kRvewXR1rO1lNKSKbQfCD4KekHOQWfTTEB00HEj3Zl1K8d4hvKSUD9+tewOofSrFC+j60ROq4WO4frxb4TDf1yn9Nxxu/fKeBEgEXLQTMyydmH2yC5VfIL+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtN4nIxCUXp+r4ePjJtXjb7mbFkKeb/g+/KmCs6KGuI=;
 b=Xc/lu4Jm/Ty0JDmTfk+TncqpzsB8AHD+nyScjJW14mJVVd5DzPHeWtwlxSZekDIOixQDcHXcHacd+OK3DU2bDKpyLv7ONDWxmmoohFe7ySqhvuEIB2udtSYyEDBV7phrPUEvEwjywKEU3fyPxX1dkERMqUW447t3V7yle7yhRjJwdlnE4rDY6fsB+xYE0Y1gINRVv1czKyMQboR+aDzsh2ir+uXB1O7ogD2Ifnee2LErbPYf52ms8Jw1TxL1df6I/50MPDCNfM2l9eyKZx/7I3J5swAs1J+JwJbNMxr5BjSVw2alT6xBMw6c9i1AbU7ve4YRGxlFlytsLGfDsNy+uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Sat, 3 Feb
 2024 01:10:24 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%7]) with mapi id 15.20.7228.029; Sat, 3 Feb 2024
 01:10:24 +0000
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-netdev@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: This is the fourth time =?utf-8?Q?I=E2=80=99ve?= tried to find
 what led to the
 regression of outgoing network speed and each time I find the merge commit
 8c94ccc7cd691472461448f98e2372c75849406c
Date: Fri, 02 Feb 2024 17:08:02 -0800
In-reply-to: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
Message-ID: <87cyte1hfk.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: d87d983c-3b71-42f4-f8cd-08dc2454e660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X/BCOtspXhFHVcsuJ8fr2Bf2g4mcMxUE3wcI2Joc6+x2Kp8pEv7p8TDy9qReyww4JSm7I+jBHPqvzrurk3Qot8q31s/IEDobmr8sumYf+f+q7GDDKoAPJ3dutrG3IUTr4jylh04LwBvWic4nr70x48zeg6KvVRvtsfB91khRiX6iVaaJXOGhWgluPze79+/phlnFcF/YKDt7X1MT5bo5dUPVsic0ifFlRzsor3K/HtIvJ0CTck30Rf6SG38Uy/9HeIxdIIqYEPlzU/QwRaQSQFx4nJuHWfxuM6zVnwIxl2MiYUXpfxm8eWUbsXfqeSRzfLElZ4VxX8Q79Lhlk62Lbd+cn6Jb3WkdfRy19HSf1An6LZHsETgoX1STcnFW753qk+NVMUAE0wPgFHAvVLl5w4HPeTSmdGDuWqyeBrLB7ni8MKdXXjxVsB5Df1/z6no0NA7i41nV0m38T7P8PWa9EKk4S+YKHHRP6Zm0FvlcPIajR6PcDESJ2c5cdu3/MUbtgVE5g3KyHCm8zHvQZisXVBgeAXR2MbyfUAU1/84c74Omrbmwd9xyEN+lmv+4rparQvOtd0Zq4gMXIv8RWhiRGfiV0/EbiagGTqIstan8ctlPY/lMyakDkdnpQzZ3YmFjqcntbI9nTtEUhcKZc4JOyd/D5ZGbPla9QW4Hhaltv1i0uSbnEDC1I+wZBFNKCHjJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(54906003)(2616005)(41300700001)(66556008)(6506007)(478600001)(8936002)(66946007)(2906002)(5660300002)(4326008)(66476007)(38100700002)(6666004)(316002)(6916009)(6486002)(966005)(6512007)(86362001)(36756003)(49413001)(37363002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ST7TwIiN9GWkpcrTJV10pxK8EUU+Yfg+S5YzBudmhCw7fOj09ourcjOlFJtK?=
 =?us-ascii?Q?4z9xf9JMo5ydFlDMnaFsvJRRatqFO4uhcfXgqP3OqIfcYceKpGJHYcc3Zdc3?=
 =?us-ascii?Q?HW59ApC+63DOfdwHThDlDV+rfgtab42VVdb8USx/AJAKop+FQ+awreGNyf6U?=
 =?us-ascii?Q?oMbyNiu/mvG6JJN+tk2hfMYT2uqYrktUrWVTtMa1oPGQIBRXAUEULzd/v0ie?=
 =?us-ascii?Q?BO9NijiRSrHEQOPqlt8z3KKdTmzGC7S294X/+1w/Q6I3PT+i6KNt1ts7aNql?=
 =?us-ascii?Q?poraIJvXV+Gx2OVrQu+Z1vSqktbqeQ49xNwidep6ZogQJWvh0QR7QE4MpiEd?=
 =?us-ascii?Q?n07uldWba6WCKb7CILzkZQU3ZvmF42dOF05fLoxJlluDDHis12BSyAoesbt9?=
 =?us-ascii?Q?O1MVrDel/Jg1AEf2FkOILaQ8TOpGubCGd+EzYRFsNU2Jsv0ra7q1lI3UGZeu?=
 =?us-ascii?Q?7+dHhkQD+kZpi8YR7TmfPt8SSe4dUpqCNUZghwGB7NbW+D5NWByNtOjT6wHh?=
 =?us-ascii?Q?5bNR01O2Inz27Vgdwd1C4wpji9L3gBVVCMKSzHjlNeaSvRZSYynJU6IWZ0Yx?=
 =?us-ascii?Q?/i4V1lXZpGjRDMT9xsYapLtuLSyt2d2xXLdkrHiiTPHvfuEqR1IuA35eUjEF?=
 =?us-ascii?Q?HO98U4S9b3KfkmXKO4fupcKlr1/gk/pUHGdiW+6ekSKH6lsCZjn2u3Mey4Fm?=
 =?us-ascii?Q?mMzuiJsjwVOzXGJM73b3p7QaZYV+BLT1iusWQyy6p9xoe/j0I8VkRVRV0cta?=
 =?us-ascii?Q?BzuSjzGjPr0sVCFVksHuR3Jh1lmJWwarQQKP53WMpiq5XLISquT0GamQ9XrN?=
 =?us-ascii?Q?PzTfZeP+ylt3Nao+tAAt4aolnq5ImKr6lRQZvMwDz6Jvkq+7OtchK5WP84to?=
 =?us-ascii?Q?DJ+78uNRGfn1jyLMDWT0yVvTkURfmLK2ZSxYwi/uzzfixf3BIb2zAaAZ/WCc?=
 =?us-ascii?Q?XDDQMMbvpj1CURWHqfCq24RGq1pVEsAlOr+UFEoXxFOBRN/RqbM7Vq6yk1ZS?=
 =?us-ascii?Q?NTCPb1a05u7hngl1yw6MWHr0wGubycftqGZENtGBEsUiyleDhnKuypdJ235p?=
 =?us-ascii?Q?+OyAeAIRZGlrBAn1TSlb2nwjfD8Xa9QUZvZNwKHCN+jT/6NmklQxnyrBQqpQ?=
 =?us-ascii?Q?RDe2OSaFt/DzgwgOWxdVctHoeAqLl9E8Toc5GUTo2zYAqAOVbAKRPCDUbw3A?=
 =?us-ascii?Q?2Cp5z57usdHr8qMmfEfESq9Q+EKvWECRr2Zpx8dyN3SPONyJII2UW3bLxkvH?=
 =?us-ascii?Q?EDe2vVPpggIR79EL3HmZSN7X4A4q5fXDxPsF2wNzbX3XymQqoql0dWK8kn27?=
 =?us-ascii?Q?sOWqEuTtEEkk3Nkk/0ldXyKu1FhF7lkiO+Iv+1KrkdtNAR5pK3YBjXi1tEL+?=
 =?us-ascii?Q?fEgyCMojUf16CWU9Q1XXuEVA5Gi7GTC2T8dNREElemSMS/Kd/pnLB47iR1hs?=
 =?us-ascii?Q?VL52yNHg+xduWpc5E2DXepDJtNdD/a/WbtIUxZvoo1ZI8yoJgBjsBp3gzqrJ?=
 =?us-ascii?Q?WST3Ewk0eZy1DfNmP7MB6GBEAfhJxaN71nVhkbeONcLS3rdFxj/nOT1ufGQN?=
 =?us-ascii?Q?NgoJfbP3WnGpVKxYlwo9e/RGZLWC2Zx+a0dRiS/B3YYhKB7X+KBY/JB2KOAz?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87d983c-3b71-42f4-f8cd-08dc2454e660
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 01:10:24.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WhsF/iiWSDyWGBzfuOxFjr8AAkGz7y9Tna1K6jwS3t/JD+uhdytY2hffphOIMRViylOsebJQ9ut8btoQzkrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582

On Sat, 03 Feb, 2024 06:02:15 +0500 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> wrote:
> Hi,
> I'm trying to find the first bad commit that led to a decreased
> network outgoing speed.
> And every time I come to a huge merge [Merge tag 'usb-6.8-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb]
> I have already triple-checked all my answers and speed measurements.
> I don't understand where I'm making a mistake.

Have you tried using --first-parent when you git bisect to see if that
helps you find the culprit aside from the merge commit you keep hitting?

https://git-scm.com/docs/git-bisect#Documentation/git-bisect.txt---first-parent

>
> Let's try to figure it out together.
>
> Input data:
> Two computers connected 1Gbps link.
> Both have the same hardware.
> Network: RTL8125 2.5GbE Controller (rev 05)
>
> When I copy files from one computer to another and kernel snapshot
> builded from commit 296455ade1fd I have 97-110MB/sec which is almost
> max speed of 1Gbps link.
> When I move to commit 9d1694dc91ce I have only 66-70MB/sec which is
> significantly slower.
>
> I bisected the issue by measuring network speed on each step.
> I save all results to file [1]
>
> [1] file is attached as a zip archive.
>
> # first bad commit: [8c94ccc7cd691472461448f98e2372c75849406c] Merge
> tag 'usb-6.8-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb

--
Thanks,

Rahul Rameshbabu

