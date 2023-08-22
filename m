Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AC67841F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjHVNYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjHVNYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:24:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF95CDD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKWMDcKmtuejekOqeCbDnr7yUH7dghMZRIj6VrdEcxA=;
 b=gNAtwcR9Z9I4330XPM8MD+Kf7UdKPyicDSlXdyJ0kdSe3q+yTRkiq7+U5B6xef+FxnfT9K36NJYINB4TR99qYEWXkE2BjV2m+CjlBEBO9KFcSH6Y7QEZBp2ciK/vvEO5QRFMAKfgZrqNLDxX/mG4HQpE7gAMNtrDkCgcNW7NfeU=
Received: from AS9PR06CA0216.eurprd06.prod.outlook.com (2603:10a6:20b:45e::30)
 by DB8PR08MB5355.eurprd08.prod.outlook.com (2603:10a6:10:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 13:23:53 +0000
Received: from AM7EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45e:cafe::d6) by AS9PR06CA0216.outlook.office365.com
 (2603:10a6:20b:45e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 13:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT038.mail.protection.outlook.com (100.127.140.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.15 via Frontend Transport; Tue, 22 Aug 2023 13:23:53 +0000
Received: ("Tessian outbound 5c548696a0e7:v175"); Tue, 22 Aug 2023 13:23:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1faf3aa388601af9
X-CR-MTA-TID: 64aa7808
Received: from 5f19a93bbc39.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 79303A0A-8586-4B72-AE70-5A8F214DEAAE.1;
        Tue, 22 Aug 2023 13:23:46 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5f19a93bbc39.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 22 Aug 2023 13:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXNWZ/y+vwR+Tjfaus3qSIG2mmvSjqGUMyhiXHiL6mu+S4pPXqB6+3rz6dd6Qk9B181BAcklSu1GSMdDOxvi2zbXuUoG6HI5ca8jozUj4cnPWMAw4WhOw/CXSyUAGfI4yZieFNjwfBBytwjWxoR7GhBsWosQt20bNZecUpAxIntgn6Tgnskk9WOufanGE7ctfvuC2kL8cbRYzI6NTgsBXF9BPQPEJ5q2tfmfBD9L/aJweGph4jued2QvexGrh8K5kh+a/1tx7+SIjuDT+Lot1MF6vO9Fs5aE/wJlCw4PN0HJDKUcaed12ZHmwhe+xENGHbFB7UAjTo3n53H8+21FsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKWMDcKmtuejekOqeCbDnr7yUH7dghMZRIj6VrdEcxA=;
 b=RP6l8MBRMgOH4KGdVCIyYwLsF+6Z4VFSH/DjQeVAS4xDT9SANx8o7pUk9eILMvYKz02llx0+4k0h36mPTODwDxUCSlKmC5ng1zOzbp013RkmeX4/uvG+pSigCvIooXlG4x3+sWSsq4QW7MAri8r1DFgNIFMUcAZkgjmHYbRVlS9VKgXt3dg0dsbNtyDX3w8UKkJdMIscoM7sYsPOOu93/Q7OpT8K4sFio4tsRfXHHgvOp2bNtHQH6/qjPKXa7hJafNDMWIoYDfyKDf7gif69S6nOAu23loRogdrgl1PD0ifGb1yK6Ao3xx0H+uR0YZ2qDzXcE2MJWI13md2aoWocfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKWMDcKmtuejekOqeCbDnr7yUH7dghMZRIj6VrdEcxA=;
 b=gNAtwcR9Z9I4330XPM8MD+Kf7UdKPyicDSlXdyJ0kdSe3q+yTRkiq7+U5B6xef+FxnfT9K36NJYINB4TR99qYEWXkE2BjV2m+CjlBEBO9KFcSH6Y7QEZBp2ciK/vvEO5QRFMAKfgZrqNLDxX/mG4HQpE7gAMNtrDkCgcNW7NfeU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS2PR08MB10055.eurprd08.prod.outlook.com
 (2603:10a6:20b:645::18) by AS8PR08MB9340.eurprd08.prod.outlook.com
 (2603:10a6:20b:5a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 13:23:44 +0000
Received: from AS2PR08MB10055.eurprd08.prod.outlook.com
 ([fe80::a206:ca48:ede0:ebb4]) by AS2PR08MB10055.eurprd08.prod.outlook.com
 ([fe80::a206:ca48:ede0:ebb4%5]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 13:23:44 +0000
Message-ID: <74ed130f-d191-d8a2-084c-ae096ca5a47d@arm.com>
Date:   Tue, 22 Aug 2023 14:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Initial testing of MPAM patches
Content-Language: en-GB
To:     Carl Worth <carl@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org
Cc:     "D. Scott Phillips" <scott@os.amperecomputing.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        Akanksha Jain <Akanksha.Jain2@arm.com>
References: <87lee8l9pb.fsf@rasp.mail-host-address-is-not-set>
 <86bced4f-06c1-73de-9aa5-bb23998479fc@arm.com>
 <87o7j4ba2z.fsf@rasp.mail-host-address-is-not-set>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <87o7j4ba2z.fsf@rasp.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0105.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::20) To AS2PR08MB10055.eurprd08.prod.outlook.com
 (2603:10a6:20b:645::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS2PR08MB10055:EE_|AS8PR08MB9340:EE_|AM7EUR03FT038:EE_|DB8PR08MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf4a732-9e1b-4dab-8680-08dba31307b2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Z0/FLj/3ErKWFWhbDax3elgrvuB2uLt1l8Tb7ruNk2p/ZIfI9G+bNWVafGtX6exdOBq4umlSuYEWmhejkWrX/YPZ6MPBtTFIEq7VnPGL3dC83QByP7H28znnZRSR7p2dwJCvAAoyyZwX+d6HOfJE8ZiU4CKhFRyzStbR6KggwWYmgTy1vEK1wCB9+CNVwVA/hzZUHei+ZeCdj55X/T4Abpul/EYcgyv6V3g2q+lKcmYRZxQegHlfltMbZ/9DpTFoNI8tAAomSZQFR2KQAbf0OSzlL0UuciC6VrExTHJ7Jq4fhXCH+OY4Kvd7x5Q6dvNGZEOJXpbdXk6vCJf/kpIZ7WhCbRdZV3bZ91VhDwZ7VXUtilzGGeqXjOGGzM3cL24xnTnNMBw8autzO/q7bB8kqfa2I5pdr/lAohTL5xbIETUqqVpS4TMGNq6uh1j0qxCa9UVrjwU1LU/Srq3A6PGxTS59qfTYosFuhwFWh7FSwvt4lOK5FXHhviOaSA+rWi+wwIjXMhKgZA+amV53POtg3ON0iizMqvWhaB3yZXVprGisDjEhbv3kTJxpfV7rMep1sDvJoh9xGZulexX7osefXWX3hfSibeakJUYIfrPZcSvUPYEVmWht5rpBPTzNkZm/DCi14f9UgGSLYYmrF3TlkA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB10055.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(54906003)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(6486002)(53546011)(6506007)(83380400001)(2906002)(86362001)(31686004)(31696002)(44832011)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9340
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a07c635a-f666-4084-30f4-08dba313023c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aL0yEdKVId8bLUWr9lCo70l+KABgYHO4zZwUMIjZH2O8mYxyt8BJGIE4Wd32/8ZH78QqjJN+ojFoct+zG4XknCr94FaNotasDyuxMnVJLnk7jUV2bFfrt1O88vMAUx9vsfl7/TtGKLI5XfrmSOWdEWtXSNP5khem92WDmNvGFDtkoVjm0p3myQ/EMVFECKxO3DTB09EHhF6lB5Dhe1ADIno4C2ZXSu9yXpUjjPdTk/OU/W7O4QxNQIlFA28HeuTCTii8uatHbR/WnLryP2YNY4hNjIvj314jOuJqPEHKbYwMI8HxnXm7RNI9JWMSrcNOaLJN6LL2RHwcveu00HgBibx9kC+NtSBy9HWUUOKfzfGch+CmRq14T4Nt4ttQ8mq1ob2ckI27Sx3iYSwaQBEXsUVhYCy5lBgVf7bfrdok8iwRmfqNGVZ5ZxX6Jyr1LH/Mf0sg/3VzkNb7tLsaYjN959nW28s+PSdjwURavLtGYiVMO4g8HplnRdIgQwwDsSnsUabBcWB0kkdaXrX2KmzKVReLlihnC1Xw6VOtujsk+uY/EsmqhjOBKpHKgM83V5QL2aP6kdjhL/+UbKrKji8Dcha+E/qUZx0aSRKzFB5KlUzUIZtparYNafdd3CsxZarXXS94lRW5xhNC6aJwHasKY6Mmlqs4YJiVheJzepgtHdGQbfD8vjPHFLjApVKZoE3rTwYxwthb8hbsGtvtVdV9nlYiSzSNCpJPT8D3Z2zwZE3+dm7Lug2ICzB1DHKMo9Bku2fVBhW2HG1xRtQVQrnqg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(316002)(70586007)(6512007)(70206006)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(82740400003)(356005)(81166007)(478600001)(6486002)(53546011)(6506007)(40480700001)(83380400001)(2906002)(86362001)(31686004)(47076005)(36860700001)(31696002)(336012)(44832011)(5660300002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:23:53.1278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf4a732-9e1b-4dab-8680-08dba31307b2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT038.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5355
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carl,

On 18/08/2023 17:15, Carl Worth wrote:
> James Morse <james.morse@arm.com> writes:
>> On 18/08/2023 15:13, Carl Worth wrote:

>>> 4. The current schemata allows for cache portion, but not cache capacit=
y
>>
>> See KNOWN_ISSUES:
>> | Only features that match what resctrl already supports are supported.
>> | This is very deliberate.
> ...
>>>    Is this due to a limitation in mapping MPAM to the current resctrl
>>>    interface?
>>
>> It is. Getting feature parity with x86 is the critical path to getting t=
his upstream.
>> Supporting other bits of MPAM can come next - we'd need a discussion wit=
h Intel about how
>> any changes should be done, so that they can support them too if they ev=
er have similar
>> features.
>>
>> This conversation can't happen until we have some support upstream.
>
> Got it. This approach makes sense to me, and it's good for me to
> understand what limitations exist in the current implementation and why.

There is some noise around having a discussion about how we make resctrl wo=
rk on wildly
different platforms, maybe at plumbers, but there is nothing solid yet.
Can I share your name as an interested party?


>>> 5. Linked-list corruption with missing cache entries in PPTT
>>>
>>>    At one point, I tried booting with the MPAM ACPI table populated
>>>    for my L3 cache, but without the necessary entries in the PPTT ACPI
>>>    table. The driver fell over with linked-list corruption, halting
>>>    Linux boot. I'll follow up this report with more details.
>>
>> This kind of thing won't have seen much testing. Any details you can
>> share would help!
>
> Yeah, I figured as much. Since I can replicate this I don't think it
> should be too hard for me to give in and root-cause this bug.
>
> Thanks again for the quick response. I'll do my next testing against
> more recent code, and I should be able to follow-up against some
> specific patches for the couple of bugs I identified above and that I'll
> look closer into.

Thanks,


> Beyond that, I hope to be able to provide some Reviewed-by and Tested-by
> soon.

Great! Could you do that against the most recent branch on kernel.org?


> I see that you've been going several rounds on the earlier portions of
> this patch set, (the parts that refactor resctrl to prepare for
> things). I trust that you've got that part of the process in hand?

Well, its been going on for years.


> Otherwise, let me know if there's anything I can do to help with there.

Any review or testing of those patches would help. The maintainer needs som=
e indication
that people want this stuff, and it's not just me!

I CC you on the patches, but lately I've been getting 'inbox full' bounces =
from your mail
server.


> Again, I haven't been looking into details of those patches yet, just
> testing to ensure they work, (and so far, the generic parts of resctrl
> seem to be working just fine for me).

Good to know!


Thanks,

James
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
