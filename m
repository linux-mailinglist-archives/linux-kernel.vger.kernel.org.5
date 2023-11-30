Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C5B7FFD6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376855AbjK3VTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376829AbjK3VTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:19:04 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD8F133;
        Thu, 30 Nov 2023 13:19:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/R/IYZA26oezx1tGjBb9FYZf2LXwTMtG6l7EVBFIv7UYMcapi//fwP9fhEB6LrIn4l1UBFdy90U+YbuRWke0F7n3fq8pVNa+PaUe8r6/k7QH96n1YDSC9JC461HBP0wuZEyXAHD7EQuluD9BkgaHwtQWWdH9MwiBPbab4KGmA+SxNbQfJ57VqbpYUOA9qluA5CADbvWd/i4p6mNUHUhzIciSL1XW7seuUvQJhWfq/wmKSjVZO5/wehOtowcSn4xlYqXpwzaQj8alKgy/RhHIe9AqsWx7LeFah+WK1S/VmsXbDCRIib+SaOmO/kAQ/WB2fxO59kTt30I2RSSc+zvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRBcPW8bJ1CayGwnGUQ4U0XcoYMoGUUVbnnIBozFQS4=;
 b=DEQtRvwfhuQ7yWLrBRt7V+nio+guHML6j1sYZwtMWIRguaQVUdhSdo0/LdzzxnykOaa9aiC/b/2xiFV/brICdj1shS0mjMgBs+MV+7lcqQjd7TnrHjzQ9XCW8+movMeMaMUUiN6L/UanfB1/SJ6pK7JObwFYq86AuTZwz5ru44CiUQCVXVWT/yeS7t3ahRPRDboC20lRUht/AdiX682qSul2v9IbOXzeChEklQD9JnDlDWCN6xnIGX0DwJpGa4y8oCS8SXZ1YblOaHjWzJCEi1ObSQubHrpNGUVtzr2JZFdZ1YN+yGAuaTECp4LT9QaEemQxgo6Y1xuJEyelVD396Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRBcPW8bJ1CayGwnGUQ4U0XcoYMoGUUVbnnIBozFQS4=;
 b=idejOG2lkbWl9+8iv4SBVuF7gAUhvxuWeh5xasxAAkWA5q5Z+ShAk8SrmJngKKnAZ/KBoQYiBPzYX7vX2ijFBXhij99MidsMunxBJjmHfy52q4hHut8fAmjdCXRD/HD6cWGFey1Shi22VhiauoOfMk9PgyndJodlu2DjtYyKgxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB7822.eurprd04.prod.outlook.com (2603:10a6:102:b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.15; Thu, 30 Nov
 2023 21:19:07 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 21:19:07 +0000
Date:   Thu, 30 Nov 2023 23:19:03 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231130211903.uu5yhfki5gghpplu@skbuf>
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-7-rogerq@kernel.org>
 <20231120232620.uciap4bazypzlg3g@skbuf>
 <eeea995b-a294-4a46-aa3e-93fc2b274504@kernel.org>
 <20231121115314.deuvdjk64rcwktl4@skbuf>
 <6def78e7-8264-4745-94f3-b32b854af0c2@kernel.org>
 <20231130132222.w2irs5c4lxh5jcv7@skbuf>
 <030c7d65-bead-46d0-8422-8a9ff0548d72@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030c7d65-bead-46d0-8422-8a9ff0548d72@kernel.org>
X-ClientProxiedBy: VI1PR02CA0065.eurprd02.prod.outlook.com
 (2603:10a6:802:14::36) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 136230aa-1681-4695-e93b-08dbf1e9fc95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7Ey3T6vqUyAPqFTiDNnJB9Oc7ro8gdlKxpWfQhR1PpHTymyfsbUWjUzZlHutMup0sWNjKNX8z9N8Usew8QqRm3mvRr+pBAYC4COZNdva/QO2862O4SE85+FLaf09oo8rX3SjCFc/C8yDRMe9BlY53eSnHeFLYWxpMN6Bpb17VAF9NM0OHYJ9evZDZereBWjyhfqlBr8+Qrnj7M1S6YJqdFDB/4xncFA0AmJKBs2HqO38vBUvvFZJhB979Bunjp2VgRBKNGNo4dt63RIvNyYpMvAHzZNuP7ArW4VrYRWAM+flbiJCeDITdJrkUfwe/4lfRQqVoTQSrRTXV1wAB1d/ZHhPgbxhg59uRUxPa8GRvx2Vr9NFPc4rtqAfwhRPR8RnHewN48WGbWsLx8y+dSK01cD2jqyxAulfCRmW89I3LdQ8qM3buv9Ntz4nqBNsBai8QhZ5nPlKmeWeOrndrGzp88SWu054B8+90ruY8cIHsEBWh68uhV4DkL7k69yLQiJxzG4lvlsgq58d5Hy4mddAvw4Y3W5Pa3O2TMQEpObf5XF8sli+Cefv88ILKgUWiJt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(1076003)(26005)(6506007)(6666004)(6512007)(9686003)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(8676002)(8936002)(478600001)(6486002)(38100700002)(41300700001)(2906002)(7416002)(5660300002)(558084003)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yjAxL0sH5d8WiPlq4yAmbriA78Efp7J8XGoBP8XunxrCWC0XaE+aTxnBpjwM?=
 =?us-ascii?Q?pINWT4dnHEM9d4d3DvfmMDgJFDADNMSUHOB3lw0SOZXvZ3sv9UGlN0CgjYff?=
 =?us-ascii?Q?tNoTe+nOm1Mt7H/xp1D18QydXoghnpsd1AAU5LCXt8jfLHjj9OM8kZJcyRvO?=
 =?us-ascii?Q?9jA3ZzaZMpq0J2Nev0b5dd25Mz7hs++/rDPrA8WmTB3JDcyieJ6WKOEQZ+eg?=
 =?us-ascii?Q?93Dvj5LtJcLyDpEEnMO24DOM1rI8YhgvnUudiMvouAgBRdDgMDduY6+JDFck?=
 =?us-ascii?Q?1jqHNEOFwA07EQXwb0encAF5SEAB+pK0ShWQnUxEPgXoZ+eE5+lzYiwbak/q?=
 =?us-ascii?Q?yYtehNo00dsVgUWLvQ23VUwCCR1JquuI6xyzPkSM4JEwomErk+rernOM50Pt?=
 =?us-ascii?Q?GZkL9k6qtsdOhnzYk+mZTQBPo+Xc3Utop32rRepcKmR/1BX1NDHaqg3Z2M8Q?=
 =?us-ascii?Q?ddaCSUxRWdIHcTJLSFMYUw5QYqfvcwqrg04Jh4IjZxB7a2ffxt3pVzLfJK0Y?=
 =?us-ascii?Q?jWY1LO8dA8fxNSc92Y0Q034LoI6L/zxWNR4ylGiSTNfvNGipj8s8kVwKjweC?=
 =?us-ascii?Q?PhaM55zqzOt9ZNBNWMso/bwqANjQf5RHMHE4VqIWUXv7aiFcq+nKbGavNyEi?=
 =?us-ascii?Q?5cHESrGBX705AeVda33AMzt+MAPkZ/2ra/OnsXrlQ4cHgEyH1ZRm3q4lSvQ0?=
 =?us-ascii?Q?lRUflqHn1qLi32AURO0+qtnsw6IoHEzsHj2ZHVUChrcEVBQWsOTqxVvTK9An?=
 =?us-ascii?Q?wfmFdiDv1DqqffOPi/ZE82bzythZxGOY03LjecIQVhhL8tpt8nPAsoSPJst/?=
 =?us-ascii?Q?vkHdvPgV5swCPq3ruQHB9rkiKn3m9039o0MPBqVRufE2Jn5iKr4Twlojl2St?=
 =?us-ascii?Q?IzKQr/iyccCCauO5fn5lHduM+4uuHSXTQuTKXIU0qPGFYmjbZAA1I7NLc1Pv?=
 =?us-ascii?Q?kVmxfWi9FeHHj2pX9flmWnXox6bdKj+9yi2a/fgcLOedaevNhMafHBE20Tm6?=
 =?us-ascii?Q?zoPhV+oWt/rJ1qdHAKHZQZpQxPvoGlPJv3E/ntxIvz6uzwvFmpSc5udxfC+X?=
 =?us-ascii?Q?LYvYDv23CEy+bERRlcSJvpV17d4tNpX5wOksFZ02KInuNUMMG/b3vcYH7qeo?=
 =?us-ascii?Q?8DpIdxQKqnGJUgLJIZo0fMLGytjMBXnS7Wa1/br6oFmridk81TszCI0ZTY7J?=
 =?us-ascii?Q?/n4ursFxl5TQhDLgWVYkvFI5Nxt4QAvRrJAFDgc/QuVXl8/g3r7W2hUkUY42?=
 =?us-ascii?Q?hN9zk529uX6ipProjgVSAXV8mvhCa2uGZHzOJbuwPvhKZqJkCguJsKMyvR4X?=
 =?us-ascii?Q?BjjG8S76QZJ2DRa4puKPCh9ayfoSDvsYHbrN4GAN/rAj1ONe65qFts+h285w?=
 =?us-ascii?Q?te1y9v/nb81cwN/Xx7WWR47lzs1jmJ/YVek3ZA7fp2O59z+ui+h62RsiZ3Sq?=
 =?us-ascii?Q?AAi/+iiiaEyFQs/b6a4e/jGas8MOyEP60h7NNEXKUIiW4IA1ql1x8C9fb4ii?=
 =?us-ascii?Q?sVAK7EtJ1F1BtmxUMZLJ8mN2npmcBqyQPhosNYniw2l9B+EGZNIGuLGhkVHH?=
 =?us-ascii?Q?UUKaImyBlaXy5W2IsInW3uh1ndZi/fdgjIaWu/HzjkbhKsd1CJ9cIri5pWEk?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136230aa-1681-4695-e93b-08dbf1e9fc95
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 21:19:07.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgLMHbprKTSawnOaYupu8w7MF433sXhlNc9h6LFqZzVjVjOmVQUMyCgDqQIT1vG9RIxB7v0cEabCl4MhgLpgdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:23:49PM +0200, Roger Quadros wrote:
> Should I include your patch in the next revision of this series?

Yeah, please do.
