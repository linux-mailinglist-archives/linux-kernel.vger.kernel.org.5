Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4247F75C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjKXNzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjKXNzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:55:35 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2079.outbound.protection.outlook.com [40.92.48.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FAA1987;
        Fri, 24 Nov 2023 05:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9d34GqX1aLTnltsh5V2gMoAItk29BFlybU/rZv0Y7HzlFfcFEeu+c07gbxEevYKLf1jO2dsii5I9YpOuI7ryqZCINmk929UOw94IXt5R7gkEUrkGCb5efrrAhxdvg3TJJG7Xobu29YAJqhvRBRyB154trTtSOqjPDUj7Xb4dTI8fGTEKJsb8sdbruYLHEeOAU09gpOKerGaIxLcNupT+y1/z0OSM/f2wH+IhKFn7cXTZsnPObVIjWJ9HcWeRxBdRtEKSmDLOSkeMcvI6uib+Xdvj58xZ+MZ1SzvK7wW3vH9tY8xQgx3N29PWiTjD7sZJpdKotixbf0NNfrObDrV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2YEQSEvrkKMGwog+NItdFVOsqxwt1eZMUeLQonK8+U=;
 b=hksdWVqIQ0TEY1Sm6jAkPIdGuo/T+J90WZvsa6rMbn9aVjK7AQu61/nZ+Cm26iZzleZJM8OFW4Q59gfIIItfXgGFusJeOqUm91+0mSnLkjNzxzA41eU78qXG0mkQWCOBzY+trHk7EBok1H4UQ+JoQBf+dKiXsCjBRJfD2uDmZNG1NZY0syo1aT93ZtyZXJjtx0BLNkSKM6U2Y5JnXg1Z0NA2BbDQgjt6EiUM3ItiiC1qRYfepIGtXGKeETx911KCs8pu2hGJRyO0ZT9bdnbW9RLkUvKxkqUpLFSH9SFh6TyA0XDYKJQVu2ZUsWEm98aRXAV6/2GlPv9YM2D0JJ4YGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by DB8PR09MB3705.eurprd09.prod.outlook.com (2603:10a6:10:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 13:55:38 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::279b:7d4f:cf90:e9c9]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::279b:7d4f:cf90:e9c9%3]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 13:55:38 +0000
From:   Paul Geurts <paul_geurts@live.nl>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rasmus.villemoes@prevas.dk
Cc:     eberhard.stoll@gmx.de
Subject: Re: [PATCH v3] serial: imx: fix tx statemachine deadlock
Date:   Fri, 24 Nov 2023 14:55:25 +0100
Message-ID: <AM0PR09MB26751B7E31082ED82A2066F795B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <a283cb15-d740-4f94-a81e-0147c2035cf7@prevas.dk>
References: <a283cb15-d740-4f94-a81e-0147c2035cf7@prevas.dk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [stOSebSLaCa8sIheJnmQnWEVH6bXcprBhsKkdCYHXZJYVXBfgZv4Svl54iV+/VUy]
X-ClientProxiedBy: AM0PR02CA0155.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::22) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID: <20231124135525.5442-1-paul_geurts@live.nl>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|DB8PR09MB3705:EE_
X-MS-Office365-Filtering-Correlation-Id: 968b49d8-03fa-440a-43a6-08dbecf509fd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdVwitWg+SmptHUmR5alumDrxR6GCE+drXeQrApc5MUR5kavyPb0Bqw0gks4JRK/bq5GAWfbu66b00iIAFzMXK94EhcIOoYc0XwmmlcHP0tqRJZYXQcWNxk6BC0EvbMnYk+aFJj5s1mAcTduVDdz3nrdk7y65Fc55pnJyhv/hxyGfwoF9bAxcdy+OTTT+vXG9ImOL9CtALZ75XNcUh59QwFkORcM/krT/7oho7lY7cvSuNNbj+Z3Q8dnfDWFxpHSG/d45GYAtQ4nw5r4z6OFmuRQ/uqzjNDXpi0oKE3BkUyTqy1WyGk3GBjYuzQw3w5jWcCf99GmN1nxxXGK+Iqte/iHVcuQ0dxVdu0IVHDyuLvHGo6zFYVY0QnwZNB5/Kt8PhivXZX37yfp0kJOJOtyV2rAmsaYw1e9ZHD0mUxHlHpGCn76KdhGaIVuuiuNvzxVk5fdSkYofpPNI8OFNa5slCfdjaeSxUakieIU3FngduzoarIuYHL9mx686hoth61FYLDNdzVmhjgg3OtWUVyoOWM42vPd3Ud4DODUnrsOdEHBcwmImVBKpOfHNQapcqKzsB0oYXHrX8ByY9NYrsf1y78i7XyVElgDcocl349lHyM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AROVMS4QL8fl5FEjg04HrXygDaCfB0q2mQ6fAfMbMt4BIHMukr3AMnIZD/Do?=
 =?us-ascii?Q?+sfW6npMi3zyQ5FHsVn90mgbFNjnU2HlK6gJvWQWMjIDivs1jrP2OQ42A4BE?=
 =?us-ascii?Q?dhzlehGvoSFexQWNCi6C5qhb3d9r5Cz55aWvcgU2lbR3dWLolm6Ko9sy2PcA?=
 =?us-ascii?Q?Z/nl/jQYQDR2o4C8WS3pwF2HuHe0dsXn+ClLBYKpZE0sMjVTuMKfz3gQaYYa?=
 =?us-ascii?Q?QaJr56uiGjtPZz4sgBobb7WGII/n2xvgp1v+Wa6ffdt3CboiQelyjdgd8Maq?=
 =?us-ascii?Q?KSIYR8/lyIWm92gvnY3I3TMUYamzrDK9u2ixkkstOfCyJPGvmfnf6HqwwK1K?=
 =?us-ascii?Q?Lc8nC+ihXeX/LnuEozVXpgzu74CHboGjXrAf+Fk5M/xrgsgHNI6YbUyLmrQ8?=
 =?us-ascii?Q?Fzn7PV0zi9SpbvZavKddJv44DVMjAhSR49e1R9wySoceq4m5VGEBTEwo17sl?=
 =?us-ascii?Q?ouK0F8IEYGbSqxxnqiLNgUh/3GQ1EXrgjVOiNuQSium3K6Ekh8qah7/BVLUS?=
 =?us-ascii?Q?iOJVxKnb7HK1UNlS/QgjfhWPR1JdlqR4V1h/1DY3tZ4Bsk5MJYp5IS6hWKQF?=
 =?us-ascii?Q?fywpaim8ltzZHQFLtFZ4bLQZ5Y6fFrvrO/x9opwgMo6bDh10WSdrbjqv3dJ5?=
 =?us-ascii?Q?Tp9Zr5V9iOKLY/lI7GojXbW0yyhn/q2Q0s7V8BsiKij+nyAguvoG7uQ1lcCr?=
 =?us-ascii?Q?EDEsLOzDf5eGDFmAaTvnEGkLDBdFO7LW8gzr83rbYqzcNwtdmkPs9xX8J9wO?=
 =?us-ascii?Q?6hl5tJAoYitoRL1Yvib8Lp2wrch6dYhYBUL6xN7CObXtBgXG350bNI44FJsA?=
 =?us-ascii?Q?Xs5Mh+7MU1pc2m/IzdlnvLpfCqyhIbSP/9lwAENFWWwXyF3Pun6sxXqAPTF0?=
 =?us-ascii?Q?H2AhgUIVx70MDlSbYVt4Hr0Q1SCWICZ83zyglBJ+D1A7hoLBERT6N6GqAKeg?=
 =?us-ascii?Q?kix3DIQIJe9mMjq6bSe18YuVkHgx+cywby1qn+WseRCRFuhLnta/LUwNgxSX?=
 =?us-ascii?Q?oJQ0GkounQ2zcfl241J0ZEPOtmRDrIjRLseNB5n2H1qeuhp/nz7qeW+9a0eZ?=
 =?us-ascii?Q?7mBvCRhNF2gLYyfYykD6A6Aj3LhE1/xD0RG01sbICSn5kV/fq2RvSXioUJKN?=
 =?us-ascii?Q?UeH3a/xvHkNcKF8hhvlsn9ZLjcZs5y9vgXD1xBxvh7npaPMZCM0pQJ+dCl5Y?=
 =?us-ascii?Q?ftyAFyrFiWsugo7f3rWZpBSiczXfaoPz1yyrPKCnoVvpCKntUNfSHjPqr6z5?=
 =?us-ascii?Q?xO2lePaibyEwRHYmXHvufcXXcnjEY241l0v4w2cPQw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 968b49d8-03fa-440a-43a6-08dbecf509fd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 13:55:38.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3705
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > When using the serial port as RS485 port, the tx statemachine is used to
> > control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
> > TTY port is closed in the middle of a transmission (for instance during
> > userland application crash), imx_uart_shutdown disables the interface
> > and disables the Transmission Complete interrupt. afer that,
> > imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
> > by the TC interrupt. This interrupt is disabled and therefore the tx
> > statemachine never transitions out of SEND. The statemachine is in
> > deadlock now, and the TX_EN remains low, making the interface useless.
> > 
> > imx_uart_stop_tx now checks for incomplete transmission AND whether TC
> > interrupts are enabled before bailing to be retriggered. This makes sure
> > the state machine handling is reached, and is properly set to
> > WAIT_AFTER_SEND.
> > 
> > Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")
> > Signed-off-by: Paul Geurts <paul_geurts@live.nl>
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
> 
> Rasmus

This might very well be a similar issue with the tx statemachine. The
patch you mention however pulls in the state machine behaviour into normal
RS232 mode, while it was (AFAIK) specifically designed for controlling the
TXEN in RS485 mode. Therefore, Whent his patch also fixes your problem, I
would suggest to use this instead of the beforementioned patch.

br,
Paul
