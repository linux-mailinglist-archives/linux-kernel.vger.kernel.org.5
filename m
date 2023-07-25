Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F99761FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjGYRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGYRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:08:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2110.outbound.protection.outlook.com [40.107.237.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AC91718;
        Tue, 25 Jul 2023 10:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6GicnA7tR3iISIjbioiq4A8Uhs7hvfVAw7YNu6jz4PAH6nGsbwrGh2aeF9+W9Gywa3sIRfUsdZt0P9aw2NMhCnrG9bePi95jsyEP6UpdquQ+N5kgUjvVBrK8cw4fSYKTQtKWS0RHbzOOdHho0A9kzyedRHrZ2u+i6wtQ+ji3eCzUqaP697v+GTrGkp3Spa/TKq0hxO1+JBVCx3ZHm5gkMCzPE2wBVv6NgU0PsAuGm5sYzLdrnRf/bOKxKUCTMVGWv+3TkpPSFAL2i1RAOJS51+EHJKFMO8kF8LQFOILFRW3z1DBfFXSCY02d3piuxO1P1ExyMuNlyHCukwOEP1eHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tO+TGPrtO0DLXfh1FUnARDvYC806dwOsH6nYjEdVAg=;
 b=Zi/NopD3cwNqA1I5mV+lz5xKCjlhuM7jZJvK2xZFn1JnogbcYQh60g9OGQ/RS1YS2xWzBca6kfH8642xrtvoxCWgAZy4NCTV34p/rfJcQFa+yYaRyRPKbwXVM8FYkXRsw+Mo6xpHbGzY9OcRGml1Beg48Kgzn8FVyWMK0s5q/1Kd+tNtBjEMcNkoT5G8KwlnQQd7bBEfP0olCaBzof2IJy3cz1JHyk1sAhnOG6Xywa9bQVQDorfBS0xLA/2EuQnsuA+wSWv+O/bW7ukuUWuQ7Xj9091mma3pK2NLpnmM3NZ7VBB3QJe/NUfyQl6wQUwL8QIeYT7msanfyeAVH36KqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tO+TGPrtO0DLXfh1FUnARDvYC806dwOsH6nYjEdVAg=;
 b=ZweIwsg0R+z3tcf7gA4OOF5kl65ch+vP0dE15U5IVu4XXKU9CJWTEzzBm1kB+zqKUS06iumR8k+wliTif0ihHMOKKhrHAtuNgc183QCJ4Q/JVPWkw6qlpteiMBr/yJ2zOpQI7Vzpil3qqkemV4FAA6wWQcGQOU3mudIvKlQN8Cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ2PR13MB6142.namprd13.prod.outlook.com (2603:10b6:a03:4f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Tue, 25 Jul
 2023 17:08:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 17:08:24 +0000
Date:   Tue, 25 Jul 2023 19:08:15 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        George McCollister <george.mccollister@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] net: dsa: Explicitly include correct DT includes
Message-ID: <ZMABf//vsLIOi7dx@corigine.com>
References: <20230724211859.805481-1-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724211859.805481-1-robh@kernel.org>
X-ClientProxiedBy: AS4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::9) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ2PR13MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dd1c8b-2ad3-4890-4e0c-08db8d31c14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DYmqTbsp889tpMlwwDv2OTtCbOQFqnRtmtO4F/xD+1+7cYuP8K5ERgWtwh6tQh1K51Sk6RVZ7R9ZnDaQejkEPc5B1kFKp8mEGssgCF3ByEfXyTnDCLsO56w2cNl1/t04QNpAGCQDbOYQUT+MZBPrhXsXLqpWYD/rr72UBKkPyLbEsLL7tAsvRJ7CXP4huhuAtbhncveH9d51UDYE7taL5+mXKDGpy5J4Iqhtx27EpFjq+Ts+S4gQegiVa2avDH0RxRbsNEGYUZbvI4OSCdmLuMH1SsRvnApsWJXp3RRIInd4KOXRVMC6p/4ZAawOx4L2HDV3RJ0uZqcw1BvfpMy88xN0PMAl31nJThInrhgUJ4aJPUQUdMIynjVjtpwnGQdawgrTz0jOVDZX50vW6zAdctjaIU7YsMyaoDzwEP2wUPx/pZRAQkZA0zsM6LLs60eZt9Bhs8OVsQwrfXMeLc+kvwr+bnEngo3DhRRSLJe50TIfpbyycjWIXnMaQN8PzQcqn3wA8kOL63Y0pUAHUNaisRggS5zhNs1dPIjyUtYi3qMtVWhVNmJj7M7AdoRlkoqAODbrFpwJBjfJXdjDvaK7hbBfD/RHgJhjBafXdeG0Ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39840400004)(376002)(136003)(451199021)(36756003)(86362001)(6486002)(6666004)(66946007)(66476007)(478600001)(54906003)(6506007)(4326008)(6916009)(66556008)(5660300002)(6512007)(44832011)(2906002)(8676002)(4744005)(41300700001)(316002)(7416002)(8936002)(38100700002)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mKTdqUGXvdWWw9XaSeqq0eYgFOZzR6rF/rw86+pgSharSa9pTBvcWkhx1/Sn?=
 =?us-ascii?Q?lPT/lqdHkj8A61sv7jBum4DwzyOLV+Cet2aGvj5xK0q16Hj9uCaf6iRFbyux?=
 =?us-ascii?Q?zQI+LWO0jv62qv8yvqY3NZUqRueVZV0s5AOlmIQl2yDXqBMr4RsoSMnOf6Yj?=
 =?us-ascii?Q?s5jTem9mO99sM+dE9ho1WHSH57DPafkOWO8rlxlGRMGF2nzhZW8wlUOIudtv?=
 =?us-ascii?Q?3bqjNDb+t6mFg+tvSEBT7/zg7n3ysbj7SdYxZ+Irn/XlfnOpU8XF9SH9vEly?=
 =?us-ascii?Q?91o3rchGRa2slBm46lXeee9UAKF5atb17hy8v7dOYApruncdVQIKun3Fer9n?=
 =?us-ascii?Q?Q4U237Do6V3gK3z3FxyNIaAqBhD0tyITihSnLTkEv51QLqCiaQzvRB8tBBEv?=
 =?us-ascii?Q?4X2SnyV6f1EtofR+6GuD5DFOW1nwjl9UpdepD3Vqo92GNDS4TevTGMnQQiZJ?=
 =?us-ascii?Q?mK+PvOlpR/uCViF42r3+zupK/z5eeKACVndl71DtlkXCpUmfnClfQnN9BVGW?=
 =?us-ascii?Q?aWz0i+fzHLS+CwcbJR1W/Q3ykWnx5m8F/pl3qg8godBVFpNzBs/INqwso3qJ?=
 =?us-ascii?Q?6lcpu6KkTslb3vrA/1js4TRmASOWtosUO0so6iahMfvJnmN8JRKeOXWZ3syu?=
 =?us-ascii?Q?c/DZMEdj6ePVRPVGc87A/JgUK68qnNCog3kCoJ2NDfyr4q5kDrVi5obiQu6n?=
 =?us-ascii?Q?IyQmgv2yHbxlbUmJ5ic0q/A+Neer4Bd+rylXXOpOW/POaHPhrQdiS16N20/J?=
 =?us-ascii?Q?6hPbgFxgaZAD2DIrHaiPsEyhVuVD3JEttcfZJW4SWlUz30Q0Tp+jiy/E4v4K?=
 =?us-ascii?Q?5YzBNPSGk0XWJ3uTEkiyJfNV4pDFiD0REsxJYXkBsXbdcTz/gdUakd0BAUYc?=
 =?us-ascii?Q?HwMmrlO5AHnDEA50T/uQgITP6KAdyy+D9LEfYUIKwzqy4wwklQW7WKs2glWH?=
 =?us-ascii?Q?MFgyWDLG4UnLO+ZLk8ujocdA6KVUpUX3HsT+Xo1gQ336hTjIPTXO7/IM5wZA?=
 =?us-ascii?Q?uYJNBVaaX1ZJhc/B4TDNu+z8nBDP2kdRUFJxfg71oM+/ZO2AmLAx7PBRq7yb?=
 =?us-ascii?Q?Xv1smuCljYXokMqQmKXNYOUU4uPPY7WwPuGI9tpaYGrh1x9dhvLlu4krXUYN?=
 =?us-ascii?Q?Xqi2k6xCKFjHQI2ymaKSUNcgLdE68RlHkIH8P40by5ZIRSRrDbtGpAUElkfz?=
 =?us-ascii?Q?WoeTfjyFr8ntFcShGP7y69VBq2eoVWb6bZOnCbVYSYx57K2E+8EGxYXUySNd?=
 =?us-ascii?Q?UgFV7CZNN3RQ2vKCNpbhxZ/VrtIP8m2CW+NHXBHGN57q+tmP/GgTf5i59vTP?=
 =?us-ascii?Q?6buC6QkH7/MG/REKmaYrMtE0N8po7EexurjSqK9jqB47xu0K4U8YYozyxDr1?=
 =?us-ascii?Q?Q5ftMhl6rVhWGXeoY+oFxqa42rS3o7Q+BWSpOodBhNMQCw/sXYhACJz7AXo0?=
 =?us-ascii?Q?NZMZRTDfMFUwHrSW9r8bjJO6XE/7uCiGoOnBeyW5QF+E+ShN4byJrUGPBU+7?=
 =?us-ascii?Q?lXmCBCrTKHRlazMHPUVqD7fb2d0dD0jB5rBo46kw77ht8LStU75dqsEl/OEl?=
 =?us-ascii?Q?oP9OnNxw/z+buT2R/oghmAoEQe2L8EBaJIbNY9PKeyk05XqVnouvO3kMiGW5?=
 =?us-ascii?Q?hySRBDRTvMnHseQajeTxiK2uynE+nI8s90i6wxcc//ey1kAIXb3IzoDGu+1h?=
 =?us-ascii?Q?L3GQNg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dd1c8b-2ad3-4890-4e0c-08db8d31c14c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 17:08:24.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFJ314jghfEB0l00psFDLhSTQ+ffzb9Y9VM5kI8SOvfiu53zb9NOeu9HPCp4POfeMSBL2GVZ/are6iJap/JRtcJq+5DqOmhhKyG40045SFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6142
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:18:58PM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

