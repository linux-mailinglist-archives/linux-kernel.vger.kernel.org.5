Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE457F1832
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjKTQKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKTQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:10:15 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D7EF4;
        Mon, 20 Nov 2023 08:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBU7r/tnu2jViJB71xsfOPDaXUt5S/vnsaZPtNzWvHLCbuxwZ9tbVlG6VS4yzBPDIsXNFAviRFr2VVCEg5vf27BNEXNXnBmX4qkEJT7a8neV1rgVIuZyKZ5Kw8ToybOJfCVB/kkrl6VZZed5hU9AeAz2NrIAzxETLy1wmZtgmvI1dal4rZtCSDmpCdhbBmFtbC9fbKkcKqNDyMKELIcRr2LVfHEyngkMmts0spovLGtodjxKgDiTyvvQE0yczM8w8DPutt1C8lOAZwb1C1BvyEjFFqLS+HH1lxv6CYd3wHHm7e9DF/JnFRBwgBOVmU0JxdH3MoqeAn7vzgPz1z0X1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKoPFVQyRU3ZfbTTiacHvyb3IyTYv+g5xk/x7lzmleE=;
 b=WiAbO6CUqnTQ473f8TBqGqT+Fh7trSJQ5YcKT6OKwBORCql2J1haVTckcBS+EKedgZxLKJ5AX8LyefcOqFk/0sLqaZtIP4SmX68Z2jrDnAYZjJ/uCNHyzdcU8eMfI99BGOVon5jD6Zr2XJEDEJPEMFJFpMIMUqOPpIBqWNIKpxqI83HxcMUJMO/L3C5k/dKgCXXa563iciQGMupC+oLFSiWqNMUvw02HLWdkOoo+ycGjLBla2XvVImQmtLdQ52Hde9dEruDsE++YLjh5SVfdNJeHNrTtU39Wf/F1yCkHNDMT/g/YZn9cRxMsCMAcFm1zed7HeRSa/g3OKAGYuXW2Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKoPFVQyRU3ZfbTTiacHvyb3IyTYv+g5xk/x7lzmleE=;
 b=fUqnFOb8ee/oXSDLXOZu6LKapDvQGKqMON/glzXrjYQQKknclAEPRefM3Z/2/wkqzJJvzcwo5aaTY0oJ1jA+6AexBTJErNJ9ZO0R02GtsyogRjx4J/xHThgHMmiREaTLaoUruInk60DESfT430cylhUJUEBCq5wxyl5x9wtqO+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9867.eurprd04.prod.outlook.com (2603:10a6:10:4c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 16:10:08 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 16:10:08 +0000
Date:   Mon, 20 Nov 2023 18:10:04 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231120161004.flnwqv5dousiltcb@skbuf>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
 <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
 <20231118183433.30ca1d1a@kernel.org>
 <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
 <20231120105255.cgbart5amkg4efaz@skbuf>
 <20231120121440.3274d44c@kmaincent-XPS-13-7390>
 <20231120120601.ondrhbkqpnaozl2q@skbuf>
 <20231120144929.3375317e@kmaincent-XPS-13-7390>
 <20231120142316.d2emoaqeej2pg4s3@skbuf>
 <20231120155344.14cd69d9@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120155344.14cd69d9@kmaincent-XPS-13-7390>
X-ClientProxiedBy: AM0PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::36) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9867:EE_
X-MS-Office365-Filtering-Correlation-Id: 082236be-0cfa-4d70-3354-08dbe9e32aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsy1FxEX7KIBMu+WtOLnUULkeTb18jNdqMOkJWHL6c763NL9widyl4DWN8L0UF76aPbJrFyxnpFaS9EyawbItOl3wN/a+EO3Qm4l3v9/+5RiQSxV/dP61pydr5gEREe4o/JzZXNhzkN+fCfE5fLsVCrHEFmwPYtt/rt18LyWejzY40Z6K74g9YncXAJfEmHxmsz2OZfIM2uJUE6LwYzJMjxfWhvq9bMJmdNo42m5QSUsI1Ke/Rh76j7KWIBM0R+3a92yns0RLAOQrfLaO5NzRchq5C8KjGQz3XRNtu6cL4e4bXpcCWGtjKszhUoUnQrNDvsQazOOI4T7GfHr9aj4hHPABhqwHZGAfTNHMHn41aqpeb4C6tAc+YmpQMHGpsp0sm8X32y4qv+b9LnL/60HI9Axb8k/TlP7MVVL5EZ+8PDP/TgK/c55oFbk4qt71Lj6e25GO53pXxNBWJgwtbYvUwGabbCqpskksU6+x/rV9Pmtcjn792kVoa3PqBMeIUD/MR0YDW3zKKF+zBpfnwLRbAUxZcbIXd5QWOCMPNmVe58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66946007)(66556008)(316002)(6916009)(66476007)(54906003)(26005)(66899024)(8936002)(4326008)(8676002)(38100700002)(41300700001)(33716001)(44832011)(86362001)(2906002)(5660300002)(7416002)(966005)(83380400001)(6486002)(478600001)(9686003)(6512007)(6666004)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WPRKjIDtSTa3tibpN43T8+NsLHy1Y7TEsVDzvdq5B35Btw+3pzhDTlTLCV?=
 =?iso-8859-1?Q?FsyV7JBgYrA6WoIugqD18Zn8Ax4uYp2pBcTBxHcYcBP8NYO57FtbbCLog1?=
 =?iso-8859-1?Q?GVjN1IfLSKkBQX/YN2Ky8kbTU7OWF1qqKgEC5q7bztvPz85rLczwSkI56+?=
 =?iso-8859-1?Q?O0e6B6y5rFo5gvePxmK9on8b2QuOaNXRByavDpHcqpoJN3Yhpudee+U8o2?=
 =?iso-8859-1?Q?CyyC1UwCm+9tdWvfTsXK8giftu/cCxP5FU3di936ASMrdJHjuPBADRLLe7?=
 =?iso-8859-1?Q?TnVjKk2hx4Cyud3F1jGosYyDcTEv2Wd6nx9s0dJP0tRl9K1WCtNGzLDIiQ?=
 =?iso-8859-1?Q?UPXKhYjJirzRYTButwXYesKK3fevPg+GbsVMT+uabKU5b3DBgGtqgM6hVH?=
 =?iso-8859-1?Q?f3/P//5RI+AQAAzEeBoe4udF9kgZrag50xzqRTOdbXjckatIP2ML3Zlqvr?=
 =?iso-8859-1?Q?NPMKaW7Kkn2L13z5rVqo7Q0qqE0NJPtAVoDPAORZU4MJ511K4gfIye7PfI?=
 =?iso-8859-1?Q?Y/VHCpD+dk2YRXJ4ggqdSj11uXWEJ23LjwaL+FHsCGgtN3lHz+MkdM7CBr?=
 =?iso-8859-1?Q?hJGUFCeDp6+boUpKmAW2aJx6ci92IUprZxh4JrsDRMzN/ragSeTEARJu+T?=
 =?iso-8859-1?Q?JzHPHRp5O6UDHuEQfjOI/Bj08/qRqRTOjh5eEhFBJ7IEDC/rq7f2ov4Cof?=
 =?iso-8859-1?Q?2EmNlAztxF99AHu+tDcwzl8TS4MqnimL6eiieyADQ/LRPvxsoWIPgvjqIz?=
 =?iso-8859-1?Q?vNIs6lhyDmIhYg4ce2zpWvUj4JQQVKMuH4ufHkKu/4DEosEqG/grJIx4CB?=
 =?iso-8859-1?Q?RIzi5vlEcs3j3Pzjk6JPvcJNVDWSQ/7YOqlZo7F3pZqRGbeAIhACgiGJag?=
 =?iso-8859-1?Q?R1bLIwumbIlDcBZmPktgl7Ypqq4vwwvmgn/Z7pggR4EjLnoJDnt+Jm9OGa?=
 =?iso-8859-1?Q?5GWdXAJko6YdZ1wY4BvELZJJxuJF1ncMiYC4sr7OD1qdlIZqULMPjpA4Cw?=
 =?iso-8859-1?Q?lYHTkyXKfvxZA3UKsMYw6YB1rDkVDmTSDjuXRAY+0S1PPNpgFT2hHbfXbq?=
 =?iso-8859-1?Q?41hwI+bcaL2+uzfn5vPdFpk0NKXVQ5hgSWe/pHb8hfbCkkz5i9wjb7CGoQ?=
 =?iso-8859-1?Q?8jsonPehZQzLKe6UvyEleCS0/NlqvH4QbMiSFfR1rCg7s/q3weE+Nd4Hmx?=
 =?iso-8859-1?Q?mlWiBmA6JsjMvQEe/u15hreI68BOB3nYNSK90FRwaztBQ7YFt7gTq7cSEJ?=
 =?iso-8859-1?Q?5/zUEWul0TDqcI4LZfroGKjztZ9o8N8nMgpjavhkwA9MEBY3pK9GoW+EJy?=
 =?iso-8859-1?Q?gD8Ee5jKU2jdSwdyU4rbhMMGkcaPpRh0O861Zi/oxw6KUSGb7SfxC8Hd+b?=
 =?iso-8859-1?Q?IbAxDc6IfrS2kb9SqJhljpGaTSZ2Ww7K20kM7ZoQ6s35F2Q5wNuBArwj0j?=
 =?iso-8859-1?Q?Df+43lyk4HpvroB/77OdlRqr0SvjiOTnSYxIsRJ7faLto0gRuPUI3jfi9u?=
 =?iso-8859-1?Q?CGU7DpI8ib0GXY5ergpNQ5BI110rnPeCod87HzpFg1e/4p/+JlIxRFutUf?=
 =?iso-8859-1?Q?roudeO0SNTNc5uxDYHAVpjVCMf1NKhlw6Dm2UGVWeuEovY1KyH0UNLKiaw?=
 =?iso-8859-1?Q?RwbYljBxXgOP2fYpA29QyuIak/XHXzjN8eYQ+vwx3L1UNEdhPT6604dA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082236be-0cfa-4d70-3354-08dbe9e32aa2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:10:08.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhg6ftKptbYLI9OM0Jsyqb0FsRXOJ2z4VvwsHXMvsAMgWm4mxxl6gvx1wKiuXb3VIDtYyodLVgMxRIi79gsG8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9867
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 03:53:44PM +0100, Köry Maincent wrote:
> I did thought about it but I got stuck by the case of hardware timestamping
> without PHC. Richard explained the reason of its existence here:
> https://lore.kernel.org/netdev/ZS3MKWlnPqTe8gkq@hoboy.vegasvil.org/#t
> 
> Maybe I got a bit stuck in my implementation and should investigate more your
> proposition and how to deal with this case. Do you have an idea on how to
> solve it?

I would take what Richard said with a grain of salt, and interpret as
"there exists hardware with hwts but w/o PHC, and that may work for
marginal use cases", not that "we should design having that as a
first-class citizen in mind".

If there is any need for me to point out that such kind of driver isn't
a first class citizen, then here's an experiment:

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index e993ed04ab57..5755f54197b9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -842,13 +842,7 @@ static int enetc_get_ts_info(struct net_device *ndev,
 {
 	int *phc_idx;
 	
-	phc_idx = symbol_get(enetc_phc_index);
-	if (phc_idx) {
-		info->phc_index = *phc_idx;
-		symbol_put(enetc_phc_index);
-	} else {
-		info->phc_index = -1;
-	}
+	info->phc_index = -1;
 
 #ifdef CONFIG_FSL_ENETC_PTP_CLOCK
 	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |

When elected as master, it kinda works, and does synchronize with a
slave, even if ptp4l gets confused about the phc_index being -1.

But when elected as a slave by the BMCA, ptp4l gets confused and thinks
that phc_index == -1 means that it's supposed to use software timestamping.

$ ptp4l -i eno0 -2 -P -m -s
ptp4l[1185.594]: port 1: INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[1185.598]: port 0: INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[1186.887]: port 1: new foreign master 00049f.fffe.05f628-1
ptp4l[1190.889]: selected best master clock 00049f.fffe.05f628
ptp4l[1190.890]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
ptp4l[1191.891]: master offset 37000003850 s0 freq +100000000 path delay       823
ptp4l[1192.896]: master offset 3[ 1235.693485] systemd-journald[125]: Time jumped backwards, rotating.
7000003848 s1 freq +99999998 path delay       822
ptp4l[1193.603]: clockcheck: clock jumped forward or running faster than expected!
ptp4l[1193.892]: clockcheck: clock jumped forward or running faster than expected!
ptp4l[1193.893]: master offset 37000003852 s0 freq +99999998 path delay       822
ptp4l[1194.342]: clockcheck: clock jumped forward or running faster than expected!
ptp4l[1194.604]: clockcheck: clock jumped forward or running faster than expected!

So, I guess the only thing we need to do to this kind of setup is not do
too much harm to it.

We break nothing if we make the phc_index the central aspect of hwts
layer selection - except for the fact that such a MAC won't be able to
change its timestamping layer to be a PHY.

If we wanted to add such a capability to that MAC driver, the obvious
way to solve the lack of a PHC is to create a PHC that returns
-EOPNOTSUPP for all of its ptp_clock_info operations (gettime, settime
etc). It may possibly be that, in the worst case, ptp4l needs to probe
for each syscall on the NIC's PHC being operational before deciding what
can be done with it. But that's already an improvement over the current
handling to make it more graceful, it's not to keep things on par.

> > Hmm, can you please explain what is the reason why software timestamping
> > can't coexist with PHY timestamping? It is a genuine question to which I
> > don't have an answer - I haven't used PHY timestamping. It must be
> > something specific to that, since I do know that MAC + software
> > timestamping work simultaneously just fine.
> 
> The software timestamp is managed through the MAC driver calling
> skb_tx_timestamp() function. The PHY driver does not call it, that's why there
> is no software timestamping in PHY driver capabilities. Also the PHY driver
> doesn't know if the MAC driver support it so it currently can not coexist with
> PHY timestamping.

I don't understand. Documentation/networking/timestamping.rst says that
skb_tx_timestamp() is one of the actual _mechanisms_ through which phylib
timestamping works. It's called by the parent MAC driver, and
mii_ts->txtstamp() hooks onto that. So in some situations, the PHY
timestamping core _piggybacks_ on top of software timestamping support
in the MAC.

Where I agree is that the PHY driver has no business in deciding whether
the interface should report the socket option flags for software timestamping
or not. But I still don't see a proof that they can't coexist. What you need
to explain is what makes said software timestamping unusable in the
presence of PHY timestamping - to justify this separate software
timestamping layer in your UAPI proposal.
