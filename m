Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B53B75B386
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjGTPxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGTPxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:53:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2094.outbound.protection.outlook.com [40.107.94.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318A1123;
        Thu, 20 Jul 2023 08:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSC+7qOzsoKLq4EJqd5DrPbTRVwbRCWWSoo3xFQjr9gh5eghYD/B/H6sjxPgFXHYQe55NIA4r1LzaKCrEBR2D2STnzQ+qYlOup3FhVfZ0fb+7jq4Mw20bseLzDB8AKZdYMSK1Gh/p7yF+67S1345EvUcguXgk6cWrHv+oB9fAxhRtkwBy+riFdPmZaasjcGA7mhkp3pD1ZxIH5wVxAlUGO3QGhSxNjV5oO3Cvfo6+tpscZuKuuo6o14eYRJOQSFGEv6UPSmjCQhBx7oO7QiieAgi0ac2udJBm4YqAJVjdELOsa5TlKmW6t8vyeJu12Cw7fheLLbpwqENjv/kHAETVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2wEN5VYRgjLJvISNiu+qayGsxw9ElXBjPaNTKqHW50=;
 b=l+fzmcrqOsmOGRTiTDfUV/hFUIZY9vzoE9/oHGH9mBQrFatpiKmhlW1Ppf5cbeuhZA+eb3/9/x84VoW1QDv36saA0cNxE6LJXTa47Cj0iaBKKkOZgt7TEG2losUsEzeflZn4eg3qAmJDkqe94nbNoOUYfoHA7LUQ6ytaj7/zpcfK3TPNo68OaCWt2W7rGgQKxbZQQLu8Y9WzkYDkVpGoRTSpBcXtdUx4qvUFjpt/rK/ZhW/BvadVKKX7HF5522QewWHPPru4dMPwiotbhkGSmYD0ydGCSc7yVOEFY9EZLM0QjtYVmufGzdvKSLBuY9Ho5Jy8EfzniMzQ7aVsZA6gYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2wEN5VYRgjLJvISNiu+qayGsxw9ElXBjPaNTKqHW50=;
 b=aVx0WlaV6LGrY6hHu/gcqkoQGc8qFx0+TV7rKfRbI+6up9tBZEayuW21GRDdp+7t3GJOE4aOOVSRul8UqPpOunpLPWA0QWUJLoiJXXgjcSj1vsHxWlZx1G8RR0yoce0Fl0PeT5wH3JcajB4SoHBax0Hxhl8lNsvnZ3NFi8Nc1w8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BLAPR13MB4676.namprd13.prod.outlook.com (2603:10b6:208:30d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 15:53:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 15:53:30 +0000
Date:   Thu, 20 Jul 2023 16:53:23 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v5 10/12] can: m_can: Use tx_fifo_in_flight for
 netif_queue control
Message-ID: <ZLlYc6HGZcdJ1N2y@corigine.com>
References: <20230718075708.958094-1-msp@baylibre.com>
 <20230718075708.958094-11-msp@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718075708.958094-11-msp@baylibre.com>
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BLAPR13MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e89c5fe-1bc8-4296-e872-08db89397712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFK4zmOhe6N9k3B0/Ij7zXc57B2rLLBBaAQfTmCVZIwlfC0SA4bSGa2iKDmisi9flr25lkpp7zjNOyqub7Xw/K1rW26EV99HjCTZ60hiBDJ+uJrYRAjG2OniLxk+Kge310zVEr49vcmuyMnmT0p6s28WKPKwoM0kRUp7iLPxIOyciTmC3LCahB3SCzfF2HBpghGH0roMh/iQbRa3g0hm5RbGkBMk7DEjh1Tpa373osOGiZ9lUIOXF9hjCq4wRuMdd01VQU0kjvhjqQbsXFVtTlJ2JdL1Hd/hS6XTiUq6b+sESSdekL8lycoIYq1IHGDnwEFOjgEYAZ/LWAuSMEmga8PZVNwr6W7oMPaMWL1+PpJ11nuVrT/s5MC+bcSjuLlFbwNJcmjk1FEiLryCfHOStyYTbTorH9uYTsyP0kmRfkzML8W1Ak4d5K/L0tLD41TthNxZhtBs3MLS1FZGlTqfyUtq0a+bSokazxtILfv23FmsEgd25/SESryuCkp7Ze5TnnvYT0oQTPqZiXn5dPqUCNxRQbAIrT0blkKhEjsA1AzcUDss7xF4H+lKa2XlAGUFAHj+aqh0hcz8gT8d+tIlxltQtfw47/JptbuvGk3T2Fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39840400004)(376002)(451199021)(478600001)(6666004)(6486002)(54906003)(2616005)(86362001)(36756003)(2906002)(26005)(186003)(55236004)(6512007)(6506007)(83380400001)(38100700002)(44832011)(66476007)(41300700001)(8676002)(8936002)(5660300002)(4326008)(6916009)(66946007)(7416002)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LIDtNN+tExpWtuJsgQlieSXXedPMgf8x62n1DyLIxbxMBsaN/sDCHNwL62Ay?=
 =?us-ascii?Q?tsehoXXGYsLdMbVyN/5ACsB4MtSoOPAwYOfCgKDm9I1QUsbNZIg2SRtFm98T?=
 =?us-ascii?Q?izhBkOK6GG1YIADJAimF6hKaQWahm8nIxJfU4l3o7QzeNWf10aqwrKuyOHYk?=
 =?us-ascii?Q?nRjVFWJz+MbqKqm58mrak2fIyvTlj5y+0xAaplbWNMswGiUVuhxRlu93Vm3y?=
 =?us-ascii?Q?OeJRCLl24GOCgSo6J6klMctHyQfyvqu5U+fVKVSWcUJ6csEgV+n4x7ruN2/3?=
 =?us-ascii?Q?AhJdrnsKM1u/qX1zPxUY7Dwuln7EWf2KxsRktkhOlt8glqWIZT4xNs3mhXn8?=
 =?us-ascii?Q?jS1F5HGH2/Q04ZRpGbHDpsFuOW8EOVkv7My9W9kZBEVywWppbsSF+4UWWU9U?=
 =?us-ascii?Q?PJ4+55wukI+srNPnZ2ulFtH3BBMDEQx1ELvihJg2JxgVIG8EX+Rd98Pr6kLY?=
 =?us-ascii?Q?vp0+ayBz1C5ZoPYBOpIRTJ2IPBIlp0by5kO3IpEtIsz1Jo8LQS1P3OwDwP5P?=
 =?us-ascii?Q?u3sNZ0mSMFSGo17Gc4Xac9yTn7tn2MYkT35MukGGs6ngjmNcP/rQ2b8t9dX/?=
 =?us-ascii?Q?VM8OTYHS6qip1c7SayoTJcCdwFcBqpiyDGEbtLLzbyjmxK/cVWragy0V/TCz?=
 =?us-ascii?Q?F1KtUdWnWsj6hIXsAhmSb1XVrDOW7WunhAkUaSIpJQSnR7+tsaDUXm1hPCmz?=
 =?us-ascii?Q?EzFkyK9YPpx/iQOlmlNCCb7N/cbzZ7UCtU5bRFWq+AG2v/yECK0WXZCnLPqM?=
 =?us-ascii?Q?jjG6w5AWwFzpbmKd3zqs4UCdbM/4gJFWJER+iWhKXUVQ36e2RfyCRXsh9ijO?=
 =?us-ascii?Q?bXM9F/Un3zi5L0cLjiEGg0rjGJtb8Vj2/TozfkGcnzQkOyBAyRq+7v0SqHw+?=
 =?us-ascii?Q?fXcuQNsuQeYUZVs80ioUzCbZLLEJkBr/aGHR2gyMxlAJ+CQ/UE3q7Wwu5vTZ?=
 =?us-ascii?Q?RSf+byBK/W6p4LHBJ1GiyBbU4RspxA2RrtyjEisSqLVsCKi6L00G4l2wuoTy?=
 =?us-ascii?Q?Fjt/I8hktzk4BZsS2AUjYntjEqZ7KhimrwYw/z4QrTEyYKSeIEVOJ9oc2B5i?=
 =?us-ascii?Q?xTjjmxMSNcl+ieT/BfyRAhfbmmkZSK9o45gUilHAjlxZ4cCiuMW702mMga6n?=
 =?us-ascii?Q?x+1TNFB3R9T1ew8Qoi+OqpJ3TjFprk74L7fBavAJpUY7/ku1D3dFJrn7D9aR?=
 =?us-ascii?Q?1grSRRm1BF11rsCblB4gfQol6Dvp53oawC1of8d5CipzvXfS5dv2fzeGEkCl?=
 =?us-ascii?Q?dl5i+wlJSsw/0aL3CO4aWub1/6nyZc5XDW/rywTnL4CUXh0ZvHR7e21NCn6D?=
 =?us-ascii?Q?nShVZYWBHG8xDXehEfgv107pgGC1T2xrbSTwhxNqa+DNwJIjQcvRi3RJWAU2?=
 =?us-ascii?Q?QoAnWHr8xE3JMKUalcAPon8EZq85aejLv0purM6d6F4STeg/tkCfuM4r+kwN?=
 =?us-ascii?Q?Go08+At/rLagHEMcEdS4rJdKRjRZbxZofcT1WvuvJWR6MCl+njwUJDTv74pQ?=
 =?us-ascii?Q?P1cV//tWx1ZGpzZsR5khSqzBURShky21v259eOUldV97RjyCznC4KHLNEYKC?=
 =?us-ascii?Q?Dk7v9S8nfP2QO4lPj34wDr/9z0fEFbhZCJDg7G5td5JS/rIU0qhFwBGXbMdF?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e89c5fe-1bc8-4296-e872-08db89397712
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 15:53:30.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+96ONZHIynt7zXFpua3aPLbSimLh+gU5N7B6wxRTpCaet3OcigpH3ZvqvUhs+IqMOo3LkJJBEDqUeCm+A3+7UQbJ6Tfl7myuK5Ct5Yx5yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4676
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:57:06AM +0200, Markus Schneider-Pargmann wrote:
> The network queue is currently always stopped in start_xmit and
> continued in the interrupt handler. This is not possible anymore if we
> want to keep multiple transmits in flight in parallel.
> 
> Use the previously introduced tx_fifo_in_flight counter to control the
> network queue instead. This has the benefit of not needing to ask the
> hardware about fifo status.
> 
> This patch stops the network queue in start_xmit if the number of
> transmits in flight reaches the size of the fifo and wakes up the queue
> from the interrupt handler once the transmits in flight drops below the
> fifo size. This means any skbs over the limit will be rejected
> immediately in start_xmit (it shouldn't be possible at all to reach that
> state anyways).
> 
> The maximum number of transmits in flight is the size of the fifo.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

