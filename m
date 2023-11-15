Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD12C7EC104
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjKOK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOK6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:58:09 -0500
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Nov 2023 02:58:05 PST
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3EF5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1700045883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjItyt8fEyWLaEhJVQSTiOiuLLPdB5bbrfbjj7Mscko=;
        b=HymqeF2PRinorOdBPQI0Sbz1iY1++Z+iJNT7Ov3fiJ8TYMM/ybcb6hBV8UiosDDi2qDXSl
        6+6CknRwZXw6jO+B9Ht2x81HA8yjArPcRdEBonVdDtJ81RYvLcg8ZyAALbDUOyOGL84e1s
        Kuk+pR1Dg896nX2nLxIMAb5KkJILw+0=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2040.outbound.protection.outlook.com [104.47.85.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-281-GOs9hfwSOHChfOk7sBPn3Q-1; Wed, 15 Nov 2023 10:51:31 +0000
X-MC-Unique: GOs9hfwSOHChfOk7sBPn3Q-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB2869.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 10:51:29 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::38c0:65fc:2f2f:da6e]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::38c0:65fc:2f2f:da6e%4]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 10:51:29 +0000
Message-ID: <3fac7d72-0a1b-4d93-9245-a0f8af1240a6@camlingroup.com>
Date:   Wed, 15 Nov 2023 11:51:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: sc16is7xx: address RX timeout interrupt errata
To:     Daniel Mack <daniel@zonque.org>, Hugo Villeneuve <hugo@hugovil.com>
CC:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Popov <maxim.snafu@gmail.com>,
        stable@vger.kernel.org
References: <20231114074904.239458-1-daniel@zonque.org>
 <20231114102025.d48c0a6ec6c413f274b7680b@hugovil.com>
 <140280a6-1948-4630-b10c-8e6a2afec2de@zonque.org>
From:   Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <140280a6-1948-4630-b10c-8e6a2afec2de@zonque.org>
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB2869:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dcc3b0-e2d3-4c83-36f9-08dbe5c8d2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: xse+c24/tDz9D+QJfgnpaJ8qOfMYIzQxcQ+LSc3SyIbgcYOCo8/nRRoEP2Y/eslSBvavM5IbDBwmTj1belwrYQL/Gp7qSKmeUNbKe6IKn91InZ7sDF5gLU+QQsP54/Vfm7SLZ6hosckfDnch5kX1TjvrztQOxhfArcWj1lERVu0q92RAJKKO5yY9/7voM6NT4N+X6+w/+xCHZVBpjhmSGH7zpNRWhj6xDiGMmgpkGfmi2Rnxw6Ee6TAaYvrUkAC3AzLjpS7h2HFk975nZEHK1+4eGUjfrHmsnt6GBGH+bDul0SRnGjVEzbbfwRHsHbllU8n7PW3qLzIgJC6dIwh4xqJjsQs22d94Erd373So+nz0x3X5kiY2VoJ1rbx0q72kj3Wreh7Q+pIWHgCI4eLTS6TjgIA51GYKyXimXfoHPHEWZLw0YnzUXMuZQpV8g/IlMUaHiCKKqGd8vbw/H1Qfym4bHYIQU4Lu+WcTyYI+sLoY+UKpv6tgqwUEFOdCsd7pStjIvxHtGVa8dO+XVa17RFsJOYjbkw9JO9WKMAAJaMzz5gdzt8TVW+k/2qXj7z/xJYcgJZcshK/Iyv/bN76rKsc74uP4Img0ecrkrOiEkdPKGeb3EkC1kZxFw5lx3+uz21geK1RPNYvZ5tCHuBnxDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(5660300002)(44832011)(4326008)(8676002)(8936002)(36756003)(38100700002)(83380400001)(86362001)(31696002)(31686004)(316002)(6486002)(6512007)(6506007)(53546011)(110136005)(2616005)(66946007)(66556008)(66476007)(41300700001)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JuM90LhuzV7f/fFrXCyag8jFG0u6YARO/1DMX5146HRCcsTr4yV1WZUoeTKt?=
 =?us-ascii?Q?kV+h3iYHVcIi3LwecLEdZ3En0PKuDeg+6zwFUBQc7miFxBNUVm83eoVBIMZI?=
 =?us-ascii?Q?vr8SWs+exj+wgniqzUSshJvkLlcZmV9lryEot7eQw2VblDeTsaPkqUjDcpNh?=
 =?us-ascii?Q?XGC+8qgN7MucgMAPPwZfnuJyjjMbxfkdiZiWwP37ZvVCzEeilo40jr/laFTd?=
 =?us-ascii?Q?SV+0N4snoioeHjmhdgtz5EQ+aKq27391pyW1+u5F1yti2Ml/NfcxMm8wSGm9?=
 =?us-ascii?Q?5aTrKmzEgiwMTEFncKRqSuuQxPJ2DWqMNbAvd9n0Pv0qaSm1PM50hL5+IHx4?=
 =?us-ascii?Q?0A2BSHFv3eZqDa7a2DZxBuGXJlTGTV1ak2iDbPzt7wvf91s5DEtcu61A3sqN?=
 =?us-ascii?Q?wa47nFNkrazt4fM3BPQsu6+rEF0eQO4uGLGirFK45+k17eoNLCWbTvZz57OH?=
 =?us-ascii?Q?/xv+LYiSHM/L1tDbl1p6Gd6g29oRLM+XeFQAtzRuPKqUwILM2fXBT4S3d4w0?=
 =?us-ascii?Q?3ktI/JKySr00AyJrZStNSpXy+ARrEenB22hfOsg1UKSZRSGfY+HxLIjlZN3p?=
 =?us-ascii?Q?HTOor3rzJpYXE2GZy/b7aceYRtm/RSkpGbJsuq015O/h/rv/F/heLCm61Vat?=
 =?us-ascii?Q?brshlOb6OKfJ7AukhSWp38wt9ri4toiy5hWqh10p4YWQHvjQzg2X2GBqWOeW?=
 =?us-ascii?Q?Wz++0WhDjDzHTemDp17YEwIbDbvBbHcDUgaozkr4f6s3cat9YXqbHrB8gv6W?=
 =?us-ascii?Q?38gdwARV2WpPDf5dXB1vP4Opd76Aqe+CwXN/NaFVnyzYSHAFgNnVpJ+2UEIH?=
 =?us-ascii?Q?NX6pReqZyeF83OG2q2ut3hfP+3LNMSam63lbBDgtaqKF/C6xWhx8RViPf985?=
 =?us-ascii?Q?DNg71QfRbIQqqDqWbuYryf2+V+VjKUcUWYCoxHXtP6+LzHTripGX9Pdua/Z7?=
 =?us-ascii?Q?1gL44P+XzHTdfuNkxNtdSXh2kNrxT3g1IpFF/jWjWAp+5HYwpjedmILy5fIJ?=
 =?us-ascii?Q?jaGIf8SBTAYqUPRoE46CtmBWC/2EhY/kpq95Vgf9KGisCNZ/A8WeDsYgWL79?=
 =?us-ascii?Q?HO3IZIvi+YkDsrj5yzVlIL0jqcEgH9q8f9n04FLsDIZGEc3QPCql4l83AInu?=
 =?us-ascii?Q?FBfRtqt862gBlQlVo0W/dA2mFk330qTPJb/odYToBTQaQWqnKKiRjyb7cp3B?=
 =?us-ascii?Q?wJRNaPvQtlUM/TxKG/4IRIs6d6aYpAQzizyqZYNjc4mkShiin6gr2vDh+et1?=
 =?us-ascii?Q?tWPT2sii1Q91237O7n97KwBy6Xp8HOX6rMIXu/fFHdRqwX+qBtfH4IqW9Dcv?=
 =?us-ascii?Q?wKeH+mmEbKlKCXmlnZjNyrkMQdKXEgeqUt+dFD++uni6H6Al1UPYxpQ3A99F?=
 =?us-ascii?Q?z2K5OOqoT9DiFWGKGK1EMeh0AxIlzzwBoWmwjHvAsdDMq+w5gpI/fz362oPA?=
 =?us-ascii?Q?oN+WdlrFewhe7F32q39AagKl1EKQJ8lc8MLZMgypHSFdLxyJUUyU0fAJXGh1?=
 =?us-ascii?Q?0KhU7PSXp9dAfUh9EHPAj+AnAzFyvOD0NgtWDjfLPP1G+kCCo8E0BEKrx1mL?=
 =?us-ascii?Q?Tel4FtWnlbOAknBwPLiGMhIcTOGL6QCHnmqPCRrBPqBN1arbTfkgA6wCwc+0?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dcc3b0-e2d3-4c83-36f9-08dbe5c8d2b9
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 10:51:29.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnC+5P7ZgIZ4bgOQGfInrvh9mnrpxmpu0l0k8ROseqi1B/vQC8ClFRMv2NErN77F0BSQHzFnpTDXC/bcP0Eqexd/30PYLYduC2C36Rf7ZYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2869
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

W dniu 14.11.2023 o=C2=A016:55, Daniel Mack pisze:
> Hi Hugo,
>
> On 11/14/23 16:20, Hugo Villeneuve wrote:
>> On Tue, 14 Nov 2023 08:49:04 +0100
>> Daniel Mack <daniel@zonque.org> wrote:
>>> This devices has a silicon bug that makes it report a timeout interrupt
>>> but no data in FIFO.
>>>
>>> The datasheet states the following in the errata section 18.1.4:
>>>
>>>   "If the host reads the receive FIFO at the at the same time as a
>>>   time-out interrupt condition happens, the host might read 0xCC
>>>   (time-out) in the Interrupt Indication Register (IIR), but bit 0
>>>   of the Line Status Register (LSR) is not set (means there is not
>>>   data in the receive FIFO)."
>>>
>>> When this happens, the loop in sc16is7xx_irq() will run forever,
>>> which effectively blocks the i2c bus and breaks the functionality
>>> of the UART.
>>>
>>> From the information above, it is assumed that when the bug is
>>> triggered, the FIFO does in fact have payload in its buffer, but the
>>> fill level reporting is off-by-one. Hence this patch fixes the issue
>>> by reading one byte from the FIFO when that condition is detected.
>> From what I understand from the errata, when the problem occurs, it
>> affects bit 0 of the LSR register. I see no mention that it
>> also affects the RX FIFO level register (SC16IS7XX_RXLVL_REG)?
> True, the errata doesn't explicitly mention that, but tests have shown
> that the RXLVL register is equally affected.
>
>> LSR[0] would be checked only if we were using polled mode of
>> operation, but we always use the interrupt mode (IRQ), and therefore I
>> would say that this errata doesn't apply to this driver, and the
>> patch is not necessary...
> Well, it is. We have seen this bug in the wild and extensively
> stress-tested the patch on dozens of boards for many days. Without this
> patch, kernels on affected systems would consume a lot of CPU cycles in
> the interrupt threads and effectively render the I2C bus unusable due to
> the busy polling.
>
> With this patch applied, we were no longer able to reproduce the issue.
Could you share some more details on the setup you use to reproduce this? I=
'd like to try out as well.
>
>
> Thanks,
> Daniel

--=20
Pozdrawiam/With kind regards,
Lech Perczak

