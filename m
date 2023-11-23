Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E37F5B71
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjKWJl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjKWJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:40:46 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2071.outbound.protection.outlook.com [40.107.14.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00703D44;
        Thu, 23 Nov 2023 01:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbV/IpybHVkQx7uP6iBum4ds6m6dZUO4jAQFNgmLCeH+8LxIO1e4dvL0gl5wzsmzOkUz5JaXshG9nlzw6ljiMdT8Wg9+CFnmUlmZkxs56VQxk3AUtrxIiJUkno/oGI/F6LmySeb9FSFVLy4FI/uuYTOibHmi/54i+ZAUcNpXHLO2zadsLqSHazln+oRTl7ZrTEZchjUuorkHrNkp7+8Shg7Td6BeWeGS+NC8ECll3YuEiWXM+dLJCa79GoOCYYSGfY7OWfwi2cwjoDNezAmQ5EF/DdL/Woq39qRRFkB9OY5uhdKdKk0NG5k65e6plBFKjnUhewAmC4BSvl0ODg5soQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff6i0m2QRlxgMX1rmCLzL/YFPWW9eE1z35hM3+DU5bA=;
 b=ducL8j0Sur9U5+SV93Jiw/wTeuRpqdt2gifr8kCx+axRKDn88SzaW60/1yyBATbZS2xNNNAr2U1VHK4wDupTsJ6scI37BNsGJ5c4GacbL+x/2bP1CSH5H1hFkmXnfbqonsL2uIA0lV7/I0NWABCxN8P0UjlSMtXy9MgQsgZyIBmsVWBMHwDCy4EeEwCkCm3pt/44Zu47MMoLXw1evWPUYuCSz9V61Z1vbSNacbW3FfYSGzNOIen1CeHQriEtxHivs/PzVSnd2drv3lniuuVZGsCutuP4Wadr7M5Vx49/MOnuVLP3viuKRkrz5WPelRZtda311e4vPMFVmZumPGd91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff6i0m2QRlxgMX1rmCLzL/YFPWW9eE1z35hM3+DU5bA=;
 b=CSwvcJODvda9dHhMge57W5lEIZS5zww6YWBMd8Y3q6zBmK5rQGXkeFJPT4bJN3Q2YhafVJHVzNPcKDBomAi9jBY+wzzHA8qNGweb4404peZCZKdQtL9zDSZAltIp9n4qhXkQTiCJ9+UdGowZYjb1EaqV17zS3bnlvZp+tZkuWQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.12; Thu, 23 Nov
 2023 09:40:49 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 09:40:49 +0000
Date:   Thu, 23 Nov 2023 11:40:45 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: enetc: add ethtool::get_channels support
Message-ID: <20231123094045.bjgo4aqwdydeirgs@skbuf>
References: <20231122102540.3766699-1-wei.fang@nxp.com>
 <20231122110120.crs4rh2utjweswsc@skbuf>
 <AM5PR04MB3139E96BF99E55E563EF71B888B9A@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR04MB3139E96BF99E55E563EF71B888B9A@AM5PR04MB3139.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1P194CA0027.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c98aaa-528d-4575-0adb-08dbec08467a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNwMWcJnaYLikmfkBYxpLX6RGuEf3f/DczZVJynFfbR+aZfvSB4MMQ+AEdkf8AfptwbAHkTbhZHInQiACNGb/Yp2mPdFpn8NksEyxrJmtYDMA4ViakgafljuYFfTrbBHnaj/ZIOyzFHLpR0Jz1G8kEu1D1sSYSGnC4e4iLG4YDbomcId85SCJLYMTzBdXLnqlyFkgTNTIo0da/SD8LWocjBhBdo6IRDH5oQ6EG5KWk+HxHlCZ4BHNVEcdW2d80wS0uCClXcwyrBp1kq/1dL6qT1OnD+2RdFkpntcr2kLliTZ3/BffQSQZ+XLiILoclyaCcbBUvFKeAwKxXefO0RjfnWwJk/SI/L5iQ1xZooqXcKZS1Z0N0lTBy3Fq5Gt9cXNHdd94XCm5JSch+CSC485IM2CvhRSXb6qhV/UTP85UmJqrsSI+KPCRshQ+Wbi7GL/fl7DDPbdZOuhSstOn7Jty6FeDxBbQ2JZ+t76YljA6J4xKoKpDotI/7UBmlT/UcSVOsbUAsQujrNz86x9qT0syqoncOhkQAt6b5HZ1xr+Fjcls1E2QYNFPgQAuUH7Xn0o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(44832011)(2906002)(86362001)(6666004)(6862004)(5660300002)(4326008)(316002)(26005)(66556008)(66476007)(6636002)(54906003)(66946007)(6486002)(6506007)(478600001)(8676002)(6512007)(9686003)(1076003)(8936002)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6D1e0xo9A84rMQ+yXbQdfbJ+heNOSUUlerEp5/1rll2u1bMURkG/LqXUaoc5?=
 =?us-ascii?Q?LZwZEXRgKCc/XXftVuOj591isd476JWtHpXbHY6JiTCE+cefcW+geRFZeC5B?=
 =?us-ascii?Q?gkPuKsoyH23cUC2pb+w8tn9paM2TZBsSN/ere+IJoH/lQQEmA8N27YpwHJ9g?=
 =?us-ascii?Q?xq5XB7pnVS0D7w0F20OhhKLYu0PXdocq8ZJjPV1V9KjEPmHF7yE+kKRMvMYj?=
 =?us-ascii?Q?AeCIdUaDVaHYBLvCtgKWPP2nsFbx5Gzh4G4hMt9/s0HRRpv0xYgtWcLYCxX3?=
 =?us-ascii?Q?7DZzrKNs7YBQ5dwez1h/0UQm0qNl+aTeCfYgR9LdCPHnlgKI+fTWOWCbtC68?=
 =?us-ascii?Q?aABAcArY6qI0nMsUNd7vwjaiKBrhj0hVVwDrkocmYKsGm9VJZkcAMtTnNMAN?=
 =?us-ascii?Q?UOO3+9Qn/olmPCZvyexL5s9ObGXUica4rZdwi+GaOpkw7qrSj7U0Ou9+G8Kp?=
 =?us-ascii?Q?EUHpjANDlUO98n4bbfUdaLw7KQHNsOQNnx4YlC9/5JcLoB2VMla/wPK8/fxn?=
 =?us-ascii?Q?VjZuZXnqmW4ntGL0zPGzxH7KxGgvQl2mChkQL6pwc8qwt3uV3M+Ig6FCE5+k?=
 =?us-ascii?Q?m0kaB6ZBVP7GqgKAxfMQmiIbA++mxpgdzP/J7Xvc1xZsdbntwsoVf73Eevhj?=
 =?us-ascii?Q?ENJf4Go/CMpfq+Y0aj+XUGgeF+4QpXBXKyuV+7xM8jm5uGxqpHCNOBvfJvZ1?=
 =?us-ascii?Q?SfFQ71/mEbrEl163lLVn1GbtEw07tUOfVkhVOKqWjzX9O9y4tavNQIiTDW1b?=
 =?us-ascii?Q?bryTojPRhUkeUg3eez1Sa/0R8mKXEAx0jfp0kAbY7JW5inZ9NqdXax3hNIm4?=
 =?us-ascii?Q?YIMQplsTBavrWI1wSXsjNcb5zLncnPfpL/2yxrwQvGCgCYe4g2vs5V0cCIiR?=
 =?us-ascii?Q?Ht90N0weX5bUE20wvBrkMzov8b6crLf2+l3zE8uFXSTb03o45Py9l1yY3s08?=
 =?us-ascii?Q?mknr6S//BofW8hC+nXFhjfoJNaECDQUpMpOXaZ4GN2Ywy1xQyooFc83QKgas?=
 =?us-ascii?Q?yo8fKou62Rt2U1yZSgDeMJBuzrVFzMDOwcPTETFtsQqX113m/HBjvOU1qbRv?=
 =?us-ascii?Q?cU+oxb3bKJtSmFu6NPpwckBHKV20GPxIA4hsEYeCJP/VjYLd4ByaYFjnNMXw?=
 =?us-ascii?Q?2u9TQU9UYkJsj1NUz/mwdL8AbDqA2j5dTapi1DpOzqTNnRV1TA6RdVOYnruh?=
 =?us-ascii?Q?HmSY7B9aNz01TwGxnj84ydbXQZA0nNrm2oxCYVGWm1p5HLio4eJCwvIp1rE0?=
 =?us-ascii?Q?D3dpdOD3uqO0bltUu40LUf2vinXpSeuOs1lt6maASNcyw+uNSkS2QiZGpu4U?=
 =?us-ascii?Q?4d4MVxsoktorVO2cQMCw0nujTJ4m5T4CnRXKNX5/OsWS54mx1dU8yki5UL9g?=
 =?us-ascii?Q?cFXcvlKKEow4+raYPxMz3BFWqd5E6I8bbkJY5z3hWks9cvAE0KFXrz/6mTJg?=
 =?us-ascii?Q?ZJB9RViBlBBBTV1k8Ey2Du53lzOJn+BQGkBrlgECEFfOk/OiKVYvp9A/AKQE?=
 =?us-ascii?Q?0aYnT4ur0dliW1oj24Y/FEP2UFO/QuSdoNgFfXtXEDB0rleX0bWsnWkOMne0?=
 =?us-ascii?Q?htnD3OaPtW75SMXOd+lMzeDX+V7H+Zq9yqyzAzzEwVeaIjsjqP5wbXtG7+8v?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c98aaa-528d-4575-0adb-08dbec08467a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 09:40:49.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbeWIfrTDTOoDMEy6N5IaG6dv+/g8BydmemGoNeDY/6A0pMdQAmBgX5zFOhjpQ86rEz8M1ocLwGYEfmvicPY5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 04:09:57AM +0200, Wei Fang wrote:
> > I would suggest finding a way for the user space implementation to not
> > assume that ETHTOOL_MSG_CHANNELS_GET is implemented by the driver.
> 
> [Wei] IMO, the issue you encountered is that libbpf will perform an 
> ETHTOOL_GCHANNELS operation. The issue I encountered is that "ethtool -x"
> will also perform an ETHTOOL_GCHANNELS operation. Besides, There are other
> apps that do the same operation as this, so I think it's best for fsl-enetc driver
> to support querying channels.
> Because your patch is more reasonable than mine, I think you should submit
> this patch to upstream separately first.

The crucial piece you're omitting is that for ethtool -x, the "get channels"
operation didn't use to be required, making this new requirement a
breaking change. The interface between the Linux kernel and applications
doesn't do that, which is why it's preferable to bring it up with the
ethtool maintainers and the patch author instead of fixing one driver
and leaving who knows how many still unfixed (and also the stable
kernels unfixed for enetc as well).

To be clear, I won't submit the "get_channels" enetc patch for the RFH
indirection table to keep working. I might resubmit it for other
reasons, like when I return to the AF_XDP zerocopy work.
