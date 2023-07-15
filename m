Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033BA7547FE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGOJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGOJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:34:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2116.outbound.protection.outlook.com [40.107.95.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80959FC;
        Sat, 15 Jul 2023 02:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov39GhzkhLK2l2VtknaaEjT/mkUvJU33YE0YLWUqwCDlzDi9G/ATwdRwzp0eAX0d8m5nZ6TCMi56CPKmKJwqvRI1mhfUPtxF8XyO7nSgnE33HcEDlMNfjRy2oihkHVL28Ozb2/81+fPnEZwMZ/OdKwA6CLm+ruEQx784m72TFZbV7A0DBrZ0mBYbX1HeBZAWXbQtPE/VQkUX1sLwvUB3BreWEEXyzYF1kbvHk6UKse0B79rQudZptRztOxSfkeIWbshox/5KZMX/sNlyVfvglQo+yczjvyYNa5+6pazEwE1T8HHpmrCUK4iCB9qOvI6l0T7CGxWKzz0eJkyIWLjtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6krfjLK8ZhGIwy76jwzMu++CvrifaXZJHh+KgkOZMI8=;
 b=YfMjwErgmw8v1dLXEnQuEz7JSt7vKTu/UzvDCrUG1Jq+htP4msRJQba9VGHYX4u36Jct6hM6+FpMIpoPFGGxG6xRUfdTw9FdkrMRml8whtFDdFxlS0TyIyTtrZbMrWLHChfOodjIlS+p+2hM4btqR6Blo3xVUBb3uM7ykBwpn1wwd80YoONTiZcM2xx5La5Qpu9v+wzDDapaDzjSy9bEftT1l3nC1pihnFywAexChXWtS8d5pG7dogr3C3myO07Gu1/WcZNoHX6335dNy5B5072q94XJYhLg07dYXsQcoGrKUg2jNmRHX4xkSP2/eK9LFpZ8dxdjx0Ll8qUlw7Qcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6krfjLK8ZhGIwy76jwzMu++CvrifaXZJHh+KgkOZMI8=;
 b=SIv9FRRebaDaNqZBgLW+bo/JD6CNFDu5ix/oOv/VbVYdADQ3Z6pxiTNas+KvfOKoyd0O2AiZE4w2Zu0EQSY4BOh2cUtgXQ5yUrvtWSJwsBpMBYWWymJD+gxL+hs0Cll0kdIDZ17MVZvaooCXIEH+PuZieaGEKcT+h5dGAZESXe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5329.namprd13.prod.outlook.com (2603:10b6:510:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Sat, 15 Jul
 2023 09:34:28 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 09:34:28 +0000
Date:   Sat, 15 Jul 2023 10:34:21 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        "maintainer:MICROCHIP LAN966X ETHERNET DRIVER" 
        <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "open list:MICROCHIP LAN966X ETHERNET DRIVER" 
        <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH net v3] net: lan966x: fix parameter check in two functions
Message-ID: <ZLJoHV+gdBMQrnfJ@corigine.com>
References: <20230714085115.2379-1-duminjie@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714085115.2379-1-duminjie@vivo.com>
X-ClientProxiedBy: LO2P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::36) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: 92573e67-589a-4db3-030e-08db8516aeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qasxhXa+r3Q3RRm0+kESP40sOSKMFYIYaktzuq+cWF5BA95ieITZDiC48I1yRYa7vamZAXEnryM/WLFXB3KcUVzcVlltes75FPhlcErMkYxdaVF0LK4bceAzrWOk+2qgtWIRjmk4lcYSiM31lTwqO+7OiUvJZRHFAzr+fRcmpwriSiM2J6nNkpXr5inpcHQxiWpRXCG4XTdZQPfVneInYPPe8UJXKHyQQ4TlSJN0Emmo3p9seOuMKTNFJRQICNv4QOpxd+VrHyZ5ugFs55SZtDROT6vLWDBv9FKoqGbx3mJtW8jdK5oo2zvgaEpBhFz2HYpYh+vHI+6ISyPSaEj/gLShbHwpr34Tp8wztoNNMZSIi7qe8NFhFtYL+/xotuxcNpYDGaBmig+bMu2F3n8NrymrTiXW7r0tI7FdMcmSX6ZdZrvbyATI/aaTPHlk7+6lnA3O16+zwTSXg4+nDA5afarp9G/qSTVdzBPZZWE6xw8A2+Z233eFLmqIfEvM+c9q6vZArO80jFsGxAb8LG6zkFMKb2r3wSO4MfPhdm6jT672kJY5IiHB8CrORgiWS8VtPBJyV1n0ujAH7A1L7pKrIWwC16Oy6/w1YoZrdrxRjXd/rIZNbhnCqIp17R7BoTv68JQbAwhfq+YawVfdyRSzYRhcQ4wOgaexQ4JjORR1a38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39830400003)(136003)(346002)(396003)(366004)(451199021)(186003)(5660300002)(6506007)(6666004)(2616005)(6916009)(26005)(6512007)(4326008)(8936002)(2906002)(41300700001)(66556008)(4744005)(66946007)(316002)(7416002)(478600001)(8676002)(66476007)(44832011)(54906003)(36756003)(6486002)(86362001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3d4picd2H+17jn886rJ4M0tOZ19pImwfgrCaMp/06dV3/tuRZrpV8x97lQWG?=
 =?us-ascii?Q?CiR4LTGkjRztgAgeuk+WPNNk5hya7ptntRxo8aQWF8LIEkEvDJujyRjwmc8W?=
 =?us-ascii?Q?RXZ7eqoI11Vu8J8USAgRJ1LpSyR8f91A7HnxlY91o05dwj//MVEdBbdfQ73P?=
 =?us-ascii?Q?g1JPqEJBBDKp0kVfdKB0dndr/hZczX9abul4jxW9sG/21tqve1SvAuRoKXnf?=
 =?us-ascii?Q?VgD6o27EfCLEQezZYT7eUdEA+KlgzTIGoSJGv00wXYwOMg2Mu4LZWuwzE6CK?=
 =?us-ascii?Q?pDjnskwj7t8fTvS++00VyMF9mM+YMyeB/0oxI9713MApLIKiA+UJCr0gNNPx?=
 =?us-ascii?Q?w9I1geY8RXqjgjkgrEIwarUmkW4V+Gga8/Wagm48dB685nqxgcU/T4A5SdRv?=
 =?us-ascii?Q?yPrP3klTef0TzKazYbxBPjbafFv1JuwtBrpLHbEYVaqtr8wSbyGWzs7Uj72V?=
 =?us-ascii?Q?eAS1d/ilB5IE8PrtlD+HRkjdJWvW+vA8gWddYi7F5Bn4K6Nw8/89U1bCZFab?=
 =?us-ascii?Q?FZftTtOIsPqBhpUlBVOLMSFkBcEZeWHRMxWCnJUTcrlstMgi+SjTYJEmLTXk?=
 =?us-ascii?Q?tWhBEERSNmHcunu4vk/XVTXt6k6j2bPZ4wC12iPhjFeINfiTrVm8ha1OiJs1?=
 =?us-ascii?Q?76jUTNCiT433rsReBwAqNroI0RWVefCWk1DPvGybEskQ8B3R2TGKyHTN6GT1?=
 =?us-ascii?Q?wkcKDaRgjzfFO7ybykySNTaqK9nIQrq/WnqOjB50MyxPbh9VHIzK+KsYByhJ?=
 =?us-ascii?Q?5IzwyzgGjBMBaj+Q9f/C0XVqum3gagnn4bL9uJz6uDnDkvMy94DhyQbzbW3a?=
 =?us-ascii?Q?kh1G/HpRXHrs2+xClFcF60Tst2G/IobqReMchTSIxQ7Z3uNjxuJPJpFwrjjz?=
 =?us-ascii?Q?ZW3RKc8trS3Z+1okPT7XdR++p7XRHvCrIxp5d6j70l/WQeibnnua7Vapi2rh?=
 =?us-ascii?Q?m9tSWnpliRw+W5xylMD8fWQMjYijpWWJMZLUtGCfGvRtv7ip1kplhT0BecYt?=
 =?us-ascii?Q?PiNrM7EiTbtblXVaXH/MdFERSC3l5cYNmLfesQOnq6UUXK6R2IiYCtAIXt3m?=
 =?us-ascii?Q?p1g7wEOBTkrDPkIAxrEwsP3xr9wp6DQOVMbpytcrhqLFw+zPD9fqNPnnGqLB?=
 =?us-ascii?Q?r5l3fCNnp8Gwa5NDCXKJYtBHKX6N+7h/h02FYZLhj4OAt6vux15S2LWxSRXe?=
 =?us-ascii?Q?uoYOjlEWCpzvpdXpWXkDOCr7wfFEt+u67HS3USrD5LniyVKXYL37f+L4OZF+?=
 =?us-ascii?Q?ldV9WIH2dlPFY+Kjwr+hIiHjLV4ze2KQnNDeYMq2+gHEFsf3bR0Bk+sW2Bwy?=
 =?us-ascii?Q?pMMw8uBaYAth4WslwD5+2N8Vb6BLL/EQLsb2iWVy0+jp/HBWAqHrFIG7nIMo?=
 =?us-ascii?Q?m/Z++CYJGTtQ5ODf4gU/kisNLAUaDJow8k7xCQAtSKiLv/U8zYSasb38+K+C?=
 =?us-ascii?Q?MDn09BzOxHTdMLBdxCF+zR52QfIOLZJd9Sopf77HFeTQ20YWy1J4t/VhorP1?=
 =?us-ascii?Q?hrAnRQo1/HMZzncPsG9NhU3opFcEGamraSXGi97TRlDSNRkyyVg/BXxt9CoL?=
 =?us-ascii?Q?OE/2rF5O1zag+ED2VZx1vayG6paXyCfgk+LNN2RP/IYX+siyNOx4vguYMLgY?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92573e67-589a-4db3-030e-08db8516aeda
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 09:34:27.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXkH6dmfM5hhyiEZTgOzNCDpUybuusA60+uz/31Q6fCWTz9P6sfVWO8WNvzXP8JzISHnB9k6s0VeDX4Aht0KZWlABrUtsHftai+zWbJzwN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5329
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:51:15PM +0800, Minjie Du wrote:
> Make IS_ERR_OR_NULL() judge the vcap_get_rule() function return.
> in lan966x_ptp_add_trap() and lan966x_ptp_del_trap().
> 
> Fixes: 72df3489fb10 ("net: lan966x: Add ptp trap rules")
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

