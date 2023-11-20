Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D917F10D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjKTKxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjKTKxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:53:10 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCBED3;
        Mon, 20 Nov 2023 02:53:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaT99hXXw5OHTvcIOOsysdSIb56LSEtyiA7XRx5/pZ8mTgtx4zPxTPkXXHyiI0idbUhwn+uEcnfkR0dvjJNEENQLxPMFUQ+sUnUU/Sys62CMANhVQpNSVkVQOzUwKTjejnxmB7W4hR5ggoDAKCXbnaR3QwETTVP4ppypWuPJKI1hCpqT+4eJQ92JXQThkrEyGHHWOqFvGrJC+wZUT8cVScCXOn0Ac9YhM1Xa8mZqIHYsWU1+e2rwDHiMN4hTS2SrelWT4yBxqyl2FzJy2zty2aZvhcwWqhi72Y7es1hsM1gdOcu+ntCQlcwuFBoAPwvyUU3kJHclCpcU9QMt5fL81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/KMO+YbVb6aZw+7WhJ6g9z1KANItOi1ENBgcB0Gi6A=;
 b=fO9IyX9a1SS22fBHaD4GZ1MyU2ND7TjWlmDRcaWma0OsfbL+xQ9Ro/jb+CMfb9Zz1YsgR5yQXXJpa44nFAnLoXRIozqdnbxzyo6yC4OUSoIgHW59yWq3GSvuySjNndheDtSvzje2gRVGH7/DnSr+NBK70iIpy05WmF/FGnpgZjZ5tftXd0HjTjfkQt/HwOVnKAN8jNDdzk/mycyu3ujnVX7rU6lGAOW8eYnVrFOQ1c/DLaUNhiPjD42PtU/M9fflwSvNZHnzs6I3uVXE5oSMKDVmAqXSFDsxhc+A3vCuKp3NfSXkyBI9HfrOR2ANfKl6lwTm0vvUW3dRkyRije8rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/KMO+YbVb6aZw+7WhJ6g9z1KANItOi1ENBgcB0Gi6A=;
 b=WuxfxTdJC0cEUmEBleNLYe6owUjIIU6rtF/C4AlRwB6F8KqlI1sFko+sZ4HLnN70vJ+V7SI40ZzHeImk3hnV+SJAqIIW2TlhyFVjW6xUBj5ohJelpF5vzQPlN+CQJvkSDCEkotl/p1JxwVDhWsGXaz6qGTXAGZT827fpWftYn38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Mon, 20 Nov
 2023 10:53:01 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 10:53:01 +0000
Date:   Mon, 20 Nov 2023 12:52:55 +0200
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
Message-ID: <20231120105255.cgbart5amkg4efaz@skbuf>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
 <20231114-feature_ptp_netnext-v7-15-472e77951e40@bootlin.com>
 <20231118183433.30ca1d1a@kernel.org>
 <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120104439.15bfdd09@kmaincent-XPS-13-7390>
X-ClientProxiedBy: AM6P194CA0070.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::47) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 3758b8cc-08bc-4d58-124b-08dbe9b6dd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV8yvzmsWzoClV20VlfvEnzlM1Vc9Ne617pzJoE6DltpTkxIgF/P4o97D2LXifPBfNXjRHyZvuFcEPwFKUMyJkujWP5ZfsZcoSTu/grRGZCfoq3gD+tt4p8OhNDkxRZalYcicDdI7cEmmrNCr7j2wzPrPpRtH6VUYaPaPnXLhcblWXa2wwF4/qM4BYXrNvWTLnVFdmIwJH4VnBuqQ2Aue394Ydyu+a8aHSbpEQ9H43RJj6eRfn4OZllrhzRb1VornHqD9irz+bwXkj6Rjaj3ui7i/sQrPUiF0Y7uQMbqHdxwoIh/AZxUO6oFskwLpDXe4i0WFCPWTSZ2SoPKXm3AUBnupUL/gZKmZpnL2oWS/u4IZ2EtyKzm5XcKx7bFPm1Foi5TipRLEfbf05qPHHP+IL09RnBd4p1Z2CMlob5fG3zZcCNaOygcNenSXPLqKdyEF5o0vyLzfDb2AE/vv1RNWpoa5FpmVG847DdTWAkHDsbVrKEFRfSIkzX66TfzEEvlRxUCPaphUbEkt2gFwunw0l/h4qHYBC3z19t2vu+2UJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66574015)(478600001)(6506007)(26005)(966005)(6486002)(6512007)(9686003)(33716001)(6666004)(38100700002)(316002)(66476007)(66556008)(6916009)(66946007)(54906003)(1076003)(8936002)(4326008)(8676002)(44832011)(7416002)(2906002)(5660300002)(41300700001)(86362001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?l+h7SPV5/XWn5N5xEnk4KVS19Y9Viwpg9RbuegzDlRIdR929E95GChpOfT?=
 =?iso-8859-1?Q?rCqHrK0y/4+rl+ya558Rua2FBCAwCeDNVYrrofp0liw/zxVNiXU9ZpbBBB?=
 =?iso-8859-1?Q?Q1K5YUlN1HSLYdpbxk8IDfZJabzjPpMuuvqjXQ1DvdqYb261vmPgTG8W8Q?=
 =?iso-8859-1?Q?iSfxj0PUDliPVG+hQaRvEDvRMoq5vKHRCOxCg/q9Gyuh5USbSDaoLEVy54?=
 =?iso-8859-1?Q?bkr/CP6Y2mJ3q4jZubauC2nDGVqZ0oGVMlvkiY34j4uor80wqUFBJO6Qfe?=
 =?iso-8859-1?Q?gdrpGLo/Na2S2TocwU6Ybc/PIpGnb+Dm6KVsUx1fVZpryfEYBxABrI86gj?=
 =?iso-8859-1?Q?2UWC5SWTX9WaCOm1gGB7eq0IMoMuyFgrbC9VqfGj2FKH2PqRIpdQLOWiWQ?=
 =?iso-8859-1?Q?wNjjK8tUqD2gwEYuPYa8mmbZyIDC3hnYYCUqNprSfgRb5y9QAuy7/d/vIT?=
 =?iso-8859-1?Q?48pIJiCNzvgs0zfpJMrEYUVNmb+aBw6IWQoNK+RopXQJNw72ShAoO0ZIEG?=
 =?iso-8859-1?Q?cIxO3ti9+znmZho7s/9ZPtduTa8Zjn+ykFz1EWkXJVymyyy3hfV1tV0RI0?=
 =?iso-8859-1?Q?MAYDetrxFDmasA+GH4dBlUrMg4yKVr095hRn6EFLqcpyHYIqpWtYmIfrRJ?=
 =?iso-8859-1?Q?cR0lS5sHpbcobQA0a1vO6FS4AmVJ6/HpUlHl6gKg8h077JshRJvzfX11D/?=
 =?iso-8859-1?Q?92i9LOT58+j/ZMDmuNYlk6anLC92ShEipTLFJ+u+KJqUCxhwvZJv514Ki0?=
 =?iso-8859-1?Q?So+tw8pw1P4MZCCu3qYIITQKjdlupQM4mH+W55mgJrKaJkpc13L4LGYykW?=
 =?iso-8859-1?Q?fOtYOPIG9CywFa4SJZNgG695I94hOEGfKVTOTo0Hrk4Bd9+JM2/CahhDq5?=
 =?iso-8859-1?Q?De6ghXBIv/Ha9Hgk5PuzZZ5mpf8rHSYYpQykWWzFRCaE7EZEQlZ7xiEbE3?=
 =?iso-8859-1?Q?GTLglnBXFaCRJFv+nCvBh7xCJpGVFUHdKc2ovpvMKkrE4QZZ2D549X5hHA?=
 =?iso-8859-1?Q?p70HUjzRVbR0wesbLlhBP53DrfXSZSebmN5nqSqJ4Zzrd7nMAdtwSPfGXf?=
 =?iso-8859-1?Q?71jDpbd7aPzk2Rw6eMqFRVOESnBKlCsVpzSu8V2Q5oFbOWXVwCm2yaxsPI?=
 =?iso-8859-1?Q?RA2/15OrvqPSEIo8qUm2IPFehRmJU3GHM1O4nisq7u4b0jWZkR1W5wZk22?=
 =?iso-8859-1?Q?mqLxvRb32bZ9LNDub9WGg9nRBbRcLHpqZwA5WpXgd5fqgxLPjHPbjDu0pE?=
 =?iso-8859-1?Q?b3M2GC9zwsaJ2B/B0EWdklh8CFFbvagM6NR8LSfJ1yFQiJrKufKCNyp5I0?=
 =?iso-8859-1?Q?8njHCVs4bmDHfOHu8lGbfwwMd8r5KdT2HugvLL3hCB7qgBOLrWxfr0K+SC?=
 =?iso-8859-1?Q?qScNAsyMDWHEFs0f5QafMf12VycXdDvSVXx4iTNXevD4pwAJrF6vztVMHe?=
 =?iso-8859-1?Q?wk+AY8ZnfYEe8PkAuhuJFpYHzEX6Ra+GBm7w7w1GdXbCdZ8MeA7J38aJC/?=
 =?iso-8859-1?Q?JyOCTCPLoXvgl3/8oQVRdOYw5aQJle+bsxTnPAZ5yCP94p5huJtG8iSmaz?=
 =?iso-8859-1?Q?wx+dqeDKCoQ3qNz2Q7bxX3HLCvRdMSuS8+JlRj1lrqsIXmQDO1EILBpJ8V?=
 =?iso-8859-1?Q?137082akMUjh+spg96fs+lKti8FgELMw4pXaY4pxeeCw4ZpoGEwDT9GA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3758b8cc-08bc-4d58-124b-08dbe9b6dd2c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 10:53:00.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ME+/HgL1+P++uIZG1fY5TpBvC+H9mNiL6jejay5IP4gqLvOfDsDM+S4WwwG3jg/Pj++vvkhlhrqdu2ZD73y0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9122
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Köry,

On Mon, Nov 20, 2023 at 10:44:39AM +0100, Köry Maincent wrote:
> On Sat, 18 Nov 2023 18:34:33 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Tue, 14 Nov 2023 12:28:43 +0100 Kory Maincent wrote:
> > > +	if (!tb[ETHTOOL_A_TS_LAYER])
> > > +		return 0;  
> > 
> > GENL_REQ_ATTR_CHECK(), not sure why anyone would issue this command
> > without any useful attr.
> > 
> > > +	/* Disable time stamping in the current layer. */
> > > +	if (netif_device_present(dev) &&
> > > +	    (dev->ts_layer == PHY_TIMESTAMPING ||
> > > +	    dev->ts_layer == MAC_TIMESTAMPING)) {
> > > +		ret = dev_set_hwtstamp_phylib(dev, &config, info->extack);
> > > +		if (ret < 0)
> > > +			return ret;  
> > 
> > So you only support PHYLIB?
> > 
> > The semantics need to be better documented :(
> 
> Yes as we don't really know how each MAC deal with the timestamping
> before ndo_hwstamp_get/set. Using phylib only allows us to be sure these NDO are
> implemented and the management of timestamping is coherent in the MAC. Also It
> will push people to move on to these NDOs.
> 
> Ok I will add documentation.
> 
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com/

When Jakub says "the semantics need to be better documented", I'm also
thinking of a different direction.

From what I understand, Maxime is working on representing multiple
phylib PHYs in the UAPI:
https://patchwork.kernel.org/project/netdevbpf/cover/20231117162323.626979-1-maxime.chevallier@bootlin.com/

Does your UAPI proposal make it possible in any way to select
timestamping in phylib PHY A rather than PHY B? Or do you think it is
extensible to support that, somehow?
