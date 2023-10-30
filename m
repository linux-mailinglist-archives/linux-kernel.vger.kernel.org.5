Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1412D7DC33F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjJ3Xle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjJ3Xlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:41:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417DFA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA86l8RGVAxgcxL6tVCQHbUpDK+cMI3TbtOIl8wIpPDr01xU3jk4eY6PnwjHQcJaeULmjdAWSEo/tF4hh9BASeVI6TDfzqGvIqRX+YTZbOdXi34a4lrFuGEtrLSZCAFLDmG54kODBLjb9mF6InQBDSDTE0tK6VEyjLDAyEeo6AZ8wJSW/ZWuoym9ZuA7AHlO/kC5c9RjzSySHpTSbaWjNzJNtSvWc+/MY2e+v2ohJZ41nLRWRf3CUfdkMLqwX5DI/HhqwWE3ugchoJb6t7VT0TOGPvavBigJMHclF5NVTtd9pU3B3+Ii+T9DNObV5hfZ56xqff4I64wpIoEOt8zllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG4nGqNQgNMUx9D5PhugVji1bQn/NOStE9FM9U34sTE=;
 b=dArgSFEQgpIgjg9U8RwPmz2qx3xBIyHX1wrhWwUhic8LArFwwJajN++Y3+y7soY+5CCoOz93VOko12ZmUxaMYJJL+7ZGoSp7Ji85wu/wpb0Tsi1BGmscPgobUmx99731iil8QaiiDwLH795ll/5/yJNyYQIGv0X/re1ohAZHsDf0jjAqUayqao8fK2fvBe/P1WDnB/lN1j9/AjT156KfI97WDkUfAfWl4oGp/gyagJBVj21R+hvbL6Jsa1RxdqSRLEbzrrC5kA7UKWKsZNYRfcanZiu1QSNxVXSWMYbiKzRaIKYnOAKoDEpH0Ut7QoVO4J6SZgYnOxyQO3z91a0eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG4nGqNQgNMUx9D5PhugVji1bQn/NOStE9FM9U34sTE=;
 b=pnAfDQKCT6VWO6CMXmHXQjVkOZu/fkkbN7/PbsE+oq0Mf2SpW7805jMnP1ZtOIEkWO8twj8l/o/D+cmnnRNqfJb30bESgzTGOjg4DIzp51mJxYosdj3k5R2HjZ5v4i0DwRZaxClEZwQFU8EOsyMr9gyYR1w6+Rf7LgAm8jj7Ehc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CY8PR17MB6650.namprd17.prod.outlook.com (2603:10b6:930:7b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15; Mon, 30 Oct
 2023 23:41:26 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.015; Mon, 30 Oct 2023
 23:41:26 +0000
Date:   Mon, 30 Oct 2023 19:41:23 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
        naoya.horiguchi@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kpageflags: respect folio head-page flag placement
Message-ID: <ZUA/IzTMokFsXS5Y@memverge.com>
References: <20231030180005.2046-1-gregory.price@memverge.com>
 <ZUA6qq6zXuc0fqOE@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUA6qq6zXuc0fqOE@casper.infradead.org>
X-ClientProxiedBy: SJ0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::22) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CY8PR17MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a5c39f-19da-439f-b11d-08dbd9a1bba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0K33JIQOnSo4MlbdVb9AmxTXJi3QDo7FFB6YNHYZdNcsIMj1QF85fTfWHOoLcFMZglacTSNzES9YiJJbSUDz0Bg0nlPpRXieDmUUldcQtR3Qkl/q7sk50sjbq07riTYVaXdtT+N/3Ef7ToGkSuxsfWh1m1T03CaCiI+3+Z37nK1mca2WMlgXimwfCCobEwBa1/eN4PJ286Rr6Z2fvhp8Zt0tKDOCez0jldOz/dgU2MxHbfNNHJSRnS9cGBBhuRs5nFjT9Jziy+Y8zkStU6UCy3vBdkvM2JaNoARSQFCtgK7U/LmC4O9XyR17ob8VTVeuryUI9TczPAtnmco4sqMtCEHT3enZ+7hvblBoTm69+tAEW3C9oSOHmkkhuBwnI2rMX20opNX23eZBXrYE9pGyh+O/BYIQO2PhIs6EZplbQy/NveRBaryheA+DpFm9ltUT5DkOYkmFQDco3AGOzrN+VmFnEtlWcSLelMTvf+8Ut0FV9UUwOHN1n0R4gS4TM0kz9c6Wgm3cveESMO6jmwt7vUeoT5G515ZV+erdj8fu4LbEBR8b/tRAinhSj255LyTHqELcbnqcXZB6aSDMGAIHgIlBuJwhnj1UvX3qEiJCT65xRvGnRBzr5r2/SdPJhQP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39840400004)(376002)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6506007)(6666004)(6512007)(86362001)(8676002)(8936002)(41300700001)(2906002)(4326008)(44832011)(5660300002)(36756003)(6486002)(478600001)(66946007)(2616005)(26005)(66476007)(6916009)(66556008)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMa4ZhKcJVMZ06uFw1DxHKunYoKDAQ4ClOV0DHZ1GkOCB67HeHsfq8pYeLDJ?=
 =?us-ascii?Q?Q8/yWooHW2N5YwceZRNG56b2aUkAUfQoqupfEteiJd9fvm8y/d9zrTCXNk3O?=
 =?us-ascii?Q?prVUZs05FHp3bLIiM/K1VfYTflidRO8RsnPkryRMwZaMENSkj189WT0AVlkO?=
 =?us-ascii?Q?2PxILCTOjvDNXXIJoPMlRbttA85AelCXL6QMMH010FIfxUjhWPns9CRkc4gS?=
 =?us-ascii?Q?hR8LZuShRuWW8DQCx2WydVz/lWIRSY6Ovc3PrJODMf7FyNVPmYZYst2qdKKv?=
 =?us-ascii?Q?FHXKuoO5MfFi1htzdIODIQ3mVAgtfPDV1E3jkq+iln3+YtPS/HZGgWDBhYtm?=
 =?us-ascii?Q?sduqOYDP+Daj8wVlZ/jOXbjm8IeUWTobYP5egGt1jCCx/F+L3T0928b/y5Hs?=
 =?us-ascii?Q?19b6s0m8jSNfLvPi3GuCRnBxcrfxgKXyv0a7GrGZZfkv7nJue9+/w0NlJO8O?=
 =?us-ascii?Q?TnXSm2pXdoYgv/LGuPJHmdcgp/HsnC0nm91ENw3LCeludS4yEO/rgrs9JKqh?=
 =?us-ascii?Q?syXsCETV3RO+ovfvqlHD46G2EQtP8qmAWufnNNrYzpokRZcjGbNu1PmHW0M4?=
 =?us-ascii?Q?TD7HW5gg0OvoZap0tZXXlq4pkXB+19UHPGFI9m9R/vg7awOtcd5nq4IJR9aI?=
 =?us-ascii?Q?L852F8wP2ViT6EwcG2YtScWIdBrQ3brf/z6/ueBOiiV28j+75DApFb//u6pY?=
 =?us-ascii?Q?Ri6GauLBeYbKwsDvC44afFiuDC6HtWZxHfu+jcccdqVDrepEs1E9amYh4QSN?=
 =?us-ascii?Q?iVis1ubJpj8j0LdGLt/l1gQ90fbwAbJIBsI4o/wGIgdyeBDiGiQuG+qKwdPd?=
 =?us-ascii?Q?VQJd//zDY9b8vkCqYz++Vmfl/LQv32XKYVWlmhaLAm5ww9yy2xIDlD98VJAR?=
 =?us-ascii?Q?AXi21/4hmaaKyyav8dEbSFSTsHGiZBEfMwGe7am9TMX10/Fur1lVrSlvVaxE?=
 =?us-ascii?Q?kkf/YWRRPWRgF0p92p34FGkLaC9huSJQhZVwfWXpK4J4ju3wNqPkp1/FrjUy?=
 =?us-ascii?Q?ENWGmXcsrB45laBws1vxyFYo6NGNm96BYrNOGaFuoCNL8NtBbpSAVP4OyWDS?=
 =?us-ascii?Q?GPeWNKRtdwWCXwrfh7YpY/qPUdX2rM38Kbb6/qM9wBeBu0QV4+/rcV4s92iZ?=
 =?us-ascii?Q?r6NPOLiNqk5f89DgfNem1no4F5nDfDmLaAnDKqZMRHcf9n5ACAQZkQ/a+6RM?=
 =?us-ascii?Q?zrxQukyHFkzgR6+T8Ejwf77GDrwpgwcZCnytIL+4nT8B5ERqXbCnv8RO9mym?=
 =?us-ascii?Q?keD5klIyIjosGjGjKI0urUC9sxoJjuBddO4CDpMH3R168HznqTnd0yq3DVqF?=
 =?us-ascii?Q?V1gyCi/9n2Xm2Bn1ew8rWSPczvGI6bo6th+DeIG6cJV9b1yKB8riNxnC+lhe?=
 =?us-ascii?Q?2wzilrjZMyyG9/aZsW8cAFlPD/PSeT7VjwWHr6CyFia0PML0jyZrAH023mQi?=
 =?us-ascii?Q?GXMc8rqn+sjENeZgyPw+KXAQg7fp1XSqdehocowDjWXtpBP05NZ1tjg5oHuO?=
 =?us-ascii?Q?V+BbTPdFxCdkeAZobm39OMfpXVjOnLpDLshDSl/KD4FZpzDu5ux0GVGX73/Z?=
 =?us-ascii?Q?OPRg1y3MpnEMuPMwW1O825fsBYkFvPNtu3BcAv5aZqKhAJ6dosPDTMprp0ql?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a5c39f-19da-439f-b11d-08dbd9a1bba0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 23:41:26.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cot1vWvUC+tPu+/8HR1b4eBze/jfTrgNp7gxvbpOsnUP+LmwHkiv+g9fvuSlLOlwGiE+/8sHXNI0xONi55j4lZAB+BqanjIOxadij3UH2SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR17MB6650
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:22:18PM +0000, Matthew Wilcox wrote:
> On Mon, Oct 30, 2023 at 02:00:05PM -0400, Gregory Price wrote:
> > kpageflags reads page-flags directly from the page, even when the
> > respective flag is only updated on the headpage of a folio.
> > 
> > Update bitchecks to use PAGEFLAG() interfaces to check folio for the
> > referenced, dirty, lru, active, and unevictable bits.
> 
> But uptodate, writeback and reclaim (amongst others) are also defined
> only on the head page.
> 

Ah yes i was only looking at the things defined w/ PAGEFLAG defines in
page-flags.h. I'll give it full once over can collect them all, my bad.

(also i forgot to update my commit message)

Quick question here since i have your attention: any recommendation on
what to do for ONLY_HEAD flags?  If the provided page is not the head,
should the flag report 0... or whatever the head says?

> >  	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
> >  	u |= kpf_copy_bit(k, KPF_WRITEBACK,	PG_writeback);
> >  
> >  	u |= kpf_copy_bit(k, KPF_RECLAIM,	PG_reclaim);
> >  
> >  	if (PageSwapCache(page))
> >  		u |= 1 << KPF_SWAPCACHE;
> >  	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
> >  
> >  	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
> 
