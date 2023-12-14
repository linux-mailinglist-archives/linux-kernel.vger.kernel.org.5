Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C2812E12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443888AbjLNLE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443857AbjLNLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:04:50 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBE197;
        Thu, 14 Dec 2023 03:04:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsEvlg60p0zZ5TReJnExPWcY2ijrxDReB9OW4AC48p8CfdPHgm/OaUxBtS2FGn07FqB8SeIJDxwEhogZ0l4s5BneT+DzRoIRLrQ0ySxUCNT3yD5txtn9gehwmuVnQjMY4VG4hq3Vz4rV1Y0wpISqCOgQEEKIlAegQBR7dBuTz/Zvs9IkIv8eJLqLKOa8Psq8UZyaiRL604i8Rqxt3OGt2HEZjU74ERv19XEwyYVzvd/Tx9/t6kImhTECzyDHS54pWJVk9rOySL/cucjUCy+vzTqB8EXn/NhgpRzLK9i/EoBDXAa5P2H2Uq67vXENljjrtq36zq26tkLIYJOzMlViFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pflpDcyv989TQf//x+qYNrITgMfQkkHbT14dyc+OIys=;
 b=Ns6sSOF2BZm2XGBJdLfYhbVHITNCnf96qucg8AYrYnstFhcSgOVY5wiADtS9LWQBIJasQhUkmO/gMsFDk+Fmif7Qsj4tnjN0l2v8a4O8BeNJ/NHLr9bO2H1Gr4Pnm6dXhtYBGfZDwABfkccbmy8OpGI8WGT1yyNhG1/tD582RsHiboc4tNmUTJ1X5vnKCXKmmkoLkFGHHhSzbGaQ770MWmRUXT2LgGZpAx/zviXPChiAiZBQswNH/wcFBx9dfwOqhcCLMyn6kwHF7tYlrGO8Otwcbbuf5ZQaiQRiW2pssQpcTHi0VHO8Ub8WcResXV0M6t8CMHEoSYs1HoxGRwUAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pflpDcyv989TQf//x+qYNrITgMfQkkHbT14dyc+OIys=;
 b=kLXr8E0N6upNbxGLfmXFJanxGE1s1iuqXodupnL894ZZPxJEn7Rgb00ktko1l/gL+v2JzxYj4B00AXq0rN1oSwYx5xMJji05I5N5ty+vZ/QHuX8rmaw602xqlCg7Iln0MtCkj/RarVs+FIrlozOh9E9Q2eEzG0PdWMOs3U8lDI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 11:04:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 11:04:52 +0000
Date:   Thu, 14 Dec 2023 13:04:48 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 09/11] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231214110448.lycg7yusrusbd7w2@skbuf>
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-10-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110721.69154-10-rogerq@kernel.org>
X-ClientProxiedBy: VI1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:802:1::32) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a80626-6485-4645-e6a5-08dbfc947eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsyvzvJ06ljXOUvyouBP5pZb2rGlTKx819B8uqXQ+hPWbJiAJOzNcK4bUE4GV0CgZx9/FkWHiRpha4E/YWdoH22piUHqUojyTwsTU7V/bsxNsp4cGoFZVM60GNzYqgUeoc7PU1Ri8mT0NqaJSMOoiWy00pYySCbV+P5dpZVswRghof/FcLMAUsKWQ5+YdStIXv7Ral0syb1VaW12qq+rAeriT24MVdRu6UKhnjJFXvv/9pYIQX7GtzRfJgEAXhh+ccTIRV3S90RMu3g+Xo9GxbVqS2zNC6L+PrX7j0Tx45A4GzWGTiHL2PKjMs+7cd2j7IF4rlKAXlYD89qd81yNjewouW7GBa0RYQ14RGv3vTYsQ59Qn2hmRVOluiIPCFvzFmhNQyn5l2XXyqloE3ia1lDj4+c+4fOw+0UhufvVpUw1sdgglE3eQMncQMOnbF9z/NGh+yjxx9ZF5XZcGxn86lsJFKufM0KfFC3+chiiYvzNcUROOpz8+ihguAl5Y6zde9+F7UvTVs19ro6E8IMq6sy3VETm3zVE5mZp53cjqVrC5DxCkLSwHy6wh0748E0O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(478600001)(6486002)(38100700002)(83380400001)(26005)(1076003)(6506007)(6512007)(9686003)(2906002)(8676002)(41300700001)(8936002)(5660300002)(4326008)(7416002)(86362001)(44832011)(6916009)(316002)(66556008)(66946007)(66476007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ORDOpEgJwyFYqhcgNiChs/mOm5QKZy+eD1LKJQ3N4/VT70cEWlwH2FnKDaZ+?=
 =?us-ascii?Q?Z5X/ifcdHR5wQ+ifgOlDMABmQkqshBqbVtO54Pfznw3woL6kqZ5shE9sDwnj?=
 =?us-ascii?Q?/v1ffsj9e055ONId54bzyLXQTjIhyM4HkeAIYHp6zyhMkTyc6re/lJRWDJud?=
 =?us-ascii?Q?qVgQFd0/T1SpKksiMpHYXAdmoqSBSPcAm0m3W5hYWolydzPjb5Q4ONT/iPgK?=
 =?us-ascii?Q?bFG/7TedzKYDTli9ZT5pvbec3JpmJA3GBXp5vD9BNHLMxzMgwaTMgSrlYJhR?=
 =?us-ascii?Q?MeSDxMDfIOOsePTy8f5qeIv1yi1FeRM4A4ZiljUVPDjoL7K6jyx3eFvEjxK3?=
 =?us-ascii?Q?C4m2mNQJrhKoY+5QVKnrMUyKp8WagLmY0c5ms17E5o07sSbC0DN9q3KPnG9t?=
 =?us-ascii?Q?TkEgtLamgCvPupHMrPof4hEUF9TY5xF+Sxx3diqd+47jFy5Gell9geOHNUUO?=
 =?us-ascii?Q?bXnLxNba/4m4G0xRtfDYhKCVVGfNpZOqcHzfQRtm1FAQuvEhhFHsKVtbFDU1?=
 =?us-ascii?Q?jvR56vrQnqOSmHZg1Z+AxsY2j0F/JLNrFfvLSCfIWPGwTSnGlGn6wH370V33?=
 =?us-ascii?Q?k0eZNMTJtaFMP3x+ttnqHexvCI9kLkElcvzpzuyVHLIaiE4O9j4oO/9GErYj?=
 =?us-ascii?Q?VvJnOJ8v2bJAwpHLfwmhq2/YkzjD1NQ4+Z8l1XKs0GqiFoGUDm3zo2wcb5YO?=
 =?us-ascii?Q?SEaG7pFMY4lsq/h9wtWG87GQSZd3ebkCPCIpBUf8FSt5PmzIigVboiI1l0Bd?=
 =?us-ascii?Q?vcopRSmASzirpNGgVSOPHXsXv9uuvC2QgEqvcCFvtnz6S449vjRlXi8UgoJ8?=
 =?us-ascii?Q?CypgD1AbGUDpYoXy8dB5XXb1PQ3PdH9Yoyb7uIqvOGm42RmSA+KBEFojKUay?=
 =?us-ascii?Q?WlY+OvSISbIMXVsoGUS0YWLslGijXKO18HkoKf+Za9BQELSt6SXwA/Riklr3?=
 =?us-ascii?Q?UZ+Jp6EaLe/ZygMDkfy6oxpoO/y4ECIEmoNgSaL7Y2w5o4SCCTDIxfdsrs01?=
 =?us-ascii?Q?k+2/cNE3V/JbcbFVv/HVG3LVaI4cMLQ4xGgWKGbGDVJ+/dxry+x1R3xksadQ?=
 =?us-ascii?Q?SSPNEJ0O7rdDKKtTyHwQTDPmioVyD9Y9TEnePva4FZpUiGDR19AJh9iJnVdV?=
 =?us-ascii?Q?wIptx1OQYJuMAabq5xqGRGquVS4pjhaUSu7MYcv+5P0AOdSJ70ktUCHHdYI9?=
 =?us-ascii?Q?4Bj+3xgkZa2Kg7DvO+GzqimjP/+9Be+WDFDNBPSAlxSIwi0RW0Nc1rX71CSd?=
 =?us-ascii?Q?E4DErZ6+s+HaIszOkVghQr5+Xk5QDhk8rwBzGJu6pz7xxWOckm6Fol8w9/d8?=
 =?us-ascii?Q?W3QIZ9Y8DxthvwBDz+4hJilYMSxumq8VWecuS6szyOffP7iWfxR74pzTElLs?=
 =?us-ascii?Q?WT3wnMMJwTlDWQDHiuv5RPL3vPRP5ZDMiwXI6Tr0f534xVnlcMcFj35N9cLI?=
 =?us-ascii?Q?d//rYXZ9B+Q8PJ13NUs1jczCU7b7aB88vN+TSa5kKto6uMrkgBhnGRHBcYpv?=
 =?us-ascii?Q?5/b2mFYo+MiJh3z3L0nwqHqGFUYigTJ1Mhf+zPhCexO/EI4+7cu3O2dHulfC?=
 =?us-ascii?Q?SqY8/TR1TLaVcQxe4WMLfOVsra+H2rp54zfZhl2ySGrOO6oMkdSmRQvNYRi9?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a80626-6485-4645-e6a5-08dbfc947eec
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 11:04:51.9968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whyv5tF1krCMDf1Ryk45ty0bEWGGs5ceYep1Aq35z0rl8tOLZ7d9EMRJzEgZVzpL2dhOkFrsWWM07kAJNzuptA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:07:19PM +0200, Roger Quadros wrote:
> - Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
>   1G link if link is inactive.
> +
> +static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
> +			    struct netlink_ext_ack *extack)
> +{
> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	if (cfg->verify_enabled) {
> +		val &= ~AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
> +		/* Reset Verify state machine. Verification won't start here.
> +		 * Verification will be done once link-up.
> +		 */
> +		val |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
> +	} else {
> +		val |= AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
> +		/* Clear LINKFAIL to allow verify/response packets */
> +		val &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
> +	}
> +
> +	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
> +	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +
> +	/* verify_timeout_count can only be set at valid link */
> +	if (cfg->verify_time > 0)
> +		port->qos.iet.verify_time_ms = cfg->verify_time;
> +	else
> +		port->qos.iet.verify_time_ms = 10;

I don't think I understand what the check is for? The netlink policy for
ETHTOOL_A_MM_VERIFY_TIME limits the range between 1 ms and 128 ms.
How can it be 0?

> +
> +	/* enable/disable preemption based on link status */
> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> +
> +	return 0;
> +}
