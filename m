Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462E77576CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjGRIjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjGRIjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:39:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0073135;
        Tue, 18 Jul 2023 01:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlvxBvmfdRysOZw6+fL/jLvlrih7SaKqM3qWK6EMqtpojwhravQXmbk0kA2dAy2+FjP8eydXY2P1x6aEiWYERRzw2KpmMXUD0tERg1nGUYMWNlv94rK0CHBSN50V2nBeDG4v9kCmTCNSiaFgxawxkvO+JsR/ieHQxZIxSy8LDSYPGanPxgFPjdIMi9Ks4CgQ1T8UKQtBp1+TLt7rUGiK5RJrJaTsXjSP5P3cAYeks1OoW2XFMqljkLoq/PKbhb4YWDyk5vdxdZMRlYMPQozYjhjzssERA4GSOVMWiEkFjKrwIgWWWEcxisopSk3Pn2SS23Dyr6AAod6DCLN3ehna3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vCi1kiGWOSyI4U9bD9u1AOwLmrfFuzm5ju0HYk5XYQ=;
 b=N25XSdTt0OjItpuaOGxJJeHpWHVdX5RwpEvXKlYwcaZDZhv1z9/K1ePiJbAuvByT6qwGjcjK9YJ6NS78LpsMehVynlLF2NVoiP2BkpLLqf6YOWBfmeEJ70CL2LPo/IFjEAYlenQYQp53fXmzyeJEXgd/hUQSk91kBzTXT5F9oYLreCCNlhPhLh7B5hFz02pj0V+iYVVaZZOGd7Vk0ts/eTxoolGYFaWzThX5Ik/x0Ztb5YfHuYwjDfTzWv5YJsSvdsITrOeQq/QWLd7PcwsNi2kNGUgDwal8L7ip7voyXJN2EkxbtOsv3KqJUsgKe9zD6b99Coy+Xn9h7ScoXRs6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vCi1kiGWOSyI4U9bD9u1AOwLmrfFuzm5ju0HYk5XYQ=;
 b=XoiCEld8Y/uhdMel/uLPVyQerQFaUNsEKp3MJ25Ery/qzq8qb4zEaHmMCLnmr03s+hZru9YXHbismT5lnnrE6sEVE8OgTj0NYGR8ebTGloowkL47QDLvzHWo9OpDUfX8SbBvsNJqsRJgvXEgkqvYObCK1nj0D/8Ti5FIul1Dqo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 08:39:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 08:39:35 +0000
Date:   Tue, 18 Jul 2023 11:39:30 +0300
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
Subject: Re: [PATCH v8 net-next 00/12] Introduce ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20230718083930.t5amtcbeypd4t4v3@skbuf>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717152709.574773-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VI1PR07CA0247.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: a02382b3-1c37-4f64-3f96-08db876a8386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: caXI4vOYIcTWBvnJNTVVi6jmtiUazpwwDfNZVN/wOTwpNtXjDa4vevO+gqUXDk+e399Oiuyr6Dln1ztag+6yoBnwOE+mXzQ+a0/MZM6NeJxrCqlM1FiKw7KYtnz+F5fYnvJdpv0fLDzzT0lGmV5TL20GgwlebJt9nzyjnhIVF9FnOSql8QkxNHhHxvT6DdlB+McQU/7WiHmtQ4XyHYy30Ts/1+V80pXHV5ZSFU88SlwAQyfWW4UeNSaridTdrPP0ze/JEv+/losowc1ct50PbYSsMQvvvkGoQcM+tUwzBFXkfwlzYkfcty3fQ+VYL6HJnvSJ1TUvm+KYeuh0QebkCAUMqjIwmB9AE246IS+hl61pr69ou23DLvqNhECTqn88dpc6Ohpn7ATm4vdrsI5he+hi2yqURb6KX6zHX7FVzvYqg1yJzUC1yVL7ODzocSZmagZLCy6h8AbibGXK58EGKetUr2ff1dOHO2sc88fAnfi0optdzdC9yWy4/T7UzKjlT4/gn0eRcG6akmZubxBf95cEuLhquu3e2WWtfCAAmK+yNwcFheBSaMILR8dpmpGKOjtRubfGJNkD18CiadsKOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(7406005)(44832011)(478600001)(5660300002)(66556008)(66946007)(66476007)(54906003)(4326008)(7416002)(316002)(6916009)(8936002)(2906002)(8676002)(41300700001)(6666004)(6512007)(966005)(1076003)(26005)(9686003)(6486002)(6506007)(38100700002)(186003)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SITq0AU1ErJORWgkFggJ74CX6NEn27iy3heq3dpyAvFZwqWKxcypFef5f4?=
 =?iso-8859-1?Q?/TMPIsAFBZ3XlDjvIxENfJGFTS0gbHxcCfat+7GTxlKzjwb5Cy+nmYQ9EE?=
 =?iso-8859-1?Q?203TV794tv4K5AAS3jYIggjyj4/dXGT/c6NB/JcmNag2oEKYgdJRkLAdtI?=
 =?iso-8859-1?Q?sdDOm8u5oQl9VAKm9IQrJOlaPXxSVISQY3C+dpcFUx73zALQALM868+bMJ?=
 =?iso-8859-1?Q?x1WSesR/m2oFh7nogX820ZDHOWM0CnAnp6uNLt69B/lbeWxI/K/Y1SHO7H?=
 =?iso-8859-1?Q?7Us/nkfXSWwJo7NChKLQ7Cu81Kb6Ohy6PLVL8jdEzeJqjw6IrXI0y42iul?=
 =?iso-8859-1?Q?AQIsyVLJkuq8b9zc5KZ+pT95o2PIKnmzdrAkdRt1ZzRX4oMdp5GPeP1kbv?=
 =?iso-8859-1?Q?yhp9ZHlGug08iZzyjI4I6X4t2KpKvr4RBdVWMDXjlyd3vZEPt4FhIDmJDD?=
 =?iso-8859-1?Q?ROC9kyApW+FTzR69WuYi3ZdQnI8mrHiRbHnrtS5tKPKStWTW64/7YwT2jU?=
 =?iso-8859-1?Q?tbDLflFXZMmtPQucimZNb6SVglfK5HKW0sRANozZacK0RZQTNxaZ6aeWsx?=
 =?iso-8859-1?Q?wPWQ2Z7WVD6Z/J59nC8hcmNmh2wxml1pyhN4AbnXvUqDHgVg00J5A1Zt7t?=
 =?iso-8859-1?Q?7PRGQkl/DsLlMfI33lYRLx94PJFC3v86rVbqXfQtQcaKasRFYBW7Xpt2MM?=
 =?iso-8859-1?Q?AcC5dyHaVZPQKps8nIfOq1jJMezGCt/6buTJCX19gWDZpCb+F+43qz7zpN?=
 =?iso-8859-1?Q?PhH3O7+dwQq+28gRfak1viYfVElG590e4eAG5/un25gTPIkmVjrx/U/LpT?=
 =?iso-8859-1?Q?x0Fma4BACPCqoPQFTdmamAs5cCzg3uG0SpktWi+dFhJXZ1v9DirsQSxcNO?=
 =?iso-8859-1?Q?vlkpUGQBTURF5lPeZsCPZ/b1OTEe/m+IahtlKTnhV3rfmMpbJ5d2WWX2sr?=
 =?iso-8859-1?Q?K1BQqhEVBuoUHM2emsIhZhsAZgzcEb5EhICPci/Ozp7bSfKH8M7yCXo28R?=
 =?iso-8859-1?Q?pFSVlRDTNJoJEq1bhGWH1etQp1AYacTT3ao2eXMC+hjwOJqXUW+h1O4A8s?=
 =?iso-8859-1?Q?8/IwSC7B4UOp9bcn04k8VVx465AP3jube4Mz0zvGnZmNdzTPhxZs2KY/c0?=
 =?iso-8859-1?Q?ZtUiNgSm3J2Kek1C3oAdS87Swiko7WVGFTDqwoc9xRiCMOFxx2zVkTp2hT?=
 =?iso-8859-1?Q?OPhIht/PuBTGvRHU/hCJcYJrDu+JJ0IRfnmt/pZRtkF83JZ7N+jms2oziL?=
 =?iso-8859-1?Q?H13os4QDZZ+35GvLCE44F+YxFAMB5f5CQqYAex7h+ljGa42pICN1RDEvfv?=
 =?iso-8859-1?Q?ZZykCZHXdn7N8Qv9dhSW7Sap1ifFmMoYx63p4oD4x5N1R/QvN+5gNHkGWF?=
 =?iso-8859-1?Q?K3SOevrV0PLN18WJryCWGhHumEWPkHVW+sZLL4COfRP21raz7WFvpDhfhl?=
 =?iso-8859-1?Q?GT2TbBoQIWUjCAOaiTl6uu6qzOJHRefhsz6i2oCwC5U8FwrXewGxTZZ8jL?=
 =?iso-8859-1?Q?eX/SdCi2I1Nd0A9MyIPWJcJ1Ok3y9hzNwaS1GcTzLVHdebvRVKCllzqNLr?=
 =?iso-8859-1?Q?CUntf21QKOhcQhMJT4ONTkkP3bu1LipPu3u7xzO1Zx3rcSZTy0QiTo5XO9?=
 =?iso-8859-1?Q?oMNtCGKlgrFHIDoX+BjlT7gpX5ohka+CsgQHZKddmih+VYC0EOhbizFQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02382b3-1c37-4f64-3f96-08db876a8386
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 08:39:34.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5q4ZQ7wEhRKSRD71PsVwpMdDuwWePleZ0r+1Vx5wBkBkjqCQNPovfVRAG9DwLwy9hSP6NBqhaL7QiRYQJ22MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:26:57PM +0300, Vladimir Oltean wrote:
> Based on previous RFCs from Maxim Georgiev:
> https://lore.kernel.org/netdev/20230502043150.17097-1-glipus@gmail.com/
> 
> this series attempts to introduce new API for the hardware timestamping
> control path (SIOCGHWTSTAMP and SIOCSHWTSTAMP handling).
> 
> I don't have any board with phylib hardware timestamping, so I would
> appreciate testing (especially on lan966x, the most intricate
> conversion). I was, however, able to test netdev level timestamping,
> because I also have some more unsubmitted conversions in progress:
> 
> https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v7
> 
> I hope that the concerns expressed in the comments of previous series
> were addressed, and that Köry Maincent's series:
> https://lore.kernel.org/netdev/20230406173308.401924-1-kory.maincent@bootlin.com/
> can make progress in parallel with the conversion of the rest of drivers.

I'll be waiting until the end of today for more feedback, then I'll
resend this with all the pieces actually added to the commit (and with
include/linux/phylib_stubs.h part of the ETHERNET PHY LIBRARY entry in
MAINTAINERS).

pw-bot: cr
