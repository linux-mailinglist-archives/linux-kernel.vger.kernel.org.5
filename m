Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F137FEB89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjK3JKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjK3JKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:10:03 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2101.outbound.protection.outlook.com [40.107.7.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0075B10FC;
        Thu, 30 Nov 2023 01:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbOYgCgFSEn5XXqlzIcH5S8jbCYlLbOWSEhHm6RRadRqDzZiquO0Po2ucMOODkfZk7KSkEpii8bIAwnn8OZZVI4qEWrd2UBdeP2rUfb0pwQQTLMOVDPYzqnkMV4PfmuN4+eK/i2NPIX9UBX0sDoHgRu0mWwMwZWqL1766Ds3Gue5JTpMhTAyR+F/g7PxhQE16FrW+CEgYqEeLff5MmYmBlxG7eG0RZv3/RHwJY1kIEPdnhulvRDX7QzSuqqqQlThzEhoouzT8obM5E2uKWc+9D3Iq1IS9uOQ6bRHyIKPLkLPbJHD1NpRtanMdRn9eOnFCm1SFFsX8ZbSweIarxjfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVhT5IulxZr/RYslgeWI3wWMz6cn+INw4PYMJU6MRYs=;
 b=QCiBfaVwmhuyZpZW3JQ2QHXgeGiDIN3gI/ZElIMOh3vfQM5aZvPdl4OkRRu5SW1jG1fjp5lnRRkWRlPfDrUEhmYsfs1rDp1x0dqtvY7dNsKqE3QHb9k1bUWJVdNrED5NOnuqXZs3MNe/5Dpx8bwEi/gqHEcCofNklEGxWQSL925HEbcBPXhEN/ywCUJzh9KoyYGITjCV9oIz4JwZh7t7I7umrQVMeqjcU0NJhgQL50xslik1nqx22wRa6O6JYgdaCFo1qkKFocSRdtE2fKwyTJk+FZmC7uNNcj+ogsS236+u65udVbpL4OrEDKsPSzYHhvxWyvzrTGE2+h3Uo+cxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.se;
 dkim=pass header.d=prevas.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVhT5IulxZr/RYslgeWI3wWMz6cn+INw4PYMJU6MRYs=;
 b=muEuqKshcTsmZN03SOyGHtZJDqgR/4vNysMAmWQZZU3omGvnaBazRK7lNGYEWcmsh3TgZAEvZgXa4oY11rZasUe2Ekk826sCiuEEWc/H7xgCxIA5f9zNB1vuzScxqeOOu8dYqij/pj52XVpP0D7EqpJ/EfveqtSErJro+MmcF4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.se;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3471.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 09:10:00 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 09:10:00 +0000
Message-ID: <e770c302-2fef-40ba-b955-dc8c54c8727c@prevas.se>
Date:   Thu, 30 Nov 2023 10:09:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: imx: fix tx statemachine deadlock
Content-Language: en-US, da
From:   Rasmus Villemoes <rasmus.villemoes@prevas.se>
To:     Paul Geurts <paul_geurts@live.nl>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Eberhard Stoll <eberhard.stoll@gmx.de>
References: <2023112434-winter-embezzle-1b46@gregkh>
 <AM0PR09MB26758F651BC1B742EB45775995B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
 <a283cb15-d740-4f94-a81e-0147c2035cf7@prevas.dk>
In-Reply-To: <a283cb15-d740-4f94-a81e-0147c2035cf7@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:205:1::39) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3471:EE_
X-MS-Office365-Filtering-Correlation-Id: ca85233e-9062-4c95-393a-08dbf184219c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWIRBbEgLGcJEmPoJBAj8KhWOdkFHhqIBi4d8jYTSUW7bId3erhzb9LS8aVhm+cogOOYuRlOfGF32rpH8MKsBN0MG5u65+eGYwhhEN76nmUuVo2nYkpQh2JRu+KBCwbuWAUxqHsAD55uFzQ6NwXiADGPjgmAKdQkp2Eqa9vfoifSQwxgy20yLhl38SxcoX+E/X4bgRbWJrRsPuXOBkX+nbNfJk2poE3kDOewjjKeN0JT0BZMs3Bfwg+K4JGrv4+wGuYdyJEWc4+WYzqJ3dPensMHEfgYcdpJSI85dN+izQp3qL2FExC7L0/ZIojzgd52GuPvUxVCj4rXUtM7nMOdEfPHc4VDUl6kgDmpyOBkwBH00juhRCYrMuyucog4CRUTfTEQufeHuvr+ExTvcjcbQzVcl88QKtv+TcYGUCBAnhJyXL3IEocoB6cDNiFJ0BlYWTMs5iyEVbao8vuGO72SJTMc7D9xvcq+OfnReLFpTfLJVKT83T2Qcs6jzrTHgeUBNIQVdvuXMcIRulCpdTJVsjIO87fePMQxL+fuoN06bTwPU/aHpukMRuG0wRq+Q4eGNQqvZKLauTore5dBaykyUe1Yy02x/OQqgUtiQZHo+KEXP0Qu3Puh7HeezwXY2rzME30OOcve/XO2BXMGrLvEzOxv67qfv9hf8WBII4SVVtf04ZPnjO3a9+lRgCUkR0Sgy8Ckvt+qrSuog6AJCVgHBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(366004)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(42882007)(6506007)(26005)(83380400001)(2616005)(6512007)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(7416002)(478600001)(2906002)(966005)(6486002)(316002)(66476007)(66556008)(66946007)(202311291699003)(31696002)(36756003)(38100700002)(83170400001)(31686004)(921008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djNSaHcvT3FWYzhkTjZ6K2xUZlAwM3JvTkJOZDBkemlrdmRZNEIwMGErek5N?=
 =?utf-8?B?LzZSa3A5RUwrWFpnVWZNUVNCdVJoVGUrZEVQYmdjbWhFenZHSWZxS1VNVDJQ?=
 =?utf-8?B?dmp5ZmNGWWNPTWlIbENHRWFGeDRTTXJhdzgxdEI2dFRpZUpIM3VpeTdkL1lS?=
 =?utf-8?B?NzRMMy9ZZ0F3aThBdnBlOHlKY2d3QWV4OSt0TEZYSG8wNmVzQVBVSHNhL2RO?=
 =?utf-8?B?aENlU3BRMFR6N0p2RjZFamxvSVN5eHpoR1pwQXlBV0xseE0vMVlLa0NRNFJh?=
 =?utf-8?B?QVlwNUt6NzU2Tm9qczhMNzJQLzY4VGo0R283cWdPR2lWdXJCMkNtUlh1MFBs?=
 =?utf-8?B?cCt2YUcydjZYWFVobjRsNnVUNUluNGVlZmFJUnZqSmo2NytqSW9TWkR6Mktn?=
 =?utf-8?B?dm4wYVFNRU1QVVgxUzFXQ09Campwek5YdlNwMXVMbGx3UWhwOWNuak1Wczdn?=
 =?utf-8?B?YWRUYWsvenlhMC84OWNCd3FyWmZkTXNKUmQ0elFsc282NmpEclNkdXN6TGx0?=
 =?utf-8?B?S1RYRzE1V1p0WXlPZmRQZU81RmZQTG1UeGhHT3RzSHZ5anUza2RrTHR5bE9G?=
 =?utf-8?B?TnVKVXhFNWZjaGRjR2ZhK2lCVElraGRFd2tOR0RUckRpeXA4bnMxcmtjaGJN?=
 =?utf-8?B?RVFRTUlsS2ZKWG9iMFdCUDdoekJNalhMRUM1c1V1cC9OUHZWUGRxZnRIeTBD?=
 =?utf-8?B?cHJZMk5KWlNKUU9pb1FsTG11RFVVQllTT2lsVWdSN3JoZDJVT0RhQnFTcG5C?=
 =?utf-8?B?M21nUnRzUWRyMllqUi81dnc3blBrNmRFMjA3L01uOFM3a3hvTlpvdFY2WElL?=
 =?utf-8?B?MU9SN1lLMVAraUNxclJkY2RsdmswQ2syTUZyOThKbWt6TnM1dUxxTnE4bHQ0?=
 =?utf-8?B?dnViZmRlcDlyZ1g2RmRXeTgxaFRmblVUVG5xcTF4RXVNdUNCdDRjWlVvSzIr?=
 =?utf-8?B?Y29vT3AwRTNlRkxsa2hsMDNXVjd1SEhIQUVaeXluQVJTbzMzVnRkbmpzd05W?=
 =?utf-8?B?dDhhdWtrejJIck5VUjJmTHZaa3BEVVh6MEZQY1V2c0JSbWxSeFBncjJWL0ZT?=
 =?utf-8?B?dTRsYWxvQ1NOc2dRb2xJODhqMEhxZFpWSlkxWkpWRjNPQzZLdTBrSjFWWkZO?=
 =?utf-8?B?Smx1QlhKa3d2SWVrUTFMRk0vdERuN3ZtL2dST0ovNU5RQUFiNFFVTmJqWVRw?=
 =?utf-8?B?eXFXUnVqU0lhNkwrU1BCbzVpMGhLTkt1YnQ1S0tmUFF2TUtWbHYvMjhsUEgv?=
 =?utf-8?B?UzdOTXVDSG9UbkVpRVJBT0VoUlR1NEhCQU1EMlZRUlBhNEEyN0t6elE2ZGo3?=
 =?utf-8?B?QUdIbFd0d2F1VFRTTUx0YnlYbFNNNXdaeHJra3BqZ2FITGh6UnhWS0lrYUcy?=
 =?utf-8?B?WnZEZkJKM0E0T1ovbmkxV1VzRDFrWjUwd0J0U2VSRjNUVVVTWFBwTUtUUnRZ?=
 =?utf-8?B?MkVJSnRZWkRyZW1FdWV2RjJlMW1DVGFlYVEra3phRU9SbGZaYkFPMm5sT1ZX?=
 =?utf-8?B?NTlVTG1pWDhLZ2lncGM4WDN6dEdmNEVNT2ZYeFRGd2dVQkF3ejk5M3ZEMm5T?=
 =?utf-8?B?TGZNb05vcDBTSTZKTGhYQ3llMkNhMzZadDdlVUVLeGZRSWdhSXpibUlEazlm?=
 =?utf-8?B?ZHMrVXMxVkJBdUIwRWN3T0lmMDNUekhLdlF1blRDdFU1VjkwUXdYSmppQnpT?=
 =?utf-8?B?dVp6bEkveTlySHpyMkZhQkNWZUh1UlF1ZFRXME91azRVS3NYTjlnbmI0dUhT?=
 =?utf-8?B?L0p2Sk9WYnpKYUdjdXcvRml2b0JxeXBseGhCY0l5Vld0TlZkdTI3N2lCbmt6?=
 =?utf-8?B?eTU1K2VyclgxdnBhYzdObGZuTGR4OWpIZmF5ek11MTRJSlVXWmI1eTIzeGR6?=
 =?utf-8?B?a1lndlNuT0piMnloelZSdk1VLzMwZDJHaHB3UjBUVURpRVNCd2J3YWdFUlVW?=
 =?utf-8?B?Vm1hbFA5aTJxQk16VW5aRUJTd3BCajhJOENTamJJdWtMS1JrUlJtcktVT2hj?=
 =?utf-8?B?SFQrc1RqY0ZHbFhBb0hYRUNuOFV5eU5uVGtMdXo2bi9aWUk3eEYydHZNdk1W?=
 =?utf-8?B?SVc3RVRCbkt0Ri9PUElNb2FUTWhZMDJ3d1ZXZHE1aVFJRGt3eXNyUnlXTVRD?=
 =?utf-8?B?ako0MnhlNlV6MTB5TXRycndWL09razhFdDJiOEhzTkQrMndyU04yMllBSHpF?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: prevas.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ca85233e-9062-4c95-393a-08dbf184219c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:10:00.6027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMjOUZwU++II4o5f4gf0znsGQLVx+gGRIe7KUVRQi2P7C5PoWqpsKwIxoq3UMXp/tfPwMx5k7XwZM6BSWGOP4uBS1iBGE4WL8GN9zVJ8dUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3471
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 14.37, Rasmus Villemoes wrote:
> On 24/11/2023 14.11, Paul Geurts wrote:
>> When using the serial port as RS485 port, the tx statemachine is used to
>> control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
>> TTY port is closed in the middle of a transmission (for instance during
>> userland application crash), imx_uart_shutdown disables the interface
>> and disables the Transmission Complete interrupt. afer that,
>> imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
>> by the TC interrupt. This interrupt is disabled and therefore the tx
>> statemachine never transitions out of SEND. The statemachine is in
>> deadlock now, and the TX_EN remains low, making the interface useless.
>>
>> imx_uart_stop_tx now checks for incomplete transmission AND whether TC
>> interrupts are enabled before bailing to be retriggered. This makes sure
>> the state machine handling is reached, and is properly set to
>> WAIT_AFTER_SEND.
>>
>> Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")
>> Signed-off-by: Paul Geurts <paul_geurts@live.nl>
> 
> Hi Paul
> 
> Interestingly, both Eberhard (cc'ed) and I have hit similar problems in
> this driver recently. See the thread
> https://lore.kernel.org/lkml/20231120132256.136625-1-rasmus.villemoes@prevas.dk/
> .
> 
> It is possible that this also fixes the problems I/we saw, but I can't
> get around to testing until sometime next week.

This also seems to fix the problem I had when switching to rs232 and
back to rs485, and I agree that it seems to be a cleaner fix than mine.

I also tried reproducing what Eberhard reported, and I think I managed
to do that, and at least my way of reproducing the tx lockup also seems
to be fixed by this patch. Eberhard, can you test this patch in your setup?

In any case,

Tested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Rasmus

