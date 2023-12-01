Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ABA8003E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377651AbjLAGbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377645AbjLAGbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:31:31 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2105.outbound.protection.outlook.com [40.107.92.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B0B172B;
        Thu, 30 Nov 2023 22:31:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUIyWkpYNUlRiobWvKfBKrW+Mt3G4wOXJTIoKLJWryTZY0SS54+b15pr7styc7a7oDDjO1Kb/pSPBSMxEX75+cdc6BW1QxpWbRulNh2zo4EjKXJLfVCS3C+aombkryuQR5c29ntRVeb8bm/fQKmCWuescNonUpHb3u8/8nhBMbMwo1UdbTtTuLkoPUtE/aj1szgcfoujzT+KYUYwbYR9QDe7FItWdxUpZwJm/jfYFigBGP3vJayfrRANkV5igX2mabUp9v6jfuUhQWCgnIkF3QdCZiC8B0mxA4uVBSVfoXjy50WbohJDcHXCnHLsvemZUSgWR980Sfr/mtforhIICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVSn6+mEouHdoIlcKyZKXR30CEfKA/WIL9COV5b69E8=;
 b=Kze9UdpELBPcFK5TOSV6Xjkg+Z0ZwnSSvFbV4/yr7EjJwq+hrPDEh4zuSjRfc4AhgQvVpdvzJmD3+RpCI0/Oagy6SBz9OVYXm9pQtys+ZXx5XriEF6lvgezeUuSiiNWi4HqiHLLHiX6lULJ0WzYwSqVN6ZG6zHrjPWfi53u/eVP+x+vBxoLB80GeTLb92uRtLhXhu+jjLkMwbS+tuow6OfwkKIgQV9t3vzY0bstcxDPKu0CIp3hZBKVoakK/UmcqXmX2JNQzpYbsCAeGn1flFpsB4f5oGDCwhl+9CUbit93LINP9q0Ho9M26dtmNxPTLZMhw4w92l7LufWyU23//Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVSn6+mEouHdoIlcKyZKXR30CEfKA/WIL9COV5b69E8=;
 b=h8hcUshIuZ0VLtVf8ZTfQ4qjL8VFaLqBtlGSHKrJ73+e+qeYhx7FvzOCrau+agmN1iRwgq13H6ZclV3dPp/z/3qPIBXOQsjFTcv4AulDSD4QPvvjL4c1r5PXwwnssCI+8aH52JdPCMs8sh6etij/k23DkFLSmUb0ZCV43uYpayo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7455.prod.exchangelabs.com (2603:10b6:806:202::11) by
 SA1PR01MB8159.prod.exchangelabs.com (2603:10b6:806:333::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 06:31:33 +0000
Received: from SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::5682:1d84:171a:1d68]) by SN4PR01MB7455.prod.exchangelabs.com
 ([fe80::5682:1d84:171a:1d68%3]) with mapi id 15.20.7025.022; Fri, 1 Dec 2023
 06:31:33 +0000
Message-ID: <3e8b18e6-673c-4ee6-a56b-08641c605efc@os.amperecomputing.com>
Date:   Fri, 1 Dec 2023 13:31:22 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mctp i2c: Requeue the packet when arbitration is lost
Content-Language: en-CA
To:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>,
        Dung Cao <dung@os.amperecomputing.com>
References: <20231130075247.3078931-1-quan@os.amperecomputing.com>
 <473048522551f1cae5273eb4cd31b732d6e33e53.camel@codeconstruct.com.au>
 <706506b7-a89c-4dfc-b233-be7822eb056e@os.amperecomputing.com>
 <852eaa7b5040124049e51ceba2d13a5799cb6748.camel@codeconstruct.com.au>
From:   Quan Nguyen <quan@os.amperecomputing.com>
In-Reply-To: <852eaa7b5040124049e51ceba2d13a5799cb6748.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To SN4PR01MB7455.prod.exchangelabs.com
 (2603:10b6:806:202::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7455:EE_|SA1PR01MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: fb98e83b-e607-45ff-a5b8-08dbf2372936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1AvpgAbzSoxeuGHotuGzot1duUfKD4B2xYAcg3i486vbFsdenQW3Xcb9+R6WzZrQ8X07ntcNy5OGd7d6n3stcgwZEZFcTvOpEbnwNPtIPs8rJDo5K0eF8qr2C7vknmyzDEfkDkJKmsNBSZPEmZ8j3fo2LF5bCzWbD18yl7UJsuWqquOgYXA+l5+/F6VQ7QaGGd/d8sv0t04VoJ6ZjYRAkCnzlWf1J+N+spYTfBZpHlaMVnCgrS8tjE6NMFL+BYQfEKvmzvy972DepY2CtdcXB5aXj7Pv0i+HRT94t83EWepE0gIdf8AK2p7GOFlLeNa3d3eSeACoOvK3CdSC4zHueK4EaSlxIdsS4UrG0zGejyqZGcRzUpmW1lX7r26Q9GsHhOWv4B051IKzDALR07Uk0Xnnt6VrRytYz7vW8Ij0KerwLUzO8s3+MBD/sD5GxRfijYpQZ+OBDsccVTzX1jPgXnE3zkrARRix9pJPo+QGM2eUV1e5UvVrmwszgXGFTzIbbowN+WDAENpIQfJYzARulQPhIoatkgIA5UVIWKpwtXjtDGO9CWCyFYIVzGJmdh3WHh4W175Al6U+sRCXM1GLL4p1GqtDGp0ZbrztrjgjuLiy7xzt7WdUdQViUvM7AN93
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7455.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6506007)(66556008)(31696002)(66946007)(54906003)(66476007)(316002)(8936002)(8676002)(4326008)(966005)(478600001)(6486002)(110136005)(86362001)(2906002)(41300700001)(921008)(5660300002)(38100700002)(107886003)(2616005)(26005)(6666004)(83380400001)(6512007)(53546011)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNZcmVTeEZQYklzUzRFNHJLT2hGWTBHVlBVSE5iNGZVbWh2aUpaS1ZOTDRi?=
 =?utf-8?B?OC9Cd29lbFQ3dVdoU0VhY2lIRXFtQUU0VlhVSUdYZXNtWDcrRXlLeWVPTmYx?=
 =?utf-8?B?M2lic09maExhWVB5b3FPc1k5QVZOalVHV2xMVkRid0RTRDdQQ0dickdwNmFL?=
 =?utf-8?B?K2R2YlgrOTQzR2hPbGtPb0tEUTJtWkxLU2E2cW1rNkRhbDRxOTdSN0tBdDRo?=
 =?utf-8?B?cndxVSs4VzhYRFVwVktmcVlXV2NvcVMrbU1VNm9ETGVRelFqZ04yVjk3NGR2?=
 =?utf-8?B?Wk91NDZmQXdiaVBTRVl1VmlKSXNBN3hYVUprSmQ2SmVXSmRwN0lCNnJxTVdN?=
 =?utf-8?B?QWs5UWxkZ0F5Z3lVY2s0ZUZ6MW9OZVprYnBCeVMvc0ZEUGdoZXl4MHNTNTgr?=
 =?utf-8?B?c04rNHFBMXlvdjBqYTBJY01ER3hGTVNBWURSWEg5SThFQ1pIZ01BZTMrMDRZ?=
 =?utf-8?B?NHBZU1cvMDRCYU5PVjUvaHhUV2RBQStHS2pUVmJMeVlvS2lLUTVUK0JERWcy?=
 =?utf-8?B?Y2JGTlg1eWJlc0wvV0R6RXdiZlBCU0tPRllhajBtOGQwZ3NIS1JsUlVBOHRT?=
 =?utf-8?B?eHZQKzdCVlZ4SmRGWkxhOU1sSDVjbjBXeCtlQVhaeFRGRTdpMCtmd1pGZFVo?=
 =?utf-8?B?bnBTQ0MxM0xnTjgyR0ZvbklwMmFxWG1nYVZCbnIwSWV2R0orMUw5OWVXM2xN?=
 =?utf-8?B?dlMyQjdJbkYvd0hxMzZwcUJ0SkxPTmJwcmVOTkk0R0hYbEJ4NU00NFBoRkNW?=
 =?utf-8?B?OXpYdjRuRTNPd2QyMFJZQ1VhbEpFNkNBR0cxT25rb0ZvR0Q0MGR2ODdUem95?=
 =?utf-8?B?Mi9FS09OZ242bXNRRTNhaTRuem13ZmZkcUpMZ0ZlSzJ3dlBWa2huSmw1V0p5?=
 =?utf-8?B?YkRZK1RuQXJ1QWtYbHZabWNaVUlDeFpuWUFScU4rMFRPWDZjcWtRR3N5MEkw?=
 =?utf-8?B?UzNIMTU2NS9hNDRqRy9mWGpDUW1Hajdla3ZFOWJCZjM5dk9BcENodmh3VVVt?=
 =?utf-8?B?WUI1TWd4TitFblBORmJOTTNkWUlpN0QwNExwSmI0VmdWeE9zSW91WFhNUDBE?=
 =?utf-8?B?WGlVZk41K29hMVpVb3lMNGU1a0NJMEZaUXlONk0rZngxWHZJZ3QzZGZPUGRn?=
 =?utf-8?B?OTh0NSsxRmxFWTBEcWFneGhXNmlLY1l6dTNDRkp3VnZJMnd3L29JTVFsNnhM?=
 =?utf-8?B?Rzh0alNnaU5GUFBhVzJMbDFWclVveXpCTFlTWld4a2MzM2R0UHN6Tm9IQ2lO?=
 =?utf-8?B?YW9tR0FPYlhPVmRlNW5VSllmcjY0dWpETEZ5c1ViWGJ4OUhqRnBzRDI1dEhq?=
 =?utf-8?B?YWVIaW1EYU9EaVZZVDlzVVhVdGhEZXZrVkRjQXV6cm1jN2RPQnhZTnBoc094?=
 =?utf-8?B?blN2TG5mNWEycVNjdUN1WDVIbjdrUW5XREE2dUNTTlErY3pUSldZU2U1ZGUy?=
 =?utf-8?B?OGR1eDB0KzNCb0pHMlRYeWNJMzNhOFhJbm9Fd2RhakhteHZsUnlLbVB0VTdV?=
 =?utf-8?B?K1VUSmVmd2lYdFlTNkNaV3dNZEJWWVo4U1RaVWkrL3pKeE02akNwd1BsRXE3?=
 =?utf-8?B?ZW5wRktRb3hBNFRURUlrZlBGRXFuZS9uWTlzd21FakZYaVU3dTlPTmlBaG9X?=
 =?utf-8?B?aEFPUUxGellhNW0vVExpUXYzVlVTTzFaODZCa3kwYStSUTllb3ZLL2JLVmpy?=
 =?utf-8?B?YkwxSi9jaWhKYTdpT3hKUTM3ZjJ1MDVCdzlBZVRPWTBxaEVQSTQwZ0YxR2pZ?=
 =?utf-8?B?Z0ZNSVpkZG4xVHNla2lwNmwzZ1RCTUdscncvaTdDRTRYblQyRkpRenRqd1A1?=
 =?utf-8?B?RERrYTV3YldsV3JmVUdzdWNYenBuT2hLeEozaUQ0VjhZZmlCakZGMXIwMzRL?=
 =?utf-8?B?elllSnZmd0diQ0V4QjVwZTJRV0ZyUlg1a3RSa0YycjBSQno2MVhKbHdBYW1i?=
 =?utf-8?B?a2IzdTY2V0FWYjVFa3lKUWc5MVJHb2tsellrbXVMRHNYVzVDNmVGcVJIdlg0?=
 =?utf-8?B?ekM0QWZxQjdpaEZVbG9DYXRBOE9aQU5LRlRPMnp5emJxQk42RHdheHRqa3R4?=
 =?utf-8?B?MTJjQkVKTFAxUWlTQ0pRSmJXYm13VDFmSDdvdGdDaXNQdFRBV0J4d29MWU0z?=
 =?utf-8?B?cGYxdE9ucDUva3ZOd09tMThSNnZZOEt5QTVKckI0ek5GcnNZYVBtNG15TnBp?=
 =?utf-8?Q?wBeOAunzNf/K9jmVV59oTkI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb98e83b-e607-45ff-a5b8-08dbf2372936
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7455.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 06:31:33.7817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MnezFXXpLPMo5Crl1BvnTS21AxJS8yaqKBY8MGbBI83DDZRiOc7sxn93RRoPKKvsqsq0OP/FX6fgbZaXHhTpYFJBdDe9P+6X/BxQkTF+TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8159
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2023 16:40, Jeremy Kerr wrote:
> Hi Quan,
> 
>> With this commit, we all see the packets go through peacefully just
>> by requeueing the packets at MCTP layer and eliminated the need to
>> retry in PLDM layer which would need more time.
> 
> It's certainly possible that this tries harder to send MCTP packets,
> but it's just duplicating the retry mechanism already present in the
> i2c core.
> 
> Why do we need another retry mechanism here? How is the i2c core retry
> mechanism not sufficient?
> 
> It would seem that you can get the same behaviour by adjusting the
> retries/timeout limits in the core code, which has the advantage of
> applying to all arbitration loss events on the i2c bus, not just for
> MCTP tx.
> 

Hi Jeremy,

As per [1], __i2c_transfer() will retry for adap->retries times 
consecutively (without any wait) within the amount of time specified by 
adap->timeout.

So as per my observation, once it loses the arbitration, the next retry 
is most likely still lost as another controller who win the arbitration 
may still be using the bus. Especially for upper layer protocol message 
like PLDM or SPDM, which size is far bigger than SMBus, usually ends up 
to queue several MCTP packets at a time. But if to requeue the packet, 
it must wait to acquire the lock before actually queueing that packet, 
and that is more likely to increase the chance to win the arbitration 
than to retry it right away as on the i2c core.

Another reason is that, as i2c is widely used for many other 
applications, fixing the retry algorithm within the i2c core seems 
impossible.

The other fact is that the initial default value of these two parameters 
depends on each type of controller; I'm not sure why yet.

+ i2c-aspeed:     retries=0 timeout=1 sec [2]
+ i2c-cadence:    retries=3 timeout=1 sec [3]
+ i2c-designware: retries=3 timeout=1 sec [4], [5]
+ i2c-emev2:      retries=5 timeout=1 sec [6]
+ ...

Unfortunately, in our case, we use i2c-aspeed, and there is only one try 
(see [2]), and that means we have only one single shot. I'm not sure why 
i2c-aspeed chose to set retries=0 by default, but I guess there must be 
a reason behind it.

And yes, I agree, as per [7], these two parameters could be adjusted via 
ioctl() from userspace if the user wishes to change them. But, honestly, 
forcing users to change these parameters is not a good way, as I might 
have to say.

To avoid that, requeueing the packet in the MCTP layer was kind of way 
better choice, and it was confirmed via our case.

Thanks,
- Quan


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/i2c-core-base.c#n2223
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-aspeed.c#n1030
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-cadence.c#n1322
[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-designware-master.c#n1030
[5] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-designware-slave.c#n258
[6] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-emev2.c#n385
[7] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/i2c-dev.c#n478
