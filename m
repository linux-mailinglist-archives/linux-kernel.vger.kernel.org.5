Return-Path: <linux-kernel+bounces-67645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0881856E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66869B21318
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD4A13AA3D;
	Thu, 15 Feb 2024 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L3c21g8l"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FE13AA24;
	Thu, 15 Feb 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028165; cv=fail; b=i4N/c7hDNKkk3oPVQ3+AQp/Xy2NTO7YgKLKIK+BOnkZ+7NeWF+UmO4RdlwrH6x1zQtkQSOHI6z0uhmySRpVHsNtkS1i+6ePGONnwYKbLjw1WR8BOCqWPZc7h5Tl3gleZliHCCAtK0iFmZEq1/h9B6tEvq9CpuwWzK90wNqjVb6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028165; c=relaxed/simple;
	bh=VLuGKogg6vZ5ltlm+eDWrqyIKj3YO1spWkLamf3g/t0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pu0o/ro2sdbS3+3KiX+2ZdyJ13//3PU4M4wVe9kd0ebvzChNzQ3ppT7LG9sfQyUhZQFt9Ex6puUazjsemsiAHh8kceYxBHOWuYRrd4giwDVcRcMLHAkJ8Wjy86gwUTXqyUUjv+fJYiGqs1ftl20peOqWa8L2+i5wo85H+82/9/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L3c21g8l; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH9X/T2xUR9WHFSN3Cw0e9jYT7VS2zAX9pCsqCTuRZWIItY+QwJBPyg57vK8W0VMVdmahEmlpKGqwk/WMf4oDUYgZXX9kAXp4k5jnNVD/Mx1UzEVpLtbPsb61e43++Ek6+jrD6O8XGYQuO4UcXq9RSK0vPw7IVITok4BLDJpdB3zQicvHfEXX91sLurtnd0yaaeT5xlN0OtV4zhf5M7DmNQ1//F151tKnJXQ854ZFJpHk5FS8xRCJcFLMfRCoovZb+Z1PTK4jjGFeEmEneo0jKerlpylEPgXJ+YzPotV9tthRokmsT+4UrpWWow0gvTHZ+4a0BF/x5PBah4IwL3UYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGNI9LPxynlihlanyVzIOZjQdDp2/MOiw1DQ4t4q0uo=;
 b=E9EK4XLsxTai57Z6YxJnxggEXHEBxEYg3C8S7gEJeM7JSnX65WCRBQDBnDjLL0iAyZUXFH2g8C6Fr99/bULTUG9RzrsFls1svTv6m1pbWEYUQqx04P947p/KVvktYq/eu5AI7TRq6/S/yRl0fuPJwKKIRcMZs6bLKjfPunYRhvtkBsUWnp2a1vYmvnAFGZD67iuxGJcHsa2DFHNgDHLAC4wsRXa69pJ47N1rR1O288qXGXRuY8ED2r7/1/q8tR4LcOjzAKkvvDT9c//gtVdNjGr6tz6Xrn5hDdHVrkC/sEOYFiZB9ZfR2fag9epTi+v/DwVM8kedBra8cR37ttAjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGNI9LPxynlihlanyVzIOZjQdDp2/MOiw1DQ4t4q0uo=;
 b=L3c21g8leOLOJTlIpO/rn5YDRJJ/M+6WD5gDgBtUInhIVulLGyG5tRQbBBxmqaisuiE3N99NdGcL255B3R2MHBaQZfDHp06ydh7ChJjNgzgQyqloBxZdLjo8aricDuF2SiYfryYSNvxBQuqHNOnFBGt94NYy0M4/bpD2h7xhjKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 20:15:59 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 20:15:59 +0000
Message-ID: <e3814f2c-0aa1-48e7-8122-e2c5154a3f0c@amd.com>
Date: Thu, 15 Feb 2024 14:15:58 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] x86/MCE: Add command line option to extend MCE Records
 pool
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
References: <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0103.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::7) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2a0737-21af-4b6e-d2e5-08dc2e62ec89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	68IjOOjWMNNokowfPpZ12EXl36MdgYCU9Pn9mf2mb6qxFpkX9hO7Vir/4YVaA//pLaPxVQHHu9w+MjjkYuR83fSZc5fAspfWjDMkHVbBrXdJW1G4Ghm69QnJfUeML1O6icQkZZ2zu+Wlu+Fa7hOp16H5zN1ThfboRYo3pSN6kk62mk10VqEagJVH2kRF6Ls1srkOKIXII/4lkRVz20WCYv20AeHZYtO9COazcN8PZ6srWzXHaiHG3vjMeP69XWiBVVIlOWC89lg6zcHhxByMHrteyFdM1iuxlGelH2efToX0AbdEYO68RF2Uvo+vf/LRgur1fB9MzwLletpgEGtYJxy3//+qO9dCiQJpf/R8567qXD07QTw+uKtONSgKSrJbopCeNbtFnutieWvOkmMHwMt2KHjBXx3AfKJ6k4VdYQsZHfwjnffgSm6CwPZrt0B7N6ZTaP+JhyNUdegTzZBZQap8WKqguBsZnPWvq/2gPW6anQiXvyF/VqklFJvrdwIYNWoHwKL9oCrBEPx+a2aQyc4K8tNJ5qsS2PlS4DlX4P2GthWWGb8O3BWlNYUT2Zyi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(6486002)(6512007)(478600001)(41300700001)(8936002)(8676002)(4326008)(2906002)(53546011)(4744005)(5660300002)(6506007)(66556008)(66476007)(66946007)(54906003)(316002)(6916009)(31696002)(2616005)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjBkQVdMZDBOdXIrN3V5bWdqMUltSTVOQzczVmZzVzgzbDFyMUdDU2tBTTJh?=
 =?utf-8?B?OWowa2FXV3hBeEUxMVh0MUR6VGdWUlJFNzN5bFV6MGU3QU9JYTBMRWtxVFFH?=
 =?utf-8?B?VTlaa0Z6QjI4QjhGVDJZcHJ2L0NZbFBkNWhSdlI4WTZMakJOSDRHYWYwTERL?=
 =?utf-8?B?VE03SDhCMlhjR29JNDJIam1ORGVPVzU3M09TK0N6eUxUNEN5Yzd6aWpZejJP?=
 =?utf-8?B?d0dwMzVDOXE1TzJrcXJaZC9PZHRmY0hBd0xYbE9iN1RQNTdZOTI5U0Q1YjdR?=
 =?utf-8?B?YmpPeE1jU2ZrL2h2WjdMWC9Xc1FaSzNudHcxeE5lL3RRT1Vsci84OGcrNUto?=
 =?utf-8?B?MTQyWDNCMXl3MC84WituWHJLZEhuN0JqMUVNeXFNMmc1N3ZBRW1rZVY3bmky?=
 =?utf-8?B?V3MrTjdIS0ZPOWpwb2E1bHByK2poSmI0OFFMUkFjd05GQjFDZlk3YjRkNWsx?=
 =?utf-8?B?WElrN0ExUUwxelRCYTlQT0RzM2l2bmtGQlpZcUZEMjMxaTRBUW8vVWF5Z3l1?=
 =?utf-8?B?QVhicnhMRm45QWUwQXJESTRyTUxtUU05UVY4OTFKdU5Mb2tNNnNwb0dkRmFj?=
 =?utf-8?B?Ty9nMmx5ZlFSS2R6Yk5kSkI3RmpmV0tGZGZsUS9scXZtMXJCVWdxOFFYUW9x?=
 =?utf-8?B?emd3WTlNRGFEemNXaDdzZ254aE84RzNRby9relgvZGhaUVhkUE5rbjhTV0J3?=
 =?utf-8?B?eXBoeWRUMjA4MFE1aWNxcjBOeUUwVjYyczBVTmJEejl4N0NDRVRiMVovQ24z?=
 =?utf-8?B?S2F0RjFVVTVLak9YUjZXdit5N21mWFVTL0U5TUhqSjgzVzJ2WGFvUno1VDE4?=
 =?utf-8?B?b3RwblZDU3ZGUnZyVlYrSU45R1lIMlhwNjZWTjg4SUZ1aEY0V04vQmw1cjRG?=
 =?utf-8?B?UFJPZlVjTXdqYStidDhyOW1DVSt2Lzh6dFUzanNMZFB4QUZKMy9jcm1valM5?=
 =?utf-8?B?MGRLNnJyYk9KUEk5SUJBbjVqdTc2QlI1TkMyMkpGSWFQM0pRc0xIYkRZSG1u?=
 =?utf-8?B?aTZZUEdlZjVwNUpmeWJnU3hRbFB0cmtpVUZYZHpvSHRtVGoyaGk3VmRJdTFP?=
 =?utf-8?B?bWZXS1dHUmpHZHhWRDJ5OVJRQVRLdWo4U3R0SmkzanFvSGNFVXU4THFNUkVv?=
 =?utf-8?B?cEFVQkNmVGxkZ1NUeWFCdEpwdW81U1JpNGlqclgvanVCVHVWSCt5Z1BJM20w?=
 =?utf-8?B?RUZhNDNkWG1tMmE2eHk5ZTc5NWNLbVJMQnV2aW9HMXZ3QXNENXhlMmZTckpT?=
 =?utf-8?B?Q2JVNm92dWkxYmdUQytUMHIxd1VSZXRzVTZna0UwREJaYklpVXZsU05RWjl3?=
 =?utf-8?B?ZDhlcWN0cFpWd1lpWnhCYm1IWFVDTGNhMFBvd2V0WllyVXowaTMrRjNhalln?=
 =?utf-8?B?UEJXa2FxdEJBcC9ic0FZTmxJQUttWGFNNE12MkNOelRSb2h2N3NPQVAwLzhK?=
 =?utf-8?B?SnluZ2dwMGNFNUx0dVR6V1lzZ2NJVkpCczg2VGlNZnVydGo2dmE3ank3bFhu?=
 =?utf-8?B?UTZmQi9ub0dVWkRiME8yWHI5b3ptRnh2TUliQWhhc1hoNDlQbzkwdjIxTXZC?=
 =?utf-8?B?MGh0Ly9Qem5BMXZuVnZISHdUamZ0blRzSm5xclRaODlRRDQrWmRZa2xsOUt0?=
 =?utf-8?B?ekdzTnlWTlc3KzFKcUcxMVdlUjR4Wkk0b21CUm9GMWUxeDF5TitpdGFSWTRN?=
 =?utf-8?B?REZVOWVia3N5Ulh5eTVLNXZpMjZkaTFEVXNrWW9ZZ2FIeURaWXZLbEhOOTdn?=
 =?utf-8?B?MGJOTXhiOGtuaDc5RDU1ZmdjVDZ1TDU0SHlRMllCY1FrSWNLd2hZck9GU2Jj?=
 =?utf-8?B?UjJaNGNsTWk5MTFwc2RRM3cveG1FbGdKYlB2N29CZWZqbXBKZDYyakYvcVA4?=
 =?utf-8?B?VzVGSWIwQXhGS2FJYzRzekdmVzh6UzU3VHVhVWI0ZjVzb3dTQlBxQ0tTYjBo?=
 =?utf-8?B?NlhhcmNtd3lXeHRENnhFaGo3bDIxaTFIQnJlZHMyVlMxMXptY1MvMVp4blFs?=
 =?utf-8?B?WHQrUXBUczJyOXU4U1dreHo0SVEzdXYwd2s4RnVXVHVqOVIzVU5ldU1kT016?=
 =?utf-8?B?aWFkT2kwZ29NN2g5Q3FTWTI2ZVA3dTJxdW1lREIyUFAzR2dhRm5TZGNZMmVN?=
 =?utf-8?Q?3D8KrWhZKENmnPL7V/DmPYoN/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2a0737-21af-4b6e-d2e5-08dc2e62ec89
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:15:59.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzFNYb9/9kdBpeLrwPy+tp9JAMW+ZNxiB/TDQo1LggzdoXVPC/apGecBzyf+5t0yd5C3oUBXxrpDXF8eq262Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111



On 2/12/2024 03:32, Borislav Petkov wrote:
> On Mon, Feb 12, 2024 at 09:58:01AM +0100, Borislav Petkov wrote:
>> * Can you think of a slick deduplication scheme instead of blindly
>> raising the buffer size?
> 
> And here's the simplest scheme: you don't extend the buffer. On
> overflow, you say "Buffer full, here's the MCE" and you dump the error
> long into dmesg. Problem solved.
>
Wouldn't this require logging in the #MC context?

We would know that the genpool is full in mce_gen_pool_add() which, I
think is executed in #MC context.
 
> A slicker deduplication scheme would be even better, tho. Maybe struct
> mce.count which gets incremented instead of adding the error record to
> the buffer again. And so on...
> 

-- 
Thanks,
Avadhut Naik

