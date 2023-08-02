Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1CD76CD4A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjHBMos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjHBMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:44:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31B3584;
        Wed,  2 Aug 2023 05:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ipw5Y0UycP5acf16qLahZ6A1uxGnBxNTFurAQ9mjNgLnvWsloSPB3mSooV5Q6CsF/oEVeLb6GcHR2GCfxXf0N5WlB3jzDYm/odvpIjQMvrPJstQm+eIQNjsTZosNmkkQT8A1+kBryLo1IpPjuHwBFO+4aKBkSPsA/zoewCN0dj7eOCKwpn6NuhhIjIEdnVjopogPZAJVXoTp43OTRrbFVI4jfugiCJr8kPpRaqu6+qExYFHPMoiG8MLLPS8UwXjLKeCvNKW6jziHXopGCCVYJE3YxuEZYk5TO08wIkrNjvsKQeGQOtcUoUanmLq9uhF348Khh2pj5iTzxehy07NwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBqI+sYY6sawf9drlfvoblJCyezgCbEpnNlP05Zs9Mo=;
 b=bd/FOsKB2sKaTyi7Fc0x0xQSvllu71eb9n4TruDhxOovgXnWtKuWSVM4VmIMnrsihQlzizG2Os2pr9rFJ6cNiyAPyWHfoDmMFnDyZ+XlSd3/v2Kds7ymKm/pX0x/DjbrJlHs/gClW5I16b31avuZNPIq0x9mVwBoTSYv1EoxmE+sXHV6aPk0WNDeF4Yie5pJuHAOCtxpplJdHUuyzL2vIg2RqHu0E+XfeNyWgKJWdv3T1sBgl5udL4jtw1tumO7TDpAPmhjQd5r1o4ii3qGL1mhfBiTIqkrcirh3x+idFMQW4aR7UGddmUIcAzk7TVRwwrCd95BtDWn3oStAv6J6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBqI+sYY6sawf9drlfvoblJCyezgCbEpnNlP05Zs9Mo=;
 b=qn4PDwGx/SmZSNHZQ0TDOau07FwKsMftoGWtCKZaQuc3t3ulMTfppWJvBBQ7Y0CAr2KIxQpdY4KU/Pi7gcjucOzwHNquC2UrOK9qDgbplZVC1M8R9BOYb9ZAizTHCTz07pvcEWgZjnV79TB1diUhKrN6hCBkIGbEJT+hoFZJwGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB7678.eurprd04.prod.outlook.com (2603:10a6:102:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:43:40 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:43:40 +0000
Date:   Wed, 2 Aug 2023 15:43:35 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: Re: [PATCH v3 net-next 06/10] net: ptp: create a mock-up PTP
 Hardware Clock driver
Message-ID: <20230802124335.b52l4bv4qemrer63@skbuf>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
 <20230801182421.1997560-7-vladimir.oltean@nxp.com>
 <87cz05k58d.fsf@kurt>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz05k58d.fsf@kurt>
X-ClientProxiedBy: VI1PR04CA0110.eurprd04.prod.outlook.com
 (2603:10a6:803:64::45) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a542923-bfca-4e85-ec28-08db93561910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eFArayxoa6X2PIS+P0TwYeMu8HoqZFOdENDFX4MdBRK1Sl+bq/z4UhQ1+PsDUgCzjPLVNYYJo/bcD4bzLyCMCKWsH/aYwIGvVwmq7T7l1cquB1M6dzXswQrWBDjdzOh2GsOEY6hH/7v9UMBz1vi2Ck040asVGgyc31Sy7Fl/xkznBAvtURMwoCOWMDn990SoneQbJqMNPim1QfGwV24j7dwAIBZh7YLA+8iCBbVsOWnv2EDKJbld6Fj0R7EyK1/FuGtgLCwo+Gk0CPQDs9riA926sjSvgun2d/2WNCHeYhlGyB+GbgpJ+pYuCwN56y63Xn4ncNf9axClGOSRlIXWCG/5NkgN3gI7TBj0jAij4pK09WRjvEC5qha1uzaU5Jn+B8VjaJcSumyEL+jadCQhh8TmrViysMPQ45aWcYn9NKh91wKgEDf+20hZBipjThFRIYIF+6bM0GOPmT24fHsCmcla6c8Bc8PwLHxaSgUPT1+EdSGg6I+k4YNvcLU2frvFhhDXQ+XwJFKBANeENiG22QoIGaCjhAljnVqRdcWGmjWAEh6C2Aoi09k801KPY9e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(2906002)(83380400001)(44832011)(7416002)(1076003)(478600001)(54906003)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(6666004)(33716001)(4326008)(6916009)(186003)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sA9z9J9eWHT1jYVb4OAOkcQjD4CmFciJtFWh/Lqh80GRP523mk3SlecSWU6Y?=
 =?us-ascii?Q?ChPboIHQExqJQoarwwlJ+rB/LysoXoAUo+ysEEo61Cn27DdqQBw/aANH+p6b?=
 =?us-ascii?Q?gwBCBFEDO9Z9UImF3Xd9sqAysx2I8j9fAuGYeuQodkunstynrjnLGepJsD7N?=
 =?us-ascii?Q?dp3nSV9hpjBrbXIqTZijK/bLuDj0ey5OBElkr7KmGJ29QUIpdSY1bD1n/PKf?=
 =?us-ascii?Q?z8uu8dKZTkBriww0RLCkjZuCg78mzZiBMFpl6txuU9Jfd7EJlXc7n+S0wpA0?=
 =?us-ascii?Q?xK+HBXgLm3uqtwjOofljbx7mcLbdSndwwSQ3FoaT08L0iGn9rZFEEyFHdJbA?=
 =?us-ascii?Q?EdTsPzYzsURzkWr4q1t+a3We2dg0mgAQExiz0sX7Ww9BvwlJYXkJbKPJwzZm?=
 =?us-ascii?Q?fJ1C9FrjQNGc9Ru3SS7aLMWLmobxGV2aguuPMyhrfdbBTBiSjqzXHOxtmVZT?=
 =?us-ascii?Q?msRuxbliiMIeIV5tEZayywOOCqhwlqp52Fn288h82CG9QuEr3qfBFXGAImLt?=
 =?us-ascii?Q?x3DLLdtWkdQXpNPigB+Gzq0oNW1OzUBxSinbQAF8ntKkpHdJC29YRLxLsDI9?=
 =?us-ascii?Q?UBe8IgyXdWbvlfQisaSZpNHw3ueq4+kqi73IsjZeXS/EVqmWg54EnLFPiXhX?=
 =?us-ascii?Q?SQNW2KYg7G6QcBevd/0w7rZ6WEHTkYhQXfz1SXjamSi/ycMBoHjU9OYZJZF3?=
 =?us-ascii?Q?qXwokpWY0XdXIgI84doP08r+52AS1r9zAAmVNePjG3lWGVj/Pn2FFwzWXb1E?=
 =?us-ascii?Q?aCK1aZYSY2C6r7/wWRCFlJdE0FuedKJjhzlrqvkxKRGboK74YDoq5k9INn8P?=
 =?us-ascii?Q?sjFJz6VOFgctBcbf1RWh/ztd54DmvjsbvBIDhL321CThRv/+bMQucRYT7IVU?=
 =?us-ascii?Q?nEozS+2adeN0/OhL7rXMg7aPkr+5uZeiS6PjGI66gw68vOWfk18feruSlE5w?=
 =?us-ascii?Q?CGDLUHl/a5qx4M3pLZnn8WaC3qA8afGhUjhnt7Bp5cQN91+7OKCBx6tSuAGj?=
 =?us-ascii?Q?+tGz+scsznE+4FGfFX0mfCMd2NxQk6P6vzf+RXtOYWKefFm0htGzsgUK25LO?=
 =?us-ascii?Q?WbbXRuIYY5N4bXbaJn3IXDP+MDu3lnB3Gz3hHrOpd/ndDukfbyciWvOYpgE0?=
 =?us-ascii?Q?38MmFUEOxCCuAdWZTYQ4JGI1/aNlE8YIrZc5MnIx7Fy07ECDi1KIAa6P1e0J?=
 =?us-ascii?Q?LibWsPmWd4JOS89HwtKkS/PX9sS2s5CORzlfv9Iyn8TU3JTj6DL5YgJBuKOn?=
 =?us-ascii?Q?GYmYVb0xCFu7acLYowuiuWK5RL7BrkCbotp0fsomm819XHs3zo+dSj3gp4FY?=
 =?us-ascii?Q?xW1r0MWogWEZt2Ge5vu0SCyT9iepP/ikWLBngHa7WYMDDFRzhdIjTrrps9Vn?=
 =?us-ascii?Q?Sb1me0XYlaxxVJnxYLZv5T5jRgPo/kdvyJdI9/8VpTW0Hm7Nq0zTfOIYc9T7?=
 =?us-ascii?Q?vrnB6BOiu7884CIcUj+AN6dAoR22pgkc/wl3pRfg/zh9IAcPlbMD4/7FimBc?=
 =?us-ascii?Q?SPKBG4ASCGpIebcY5k3+fdPh32xbU2VrrXaqmQVF/1ZdGP+lN+ZXuJKHUa+b?=
 =?us-ascii?Q?X0y6z1PWp8xr96+4+EJcnzz5NyWrdIfnmoRS11rtQn42lUf9XcmwpdrCKGND?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a542923-bfca-4e85-ec28-08db93561910
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:43:40.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiZKWn7ecZsN4OqBOFbCJ08Rh7/Ao3tQCNrmvNJILlAJm71in6bGE1BfWoCQu7eApFIh7ksCpDGLscytNXCYxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7678
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kurt,

On Wed, Aug 02, 2023 at 02:18:10PM +0200, Kurt Kanzenbach wrote:
> > +static u64 mock_phc_cc_read(const struct cyclecounter *cc)
> > +{
> > +	return ktime_to_ns(ktime_get_raw());
> 
> Maybe return ktime_get_raw_ns()?

Maybe.. Didn't notice that there's a helper which does exactly this.

> > +}
> > +
> > +static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
> > +{
> > +	struct mock_phc *phc = info_to_phc(info);
> > +	s64 adj;
> > +
> > +	adj = (s64)scaled_ppm << MOCK_PHC_FADJ_SHIFT;
> > +	adj = div_s64(adj, MOCK_PHC_FADJ_DENOMINATOR);
> > +
> > +	spin_lock_bh(&mock_phc_lock);
> 
> Why spin_lock_bh()? What's executed in bh context here? The PTP aux
> worker runs in thread context.

Correct, thanks for spotting. This is a left-over from some other
(unsubmitted) functionality I was working on. In the submitted variant,
nothing runs in softirq context, and thus, bottom halves don't need to
be disabled.

If there's nothing functionally broken, I think I'd prefer to address
both comments with follow-up patches rather than respinning this 10-patch
series. The build testing for this series still has not finished yet,
since yesterday.

Thanks for reviewing.
