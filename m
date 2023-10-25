Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7AA7D6075
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjJYDTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjJYDTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:19:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2200.outbound.protection.outlook.com [52.100.171.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45550BB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvjQRdy7yDLHXWSJdxkelVAY+/VmgsGwjfqmsOSILCjcED8wtU3E9btwPQqZzU1YY17HrSv0j4sSPD18jmcEU/jTmXjdmUoQeRX+eX9/wamSMPSJRHhgBHVccGiir1gpyaaap4xwoC8RT0+L8Ae6GtKpep6ETAPBI9g9sR0Zj5cjxYXgOlg/cNo+0Zgpd+isF/uIXUseXyXgOk72q9O2dJn6bHjRx2I5bbjeVEwqtucNpaGNLEaY84xG+CoFf7bUkqk3kokfXHovAr2LtfrSvse5J6KVydxmLqwdOCIMyymwVIX1HSwJd4gmSS33EQ2F1QR6dx1Z2kESjtZqTI1mKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWY5ZDRqg3u8AeLUVa7y6PsLIySWFSowGA286dgN/ls=;
 b=AvjJ8hvPm74unM9oAisQitoKllpHyHMW6l2wPTtFe+e140KxZubOKo/dmCPFJ8iH22UJdGTduBIU+JHWLOPhdpoddkDMCZLqu50NZPArDH3bOhWHcAejH8hJ8jvZJ5H16/6nVEJEy+20IVrov1IZ/+nbRG7lrEi9W1QcU78VjpumoxEeFIUgeYDIucYPefjg0rLoTI5ZLMetu1fibln7aOjdWyLpHGq8XIIrL+NsYf4+xGJHm8okT31FK+yG+/ld49H0MMwuY6cGqNnY0lvUeVNNadsQbO8SXifHkRrD12IYApr8GX9+3rva4Se5Pyx2xXYXo9afuajnkxmZ27OlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWY5ZDRqg3u8AeLUVa7y6PsLIySWFSowGA286dgN/ls=;
 b=hCDrv7d38+La0XkJBc40Q5ryd9vny0ply1+c2js8IOKTPmU1NX4R5Mm/s/IK8f78Ymoqcq1EhpohwvstQ476rHzqlpyyjjqmphr4f+5HDsOMTezTpyTgQOCdcoNCbAj62iddBd6BVJuBa1BWSxPVnrHZxtByvauXMiIl/rMZGvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA1PR01MB6656.prod.exchangelabs.com (2603:10b6:806:1a0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.34; Wed, 25 Oct 2023 03:19:11 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6907.021; Wed, 25 Oct 2023
 03:19:10 +0000
Date:   Tue, 24 Oct 2023 20:18:59 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Mark Rutland <mark.rutland@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH 2/3] perf/arm-cmn: Rework DTC counters (again)
In-Reply-To: <ZTY3ieLQaRQ4dHYP@FVFF77S0Q05N>
Message-ID: <136bf09b-d0a4-1588-801f-bffccb3e6f4@os.amperecomputing.com>
References: <cover.1697824215.git.robin.murphy@arm.com> <5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com> <8e179525-bba-c577-85cf-4aa0a7af436@os.amperecomputing.com> <ZTY3ieLQaRQ4dHYP@FVFF77S0Q05N>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR04CA0260.namprd04.prod.outlook.com
 (2603:10b6:303:88::25) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA1PR01MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: a1924636-7d94-41cf-4de4-08dbd5092752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ahjfsqtt802oZczXQ12gLtxW2Ol49G0aKPgCkOo0YXR5J1v4P+ZCiz9uIX/S?=
 =?us-ascii?Q?DuDOZMazMzclzki3sAd/StSNZkgQzqqJqVHsV75aJL2q4HkKGuWLq1/uk12G?=
 =?us-ascii?Q?VhDg/tRHmtzoSu3qRGim16EMe2YhHXwUwvj3ln+d0r90IVDzFU57jLbk4IgW?=
 =?us-ascii?Q?coVjhDPpUeA9B13AczQ/0yImtTP6w0jY051eQAf/JI3aGF1/jYvdAkgZ2GPQ?=
 =?us-ascii?Q?y1CLbOeGdmR9iaf7NuV2sx5U9OuW23XkR6PzujC8GH94bFNVw6nwJgqE0PWj?=
 =?us-ascii?Q?CF5KK7dUbfCf8cogx5+mC6UYoVj/gfqA63rgAbVcllt6JShD7UdBvXBhmzBr?=
 =?us-ascii?Q?YWOLdePHk5tp+SBFJViHF1UDdb35SiMjUxokMSfm1b6r+ih4ktYL28LaCYoH?=
 =?us-ascii?Q?q3Mzr1hamDI5PtGgZncKxsMARcA2sPtW4gxmKint07E6utYX9himcGpi9nAM?=
 =?us-ascii?Q?kGvZsrYUJNRtPUbIk7flw7wO0AcpP0nyg2e8LPyyxjz6d/DbgS0l6yRaHTDT?=
 =?us-ascii?Q?U3Z1PfR20Xx2s9CwcxMdBfFnLK0JiPUvpfUj05mpiqCklXEIuZBdvZpfI/gw?=
 =?us-ascii?Q?rxBut6oAPMaPUvCcqa2afQQeLMs4gPEHaqC1V9pjNGNgn9x+GJUWVEenDMsk?=
 =?us-ascii?Q?0/B0uDFUST+SzxPRVW5esIG+wbsSJsQmYdfrh98h9QlY6nee9hSb9YaieN33?=
 =?us-ascii?Q?XTnL3gzgdDGjlo2tJnU1t2I66l0tJ9oxsfna6qj6/PYrqri12jZYb2aMMvpr?=
 =?us-ascii?Q?kfO6Il//uu4Ztsoif1gcok/OOeAzpgY0WKKoGqpc2xgKfYM/8dKR39qjJ9N4?=
 =?us-ascii?Q?quh5fZPUd9Z/6Y4H0pWqNtsCI2VxC/E9uXPy/3lY63C1W6szH0XzPwESaWcN?=
 =?us-ascii?Q?TpfQwtWNhpoY++CHXKtz5CoZTnACxdoq2S8VTrtHyAt+MfeJudxnfVOCQ9ta?=
 =?us-ascii?Q?PDeDYvx3GeFDIP84vXXuhmpjNIUurRLDtRBhvIf+YzfVcwe/0C46Ssg7HjEs?=
 =?us-ascii?Q?we9Jo5/sZR4mxLwca69QRTa0s73leez0AxokZDDPuFWQ2W0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230031)(376002)(136003)(366004)(39850400004)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(38100700002)(2906002)(4744005)(41300700001)(5660300002)(86362001)(8936002)(38350700005)(8676002)(4326008)(54906003)(6666004)(478600001)(6916009)(6506007)(66556008)(66476007)(66946007)(316002)(6486002)(52116002)(2616005)(6512007)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gPrXP5fXB3VsAHl/SrQWA46VstKEdkMPQ3RVcunAohpvgC5XlMNyzcEbJm5/?=
 =?us-ascii?Q?9oGCphkpq1knSi+CW/bSwlVjXlSSOowo0pO/Vt6ujJAjZ9Jr/SZDMtNAW384?=
 =?us-ascii?Q?3SbkMb5EsllRry4T/zjvIPfNXa+cmJRNUcd+x3KUcdlr3tU+3v2rXe02OaoN?=
 =?us-ascii?Q?Msb8OWQWCAlQzN8iNFq1TohvPYJp8zMvfQqFGzhsJ/NhG0N5K0apU748tjJ3?=
 =?us-ascii?Q?wEQpeyqVuLTDJTy+OHE5ImE5lNfxUmOT3yi6slqcKnL06hdJnb7YSndYfVmq?=
 =?us-ascii?Q?dRSMhYme6Pl0EvQIm6B0r1XjGygOaBL9YrJFJvyZxlImwE7x4BUEUIFDSyp0?=
 =?us-ascii?Q?3CvumR7Uf95eGNYd8qA5M/hHHSFP6G3jfPcGoMVXXZhugCXqT8OUjExXqvAl?=
 =?us-ascii?Q?PGt0VVvGwfAVdZqtINPN6bCfJcT4bOzJR2N96x4mQJU0eNrpcUQDMw/2h34P?=
 =?us-ascii?Q?EEn7zldAp9TUD4NbgdR6H3/VC1n7EDAtwsj08vuPAQhmf671kKIhju6/eqtL?=
 =?us-ascii?Q?NZmriigAYts1SWz6oL498M3qWbBprLO8rgEsUz0DKzFJEQSbtHhC0/d/PqWH?=
 =?us-ascii?Q?PJ7QjvmW4i7O1lR/yE42h2J1Irsq4m3pU6KvCJj+yqkUP11TLnLQreoCjq01?=
 =?us-ascii?Q?mqHpk2DNK5edBeVGCdhnN2FVuwXpPWQyVHrpc7z3grULVdzV4de2DQQ8RYgE?=
 =?us-ascii?Q?wxzWb0pyTUZgwFaVTuOilW07R7abvw0vDTC537IfpvOlqp81If3CYKXCz/oK?=
 =?us-ascii?Q?MIo0IXAeewSFHjzmdAQf7Ot8pDh7vEMldZ9LRojjGOknJ6W/kW35VP5dyhBL?=
 =?us-ascii?Q?ol1/eZCmxfsuEOHIZE2kQ52XT1qvh3vH3UV/M17U3ia3zARHwTjIbRAliiTc?=
 =?us-ascii?Q?dw5apMQsa+sXRN1IubvxXw7GqwtmXNues7Ww6uPRUASmRURRH4QkUbdovY1S?=
 =?us-ascii?Q?I6Bh/faDLxSzoNDxMFKfEvBsMKuZqyrGl0bYTPDCEVLwQFFFD9UchQNWe3SI?=
 =?us-ascii?Q?LvUAyO0tYYWvt8xZeY9P4Bpt4fFCo8oRSPpSBMOx1WGv7yaFVlv+VZq9sGBv?=
 =?us-ascii?Q?/yUncmSNmPBlZvA20E1eu2PVbcuW2w/ozBbDyoUVxU4SdmTbAGcitMfX3Bz/?=
 =?us-ascii?Q?mi5QIgWdIFnj86+FawWZVGgTWXO4chVndaBtQp63EjYdPbg5Jf4njgFhtOE2?=
 =?us-ascii?Q?tUVhbfWV7O9D6KrMlDJ8bGLuJL58v6gQ1Ib3MOwoY+5l66tEOdnTDRTp8zXD?=
 =?us-ascii?Q?RFxsLucXCCAE+l5MqH4TL7ckmwwJ9CvevH2hKWX0IaJ8bTUv57FmC+V/i2IY?=
 =?us-ascii?Q?1bXn20B45/1RouQ9QGOkwffvrf2qVQU8Z/wXa95Zzv8K3k5a2FotyU8Yw+MW?=
 =?us-ascii?Q?+RWdcFr5k1BDOCUndbY6rDPyGVyABLhE9bRHdcJFrbsbbpmIiQGfNUn2pU7r?=
 =?us-ascii?Q?0VFQQ47hTvCns/5G9ZSSTwlTburZ8BEWaGceqYqoV9BQAmEG9u0+0cJwIM5w?=
 =?us-ascii?Q?d343pyKdHsPYG6YEBNbM20wM9Io6bpW+isaH75NaLi/XgzXzy3chvEqMMXdW?=
 =?us-ascii?Q?vf9VKbQsDtZjMYd0cPkutCrkN+oNq2LEaPKj3JvfJzah8KftqKYqK1CEveLv?=
 =?us-ascii?Q?FiSoPghyaVDDQzMJ8BjQ4uw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1924636-7d94-41cf-4de4-08dbd5092752
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 03:19:09.9098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAopNTYRbXbgoA63q8DQC5zjaFn2yaQoIp+PUWMFgeQZEl7lwt2krV6odn8GjL4N9qBq3q0qUQPqoxmid/7tisUXjXONGASIT5kCzOssvfqpcJ7tKa5a3Va0YQVOiUku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6656
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Oct 2023, Mark Rutland wrote:

> On Fri, Oct 20, 2023 at 03:50:30PM -0700, Ilkka Koskinen wrote:
>> Hi Robin,
>>
>> I have one comment, otherwise the patch looks good to me.
>
>>> +/* @i is the DTC number, @idx is the counter index on that DTC */
>>> +#define for_each_hw_dtc_idx(hw, i, idx) \
>>> +	for (int i = 0, idx; i < CMN_MAX_DTCS; i++) if ((idx = hw->dtc_idx[i]) >= 0)
>>
>> Isn't that "idx" unnecessary in the initialization?
>
> That creates the 'idx' variable that's assigned to by `idx = hw->dtc_idx[i]`,
> so that is necessary.

Uh, it clearly does that. I have absoutely no idea what I was thinking 
about here. Sorry about the confusion!

--Ilkka

>
> Mark.
>
