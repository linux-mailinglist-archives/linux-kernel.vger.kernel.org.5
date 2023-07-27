Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78457650E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjG0KWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjG0KVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:21:52 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD071710
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:21:50 -0700 (PDT)
Received: from 104.47.7.177_.trendmicro.com (unknown [172.21.162.147])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 5EABF100017AC;
        Thu, 27 Jul 2023 10:21:49 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1690453309.038000
X-TM-MAIL-UUID: 52da8c38-f2ea-409f-bc23-8c63b663b75d
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.177])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 097F610000FF2;
        Thu, 27 Jul 2023 10:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9lqFG71aIJQCZzd3aZBCMbEyMBFzlH9CoZLzv0Wf1UWICmmxRa4Qlv9kPZHPdEUpFmYALD8ZuK05WXYO7fX0ntuPzLCzlSMXXkQi3CzALnG3kpYnLO2RdbUdJEeQbwQ3DY5K6g3oR3AxSpQYi6+c1fB72txnk5IbcStOKqYRN7dU/qOWch11/s5p3s+2ZRofOimKq71wDoMEeJYwlfYAg+YUjerOxSacTpDBcCiRv1269duI1SVo8oHQJc17ousFocCKr6CX3P3YProf2woFcsuu2Tkb2/SOLCDrV96LJ/dsOQlHb26iF0V9EGTg3hO9H78LJ3XwBHj+ysDoGKQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sma3XlmxTQChBVaXT37ES41CoEKYqclLB+FdpblZZjA=;
 b=E1s0+SO4aWs2brBVUFVx1hBgn7AhHeA/pwIK0bE/9ZIQfCeZKi+K+3w4z0+SZ9ZBgzemAhMZMncXLi8J09Ok1L6merIqe8ZjgSPYtXutaSQtTNyDIlmstJA5D2J517OSwRg2TTRwpwlPMk7/ivEp8AGxKa4qmSTf0Q4qUfCDWw+sRMIIQCjQAui0z0MQg97fviTVXjpmWEgqg+CmjUAzn2BOMENXh9M4PysjWMJNC+RlydXTw0eaxh2x1PebrImtsi2XbVncaa1RNX/t1qnQFC4k3TL5gxnDqkya1HVKfGzzYQzNKc46xmeOek+wWfoB6xgCmajN0BG+ULkwFYOzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <e96ee63e-24c9-2d6e-7ddd-9025bca5f7dd@opensynergy.com>
Date:   Thu, 27 Jul 2023 12:21:46 +0200
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     John Stultz <jstultz@google.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
 <20230630171052.985577-3-peter.hilber@opensynergy.com>
 <CANDhNCpN_abA6YGHuFy32pxeT06quNSVBgyXnmPW09xTLe4XAA@mail.gmail.com>
Content-Language: en-US
Subject: Re: [RFC PATCH 2/7] timekeeping: Fix cross-timestamp interpolation
 corner case decision
In-Reply-To: <CANDhNCpN_abA6YGHuFy32pxeT06quNSVBgyXnmPW09xTLe4XAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::11) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR0P281MB1483:EE_
X-MS-Office365-Filtering-Correlation-Id: d19c9b7d-f889-4bc8-01bb-08db8e8b4924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYetebtGflUJJzLQK+DMq6i8Thtyl2p3DJLHqsXbda3oLVh4nOkBB45fNur570O6CiqAB0SSosAxW8BHqLdpUGJb1eGkYMW7+odKrDiI7Tn7xAykRBdYqhXKQ6F+iVdPvIFGNFkbRgoEiSUuacEVkW+4YDnj5y4KOBZ5grBeSP2T2x6gk5BMsYVvkOUZNQZ43ODDbXvzeabvElS06JF4Ch65e1CYiiWLCI20/58oi1sifrbxb7/cIl3PBapK/Z4YTjQMLrIzvMZyQhIx4YPF2XOUsdVQMn5tJuBeJ9KFMJfuiFHi+tBGtFY93CwwjAcWOGA47xd5JcjHlTOTNpPrVIXQRwMSRuLCGiB1d14sUpgkgmCQynuEbOxwXd9UKu++HNFTpqgkewGvAZvVg8jn/OkA03ovisJWX1mp5wyAAHlVZFQtQp1jt8zLZRbHAyRDuDq0VKh+aM9B4c+Ku2NzIpO2AFsqPtIxC8JdLzqLTsdRLsXEFXeohWgftlqTfdhoYRAKPlpvd8NZKwkumAqwxhuu1nWPOErZsWrBfpJiOfo+xhZjrQG/L3oxMuP56zYPhh19Co3UCLw6QJ2hCJEXCSeEQyo6jxH6ugESXqflciQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(396003)(136003)(346002)(376002)(451199021)(186003)(31686004)(2616005)(53546011)(66556008)(66476007)(4326008)(6916009)(66946007)(83380400001)(38100700002)(316002)(478600001)(42186006)(54906003)(8676002)(44832011)(5660300002)(2906002)(8936002)(31696002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnlEY1RiZ2NON0NVNkF2UWluUW9ZenA0UVBZZmZpMTVTR3JDRGR6R1dZRVND?=
 =?utf-8?B?T1BxS2xRbkpvalk4cmFHek0wQWk5NGVzbG1hQ0VOT3dwMW1RTDVIYjZNcm5X?=
 =?utf-8?B?YlA5a0h6VHJucnAwcG13R0hUSmRGMzdUSE43WUJFczZWSU1pbzM2bDI3VVk4?=
 =?utf-8?B?Q3ZmbjA0WGE2eTBDdW5vQ1hXQk5Jc1AyNi9sZ1UvaTYzY0gxWllXdnpXVHpl?=
 =?utf-8?B?R2pQNGR3S1lPREZkNEhEYytIV1Bya0FhZXphZWMyaVRkSkZXU1hVdUFUUDYx?=
 =?utf-8?B?Tkk4RlNSWlhaRVcrM25NUXFtZGV3VkQ3dGQvRXFKbmtGbXJtTm1lb2JmWmhn?=
 =?utf-8?B?eW1meithZHBqbkZMSTlVTGFyanFvMTlhN2w4SEN4ZHFrRmhmSUcyb21BVWhk?=
 =?utf-8?B?Q1dHeEx1cVVNeUU4VHNrUlkrQ2w3b1B1VldOYWJJRGNxanBhaTZ3Vm14UCth?=
 =?utf-8?B?Zk5HSElNL08zSTVuUkJCSnQ1REpybVU2Nm9lKzhPYnhqWmNDaU5RbUgwMm9l?=
 =?utf-8?B?TklNZ1M5SWd4ZVNmM3dEK0drd2NYNUt0aWg2NFkyVzBJTUNmb3VLVWVEVVlM?=
 =?utf-8?B?bldmemd1ZlRqM3VHcG5MdTJpZmtrQWwxeXZMVlh5SEU0bFJvaFhuOXhFS2NP?=
 =?utf-8?B?KzBHUHQ3QkFqaDVQczNoZnBMRDUrTVZ4YjF6akdKN0VONi91WEJpVlp5WjRt?=
 =?utf-8?B?bnNDOXE5ZCtQQWpNZSt3T2ZCNUFvQ1hPcForLzYrMmpQaytaSXc4ZmVmdmRN?=
 =?utf-8?B?UUllOVFYRmV0Q2pYb2lhcjI2cWlKR3JsY2RPZG5JSit3RzJHTWZDbWV0L0tC?=
 =?utf-8?B?OWVRcHdyZUJwUHRVSk1LaWdYUVFhTTh2OGVML0laZEt4VkN4cGJNNXFtTVJz?=
 =?utf-8?B?czFZMUhEWjRObXhkSXo0dW1lUGkzVjZpdHdBL0ZicmtBdW9iY0VWcnhtTnRl?=
 =?utf-8?B?eFZvQ2xtTTJSVVF3SXlqV2o2QUp0MUJBTlcyclUvdlU1b05MT1RhWlpVaW04?=
 =?utf-8?B?N1JuZUVuVHFtaFZhNmhsR05hV3ljVHJtUCtGcURDSGdIUVVvTlZyOEdRM2NK?=
 =?utf-8?B?Wkc4Z1BiSUhvUVFkZkpIa3RQQ2RKQWo4MUszNncwMFJKZ1RaSDcrVDFJM0VH?=
 =?utf-8?B?TkxEaU41SCtPVi9JTkMwazIrWTVJQ0t6L0JNWXQxQUlEandwcDBFU1E4dFFh?=
 =?utf-8?B?R2JuMlNyZDkvTE9BQmtob2xNdFFnZmlsS3JOUW1ob09UQktVVjNkQ0VKNnVm?=
 =?utf-8?B?aTJoQlFXSWFjanRVZG1GcWw1aTVwclZvZUh2VXEvSU9ybUduRzNqdTVpZjhW?=
 =?utf-8?B?NDNUSGQ0Q004SXRVMkVKTUs3OGhEQXVlQWFyUG5VVnorZHRLWmNuN1luZytq?=
 =?utf-8?B?bWlEaGVwZUhneFI1TDllK1IvenNXd05qOVpjZHpwY3dPRW1qVkNRd2Jab0JQ?=
 =?utf-8?B?cm9TNGN0OTB3WWNhSnBTRHdvVHpVUVhvTjBUU0NtK2E4NGpmdGRyeWdVSEJZ?=
 =?utf-8?B?UVhxcFM3QVJPZmJIcG5ycTAxZjdmci95L21ZbW10MzFhVmNhdXh5b0RDaFVC?=
 =?utf-8?B?MDVQdmJwOHVzR3M4d05NUlVFa1FncTluNUJ3d1p0RGxrQXhaWlk5Y0R4RXd5?=
 =?utf-8?B?a3I5RDRMckl6bWpsOXI2aEJrdjFSRFp5aUpidzdOSGhzTWUwQlh2MStJOTE2?=
 =?utf-8?B?M2w3U0EvM21vWm9PZWRWWkh4cTE5TXAraFpDaUQ4WDAyTDlCcjJwazFoSElS?=
 =?utf-8?B?YkZYdWVMdkxES1NRdDZFSG9ULzN0ZUp3dE94TzBheCtmdklvMFIrRDZYTzJw?=
 =?utf-8?B?NEpxajVPTGVqbkkxaWlFam5Fa08xQU9SWkp6OEtORm9VWlJ2WFo2KytsWDRx?=
 =?utf-8?B?amY3ZWg1LzhwdEt0bkNhR3U2Q2hURVNQRmFpNC8wOHk0aVFjRVg4dUtDb2Y0?=
 =?utf-8?B?ekVQMUV1dXBiZUtVTmtZZlh6aTB0bUY4NXYxTXZZYzJUelZFaE5GS0huNzFu?=
 =?utf-8?B?VFQ2dGk0OG5IM1NlbkRFdkJKZU1WK05mTnd2UTFhNHFoQndXYkY5b0xVdGRj?=
 =?utf-8?B?MUpMVkROMnE1a1Z2SmN3UHFlMlJGYXJ5YTZqME1JWTFOUmZCZXBmK1UwNnZm?=
 =?utf-8?B?V1FrV1BYMDd3emlaUDlQVVFlMWIxOUkya203MWg0dy9CZkFvYm9hSVQ3R0Rw?=
 =?utf-8?Q?X7FW74uXRfemxt/bXEn6cnu2q9YwqG2DSWtpZcA32UXm?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19c9b7d-f889-4bc8-01bb-08db8e8b4924
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 10:21:48.2516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deZVo/euw88H09r7BxmuFvYiHvKvQ+AM1NltAqLtygLCU98lMsUkomPhL8rBjt/gOGShpxunwNTRVrJPPTkXHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1483
X-TM-AS-ERS: 104.47.7.177-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27776.006
X-TMASE-Result: 10--23.377600-4.000000
X-TMASE-MatchedRID: 6otD/cJAac1TzAVQ78TKJRhvdi92BBAu59KGlOljPvvL4Mp4UvMNKVty
        DLlJWzklAHg/HS2tqGhxI14S84n1gxhPobfltr48XAeS+w5YgSWB37bQADgKr1h/wutMoz0cfd5
        aIFd5wa1AbwnmmW6Wx1yR9nr6xxeGt3rAJT45JY/JtoyGVE0N8ETrh3TFw9fFD25MJwZSrJQ2rJ
        R3IsjYC3VTDDHykXSVy4p6Ia9VgClAQzrS7+Jvop4p07KVSE/ZJ3y+iqiko28pK3G8RuosT34Jg
        WRal36Vp56doKZCCFJEPCl74DuKiehv7GZhENfVQj0AQ98QP92jg0lrtKMWyriyzPY0dNE1ot6+
        FxoHvnQmkrgX3CciJpBlLa6MK1y4
X-TMASE-XGENCLOUD: 5ad7d94f-1761-413a-a2dd-e9cb0f3cbcd4-0-0-200-0
X-TM-Deliver-Signature: ABF0F0047BA41F4CE1076A81CB31282E
X-TM-Addin-Auth: dqHWb9krQSxGrs4SOc0ewuy2MSaJq32Cr6LJvBNbraIpPgcE6DItIWQDKGc
        SmJngcvW4VlT9Xq3iayfCsLaO21iG6v+Bp2H+2WxC59Nchri67qWXwvMN0DWTYj3zYWiBNU0uPO
        XHkZThNt+E8tNonwFpGgmJ1jsKOf3F5cs76Wn5bsPqCXMDg92n/In4Mpw/sG1mlfRZ3dvWWhxIZ
        3knx7QgFtwSmLjrU+xZfOW7+wW1k0wOdHdk/dQK+8BY4uXY5JP+CB5WHithGUvdlBGcH0n8i9Uq
        ew5LPoNzFbt+3SE=.Ll8dr/xSY1KEbPcyP0glAoRn1lHvU7huhZhE6tAUMepb9FzSuG0wD8xG69
        EB4PokllMfACrKRzKJJyvpOoR4NX4MPHxDBFTN1bClxISlB4MnvhGP35M91yXJqAQyJuOy1JNZw
        dR1+dHeIuHdZEYpcdn2HScSHTHxqdY9QrePLwXHfT4lMjOqvEczV4gXv8UzSqRjYC8Cd+IdALD9
        VA87YE388tNO0UX20iYoXIWqwFFwYKfXI9nby8Giwkh8HeEf5aeqviFsQlXiUE+b9PkoveTzSXj
        xUHvomC25Ct2YeeVrl6NIAgUWuVrtczOSTtfoMjCpcYkCibzuK5KaUlsF9g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1690453309;
        bh=4JU45MEqgzqnlvXoOjcqZfoJ7mUfGtFh93I24eEd8Y4=; l=1808;
        h=Date:From:To;
        b=dI11o4fZvVbFvVM7NwJdsRM8gXVqIZ4x73CR0tCLiqKmqJhsMdm3ljBy8EcKwfbuz
         SI2QZuxO2qDnpZy7n+o9PKeRStTLSN8Py+GFenNv5QPI6reS+YPJIV8GvChBZGYSV9
         SMHevZBApYJHYdF7S1WvwEbr/VV7N5zCg4IUQiM1po7ZoIo0oW1ynzeRXPI7Bp4kAp
         loOaUb0BH7zszDplS88HjX5m/hzNR1Igs+N66OKUYHt71InbOiIO70iqq47mQlgi3p
         3D6/N+Qk8G/R+JmlCYuCHsysMyZpRm5PWB5SxjppE6kwbcsOI0fa6i6oiVoMnMtfNP
         D7r+3oMelIulA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.07.23 01:02, John Stultz wrote:
> On Fri, Jun 30, 2023 at 10:12 AM Peter Hilber
> <peter.hilber@opensynergy.com> wrote:
>>
>> cycle_between() decides whether get_device_system_crosststamp() will
>> interpolate for older counter readings. So far, cycle_between() checks if
>> parameter test is in the open interval (before, after), when disregarding
>> the special case before > after.
>>
>> The only cycle_between() user, get_device_system_crosststamp(), has the
>> following problem with this: If interval_start == cycles,
>> cycle_between(interval_start, cycles, now) returns false. If a
>> history_begin was supplied to get_device_system_crosststamp(), it will
>> later call cycle_between() again, with effective argument values
>> cycle_between(history_begin->cycles, cycles, cycles). Due to the test
>> against the open interval, cycle_between() returns false again, and
>> get_device_system_crosststamp() returns -EINVAL, when it could have
>> succeeded.
>>
>> Fix this by testing against the closed interval in cycle_between(). This
>> disables interpolation if interval_start == cycles. For the special case
>> before > after, similar arguments hold. Fix this in a similar way.
>>
>> At the second cycle_between() call site, add an extra condition in order to
>> effectively check a half-open interval, which keeps the condition
>> documented above the call site satisfied.
> 
> I'm having a little bit of a hard time following this commit message.
> Do you think you might be able to take another swing at it to make it
> a bit clearer?
> 
> I get you're going from exclusive to inclusive intervals, but it's not
> very clear why this change is needed.
> 

Thanks for the feedback, I'll post v2 soon and will try to come up with
a better commit message.
