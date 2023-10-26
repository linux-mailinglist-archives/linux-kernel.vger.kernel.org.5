Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41167D7AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjJZClq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZCln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:41:43 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C42E10A;
        Wed, 25 Oct 2023 19:41:41 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39Q29Z6Q007229;
        Thu, 26 Oct 2023 02:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=message-id:date:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=Lx70rg4dfiuQ6UAGRnbIRsNCFqQ2Ng+aqMZMzvbz6Pk=; b=
        bgzVpAaSc3C7SsFf6VDbLMzbQWREm9RQRbdhZUlO/zisADo2C615sPLawSIhEj9W
        BE2KsrebfVG2DBllPaKxrZlvDyHq9mS+SJQDdJkDlcRxnAt9Efc0OIFlZy+Hb2L4
        AZouRNeqI2QFa7LnBUjx44ILVUscNJyYfTg0aJFMjM8A11uvpYgv2dQMSKM7ukUk
        ZF4KMcZUl0v4vmQBHk/N3RTXF3cokQ2tXCIVJ4IIzvLfBuqGdiYSHqNybkw1+dL4
        Fkdk/R/0dzjdU9yMrm/tTFJiaAdsDFOSk0ndcVblla2t9Sak66fJ04/uNoE9DlbD
        w2pifDcrZWGwvdR1D47gqA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tv5m5w82u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 02:41:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpU3+Byt09zipx6iTG45xieKv9sE/Ng21+FmliRpc51WLoFgrIBQ4FazSgxjyLGetJ82hvfiiejfDRqjZeQ4Wq1YPdAzuZFrMVwdfHHL4h9OisDmOF7Olmm+Pf1EnxSKz5KXGltrOcrDLQsEC3R00gwj6nS6aV9yfKUb+6MMsx/0l0jowj9X8BNJznXnmSQ+CtiZ2OYldmSUOfPkAf8WRLZfxDA1pEN77iVanR1hlwfSrTMCnBBzSpLa1fC9bIR8TIb9mN8y+ebMckQITgH9COSqmNUTayuRelj2M/cSTaVNZP7b+e14N9lb23egxXiCh5NsZyRjok18NMmnAuSAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx70rg4dfiuQ6UAGRnbIRsNCFqQ2Ng+aqMZMzvbz6Pk=;
 b=BkUQAwHAC3BIEgQbRQlgORuvhXFXPT3cvypL+BSoU/Eu7vWMPbsVPOFxVwgl3SLtIdlAPOrQetzdYeQpVd3KtLVLruwmLw3L5gp4cc8lRt0LMVDWEwk49L2YkMyisVZVIieRC20V73wZcx+4VV9DLUMKc/1UPxedkqU2vk+Hfnm+ymfcGkyZoMX1Cigs9LRN28/r0HYQzVSP3LUtcLbBMh0o8nSVL2RcpSvvjuPktOBn8xMviAXmsmc097tLWyafPcOPGcML3DhoRb4/++S3AHtpNbcEuybTNGnzm+UP2E+gT8pofX+/Xdumfl0ktpDDICVq5b7i1PUyyz1jEL5j2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB7738.namprd11.prod.outlook.com (2603:10b6:8:e0::6) by
 CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Thu, 26 Oct 2023 02:41:33 +0000
Received: from DS7PR11MB7738.namprd11.prod.outlook.com
 ([fe80::ab73:148d:46cd:bf37]) by DS7PR11MB7738.namprd11.prod.outlook.com
 ([fe80::ab73:148d:46cd:bf37%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 02:41:32 +0000
Message-ID: <19a2675e-928c-7986-95d5-b05a09cf1120@windriver.com>
Date:   Thu, 26 Oct 2023 10:41:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: phy: fixed link 1000 or 100 set with autoneg off
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d7aa45f8-adf8-ff9a-b2c4-04b0f2cc3c06@windriver.com>
 <c23dcdb0-f493-453d-82b9-b498f4d3c88b@gmail.com>
 <9dd0e0b8-751b-170a-7c8f-bc084efae69b@windriver.com>
 <dfc37ead-2abe-4053-b0a6-911c9c387451@lunn.ch>
From:   "Jia, Fang" <fang.jia@windriver.com>
In-Reply-To: <dfc37ead-2abe-4053-b0a6-911c9c387451@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To DS7PR11MB7738.namprd11.prod.outlook.com
 (2603:10b6:8:e0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB7738:EE_|CYYPR11MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: 733f087b-f165-461d-b357-08dbd5cd1059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EA1X+8bgbaCR5aP9K39GLcPMv3hHGYQ4IMa7pEvdU2xe5Jzc9CKs9Ei4e4fzMGWfa1f6soqjbEldb0zPxpxsSdrnXzuxKLRdgSKLhxIrn0Jv5XCKzQzivCqcA+pBZV4Qkw/1gEGaRmFioLnmMq5ESIJb1UDOEhG37mM6TMyz85jTt0P1667b1Y6HKaiWVXPiWNm42h8rf4EuB5x/13v2AbkpziTxoV2KrjPhJhLJKq0HysMivtY9obRpvfiucPkTaKKn6dAqynKrrQl80MdVFS8ykR2/I5m/r1I8qGte8WA5NscKwZ83UG8SgDJvuDs4WQuNrtbmp20OHJ6L/6nLxXIpExdbqaL6TbCAptRj4x8o3Nr/2VvVkVwEfI5HDsE8AEvbfi1hMeoDXPqP3n1qj1NH5+xjwH/gbhUmv7LlmRz6HmpviJdB4k5LHZ8W+pd2pP6cb0NRxYl5KrtCfgc+nH5axH2Ql82+7PzKMjQNZNrT9weNK1aZqTNTmBf7FS/28cnDU1OsVOsJ24IbE4Slh+oBQfB5KJEPzjGq0fazgdO9bHVEa913sbcHDB93bXGXfcJYU8uzRYzdBrw/Av/Ch46APKzQMjhbikP922ON81aIRFfRAVFUSyHIWFU4nsDeGDnZkhA7sZ4ffgA1Po3TV1JsMQp4vnN4DzyvUvJ3yokhJRDjZlXNZ65jdtFPsZ9H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB7738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39850400004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(36756003)(2906002)(38100700002)(6916009)(66946007)(66556008)(2616005)(66476007)(478600001)(6506007)(316002)(54906003)(6666004)(6486002)(53546011)(6512007)(83380400001)(86362001)(31696002)(5660300002)(4326008)(8676002)(41300700001)(8936002)(26005)(31686004)(221023014)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eStHWXFldk1iSEkzMmdSNnZpU2hXQUpUZElDb0dXRjlvVHpOZ0t1UFNJUTFK?=
 =?utf-8?B?dHlZQUkyTW5VRUQwRUNJcFpkV05WMlVySnN0S2FrbTZzd0J0UGF0Wi9Nemp4?=
 =?utf-8?B?UU8xTUJPVkdMbzByekJvaGVZdVpwb3hvdVFRR2tOSU1OOUJtdkE4ZERSNTZI?=
 =?utf-8?B?dzB0bVg1RlkrRzVSNGtQSGV0V0NNWTZwS3NGVUtzRjhIV2MrMTJjeHVSdjc5?=
 =?utf-8?B?TStYYVM2ZVdTRWJkYVdxWGxUamdVN3V0MVJVMW1PSTAzOTJZVjFCeVFpOGV1?=
 =?utf-8?B?S0VkNDIyRVM3b3htRlU1ZnM3eUtETnJsQUlLVWFZRStZWVQ3bk03Qm1xdWh2?=
 =?utf-8?B?dUZQNmdHbUF1MlhnR3NIdXliTXJORTZxY3JDTmxwSTVhTFV3OHNsWXhGUG1B?=
 =?utf-8?B?T1pFcjlZWHdCRmVTa25sLzBsRVhzS2ZDWHBmRU1tUUNKcHh3ZktlaGJTK0p4?=
 =?utf-8?B?R0ZQWGs0dEFJMGZJclFWdlJnbXZYaFlpYU1ERi96MWxNN1E3czNZYXl6R0RD?=
 =?utf-8?B?b2VjUFJsd0FhMjRsaW1sbnkxd3RSMmdZM2NrQlVYU3lLaW9KcytrdEFpcUlL?=
 =?utf-8?B?ZlNHb0doNDdpQnhpTS9TZ0VJeERMWFN2QStPK1BUSER1UUp4aHNpNTI2blBP?=
 =?utf-8?B?ZEIvQTBwSERMTTNFWnFNbS9SYmdJNGJHUWZKaVlYM21hdi9yWXpFRVJRMzVN?=
 =?utf-8?B?cnZ4YzJZOEF3M21jUnBOSWFyaktObWJqZUlYUmFmcmhiQVN5SGZmRFZQVG41?=
 =?utf-8?B?bTBCNC9HVFVkVWFscVZZaTlnV0JmQVNrbEpRc1BCdkZTK2ZZZTRTSjZsY1ZO?=
 =?utf-8?B?Mm1hM0J4d2R6Z2lBeVBQNmtGaE85K2RPVzdBMnJ0RGRXdis1eG8zNzBMN1NK?=
 =?utf-8?B?ekdmcGNhbWpJM2NjcXRDSUxpNjJ3WUpPQ3BoeUpyb3dxZGtReTR1MXlmYXpX?=
 =?utf-8?B?eFpZRlhIUFdtSEFlR2t6cUhORDhtOCtFNW1XejVJS3JzZGxWM09uREZ1bTVs?=
 =?utf-8?B?akFPUTNaLy9DalBlVGREQ0Q3aTlwZE1iMWpCZkxnL2g1alZXbHlQa01Tc0JL?=
 =?utf-8?B?ZTUvSWlDaDBwNzg4WktwUTFnaDdWZDBPQ3pwQ21UVURlSCtUM1c0Zmdaa1dD?=
 =?utf-8?B?MEhRdXV1NEh0MDk3UmxzcjBKdlo2S2tEaEdTa2FYQ2dodTJiY3poemJteWh2?=
 =?utf-8?B?VDdhYVN1WTZCeWF2cWJlT25HTHlFejloTGxHSGFUcmp2ajB0Rnd0RmFPaHhY?=
 =?utf-8?B?czdqbURxUWtZd0hyTit4T1hsYjZ3WC9xV2pTTkozNzJMVm8xbW05b2U2MnhY?=
 =?utf-8?B?R2NFSHNlNzhSRnhWdUcxdUpUQVByT3B0WURZM1JmODNVOU5Xd1ZnblBKUWxE?=
 =?utf-8?B?NTFzWlRVbE56VnNIUWNEWUNDallURVJ3cGk3dkZEMGxBclRwTnFZOHV5QUps?=
 =?utf-8?B?OTJlek5IeWZHaWp3a0c1bVU5NUJqK0RTeWJGNXlCQ2FFa2tuKzQrVFlsVGdi?=
 =?utf-8?B?djVhUzZ2TUNReFRPQzVDNUtna2JLWUdicXYwaTJQQlZGb3V5STc4bTNhK1hR?=
 =?utf-8?B?SjNXNXUvZVZCYm42V1Mxd1Q1Nkg0U0h2ZGtraTNhQ3hrYjdadnJZNmRidEoy?=
 =?utf-8?B?RDViZGJpT1VoRTMxRXBHa2Fkb0FmWXlKNDRQU2JISHNkNWFBR0lFS1V2Tzg3?=
 =?utf-8?B?ZGsvcmoycGhTeEZ0N0tuQXdRbERGVlllWFU1SUdudXorcTVkODdmTHJ6U0Ft?=
 =?utf-8?B?QWJsaFhVRk5XMldvTEQwTDE5b0FGY1ZIdmJscG04TlkwQXBXdG1nM01LMXIr?=
 =?utf-8?B?UFdsV2xCcVE4cngxVlJrNXNzL2dES0JRbEJkckNyaVNRMGlwV3U3RXcrOENn?=
 =?utf-8?B?V2I5bUVKMG92em8yV0ZjV3VRTmUyN3lZZWhRRjlQVTc0L1NyRXUvWEpTVDM1?=
 =?utf-8?B?ZU5VWHUrY3lsc3NFVUFqKzF5VVpPY2FYem1UK0ErR1NtNEZzVGFsejBwQ2pp?=
 =?utf-8?B?TngzUzFJOWx1NUxzT1cwRlp1eS9JZktOQnZaMms1S3J0c3RXM0lHQ3l6QUVG?=
 =?utf-8?B?R1pscUFpM2xnOUZVbDMrUFNVcGhYRDJWVlRYOUFGeDVSYkR1TUUxVjZvVE51?=
 =?utf-8?Q?YH/KEezLpj6uWaXx/cKGU2E80?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733f087b-f165-461d-b357-08dbd5cd1059
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:41:32.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP3QCNPyTaFtSwXryVtOOtzT03MkYryCJGRnFw0fk7ZEVXwMVJK17rjSTEtElxgvZiLaEBxNRSX869qiS8KNpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-Proofpoint-GUID: -bg2NsuLZuwqRUWx7TnH70DY30QXQoUV
X-Proofpoint-ORIG-GUID: -bg2NsuLZuwqRUWx7TnH70DY30QXQoUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_13,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=571 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310260021
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks very much for all your reply.

Do you think is it possible that we don't ignore the speed and duplex 
settings in BMCR, but we only add the bit BMCR_ANENABLE in BMCR ? just 
for example, return (bmcr |= BMCR_ANENABLE);


On 10/23/23 22:28, Andrew Lunn wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
>> Thanks very much for your reply.
>>
>> Actually, due to some reason, the phydev's default aneg state is off.
>> And we just found if use ethtool to set, it had the same result.
> 
> I find it surprising it defaults to aneg off. Are you sure something
> has not turned it off before you look at it?
> 

These days I was trying to find how and why set to aneg off. It seems 
like due to "the some reason", we have to do this.

> The emulator does not support writing to any registers. However,
> fixed_mdio_write() does not return an error, it just does nothing.  It
> needs testing, but maybe try making it return -EOPNOTSUPP. That should
> prevent auto-neg being turned off, but it might also break everything
> if it tries to do some other write during probe or link up. It could
> be it needs a more select response, allowing writes to some bits, like
> the reset bit, and start auto-neg, but not others like disable
> auto-neg.
> 
>          Andrew
