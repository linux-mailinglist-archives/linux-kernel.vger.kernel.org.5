Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121D47A74A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjITHql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjITHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:46:15 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8703E1AB;
        Wed, 20 Sep 2023 00:45:37 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K6Xio8018438;
        Wed, 20 Sep 2023 00:45:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=subject:to:cc:references:from:message-id:date:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=jlGY+9Vpy1tQG1Yw93ooD3AWCH61LXY3do9FOoJlQ+U=; b=
        MG6KiNf036fZswn8ui0X4VZlE5Znzw0nthFSTdmRCIPyl5k8YukZdytDtNXw3dFX
        ytp0L2zDYAvBwRZCoqTWtG4wLqIU263jgoxZXEwcYCYbltANnS7ocRd1bC1Jltue
        IJUU2qznCOiPKQ2MqGPxgBseuYYZ132YpSm9MkdtjXD9UzxcuYg7/ag01X3PPBaB
        Q4ghMbOxMH+spZBTc3zsKzs7qBdNHj9BCtg2EmYwSajZod7+/pkyMVzLjuBep3zR
        xuK6LYPEzyfcJCOR40G9H1cnWfrU13CWMw8i2/LSKQ5xOGJon3TbTjLn4KpfRsTt
        mwlTsCNp704trsFXblb9yQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t57n0u42k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 00:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTX1hQ5ZOb2KBDYvbe7d5OpkmK6YuP2ArHfSMlCdAoYvWgDCNGngb1jyssd+8GwSrBk07B2RlEKlfzUxqqnkXRbrrzgK6Cf+8K9ySzoAjenSZcRtiwKzYdK9V8aQQjgs1Q26pXv3TgSYd7bohLT+vZXn3aRzNeDBXqTtqaykOXQknZog84pgbo5tEHjoMimJlsaIK60r1w/J6uGkQHIvP3XHdsgRVD2sMtfKSW3odpsTDl6MLzyDI0UnTJnf11mYqz97KFqntmfUNiCJqzsehEaVD4tksIVKoTfmfE9LaPkR6nlApmmI7SNTFdzZ8zss2dGMk7HLKh1cZ2sNHX4TZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlGY+9Vpy1tQG1Yw93ooD3AWCH61LXY3do9FOoJlQ+U=;
 b=R4IiiAW5jwzxF+o8XNuKluK/OI/GADzg5F6GIPBfmvV4xxnqSXWTXq2qOmtolAfo1vH+qqrPM6ZbWUTiaCJ005jayfk5aT9pJ1sAvjqE0/jlATdymJraaOZXZoFBHdugfbp9y3OVDj9b1CSL8QDCNV7EUboHvsh74sGqjO72N99j6F+PYzgi/J7peDDFjf5rA7h2dnhKwM3gUD08gg2Q0mYUpCr8UYO3OHjOoJV0YdKOpRyqHGq6shyUNG+7WIzLd8gNopmcpv1XOgEMCSGbY8hH1OJiwUyX+N9HovugFVDwlaegFrKTufCf/MJdgdk4oiUxtsv23i6eTGihpF8BTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by BL1PR11MB5464.namprd11.prod.outlook.com (2603:10b6:208:319::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 07:45:22 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:45:21 +0000
Subject: Re: [PATCH] usb: cdns3: Modify the return value of cdns_set_active ()
 to void when CONFIG_PM_SLEEP is disabled
To:     Roger Quadros <rogerq@kernel.org>, peter.chen@kernel.org,
        pawell@cadence.com, gregkh@linuxfoundation.org, pavel@denx.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230912064946.1405848-1-xiaolei.wang@windriver.com>
 <65ddacbc-7094-5038-bc13-16bf209fc954@kernel.org>
From:   wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <6292cf55-af7a-e746-d6fb-b036c2b1e82b@windriver.com>
Date:   Wed, 20 Sep 2023 15:45:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <65ddacbc-7094-5038-bc13-16bf209fc954@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|BL1PR11MB5464:EE_
X-MS-Office365-Filtering-Correlation-Id: f06a5aa1-5c69-4734-2394-08dbb9ad8a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BrwsAoyU4yaCPEaCFsceloEZvuhmGXO4YjiUzice5MGUFZVINTPcgFEYH7MN4A5HVAupZv9KzjWRxwyOF7cQNYPwFsbl/ENL/EvYzD5hWSFvyFWqzA6e0uPbPiqp4LYLX7Rm5SX81wiT6MeidFpVvBCoyX5L99R92j7ZTMf2xILgaVuvNTSqOBU7KxR3YErypETyjniVX34uSukXkDyXJ1ppAJYPHbEGbHVm76WqmKiuN8q/6CZEeEi8bhaNsiaWaQO9tG0F64HCMcoF8wBnpFuBO/J5DGBp6S6tdggRGNrIf765BS0+vMMp3Y3qZpfixhSOF2zlNuRLZLhOKBI5ZYu/7SIaNI43s6IKWO/TrpikIrXCb3f2tohVFOUVYANxJdRweLOU1Z6xtUeIwYpGWSliuF5eFO8BEdBhU+lo1dadzmuj6bL/oiAq0D+mIs3lFfibK6f3wM323rDrCNwE/KEEEDTb432w3l5+M8wP4YAj2/vlxxaLo44CCcAhTJRAS6fF6lnJgjhX2HGV0U1k0sh9w+Zr0EwtAQcDDAVQADwl3tXXlhx2bJxWEySQqcAbs0hSAzqwpvtboC6o/RzKaq1pY0AcXUNMA8JzE+pTkVOCGDXhKeWXEQIWcBI5uSWHbvk4965eZXrRSOzMfG89SaQtVxaBUx9g5Rwm5cNhSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39850400004)(376002)(346002)(451199024)(1800799009)(186009)(26005)(2616005)(31686004)(83380400001)(5660300002)(66946007)(66476007)(31696002)(66556008)(8676002)(8936002)(41300700001)(4326008)(2906002)(86362001)(38100700002)(966005)(478600001)(316002)(36756003)(6486002)(6506007)(53546011)(6666004)(6512007)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1ERVJOUVN0eFo1UDVmYjNwcVBSR2E4ZmJDMDVWNmpNOEJJbVBjemFJRU9H?=
 =?utf-8?B?M29EbFkwMVNyT0pnbzFiVEN6L3UrenFmb1p6Zzc4WUFpR2J3YXBFZDc4RHRR?=
 =?utf-8?B?bjZxNGRMWU1jd2UrRG8xNVp5SVVsbGtZTmlCZ0pjVTZWNGlpNUJvcFlCTU1y?=
 =?utf-8?B?bWU3NCtPbTFCT09lK0VUN01sZFZoZ0d5a1BSamFnSTlzU1JlVnhIR3JhVGtO?=
 =?utf-8?B?TlpqMEtpOCthZTlyMElyNmJJM0N5TTMwZXVldTFpRVR1V0VhMWJHcXRFRTda?=
 =?utf-8?B?WWQreExNZklXd1ZOaStjTjJteSttNVNCazA0SFlVbGJYWURIcll5VFlFL1NP?=
 =?utf-8?B?WW5vZFEraDZzb0RhNktRQnNKZTJUNy9CVjFvc1pRZEgwTXZxRlZyc1hhLy9D?=
 =?utf-8?B?bVppTEc5SFE0dVhIR2hXY2U4S3lZalI4aXRXVzZETDJHOUtOWTFGREtBTllZ?=
 =?utf-8?B?YXFvekpMMlhKWmVkeEtMRDF5SWc3aDBrNFBjREZ3K0JmSkpMOUtvdFgwWnly?=
 =?utf-8?B?YWpJWU9PdjZ2R3RlRWx6QStubitYK1duTUQ4UytJVFMxMzVvaGNEcFVjMjRN?=
 =?utf-8?B?dmNjZ3FxREgweGZNZ2VIMVNxZWNBaXdXa01iQ25Zdm5wTFFKa3ZWVFVPeXJw?=
 =?utf-8?B?UExXeDNSaHJaaVRnaHJiVXpmcFFFaWNwSTQ2aFdWbVNNR3NPUXZCd1UyOVRO?=
 =?utf-8?B?ekp1N2VBTnJMUmczYXAvamYxQThZS3libTNIRXY0WlY3Zm9NRW1EZWJsRTJP?=
 =?utf-8?B?YzU2eEtrSlhqMDRleUt4K3ZzakpuWmttRUlQUTk5alhSUlh5VnVtdVFkbHFx?=
 =?utf-8?B?cG4wOFBYb0xOOVF6UUtYN3Q4TWRHVlJzUzlDOUQ3QmMzSGg1aUFmMmRIYWZQ?=
 =?utf-8?B?MGs0V1V5Vk1mTjNsU0JHdld3b0ZkYU5sbnZoTCtuY1JFOFhCVDNJdHFjbDZX?=
 =?utf-8?B?SFI2ajJnZlQyZHFkZDRxMStKcFhzOEJ1R0tXRDkzL1dOSXJxbjJ5UElicTdR?=
 =?utf-8?B?VllzOXZiTHNFSkpGNmZ0bnFwa0dXdVlyRFpEaEppUnM5cm5vSU4zK29veUpk?=
 =?utf-8?B?NFRrWEV4Um9IU1g1L0NEK0NsZ1FMMDh0VWZJamtkVG1LeVp4UnFmYVYyYmVF?=
 =?utf-8?B?VzladXhLZE90WUtlcFZldTFEWlY3TVFoaDNwczRpNjNKd2lhV0FKSlJuR3Iv?=
 =?utf-8?B?Y2l6OFZYN2crTXdIQ2FYMFlrT1hIbnJzcFFIL3g3azdETlEvVEdkUzJBU1hh?=
 =?utf-8?B?bkJlUXZNaHFtazdueVhCODFtbUlodzdvaEZpYm5obkFNeE9wM3Y2SHNnc1Bm?=
 =?utf-8?B?Z0NiZms5bzFzbUwyZVNLZDl4RU1FRzBiQVBscWQ2Ly9lajJWQ2tNcnQ4blBj?=
 =?utf-8?B?RzJudU5KQTUxY0hGZmlWTytyQkxQT3ZlY2dFZmx2UnM4cno4dVVSRzg1Rldl?=
 =?utf-8?B?NGl3bHYvVjZJUDNrZ3RsTHZyL0ZsZks0dVpKejJxR1ZSN1F5Z0JmVklTZjBL?=
 =?utf-8?B?VzZ5RzNMYVhkanJLSWEwNkpEQlU4Zi9uU2hWbTdoWGVYSlowaWoreDhheGky?=
 =?utf-8?B?T3lrcUE1TStwSmlKeDd5VTVvQTVaNDRsbGY4azByVi9FdUJEbDRHeUpqbWQ5?=
 =?utf-8?B?R1RvSzBTYnhJQVJscWd1cDRKYjRWZmk5a013NStNVHA1RzgybHFnVzBnd1RE?=
 =?utf-8?B?RGR2eFJlcFR1K0haSXQ0ZTBxNWkzZndoSVlEbGpqSmlCd0NWSlNVdmNrWEV0?=
 =?utf-8?B?cEM1bmJPVEt6QUwvR0YyMUk5d1ZvREx3dlRhdEd3VlJva25HTDU0aXNNR1o0?=
 =?utf-8?B?Q25VYXZsbnBEYnVsdzl0aG1NWXlVOUk2eWVQaDl5ejVFa1ZxMzVGNGRXVVRj?=
 =?utf-8?B?azB3MHg3dGdEdjBudU5ZbitXR2NiQ3lQY2oxNUxGeG1OTHRnRGRHdmg1MUEv?=
 =?utf-8?B?NHpTVHUrRXVFNmkzazk3ckxWUHdtS01pOXI3T25qK1NaeHZFV0VLWmtmcEM2?=
 =?utf-8?B?Qi93Snk5UkVvMjYranJzeGpLKzhBSXJUb1Rtc0g0ZWN4U2YxT2hmcGZDcDYv?=
 =?utf-8?B?b1RkRHBzTUlKVVVtVlRZeHJFZmhiZXdSZzBVNGkxNUIzT0FncXB1NWFCQ1Bs?=
 =?utf-8?B?WkxFTUJQSTBoWkNaWVFiaEc0TDFLSjNacWM4aVhrb0MzUVo1WW1UYU9oaE00?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06a5aa1-5c69-4734-2394-08dbb9ad8a9d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 07:45:21.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgZTcPrhH0eExs6HgwC9t57Q0xezd0nJ1ciJz2NI4ZQdUL3S9wEXCXpfPowYszIUQyrf8G33cUtA0WNKe0pp+jWIVxoPIuJHFW5TOiEvqpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5464
X-Proofpoint-GUID: XzCl039nNQ0VKN8GNjcALoYVIG2GEXRk
X-Proofpoint-ORIG-GUID: XzCl039nNQ0VKN8GNjcALoYVIG2GEXRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=941 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309200062
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/23 3:29 PM, Roger Quadros wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Xiaolei,
>
> On 12/09/2023 09:49, Xiaolei Wang wrote:
>> The return type of cdns_set_active () is inconsistent
>> depending on whether CONFIG_PM_SLEEP is enabled, so the
>> return value is modified to void type.
>>
>> Reported-by: Pavel Machek <pavel@denx.de>
>> Closes: https://lore.kernel.org/all/ZP7lIKUzD68XA91j@duo.ucw.cz/
>> Fixes: 2319b9c87fe2 ("usb: cdns3: Put the cdns set active part outside the spin lock")
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Should this be CC to stable as the original patch which this patch is
> fixing has made it into the stable trees.

Oh yes, I will send a v2 version with Cc: stable@vger.kernel.org,

thanks

xiaolei

>
>> ---
>>   drivers/usb/cdns3/core.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> index 4a4dbc2c1561..81a9c9d6be08 100644
>> --- a/drivers/usb/cdns3/core.h
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -131,8 +131,7 @@ void cdns_set_active(struct cdns *cdns, u8 set_active);
>>   #else /* CONFIG_PM_SLEEP */
>>   static inline int cdns_resume(struct cdns *cdns)
>>   { return 0; }
>> -static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
>> -{ return 0; }
>> +static inline void cdns_set_active(struct cdns *cdns, u8 set_active) { }
>>   static inline int cdns_suspend(struct cdns *cdns)
>>   { return 0; }
>>   #endif /* CONFIG_PM_SLEEP */
> --
> cheers,
> -roger
