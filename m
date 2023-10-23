Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49677D2CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjJWIgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWIgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:36:54 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8C0DA;
        Mon, 23 Oct 2023 01:36:48 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N5tqed028191;
        Mon, 23 Oct 2023 01:36:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=message-id:date:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=k5Isls2LwuH6PwbDTXiuNYsuSi+s0pUZalH9mJraDdk=; b=
        LuI6Bp7gsIxshgOPv4fhq8cqD0JQmuxVUDrPEiyK66UIrQR68pPFR/0sxDNdmkq8
        d0xPj1FVqEm/FVrQRWlmswLcCVhqDSxu9rSdmdb+zQCg8Fmhg7pdlkCSsvJlRUEk
        X+ZbguWx6ukPeyk0QvZMMB3Sl/saHNSzlKMiJFnyWkIvfAA4BmacNIQt4wBKrjHi
        yoGyERvUWKa66aIJfxmiVt3lCLU8vFuzQZQXe39Qt9mkcR6ubs2w9/VlqMgrQ+yN
        NpBHzaZfTN10WYurtYQoTJTgRt4bJHvo2EbAHMMk/en9/5RYR6BEUIuZuK7jXvhh
        CeFPlTrIrrQoylL+GJzD2g==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tv9x01kgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 01:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEdcQlaEV6VimuJKnl42hvRbrvkY3/ZBQTJXUNXgL3A8YLD5/+ctk80B0wF8doGoYynkqR+XBpyOvm0uIOykqtjlHDScDjtIQTVDZgo2h3iOMAwiCKJteJDZEHj4F+XWdohv/9YB4qsCsr0OhiXL7xJ/c+ikyDz4sPP+JEJAtyUjDKB3+xrFZFaGDTphY2Z6vXN0olEEmTMFjGAoa29jxLEWEa15G8Jx9RyKtHW79RcDoGajmjO355eHNQQmjpJvrf6cKuJ38RDKpBj/twF9kq5Wl647w/wrdvJw93r62yEVDhxriLBPSEsEnXL+GU0DkhkoY+mlFkARhtDq9yvcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5Isls2LwuH6PwbDTXiuNYsuSi+s0pUZalH9mJraDdk=;
 b=AdGHxuSfuBwJLI18tvWYgbCUA2pU4dxgxXWydz4bFsElvvm6iK0ZZIae3E04ck/EJ958zK9o8t+zOFEhnLXicaejmKVaOJDJB0pa/eoQSTCzdpWL4Z+q/UwoBsUIUybP559/r9fZvmZFrUiIDMDzMEle7Zsu2Sz6NlZ0qR9p6cETBuOcBqMbYWBxCw+MsCLbm0FPHsf82//D6/8GUWDV7XI2e4Wsynx4nvYLLuuaOO047HnbitkRLyIm2hK1IcjuqfDlcdriF5gHcEwsfaxvYdQ4jPWqz2zwlMUj6Y3ih6qT2HS+APF1Ze3sKT3sHIse5kOfPrfpsYFvjdraSJ50Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB7738.namprd11.prod.outlook.com (2603:10b6:8:e0::6) by
 PH0PR11MB5110.namprd11.prod.outlook.com (2603:10b6:510:3f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Mon, 23 Oct 2023 08:36:38 +0000
Received: from DS7PR11MB7738.namprd11.prod.outlook.com
 ([fe80::1ca3:401e:220d:23cd]) by DS7PR11MB7738.namprd11.prod.outlook.com
 ([fe80::1ca3:401e:220d:23cd%6]) with mapi id 15.20.6907.021; Mon, 23 Oct 2023
 08:36:37 +0000
Message-ID: <9dd0e0b8-751b-170a-7c8f-bc084efae69b@windriver.com>
Date:   Mon, 23 Oct 2023 16:34:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: phy: fixed link 1000 or 100 set with autoneg off
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d7aa45f8-adf8-ff9a-b2c4-04b0f2cc3c06@windriver.com>
 <c23dcdb0-f493-453d-82b9-b498f4d3c88b@gmail.com>
From:   "Jia, Fang" <fang.jia@windriver.com>
In-Reply-To: <c23dcdb0-f493-453d-82b9-b498f4d3c88b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To DS7PR11MB7738.namprd11.prod.outlook.com
 (2603:10b6:8:e0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB7738:EE_|PH0PR11MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: e090b9e9-7c1a-480a-0e8b-08dbd3a32b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIP8wST7JmOJAkvAVW7QDjVQlUbHVZeWSWnYj2Uuw2QGoly30NHmJlkPAwbr+kFMSAv3HguwQf3BGtsuEal9ApoNcmG36qXGr2CFkGY1bauzYpvIbD2m7T9kR9LLeNB/kZwQCCD8DJogwjV1J24xcOOf/ar7D4Z2ccVlYMap0k/p2WKZXujQN1K1icua5KJLnVrOyaa7wgLUQPHGqbqrasaJLaej+gh1NHOXJhYZU7N2XoU/xUNxSfI/KYPjBdgSGC1rwEGgxe14m9MfW2EXputRpA5GEHtRhtaH2MQ6uBwBk6eDHehnPg70ySjcGDcsIiWUwkiFyOsHuOxDOX5ukU4jZNsLHxa/+SIEIF1q1ihITmQFGqOF1Ap8HkycD6JJfNcNF9/i1ZxgszDRJD3tgb6jV4wIM15JCfLnzoN3XpCokhgOPf5fCX1jAIF2DIsaRcYSl6HM1LgXULHF6t8MTFGF2BaJLmN6oEh8k1mYgcXN91VnTcMdoEp4fxHaSmzYBhPuINxAV2dTLuWB6eHR9xTX7+55C5KC+7mMGR3wHGcEtGDmBSLHU2zsSvDHQwB2+4fJ03b7IXhcwz65+3RIN0jqBkn3pQHqyclL5cqE4SoRZiakXRtVx+Uj8PG/YXJrw6nhaBx/A0pD9Ir4UkBQwdY7704XAbRlA6zpYQZKqR5govF/pMwmwNOPxUdwpVmV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB7738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39840400004)(366004)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(31686004)(38100700002)(2906002)(41300700001)(86362001)(31696002)(5660300002)(36756003)(8676002)(8936002)(4326008)(2616005)(478600001)(6506007)(110136005)(66476007)(6666004)(66556008)(66946007)(316002)(83380400001)(6486002)(53546011)(6512007)(221023014)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVc2Nk95Y3VjS3FpaWVzMkVNaDVSVEo4ZTRVeGdGdWRSZDRLTGE4OUh5cTlJ?=
 =?utf-8?B?cllydHNnZXoveEwvVEVzQ0N6NnV4UjBRcVRKR2hQbHRRZlBkRzdKTnpvbFRr?=
 =?utf-8?B?MlYzbGNOUWMweGpQRXZZUjFQS1JHS0pIVUNVWU00d3A1SW9FSERCZTkvRGh1?=
 =?utf-8?B?eng0dUMrNWdVN2prd3pKRkZabTRveWJkaENMYi9nSjIwMXNydnhKRjFCZlkv?=
 =?utf-8?B?c0MrbVYzRFJ5U2QySlVIMUUybzNLbkQxbHRRdytQb0xGSlZ1NDdsS3dkSE5v?=
 =?utf-8?B?REdHMWVpYXk1L0JRbnE2M0JYeEh0NHhBRmhYbUYyUHFKN25VdUJhRzREMDlh?=
 =?utf-8?B?ZUtURnRTN1NnYzhKN2ZQQ1VKZmZrODl2a0N6T2FYaS9PMldmcTREOXZxNEdB?=
 =?utf-8?B?ZWhFTmZKL2NSNWtTcFFLRTBac3djS2xLcjF5aUhkam55c3MwZmdaSGhNRVFp?=
 =?utf-8?B?OCtWL0JiQXE1c3NLN3pqbkVlcHRzZDBhSEFTclY1NGxLR1pxNm8vMm1oU3pM?=
 =?utf-8?B?Rmxvby9EUXBhRGp5TEg0cEhEUExHRU9sdkphbThrLzdSZDV2Qzk5bWFWUjJv?=
 =?utf-8?B?SDk1cDNWcTdNcWJlQUpPYnZyODdpanN3azlYOGJTeTdwQWNmQXZjTHRRRDFO?=
 =?utf-8?B?ektIM2JuNStXTEt1blk2ei9mTGVNVy9ZSVBZRlNJWjNOamxUcDhZTUJJR1RN?=
 =?utf-8?B?MmNEQVNHYWZ3bTM2Ym9wQllnQ2ZZaXljZzJxK0N3UGdGV1VraStHN3p4WXRn?=
 =?utf-8?B?dUlpZmhpS0J1YkRqSnplSVkvME9qUklGdTYzRkJnbnkxWTZuQ3NaNlkvclR6?=
 =?utf-8?B?ais3UHkxUTcxSy9DdG1KbWlpelIyNFZDaUE0QmJ5S1lSeWY0blUvQS95S0ph?=
 =?utf-8?B?UkZhNkQxNjRPb25XUjJod0pXUzNrUnBmZGNXQks2eUdsa3lKZlk4NXhXT2Jp?=
 =?utf-8?B?OHJMSGFJRlpYb3YybTZOYzVkaitsYkNSQjQzbDhveVNPblNsUVBKa2FjUUlI?=
 =?utf-8?B?N25lV2Qxd1JRdktacjkxbWR6T2tzdGxjenRYUkFOVmoyQUlOalVjazZpNEs2?=
 =?utf-8?B?T3J3eW8rWmZHaEpOMG5lNW1GTmtnOWRUZnBFamJSc1RIK1ZrdDJHd3dETkdm?=
 =?utf-8?B?ZFhkTStmemxJeVAvZlZZalh6MEIxcjdyWmdUbnlqVGFYdTh4dC92eWlZaVZH?=
 =?utf-8?B?b2w4dDZncTRpeHhZTE1SV04rcjRjaFA1REh2dC9IWmJEWXcrb0QyZWdjaVI4?=
 =?utf-8?B?VlVZeFNURXp4dFZIV0lkWFB6MEYwMlVnWDZmeXlMTENXemJJaVR6Y0lsQ1Zs?=
 =?utf-8?B?TjlESzlqU0dBdzdUQmdFOUdzNjlnNnJKczc4V3ZhRnZWeTEwZDJDMnZlZ2U3?=
 =?utf-8?B?bHNMYzh1VlJIQURyWFF3QWIyZEdNWjJwaWJIZzVFLzFUd1RLLzlLT3U2ZGU2?=
 =?utf-8?B?Y1lPZTRjdXc4MUxJc2c2YmVsbUZtbnVCR2llQU16d3ZMUzFtUVJ2c1BJWmN0?=
 =?utf-8?B?UVRFNnE4KzdIN2xSYTBVN0llbmdjN0FPa0t3Mlpybkl4V3pOS3hzTEdIZHBB?=
 =?utf-8?B?Zm5oUnVUbXZMOGxpMjNyTkQ3Y28wVWRxQWk2NWV4ejc5UHRXWkJLVnplZkdN?=
 =?utf-8?B?N2dUeldXek1SZUhOaUtMUGJOOGRYL2xvVk5Eay9oczB5bDFHSFUwd2FBUSsr?=
 =?utf-8?B?VGlqSWZtYW1ZUWhUQ1dxamV1NEZtb09taWpGaDRMeFBldXduQ2lHRXpTd2lJ?=
 =?utf-8?B?WHJrblZvaVd4YmFYb1Rma21LK1E4VGhPVVM1alJ4WkYzZ29IMVBTa0xuTXZB?=
 =?utf-8?B?N1NmT1hvS01zeFZYSDd4S01DNVcyWmVRVFBOaExLZHJNRHVQbW41M3ZPejh3?=
 =?utf-8?B?eXozN3ZSMTc5Tko4RjhRNmZURXJlYUE0YkV2R3Fadml4eisrY3FOZm4yalc2?=
 =?utf-8?B?TER1QWp5MUZWS2d6cGc3ek5YeWRuWi96elBpcGxnRDR6U25NUVYxaFRQNjc4?=
 =?utf-8?B?emNCdkFZOTh4S3RQMFZ6SDdtUGd5OWVkUXQ0RXJlWGFQMmkvaVdDRE00SjRD?=
 =?utf-8?B?UnRPdTdKNkIrZFpYMHZJbVZTVXZmcUhsbXR5cTVRK2psOFptNnpQTGVrcG40?=
 =?utf-8?Q?cqx6splIHWnG/HEMGlBj3uVj1?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e090b9e9-7c1a-480a-0e8b-08dbd3a32b16
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 08:36:36.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kakpv+u9w+9AUB7XCSWFntvcVncENO1lkQng4ZD89ShEURcXStfm8/p6ZjI1Y5Nuo1dxFbp6JMBClWsTkc5maw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5110
X-Proofpoint-ORIG-GUID: TnV1QcQege-vIycx8zk7ppeeeFQp6t2h
X-Proofpoint-GUID: TnV1QcQege-vIycx8zk7ppeeeFQp6t2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_06,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310230074
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/23 15:52, Heiner Kallweit wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On 23.10.2023 09:01, Jia, Fang wrote:
>> Hi Experts,
>>
>> We use NXP LS1046 board and face an issue about the eth interface speed.
>>
>> 1) Scenario
>>
>> we set fixed link 1000Mb/s in device tree.
>>
>> However, after we set the auto-neg off, then the eth1's speed changed to 10M and Duplex changed to Half.
>> The value of /sys/class/net/eth1/speed is 10 and /sys/class/net/eth1/duplex is half
>>
> Why do you set aneg to off? Leave aneg on, that's the only supported
> mode in swphy. 1000Mbps requires aneg anyway per standard.

Thanks very much for your reply.

Actually, due to some reason, the phydev's default aneg state is off.
And we just found if use ethtool to set, it had the same result.

We also found that when we set speed to 100, same result.

So we can assume that swphy only supports the aneg on, no matter the 
speed setting. Am I right ?

> 
>> 2) Log is as following.
>>
>> # ifconfig eth1 up
>> # ethtool eth1
>> Settings for eth1:
>>          Supported ports: [ MII ]
>>          Supported link modes:   1000baseT/Full
>>          Supported pause frame use: Symmetric Receive-only
>>          Supports auto-negotiation: Yes
>>
>>          Supported FEC modes: Not reported
>>
>>          Advertised link modes:  1000baseT/Full
>>          Advertised pause frame use: Symmetric Receive-only
>>
>>          Advertised auto-negotiation: Yes
>>          Advertised FEC modes: Not reported
>>          Speed: 1000Mb/s
>>          Duplex: Full
>>          Port: MII
>>          PHYAD: 1
>>          Transceiver: internal
>>          Auto-negotiation: on
>>          Supports Wake-on: d
>>          Wake-on: d
>>          Current message level: 0xffffffff (-1)
>>                                 drv probe link timer ifdown ifup rx_err tx_err tx_queued intr tx_done rx_status pktdata hw wol 0xffff8000
>>          Link detected: yes
>>
>> # ethtool -s eth1 autoneg off
>> # ethtool eth1
>> Settings for eth1:
>>          Supported ports: [ MII ]
>>          Supported link modes:   1000baseT/Full
>>          Supported pause frame use: Symmetric Receive-only
>>          Supports auto-negotiation: Yes
>>          Supported FEC modes: Not reported
>>          Advertised link modes:  1000baseT/Full
>>          Advertised pause frame use: Symmetric Receive-only
>>          Advertised auto-negotiation: No
>>          Advertised FEC modes: Not reported
>>          Speed: 10Mb/s
>>          Duplex: Half
>>          Port: MII
>>          PHYAD: 1
>>          Transceiver: internal
>>          Auto-negotiation: off
>>          Supports Wake-on: d
>>          Wake-on: d
>>          Current message level: 0xffffffff (-1)
>>                                 drv probe link timer ifdown ifup rx_err tx_err tx_queued intr tx_done rx_status pktdata hw wol 0xffff8000
>>          Link detected: yes
>>
>> 3) After code tracing, we found that:
>>
>> phy_state_machine()
>>      state PHY_RUNNING: phy_check_link_status()
>>          phy_read_status()
>>              genphy_read_status()
>>                  genphy_read_status_fixed()
>>
>> In genphy_read_status_fixed(), the speed and duplex changed.
>> It seems like the bmcr value is always 0x1000 from swphy_read_reg().
>>
>> After revert the commit 726097d6d6d(net: phy: improve auto-neg emulation in swphy), then the Speed and Duplex shown comes back to 1000M and Full.
>>
>> Could you please take a look it ? Can we revert this commit, is there any side impact ?
>>
>> Best Regards,
>> Fang
> 
