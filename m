Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930727DD39B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjJaQ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjJaQ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:59:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA59C76A8;
        Tue, 31 Oct 2023 09:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsWPqXYqq1zqcvlblW9HauoYTOnq6v0M/d4XdwQ3w9uoX0cprXwvCH7K1pJUkkj1c2PlCQcEoRs9kmVwrPsk44F9Mx3Rsp58Nh/B5abfgF6OZXh9570DudYyeAsU4XaYq4K+LFVnZ5vEIRSNYssn040z0dX04UAvkPNoUVaEsjRjoG6y+L7Vrdqo/wChnnlXoGKKotM6KNVQm5pk/6I6Y4Tm4jAZA7yd+Dj9dQhFAWBKdA1i4I+E85jliFdRZkm0NaeDiZm8oghhk+WXjbeIpf7D8bvqakFiT417BowKEJ4RkRtFpRs/g1c/Q3OJWvEcWkOw8buoVchE+vgrqgJXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V13O2bw19hdmiAbHcZS0zM11hTLBFgKaj9G7ErQGYU0=;
 b=Pwugbg702weudNOrWndhE469o0SvZ/5XWMMcTint1zeiyiPxa43j8oeJyQz44yETKNaBRBP9ESAijBUDBwQsQB0kbYc6fLdTJqxWw6RZWYKh2yomPLofI9HrLL/Cwjtn8vISWv5ODmUM7+fJfZpQdsmhJRnSLz5pTeuGLZxWe5Ja7tvPzotWJFLeDwEDYpwL6dDdfiQIxjGU5ngi9cT2yEpfKAlsHkAcCiubrAVpOFSwSA7tDxfovvemKD/PCWhHxlsDqcUa4SoxeOqyosg1Rm2O/gxr3FmhvF8WnGVTMhJzwonB+58TiPpCXYi2EdNzAsMADy0sD2r8BPxYJqNqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V13O2bw19hdmiAbHcZS0zM11hTLBFgKaj9G7ErQGYU0=;
 b=xoTTnoO5tPNxmJjC3W05bY2Ujs+M6myehtpeOOhmJKyjCS/ZFfhQt+q7Dcpl7Ar8yLQuHc1xf7nQw8i2ymS+IAomTjs5r4AwuJrnVd6yvsDSWKeCcg872yT+B8+Ykd1toQr/Xh8eecuMvwqohveEgE0XRQ80opfcB6NzvWEtn20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6743.namprd17.prod.outlook.com (2603:10b6:8:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15; Tue, 31 Oct
 2023 16:57:53 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.015; Tue, 31 Oct 2023
 16:57:53 +0000
Date:   Tue, 31 Oct 2023 00:29:20 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        weixugc@google.com, apopple@nvidia.com, tim.c.chen@intel.com,
        dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <ZUCCoCRS3cohf9OE@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <20231031162216.GB3029315@cmpxchg.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031162216.GB3029315@cmpxchg.org>
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: e03813ef-1ccc-429a-b613-08dbda3285bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vo5TH+H8mBac0SvxB49s+w/2+VvqXB1jg/FfWGJlEj1XaE7W3cKp6kERt7mI9GY3GAF7y9alkN4EV3iqNN56pnL9h703WVvsKYLMoG+B3ChApavDkwo+W+4nk+N8oudktAbA+1arL6Ai11qw0dHANdQfwisRHjeKUXqTZ8l0t/7nW4Vj0KOja8jgBZxtXKOlVtxQNye1DUaYvM3GY1cVASyyZKWw5con4GAZnOa0AGaRHEvB0DBtNkpnZXctskjKLV1/qDmJYZAubH6SI/yt2UDVodxoYIgXkGqkd3u1vDjpjGA8fZxvWgYKPyiyL5dc3CbJIPV/PSDK26C7c51mJyJY0i218TFdL9jfBdFaGqo9Lj6UVjr2wxF8BZ0111IrmDSG/X0TnuGa2J3NesF7sHyf7QelM9ibloRrNHAe0cHnOlZABocJp0tcJQ77CmPa4EptrBImm2p5zhF0r69kY751tnW5UixBON6hVQiKHhV5qOWLbOQ7nMYDoU/HTHJRoK9rdxGbFGmToiTnM9qInaSB1ykmiiV1Ivp+OnckvSUoKTnawKSs3DLJ2lwBLUCFkv6+JwdHbow6y1QKbYMDDeocga9OcvBXfUkADd4o8AQjgCF03dQaLS/NRKOAAIj+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39840400004)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4326008)(8676002)(8936002)(54906003)(5660300002)(41300700001)(6916009)(66556008)(66476007)(66946007)(316002)(7416002)(6666004)(478600001)(6486002)(2906002)(44832011)(6506007)(2616005)(26005)(6512007)(36756003)(86362001)(38100700002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?I8e7XV66QpDn6CnZd8podAfogLl6qhSx93IFrYBU9TvKEh6hJDhBk7xn5T?=
 =?iso-8859-1?Q?OBT2HmgPaStUd6FPDe4sNqDlVaRHY+GPJ4PzN21Qgf8B1veKnrokQciDOH?=
 =?iso-8859-1?Q?jP7I2i4sXFzn2iY93dOW8YG2ut1hxd/Q5p09onLIh0UnnmHUK0t4JlDEnY?=
 =?iso-8859-1?Q?d2bXtyzAjudAy8pTIlHkNtckAwy/hcbINLel+arrbIBk0oJEmWdngCO+cl?=
 =?iso-8859-1?Q?wtgp5KUWzDUaKKxqQLO61vxHGYw0AiBpHYGj2RQ8bV2YbSKmVhu35s6g0h?=
 =?iso-8859-1?Q?w94jh+Mrbuw+MZoVJ6F0Gpk604JpHVrRs/LT5/8qm5aZl4GXNsz1hnu4jg?=
 =?iso-8859-1?Q?eRN0H3snPFozE/tFacKXXoN+i8WFwsqQxeNmrJSUjDWhPSXW//wQpqDK/3?=
 =?iso-8859-1?Q?boC84wxVbStH7r2dVcKZ1Q26NQXqeK+AvXN4/R6wQUiB2nofcofRrkjYPl?=
 =?iso-8859-1?Q?ifGvQSZ1kWmnL6dwXYcNwt1lThH2NNOtq087BpMXUihtg26mll4uHstjx3?=
 =?iso-8859-1?Q?GHgCN3sCm/X9zxu60rB5X5GEZP+hY8tepcLiyjGa0bsxK7zqYY/DzCG+Bf?=
 =?iso-8859-1?Q?lOoxg47q5UDhdW21PA2uco7uLwkoRm8Vu5Xq7luZMRtOVbi0NW5ODVhfS5?=
 =?iso-8859-1?Q?ahLtfMfHVcewwEb9X8NSFiLwZK4ODV/PdBPnGK3NTejkx5iW3AwBvHKwTE?=
 =?iso-8859-1?Q?RwwhbbEFYPFU4iQ2DrBIlrK/yvuwg+s8LWkQcFoKIifyUMo8aygKe0DovH?=
 =?iso-8859-1?Q?IfGqoHEnXYGC9rAZpawg4LwxgL2UFFf1RUW2/ilvBk/K/KMNGcdIplM1Bp?=
 =?iso-8859-1?Q?6WFUFYxmfv8BplO+PGELmAwG9XG0M3we2G+GiQ0SIkJKRlrpaUgRaQczqA?=
 =?iso-8859-1?Q?k+48RIepLFvH1fRRPEGaCqejrhmamVRcNokGfUwKHX/d30HhHgIducVhp3?=
 =?iso-8859-1?Q?OxRgZc7dxJl5b00CioJ6r6X7G8aETgPAsEBQa3laxJUevf4fda6CXyefLy?=
 =?iso-8859-1?Q?E52O4pd4k45C7b6HwqgHzl5GCnF74OQwgAnW97OszRsge+oGQcIqh7/Gs4?=
 =?iso-8859-1?Q?vFD13GOrbPA//hVqv0nLebDnEFVEx3jbHeX5Gn9J8z0y9Bhn8MHAH716FO?=
 =?iso-8859-1?Q?MupNROneqbgrXf+AtNYhnadSILZn5itgk9Ba7rPwuXt0BLT/60XaCc1EoF?=
 =?iso-8859-1?Q?Lf0Avqeur78qxLOzYdPuhzNOCR9A7++1l8m16mtIPiV3gkIso3Ggk/ZrvK?=
 =?iso-8859-1?Q?TTGq0GS1xj+vpkb2JJorLxw9sW0X3eGYmgaGKKZTSRArGMKP/LCZD3uHPe?=
 =?iso-8859-1?Q?c4eDPPIqNHUPLklHFLUyrxYI5ywYMLHfTibfGPw6opnKniB0TPr115v99h?=
 =?iso-8859-1?Q?5QxBUZWhjfDoUaxhMhlQR1x0KBA+QKOqmkkSR/AjHhv9IG2oAA/x4sCKJO?=
 =?iso-8859-1?Q?W9HCo/iT05KDq69mMzxzuHU4TH0yuCblR8W29i51Olka38jFj8d3h4uqui?=
 =?iso-8859-1?Q?wlMHMJEUrxw+uTsiDt8oVvZcJnrEFqaIx8oQeVxs6yDU+HWTHojur9pNbS?=
 =?iso-8859-1?Q?FD1wpUTKXrLOgHcZJFHuygsJhcvgnlG0wzOEVvf/ilmROSPLi2eQTiI0y3?=
 =?iso-8859-1?Q?NhlUeAnMnGseRRYzDPhgg3Fw9PfjB5YjJBzROj5+mAhzK1Qe+wsyTKNA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03813ef-1ccc-429a-b613-08dbda3285bc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:57:53.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGk/6vfBSBH49LQchJG/LvwOQczIsJYqcpJFXwO2iHGscCm1KyRn2JSWaSE/7iXnFvutCiLPLfP2AP6RNbr2rZW6XEj8TrwE4PgiL4PaWls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6743
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 12:22:16PM -0400, Johannes Weiner wrote:
> On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:
> > 
> > Well, I am not convinced about that TBH. Sure it is probably a good fit
> > for this specific CXL usecase but it just doesn't fit into many others I
> > can think of - e.g. proportional use of those tiers based on the
> > workload - you get what you pay for.
> > 
> > Is there any specific reason for not having a new interleave interface
> > which defines weights for the nodemask? Is this because the policy
> > itself is very dynamic or is this more driven by simplicity of use?
> 
> A downside of *requiring* weights to be paired with the mempolicy is
> that it's then the application that would have to figure out the
> weights dynamically, instead of having a static host configuration. A
> policy of "I want to be spread for optimal bus bandwidth" translates
> between different hardware configurations, but optimal weights will
> vary depending on the type of machine a job runs on.
> 
> That doesn't mean there couldn't be usecases for having weights as
> policy as well in other scenarios, like you allude to above. It's just
> so far such usecases haven't really materialized or spelled out
> concretely. Maybe we just want both - a global default, and the
> ability to override it locally. Could you elaborate on the 'get what
> you pay for' usecase you mentioned?

I've been considering "por qué no los dos" for some time.  Already have
the code for both, just need to clean up the original RFC.
