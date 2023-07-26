Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CEB763748
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjGZNPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGZNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:15:33 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2114.outbound.protection.outlook.com [40.107.96.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14E1FDA;
        Wed, 26 Jul 2023 06:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVht5HJyRueAE9+T/psphDLo40ZIAfpaq5R2owapvBw2Kw165jp7nlpBUti+lprrfGpUw8Qftn4KMqNFXhrsY1+6+rKjCymvjWCGhZ5Ulg9a9ZlBQmg+T5noUKXh/UfyHnTjV0gkvL0PytXS/6D1CpAyUXm3onPzQyIASHO8hsx3UZ0QKd08Q9KUrvYpsAbK/s0J2ljL+Zh90cG/Ex/ljRj9z3dBumPUlxOpoqWmEYkmr4dbynbUZaRK27cyJbSwd6XGBukJdJz/7kmOjqBcPcleAUZ3rrf9i471qpNZfaz5IgHIYE1MQPNK16/ZJqZhrjf+H+ATczBmj8HduGfVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDxjKCbZTEZKIagqXPc/xKULDjbAkbeKLsZvxAvI4No=;
 b=AocAHU7wrYcexTY0PJFEZK86cTQG0ti6Hu4bnHVrUepFRqFeiqokzq5VA5bfzkiJbuAWkbonW4xsT3wDh1MCAOjZoTXWg76WN9IOZqg19MkGhlZY7hjk8CJ6NCRHFfZHBodMUl4MZzcdRo3MiO3/xvQ1LN1qbc/V0ho1OMdnUj9Q2fMasAhEtakPlz6VgdVguCbPppLfPn8Fp4rCyMCBM6wjSQ27fHqbvIEXS49u1nId4Y2Q4c+FQhpwEHS+cyi7m9317/kAY5wEkfQVLufFMz2Sr/xbzNG8JZQ3a/xdI6M47nPH7qBrahDPEXXOWAotXtjQZmi1CS9IELHIWCdz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDxjKCbZTEZKIagqXPc/xKULDjbAkbeKLsZvxAvI4No=;
 b=PusgVTWsHjmar/walkBhsM2PjRzoAS4tNI0slMGhSpWSUiilnjQL/DaeUycMs3HRWYy3Z9EJjqXkjqtqCveuQ+d9eDUeh61K/CYzHTB1BIqj1vz5qABpbRAd8AEPDQqBwVsnJSHoOyJhEwox7A3/nCYBbQaAkcIeMPpfKbp3dUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB4085.namprd13.prod.outlook.com (2603:10b6:208:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 13:15:26 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 13:15:26 +0000
Date:   Wed, 26 Jul 2023 15:15:20 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 2/3] net: dsa: qca8k: make learning configurable
 and keep off if standalone
Message-ID: <ZMEcaKWzoAvtz+CK@corigine.com>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-2-ansuelsmth@gmail.com>
 <ZMDXFiSFI/hyr8j6@corigine.com>
 <20230726121435.stqwc3jzjll222ck@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726121435.stqwc3jzjll222ck@skbuf>
X-ClientProxiedBy: AM4PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:205:1::34) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 697b66d4-ecb6-4891-99cd-08db8dda6087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8f7iSyg1A0e/nzjUBTKgM7yJouM7gWqNhkIzl6nLwVDK79VZlrndc+LGWv70jnLaZdSef+RJezh+K/g8SD6TuTXKUxNBp+oNI2xljLoZA8lxgAJqFrjH8j1OxmeqGkhD6bfDgHIjiEKlxs76RhBeo0ywAqvJUYohbPnybqMQ23Spi4VWHFX09zbrEnyDoXsc47ezs9aPkQDrxgaQFG49apw4GTcCt8Dt8s4pAIOLRV9PInyWD3zBerhXQoL0xYERLw+TEAOu5ydm44yXUhgv/hUna+QkKgVCC3dTSH38Bon+ZqB5uMRJKbGHZ8aRH7mW7Kik9ZO4TVIW+Pzk9fnvKzkODK+W94tItRxy8a6xTaHo6alBgNzjhxmSUGUR6EIcetY2PmkA8GIRCdnQAD8MUMYkRBd4CamcPomKH7LPRMaZL8n8to2u3Fn/6gelYCtlMOOLCW+WnD9bcyyvcSWDrPzTvEcKfBtHceayhkc18I9ytSk6+JEe38T07XH4TSLLbES95sK9Le/sNiwsOOOfgMDAl9UVqmhCmp/h/my3QTbaEPzUMh46z65qPbzNhvwq1ap25vgxmJtInF3v7rdBvqjTyf1qGHdb8m4/IKtw2AS3y5zIkiaT4NbnjzD/GToA849CAuzupBlcsScVXafScL34pzMUkKB1BM+bm1S9TfQi3BP1sKklBEQMUuPq1fs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(376002)(396003)(366004)(136003)(451199021)(6916009)(6486002)(6666004)(66946007)(66556008)(66476007)(6512007)(44832011)(4326008)(54906003)(4744005)(38100700002)(36756003)(478600001)(2906002)(41300700001)(7416002)(2616005)(5660300002)(8676002)(8936002)(6506007)(316002)(186003)(86362001)(32563001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ez1hxRd6yiFeBrNvBd0FQacAj82T2d+oJwoE/gQZL99b9Qll1eN2zku62leq?=
 =?us-ascii?Q?cJ3DNVK7kTIQnC1/Y2JFEswlgNfXx/XWX+qNLiWRIQ2tiohmWqHD2IoXBMCE?=
 =?us-ascii?Q?N4u74nEwH/ndt7+RdI/CM8LASOSQ+gD6aW3fqVvp5MP2WrAF/pLzDKF5xAbA?=
 =?us-ascii?Q?ouG6TAVeFs/axbYTnE1ZVdSPgpxLd/N/VK/JNUOhAWYwiKinhB/yepmV+aJP?=
 =?us-ascii?Q?yaGLoTbj+4A2voelichMeOe4V+oZXOUxk7df1FQPdCk8gjeISWXEvScxjs5C?=
 =?us-ascii?Q?+oLxmTj/1egvVXfv/DuoT9TwaCIAQVn+vb4RG4NqQXWzYWF9WaLu8NYZUbut?=
 =?us-ascii?Q?mBKs946EbWwplGvHaxrC0bA6Q71gLweHKSo3Sedae/AxJUlratfeCWY7nYre?=
 =?us-ascii?Q?O8QRtObOcvWC2WC1m7C7VapQB1ZFIfG4ES9JEu7uIv/+RwLOvREjiHy9yetz?=
 =?us-ascii?Q?qF5pwaWRJLfefvjNuTPZYTIY6USOPSP9aAOfz39rI7Z6BhHYP/73mCXR187x?=
 =?us-ascii?Q?vbkpoFaTbCWo/GqxSb1IzkM/l/dydojW2A2ESiRplhrhwD2N/Sh+sSVGkDnj?=
 =?us-ascii?Q?S22DyeA0DwmBNk+lv3/pO5e3Xu8UWtLDr+FjSOQTY9GzOlCE5g+Z549sIb9r?=
 =?us-ascii?Q?qXVGnlK5NOEZtKHivvDDofTPJHPCMzl/jXBQz/+hde/FQ/AmJfoKwKlS/MP2?=
 =?us-ascii?Q?hNEcC6IWKnc356jsr2hsnP7D+HQd6+HV4gOzH496JTTv33jmQn1RoWxwdaT/?=
 =?us-ascii?Q?Ss1SBDgLF8UwwDBbXFilELZA6B3Jl+lin5xBYqpE4fQPQ6ABF7WDL4hL3ANa?=
 =?us-ascii?Q?jsfJ2JHH8UfW+jlhagwihflPDU1TycgvDMYBckGwPbfqdsNLaUa5bhnffuqB?=
 =?us-ascii?Q?duw9aNyTOOVWFCDs5L00UUL1HkDRJEBsAA6ZxhhXGXN8PvY4voNjORV5IYZr?=
 =?us-ascii?Q?acQUTgTIFsQxzHPQcCazJudMS37fYMZARQL/kEh3IQcNiqw1yWJ+IlyxxJ0Q?=
 =?us-ascii?Q?NVTwt11j3fS7Lwf2S4Q5+xdqEPlChXjEUjaPx/IAsP8JnRkfDOgyRDneGcDJ?=
 =?us-ascii?Q?krwd49D5alCfOT56O2dBlIjh0zoXlemzO6K1VHxoKNwE1XU2F3DfZ/Fw6HGb?=
 =?us-ascii?Q?ckMSGNrt521eTPIyWkQaAnbJiR0uaTJOUAV3yu6lzwdPb+czt2L5xqJx6AhM?=
 =?us-ascii?Q?r5+R34NTuBTqPCaO5OkJqGY0Gbx2S/q37Zc5gCvhgtE/k9Xq7PxCuG5OZ5Vy?=
 =?us-ascii?Q?iiEkcGP+NP+JTbJ0F5L986ViL68BnOEx+qlhlppDbozdWwjPGplj90qYqsz0?=
 =?us-ascii?Q?K5sLiArt6mDvSeshk4dqewI8HVCFQhYyu/55VVQW1m3iGNfSlT1x24rnaVIK?=
 =?us-ascii?Q?sQs89kIYkIiJ0/wxLtExVp5yM3lKnKz0v2hxSxRTI52ADWiTUpqG4D7WTKnv?=
 =?us-ascii?Q?ggjdTzOpLKvcCIfyen9eAEAgPzC8Wtkb8Gx+TxnkmRaF5rK33PtivhWXuOlL?=
 =?us-ascii?Q?FX3KhgSbRem1kDNvGzu+hg5Xi4j4nWN02+PKUOelpSgJhQ6J0mro7zfz871y?=
 =?us-ascii?Q?IPaisXgMpEa/KmcuA9Kq2y4wEzksaRM1DmzMKe7rORmgMTJxtJJquA5ce3Nj?=
 =?us-ascii?Q?Gx8XxRVjowsTIpT+thBiZC8jaQVf5xyAYF8ajD6RqjI+Z7DxLnqUEYBcovq9?=
 =?us-ascii?Q?dVDeaQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697b66d4-ecb6-4891-99cd-08db8dda6087
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:15:26.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4IVuJ2v/NhFjLmw1OKlepNHojA2NISqWgiDSeLhah2LKg4Pmzr1JZtrsEUsW93KEsMqG6vmJ3L+GprlIZHohBUZNx/Jk14LfIcSCJWDuZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 03:14:35PM +0300, Vladimir Oltean wrote:
> On Wed, Jul 26, 2023 at 10:19:34AM +0200, Simon Horman wrote:
> > > +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> > > +				struct switchdev_brport_flags flags,
> > > +				struct netlink_ext_ack *extack)
> > > +{
> > > +	if (flags.mask & ~BR_LEARNING)
> > > +		return -EINVAL;
> > 
> > If I am reading things right then some implementation of this callback
> > return -EINVAL when they see unexpected flags. And some seem not to
> > - possibly because all flags are expected.
> > 
> > So I'm slightly unsure if this is correct or not.
> 
> Which ones don't? All handlers of SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS
> should return -EINVAL for changes made to bridge port flags that aren't
> supported.

Sorry, on a second look I see that my statement above is incorrect.
I do wonder what it was I saw this morning. But this afternoon
I see that all users check flags and return -EINVAL as appropriate.
