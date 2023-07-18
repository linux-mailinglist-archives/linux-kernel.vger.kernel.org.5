Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79A77576B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGRIgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjGRIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:36:15 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856DF10E;
        Tue, 18 Jul 2023 01:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDEjEIf7ky0o10tKLiSMc9ynfQK1WhBEaz2Vgd1dcuDQzHl69RXu3ihvqnJzvgGTw+Yr2jppMIxZkIT5b/gtMWWUt2zNhEptESYbtMl6Qv8Zn0ctki+CTzQuX7l7I8MP5iIKApJRmwbCkHjC8QPIfel9Qc649eczIi2jHVu7vdPdpXct6G5o6yTfBJDf6CZipH5XD331vKcCe3oauj5IQPckzAemz8K6kypuJIPIiGNjoph7WS7aF0Y5gyrhaIUhD4yVRPEQKQd5mSACdWp+/+3Ta4PeZLnrEv6B6jyn3qWDQ63kcmBjcoT0UZaQDMzIKt9OCS6hToXcNlGEZcJIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM7TtU7VlalJhGuBD4tJ6gu1lu7VYWzRSCKQrQPhkws=;
 b=MWF/RvlzTI2Y/ttkYYmosV0X/cgJPvyerDzFDfW94sJN7r8Gy8EqGZb762nVhJFSeS6NtClLIDpgoiakB3YUQnm2axsekeAa4O3aLO35CTwX6yxAaC0F9DHdkacwxQ9Y+MGR4oB4Eljl6yGURQFfkUaamXj0pyckO8IRW1h1LQIxY3UkIf6tB+xaO2KHEzcoErYv1UiZtjBSRhshEBuMQDIkf4tyQlyGp6jAcOBrmZ8SezaM+vmdF0kCZPBHlxN7zrX3s8Ib2Da+2yOPX743MOdXnqN57k0331Kz7dTEI2viKb2umOCbZvVQQw8ISqaz3jfLDGblr80DIWF6WxXKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM7TtU7VlalJhGuBD4tJ6gu1lu7VYWzRSCKQrQPhkws=;
 b=KTEiqKUppJOwLypakR2cLm9+ddFykp2S2ZpK5hT0YTbr/jOxZPLD0/GNicpmATHId3NKn/phd5qdGbFeASXGLJab4nyy5qiTvRzVYWfZrgGTvFK9Z7O0D96Rz3ZHZLS7IA+gEaCDG1/jFwArVH/RrC2NVwjuGtzGA9rsIDjbw1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7830.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 08:36:09 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 08:36:09 +0000
Date:   Tue, 18 Jul 2023 11:36:03 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 11/12] net: phy: provide phylib stubs for
 hardware timestamping operations
Message-ID: <20230718083603.hl33ne4oe7f343py@skbuf>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
 <20230717152709.574773-12-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717152709.574773-12-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VI1P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::41) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d754aa-78c4-4a59-4516-08db876a089d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ahc8A5qzYobEpoJPVknzcNrdbeTzDfbXYhL6xLEjeTEJU3Fl3yKUEbiEIJGUX07CB8gGpd9/o1QzJZSpDe2rSyVzlQGCyBsj0Fz9sN1wfKgu4m998LS+xbDeoUa2L8JHFJX1s7KNNVD2WoGhE3qsAn50nqqZobIbYDPmkBI6zkccaVWkEvYvF5v5DtLqqK6Si/XYyJjTZxncga3Pan5RH+gvNFqfPYq6gPnL2cdt3mAlTcl3B1pLr1L3WV1IG3W4QUJVKZU393VD/U+uTn8Zr6+dhypcK+F01boBsEUKwgKSiHfUvKCDmCgtwJyMqnD82uVPQONOp99BpiouHmTcOD5aE1Uz94pZ+Cw5xAA+cS0yYoJzo3KEgI7uPxt21hEEtRS8kILn+Wa47QfckQelufC985xaQ7Gq6fCt2eV1PHliWSN5dAlCS2IGl8jBq4yp7j+8voa2/pQ0gwYi1KexDdOaF2fWpgXJ5kGzWYFlJsA2rdwwKcDeD5Znn7ok6A4q/o4QRZ6A5/jlE2QwsrA7YhAyi/ZEUNcchXRAgNRQJ30OScmhWFesuJI1QAfuggv1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(6666004)(6486002)(478600001)(83380400001)(1076003)(6506007)(9686003)(26005)(6512007)(4326008)(316002)(54906003)(38100700002)(6916009)(66946007)(66556008)(66476007)(186003)(5660300002)(8676002)(8936002)(33716001)(2906002)(41300700001)(7416002)(7406005)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IyItKMnuaLY5wbk1F4F7aKNFgNFL0hK6Uhwj5ow9pbgfK9BwgRjqoP9yESZt?=
 =?us-ascii?Q?cByik8o/KL0AITlt7KKMmffAvnhS6rGIx5cZrNgbxi9Wp8ziBkL/fy/Ni7SY?=
 =?us-ascii?Q?u+9Rjx97o3YGWN23jZHsoA2Bhrg5VyQ4ePqMjEPqp3ipdGJh6oBesF1pXPXi?=
 =?us-ascii?Q?g96ksy/WbEoRKltF5L+XmxJM7DVZ84kxCpb1DsOn73uVsZljffh4Kz5IvfpG?=
 =?us-ascii?Q?9oBC69smrELHBvjjtOX71Osq5lxnGueYb9JoWpy/g1lyPQ697c+RaKwUTcnO?=
 =?us-ascii?Q?U8x9C7ktnq+ypTfVawy9J3t1qd17ljNdg2GKppsSt6Kr8utOnyDzyPMLjBWe?=
 =?us-ascii?Q?zJnCY84MKep0ebfwg/gNMuW9m9Ywgp5W+qiwSPxBbeKT1oZltR0WXXfrv4ku?=
 =?us-ascii?Q?9AFR8UaiQQ05F0b9T+kIH6NHaom23tWrmHuVfCt7OTERYp3cFl/rXkjB3U8M?=
 =?us-ascii?Q?CkQM7urN3AIRLNI37yTU3SeIzxfTpjlDITi9lEjgO4plMChNIQMR4OhE2wNm?=
 =?us-ascii?Q?deeVQj5PSIQaTHBZjrcm1o+/+RWoKAhJgLquLznbELw9Xx1l5CtAs1PCp4tL?=
 =?us-ascii?Q?O92Oj3OuYTG7+pd+PLY9WS1RlUeYwVDfY1n+5TZdRhoapb6pPcfzIGwFpxar?=
 =?us-ascii?Q?551hzpPAYL057kXDvGEZJdYzost3wcO30bu1RegfSD6KAn0mAAUTTvvJnvkI?=
 =?us-ascii?Q?ZoruGxL4TzzsHpmcB6o11gxTlCyzPTjYkcbdZpgDoWuafNYsa4C9DvrQzuqm?=
 =?us-ascii?Q?4zw7gB+2Nld0uxCYnrxLcLF8bOKVviIcUlmWC5ryMoBsO5pN/8jk5EUjMdeB?=
 =?us-ascii?Q?LffyGzveraRzi/fXZkZ3xcAxcPp6RSCH9qdqHhL1bgLqDFIe0TiFZaCbu46d?=
 =?us-ascii?Q?Ew5Spz9f4oWSLdNOp+NH8/W7KhKQDbbr6x4PqjQR/fzZuqVOzRSCBV+2hMZT?=
 =?us-ascii?Q?CIDJOflQ8JIykwsMkMSfj1YT97ldbC3RA6E7r3KM36Eru/BULGkw6LXJdaij?=
 =?us-ascii?Q?fTj/1Y8gBnwGYhcw5uhb8vdStFYzaNp2q+A1OaEyjVhi3kw+qrSYVmPo7jwo?=
 =?us-ascii?Q?Wm9l6TOq8gHGvriCTwhqfsy36G+Hzz7PzB3FStmD+dNrpTuDEw1c2nJvTXxf?=
 =?us-ascii?Q?Aewa4tGIGJV3yGJH0N2/PcchgU7fl3IAWep80Fszh88+zDKOSVuCEg8U/xLs?=
 =?us-ascii?Q?+u0fxR/Cx3JPN7cH3kj9Nm9lQ0NBUw05uyk32N2hbQmVTulnS9esS5qFJteo?=
 =?us-ascii?Q?No6RBmjdELlXuYVo2c46hwcz4sGcBTNJ0S9/6sr0eVyRvo5a2PkqnA5aGYBc?=
 =?us-ascii?Q?GpdiyrU6Su4cDrzJ3srDRC3wMa7GbuYMQ79asmjtfRZJ5RT8dlDhBL5AqLwE?=
 =?us-ascii?Q?J77KpTOUZfyh7qZclNSdZEpm54UvlSN03uJbXft9OTZZLyjcG4Nsf4HMD1ZD?=
 =?us-ascii?Q?LTSmvMb3ZK7SoKkXgj6zs1nXMK5B3mVhmtJl5T0zd7chgfTK8w41ybgE+ImX?=
 =?us-ascii?Q?a3VNisjp1HzM7nnb/2F5ee+VteWAfE8KtStYtELok9tt9di53wj/9Bp0tYns?=
 =?us-ascii?Q?fDh0TnKLcyvDS8ftuHNLw/M6DdOM8LEizliQNViSjPX4iq3fqwq+ZT4Y2oM3?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d754aa-78c4-4a59-4516-08db876a089d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 08:36:09.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2lbcwhq1OZYSj27r3fxg2748uG2Ps6bQgM0ekyr5u3se70J6Au9Gax2YX7rESWlmThPGH2NqcGWPOOEZqrP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7830
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:27:08PM +0300, Vladimir Oltean wrote:
> net/core/dev_ioctl.c (built-in code) will want to call phy_mii_ioctl()
> for hardware timestamping purposes. This is not directly possible,
> because phy_mii_ioctl() is a symbol provided under CONFIG_PHYLIB.
> 
> Do something similar to what was done in DSA in commit 5a17818682cf
> ("net: dsa: replace NETDEV_PRE_CHANGE_HWTSTAMP notifier with a stub"),
> and arrange some indirect calls to phy_mii_ioctl() through a stub
> structure containing function pointers, that's provided by phylib as
> built-in even when CONFIG_PHYLIB=m, and which phy_init() populates at
> runtime (module insertion).
> 
> Note: maybe the ownership of the ethtool_phy_ops singleton is backwards,
> and the methods exposed by that should be later merged into phylib_stubs.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

I should use "git add" on new files more often...

Annex to this patch:

diff --git a/drivers/net/phy/stubs.c b/drivers/net/phy/stubs.c
new file mode 100644
index 000000000000..06498de2d16a
--- /dev/null
+++ b/drivers/net/phy/stubs.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Stubs for PHY library functionality called by the core network stack.
+ * These are necessary because CONFIG_PHYLIB can be a module, and built-in
+ * code cannot directly call symbols exported by modules.
+ */
+#include <net/dsa_stubs.h>
+
+const struct phylib_stubs *phylib_stubs;
+EXPORT_SYMBOL_GPL(phylib_stubs);
diff --git a/include/linux/phylib_stubs.h b/include/linux/phylib_stubs.h
new file mode 100644
index 000000000000..1279f48c8a70
--- /dev/null
+++ b/include/linux/phylib_stubs.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Stubs for the Network PHY library
+ */
+
+#include <linux/rtnetlink.h>
+
+struct kernel_hwtstamp_config;
+struct netlink_ext_ack;
+struct phy_device;
+
+#if IS_ENABLED(CONFIG_PHYLIB)
+
+extern const struct phylib_stubs *phylib_stubs;
+
+struct phylib_stubs {
+	int (*hwtstamp_get)(struct phy_device *phydev,
+			    struct kernel_hwtstamp_config *config);
+	int (*hwtstamp_set)(struct phy_device *phydev,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack);
+};
+
+static inline int phy_hwtstamp_get(struct phy_device *phydev,
+				   struct kernel_hwtstamp_config *config)
+{
+	/* phylib_register_stubs() and phylib_unregister_stubs()
+	 * also run under rtnl_lock().
+	 */
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return -EOPNOTSUPP;
+
+	return phylib_stubs->hwtstamp_get(phydev, config);
+}
+
+static inline int phy_hwtstamp_set(struct phy_device *phydev,
+				   struct kernel_hwtstamp_config *config,
+				   struct netlink_ext_ack *extack)
+{
+	/* phylib_register_stubs() and phylib_unregister_stubs()
+	 * also run under rtnl_lock().
+	 */
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return -EOPNOTSUPP;
+
+	return phylib_stubs->hwtstamp_set(phydev, config, extack);
+}
+
+#else
+
+static inline int phy_hwtstamp_get(struct phy_device *phydev,
+				   struct kernel_hwtstamp_config *config)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int phy_hwtstamp_set(struct phy_device *phydev,
+				   struct kernel_hwtstamp_config *config,
+				   struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
