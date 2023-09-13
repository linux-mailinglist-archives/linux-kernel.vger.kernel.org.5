Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3E979E340
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbjIMJMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbjIMJLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:11:43 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85251BD1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:11:36 -0700 (PDT)
Received: from 104.47.11.175_.trendmicro.com (unknown [172.21.184.89])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 8441B10002ACE;
        Wed, 13 Sep 2023 09:11:35 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1694596295.049000
X-TM-MAIL-UUID: 6b5126cb-5e7d-4526-ac76-a63327a7698e
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.175])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 0C49410000E25;
        Wed, 13 Sep 2023 09:11:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoSiyNEyrC0TfkEnOonLqvPdVUP7UkttCRyZUOKWhkkpjawC8fl8KNPuM6IIO7F3HeavBR/u2BUBaqSr+xlsdkRvNywUKh6LbraEPCdNPYkVFi1LdyUTX0rMaX94dI3xecvJS/Hz4GARDvUoO3AhcMjSe12MaKYglFpxywXg7jYnohPYz9Avt7kw2t84N2vVT+EtgQfr4CV3xq1RThUJHKnEMMw8V4BSCAM4R7RjH1DQZkODKFZkg4v85MG0Rg+SNeQ6gV7G4KDUlJvcYRQuWTcFeG383isLkLa/o6OKnzGPo8lJhDaYeoRo1ILj8yRaEJA9R6J/w0/bmvqr6gc+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIp3kHIKpYaCIkzca3wVCVix0vmDmYbLs9ThnUxuRrk=;
 b=jjqxxsmB1hgopf+B2Q6TFWuCohpXqrWXQYeBuU3bLGWrMGiRlGDMYsKDVeMCBntqk9JpKwbl6RWW+ycnKRnRUqwxpyPwOMubs/48V2254uooDdawGlwKLzZ3F+AK7jO5Z6koSSlBRavQQrwS1xNtpPey9NPyAEgUET+va29Gg5/Y52hLOn4V0Wkj5Uq/tPuMKJpG8JMoMWuvskG8UrpKzAf1hjMl/XM3QaaVEWloBie2jcN7gJtqNKJBTf9Izh3rCu2fsJ6jypLVWflilNRP3XOFtdwRXwBRX2awZ/A8Mus/RZgItpgks8Dk6Gm91VpxXsw7GjIBpcoC8xOgU3Q2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <efcc7ddf-8845-11c4-fca7-0eecabfa64a4@opensynergy.com>
Date:   Wed, 13 Sep 2023 11:11:33 +0200
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     John Stultz <jstultz@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
 <20230818012014.212155-4-peter.hilber@opensynergy.com>
 <CANDhNCq38sESJqYS8+onu9G4FS--JR6pF0fA6wJXwSDon6QkRw@mail.gmail.com>
Content-Language: en-US
Subject: Re: [RFC PATCH v2 3/6] timekeeping: Fix cross-timestamp interpolation
 for non-x86
In-Reply-To: <CANDhNCq38sESJqYS8+onu9G4FS--JR6pF0fA6wJXwSDon6QkRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::8) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR3P281MB2158:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d582dd0-e655-4897-bc96-08dbb4396d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMmGWcXheBvSfB2AoZYWEZMFgdqhbxM3Q+E+Y34c/wKmc7MA/MaoZHqOt/K78llYqiMCPSVvanx4IaIhS4j7WPfeq2j4UGR/CAdIt2ljqrS0yElQHO0GATvRMFQNx8a2l5Wzku0va5ucJIX+LJeZzuNVLoLw/m1RflwM8rX58Ub/GH4cHv0+KLBbu+h1Xx/hF3tr3Wd+5XPUF5MYSKoje02thcDzkaHFahgOvad2nzo98iB7D4JbT8w+RNcqY0idpybBXs/iIdHowFV0J6D7yjZJWIMW3zOcSMj4ez93nxwAZGdQji1DOdV0teG2s5BI0l7uOHU0RzwSP5iTZqodWwnoaq8uYL192gdmKOgOcT9fDI0tEJzgfMCNoqtrQdfN4yc+mwl+0vIkwJ6CiRqP7BEb3Nt20zTfnfmG/+UV2qczb+ptg1R/YxPiMhsrrnzA68OuH8zy8neLfeTZW9UC+GaFsRlkvta/QGKsh7K4Oyr+yqUxuIF0UCl6mc1CO5mjRIhqK7scEhf1BAGgcowZaqon8DxYfvWc+qIIz/DVhwcerl48S06aBNHEEoPoR8LIRTjcPKwM+0jItF20VAaQgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(346002)(376002)(366004)(186009)(451199024)(1800799009)(83380400001)(478600001)(966005)(53546011)(36756003)(38100700002)(31686004)(66476007)(66556008)(66946007)(41300700001)(2616005)(42186006)(316002)(54906003)(6916009)(8676002)(8936002)(44832011)(4326008)(2906002)(31696002)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T05NaVUzQmFqZVVXUmFnVXc3L2E0a3dzL0NSZlRDREkzQUVwKyt5RUxjRk40?=
 =?utf-8?B?bjFTT1kxcThGcktuU2xpY3NWenp1RmdmOXpPM0lBVUJpeTE2YXBnMFZLQTBB?=
 =?utf-8?B?RnhDbUtpQzViN0pHYXkwNkkwWTNQVkorbkI3b1pQaVJmQXQyUTRnMDQ2QTlq?=
 =?utf-8?B?d2gvTHluRGFXY0lhOHNRakptQ3Q1bTl4SzJpYk9rdnJ4NEVCNUQ0VVV6OFpI?=
 =?utf-8?B?cnhSS0xEeDFsN1Vuc0RZdHhFbm5EaEZUQzByRm1EeTlNZXh2TjRPNklOWTln?=
 =?utf-8?B?RVFtWXRLakVmd2hwUVRaa0VIVXFYSy9TZGdiLysrbDNXdGNIYmNPLzFxbE1G?=
 =?utf-8?B?NVpJcUJKdGxGVHV2UnZYWjBmM2VrRVBQaURjOE9vNXJKOThZU3pEYVF5emFu?=
 =?utf-8?B?RjVpeWFRU2pYUW1RdHV1c2VFUks4QVBZR0RBT1FEb2pNTmdDRGV4a3NsYWx6?=
 =?utf-8?B?VkU1dVFDZmtJdlVNUWNqaUVyVEZZUHdLMWRVNUpZRFowclRhT2hnZkpBaE9I?=
 =?utf-8?B?NGZQdTNoV0hqNXhjMjgzMFJjVXVFUyswMUJ3WTd1c29xYlVjaitabFJFbFMy?=
 =?utf-8?B?UVJLeVBYQU1QU0o2NGtseHNFMEVUazV5b2NMVmdHcXRkMVJEYUp4eDVtbzZj?=
 =?utf-8?B?YjNzd3pmN3VaNDJOY1BpNmVlUXpRSGR5MjUzQlk5V1hFOW9lYVgxTmQ0VjQx?=
 =?utf-8?B?YUxQWDJnU0JXS3VBRmF2aVNGK0c3MXlqMW9FblAxTjNDbFRjMTVWNXM4MzdJ?=
 =?utf-8?B?UThUeHUyTjZkeG5SVTc1Z0taaEorQjlBVHpkUXRZQ3YvbXV4R3ZLRDZvUWUz?=
 =?utf-8?B?YXJWc3hXU2V6dzlPVVpkcTNpeVJuNVJHUTd2bXlkdHRMaEp6MTFxUWZ1ZEw2?=
 =?utf-8?B?YUlIMUw5aWtWUGJVQ1U3dHdUT01hTy95VUxUVzFud2pQLzNlQlRJc2lyenZG?=
 =?utf-8?B?SmhRbmg2bFdjSDZnakZWK0JOYWkvNjFjMUtPejd0cFZmY0hJNjI0bG50ZWI0?=
 =?utf-8?B?NUlkbkJTV0dOWmhlYXBSMTRvOUxJT2RpLyszYmlWT1lJZzMzK2drNnRYNFYw?=
 =?utf-8?B?akFVWkkyc0x6MFpBZGFDZjJXcHhhZkVMNHdybmFCb0lKNkVYSzFpS2Z0Q0Q0?=
 =?utf-8?B?dHoyT0RncDVwYktsTW1lZ1AwOXhsSEpIbC9CTUorTkdjUTIyRHp5a3FiSms1?=
 =?utf-8?B?UDZ1Z0FmNG0wc2VMR05RVWVSVHRIaVYyR1JiQUFDZElpWkxXWVZwbHBYMWtn?=
 =?utf-8?B?Z3crcTNGanVtb3JFUHpZSDVKblpOY0J4b0d5ZDFuSWZOU1NwbDFTSGVtMUhG?=
 =?utf-8?B?cDVUTUdvTExLVHF0MTFTVVVic0tlY0NmUkIzVE4xaFk4VWlRVUJvYVlXTk1u?=
 =?utf-8?B?cVNwNnptK29HYUNTSmFhcXR2QzhqZTNJTTQxMkNaMHBaelh6UDJzelA1cVhP?=
 =?utf-8?B?djc3UTlQT0w0QWZqRHRaQUtiZDZoN1FlUzJSdEFPaXpMNi9RZ3lrR2pJNTBI?=
 =?utf-8?B?QVF0MzNDVHROV0RXR2pHVC9qSXgremJ2Z003ZjRkUlc1U1NtcmRIWWlMSTZw?=
 =?utf-8?B?L3pLYkFpejZabFQrMDh1Q0JOdkNYWDBVOGhZK2hPUWFITEdRU3pYTnU4Ri9U?=
 =?utf-8?B?ZGNVQUVWT0VJVHJ0ejdVbFBvUjYyWmlGdDhCSmt1RzFMaDFaRTFXK3VMNjVo?=
 =?utf-8?B?Wk5nUHBtWVlidHMvLzBCNStvVEdGR2lMQldKRE9VaVcySG40Y3A2UEFoOWtN?=
 =?utf-8?B?K3JXdExHRktiWmpKTTJNME9sZkdpZnZNaGdOM2lHdFlqMm0yQkp0eGdNbW1m?=
 =?utf-8?B?NE9vMjZRQWFFSkxqSjh5MGJJZm1HWmNJc0lDc2xLcU5oWk4rak1CNVJrNERE?=
 =?utf-8?B?Z09GbzhGaXFuenpCdGFWMHdjdVpJU1I5ZERON1RiZzBGcDdKTWJ4b1RLQWZu?=
 =?utf-8?B?V3RTd3dhQWdzSXNhZDZlQ1Q5eXFuaHA1UG9nR0JRQnBmTUVRZWFldFdRNjcv?=
 =?utf-8?B?Vm5jUjRGU2taOG4wVW9ocWIwa0hoRCtUTWEyTUM2UnZLRTd6aHBXaVg4cnZT?=
 =?utf-8?B?eHpnRWRETVFhMW9zeHovQVhjUEpPYUhsdlJJM0NHQ0Y5YVplbllrRXNwdzdN?=
 =?utf-8?B?WTZtQUpWMERjNnc3a0Y5Q3NKNW9ZMnV0c3FIa3FkYnFyOS8yWnhGL2F6RVIy?=
 =?utf-8?Q?72O8OubzN61jdEZkSQQG/qohHsizX3ujrEe0UrUwqKIi?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d582dd0-e655-4897-bc96-08dbb4396d1f
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 09:11:34.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfWCJgltIQ8Cqimw9eCdVbImMVGq3yVEkKI00yXUIsQ8702HYbx1X6o4zMw9Gq9+uMOaHyRzqYKExU6BnsqdVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2158
X-TM-AS-ERS: 104.47.11.175-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27872.006
X-TMASE-Result: 10--10.996200-4.000000
X-TMASE-MatchedRID: hls5oAVArl+QE1fty08IdQw4DIWv1jSVbU+XbFYs1xKg62lZ0XktG7iQ
        iEAegnEggz6FtQoDz5dNp0sviAtK3JFgEkCu6tBGpKkqM2JIYKMVD+MNVApefgsPNAkPeS3QnpC
        jSr3WwLrmsvBYT5bFloaXmqFTVGg6M8VWyP3FqfORj0jujuSQmjk2uMRKx2X38lYGTsjEXz+ev5
        1bGmTwSIUSVitOzZw/aDPHDhDl2O06P625LmYMOasfKpArFTPACMiEBPZ3hhWHAl2VcE9fOcStu
        Xj96+1kdF/3Aype0efrEDQC9rvecA+bXnHKG3yVJPlTeUnhPwqs0m4CN4NCDVo7GmCOJYd1+Tf0
        tcxKuLrhMry6OGhKZdXfccwrD9Y4R03spMCKw+pNfJyb2YfPuw==
X-TMASE-XGENCLOUD: c11fd891-7cc6-444b-8898-27df1041ddab-0-0-200-0
X-TM-Deliver-Signature: 2B968D78304DC003539288F83ACF3634
X-TM-Addin-Auth: OHCPMaH/khs26L9CVFyA6Y9NZJvl+theZK2rXW+JEdkb2GsdYvX/bttjDYT
        PpAnUvl96ELC8N/haczzcEwdhTGBZ7bdPILdvRauNSQNR4e5PmH6ZCJJe6kAC3cpY7jgZ4g216S
        MTsD3YScbr8vpy8pfpRs7qrH+QpGU9iLZSteAQvr+03FWfMUlcln38DqJKTtiSeiZOJX92KWfXq
        zxGbcwszjQYFSU5tZGTH+0bTesBJPTKcsmWpFrW0HOe2Ud81831PMRZ2kr/J0QsWQHHl0YYwd0c
        DBbv4jJedQ77pm4=.hH7U939ZAPXzXuXkMtkQe93P1mCx7jj47yK8Cp8D06n1Hy1fHzzbChG48O
        rYd5MKov9HrAbKOofwIh9kUOIV+nCdec11Y0RWbPNbFortUXva0dUZZQSio8+Md+T1hkM/f4HT/
        RDN7axyv59d7Jua92kjgdbgzkOgO438lDJLIYjUAs5cbbhjJBZhp3WGCIShlqQ/UOtu8keOIWPS
        SPVPvyLFPnFZfhxRInmnr6knYr8fQapsQ94QIiThDV9OWlqdLDVMF3YKLUMUxPl+Q6cdnx0ecqb
        2AHpL3v01wBix3cGKJn7b9f5sz13w4JZ03P5DXnlzDxalH9oFly+lupEtJQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1694596295;
        bh=NxcYjDLIYYWrG0kSz7ZIwC04oEbsKQCYfYp2tkOjATo=; l=2000;
        h=Date:From:To;
        b=J/NKAaDg5OYc9cB6XSvVLYkxWq0Qg3wPjashkwSbRA62b7v1hmpMJ3l3qtimXfox8
         KWQDBq/p6KKVk5xaezGvp0fNV4ScmqBujcvMlW1OAktA6ypsd/HQq6IyNBeAqypuBL
         TWmEqJtpcxGp1taCqKQRBH1HwOO10DgmbehVmJQLXYbZ032q6K/jfdAa5s6r9Xjlm5
         EJbo4BUagoaCxjpGkOVZVpC5gBIz3pplO6codK+zT5Q93Yy9Fy5GhRpJQ8TogVU1yK
         8oCwgNOduPzPrl6SYpOCJvvsUE5w1lKhZh2072alZE7iLrjBPnc0HkUUHb+kvrtbPn
         v/XNw8oV2n3TQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 6:04 John Stultz <jstultz@google.com> wrote:
> On Thu, Aug 17, 2023 at 6:20 PM Peter Hilber
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
>> Fix this by deriving xtstamp->sys_monoraw and xtstamp->sys_realtime from
>> the last update time when interpolating, by using the local variable
>> "cycles". The local variable already has the right value when
>> interpolating, unlike system_counterval.cycles.
>>
>> Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
>> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
>
> Thanks again for iterating on this.  This looks much better!
> 
> Now, I've never had an environment that used this logic, so I'm
> trusting you've tested it well?
> 
> Assuming so:
> Acked-by: John Stultz <jstultz@google.com>

Thanks for re-reviewing!

I did automated tests with various chrony [1] configurations. The tests
check that all PTP_SYS_OFFSET_PRECISE2 ioctls issued by chrony are
successful for a combined test time of many hours, and that the
cross-timestamps look plausible.

I will add a description of the relevant tests when changing the series to
non-RFC.

[1] https://chrony-project.org/
