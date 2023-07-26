Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251D3762FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjGZIah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjGZIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:30:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2133.outbound.protection.outlook.com [40.107.237.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A26A58;
        Wed, 26 Jul 2023 01:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQEmGxLixvLpF221yi6It3GqdGMpeQLdK9eGxNcKMqDDTNMY+KJwKXAKufiQUFgcXSy+ynA3aa4U53r447B240aMpUFj/nYiG5OrqauhJHfowQjah2o/Z9EUDg9pnXn7+MZ1/fxodRmdwG1UfU61hB7NywX2q1BrtgssE9tWb/RP+DMs+NFveQp4uRA5V5WABF8gTDqs80NvIToT9Qt4pXXGS97S/AG9gtV/Uf1NzablsCf138f0+PF9OEBYT72n569mUAMd682jr6du+Fk0ZyGYzqH+EPobnNQKm05FBKHvPyGNnCr4HcTL0uNUqWfv9k6gNvkdVy/sdEs2oJYBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrKR49IPqjnUvGeMUwFiW0RxFR4WTCHdAQCVPoxAPRw=;
 b=EcH0ai2TTx3aJUKdowlFhZRJGWAX6XaO2F5YUpdrTuz0W8DN/LQkdck17raP8Ed/hyBHYDy8Bcp1zaxcdmdez9pZjF/mroMA3b4d+fVIL2K9LAvBd+qLsg9L74V3kWOgkWs7/cVFvk7juLvRnRFB6DoeEgezalqx+TZdIkBzJiO0wv33E+AH5l46663QgLqEpgTlnatnCa1JSk06o8QjmE+pbJ59VATw2dLSDB8wzKy0ikoqChuLJKETWq/oCPvEsTLpWfWdn3QJAkVOdj9PHRTsHG/Tdn+zYHkClJEJUpPMcQGqdcZqcZjHhTebzQyfgntRpaAWnJf9RdweQ6Pl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrKR49IPqjnUvGeMUwFiW0RxFR4WTCHdAQCVPoxAPRw=;
 b=NFAnH0JnjOtAOmDnjBFwbrE0z2ZwK2bZ7sWh/gJwrB95pW4GBnE8H+cUpk3UgYnj4Y5lweK0lNPHiQpe0tGfljDbk8m1PZNYQj/thjB2i0QIVLb2cn2wMD+bzETgJLq3C7pFGEA/6K/DxmLjssoSeKEVXBTYcXVPALbLsIipHLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3630.namprd13.prod.outlook.com (2603:10b6:208:1e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 08:19:41 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 08:19:41 +0000
Date:   Wed, 26 Jul 2023 10:19:34 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/3] net: dsa: qca8k: make learning configurable
 and keep off if standalone
Message-ID: <ZMDXFiSFI/hyr8j6@corigine.com>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724033058.16795-2-ansuelsmth@gmail.com>
X-ClientProxiedBy: AM8P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3630:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0b00a5-9cb9-46a9-7f80-08db8db10f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuFbfmjerJGWuvK4lC+jR8fqE0ppyQPv3ZSo4NVmbueK6GtFKlf3YkjRRSR1PW3z4uGj7nb+7AosU0JpibYmxlR8GHUmH/T0T8cd5uptb4bDeWk5FXT93jl3CztmvNqMZm1YkIw77QeP7nvsAw7crabzWfVlq4XHboHuE8D6lgELaiI+TFuxZo8V+rBl0LJPgLPybl7ueJIIJHVy45VOAaMqe5pfUcdU9vNwlpDnWAdSU2JV++8qJjTnCEb6wXOMQYbeCXehjCuJ1L/bUOM66cP55KkWochvZmgQA8Pm78ToMIXqcEA6o71WCPaibzg6nf+lVS7PNVETayF9hj5PaFWOTmtbl9FxGDQJF+Oe49eNv/4GP8WwTNQQQpUF5ZxR9tdpNdMEBLhR9wDAma5CTXSqWdUwyEpGrSwxGRa9wOSEWm1zrIXdyFmypY9nGMObUFuVvXTfBHF+EZAzFBI7OdbNtn1brQz2iFR/iEY5oW1/pCmWZtQ9iyOl56oUoeNV3+45DUWUbKfZUNjzdrFysUrihfh/LMJx3ceWnhwKyDhDODWdx64Ih77JCJ/6EJEeQaP3SEIjwd0OX2+sFcDKy3FsA/ArfpU5c71mSASvVLdOdlDpjckj51D/3f2dG4HllHoeqLMrLWvCL+Nt+XAR8AMyvzMQpR9KLTdXnFRaAsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39840400004)(396003)(366004)(451199021)(36756003)(86362001)(2906002)(44832011)(7416002)(83380400001)(186003)(6506007)(6512007)(6486002)(38100700002)(478600001)(54906003)(6666004)(4326008)(6916009)(8676002)(316002)(66946007)(66476007)(8936002)(66556008)(2616005)(5660300002)(41300700001)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J/wv1jJ5BuqZraSbH45aH6FLMnD4NV+NMQR3MXlWp1c15e7Jk16t7n/i5L1O?=
 =?us-ascii?Q?kVoPWtv+br63qjzhLXXa13FhhuzoRnWZxoXS3US9VpK4BkFdX6Q5arZ1+UIB?=
 =?us-ascii?Q?4xBPL4u1TTRaUX0mhWKEKgtRqX1vCBr/AlhY3UGi9/BU/DVrlD4napatWRkz?=
 =?us-ascii?Q?C3bup8He2owcfb62sVhLA6j/1BHEZJbgh5/y95EVAQ/IeeHj57N5+XwL8Khu?=
 =?us-ascii?Q?PORnRnGhUvP7NzKeWsvpG2xB0rAywPaijqnCzhSuCftLXKsamAUYEwE9gv27?=
 =?us-ascii?Q?VFWNEZUwmLepGUbUiGrSRL3udKcsOZSBxbpTRrASW3i7NfqLLlS794RBylyP?=
 =?us-ascii?Q?w6uq7dKOhK5SwLClmKYZmPOFXDVnbUW0osfxCzgb54ZXrnpoHL93K+d5nyHs?=
 =?us-ascii?Q?VUw/v05okIBAK3MkfQrKwhsFVtnOvhw6J633Xcv1yHP7keBZwbJtxjLVysv9?=
 =?us-ascii?Q?rnY9t1wKU68txdZ1gttuSh44LhQC6dAJHlNMfZbW/TfUFSnU3mmClOJKfYbT?=
 =?us-ascii?Q?RtESs9DdpFkFMe7BBaq3AI41CSy+Jtnoj7PiG7yv1Hw0Y/PJ3YLvpnYGQPVk?=
 =?us-ascii?Q?3Mny7caoPmi4jdY+mxiVN9dMVH6QWbtUhIwUil/T/NRYLtUmdnDcMRu/owp/?=
 =?us-ascii?Q?wSBgnlRfqugdhfvWhWjUzkshPZJDWI9EB8t7sBzDribn8PdP5dyEdqK55Bex?=
 =?us-ascii?Q?3jKiFZhqwjZfNJx9U7ZeNqAsXOonzryZcNSal9N7shHYgArrW0zG6JNKxnj0?=
 =?us-ascii?Q?LIzqbTFC5qYDS27nkaBExjUCHMSf7l0sw2kNrNAEv5yp+j+QqRAixn/83nT9?=
 =?us-ascii?Q?1LRvM4eI+slrvPOd6Ei/B1aw2Pvb+dQAzawCr5Td5K3Q4jkhIhRabXEpPTO5?=
 =?us-ascii?Q?9acJm1ZnTDl7zP95ucoqwERRCr/OwUcedZostYnWE/aBraBcxO8iXzxmR53I?=
 =?us-ascii?Q?fKCX9SiY9FbE0j0mY+Xvz0iix8/L9q66t81ZUaSYRxKX7sR1w7D6DlWCbbp0?=
 =?us-ascii?Q?yum2fBIDYNWSY2XtFsTt38mDjeQeoLlGPhrEDKaVjz3Ymoe6utEuUpxF+8IJ?=
 =?us-ascii?Q?d6CdeRo68j+fgvFcyF6S7DdMAaVdSOjsVf0m2r+aF7QXOJENsXN2Xaje4S2d?=
 =?us-ascii?Q?l0VUZnMkk5y4t+GLYeeGzNPS+TeDwy3+ywbnjU4c0jw9zTw0HPCHdi9yVo6j?=
 =?us-ascii?Q?5DKm7/IS+0KPE1GvMX9zBg3vv3IKPe+KUqA5hFnfjrM6ZPk43VRHegrfOm9e?=
 =?us-ascii?Q?Bxgk5l7BO1Apf8sAMv5rC2QLwC2J7FTclAHAYcXSdVaSc1wrfvBQ5E0Bp/as?=
 =?us-ascii?Q?mGB76Y80mrwm3WIOs6jeA+Y+i3fxvm8aKNuzXiW4x3V4n7lwOLoQyCg21+HX?=
 =?us-ascii?Q?xlk+lQjxUS0taiw5KyeG/XfzSwpTF+9p5kj7JmcujpYfpey9cQ1+cioqnfvx?=
 =?us-ascii?Q?+fA+USRQVwC5uNs9RZl3LDNlhKxYVHY0X3APFWa1IPgcOeQObA0bN2+qM6mZ?=
 =?us-ascii?Q?tSuhZRsy9/nADHzQ9DZvdtT+v2RobZ9QoNllaaSJpZM2aRd+UBLWmNlT58qF?=
 =?us-ascii?Q?/iqeAUoZ0eG0m9RKvAnQa9c/ic7v3eGsA915cGWhyobwhDl5K8DEZflfaWV4?=
 =?us-ascii?Q?Ft9TTrG0+rX5VzBDJ4ztfbicbDPWeB8Aj3h8P55WJgmmqRbt+7VnSbDMs09F?=
 =?us-ascii?Q?YmE4HQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0b00a5-9cb9-46a9-7f80-08db8db10f5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 08:19:41.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +u9xWgt9XsWiJZHMXVM2c21MzDM8LR9c6nTjrv33QQXHshyckwchn/wgThwJz/629pzlTOsGw5yMI0gh3nGtRypzNp7EvCpeUCmSTol6UA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3630
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:30:57AM +0200, Christian Marangi wrote:
> Address learning should initially be turned off by the driver for port
> operation in standalone mode, then the DSA core handles changes to it
> via ds->ops->port_bridge_flags().
> 
> Currently this is not the case for qca8k where learning is enabled
> unconditionally in qca8k_setup for every user port.
> 
> Handle ports configured in standalone mode by making the learning
> configurable and not enabling it by default.
> 
> Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
> enable learning for bridge that request it and tweak
> .port_stp_state_set to correctly disable learning when port is
> configured in standalone mode.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c

...

> @@ -1978,6 +1977,8 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
>  	.port_change_mtu	= qca8k_port_change_mtu,
>  	.port_max_mtu		= qca8k_port_max_mtu,
>  	.port_stp_state_set	= qca8k_port_stp_state_set,
> +	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
> +	.port_bridge_flags	= qca8k_port_bridge_flags,
>  	.port_bridge_join	= qca8k_port_bridge_join,
>  	.port_bridge_leave	= qca8k_port_bridge_leave,
>  	.port_fast_age		= qca8k_port_fast_age,
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c

...

> @@ -591,6 +611,30 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  
>  	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
>  		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
> +
> +	qca8k_port_configure_learning(ds, port, learning);
> +}
> +
> +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> +				struct switchdev_brport_flags flags,
> +				struct netlink_ext_ack *extack)
> +{
> +	if (flags.mask & ~BR_LEARNING)
> +		return -EINVAL;

If I am reading things right then some implementation of this callback
return -EINVAL when they see unexpected flags. And some seem not to
- possibly because all flags are expected.

So I'm slightly unsure if this is correct or not.

> +
> +	return 0;
> +}

...
