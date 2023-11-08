Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFBB7E5A75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjKHPv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKHPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:51:54 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E61BC3;
        Wed,  8 Nov 2023 07:51:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSKD3g/a3ia5q1orqeK6UBNS/cYfcL7c/RmIfsvQipCYy+/jRAKNRKDZktl6N9tWpZ8qltaSNVG3/jB2/dU7BdrqwLPD6wlt3BnlMXozd+BQ01neQNsZXLZ639AG8gjoJmeukO+95DptXz02TcPAc1LMGmIqHxyTEMqANuoQLjd5qdEnG40Wm1l/h1A1w4VUqyieD5kL11VpxJZGlmUAXDOH6LP6/yNfYmP8On3riKrf1+bQ5qdjRlN6BDSB03VUX+2Yiy8C32AgFIHQ2WipJWlpY2rH1UyNAFig75eW8j8Ug4sy8x+aTgrZIvFVQkULna2/TOEDe9Um6ebIFZMLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7bgvZaibOPzNTUAcql2w3jrXnvVVRRMmtgwexf4yD4=;
 b=CVTDEi+kkiFWlesjlt395wjoVdAXD4v9VN3mPS6Xv0+nVuIi+McBFFyhvCnXoIJ64wgvAHE/Rt1t9IY8VODVOxReuCziVUJGQarPLAEbo2MaPfKajXwYjVFSXQyr7mcllDk0bLQjKYeunErtYhmHBCntV+Yn/C2uPsvja7GAQIxYVa8RBA4Wwj1CRI5fgarKhTjLUhkcYbAIWe7kmKji8NI6dYo7pRENRWqpGlptuaHPvbFCnnNJQlT+VunY91dWUwR8z9mOnvA2CRjyLZ9WKW+f2TGVeEZkPJtLqc82sEZtCocgRBhSc1BCo7A/5y1bu470G7y6LsFRBN5M2NIqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7bgvZaibOPzNTUAcql2w3jrXnvVVRRMmtgwexf4yD4=;
 b=UiC0P1BOLo6gq/+w7bBoIkeX/J4DbdlYjr/fTeoxrSyHxJVAVeaVvKeQBFJTa4UEt9EZF7FlDa7V1xVIeEsR54xysoKACtT3a+z6bFpQ5lLkGzN2mp4IkG4tLFi1kGLK3Q3627VJPv4Ak0coI2i3jH+iFLHyoFZ2PdLZGht0lko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8394.eurprd04.prod.outlook.com (2603:10a6:10:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 15:51:48 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.017; Wed, 8 Nov 2023
 15:51:48 +0000
Date:   Wed, 8 Nov 2023 17:51:44 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 0/7] qbv cycle time extension/truncation
Message-ID: <20231108155144.xadpltcdw2rhdpkv@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: AM0PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::37) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 1290d4ce-3166-4ce6-acf6-08dbe0729dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BOBlXtYd9vIQtw9ubG6v8iV76K69S0fcpVl06Te8zwHIQoGcgSevdjj0MErudIu7qBkMNyiiq/f/99ZxunTFd1r5ahGLKSKUlfME6sEtoKZtGWOucaugxcVw0SwBErNMzgD0+Xvn35Z6ljKsHVloVOf3SWuy0inlIZ9rH2wkORwYouobmAIZO30/QYBo24k1rSSO4r6aiNVsUCJHt/nIxPqOkFJELUYgecICWK6HSCjngNOEKTqmsvuIqihrZtePAebQHH8MwBdTLFzaQgRv0UzHZsPxLVjU6uq6H4lSfmIR8ZVkXQhr78ljIlLrLXbaiBU88VNb9iNPcWIN/1fMks9DFaiHu3MGIZ2tfb+MNmcUBjRLG38m9rq/4BCT76kig35ATDBAvSFJz2nes/lFFiSVID3TpffdQAKQAfDTGtDxen2hH8wS5mluVXOSLivbKeEPC4zyvGaGw2UhuV5V1fF/8455/10ak6WyLYjDSiZ7vW2EKUtdDeHTLnf51YZR+t4MpdBhAXRSj7+fcDd0qyNuItxqh9uVoLqprkuJBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(33716001)(2906002)(8676002)(8936002)(83380400001)(4326008)(26005)(66946007)(54906003)(66476007)(66556008)(6916009)(316002)(7416002)(5660300002)(44832011)(478600001)(9686003)(966005)(6486002)(6512007)(6506007)(6666004)(1076003)(86362001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eLjIzBVRNFgpDFbIdPWn7V890bM/V1lqD09CDA3PzogGenV6tqcMKz7m4ncq?=
 =?us-ascii?Q?FZG9UTYnyQu7urSK7/hiKrWLQW2lkh4OwCJMVRzVpyUkbBNFUpT/09IHozzM?=
 =?us-ascii?Q?gRdEMGFBUMSOqXeqozO/hZPZDyvHWOP5cbXZeTBEnMibs/sCCVp8Q3vd3/7u?=
 =?us-ascii?Q?S3yfzRx2sep4bMSxZjx2KMWbiQMlGuAJeiQBJBrWiSfeSa3HX2d1UPWEcWWc?=
 =?us-ascii?Q?kQ38Kvd0PjSsmtyfS05bYEsjZL86fqwHQbZS1x+Dl56zf7wKcJn63TpB7KHJ?=
 =?us-ascii?Q?b5NCVsXQJO7gC/TlZStLuEf3/sgOrWdvmeWyNbg5SsKjcXzzxb30LVE0PN0W?=
 =?us-ascii?Q?YPdnvR/5OK5HBGObGKwOSjMzqPYWDz+vD8WyPwtGppBmkEifvla+T6a8o31q?=
 =?us-ascii?Q?nj5SqmuCZg1ysfNiTUfNipDbtFQ0uc9hy6iVeXvo4xsIHEf9WG/L/e6Oyna5?=
 =?us-ascii?Q?fxvFOVZy9jnLzTxRUZtv4jDVZPQTRst1jR9005MU40pywekPOAEPhQpODnxT?=
 =?us-ascii?Q?usFihH9DJL8IzyZO+6hQCStbxjo4F3/Nbb0rcNnmDV7RsjzAaa/nP697MKeB?=
 =?us-ascii?Q?O1mNAsuMSEU64Phj74JOr66qf0jbFi12wWjDuhsKoHJXyVTSGnY84xeze5fd?=
 =?us-ascii?Q?D7+HD35TL5EwfGNme8pXvX92U/OdrbufYjv6l+rXh14gF0aWfwRGteP0UduT?=
 =?us-ascii?Q?TY7vIOytk6lQSzivx0YNphL9P2ib4CRGrq52nsZ3N0qJO6wB0t5pSSd9tsid?=
 =?us-ascii?Q?0BaKwu6LvdXDmBTWMKTk2Yksf7LRQddp0TzEJHugld1EzjEhgxMLb+PUbQ9c?=
 =?us-ascii?Q?4tMO+uzBacXMd6JdgIp9NNHRgwUMKaf7LjpeGMC00LNLCXkSHUz98gM1CAS5?=
 =?us-ascii?Q?4PLMhE0npzre10VgL78rOshxB9l4Uhz0jnILl8m5EE7jUu4iDob1yvWeu0V+?=
 =?us-ascii?Q?I7jfxDKn3tzDKYW6cHy268bYJlw5BUfl7owCIhsc5g8Ew2FY5hRHDKZkYMaA?=
 =?us-ascii?Q?Xo2nc5GxGYG4rnS6nShk3Yze1yHWa1LGF3YRHUXKmWc/gMTTQVNWl96OQYhH?=
 =?us-ascii?Q?crxzTAbjIRCIPOlEgRo2A/jL+Mia02GHHqlIQcKvGD1R9ALcC3jslF8VKnQL?=
 =?us-ascii?Q?zXRMC8oYsZt6CX5kZwhKzkSNI1TfH69IGc5QEsGAxGTn/lCv5bPSj4MdeYb6?=
 =?us-ascii?Q?jBQC1jiSU9bhSiTAto5bEjhwk4E/BlYmpCE5Q2+jYmvo6DbYPQiT/QtyWjQa?=
 =?us-ascii?Q?KGzTHvoGluduhLEaeQgx+0ySWpo2SKB8ClbXfcrKbNAgEiosJOJsYnNdyAWx?=
 =?us-ascii?Q?20rON4czEDTY8qcc7wDCAPIGfaWHwDRxDldMh3I2fVQ5cL6J7aIYBVgpz8sc?=
 =?us-ascii?Q?kkZuClbf7wTL/E8NlPY1sVkFR7vSyOEHvoxoWYTqEt/hs1M3EhWZiI8n9ieL?=
 =?us-ascii?Q?UmK34KuyaRh3SpJOAx7AvBbuojxidZeJHTdIgegbk/+UmfcbHYW01SpRe6Ub?=
 =?us-ascii?Q?EsA59K341NqJnwwE2zkhhtT1nY0/RSqizjuYhmdr/JkGzjcnUJ4gf1N6PCAT?=
 =?us-ascii?Q?rqCpSLKPfpGDga8WjwcZtFtX4zrfm9gS5DuIdI2B85AZ3y0Ki1mCf63TvmV3?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1290d4ce-3166-4ce6-acf6-08dbe0729dfd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 15:51:48.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDA1KETtm0kjprYztZ+Be9D/xSAc+KhqrCRuGsl25kyzdqaAb/WiwYuFgDlLQNceRrha7eckW+vbS3ZBpZg2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8394
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Faizal,

On Tue, Nov 07, 2023 at 06:20:16AM -0500, Faizal Rahim wrote:
> According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension,
> the Cycle Time Extension variable allows this extension of the last old
> cycle to be done in a defined way. If the last complete old cycle would
> normally end less than OperCycleTimeExtension nanoseconds before the new
> base time, then the last complete cycle before AdminBaseTime is reached
> is extended so that it ends at AdminBaseTime.
> 
> Changes in v2:
> 
> - Added 's64 cycle_time_correction' in 'sched_gate_list struct'.
> - Removed sched_changed created in v1 since the new cycle_time_correction
>   field can also serve to indicate the need for a schedule change.
> - Added 'bool correction_active' in 'struct sched_entry' to represent
>   the correction state from the entry's perspective and return corrected
>   interval value when active.
> - Fix cycle time correction logics for the next entry in advance_sched()
> - Fix and implement proper cycle time correction logics for current
>   entry in taprio_start_sched()
> 
> v1 at:
> https://lore.kernel.org/lkml/20230530082541.495-1-muhammad.husaini.zulkifli@intel.com/

I like what came of this patch series. Thanks for following up and
taking over. I have some comments on individual patches.
