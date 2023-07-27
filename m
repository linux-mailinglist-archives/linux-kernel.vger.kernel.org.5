Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B928765774
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjG0PZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjG0PZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:25:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515E01FF2;
        Thu, 27 Jul 2023 08:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEFs/CrNIhrqcMnE7T9c/346RQsmZbXZMdbJBYRoJ4MJRcmJQT7Aw5DLVmsWe5YWwLrrKoby/ru6fSfBqVOE28ISCxDsvG1itPT9iBJFfP/yiONFF194m2IAttKqlE2PRTK1PuZZfnHtTtfTbIOxTM3mLZwJ4q94UnQQxRwMdXcbPlOrJF0p+QFlt50YA6I0vkNRV9mXdqPpA6pB2Q+K43U0/VhK2n9g8ql5BlLONdUguXvWHRXBlagO6stvFRF+blyshrcGjcKCY1RLZLWe1ZpoLeLj7GtEnVlM9WmYAZoHVUYbcSek0dT65L0wW3WxpYqSB3JkPI7HOuZ7OmdKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbOqT2Su39riI0S0edFd0Cg/WCJk8/Twy8uszvUausM=;
 b=GLw4xwDGQvBJsFrIZPUMW5EJr/O94PCGHZDeG1IDoL9zDwKq1/ESG8b/RCxROytdGeoDVWMrUL7O9yONJ78to8YCP20wKhEn140uO4noeNLTzPGn3tSpkFGKLB9k7ne6RQSL0niN4XqcWzIQjO7146sGl8/QO6cID0YY43mEhQnnmvEs/LyAYsHhihS0GRXoIaAhdwUpst4sX0Q5/+22Tyo4uT1vAokDEuwb1UKO86CdRUdLbbvq9S/1NJNdNPjvpm7mxd2y5NTZxFAx35P9sC/U7aMFY74YyHfpsajdo3HoH18NJrgZy8QFoM/wcJ4G51gq5Vujl/wYDlhozkmfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbOqT2Su39riI0S0edFd0Cg/WCJk8/Twy8uszvUausM=;
 b=Qv6Ncj2dcAmRAIymd/RQL2gtDxS9x6ONGS8Icp6iQjTcfdyx/BNm1rqT7TT9pnIRXc5s/0sLW27YoJVW4wb+G3Y8OdpMMHUCyUWAGAsRYVwZSQ05uI2iWuY5OqV3WDVGssuf9Cz6wpPg7u6tK/07USsWBeUtTEpeEFb/b+65Iic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8257.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 15:25:25 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 15:25:25 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, imx@lists.linux.dev
Subject: [PATCH v2 net 0/2] update stmmac fix_mac_speed
Date:   Thu, 27 Jul 2023 10:25:01 -0500
Message-Id: <20230727152503.2199550-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM9PR04MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 509b706f-c2c2-4b69-8272-08db8eb5b361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8oiCNBeuPZ+2n+MbtzSgbSweVGP5i8h0AxMtNR6TZc3ZGshv1dp1BIfipx5VM/0Kl0q115YfPBe7XTmsJJjc7Ov0d1XiPE1GB+CtbCZMyXmV7OLOeYp7B4Vz8V6Ub8IKH3RCDJ5lxjsrHome/Jzo3ZbNvBAlxzpttSyXx1EAfPC4KRREyrd+n3NpkjIij36cHWKPy1vZClrElV39jNXE6bm9AfZw6gNBzliJGkbKzXYTb1j6lXJpiS2w1OuceXA9zdwjwr9bcFcInD5v/Fk2pnsC2pdVEJ3UuOcLE6Apgs04U3YQQRpgxDiTjkehQl863RPAkzdQITNVRnZXP9BX9EQ1/FgYraxR+z+6JfEWJtbgWyaPeUWxhkQnXA7xP7AFj+Ft/CnU5/25COlPQOqvUGXOKpMF0i8J7ZEiqoavQi2Pc8wbyjskO4PHvx/+R8DfxBR5AHlssJl+HV1sNsnLRP+1wtciPbCO3up0ijD5wgxWcycjiwHcTpCvyUOPlh+UYk+PkEuOOKYU9ya0KuWiIhNtTAYBrZh51PfW5g1Dj3iEccn6ZWA4vHe8egXkhI54QUP97KulcNuJxKRqOGSV/MFVKwO5yhEQLS5kfk5hdsLyJwB2iVOHZLaG7gvmFKkIobt46RaaLplUQK5G6MCHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(316002)(2906002)(8676002)(8936002)(7416002)(7406005)(5660300002)(4744005)(41300700001)(44832011)(36756003)(86362001)(6506007)(26005)(6512007)(1076003)(55236004)(6666004)(921005)(478600001)(52116002)(6486002)(83380400001)(186003)(2616005)(4326008)(66476007)(38350700002)(66556008)(38100700002)(54906003)(110136005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtt0Qa0kM+kW+VgqZq6serE2edetp0yZfxyGk2RtWXqSvrIs4BAxMrl4VDvp?=
 =?us-ascii?Q?0c2cHYrgw56PAbrPoDr20QM2Ezxb4S9nldoiLAiC+S2DdKYvDvpuGoCLMijJ?=
 =?us-ascii?Q?PzI4Zx/78kgOo7t7a+Qc0DG5rauYA6wxrfgvcRp6P8LKQp5SIC1onL4LTg3S?=
 =?us-ascii?Q?E8Vuzx98YFjcD3U9XxSNnTDa08llJaWp5HpyXRDIOT1ZNpwOHyBLS959PObT?=
 =?us-ascii?Q?Dvd10g5UMQr+9bXLydtVfRizk8Ag1yJ3P8iq6rF/kxpw4ghWWDxPlgRuf4/u?=
 =?us-ascii?Q?o1ZDe56M8iFtSbhSq/9nyqid+g7bFAb8DAe6mCjQFAtcve5NHpdkLQ19Zz1Q?=
 =?us-ascii?Q?QC4Dw/YpVIMXEzUtjAqlSH+/hCakiHtIjI3TTOB1Ii960e3nhHWrhc2e9KcW?=
 =?us-ascii?Q?KGgLp2HMrGrS53PB3y4T4tXNzM1O13HdVjwl5zL/YRbx90gJM0yz6LMEzEzF?=
 =?us-ascii?Q?N9J9fH49WEgaQ3AGEDYlnIwYW1GLuaJZgpXAm4aIvQJ1nZl+4Nex06r9Zizd?=
 =?us-ascii?Q?gEzXqw9W8Ttq2x8XxJ0uO9unyNtup8kHe+d3GILCwHkarOYSz0Cyp4OWU7WU?=
 =?us-ascii?Q?VMrDzqV2nPVNXa52sAlJDi6v38jqUp+0KgDXwC/nygFNFqwJde71Ug5uxB3/?=
 =?us-ascii?Q?hQBZHfOVIOqQsOfEauZ/EqyZlGPLSvec2X0VlQmZdB64iOIzR4pvjSWKxxwf?=
 =?us-ascii?Q?BZFQVfC1TTczLh1VzCsil32jLV9v8d2hKU0jF6tqnU+Vytc0IXOysvpPKEK2?=
 =?us-ascii?Q?cgkadUniIG0HGpR/jIIbMHGdvN290au8hkwd7NvQOrFEFTbku6rYXFcq9KcG?=
 =?us-ascii?Q?0hj4+wpz91iV3Xjnh7Rq134/e6igMbj4d+FrVGBZWSULRQqUnDBVLcNdJ5Lq?=
 =?us-ascii?Q?vzBDfjbg1sARk0LoJD9QliH72+WOll7HaTHjfTkux9chBYd59LMV8whFHULd?=
 =?us-ascii?Q?ovWzFsFV1lZmFVps8SptETy1ZDOLFMgaMNpNLN0pNZQbngW90T6Q2UDlBy6K?=
 =?us-ascii?Q?lyWRFyulLStJ4e0VLyLf73bbryOxulgQ0ggBSjpnZg3Kv6drN7L64qioRtkD?=
 =?us-ascii?Q?4hStYUWkHDv7DbkRMXK3JwUlXnsc9KvREooDUs3rH0rc9E1Zw5tjSfH1xfZj?=
 =?us-ascii?Q?HlpxjdycZLjatJMzDF+KzFDDBTKzJiG2HJgvdXzmN/qkvS9ZvTFHCulpl3Oh?=
 =?us-ascii?Q?7ojm80zmBd5msW/rSjW0d2yccF4QWAQLsupTKLyrgmNXlaqpzVyn5v3p4tpA?=
 =?us-ascii?Q?zuf1KCnDyPKkjR1bZXEd5ngRC5lN4MEqwptP91kZpnM+uo48oLO/lSihhScn?=
 =?us-ascii?Q?r69H1E+oepGbkE6plVaHKIXMk67R4HNyT70PeGVqpXlZp4yIy1IIb/aWa19q?=
 =?us-ascii?Q?sR+fTmxoitryXOOhiFgCyBVm1X453mW/ibEkB62kJ926KHGoohOC7Xfohij9?=
 =?us-ascii?Q?AkoUFOF+doqevImTxw06hCP6jGJnKM8wJQuZSXza0Ehhc9zm42uuT5EUy/aH?=
 =?us-ascii?Q?2flnSYYelPDGuzsBba5RLrGHbsfDe1ZcrFOXeReUbdfwPDHLqt+IWg38NiJu?=
 =?us-ascii?Q?ejbKyNS0V7RNWoM02jW/fZMu/QEhUtZIy5YdEipF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509b706f-c2c2-4b69-8272-08db8eb5b361
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 15:25:25.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIGOWBakiGGay+uYSNrAZCKK3y0FOA5QOnkD453oxHHJNOKNFYnOg9soBXi1qEMH+tdDWDqJbLoTOO9yK08bxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V2:
  - Call fix_mac_speed() with new mode parameter added.
  - reorg the function of imx_dwmac_fix_speed_mx93 by using the
    mode parameter.

Shenwei Wang (2):
  net: stmmac: add new mode parameter for fix_mac_speed
  net: stmmac: dwmac-imx: pause the TXC clock in fixed-link

 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 47 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson.c |  2 +-
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 include/linux/stmmac.h                        |  2 +-
 10 files changed, 55 insertions(+), 10 deletions(-)

--
2.34.1

