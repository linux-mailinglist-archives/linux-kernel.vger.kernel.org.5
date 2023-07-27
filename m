Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6937650E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjG0KVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjG0KVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:21:46 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8771731
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:21:43 -0700 (PDT)
Received: from 104.47.7.177_.trendmicro.com (unknown [172.21.191.100])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 4E21C1000007E;
        Thu, 27 Jul 2023 10:21:41 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1690453299.940000
X-TM-MAIL-UUID: b48a339a-f54a-43a4-b084-25c420a6bf6c
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.177])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id E5A1B1004552B;
        Thu, 27 Jul 2023 10:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUepVr4kdiY1vuG/fyFI0vADtHdB9Wg2jpG5EYHu+bUq1JcaeSR7H+Vosdg1THTrFOtVH4jD4Ls7UtCznch7OTV95LZSgIVBnRHWz/m4nCgybgXR8gI66l5LaNa9+UQxUJ1khLKN8ko2FNJ4PjoOfw+OxIYBuwU3xOoGo9v2zGxSHZ3iFGUJcPlzOJfOoVHRyhtyvJ1QqOqWhl9NtlwCfRT0VA9ihmZIutMRU9WLi61WNbKxyw0kthj7UEytKGjmzhDtmVIhRNsbj/OgnGlx5waCzgyz5lK4fvUa0zrTr8eJXKfOiia9TvnnZeQiyIZQ8pXHXRE6uzOX8KMSfwN9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De6eLU7TwgegjJn5tIP6epFFZweJUqLYUy4dcV8eYy8=;
 b=NA/P3HnMKWLTiyM9r2oNwoQ4nSytnvbFtIxUdSATC/hYhQOEPBVuWgDGr+kNFIRTmP/L08z/VZyrMiEbYKvK4x6eKeDdlbCXHRIkbOQiLCu6StpI1Wk12pTcUrI8tBYn0mOEOncv7+RDyqY+bcGVofnj9oBOMpJoXP2XzJcsTFTEvmpntIAtb9NI2881Ne34PUkpvpxNujbv7c3g5JW5SpHa0gIN2+PYVv1DzKS72TJCjaS1hJEodUxOc7w+hvujSbCNPG6FAa8If47hEs+rljSOIKD9nOjQKS3qyLpQ3Wn4q+epcclqBTR3hODOaBj2hpV8W60gXjy7XlsGPeorMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <acab57a7-3aab-11bc-6102-bc2e93cf9ecd@opensynergy.com>
Date:   Thu, 27 Jul 2023 12:21:38 +0200
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     John Stultz <jstultz@google.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
 <20230630171052.985577-2-peter.hilber@opensynergy.com>
 <CANDhNCpaoRRKGz0XxV3zjA-ux66gU-dT_bGQ_OqDh4ty=VdXLQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [RFC PATCH 1/7] timekeeping: Fix cross-timestamp interpolation on
 counter wrap
In-Reply-To: <CANDhNCpaoRRKGz0XxV3zjA-ux66gU-dT_bGQ_OqDh4ty=VdXLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0310.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::16) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR0P281MB1483:EE_
X-MS-Office365-Filtering-Correlation-Id: 6419eabb-9792-472f-94ca-08db8e8b43a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kizHOdbkdR8klN15Kdy7D82Y3qRiLrXXNorzCl0zm+FlKAK4DIU77OL9fEe0GqL39bylP97O4oP/wc65LO59Z/L8g0ncK26S9ZKHSAxcI7VUwr97OLIrfCWvNf3QT4aM8TFJk2tKfPsSks0OBF//p3rgM6nsOQ+ZUPZvaajuI2D3OqWul8iDRF6FYXNYBNszLtTEJwDWKScsb5peJkwtpVNdW4ef76elwXh9VK/a0guJ+fw5KAuZZ2UIgWd1HEUaQXFA5slC7t80NBK+8HqQNhlTE8v4PzIj7jEZYIL1GB+0IktPI4qPGjjpGxneLozp6k5nS7KjDygy6CevHNfpaRBIxp4rEOhXNKwH2nsoRCE3UgBv5qrUixeE9FdBeGNj7VzlYMkAtzPE+GcOs3Rg56t/n54SvKObdD61+aAR4PdMs6EF/O27v4NSwqv5bhXA9Uc70uQjiPMAstUr4yhmO127og0B++MAcHBm4Ou9TnPFrYr19LzwPm1/pGPdxEC6cLSWcvD8vGCPVxRD6n2wkOvOXabF+/qvAv4zAsEnQLMkCIzr1dZ/WCAdf2U5EdwD3hAXeEbg/ZpyvCh7tTUDn+TTa1aC2J2MadfiZ0bgfdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(396003)(136003)(346002)(376002)(451199021)(186003)(31686004)(2616005)(53546011)(66556008)(66476007)(4326008)(6916009)(66946007)(83380400001)(38100700002)(316002)(478600001)(42186006)(54906003)(8676002)(44832011)(5660300002)(2906002)(8936002)(31696002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3FMWXVFcFJva2Z2TmdvbHBZRnkzTS9FeEViQ3dCUURkM2xySXJKMG0yS3o3?=
 =?utf-8?B?ZS9Bd2Z0V3VkZnZrT05NUnFJSHR1UmhpeHlMY3hUcTREMkhRUlJEZk5GNFYz?=
 =?utf-8?B?alZCNzFndHNUZFJQcUJEQ1FiTExKYXhUaTdjUitLbXQzTERqbm9BMDJ0Zlc3?=
 =?utf-8?B?VWFiWDROMUwwZGVWeXJDRU85V2JyN2U5Z3JsRmZFUGdlem9jYXlTcURHQWRC?=
 =?utf-8?B?N0F6VzJmQXZ1VzZ2Ty80eEdMdngyaENxR0hhdWM3RVJDaGJkREZKdGU2Mk5j?=
 =?utf-8?B?U1diN1JTQUR5VENOVTQ1QVZBbjJiK1J2VnBGR0dUazlSWjlScVpEYmRKZ3V4?=
 =?utf-8?B?S1UzTVlzeWR3QWk1OHhQSm5rSzVpSWI5NTdVQ2I3ZzdWRXNuS1NhSG0vTjhT?=
 =?utf-8?B?eHdxUVlWNjhiSVpiZUJ0N1hDeUIzOEx1d0ZZcXhFOUNhWjJDRGI3UVl0dG53?=
 =?utf-8?B?bHFUM3ZVU1JoS255SlBUckxIWjNkZytReGNPa05wVEFnZ1plMDU0T0JTR1dy?=
 =?utf-8?B?NzFORk14Ujc2Y2hSNU9LTWw1eFo4bmYyYUtHRitwYmpSOWdrRFdlaFA0SFh6?=
 =?utf-8?B?ZDYveHZNd1pCaFdHdjFTS3JWbkwzUzdQK3BsWE1PaEZLSTBLeDNsalNhVlow?=
 =?utf-8?B?ZjFweDNiNmczVjQ2S29rMFpGamlrd0FFTXVnNy8wWXQ5R3Y1UVVrRk0vT0xr?=
 =?utf-8?B?TmZVTTNrVitMck56ZnBJSUZPZHpSSWp3MEIweUh5emJDS3piWWJuSXlLV1Z6?=
 =?utf-8?B?VjVZZXhtV085TUMyS2llVDltQk1hNUIzMHJRTkJwTnlTYzlycWM0MDY2cWE2?=
 =?utf-8?B?Tkh1YU9kUkZ3ZldIYWJ6NUthOFZrVkZ3ZHBCVE1kckVxWGh4bm54RUM3SFFY?=
 =?utf-8?B?Uk9LYTdEdjl6d3QrQjdvTENHb1RtaHkvU1RrYkE2SFQ4TEVmYnAwajcwYUhS?=
 =?utf-8?B?cDU1Y0k5TXpMT3N0bWpSaW56Q0taTVpJMTQrRHpGcE5LKzFHOUJSOURYN0lV?=
 =?utf-8?B?QjF0YnNCYjdPbGwwRDFCLzFNR2hmQUJiU3MyTGp5TVAwV3hia3hRWVdhZS9r?=
 =?utf-8?B?VHpIeG16bFpGcTZ1M3lBdWY4dXZKY2txWTlIYlZUd0FBbVplZmhTU1EvMzcy?=
 =?utf-8?B?Mk1QWmFsY1VvM3NRTUdWYnZ1dXNVWHBKMDJnY0tWRlRNMktCMlN4VzRTYjJ5?=
 =?utf-8?B?dlNRd2V3QjlrdE1BU1V1SjhtY2YrREdJc2hvU2k2QVAxaWZSdHRUbkhzSWdl?=
 =?utf-8?B?N2tLcm9ZU1p3TTY2U2JSWkNFUGtRaWxwY0VEUXA2VzdiU0l5ZnRTazRPV3R0?=
 =?utf-8?B?WU5IYnZNZ0Zsd3dJT042bENQYm9pYnR4UW5zMDlaKzgzZ2dZUnB5MXZFRmZE?=
 =?utf-8?B?VUUvakNObVlJdnJtMnZweWNEbEkxODZjeXlUZHp4WW50TTlBY0pyZUQ2Mi9w?=
 =?utf-8?B?TlBYVzZFK3p4cU84RlZCcFJpcnI3ajNsRnFoMjZjNkU5YStidnBod0VsbkJN?=
 =?utf-8?B?a2ZwTTlZbmEzMktUVGczUnJOUWIrcEo1STV5ZGNSU0xXc0UvSi80MVhLTkdU?=
 =?utf-8?B?dmxyT1cyOFk0R2Zha0lhTzJwMEdiaDRkMi9wNG1CaVUzZ1prcy9ra3Z2UU5j?=
 =?utf-8?B?U09VTmpMcjNIdEEvcG1KMnQ0N09SNUpYem1RVW9YaGo5cGozdStDOWlIeVdt?=
 =?utf-8?B?WlVPMGMxWFh6Vlk4YWlKQnhZQzR5OUg4WVZUc1UzdHhnZ0UrWFlmdTRYYkV3?=
 =?utf-8?B?NTBUTUJlVGNMTVBnSExQWVBuUzdneXRCN1o0M2ZudW01Uy9rYUszenlneTNI?=
 =?utf-8?B?Sjdyd0dVMHlVQjhOQ1lHYjNnMHRKaUh1NkpLTnUrN1I3ZnMvYm84RzEzZXli?=
 =?utf-8?B?N3VjNENnVG5JaURETkRERmFVbHpRYzNzVWZnWjZxQjNaNVlESGQ4TlFGVFFC?=
 =?utf-8?B?dFFpdkk2WWQvTmFQVGMzeElIQndWYml1KzBybVJPMU9JWittRlhWTC9FVisx?=
 =?utf-8?B?dkQyUFpOWiszdFlic0xRZm42dzJKVWdxbFpxZmltM1JHcXVlMWgyNVJlMmc5?=
 =?utf-8?B?RC9tcThuMXo5NnNjaEI0VmliTXk0cGNWazV2ZEZPNUhkVkc2RkNsQkJJRVNy?=
 =?utf-8?B?R3RsV0dPeVQzWUNTMmR1ZjlkVlh2UkV1WkhwVGJHOHNCYzdQUitHMlVkWjZT?=
 =?utf-8?Q?J28hFbeyn2ba1qt8eHIrvwQynZJuiw5YcHoUdlckWlVr?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6419eabb-9792-472f-94ca-08db8e8b43a5
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 10:21:39.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIFRpn3P5EsmR5Xd2kEaOOcL2cFxgqTqWmaL716LICD+whDSVj72P9i3OiqwuTLsjXaaBTc4ONiffT5JDB46Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1483
X-TM-AS-ERS: 104.47.7.177-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27776.006
X-TMASE-Result: 10--8.889600-4.000000
X-TMASE-MatchedRID: scwq2vQP8OFRw37hysZWBgw4DIWv1jSVbU+XbFYs1xK3UJJ8+n/4RZV4
        6ChsSKJzeLbIdIgehmz4KMoVcGm4TWVKzi1vZiAN9uL5hOvaG1KVmuhG06IIbTji23k3pyJLKLe
        iMOXj8x0HZRiBZseHrIiu7wRb1ji7rddi2w4fb9BFg2HO5lmNEPhwJOI9xff0D++CmrqtFoD8wt
        ZXDSbfrL0UfeDlmgKJ6xA0Ava73nAPm15xyht8lST5U3lJ4T8KVpPkdwltPhTCWXLd4w2EwN/up
        PexrMg466PwQJF2tNThh+3i1Bd2p9lWEqyA1TWbIxoY6jRls5ndfsxLJyDdyA==
X-TMASE-XGENCLOUD: 778ee2c8-e7a2-45d9-901f-0b4f9eb4cf0e-0-0-200-0
X-TM-Deliver-Signature: A956273B454162CFCAD01A06AAB72FD1
X-TM-Addin-Auth: Ne+BI4Ey/mMAuDh4Bmf1lHYqscYiXurihyAFn04jJGKSJU64p40hqpCrSx1
        ernWv5AtbjavCqjualUtLAkQiRpy4vYDXPrrQx/ATNCJLGVe7esk2SKpa4kjcRSQkpe95k4KsIg
        Cu/14krMwY6wX8RaeBPjsGHEZQliCEissBjnZYEh/5aNh0UVVT/WHI8jJElAcGWbuKI/9T1IpgH
        9r32Tvv2PwFbZvUZ1zJnfmeERuinNqaDmqJMi/Jnr3wgX4WCyxnz7mjeKZTXxUt1jRbNa7BCBZB
        YUuY5STw6hX1EyI=.OTq6fIBR25FcaUyEiY+e140ZPzX3izwoQfas822qZ2HIdWpdt56bQ1eALy
        9iluvRKqu0h52l8H2BqNQuWi6vkYlul/b5SUj6PgHV8I4WkLuB3ZM9CkI7BYj8SeqiXkVY4FTTr
        CqbYgiHyWc04QzL+sAbe1p9Ky2MVG36ZnfverIDOtE19jU5Rlf2IIcOEVyBLr85H5mVRiOTcRNA
        jDoZJZpOlvu/MYcVMsgvqgIKJV/D0Y57Y5dEKD+Z3fgtBmP06L6QOxIjPvRXdTvlV8dU16B+7aO
        BkTx3enZ4/lFikenZVty88AL21KIy5NonfmEc8izCctx45VnPBRfKxEl49g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1690453301;
        bh=aGRlESebHQpO66t9+gVRqnAJ0jRBelYTvwt9PX68ep4=; l=1454;
        h=Date:From:To;
        b=l1skd23RrdTLaXuZOcxbKXRnnbDBrSsW8535NqAfDEM1RiaipX/MV6nJ+nVtvRu98
         E9vBziLxuiY4ya/juHK+ZPbhLPxoJs2TFecdzWfnLvDd/FCLw9fVLtRXWyYQDP7MYV
         LTLVrcSlFsJEXABRudnx87HRkcfzAf4mirz3SxQ3jLPdVdaArl2uv9fVIcelCAVUL8
         cnfFi2iwnANj/7Ks6us2W/wR8LPipMVtWFpp/PiTVtVW3GU2EShjMe6TnXE0+5dmsz
         Ttmhwi+70QsLnI+gi+JEzS6hGTpz+u/jVSEiACn5hc64GxITzebubzcZlJhvWmRK4A
         GZ/gDWya404Hg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.07.23 00:51, John Stultz wrote:
> On Fri, Jun 30, 2023 at 10:12 AM Peter Hilber
> <peter.hilber@opensynergy.com> wrote:
>>
>> cycle_between() decides whether get_device_system_crosststamp() will
>> interpolate for older counter readings.
>>
>> cycle_between() yields wrong results for a counter wrap-around where after
>> < before < test, and for the case after < test < before.
>>
>> Fix the comparison logic.
>>
>> Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
>> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
>> ---
>>  kernel/time/timekeeping.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index 266d02809dbb..8f35455b6250 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -1186,7 +1186,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
>>  {
>>         if (test > before && test < after)
>>                 return true;
>> -       if (test < before && before > after)
>> +       if (before > after && (test > before || test < after))
>>                 return true;
>>         return false;
>>  }
> 
> Thanks for catching this and sending it in.
> Looks good to me. Curious: Did you actually hit such a wrap around with u64s?

No, I just saw this when fixing the bug in the next patch.

Thanks,

Peter
