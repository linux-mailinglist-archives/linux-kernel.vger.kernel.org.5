Return-Path: <linux-kernel+bounces-62357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED46851EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8301F22FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CB3482EB;
	Mon, 12 Feb 2024 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gT7TLQES"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14173A1CE;
	Mon, 12 Feb 2024 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771118; cv=fail; b=CynkqfM7FbUpCitTn8mf0EhE0UMHgJssvkfw0t8nBfyn/tGZvH6J4iTvmupWhpb1Qekz1jlXs9mNgpSC78McLgwQVQsDE4p1h8t+7FS2OGWBaBsqt5SdmKFibe9WA2Rwn/CRb3z4zCsVRNVUkT2HhgiCYxE2zdLXXRzqe/kQa4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771118; c=relaxed/simple;
	bh=py67bPSrcKXHUz/pMnrJx6B74Mn/DRbkbdOHhlS0ds8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bVgEx0IjYHIkCH6IPMwy+5mZR5ihfvgRhTJHRnQEp1e3MzhFsBPLtpL7cPEt5ytEQN6dQ4+Y9nuUdPfyz21jW5r/2oTUjNwJGbI6gfKPnA71g/AQ/YwGtT94zDsm9q+0fOqQukWYpc+HZx404EaCwM82FQLaeF7R+IOVeJhIOHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gT7TLQES; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmI/twZmPjN0UoRI33Df1Zo9Bh4FOXNGTm8LnQfHkYe7+4VWmn6/ohFHn4MTmXDQzT3cdIV9etrm+8ql4s+yLtJDbGwWhqiEfoe5SqgsdvGg3HSW1faC7GMqUuvTtGj513yk9LcxzNcoWtvPEt3Gq7UzFrhmG5/Qp71mSGJzsmpLib9ohCc1Xo/j75D81/gJtGmSNnMQccUEKa1gotLcwOSSxbYdLc9rtzQX7NkSk8tpg2y62lNfFZKs7P5gnKW4q+E7JMNi+VaKXKVh1QzBvXvTEO7gK92Bp0EOEd6UqIJsgU4g3/H7NytKXEUDmwq6kV0jO1YWJhbiotx0boAsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOl5sH6ZRUglazCNGCNtawj52phnppDYr1ooe0Z6neY=;
 b=gtSR8NV9TuWLJFhitkQ1c81v5FWUnEQW2EXUhN0Hyl5qOVP5bi1qk2NyzP772hZX5QrOeV7RCik3mPQMKILb5dIEQusTagC2hKRyP5fJhRupTX/ppZTy+lgij+cQxlESkxQIlqP6mmdEWCx0/TnL5INtJ3OZ0DuOuEvqX2i+0/IzfxU/0TM158rZKhz/hJW/z2UVT8Z4BdJYQrIF0egNeZu5CfLPvD4Y2sIWkEXonc5vkB/XYdkA6vK3M2n43aPxyWl74j2fbDmx1Pc+hM0Ay2g3KsstssV/E5geoBHKcdGSHYaSm2fUsxf+eauehoddxefaT9gdaeNcbgqUeiAHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOl5sH6ZRUglazCNGCNtawj52phnppDYr1ooe0Z6neY=;
 b=gT7TLQESYhMu6vtbW5xlaaz6KaMb9MEU7fXHeQZ4eqp7o5umK/PhNPZePBoRqZAFdoh4zUxn5qWC+TDsQy9e/QjD1OP4b7rk9XOyEzC0F+NcuLAcRj0DtLkq91xepWyloe/QVteIdDq7SNGDYJvcnLD5yx0XXrOSgtlVz5WcOzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Mon, 12 Feb
 2024 20:51:51 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7292.019; Mon, 12 Feb 2024
 20:51:51 +0000
Message-ID: <4ba9e6e5-323b-4eb2-b0cd-d10a2f432fde@amd.com>
Date: Mon, 12 Feb 2024 14:51:48 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] x86/MCE: Add command line option to extend MCE Records
 pool
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, Yazen Ghannam
 <yazen.ghannam@amd.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1cf19ecf-4785-48c9-91ef-4ca3c965f568@amd.com>
 <20240212201840.GOZcp9IFKkmsRT0Sj9@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240212201840.GOZcp9IFKkmsRT0Sj9@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0192.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::17) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: fbffc669-ecbe-4172-c3bf-08dc2c0c7009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vTcJblV/pFSle8H8cRC56I3//QK3qVKWnBs5pPe3VOnQzOFMUKK5UbmZfuDlriEdC3D/ahY6/gDLVwQ8SreLU+LJjWzgBDno8CKFl37FDJgcwqNuDT5HZMbKsVuOAO7GwXY0CfLMvygSVDx6tpi6IXIphShZh+ANTmUjdPEg3ypy9O/csWRsvxn1MCQPO9DWLMSzUAldTJjQ6ytzX32EeeNZvE33R6P2YdBAegUoShJertAgNRMZQv56PCK6jdqHsJmEQnjDpyjjyUzTTOlvG55g+y7FHYiXUxEVeinRGwo6py2pKc9g31lIgn41vvWrND58YaJP9gA5UF1DwcBNjTD4Me6xocY1kWeBDDzgiYQkv/ChPn0Wp0TtfJAjqqNb2ZiJizJaF/gP6eCFzQt0vsMC2N76Iqz26m+bYGJlkDFnNWdfUGL4bWaiJDQZQQxlCDCPgqz94htf76BG0k8uf3iY4kLcSiIkSeu9YEG5eYChXxDQ4E3vHwqMMfn2uAPxuZLsFDn9k/IPOwDlB0pO7huR04kvgtEjtX5Z8iseVcuMJCW363tzqMuJrr1NE53c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(4326008)(8936002)(316002)(66946007)(6916009)(36756003)(66476007)(66556008)(54906003)(5660300002)(4744005)(2906002)(6666004)(6512007)(2616005)(38100700002)(31696002)(83380400001)(53546011)(6506007)(26005)(478600001)(6486002)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUpoSnNxcU5CYlliemh6QTMrcGlFNXE2WlozL1hDbmRlcGIwTFp0dGJpQlBH?=
 =?utf-8?B?RlBoeDZFY3hwYitOWXVVanVOR1JkZnhpbXhjcmR5aU9UN2RHOEprV0Nsd3o4?=
 =?utf-8?B?OUM4TEYvdFZxZDVNdmJ2QmdKQlpCdmVkQkRNL1BLb3Fpald6ZUkrM0JiV3kw?=
 =?utf-8?B?cVBUaG0rL0x5OGE3bUJXOXRqb2M1YkwzbjB4WU9EWnRpNjJVbWtvWmdUYmJP?=
 =?utf-8?B?OE9JdDExai9icGpZOHRVdm16MjhLbUg4alJYdy9JTSs5cktCZ2VSQ291ZWFF?=
 =?utf-8?B?Q240V3l2UTZyK1duYU43TG04Vm50eXhzdUpEU2VJQ3JFOWtEUlk5dXh0Ujg2?=
 =?utf-8?B?bzVXTW43NDBJbVdPK2pPWnNrelNGSHpFRVI5eEpYR25YWHllMlo1d2hXUG9s?=
 =?utf-8?B?SEpraU5VR2x1WmhEZUtJZExiVnF4YnlNbStJNDErekVCbmNuK1RhWUJGdkZQ?=
 =?utf-8?B?Mmo1Rjd0V0REbVRTRXhZYzBWVHhXMUVyQkY0a3RKYUJZemZEVDlkUE1xZTF2?=
 =?utf-8?B?dG1iYlB1cHRwZkR0OG5tM1U5d20vUUsxU29GakFTa2xOdDF1RmlnMHNUdXJo?=
 =?utf-8?B?WmVPNzA3OS9naEdtelRaUE9FdFRBRmozZi9abXZSY052UU9sV3FHeWdrdUhw?=
 =?utf-8?B?cWxUSjFlZ3ZReVpUWnBienNwc0p3ZTR2b0paRTkyTGNYUGtTL2VJcUNzdTdn?=
 =?utf-8?B?MDJTUXVnUUVwRStSRGozbUFsWUt5UmJMTmxzWmxpTkMzYjU2ODdac0MwUXVV?=
 =?utf-8?B?SUdVYUxraGhnUml3UFBtQ0lJVmhwQisvQ3B4T1VWZkVDbW1Nd1VzYk1FQmhD?=
 =?utf-8?B?dytLOWhET08zNnZJQTIyT3U1K3M1MnZuUjZuQkk0UVNISkQ2TXQwcjVXcENs?=
 =?utf-8?B?a2xJN0pROVdvOEI2azZSSGVFN1ZIUHNiSzBnSWVDQjk1Ylo5V1hJT1pDQ0Qr?=
 =?utf-8?B?QTFwQnFMcFh2RHIyeTNudjUwTVFJOFhEbmI1RlAwZTZDaEZCaCtWRzlPSVNE?=
 =?utf-8?B?QmIrVm1oV0VJSER3aXc4blVTNWZzaEMzMmh0SWVDVi9pK2xldC8zQ0Q4eFlk?=
 =?utf-8?B?MWpENGxBd1BHQnpUWlhOUDV0cFNibnJ2bkcxcXk4ZEdaNXRwUjB5eW5jdXBz?=
 =?utf-8?B?NHBHRkdvOUhCSUlaczk4NGdwQnZhUkVYZUhDbXBVOE40TGZkTDJLSEJLOXRt?=
 =?utf-8?B?MG9rdS93eUM5NlBqNWNPUTRmRDhDbmN5M3ZHSGNYQlZ3dXBSejgzUVpMRGNB?=
 =?utf-8?B?ZmJhN29SZWZDSlZUSU5VRk5nYTV2dXY0c1FXWHdaMWcxZFptcXVscitrWkV1?=
 =?utf-8?B?QTNsUHRVSHlrenNZUGpwZzgxQWhHQ01hZzg4elBNLzZQWDkzWkhMa1RjZDBW?=
 =?utf-8?B?Q0kyaTE0emNGekJPZU10cVlXdzFRV2g5U2N1N20yN0tZRlU4dmExTFJHQTVz?=
 =?utf-8?B?eUNqSS9POUVCNDZ3eWlSUmVzczE1RmFoanZhU0V4REJTeFVBZlNPL3czOFBw?=
 =?utf-8?B?S0FlWk41SFdOQnVLS3FGc05xZTh1ZGNrdnFBb3NsTC9wVTBVeXlIWisvTVRZ?=
 =?utf-8?B?S1psZFJleFM3VWdEWE83TjhkSGdMak5ianJsOHJ2dmlNTGVsdjRmdUZvTWFx?=
 =?utf-8?B?bnFkRFZjMzJQUUdHL2QrWEhQQ2hJYjBCdFVWUGJ4WHBMdk1scUVpQitBTkNL?=
 =?utf-8?B?Z1d2eUtGN21UYTJHdm9GWHpVV01VOWRQRzdUVGhKOE85d09iRGpZbTFCamNt?=
 =?utf-8?B?bnJPOVoxaVU0V3NFZ3ZwK3ZjQXFSVDg5UjAxQjYybE40QzR4N0xjZ2NIOHlX?=
 =?utf-8?B?VjJZVHZWU01IREFJTzJtdk9OQmhQczQxYTZyTFJvMUFFcWF5VEJjY280SG9F?=
 =?utf-8?B?aXV5U1lJelhXMHhxNkY5RVZpVVF3Y251QThaRVB2bm1Galc5WDliSVJmTHpz?=
 =?utf-8?B?UUlxdERLaVp3WkZSU1F2d202ZzJLR3dBT2kwN0ZGUW9ya21nTGRwd1ZWY2ZH?=
 =?utf-8?B?RHlGcW1DamszdGFHOFZIdmtRNXdXV1lKWEg3VlZ2bEdYL3Y0UVBMVmR0T3pF?=
 =?utf-8?B?Z3dvWlZES3NJdmNtbEVvbDI2RUhvRlBTdU11MEpTMHFtQnpaa1VQM3Vndnln?=
 =?utf-8?Q?MF5fUeA/LNGivpISoKPXpdom8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbffc669-ecbe-4172-c3bf-08dc2c0c7009
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 20:51:51.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDr6wTPeZ/qG6kTb0wsvi05HxAKxPZQ4wKndkFYkln2z/2hRff3CE3YiG+FU00H5ktWml+uUqf+qaid8lPNedA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

Hi,

On 2/12/2024 14:18, Borislav Petkov wrote:
> On Mon, Feb 12, 2024 at 01:40:21PM -0600, Naik, Avadhut wrote:
>> The spinlock is mostly held to prevent other primitives
>> from modifying chunks within the genpool.
>>
>> In #MC context however, we are not modifying the existing
>> chunks, per se.
> 
> What if we decide to do
> 
> 	mce[i]count++;
> 
> in #MC context?
> 
> That's modifying the existing chunks.
> 
> TBH, I'm not sure what that spinlock is for. See my reply to that same
> subthread.
> 
Yes, noticed your reply. Clears most of my confusion.

-- 
Thanks,
Avadhut Naik

