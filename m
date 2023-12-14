Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCFA812E79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443848AbjLNLX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443635AbjLNLXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:23:54 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E32BB7;
        Thu, 14 Dec 2023 03:24:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPStHfKK7WTshpKnG+DiCCSYG2VUEo0I1HJlJruw0fR58swxjJ+as1SDk1PPDm9GWv7V9L5q+oGJvf816WGSb1HIguNllcXaJCDbmBogTrwIg58XnINmjgLtAaCHm+2xhONMtIZP9PznJYkdsL5n8th7UKPGK/Bi5q1C+SCUWfHuNX+E0opcZCfjoMfy6SCoMULhNSM/i9cMss3s6ua0ZFvgOvvVs5cEpmBj1uYI6fsCdunJbQwF/qGvTIAQKL0IsZiALkzGPqCV0HmLlwp/ETvydmw2q2SBLFrHARxQTKTtg8l0WgtaIspa4/n57eDt1V6pUUziENV0Te/w3kV/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAHHCatHVmCbhLQ1+3AVHoypJ79n3jTuNM1icp0PeOI=;
 b=Fn9u4R9oGulPLFLzCtlJ7+6kmcikp7UGXUyN25thVHRbX/dAtG3FXvDjTlCb8Knru7MASLKvdw8TRUw8rf2FoUIqh+mh/I0iTXgcfcO+q/z8wlsqC1P25J8fUJOqwy502NtnDfi0wliodMVEb8tnCXrqyJAYzSyedUucRVdL7QvulyEyFKOOUCfRwz0w2AvvLBQbE+qCJdx+Nl/iDAIHC976uRxD9Q4gZMj9QOarcyKW9suzv3fxhdgOBVPX0glNQkKSAPfTiV4aMcTPbA8iN9XaWy5ZmN3fIDvph+YwzqwX5HywNUssSZDCXngZir1z8dsJ35ll/e2b0xBvaIcQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAHHCatHVmCbhLQ1+3AVHoypJ79n3jTuNM1icp0PeOI=;
 b=d0Ad14+lj22ydl6DCjvv95ktrZsUEKmS8zgKUUYNvQ7tVuDPb4x2hHfaUCSGaAfAP3MB0BOoa23/ZFgB5wFmKwudK3cL0GBwgukjibh7LRt8QRxrythSWo72i9gepfU9recAaKvb/JQCXLKVD3jQspAnEe8UNPeLuu/1hZ+5R7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 11:23:56 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 11:23:56 +0000
Date:   Thu, 14 Dec 2023 13:23:52 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 05/11] net: ethernet: am65-cpsw: cleanup
 TAPRIO handling
Message-ID: <20231214112352.iaomw3apleewkdfz@skbuf>
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-6-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110721.69154-6-rogerq@kernel.org>
X-ClientProxiedBy: VI1PR06CA0159.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: e539d8ad-ccd8-48ff-af5b-08dbfc97292d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bza1RsDvpG9mmop5kQ1wXNootIkGLCd3DMD7GEqpUkQQQVwqtUytckkxCL/fvExcKq3CFrdPGSd3vbKF8KfkmXr6HHDbx+XrMBzDkYDh29LDZ058en14fbAZYHsyUlaygOQhH7TWz6JWxMqjmGffBOfM1TzUYppi6aAGgIGu4FnouruNAVF8tl480uhj1C9Gtdv33C+eW7EZDkxRQdL+qSQmBm/hvXuPP2fNhqL5cmyS36/s6ZMQterO3LqOfGU2k5jUHtia5ZKhBXC3W0cRYzRLo+KhgpZXTzcvI96mPa3bAP36gGX3jx9X8LLuNZrSe0SzZ/CK5mvtN5gLH0lmok1zHqPhv5aARBWeDP7tmwm/SpTYHcn1Vp9r0LEDaDTlY2UYG55kQnEPGJjtH1N7yYFrSF+o2v8K5i2+V+A10ZpiD8bl7y1BMnGvbh7n9a+8s7wKuf7NsZw/wAxQtpbYLuGe6gtVtosF9OfHZE7GsUXnt57gKqkaJfrVz/McLZDcUcuUyaibnCylam8Rer7feJlqSc/XQhD7ZIGb7urDmS4IB4/7PiGoBa5cmJq44rXp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(33716001)(86362001)(38100700002)(6916009)(316002)(66946007)(66556008)(66476007)(26005)(1076003)(83380400001)(5660300002)(4326008)(44832011)(8676002)(8936002)(6666004)(6512007)(6506007)(9686003)(478600001)(6486002)(41300700001)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4akb4KMQiX44jxnsQi6PtvO0HnjLihboiBfxmwmiYqUTJgs0v+35Ie/dq60S?=
 =?us-ascii?Q?Sshc/J39ug9bMtVFOkav7XuNeUNjJn7EzZ2fVaI9iGXbcaC2EQcdwhzketwt?=
 =?us-ascii?Q?Bnss3HKdAj30V56xlrdMKoGiEwQMLM5FV027oUeT+ntGlQE8RV2Wy14wDuVy?=
 =?us-ascii?Q?RM2zYVxiNY0Jn2sa3/npIgu/uC+Cg+Y55S/bd2FfO1+5Abig0E8QBMfe7/UD?=
 =?us-ascii?Q?Y/PW5GaVzNAnzQ5ylZIewWUXhkAt+OSB3jRrJNWZQjg8ZJwSWAwJqchdBYQG?=
 =?us-ascii?Q?ztPkTqgF5R3ISYPSfFfzw1ibBPR4OKX8ZANu2LyxOlJF1ysHwbis4Zm3h5oB?=
 =?us-ascii?Q?wJ1mLP9gq6zOP0nz8PkAYNZyJTQbP7MOA7mlTqyuCu7muaVI2PKzTTBar6y6?=
 =?us-ascii?Q?fx9YWsiFj3E1lSjOa73/AzrQGc6n/kTUvKwFKPaxs4eBBMrF6DbjPiW0ktBo?=
 =?us-ascii?Q?Dbjm7UhVLWwzlmahgDvD5z1OX6xOfSwf4K77X8zTn76tzvpo50TRpiQgz2xP?=
 =?us-ascii?Q?MCwJuZWpchSCasSYlk0uAVOpm+EXH6qnl5vwwFTUvWZ+1v1T0aUbzWLiJ8e3?=
 =?us-ascii?Q?N2PBkUV/wFXoAjWRUxSDiDlqo3JgNgJWlLkkAUkRETTVK2vOpMqDXAPd/Lmy?=
 =?us-ascii?Q?c3/33rOq5zgWTgpwe+yIva3fPrfcWLxh9pNjWwweOaD0U7bml00wmoDH/zTu?=
 =?us-ascii?Q?tV4rG5HH8fdZO92A2lOjK2cF1caqvqItsG8rOsJCC50Pq1DC2ecL5EKrgKI2?=
 =?us-ascii?Q?7Ihg7yMWQGlJeytuScdCkPWkPa5Y1p11EQb+SHr36Jc9b5S1HwjDqEvqQ1Dm?=
 =?us-ascii?Q?f29fvLeslxUQEIkXHlMKnd79/VGyX5VrklsmeLnYpOM1BTkEMiy9um8WGkr/?=
 =?us-ascii?Q?zHPYdU8lrWo7EMtxP4gJNaYIib4Qs0YN5Ehy4N4vGPHBbLeS43bPHZ+7dkWU?=
 =?us-ascii?Q?+Kk4t0fTuXbQcC2Awx5tRgU+W8OI646lhVR63eKla7YNd9kuXENcm8rtxc/+?=
 =?us-ascii?Q?xcjTHwRJWK/AVEoaj4OSgW4pcrOGWa58moVptWADd3upjQf8xs2oySpPidDN?=
 =?us-ascii?Q?vWU9G2rWFg0BLzrfdNWOQ669NiEzXzTWGGbvyfcE/OKHJo+/ZB2wgGKfdgCL?=
 =?us-ascii?Q?4Y+hK1HOt+awmYHGpgh5WJtZRxkiA9Y2u38Oa4Fc/IO5hnCB/9is5xplz32r?=
 =?us-ascii?Q?pU6jmsRVbvcqmCBuHcTwVgxF5i91FqHMlHqBmTmSEHBY6LxSGqYOmOf9v+LM?=
 =?us-ascii?Q?arTNYSwxBmd3yCWRZtyGpwvE6vBofTEpxLeoE0dll3EVBirex/GxcOJjWzaA?=
 =?us-ascii?Q?rQx60/dZl8PtxEBGRi9m1XtohrqIZz7PeILklHawpU5bX/7CIwRjq68npb34?=
 =?us-ascii?Q?Sw08Jt+pef9akLX2FtnkGt3ICaTu8JmuWdP7lvbbQMAtIb02ZSMscr/enAT7?=
 =?us-ascii?Q?PFPJ6KfuvSizlGoN3dBfR/h5FgTVIIbCuBJwJDJyQXTSD7LxV+KBSuE2t23w?=
 =?us-ascii?Q?ELSbgTB+9veZcPjkgyZCgufbyZ7pGpvPGW8uGpLgt2zydl69IQlzCu4X8fcH?=
 =?us-ascii?Q?XhEbhFvZkPakBD150BLy0klsx6PZi5Xqiosw5bPrygsvtI1w5fS+LH017L11?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e539d8ad-ccd8-48ff-af5b-08dbfc97292d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 11:23:56.5654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt4Oyr32cQuw9l20/S6HzWcpkkkBlEhER3l05+gbObxAWKnuRdCDGyteqwUzs78cuFHk+jr4/knALheQD8aMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:07:15PM +0200, Roger Quadros wrote:
> +static int am65_cpsw_taprio_replace(struct net_device *ndev,
> +				    struct tc_taprio_qopt_offload *taprio)
>  {
>  	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
> +	struct netlink_ext_ack *extack = taprio->mqprio.extack;
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>  	struct am65_cpts *cpts = common->cpts;
> -	int ret = 0, tact = TACT_PROG;
> +	struct am65_cpsw_est *est_new;
> +	int ret, tact;
>  
> -	am65_cpsw_est_update_state(ndev);
> +	if (!netif_running(ndev)) {
> +		NL_SET_ERR_MSG_MOD(extack, "interface is down, link speed unknown");
> +		return -ENETDOWN;
> +	}

I haven't used the runtime PM API that this driver uses. I don't know
much about how it works. What are the rules here? By checking for
netif_running(), are you intending to rely on the pm_runtime_resume_and_get()
call from ndo_open(), which is released with pm_runtime_put() at
ndo_stop() time?

I see some inconsistencies I don't quite understand.

am65_cpsw_nuss_ndo_slave_add_vid() checks for netif_running() then calls
pm_runtime_resume_and_get() anyway.

am65_cpsw_setup_mqprio() allows changing the offload even when the link
is down (which is more user-friendly anyway) and performs the pm_runtime_get_sync()
call itself.

> -}
