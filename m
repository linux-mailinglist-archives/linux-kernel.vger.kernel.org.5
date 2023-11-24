Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07167F755B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbjKXNhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjKXNhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:37:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2091.outbound.protection.outlook.com [40.107.21.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE9E1705;
        Fri, 24 Nov 2023 05:37:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZmYoAYZ22bSe1PuMAHoHaTAmiIi2ydkLiEq00WuwAJDz8CFuJJFxkMofbjY4SDohWWSk9ZKl8Tc7tOgENoAyuoriWU3B9J8vuc1gLKlZRTqBXr0vhYxvsQS6X4+92IB7Mzvh68gcGX6moTAOIn6gZxwRho5YRr0Ryzk/Gddy308WuYj0qaW8p8Hk1Mxb6YhIRFj2PlAnP1Hb7KQdWBEx5E5987ybzCkWZsifWCHkPzgJUvIfblq222j1KwrJzYSkPNpM1c3hAPRxmuZONue6q736l6d01pZfcqdZ7LEY7Ln1g9LV0pncCtexdwVG73wyfl+Q6FIBgBW4cKmOu4KMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXGc7OMyJe9N8G8QPUZ0rQTXKwgq6SkUrLMU1rFIYQk=;
 b=f2lt2GlayhIrmjUIksRgeMyipcX21v65vkt3zyZk5A30w1YtGyoPlhFptyabBe8Uw23xNzBugVwUP3GrlMQxqmwVqEml5MlD/t+6gNUiZAABCwKxTJG65504e8KSNwjCiMC/RkAfmvPc9uKBMOQYZcU/2J/8FHZpYM7QjpaCcDKsNrgp9qWFkXH+S7QhicrTm3rikcmmNLNVdHMzlRBc7sUp/d4AsMt8AMGR398vbZWD+AvwSbscBc/xXb83isDEF4IXHHUpVdeeKoxIiy6dTkoRVOaOKDyKd041mkllkfhnAhWavz+xUwq8VMfLWRbY2ecRcouOzH1gbgCYXdchkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXGc7OMyJe9N8G8QPUZ0rQTXKwgq6SkUrLMU1rFIYQk=;
 b=Vj8C4iJo50FOdd8lBZdJxGPawu7XncGsFpcXgo9N2TfYWysk8t5EwpVG4IFKc0eYdz4YF6nlI2FF2SWCwun+OMsxjH/niYregvCFYPQsdC7THD65vhVIPsyTlJrVScEwjCI767Ka7Nd1UAzA0ZAK7PaUHrEYR0dowb77Q4zfoSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB8PR10MB3609.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 13:37:14 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 13:37:14 +0000
Message-ID: <a283cb15-d740-4f94-a81e-0147c2035cf7@prevas.dk>
Date:   Fri, 24 Nov 2023 14:37:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: imx: fix tx statemachine deadlock
To:     Paul Geurts <paul_geurts@live.nl>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <2023112434-winter-embezzle-1b46@gregkh>
 <AM0PR09MB26758F651BC1B742EB45775995B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
Content-Language: en-US, da
Cc:     Eberhard Stoll <eberhard.stoll@gmx.de>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <AM0PR09MB26758F651BC1B742EB45775995B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::32) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB8PR10MB3609:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9a4478-0028-4e24-bbc8-08dbecf27824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MO7WgAzqaDaAcOtoQL5RQfkLKwwNxnd7ygMJIrLV8erhzs8gJLc7lhGwcrQ3I1ZfHLNb7A1hAaki4xU3DgT7Wm7g11RqfJNeIdJlPq5XdaQP6KBYwcwukmJRU631O/jpHtphAXcclyvxW5EkVKg5uExJjqhSGZ8zOl8PjrhQkyjyjCt/kGhPS47CR7Z6kl7rjNH6rUwVUHf0xb9pE9IbB9xbibJRRizCzLbOTlK4t2Trxjrcs272hI0h0CKYYoTGdNzRDiJz++pc1gdd1Vn9/E9D7zWQqU1yR/qLVJqFrGhUBBW30D2vP92qrBqWefSlmGAuB4L+VyfEL4MKPuPvGKRD/s81560Mwg8BX9thnO9UGiW25vexYwESyGQsP2ojPnrszZHMq5viJyrUBl3dtCuxDekcieUo3wIxzbmVNzyYOwXBO+iM7HMk+UWvNlVNv+NKDzSL19YvvnYRrzj0Gw06a4ULjH+gTiBFMoxIQ45UIACIu+caZ4gtIesz2vLVBUMGIDbJdTd7vWqL0QYc1l6wc8fDCKn68SVOJYewwe74/wNrFI6GrPuuaCNTak/wt25UuSoqDBJrCJ8cE9x1f2Ek2aJiW4wIA4n3gODfDATzXPt4cFEHj8zkKbaiVebmm9K2eP4cCxX2kpu36jjGEEYsEggGcvNUewiignPi4g8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39850400004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(26005)(966005)(6486002)(83380400001)(2616005)(6666004)(6512007)(6506007)(66946007)(7416002)(2906002)(8976002)(8936002)(8676002)(86362001)(44832011)(4326008)(31696002)(5660300002)(41300700001)(478600001)(66476007)(316002)(66556008)(36756003)(38100700002)(921008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2RDVXc3SGZ0ME83c013eDU1THBVZkZlS1BLeEE0MVFMcWxqYndVbmVsNEgw?=
 =?utf-8?B?OFNiZHFmN0VqckNUUStwb2JsbDFUcnRzREZ0Q0FhbVVKd21YdlBqcmlydXNF?=
 =?utf-8?B?ZDgyZUt0ZVRzR1ZGc3NEOVhtNUJ4YjZtL0JUa2ZSeEloc05BUEJrMjQrWGZV?=
 =?utf-8?B?RWppaVo4eVZjU1pCZ3pDSjRtR1dOZUwyNFNjaEZxY1dZMHBxK0trSTljbGND?=
 =?utf-8?B?cXdmb0N0cDJTZjIwdVMxNzBsdFlpZm1mTFR0TGFQRmtFbnp5YlJrV3hMVVE2?=
 =?utf-8?B?ME55SUhWeU5QTU85YmoyMmJNdXliNld0eXVKdkFhYXhqRVNXTmd6d3NSVzM4?=
 =?utf-8?B?ZU01TTJySk5Xb3V4T1JoTW9sTnJpZktOa1JNOTZDRUtmaWZ4N0NRWWEvN1dE?=
 =?utf-8?B?b05PbXRYZk4yaFQwSUU2ZlBSMDdOY1BlT2kvOXpDd1ExdFhFK0RPSkxQdUJz?=
 =?utf-8?B?aWp1NDc1aWlkMEwzODB1eTJYOFVENjJFTmc0YVdlRCt2UnRuLzBkU2pmWXZ4?=
 =?utf-8?B?aC9Hbzh3d0RmcjdlbU4yN2VtZU05bXNlcXdtaTZnZUxIMXEwbWZNK3ZhcGlh?=
 =?utf-8?B?WEI4YndBY3BkZEpsbGNnS0NMWUNXMmh5cGNaMUwxMVd2TE8xbGc3dFA0bkwx?=
 =?utf-8?B?WThOa1pXc2sxNm00K1R2ZVN3SkJMTVYwL2Ixa082N1JXSklMMVhTZEltMzR0?=
 =?utf-8?B?N0kzcHFSbDlhWUowaVZLeEtsRDhUUjlRZ0lJaThUemJ4aG44ZEFTOGQ0bGt0?=
 =?utf-8?B?OHdJQmlRcWhxalRnbGw4T3pDWGhuLzRiUGpYSTdYTEpSMVNUWlZUdVVmTndC?=
 =?utf-8?B?MVdJdGp1Nk1qcmZOZWppc1RmOTgxRTRsVjBsTGFGdzN5NG5TTElyZ3RnZVh0?=
 =?utf-8?B?bkxBVk5XdU1pQllPK25ZNlkyQXltbFovNk80dkorb09uVmk0N1FSQW5yaFhX?=
 =?utf-8?B?QmpOMitqeWo5S0R0aCtGUDY3TDU4RUUwWkdaZm5HYW1sb2RLbkRpZ2xjeFN0?=
 =?utf-8?B?WFVMRWkxNCtnZGJJZ3AvZUtOWFRDRlM4TmhMdXNneEdwQkk1d0srSFJXNkxI?=
 =?utf-8?B?UkJVeHd2dFE0cmZmeElTelVlMlExYWxsN2JtOW5aekhYb2tUc1lzNGxSODhH?=
 =?utf-8?B?d1lsYlBsKy9uUHFCaHgyUzV4TlBUZEpRYkFvUXk3eEFOdzAzOHRLZlZpdWRt?=
 =?utf-8?B?U21Senc2c0NYcmx5OWdDbkx0d09zVmFmQnRGMjM4ZUpVbFJkQ2NNTFlLVE91?=
 =?utf-8?B?NzVaNER1OEUxUXZoc3Jud1RPRXpwQ0VaSTBEQUlXZWhhbzA3MXFza0ZhZEpC?=
 =?utf-8?B?WWV6TFdnZ3ZrSG9XZVJ5dmtaOUdvU1dHNlhJUC9EZlZPWHFVWXVXWEtneVF3?=
 =?utf-8?B?NDZxekQ0ZDJWZmtQUXNnVVI2SGwzWUFNUFZaaW02MUx2U0FFdkFZRGhoZTJK?=
 =?utf-8?B?Vm8zblp5bWl0eUxiTnhIMlVVZ0kwRkd0TUppaUlGUnRQN2VENWVkUU5VWlJW?=
 =?utf-8?B?bGlZTmVzNnFXSEV1eUJlbDU0MnVueEdFRVV2aUQxdWUrVlowVFd4OEVISTRS?=
 =?utf-8?B?Y1pCVzh6SHl6NWlyWGcvMFhNUnR2QUJ6WnlKZTdVUkRGK3EzUldnT0VQdXBw?=
 =?utf-8?B?aHVrVEdCbFNUMmVNNmdtNFp3MkE2U25HZmZkN1FTRHZPc3ZQWWRpUVozUFpL?=
 =?utf-8?B?SmhYQkMwWmZxRjg4UXlBajV3NnpUZEhOVktaamJMa3hPd1k5cm40dGY2YlhN?=
 =?utf-8?B?MjdCaXVyS2ovRFNWWFBLZmpkR0ZWRUpNSTNiSjBEWGRuby9sU3VXQmJMWmkr?=
 =?utf-8?B?SUxtRCtIWDZmWlhSWU16MzFwNXpaOGozNC9OekVSM29IZmJLTGtEYmphQ0w1?=
 =?utf-8?B?eHlqNjlna2hFdExDUnlTVHhPRGo4YmdEem1OWDE1VWFYb01uVXVlVkFsN28x?=
 =?utf-8?B?bWhwQVlRZU40dmNXMDdwT1JwaDNMYjUxRk1POEZIQ0lKVXhwRWN2UVRyQVYy?=
 =?utf-8?B?N2hTb2Q5Tlk0M2tYYjFlSTB0dXNIT3dWMXN5bzloZmtSc09oMURRZkNib2Mr?=
 =?utf-8?B?dVNVb1k4dzFNSEFzdGwvNmJBT2R3NG5Kb2xOV080aGo1WGVGT1MzZ2d5dGhq?=
 =?utf-8?B?ekZUc09IZlRkN1dLVWUrY0dycWdqa3BibHBhN0czekhDQS9FT0hoWEs5NTdV?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9a4478-0028-4e24-bbc8-08dbecf27824
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 13:37:14.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7bTj5h0TNiuGpwit24nyvND/bmkMflo9CYL0AU2a1dFSYzHuL5/AFebFLS1Dp59gFQ3PH0vV4ftJscD72Hgi0wNJ65S+wGUKJCjV0vKl5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 14.11, Paul Geurts wrote:
> When using the serial port as RS485 port, the tx statemachine is used to
> control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
> TTY port is closed in the middle of a transmission (for instance during
> userland application crash), imx_uart_shutdown disables the interface
> and disables the Transmission Complete interrupt. afer that,
> imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
> by the TC interrupt. This interrupt is disabled and therefore the tx
> statemachine never transitions out of SEND. The statemachine is in
> deadlock now, and the TX_EN remains low, making the interface useless.
> 
> imx_uart_stop_tx now checks for incomplete transmission AND whether TC
> interrupts are enabled before bailing to be retriggered. This makes sure
> the state machine handling is reached, and is properly set to
> WAIT_AFTER_SEND.
> 
> Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")
> Signed-off-by: Paul Geurts <paul_geurts@live.nl>

Hi Paul

Interestingly, both Eberhard (cc'ed) and I have hit similar problems in
this driver recently. See the thread
https://lore.kernel.org/lkml/20231120132256.136625-1-rasmus.villemoes@prevas.dk/
.

It is possible that this also fixes the problems I/we saw, but I can't
get around to testing until sometime next week.

Rasmus

