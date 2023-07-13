Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3126E751F50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjGMKur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjGMKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:50:44 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E2212E;
        Thu, 13 Jul 2023 03:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6gwOx+0p4qSs5l4AjQ0HdxlIsX0ZmSJ1jFy9PZ3EKPrJuREEM5wYjcp97SW9tGybLdCBTNvtgUgWMXsv6am2fPWh4Ogvc0XS+3YkfAoXLjKKboGMqCqwSN5uusVdoN7FvDC7f3hLI1y4Eri+XJ/pod8DqJxiwl12tA1ya/oxtP9P7qMPvVx31u+twjT/zeULVyU3+TNAqYxHxhRPdDgy66fD/xPEkykpJHAXdFNo2ErdH+f5hihBECeYs/oNE+taywEVTyvZP+lqw03rvyaWS89QkYB6MLiecTIKG9p/sGupaj1I9LeHE7PU4IHN8WesrVDFN5t57FRYa4U/IP4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ywgx8Q7KKH/r5gChabpjyx/6aoONzFmYWXAV+5oY0+c=;
 b=b+s2dWi116aMxI9ED7EhBqyn9GxGUZMlHDdjCmz5J5+QaT7ygjCuDFfCYdM630NMP34lJhNG2V6YSO3vTKFJx1iud9696I7zYDIRadRa9IsuDuwqpSNCzRyXXr8wSNcG7e3E41Kdk5ARuPIh7J+0tE2DIW+Cf8VEfXNqeKWTSiQHZfACBHVjiUTc5Hpr62gcp1TDsJM2EG0Ea2DjJ0ulQv3drybLzSE8AndqrUTY29p5QtlFLK59cOORWe6lULIdLK4OB2doZkcnqcy3hSjmDfDilx20/L265UWm/o06UQ/R6DAu6KjjVN0tjkvPJ/FjBBMwoDv5W5Ex+Itrxpp80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywgx8Q7KKH/r5gChabpjyx/6aoONzFmYWXAV+5oY0+c=;
 b=UHeVPMEwTq4KbU1h2XmXc+YEbxR6KqdZF7XsJ3bh0hbA9Z9NC3rwVqSZE2YFcd20sp+xgAKfhyMZy39+gJ6kF991J8IeRu8URAea28kybcIS42jg5ebbZBWlLuAHvascraa+z1XpqpV9LQJSE4IqHdX9OvuBIizdwZoPTRibglq2kXBuOG4rDzZP/CBRvLaVL3B7ePxkE6CxcqS8qSp9n+m3XTieEPwr6PkJnCa3zAIWQkWfUU4Q8xjzklNemOYtZiBSqhGynwzX6x88l9iNPZKKPiEQMVc8Y0SToun6lYmTPyussH0EJDUrKspW+tYpJNQ7Smo2JrXTCcmZXEZU8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 10:50:39 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9df7:40a:ebff:8332]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9df7:40a:ebff:8332%3]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:50:38 +0000
Message-ID: <4b17be94-d068-f026-756f-59208075e254@nvidia.com>
Date:   Thu, 13 Jul 2023 13:50:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        g@carbon.lan
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
 <972a06e0-6841-043e-fc00-db7596f664c4@nvidia.com>
 <cskolyrp3s47gnn4nwtqpfxtafzhpirn3hv7ovhnnzpbb3ll2z@oum3v3n7go6l>
 <6dced1ba-c468-c88e-f861-9c202e803894@nvidia.com>
 <eadl5bkyysdcymgy7ra4hm6cqn6ngcxbyvz2qzg3fdffsssnpo@d3rzegyurzn5>
 <6fa5ec73-e6c6-cf8e-b11f-1a57f0fc34b4@nvidia.com>
 <95210a8a-c70e-c312-2c47-4f5ee9329586@suse.de>
 <bd7c91c4-9528-aaeb-9789-03191dc7761b@nvidia.com>
 <875b1903-bca8-8c6e-79d7-506313bbd56d@suse.de>
 <mf3lgyy6qivmeb5ut7jk3qllyzz7hdrmqstz5phxseygj3oc34@sdf3ilsivmbb>
 <hxhltswufzzm6dvittjxp7r6hqdvoxa4t2kxpqtmqqcgfefze6@ind4yf5oifj3>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <hxhltswufzzm6dvittjxp7r6hqdvoxa4t2kxpqtmqqcgfefze6@ind4yf5oifj3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 8748bab0-31de-459e-ff0d-08db838efe8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PaOu1Gv8KhWwVJu1ElV4hOsfQtr5W/cg0Bo47BEnc2G7FaqixwACL8CeF98bs2CZPZCnkDaZol5j2c/w3BPsiZMcSSZ5JmOGMgxII6t8Okmu8nfzDQbFqktTpKbdPWgIr8GHsNWfO9dXgaRK61iIaZkVnmFcoJ4qrkS80vhIBJ35VWfMItANf+sRmUkLSOHExZ64ccTkeyfh4T//8lSOXJibmWqF+HhNh3Y1aWt1g9sQFV3gLqiXM4uIXF7IpwPYmPRfFEWXVbhZOfquRjB7zMu70sNiWJDXucBH9cqThdkWHbY3YRr1hmos4hfjehc+S57jJ/iP1qht+2/R/KO3Jp0qNx3scXuwzmFV2t7zhnd1ksqrGiQcExG2gSbB+eCkv78megnvV0es8Zt5Cfb62orADwZy6LgJgdCd+Uxm/sHFqDh6U/j1bF1d5i3FZHOLUCXYcBDMAW+o3gNmqOXBmD8zFgobIt2mTJfukUd7dHcXJ6V4oUvOcdJ1FG5aY91zAM0rAprfs2Dp00em+bqgtZgwum+hLI4IR19IDW7reo+LVkt1zf/1GKRsvqhzdhNlYN2Zbv04d2j+Lz2Y9m7ArQC5R4KcHrmVLmRNy5FOaig8VqRwEc2DiiClez8hExRIx5/CaW5Sjo9zPkkm1SrVjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(8676002)(8936002)(53546011)(83380400001)(2906002)(4744005)(36756003)(2616005)(38100700002)(86362001)(31696002)(7416002)(5660300002)(6506007)(186003)(316002)(110136005)(6486002)(66556008)(66946007)(66476007)(6666004)(4326008)(478600001)(6512007)(41300700001)(54906003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0VqZUJXME11Q3BqN1ZiMTEzU0VwTU54MG91R3htbjFVSkEycFA0QUc1aDBq?=
 =?utf-8?B?a3lYemN4c25FbnFvVzFVME11NWNSVVpZY0RseGRKbU1EZ3ZNQ3NRWGJVK3BR?=
 =?utf-8?B?WFpoenRrZnZuYVJJTXNsLzRUd1lhbVpNU0tvYkZqNlNFcnlSekxhdUJ0RmlX?=
 =?utf-8?B?bnlsRnlURjhzSW5mcUZYZC9WU3gxTHRscWxpWjh3Y3p5T0VMRjBGN1lITEpY?=
 =?utf-8?B?RnBuTFdwcXJ4OEpxdCswMmpyZnFNMDczU3czK2gvWC9Qc2Z3R0FjK3cxc3dV?=
 =?utf-8?B?b05mYTJkMzcxU0syaUQ1QlNNTFdCUWtHVkp2dGhhc0Fxc25ja1JRTG1rR3Fo?=
 =?utf-8?B?MDJtMWMzVnhEZnlDNkdKM245OFdKZEZnZk56U3BKQ0RnMjYyZ2ZRakUyZnMv?=
 =?utf-8?B?ZFJBM2FQMVhYSGN5UDVRczZWaXMwYWE1d2c5Q1dWM1lDZ1R0Y2VLbmpoWTl6?=
 =?utf-8?B?UFBWQThBMGdVZ0x4cXFETTNXTXphZllTVVg4STRTcG45UXpVQmpKL2lBbEhS?=
 =?utf-8?B?WVVpREFQNmxsdWswSmtaT1pZNFlxbStTSzdhL2tZUnpVQ3BXYmpORS80U09q?=
 =?utf-8?B?a2lnYXp4TW5OcGFZOWdtcmtpUGx1bDl2aWFWTjlwNjBSZVlJTDlYNm1STXNR?=
 =?utf-8?B?Ymo0aENzVVlsS2VVVmVSTVJuVGx6aUtZdnB0YkJBRFhDR3BzTmo3SU9WYXdQ?=
 =?utf-8?B?cCtnZGxlYjZ0YkRmbTRUK3VjY3FoWWFkaDFlVjluM242L2RvcTVQV21LVW91?=
 =?utf-8?B?TlBteVhhR21jelFqUStJbm1WalJHSFFENjVqOHdWNDYyS2J6S1JFVExTQVJl?=
 =?utf-8?B?czJoS3ZsOVBPd0U0Z1VnWUpGNjNobDNFb2VSc2wxWThoeTRERmpPMzlFTjlS?=
 =?utf-8?B?SGRNSFI3V3RLYVN0a1BoSVB5QVFmVlVWMXRCbVZ1eEt4MWZHN3RURVFuRlRk?=
 =?utf-8?B?TUUyOHhhTEZ2RmxnTjh5dFVSV0hoZEUvYXRrR050WnB0RVlPSGdHeVFmZGhJ?=
 =?utf-8?B?Q1dVME1OVGJJWnlucXc1ZmptQnplVVU0OEMrT0txN1lja3pmbm9RMmljU3Va?=
 =?utf-8?B?NEkwRStDY296YjZHTnBucmRYZEpoNzNjcU9lTG1icGVpU2FhZkkvcUU0aXAv?=
 =?utf-8?B?di9UbkVNUTFnbVppTlVidmcySGdXYWZXRHZ4ejgyVnp6TFE0dFNQWklyYmg5?=
 =?utf-8?B?RnBqeWxzTHdyNktvWHpMV0xZa2dwSWdTWmx3QXg4UlVLSys3N1dPWlBEbzRu?=
 =?utf-8?B?UUNENjBPa1FKSlY1eWwyVlFxL0loU2gxd0dTenc3NnBYbmtIRHZTNnc3cXFF?=
 =?utf-8?B?cHFUdGpsQ0ROQk8rRDNxYWtXelNYVTdQZmJtRlFuN0UwblBYNGcva3NFMVNV?=
 =?utf-8?B?LzdLbi9tRDdtMEh4Yk1kWDRKSWg2a0dwUFBQNy93Y283RjRRbmZtVVgrWTZi?=
 =?utf-8?B?WjdRN09YczRqeTNCdTZlSmxxazg2aFFrQU9wSldvczVWbUo0cStmVXQyY1RB?=
 =?utf-8?B?UWdZV3RVdjNjN0pKOGtQVXlnUGNic3JQdGcwNFF1bWhHV3VxeTY4b1Z3V3FG?=
 =?utf-8?B?enQyTFFTVkFzMjNKVTU4Mk8xYzdMYUJBTitON0hxRDU2R05LN2xQQ3M4RFBM?=
 =?utf-8?B?T0tRMGowT1BrNHRlNXdmOVJqd0RmRTBQek9tRWZmOEFxbFhLRGNJL2JTQTNM?=
 =?utf-8?B?blNNYUl6ZWJmVkR5VHFDMTVQb0I4N29scXJXWjc3UHBjS1VlOGJsT2ZmOHUy?=
 =?utf-8?B?WXhPRHN5eW5GeTZaanZDTjl4NmFhNU9tbUN6Z1lXb2xvcFRaNFZqZXZjVGIv?=
 =?utf-8?B?VWhUbGhwbnRKMlBmNGQweURRYTlpcFJzaFF2ZDJSVTNKNHJ4eGlsSlJuMnI1?=
 =?utf-8?B?Q3lhenY1TUdtS1RpakNvZ0pRVHNOOXNPWkx2NnFZOU11b3JGQkg5RllGQU9s?=
 =?utf-8?B?WUN0TXlPZVpraFM0c0p5bUMwTWhMdkljaUl0RXFnREdYOEE2dkhPUWd4SzBw?=
 =?utf-8?B?eGUvKythWkF0d3NUZXZNSC8wT1VjQnlBSTNRSE9wcVRjOFV0ZmlDeUVmMkdL?=
 =?utf-8?B?MGdsVCsvTjRsa254YzVodllCS2ZmYllwRDhWcnBJWS84cWpUeC9MV1lsVjUw?=
 =?utf-8?B?UkR3ZUxqV2djQXBUN0xCY044ZUtuREZnSGE4V1BOdmlBc2FPOGV4eDlURVpr?=
 =?utf-8?B?QkpPNHgxVnpOOFlCNnhFZkI0cDdFMHoyRG9VM1hMOUNvMmxpb1k1UUtoMGZI?=
 =?utf-8?B?c2xkMExmaHVwVEZ2dEJteTAzOWZnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8748bab0-31de-459e-ff0d-08db838efe8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 10:50:38.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjrNXVt5jN1QZgI5sviDvO4NH157vpRpd6PdHHsOf36VqUVI3MFiYHYFlY7jatqj8/7ST8IqU0s1H2MuqLTmsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2023 13:44, Daniel Wagner wrote:
> On Thu, Jul 13, 2023 at 12:30:45PM +0200, Daniel Wagner wrote:
>> On Thu, Jul 13, 2023 at 12:14:14PM +0200, Hannes Reinecke wrote:
>>>> Exposing the subsystem is from the target configuration side.
>>>> Additionally, the --context (which is in the initiator/host side),
>>>> according to Daniel, is there to distinguish between different
>>>> invocations. I proposed that blktests subsystem will not be part of
>>>> discoverable fabric or protected somehow by access list. Therefore, no
>>>> additional invocation will happen.
>>
>> I am confused. This is exactly what the whole --context thing is.
> 
> Ah I think I got it now. You want me to set allow_hosts on the target side too
> :)

Yes.
With the unique hostId/hostNqn for blktests this should work without the 
need for --context mechanism, that was probably added for system 
administrators and not for unit_testing/QA/Verification engineers that 
run blktests.
