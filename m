Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE777650EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjG0KWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjG0KWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:22:07 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA819B5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:22:01 -0700 (PDT)
Received: from 104.47.7.177_.trendmicro.com (unknown [172.21.162.147])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 69A3110000C3D;
        Thu, 27 Jul 2023 10:22:00 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1690453318.484000
X-TM-MAIL-UUID: 49a3a5d8-5b29-42c8-b250-b79c1ea3e974
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.177])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 7668610001791;
        Thu, 27 Jul 2023 10:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS83PgazrKaasbJhkxzlSZPeBxLtBysGXXEmmVEV471m+XmduwQit4PRLssU2eoGEuj1YUh9lPgA/rYswuZNRkL+FLdAkurgmfDI2wA0T5qyHuZVOcK+n1O2KhMW+6PW4E+QVcgNrUSW1s3QU8N/nLK+cIaCkKGySiXZM4rcE0T3KGnAb4ebSARsgpXBc3n6g10ffAz5RKSxQYAd1xhZHmt7ttxuwKe2tk/4Z6eABnGbY4PsGPyYl2pz97lCqgMlyoCCvMGdFfCBkJeO4gNT1f2ybo/6l7UusttX7afHavtnpePOmU/d3OLJ66RTOV3aPkolh41Iop61dJvbO/85Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24UvHhNZgSFGy9y1j3S6/YJyS3iJgGOGgii4RS0mGz0=;
 b=hSdiW0iAP7uHHYPzdhjwdrtoUuPRz9RucF5e2HpJN8e4OsWrdkABJz4Nag4paSYaFGH91PJDmXkcoFqVRjqIkNzBCXRWsaUsJZwbA2zP3r9GdJiDLxrHN5VG6U0gn0gXqIxJ1wXf+L7o/95viSkkTx3uOLuqWusyEJzo/RhazVjrDrsv7etL8WWxYkDGn/6e570HGfd55KAdfY2KHWKg908oda9Km6ydsPYUC0DyRj8Kd/UovVHYNsN3nALVHoaA8YR+U+09JfJ6gyc+CHbenDabP0akPWSWwlRY+MyxzvRCa/hsAf1WjRw4ksCeXYR0W8x9xe5OM3y/G6lLNYW3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <e508b3a4-21b9-e921-a8fc-b7913f5a2d4c@opensynergy.com>
Date:   Thu, 27 Jul 2023 12:21:56 +0200
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     John Stultz <jstultz@google.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
 <20230630171052.985577-4-peter.hilber@opensynergy.com>
 <CANDhNCoi4OrtXdqs4UErhM0ofecdg94-Yew2NETxhpKkDojt4A@mail.gmail.com>
Content-Language: en-US
Subject: Re: [RFC PATCH 3/7] timekeeping: Fix cross-timestamp interpolation
 for non-x86
In-Reply-To: <CANDhNCoi4OrtXdqs4UErhM0ofecdg94-Yew2NETxhpKkDojt4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::8) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR0P281MB1483:EE_
X-MS-Office365-Filtering-Correlation-Id: 99647102-e660-4d69-d94d-08db8e8b4e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pq6zduTXc8tefZIvqGFHVqvw4Fdn8kcu6kXhY78bXPRz6TnR7wzdEf7rQTfLFlX/dz1peqQgvbQRZwbEKIX6klfz72QnZ+A4+OXKp6UlGLca5YKmzCtmBmCU7AChG+NirVPWrHBnQVv/YUOOPW9BUCGkhSP8/LD1K9xDK3wNaavBwbD7aU30zdAicqRy/xnK5/uXhW4myYWKuXidD4SPEiHjiAETnW9UVDPhiaKGH25eXwZLUkYtRCZ+tn/ODrOZqNcyBElMqKxauCXK2KwDhhIeqzjP1vZ929cliAvWYaLfpoOuhsSsZYGjcOZCdtZ2pC88zMROGDWtrgiO7ozi7cnZKt41/fyzw8U9E4aw0gPXJhbrZgZ+tIb7VvDPT79yn9n96Qafl6zPKZs7Geowt0WHxOXGTQ9uykMCiatUnd8Nt5DEzSn24Fi5eOYwWxmJF/69/CXXzg9EaOPwdI/em7oIejjv9gadR+XPz2ojajbyddkqV0P+oc4BdZ6HXf8V+adbYR5e7y0j7vC2DfFo0c2PoUGeVsXWQ4ohkrZsx453RVuoNQOFJKY4W++4vRhA2cTTm6z2oefi0ywQ5UorfwvaRE90wAbgERJcyZ+MmWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(396003)(136003)(346002)(376002)(451199021)(186003)(31686004)(2616005)(53546011)(66556008)(66476007)(4326008)(6916009)(66946007)(83380400001)(38100700002)(316002)(478600001)(42186006)(54906003)(8676002)(44832011)(5660300002)(2906002)(8936002)(31696002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmU3T1Y5bC8xcEwrSC9DVHdZdW9ibUJ5K1RLUTBZbUQwdFE5ZWdaY3NNa0N4?=
 =?utf-8?B?VDYzcDA5ZkVsMXZWZlF5dkVVakhEVWIwVkl0RWxqTlNTM0VMTHRDRXVrMlFT?=
 =?utf-8?B?N0ZOVEpGR21NUUVFd0ljSW5DTS9VOGY5cFFsaUZ1Z0hGb0Zxc1JzZzliTnFI?=
 =?utf-8?B?cE5wdUYyWWxBREVmNnVqemdacHFhcE0yQ0ZVSlAzVWhwQ1NaQVk1eWJZVW9J?=
 =?utf-8?B?RWRwTXZMYWM4SUxYTCtTQ2hPWFdvQjJrMVhXeXprTVArNXJ0bW8yM0ZHWFFF?=
 =?utf-8?B?VCtIaVJ2bUJqbS9udk5weFpGZWdKcEU4V09Pb21BV1ZRUHpzNjZ2Um9NZm5W?=
 =?utf-8?B?U0VmWWtFa3VuMHVnMTlYd3FQTm4yZ1FxZjRHd2ZkclUvZGc5dDh1cGkvL3la?=
 =?utf-8?B?ZkFmeWZZQ0dSOUtocG9zQnRyMHpybi9DTG91RWY3RVdzakx4VE5GZnUwSExo?=
 =?utf-8?B?TFBCQVl0ODlNbktrMWxjSVVhZktxbDN6VUlsQ3lxZmpMK3ZPMDdFY3J4clpz?=
 =?utf-8?B?TnpxSXdnaStuZS9qODJxYmVhRVRuVFBaZ3hCUVBvRGowTk9vVlVuRklsOWhr?=
 =?utf-8?B?aEhmZnNKaWhOSC80SS9xeGdndkV3ZFY2dmhtTjVPMkRPRFJVYlI5SnBsNjhJ?=
 =?utf-8?B?SVNLY2R3Y3VvUXM2OEd4dVZvOEh2ZTFZbjN6Uk50VEFpWExpbWt6Z0JWZzE2?=
 =?utf-8?B?ZWhkYlZDTGphbDZBTnBlbVhjcFJSWnRzSWUxVXVhVlpacFNHYlAwY3Ewb3Rt?=
 =?utf-8?B?QkcvQWlkRWZyS2pJbG5RU1NJd3hsZXYwQW1ROGYyRWpGVUJmb0g0Y05kSUlq?=
 =?utf-8?B?ZXdnTzQ1RkVyUktuUUxDWk43YWk2OCtVdVVId2J4Y3VERGtIVzY0eExWS1E3?=
 =?utf-8?B?cDZqck54TWxlL1BGUktLWHM0SVlsOUo1SjdjVTc2Z1pJY0FKZGxseHA0MFBp?=
 =?utf-8?B?UnE1ZCs4a2dXbUNWOHBpempYZEdiakhYT1BTNEgrQ0NHb0hMV2NnWXR0NTZz?=
 =?utf-8?B?NnNQTzlsZkk4dGRLb0RablFDSXlFVDNMZzJDbmJOQmp2ZWoyRlhabWdnWXpv?=
 =?utf-8?B?c3RDOE9mT3FaTjlSbG4wTmhldDNVcWdYdXdTK3pQTEhoMkVIa2o5UkluOXor?=
 =?utf-8?B?dnVGODY3RDhTSU4wK2RsWVMxYlVxUkRKTDRaVXdNZzBHQU5pclF5L2RhWVhS?=
 =?utf-8?B?SkFHdnUweHdvcVdhVVQxcVJUblZoRzluNnl5YWFBeDliV2NkYnVYZnpwaEIv?=
 =?utf-8?B?UEVRdEU0djlFbnd2cjBsUGVYUjRrb0l3dGZ1aHFkaFc1SUtWc1VDV0R2SXQ2?=
 =?utf-8?B?NDRhVVV0MTJ2L24rbVdpdnR1Ykc5WUc4c1JmRmVGY2ZlOXpTcUV2YS9CZUN0?=
 =?utf-8?B?bTVxcHozZ2R3VVdVTGJiYjMwZWRRVlhRVzFXRXN4VHNZZTAxRXdZZDZWNGgy?=
 =?utf-8?B?NXBoZXFCcWp6WlE3aXFTeHZUdDI2U0J1YStCOS94V3FsQ2pwdFVNeEtScFVL?=
 =?utf-8?B?dnliVjNiWVBDVmtYak5sU2RwUGp1eEhmMEFsOWNoNDRxRW9WVnpvSVJnV0or?=
 =?utf-8?B?Smtxc2UrWEpjTzdpOVhsYldXTjFaUDdHWTFVZDRON2gvQXJ2czRYbk5NdHZG?=
 =?utf-8?B?d0hkQkdITlJtK0dmelJXczNhSmI3L3FMQ2tTL3I1ekorT3FGcnNTV0oxY29m?=
 =?utf-8?B?ZlVZRkt5b2piTExIM0krTUtvNzNHeTdPcjNIQ3FYV0l3R240UFYyN0lYeUVn?=
 =?utf-8?B?SzE4ajZWa1BFRnlJUnhRSnM1KzNMRzRQRnlwdUxRZit3ZGxOcEVSc3pMdXA0?=
 =?utf-8?B?TnVDdmpRdkRqRG1OTmxRV3lkRzB4cTlRZW05Vm52Y3hlWERzMlBjZmpBK2dI?=
 =?utf-8?B?S2hYaUxjdUpXZVpYTy9KMnpNNW56azdMN3FrMmlXY0xDNUthYk9hUUlnOXc1?=
 =?utf-8?B?V1JGZWtKMkVkYVR2TmVOeUtTUjFqTjJYWDVTcVBGd1hnL0xETmFrSndac0Vh?=
 =?utf-8?B?TTk2VWJJYVZ6cW1aa3lQU2tSaE1BZEJEVk1kU3NmY1p0NnUzdjFIcjYvbTdW?=
 =?utf-8?B?SGxvb2x5c00yZHlUeE0zYVBBSjJrbVRTSUlnNkRJU3RHQjJVWFpmUzFwbHhT?=
 =?utf-8?B?NnhFNnhpNXBmRXJDQ00zS3V3WHpOT2hnYSszYXJOMUg5YjJnM2w4bFN4eFlI?=
 =?utf-8?Q?elA4Ba47P/U4qQJG0CrK7+Cb270YlIUgEyPVwR7Wd1fa?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99647102-e660-4d69-d94d-08db8e8b4e47
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 10:21:56.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 104OjoEhnS/tEGiB4NpwubsxR/bNs7PlinT3YMGK1OEeh4GF39n9mq7oKQC0EaDtWbCI3Pc+SsZ7d0RQMEWtgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1483
X-TM-AS-ERS: 104.47.7.177-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27776.006
X-TMASE-Result: 10--14.575800-4.000000
X-TMASE-MatchedRID: L8tZF6zWW2pTzAVQ78TKJRhvdi92BBAuxgiPAz8l1fscZzGOQm4bA9J7
        CoYPDdZiw4pi63ExcfW8kw+qXId8VXnlb5Hl8fLpJOyPZ8F0fn5BqFX02wvtDz4DzKqGgBHvJYP
        b4fzEodg0l64aptIzVyd4HaM9R9x8+3U5p103tDMZD7bjq+6lMGzY00haS8Qo2ubnxCjreJ8j4/
        Z/wyn0CFuvsE1FHKUHw+a7hq/6IHaoimPESh5yIbIyl8KAIcW/cnxszfxH2Ckmx8kl1Wnd+q+eC
        SMeOiOkA/lH/MvdoiYmkrgX3CciJjsAVzN+Ov/spwpj7FQJcyeaWgMB5xhkxXU6NJ3IsyGzLlSc
        ukoskw+lazXi8LuT/A==
X-TMASE-XGENCLOUD: 1f83c242-2c8c-4964-b12c-89a366aafc01-0-0-200-0
X-TM-Deliver-Signature: 50F060080D87913FAFDD92BE752EA6AE
X-TM-Addin-Auth: RSyherxdSbSMLvLFThFrdk7N4ESGbt49kgIBZJwuFErHuBLZNDBzEcODyDL
        m220ysrCOTBA0XPtpP78DWb7/Qyo1F8icJ17zcDci+n3bZyKc3VWPnpu3b66MfLkA9mLLwOQOJN
        IQNqqW9k2PnCnJ3zgf5meEYWKpPGOqTTXSkc0FRFiPKjHG4tE7FV6XsOMk41eaaF1E5xmASW+8D
        XnjeUvwhQhCN15DyftEdGt0Ljh631bVQsvClMVZJmZpsw47XJKjJmPkJE3vRrtuHOeo0ksfhIsq
        nUZqklj8KExOp1Q=.F2w2TH+ZC1SlalEkHKRjssmJhPJ2A4HI9OMqhqPznsPq/qJo2A6wxqo7/1
        5TjXczfg1KVRhg/PIP9hguMJ/edgI8i4YIawqZoUqOl3s9vvWi7MjOEHrqC2MVhJ4o2iS2oCEkY
        okhA3/i1GGZawvUkC9uFTn7RREUMZVIduZbDghVWw624zGH+4E7hkoU30HhIATmHfyRAb1sev4y
        l/gPWajJS0CYsmpyw8yA5eYPNXoTF9XVSCIvTG0OQmLcA7ncO6vNHxB2hbdJ9JwVPqh0ZvzsaIH
        cmejOREsyHKzCTx4+7JNnqPCsgvHQHOon/SNm0l36XxuoOfWNY8bPNVhFmA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1690453320;
        bh=+xtz3tMAa7gl6/yMuPYjNuPDC+tvRKu4jIFZZYLniUI=; l=2721;
        h=Date:From:To;
        b=1uGMatrhTCabMfd26LKUwmF+1xpLWrhuNWB4s+lxeXVRrFHGx4NIezMg4mPRw8p2h
         ZXQEHuTb8xqxQR5GDszEh5EuiWlLhTMp3t2RscabLmcJ1tbc1G4MKwStVoXHPK+iwJ
         ryEoi9g6PcryzxD7e4b7XISsjCrwT2N208ffxyTCFoz217oXIfjHbG2cUHY4QfsDia
         /GKqHpRPtBmlpvFG3JM7g64tzgWvFo34AWJkTaA9TkSIX4A72I2dETxJbP0IvkKZUE
         OlmY8ugIP0jQKVRa1UECsV4Q7/7qu9xQ/1jieTbhkkbGj407ohjlFkclhLAVnWiMpD
         f4P0w2SGBbskA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.07.23 01:31, John Stultz wrote:
> On Fri, Jun 30, 2023 at 10:12 AM Peter Hilber
> <peter.hilber@opensynergy.com> wrote:
>>
>> So far, get_device_system_crosststamp() unconditionally passes
>> system_counterval.cycles to timekeeping_cycles_to_ns(). But when
>> interpolating system time (do_interp == true), system_counterval.cycles is
>> before tkr_mono.cycle_last, contrary to the timekeeping_cycles_to_ns()
>> expectations.
>>
>> On x86, CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE will mitigate on
>> interpolating, setting delta to 0. With delta == 0, xtstamp->sys_monoraw
>> and xtstamp->sys_realtime are then set to the last update time, as
>> implicitly expected by adjust_historical_crosststamp(). On other
>> architectures, the resulting nonsense xtstamp->sys_monoraw and
>> xtstamp->sys_realtime corrupt the xtstamp (ts) adjustment in
>> adjust_historical_crosststamp().
>>
>> Fix this by always setting the delta to 0 when interpolating.
>>
>> Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
>> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
>> ---
>>  kernel/time/timekeeping.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>> index 7e86d5cd784d..7ccc2377c319 100644
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -1259,10 +1259,15 @@ int get_device_system_crosststamp(int (*get_time_fn)
>>                                       tk_core.timekeeper.offs_real);
>>                 base_raw = tk->tkr_raw.base;
>>
>> -               nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono,
>> -                                                    system_counterval.cycles);
>> -               nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw,
>> -                                                   system_counterval.cycles);
>> +               if (do_interp) {
>> +                       nsec_real = timekeeping_delta_to_ns(&tk->tkr_mono, 0);
>> +                       nsec_raw = timekeeping_delta_to_ns(&tk->tkr_raw, 0);
>> +               } else {
>> +                       nsec_real = timekeeping_cycles_to_ns(
>> +                               &tk->tkr_mono, system_counterval.cycles);
>> +                       nsec_raw = timekeeping_cycles_to_ns(
>> +                               &tk->tkr_raw, system_counterval.cycles);
>> +               }
> 
> Rather than adding another conditional branch here to go through, why
> not just use "cycles" instead of system_counterval.cycles as it seems
> to be set properly already?

OK. Thanks for the review and suggestion!

