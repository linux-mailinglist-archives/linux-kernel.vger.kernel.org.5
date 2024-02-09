Return-Path: <linux-kernel+bounces-58991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2666684EF7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962341F2536B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444635672;
	Fri,  9 Feb 2024 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sM5w0Au9"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0575226;
	Fri,  9 Feb 2024 03:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451123; cv=fail; b=FJyLOuzklkewVDHzO8MswGt6D0E0nej7TD45jl7I2yCWfn3QOZwbIw6aOHnfIichN0HFnuE7nkc/qX6YHQc21KiBQiG7FD6eIIa/Y8QWuuil8+9fMktxMI88gbu5XhDvXd4FXgLoV/1p1G+oGa4TcOAX2C8YqQYv0EROi6UgnUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451123; c=relaxed/simple;
	bh=gR0cAV7bdeudI/2e5U+wCGwoziH737TCRS4+ZIzhC0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqGZWqUlcQNCGfLERKqiV4x40RcWgKKZRIG3pJf/PdynofQW0+295k5SMjoXRl6mJbv71t4MKbeGe5GDN1V8yoSsxnceqkfaKwoLJ3P3kA/aUO+ZX63NxM0kBPPL8Bgj6I32bYm5WAuNkTrOPh+G/h0JbfNpF6ZmCr0fryjSUWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sM5w0Au9; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJKb3QoVQVaZ1CzF/YO2SFyB6B12DEPq/BmuEI+uC6TP1YkPqomWorctAy7WTwVdR+/CItcWcO9ins5wZL0zG4NKEmqXUXoJlCT1IKF2uTNWT+aAajZnBVr00pPCfiYo/XOt+d9exi6e87j1yAUgN/khJsKFveOgU8tzQ9/WkbagTllKTI4O398wupEAoqK0b5tDoDXuEfO0Q13eDCu7w7PaSnPGkl3y/FM88fnLFm+fXBJMg2gGQaDJirCeeDYUZHeT95swLh2X9BtepDliWDY3xF4oUZIg2RfRVaIWWsDz3wp/svD0OA5khe5r+exhsyryXBbJNWuFEHbL3i0IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFgEiOMO/2f33Ir7/AwYIFp81Yxas9rZMtrC30uh6IQ=;
 b=g+gvHKaLc/EBD1+97e48fKUeMQXriaXDeez2lGA/YrpMQv7H0Ki4kwjpOzAqDCmPLmG4SuXwkBY2e9efw5E4i/owRc13gSdt1aPK1nS7rPmDx61pMmfkLEN5X1SIkCQJKJqAWosy0haLtotzLZ163Ncf/NFoSizd+Ue4vGhdIVlY7hr+XmiM6M1RnMvQ2eAtDcs+LyIz2Ge9vVp8cgjkLkTsPUrWKtzV1yGLJO0QjVbqlROwNzfV7MJlAVJMmjG+dlELvqr909ALBdXKMEp7aL/vW+WBBctOLM0ijWb1HLV2bMH/DlLgo4xBtPrF4ccht7Vf7CuGZQyPYFhVIRFIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFgEiOMO/2f33Ir7/AwYIFp81Yxas9rZMtrC30uh6IQ=;
 b=sM5w0Au9DO7mfjlWM/6YsnVwosXij4Ed8AfQKLq1pLZvisR6kRUa39pSPi69R9N3l6r2on3s9lAcPTtrhhVA3+Loua7wqGZwpp7tVo+bFR5azB1JrgHRHxM/6k8I+thByGjlPU7wZuNjVw+7k/ZtgzSZYRiGDe0OcbZUxpnXOaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.12; Fri, 9 Feb
 2024 03:58:36 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::f16c:d6e8:91e8:f856]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::f16c:d6e8:91e8:f856%7]) with mapi id 15.20.7270.012; Fri, 9 Feb 2024
 03:58:36 +0000
Message-ID: <266a5ecd-30f8-4450-ab9a-e4f239ad640d@amd.com>
Date: Fri, 9 Feb 2024 09:28:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next20240208: tg3 driver nw interfaces not getting
 configured
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, andrew@lunn.ch,
 Jakub Kicinski <kuba@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240208155740.24c6ada7@canb.auug.org.au>
 <ce7150b7-b6f1-4635-ba5f-fdfda84a6e2f@amd.com>
 <fd72544a-f3ed-44bb-86e3-bdfa4fca720e@gmail.com>
 <8a59f072-4a71-4662-bfde-308b81e4ce88@amd.com>
 <47987433-7d56-483e-a0fc-38140cc17448@gmail.com>
 <11baa678-8cbe-4a9a-af09-381d649d648c@amd.com>
 <aa9a3495-22fd-4fac-abb0-afedf1b4d8ec@gmail.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <aa9a3495-22fd-4fac-abb0-afedf1b4d8ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0eb352-2b51-436f-f1a7-08dc292363e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Z/oG3O8Q2x0JcNW+V5sLEDHnJ9H5iLt/+rw5I7mvbIZt9SGxKGLltI2jlLsuZQpg62LfvqaheZQ56l3fxHmxC6KH7loYD00J2AS5jAkhdxPIJjS/UqPmLq06RzJnNrnwoS4+qhOEkBAhDofLoZWutsXGdv1r+Ep8CdwS9Of84Czd0fKXJXIkalrOvAxObst+wSQkFcYI/UBE7I8Z7EWlfMd5a0qsmO6i3NKntHaMKhNj2QX/6Yh/Q+wKPJtUToPespz0FiUP190sGfv585wUEjszh1WOQln/Nm+iJkrrx1UM9s3UFgQA94zmrTpdDzMT4s507QIU6Vt2MXh8UlB47VPZtI6rX9kBXD3N48meVbmwZjjdDFLzAyt6SKpN9ve5iFDgxEkyA/yl2V9URHqJC8hhfguUx3ccGpxrxkFvnnufzCKGx9QapbU7PvlMHwkoNIWkuCXpcVvUCun+MDVUX+ZdiwWRpLFNeSpcsGIRDBYmatfj4h1DVAoy6eMGCTCV/Pk9whny3ZBKfeBQmeBGiGOFGZU+VhwA+N8gLdV3NM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(53546011)(41300700001)(2616005)(966005)(6486002)(6506007)(6512007)(478600001)(31686004)(2906002)(5660300002)(66556008)(4326008)(66946007)(8676002)(8936002)(66476007)(316002)(6666004)(110136005)(54906003)(26005)(83380400001)(36756003)(31696002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZWMFNqQU1LNWFjWDIrRDNmZElvNHN2MndLT2VjMTZUcEU0QUZSNUpXcDdQ?=
 =?utf-8?B?dDlKTXRYSXpNN1pXYzdpRkRhMVEzNUpnbzhQZjVsZENHLzEvS1R2V0hNL2RO?=
 =?utf-8?B?UFFTTms3bXA0SlFhMUpuenRaYUlpc01EZjE5MmNYa2VqWHk0ait2WVhZdzMr?=
 =?utf-8?B?dE51eE55STJJbjFsVnFKd2lmTWRTWlJ4aERJQnc0UGdmdkVRbnltbDJmYUJr?=
 =?utf-8?B?ekxOMVlRSnlwTnJKVVp0Q0JtenFTN3o3Sm8xdSs0MThIc05BNTlZZHdlTSsz?=
 =?utf-8?B?NWVZY2R2Qlo3SCsvVGlPbHlsMGFkV0JFY1VTc1o2N2lUZkQyU2RRTGIweHBZ?=
 =?utf-8?B?c01jSlRuYk0yL3RLeDhyTnl5dXhkTTRxemZ6WDhYVVhyKzFtLzRhaXVRTDl0?=
 =?utf-8?B?UnlGM3ZwSU1WWlM0emw2VjJJZzFuUk4vR3NKM3d4NVE5dHc2MmpnUUVVNVNN?=
 =?utf-8?B?QUgvUSt0c2hmTGI3TVd1dFltTTNoK1pZS24wOFNnNkp1T2R6UFgwODhpWmlD?=
 =?utf-8?B?eGE1eHkvVjg2TFBCemhxbHNGSCtSUjhwcEtkTmh6eDBwdTdKdVlQbDBXRnUx?=
 =?utf-8?B?THcxMFhUYXpqMWlsK2cyS3gyTDMvRWdLUmp0OWFrRlN6TFR6b1VxTWdELzc2?=
 =?utf-8?B?cnVRMFYydlJlem1JN201bERrWGI0ZXZ2UmY4ZFEwTTdaR0svanZ6STFhNnlo?=
 =?utf-8?B?MWVMTWcxQW85L1JzeXM4Ym9hUmtLTzcza25zb0RhQXlsa0phVkdqYkxzc251?=
 =?utf-8?B?Q0xweHBXR3VtUmVTb0FlYlVZeXdyTnVVWkJxdVJ0RGRyTFMzb3N5RkE2UlU1?=
 =?utf-8?B?c0d6RytYSHRNUmFubndBcnZ3SDFsVk85Sm1EbGRqRDRtdzZVckU2V1V5WDI5?=
 =?utf-8?B?VEhIcGVFYjFnLzJWMHFtL081TFZpZVhXY0Y1OUg1SWtlb2xYRlNvVklSSnR5?=
 =?utf-8?B?NzlsclhkOWlGcW5Hd1BOZWZRYjJUbGJMSVpuT2VPRzZmc2JEOHhheWFOa1pC?=
 =?utf-8?B?Y2lnZklhK0FXTm1Qamp4ZjRFd2IxcW9na1JYMTlvSXJnRlNzNFZpREc3WVhy?=
 =?utf-8?B?WU9VRnUvK05nZzB6bTV3MExEanlkVysranZZcVhZeWVJT2xEME1RY1FhVDM1?=
 =?utf-8?B?TFU3Unl2NlVvcW92NUo0MEFEMndZYXVNaUM5NmJ2bVd5dFhmVnhQOEIyREtQ?=
 =?utf-8?B?SndlYzdSSlpBK3NTVE54NTlPbkRnbU1TanJHWVBOaFhSUFJKZ1VxazIybXpp?=
 =?utf-8?B?aGgxTUlwclBDYURFR3RKc1c3ME5VNENlNUlVb0VmVXBMN3lUQnZyalJtT3g2?=
 =?utf-8?B?MHpNY0hCTGc2VGQzWVhSNWpxdGt1c1FBODlpTVhNc2hsKzVPYjJNZ1E1aDFT?=
 =?utf-8?B?bEc4a0ZNVWtlZHFkelpTSkhxekNqM2M1VjRBVk9ndUhPNmtDNCtJdUh5dGZx?=
 =?utf-8?B?ZXowcEJ5OGIzRTdBc1EvZ243RktQT1dQMWVTOEJYcTJ2QUhZbmxZUmE4WVRZ?=
 =?utf-8?B?cTVEZ1dRZTMrR0o5VG42RVBwamtMTWorbEl4Qnh0cUZDVkhEY21vYlRtWkU2?=
 =?utf-8?B?dW1ycWxISUw3Yy9wTnFnSFdlR2trdjdCUHZmdFN3bFl5M0hHQkRzZWpjU04z?=
 =?utf-8?B?aHpmcnY1WkNIemtZcFhvcVAzQ0hMbHk3cnlBb2wrb0JvVVFrR3g3TFIyWDdw?=
 =?utf-8?B?L1g0bXFGWkEyRkxRNHYvZUxEc21icEtodFVWQ3cyY3ZHNVRsRmpSV0F2dXl6?=
 =?utf-8?B?TzhmYjQxQXo5TVl2SW9sVmoxVTdJcDVvcnRpOXliem93a3lFTlNQcVZNeVlV?=
 =?utf-8?B?ZnRJeEdBOEV5Zk93T3plNWZQRFgvelFXWTZ0WDRJL09Ec2UxcHFhTlRmMk51?=
 =?utf-8?B?QmxRKzQwOXVVdEZ0Nzdua2xZemtMSnVIdmdVcnQ3emdTaTlSQ0FiNlo2WVNE?=
 =?utf-8?B?YlU4ZWdmUGdjYUFPUSszcERmZDZ2NkNHV3cxQnJSYzdDaGZSMjhIUlZSbmRp?=
 =?utf-8?B?RUlJV002WmlXakJZTDd6aEtkaS9IakR4UXZpd1h2QmkybkRXMUlRRlpsWWp6?=
 =?utf-8?B?bEtYTkJyZHRIb2RuTEpQS3VaVFJseTJHcXgyMXhCaCtpUEMvU1k0WjF3aUxh?=
 =?utf-8?Q?59IrZHCu8zNk84pGXNIo999FG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0eb352-2b51-436f-f1a7-08dc292363e8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 03:58:35.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k23zALlYwvNX+uV4mKSdxl2g2DXjEq8OD+xUWqlL+dgX06O+PF+ZvHxDPFN7iRP+xt8bgyO9lZA07T4HdQtvnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070

On 2/9/2024 3:48 AM, Heiner Kallweit wrote:
> On 08.02.2024 16:28, Aithal, Srikanth wrote:
>> On 2/8/2024 7:32 PM, Heiner Kallweit wrote:
>>> On 08.02.2024 12:05, Aithal, Srikanth wrote:
>>>> On 2/8/2024 4:16 PM, Heiner Kallweit wrote:
>>>>> On 08.02.2024 09:30, Aithal, Srikanth wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 6.8.0-rc3-next-20240208, the network interfaces are not getting configured.
>>>>>>
>>>>> Thanks for the report. Could you please elaborate on what "not getting
>>>>> configured" means in detail?
>>>>> - Any error in any log?
>>>>> - Any other error message?
>>>>> - Interface doesn't come up or which specific configuration are you missing?
>>>>>
>>>> I am not seeing any errors in the dmesg,
>>>>
>>>> [    4.019383] tg3 0000:c1:00.0 eth0: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address d0:8e:79:bb:95:90
>>>> [    4.019391] tg3 0000:c1:00.0 eth0: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
>>>> [    4.019394] tg3 0000:c1:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
>>>> [    4.019397] tg3 0000:c1:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
>>>> [    4.041082] tg3 0000:c1:00.1 eth1: Tigon3 [partno(BCM95720) rev 5720000] (PCI Express) MAC address d0:8e:79:bb:95:91
>>>> [    4.041087] tg3 0000:c1:00.1 eth1: attached PHY is 5720C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
>>>> [    4.041090] tg3 0000:c1:00.1 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] TSOcap[1]
>>>> [    4.041092] tg3 0000:c1:00.1 eth1: dma_rwctrl[00000001] dma_mask[64-bit]
>>>> [    4.077483] tg3 0000:c1:00.1 eno8403: renamed from eth1
>>>> [    4.124657] tg3 0000:c1:00.0 eno8303: renamed from eth0
>>>>
>>>> nmcli says interfaces are disconnected:
>>>>
>>>> [root@localhost ~]# nmcli
>>>> eno8303: disconnected
>>>>           "Broadcom and subsidiaries NetXtreme BCM5720"
>>>>           ethernet (tg3), D0:8E:79:BB:95:90, hw, mtu 1500
>>>>
>>>> eno8403: disconnected
>>>>           "Broadcom and subsidiaries NetXtreme BCM5720"
>>>>           ethernet (tg3), D0:8E:79:BB:95:91, hw, mtu 1500
>>>>
>>>> I am attaching host dmesg.
>>>>
>>>
>>> Thanks. dmesg lists no error. Please send output from the following commands.
>>>
>>> ip link
>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 2: eno8303: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
>>      link/ether d0:8e:79:bb:95:90 brd ff:ff:ff:ff:ff:ff
>>      altname enp193s0f0
>> 3: eno8403: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
>>      link/ether d0:8e:79:bb:95:91 brd ff:ff:ff:ff:ff:ff
>>      altname enp193s0f1
>>
>>> ethtool <if>
>> Settings for eno8303:
>>          Supported ports: [ TP ]
>>          Supported link modes:   10baseT/Half 10baseT/Full
>>                                  100baseT/Half 100baseT/Full
>>                                  1000baseT/Half 1000baseT/Full
>>          Supported pause frame use: No
>>          Supports auto-negotiation: Yes
>>          Supported FEC modes: Not reported
>>          Advertised link modes:  10baseT/Half 10baseT/Full
>>                                  100baseT/Half 100baseT/Full
>>                                  1000baseT/Half 1000baseT/Full
>>          Advertised pause frame use: No
>>          Advertised auto-negotiation: Yes
>>          Advertised FEC modes: Not reported
>>          Speed: Unknown!
>>          Duplex: Unknown! (255)
>>          Auto-negotiation: on
>>          Port: Twisted Pair
>>          PHYAD: 1
>>          Transceiver: internal
>>          MDI-X: Unknown
>>          Supports Wake-on: g
>>          Wake-on: d
>>          Current message level: 0x000000ff (255)
>>                                 drv probe link timer ifdown ifup rx_err tx_err
>>          Link detected: no
>>
>> Settings for eno8403:
>>          Supported ports: [ TP ]
>>          Supported link modes:   10baseT/Half 10baseT/Full
>>                                  100baseT/Half 100baseT/Full
>>                                  1000baseT/Half 1000baseT/Full
>>          Supported pause frame use: No
>>          Supports auto-negotiation: Yes
>>          Supported FEC modes: Not reported
>>          Advertised link modes:  10baseT/Half 10baseT/Full
>>                                  100baseT/Half 100baseT/Full
>>                                  1000baseT/Half 1000baseT/Full
>>          Advertised pause frame use: No
>>          Advertised auto-negotiation: Yes
>>          Advertised FEC modes: Not reported
>>          Speed: Unknown!
>>          Duplex: Unknown! (255)
>>          Auto-negotiation: on
>>          Port: Twisted Pair
>>          PHYAD: 2
>>          Transceiver: internal
>>          MDI-X: Unknown
>>          Supports Wake-on: g
>>          Wake-on: d
>>          Current message level: 0x000000ff (255)
>>                                 drv probe link timer ifdown ifup rx_err tx_err
>>          Link detected: no
>>
>>> ethtool --show-eee <if>
>> EEE settings for eno8403:
>>          EEE status: enabled - inactive
>>          Tx LPI: 2047 (us)
>>          Supported EEE link modes:  100baseT/Full
>>                                     1000baseT/Full
>>          Advertised EEE link modes:  100baseT/Full
>>                                      1000baseT/Full
>>          Link partner advertised EEE link modes:  Not reported
>>
>> EEE settings for eno8303:
>>          EEE status: enabled - inactive
>>          Tx LPI: 2047 (us)
>>          Supported EEE link modes:  100baseT/Full
>>                                     1000baseT/Full
>>          Advertised EEE link modes:  100baseT/Full
>>                                      1000baseT/Full
>>          Link partner advertised EEE link modes:  Not reported
>>
>>>
>>> If the interfaces aren't up, please try to bring them up manually and see what happens.
>>> ip link set <if> up
>> Nothing happens.
>> [root@localhost ~]# ip link set eno8303 up
>> [root@localhost ~]# ip link set eno8403 up
>> [root@localhost ~]# ip link
>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 2: eno8303: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
>>      link/ether d0:8e:79:bb:95:90 brd ff:ff:ff:ff:ff:ff
>>      altname enp193s0f0
>> 3: eno8403: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
>>      link/ether d0:8e:79:bb:95:91 brd ff:ff:ff:ff:ff:ff
>>      altname enp193s0f1
>>
>>>
>>>
>>>>>> I have 'NetXtreme BCM5720 Gigabit Ethernet PCIe'
>>>>>>           configuration: autonegotiation=on broadcast=yes driver=tg3
>>>>>>
>>>>>> If I revert below commit I am able to get back the interfaces mentioned.
>>>>>>
>>>>>> commit 9bc791341bc9a5c22b94889aa37993bb69faa317
>>>>>> Author: Heiner Kallweit <hkallweit1@gmail.com>
>>>>>> Date:   Sat Feb 3 22:12:50 2024 +0100
>>>>>>
>>>>>>        tg3: convert EEE handling to use linkmode bitmaps
>>>>>>
>>>>>>        Convert EEE handling to use linkmode bitmaps. This prepares for
>>>>>>        removing the legacy bitmaps from struct ethtool_keee.
>>>>>>        No functional change intended.
>>>>>>
>>>>>>        Note: The change to mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, val)
>>>>>>        in tg3_phy_autoneg_cfg() isn't completely obvious, but it doesn't change
>>>>>>        the current functionality.
>>>>>>
>>>>>>        Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>>>        Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>>>>>        Link: https://lore.kernel.org/r/0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com
>>>>>>        Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>>>>
>>>>>>
>>>>>> The same works fine on 6.8.0-rc3-next-20240207.
>>>>>>
>>>>>> Thanks,
>>>>>> Srikanth Aithal
>>>>>> sraithal@amd.com
>>>>> Heiner
>>>
>>
> 
> Could you please test whether the following fixes the issue for you?
> 
> The uninitialized struct ethtool_keee causes the bug because
> mii_eee_cap1_mod_linkmode_t() leaves unknown bits as-is.
> 
> ---
>   drivers/net/ethernet/broadcom/tg3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 50f674031..7d0a2f5f3 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -4616,7 +4616,7 @@ static int tg3_init_5401phy_dsp(struct tg3 *tp)
>   
>   static bool tg3_phy_eee_config_ok(struct tg3 *tp)
>   {
> -	struct ethtool_keee eee;
> +	struct ethtool_keee eee = {};
>   
>   	if (!(tp->phy_flags & TG3_PHYFLG_EEE_CAP))
>   		return true;

This fix on top of next20240208 resolves the issue. Thank you.

Tested-by: Srikanth Aithal <sraithal@amd.com>

