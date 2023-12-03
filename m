Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2803A802513
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjLCPQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:16:53 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246FEA;
        Sun,  3 Dec 2023 07:16:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqOZj5zLU5RZQ3QTEmk6fE8fggt13nETjJXNio7J1o6gw9lt2Owm3nscmderD7dIUkFaTx/nr9ozhTbXRsS6HDlrRxgnVsfO0HG8Vh2fj3i85jT3QjU6nsB1ZqaluoFrlwyxC7xjuK5l/809olCzZtcl+35xtq5DUKQA1s1KcC5TzTKBQQVn9K0rL7Y5y6S739x/zx+SqbLQ6CLZ0jZ2nTPt0Nt+Hc+C3za09eJdHeRCEQdqoeazVHRMQ+TlkToK0g7sd3dy4wnTX9x+MoqXnDbToq3OEbbgmuHL0UeEpKFyVDVqDAH/7+9bcY1oMjZwEZzXHSaVZo8+0zSLc6YPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwjJI+nBAlhWrRXnrktFziLODTDmTGU2XceMZNWR0X0=;
 b=MXMu790S5SxVclcjqY5cuOA87dr+y/b7GffeNHIx6M/K1hs8r+axh5AGCcQt5PjiK9CpAwHcofxdWR3R35TghpwW73gx0uDvYoymVDd8t1BXBgcsYSApcOiJ/hpmsMfV10SXSsAmw+qX0HMx6D8KD3BJ1N0zPgz5rnjS8rRUh3RqmNvgWwfiD1ggD/Y+C5kOI6uypMDVTEeMYlami7frqd4q7q1pv4gmKLzYMUh4q0cHG/nqvnhM979pg66MgJi6BqtcHwvNHeigqmLIudHBtdOb3IUqw7p98rgFZLQEU7HfIvrAQt4ji9yv119tobM8YNJkdhxeYShy5qRjYt3LxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwjJI+nBAlhWrRXnrktFziLODTDmTGU2XceMZNWR0X0=;
 b=axzSWLxTUd8MZkMk54Ppaop722ph3FE1SCXImPNOtVQpXo0VpxqrzK5QkjjEsGfWt15UcXsAmnWvNLjnBtKOjQ9CXcXXLatd1QK2vzo94ILW66m+gdDosH2eV5jpnpN+nTe+o0iLJsZeqqcM1Do8qIvK2BopKbPCmuWwHs4Anr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB9740.eurprd04.prod.outlook.com (2603:10a6:800:1d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Sun, 3 Dec
 2023 15:16:57 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Sun, 3 Dec 2023
 15:16:57 +0000
Date:   Sun, 3 Dec 2023 17:16:54 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Wasim Khan <wasim.khan@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <20231203151654.nh4ta7vtzwpwg4ss@skbuf>
References: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
 <20231129233827.GA444332@bhelgaas>
 <2023113014-preflight-roundish-d796@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023113014-preflight-roundish-d796@gregkh>
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c507262-cbd2-4522-140b-08dbf412e3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdP3eRTfLemsheKudVQypNrV8dK9oVX50XHjleXcmIa703bjdN9RSxw/ZpUy0zv3BR/X7TNwPn34IpCPir8DvpQ4nwdI/2elRHUZAJZdZeLYM3isYKq5jzHKlFsxJigLZQXnfOfCBTF38vpI0IYq2K/YG6WKH4VN0RbNiHUDMn6ihspQuIfcRGfjJGdyclp7lYrgxGeMy/aE9PwfeBwbM89nbq9vXIeYP3A9RFa2bSyI4vn1FVF4akkB0sF5UQsg2uj7HwesppiohMQ0HCu9G4pQuyvSVDvwfvOIg5usRaaDbezAQqYe+8zjYangtOHKjbnn7LPmwTbwE6m4SaeRAWtaI7vSjlQ+FihJi8AGxEggCmKCcHTPz//ALp6FDwszF5EaqtZe6JtzuzJ6AflnqbWfdT0Tky6i177ZT0ZZs04GoMfGcCHoa4xzl/1qUBmk+wdEKVK1rgaMSo3TTKVqmZaEs6Sc62ZOsDGmBPJlTKu7rEIl6gLNCXAC9Fe8jPSMjZsvqylWQDwUXTho6riMei2lyD5isHrbutYNa1+LbWW+u/4qs65atZ1H4FQkh0Sv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(39850400004)(376002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(86362001)(44832011)(8936002)(4326008)(9686003)(6506007)(6512007)(8676002)(38100700002)(26005)(6486002)(478600001)(6666004)(316002)(6916009)(66946007)(54906003)(66476007)(66556008)(4744005)(41300700001)(5660300002)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MsSOhFSf6ReH1UQ7lf91TB7Qz+CYXs9n6A32/aHji9D+lvbhcEVQPVTr2raG?=
 =?us-ascii?Q?sBV6H+O27Y6/gw447r0927w92RcNs02r4WvqRbaSyaVbg+SXnXvUxNO6T3Oc?=
 =?us-ascii?Q?+4R3KQrJsq/b3lb8Onei9ihKe+wwKh7uQFeCBNqDQ4yXvp9hvesOIJdjhqxI?=
 =?us-ascii?Q?T9lzxmSBiawiwoJnlGIDPSzOe67fkcCZdbfPDIpxRvFtE63UmygJMtIJm7dk?=
 =?us-ascii?Q?k+kVnEnr0gYf9SP/kTHfKecx0j7MEIhh3hXKzJP+rPcARylELtC+h9Fs7jg8?=
 =?us-ascii?Q?GQug94h6wXoeL7gjxc7L6gOBZ42Asr7SGelcg9jg1F/271BootlE4YJOtUzC?=
 =?us-ascii?Q?c20nuPPtKOPPvxxH4ZP9Wmmnw8MebZ6qZ6hxW1vOeqETOJxVt8sGW/Khq0Co?=
 =?us-ascii?Q?QyKQjFeQ2G1YmpZcFkqMNA2cKCXZWZRNCvD4dHNKxOpXqXHrHRzcB5foAJq1?=
 =?us-ascii?Q?ekt5mNbequU7BQpNMvl0A0V+URzqmgJx+AAXkGazpDMYZAmHbkMIlsg36f+N?=
 =?us-ascii?Q?9fN3wqiYM6yxn66K1+1uenih89mS9Fzvikf0XKNm2gdmj4APEF160V+V4bKO?=
 =?us-ascii?Q?Lc+l2m8sefbI/JvC+D04yUTTAn3cAK2pZH0Iw35dsvMHovflFOKa11X4YI0T?=
 =?us-ascii?Q?BN6fyc7E9BEkMSmXpKZm2o/C+Bqo0dOw6pHvMoH0GTetUzn6vfuaL4o63fXf?=
 =?us-ascii?Q?B4MO7pfqct0iLbpbwx/aYbQrY0JHNDEZiX1sHOQkYZG3thyck/n5/7l3f7jZ?=
 =?us-ascii?Q?G7HOG7DJtbSr9E2pY5Rlnfbn+7rvMqdSqMfUQ+qcIDyFCDAtRep3inUt9pRn?=
 =?us-ascii?Q?fdhcR+lx6mqi50aIRiBpeeiGiLs/MmI7fvqB5P9fDrg3/kWJfrbBbu6QiQmj?=
 =?us-ascii?Q?atnUOBFKdtQjKSpPOf9LHkwIo+vZybWJNs8efqcyOV0IG5CpioCSQSCHzr82?=
 =?us-ascii?Q?2zp/y/zhGhUZ6tHZplztE8ltD7mFiYyJoHfbAm7Dy1g7DjHbziCRCvrIfydS?=
 =?us-ascii?Q?35ychACr3P+vF7EYU0nXqyrem9N2RJmU3l7gf1xQOrrRKqPR/j9eMxQZ8Npb?=
 =?us-ascii?Q?4wozSk/TyZ75rgr3KHSMU2jE/IKvtzpgwJyVBRY0RliVoQ19ysgHFxbuvh6u?=
 =?us-ascii?Q?DiWYc2gsz6/1iG8IUv9uoaIEr8NQjRK3QRVKpiYOuWcfvJ5dORC+3u40KT8d?=
 =?us-ascii?Q?NLI46klCBcJjlPMmZjjtCl3kplg5/TMbMHjPcZKj7YDJzyazkK9dhoj/xZz6?=
 =?us-ascii?Q?8O5km6bMN5vZ+BcsTBCnH3Vov/Bt3a3Xoyk6KQXIQwlJmooEVUdMuWjlbDPu?=
 =?us-ascii?Q?CZoQj2f+uIhdoAEkfj05HogwrS34bJjSPFrbykk9UziHA77eunQl/smW4l4V?=
 =?us-ascii?Q?lh/jdOed1rPw2c4DJViKGBha3URML0xVujnaZmnzrR1sLBhUeQkdMieEBsqp?=
 =?us-ascii?Q?V3QKwuI/9b/CC0IY62prAKp6USn32mFTmJeYln/0iKrHB6U3b4si9cYjtrxA?=
 =?us-ascii?Q?yBB4p3ZuKP7ayFegnzsx9UDm+R7ctO5YkxobWmFxwla5mnhCkjcwaoNcMVXN?=
 =?us-ascii?Q?eO+weocPxFkPHxmnhQeAjirXpbI90oktJNb+kvp7Gr2uieEZoKTwkyOXOSvx?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c507262-cbd2-4522-140b-08dbf412e3ac
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 15:16:57.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPlowDD7SGanlRj7ZsM0r7ze/SuHVckW1Vvm5fqAlPHAVBBRr+RGSy7RnW+7V2yg+Fpjhe+knwfXdgporHhAcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9740
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:10:19AM +0000, Greg Kroah-Hartman wrote:
> > Why would we remove name of the current company and use the name of a
> > company that doesn't exist any more?
> 
> Yes, this seems very odd.  What is the reason for any of this other than
> marketing?  Kernel code doesn't do marketing :)

I'm not sure who is doing the marketing; not me, that's for sure.
The patch that I'm proposing undoes these strange aliases.
