Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44075C1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGUIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUIiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:38:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2137.outbound.protection.outlook.com [40.107.243.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A5271E;
        Fri, 21 Jul 2023 01:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDHzGZ9HXz3LKBKa2TxDkFxEgv+Bh/qABX96rQTAGZjiImj3HEhRmI9XCe/Ooffxe/RHZStaQl4ljZ8fg5yJ6SfLaguAjiAxhNn6Cw3oBHCme5TjBv0EXIN341yfjsbHAM0nZ5pvD4p+MJGCrkmG+XvMztJDBBHJyTEsEZYeVxL3xIMTg5xOMBePH0xK9FFsJNNbAFLED7B4NfdxJzeUJaaNPX7dyO1j2c0zJKK0EP3ZzHzuT3s31gP1ogcJxbNrM4osu9ONghm/tKIhvHpCdptgHTR8bTl1RmU7u9vKjodmSBzHwYeF+8RaqGxrt2ZbUjc1riDCSvYToElosmLrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud29kbOYXpgHDn35Uh5L2HHQ1CoZAcWxJi6uSciyx8o=;
 b=Nz+yc2dii1dC8LfQamIOCxBNx09EoEvHuyS5canxB2Im+23LIYbgWWedpZRArT4qxrdVUA/SdMJesOofSx8lPfXOgiYF0WZhTg4v0wvXuzO7kXfX0QhXa+8c6jx9MRMOvZB4+0bHC/56VmH9FuqRKu0bl11+DYu7ZvQGTHmO2Im3TSPzapQXXhRk3csN6SpQrEpvekQG5hwX9LW/Sw13d4b2TjKJTCHpTXcmxf4lVLtYj1haR70oH+o06XkkG/mXEitU45qp0WYYKWM1zx0rK1dGAfxjULtP+JuHJ3cFdNE03ca3k6GWw7tozg7OrwcPLobr3fo4rF5vT5tozEHn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud29kbOYXpgHDn35Uh5L2HHQ1CoZAcWxJi6uSciyx8o=;
 b=jCM5DXQP0z7JKSC/J9UFnOegXcu9sENIT3RiXEwnColWdZbPrSS7nQ4aizVU9qXJWyfUDmkOWxyA9pTNpoG16mx+yWlrGVRNLcBreayYgShsbUcyrhJvfRopr+jP5PRHiR4HQlRf1dqpX8891Yt4qjh1UYQ9JVXiz1DAKJImMV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO6PR13MB6029.namprd13.prod.outlook.com (2603:10b6:303:140::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 08:38:15 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 08:38:14 +0000
Date:   Fri, 21 Jul 2023 09:38:06 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
        benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <ZLpD7uPbGhYcYjH2@corigine.com>
References: <20230719183225.1827100-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719183225.1827100-1-kuba@kernel.org>
X-ClientProxiedBy: LO6P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO6PR13MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 2835491b-0494-4b34-0813-08db89c5d2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNmLVWJxynm5HqtQDlpPlp4vCBCqmJMpqktftcaD5L5objhS9bzpIQpVj7TSAkbHWP1ZgtA/1kGs1Has9C0Cg3N7FUJhdT5KyjbhIOPsCjEF6LIq2kF5u1n5bDwXS6m3mGn9Nog0SiT/NFvpaDRCcIEV2eJzM101oSOV8hN2WDjBB0sDGPnQu6XBSyG+amADScdgTLdyUNGVzVa1mISHXPB2k3GJGt6b5WGF4ptPGhl6xZShxQ+n6TWbaZB0At2T4AyIQV1ouny2mV/7ZZGIe+n5rPLQBzlln2jVOainO3OLoKB/44sXzTP43Hutrq+piv+uKL38RN+vUdsFgSPVnnmPM13iGHvvF1mJlU0PZEGwHcWg2gefj6dzNeNyTKCXkSFayxJbMqZoJ6fZAFb2aGROL78NdCdhRMScrnvGdC70FOsmpt4g/50O35sRiyfUIkbH0W8X/g0YLVK4FhBVhkDkqeYIyL9e+68xr9+hIJJpm5abijDCeiWhTn6StXykw9MQW9EzGFlS8DshZgfMcybG2nyThVA0FS7e8FxEllqkm4HWK+kO9xC3qLQ07T0zYh4HHs7s2Q/nTqBKfM9bc/5ebx/mzem1WXzOLpXr8qE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(396003)(346002)(366004)(136003)(451199021)(6486002)(6512007)(6666004)(54906003)(66556008)(478600001)(5660300002)(41300700001)(8676002)(8936002)(38100700002)(66476007)(6916009)(4326008)(66946007)(316002)(2616005)(186003)(83380400001)(55236004)(6506007)(26005)(7416002)(2906002)(4744005)(44832011)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gNbL8NwHevtwvtijLlpkqKEGk1iXu3d0JXJnVue5arSDRgCE+j8M5ghHETOX?=
 =?us-ascii?Q?DLTU+u7m3Ztucnu1V0Jg31/MjMThjLXuN+zj3yIROcFDu7lNn7cu09AQcfw8?=
 =?us-ascii?Q?JSXYDg3kgu0mbOHxUPt1LOLB+IqHE9aF97CVn1T4oX0NG8D5MNLP/WDJAoJE?=
 =?us-ascii?Q?x+b/daZAtfcyz2vh5vqoin+MxyYNarH8JmrdYyFEx+9cuEEN/Mc98RLk47dk?=
 =?us-ascii?Q?GEJEul00Q4tQxTuFt7xDTI33vtXS2mkSMT+CEUkyG7SuOMtSZLkPXCagGsUR?=
 =?us-ascii?Q?EOYXdckY+7ZgCvlGniuQW65a8NWMk4PDmF0wjVVjQ1VYIpr00uKWXVcB9a+V?=
 =?us-ascii?Q?ZYjNewvyoIpegoFjGypP4DuoiPoqoenxpE1djCRBtYXMPXLFENDR8SD+jFmG?=
 =?us-ascii?Q?2IxOqsaao207bAz/LLs4fNZWhDPx+EYaAWgv4Miaj/a1npEaV5XtgFOEKFKR?=
 =?us-ascii?Q?g1nkrxtuACzxgknm6geGXUzky7/FUa74U1iAhrQccBkxi79YNz54ScGHeRn9?=
 =?us-ascii?Q?VknatSTBBY9Mo6UIHI5jmxSys8GPabkudii9Y9c4bQ8WL0jczR+MzgDf8NVt?=
 =?us-ascii?Q?by7co8fPB2GV52TKLrA+NZHtP0hpAH4T4+gWV7c3kPIwcUSaRb7WmoGdpg25?=
 =?us-ascii?Q?WOAcUdyWXBkQ8Eap3UcJAKQivGQABqo0pr2rDGWWCi9Sz+CmHHH7fwX5dkEA?=
 =?us-ascii?Q?b1NtwNkEyq81HY+SOw+BmMSgSQ1QJSfx7yNrAje7VlddH9mJzvSIUkQDnEqF?=
 =?us-ascii?Q?4jogRmvUd0piN85rZ4JsPUwkzuDTFl9bu7WLkaiU6qH5xH+Bs7bDsOBTQOhh?=
 =?us-ascii?Q?kvqSKyb4PCxIdjlXuVOvrCj9ZW/3XdjhGPwr2S/HJUwjQr2oOSpFyE8md+el?=
 =?us-ascii?Q?tTwWVLUmIUk7mq1bBntdqNzAuuc9OBuQT/jvWsytB0WgMeDaozeE4gu9gxlQ?=
 =?us-ascii?Q?czQVk65TcsWM78BjwRPNg38AgR47r7+AhSPu4vqeBZUXLATzAsiM8SlygA7n?=
 =?us-ascii?Q?TZhBIfXzUHIG8ihg0aIb/B/An9R9iBLJq+ZD6ZA/yZVTFwhXYytf/KXwwYvz?=
 =?us-ascii?Q?XZttqoO2zSOqy4KPGCc0smsKt24RTgHwTuSLrE3k6WDGCExEXY1JPH0XdHG+?=
 =?us-ascii?Q?IqLu3MMOHvtFzSacAWjUHN1rp/BZnlNpdzHGROqpqKsTKVdFF/eu2c5tbIHz?=
 =?us-ascii?Q?4ZnjaFGYFNorN4TQCHTE38dleTYSuR2DXRvX+dWKgl1RcBoSdwtFf91I0unU?=
 =?us-ascii?Q?6SQ6kvbxnHXx5lMzOIvcwKmSl8R/r/uc9awP8aOieqMbcWT2aCVP/4PWA3V2?=
 =?us-ascii?Q?0QcAg3L5CuImB4V+jo9q7cHMMW6QwTmZLcjoBjHiNo59wZn4EJQYf6ZfRsAS?=
 =?us-ascii?Q?kHUzIqIyOSB/RiyFGEYCK+R1FBguUx+CiC8z/xbXU7ysyjxq1FPrf6ibOZiT?=
 =?us-ascii?Q?zddxInl+NS0RCQuO8TpbAIoasj500WiLdzWJj22Nc3LaF5y6iPTfnc91WFte?=
 =?us-ascii?Q?hPjg7zje8PpDHHelKHuiXtnGpLQG/Wfhz0lY7lpp9TOZWPv0TnZ4M+q0k+wm?=
 =?us-ascii?Q?/5Nn6SlpmfK+9gF25jcpR81zQ6WKDwptfCk1RtZrsqc7tCyBhQqKK9k71TEV?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2835491b-0494-4b34-0813-08db89c5d2eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 08:38:14.8168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER8TXahR+cYQ0PtqcJdcziuME9Nlwi+pireyYZQZlQRo3luLZPuqTa/6QVzRTswHAGJZJbtejVcKGEV9M1d0c/q8GLlcIeaWlE4D+iauXpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB6029
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:32:25AM -0700, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

