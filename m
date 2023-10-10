Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1587C61FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376605AbjJLArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjJLArh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:47:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0B19D;
        Wed, 11 Oct 2023 17:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX7wy00AjelhATiKgunOO369ymqpCAY30pielvB2fQbiPektN3JyMCVJaRIiNcNmX0JuPUpYLKxqLrCNdON/C7bNXSOErbG4/3mo2+o20/mq0l5d3Ivw5SEVEb10oEa9swV21tOfqBMgeIo5mfhToZrP+uOfFYvmRHGIVrN31WQLBO+8MV5755+uX9mYtuTrQMXXVmdwpHI7/GS+YUZtsWs4LiCvgVcVJK5W+gSVqGDJ9IIL2lpQjVyc6/C74jq5ViAIaPbwHSzdOz2pafJvS+xnjZn1EDC9r5N3Z+2W15cruubyKDig2vJQzXFlg29e2pPilCztz1vuPw40A0fMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6LcXIg+/Qz3VTLav/12jbPPYdmzoBTF06TPH7+FA+8=;
 b=lvIKP1w76D/yEXChF514ohD2mWcp68lAJ6/tO+TunSXoih/+uTkmTEDxS6D1NvEeOsA2VlZdM3jin+VMc7RWMhLUFFNtMV0/vRSJPpPVOB/Czfispkc+kFSHCtzFiRZtV4Bv5zeQihjJDwW5ueAzuWvWx3+ZSTUf6crDwocuCODOxIFQI9zZNHCFk4TopVAXTd5u42lse8hgd9jr4lrKrE6F8Dn+qxjNRrSwEGezW3voerPa4BgxzmSS2bxwWFIkNF6hCSK++W5E5ZnJ61JX091/C9N8v3v3dtMw/rgroVMt7ynk5vr6lL+mLYc1Eh+jumclzeJSaT2g+N78/9R+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6LcXIg+/Qz3VTLav/12jbPPYdmzoBTF06TPH7+FA+8=;
 b=gFyGB4RrVexbT3tamvVOEGP6LVF4yBeC015Ckg8JcZe/3OK/V22qE21vLMFSYfvvwxCjobsmxvqGfCuHf/r5Lw1CUeohiEUala/vWfFtqRE6GexOW9QNs1zpxKBNALozkAo/6bQNaAVvAPIz9NYopPQvgG3v6tY53D5J0J4GhEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB5926.namprd17.prod.outlook.com (2603:10b6:303:1b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Thu, 12 Oct
 2023 00:47:33 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 00:47:33 +0000
Date:   Mon, 9 Oct 2023 21:07:08 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com,
        ying.huang@intel.com
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted
 interleaving
Message-ID: <ZSSjvLXozGRVWKm+@memverge.com>
References: <20231009204259.875232-1-gregory.price@memverge.com>
 <ZScQVjDzu0ttYPwC@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZScQVjDzu0ttYPwC@casper.infradead.org>
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c876c9-855b-4da4-c9d4-08dbcabcd1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCiiYKd6Fa4+TLSw0XS56uWO2fkR7bgLdav61iDiYsfdvsyuuPMk1QAb9NJ52cgPyInzJVLeGVBdxXYpNbQYblPtGLzIymVh8XUZKURzn/VyNJfLFqc0YI428McECWi57U5qFVFC32YMKbL6LrlCw6loUUm9wlmLqQgDOzdZEgiTPdRGdX0eRN8+CYyBsYCd3mw7oIEdkXJIcgiwmB02iOXS0SWY0ZRiyo4ttHi6dEuBUCvpNMYFTU7EJ2c0TrtYUSyrsOQ5B7sufUsie2Nbf+zq95GGiLYf6zE31AzphIeyYxu9EAbM2vq2yxJdAkquSIaRDOlvj1ZrHSqhUFS17NyV+vzq8e3Hj5QdodXSf1wIO6WzsLDPl2rKeaRy1+qJcThKAfTQ/8krgC+e/nKV/aywpyKgVYKeQ4RQd8htKPE2UbbewP4/OYFVamR9Jww86k75e1vd3BmJrKNVIgB/lerHqJaBfWduB5Zq2kDvKmJdPEPrASK/sIKu13MPgOjv0W0tWMWZV9JLuJ/jd0WGdUfqUs+nNef3piTQZMl3t90NwOuocW2Rdj3ZedUtaSTlxErw+QAhXgYi5UuE3uPvq1CG0iJDB34H1wP1gDXXRNVJHCAcqNb+IhZkWC872crn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39850400004)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(83380400001)(2616005)(66556008)(66476007)(6506007)(26005)(316002)(6916009)(8936002)(4326008)(6486002)(41300700001)(2906002)(4744005)(6666004)(6512007)(44832011)(478600001)(5660300002)(8676002)(38100700002)(86362001)(66946007)(36756003)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqkpjpLL+YjN8KfpoQg1fwCA2ik1WBeFj/0wiVq1NqzeqdY9xQlpjwrxnG1o?=
 =?us-ascii?Q?GF6Erx00904nHe9ioP0gLOdPeqdHvBq3CG7WnvakOKA2UkTUXy7FHB+p/IUx?=
 =?us-ascii?Q?ri2+PFQnPKMJqZ57EhgSQKGMohOJubPc4XXYGIzyYbPctWihniP8yE2WN8WV?=
 =?us-ascii?Q?tiqrEpfM2OyfiObvTsr4sli7QsQq4ukCcWeVTNDlySQL5t3L63hpCVCKHnqj?=
 =?us-ascii?Q?sTo1HvJu92GVFEfVojVaQuQfW3X0d1aDNv0fT5nylbbtmiHgKm72yIuvEHXG?=
 =?us-ascii?Q?aTt6BIFggH5Qj6b6BBZJgGkDo31cQ9TZMvGgEJh4EP8NDrbmzCuntrB7cvim?=
 =?us-ascii?Q?Pcsjjhyyo7frVDU5bjWfIp84a0lX6/eqAPcnrzEPk9SZod+Bxl3Gvknk8f9U?=
 =?us-ascii?Q?+UpPydP8d0DgxCBx9qta2ClJTYAAZJT12SMv/Y1x9UgJ1a2iy2VZVNAZa3rT?=
 =?us-ascii?Q?UYkskhiFouZ8khqm6SI5J2PLDxw3j25MW4iRe49S1XV4GpXXlSF7i8mmlN08?=
 =?us-ascii?Q?+feIURvPDHmRvNIPODoy0kRDQQpYm26941N65B2oWGaiPFciYBp8Dk7UTy36?=
 =?us-ascii?Q?EqWnzqwr6PU9Y0qyEIoQWGQPNamv+/hRxC6AA3b2Xj7H/OQPx5m3prAQckK1?=
 =?us-ascii?Q?i1nIRV1ojrC4v2e2fhBwI5KtGiPtHMzswql2gPfrGS3AREmSCE5uVkpZfpfb?=
 =?us-ascii?Q?p+N5mU2Lx8xBQkiCns8robzhk0nUK++6fRjx6CjWHIcKm3lN8V/SANRdFEqv?=
 =?us-ascii?Q?xzQR/c3zkJffi33aOi4lqBeGVckj8vjOXsRTmbZTQlK6nMUgfOXQAzZ5in2c?=
 =?us-ascii?Q?265GlNZaA49buAFrDucnJO2THzsLX/rNLPRtIHOzFhFzTm9Hi+io6mXCPu1R?=
 =?us-ascii?Q?2C4e1dIO8YwQRu8RjkUFdAbSKXTpQ5x+jvdf6fTimomZCePzJC4tD7PWIbDg?=
 =?us-ascii?Q?Yx/rhAt2frjvDxVW+HzjX/0/83D5vz8KQsNDbagnwYnZw3zCxlfp8b+4HE/3?=
 =?us-ascii?Q?KAouY1BX9o74bctUzNNJt79R21Xe0lSoe/5u2cPsGUYcIp2btHTv59gVrg+0?=
 =?us-ascii?Q?DXnRVpdMGckZvn2yBuQ6vw9sRaRdNj53KPPwbppLHVq36CVsOBhScUHTQz5i?=
 =?us-ascii?Q?fiCf2uCT3v74waxsdUhkqkIEAvy+3Yg0vkR8aGkScmqtWmllFXUiYONqLb31?=
 =?us-ascii?Q?oj43AnE7/2O6x0posEYSmTHY29RJ0mhyp4QKsm2EBQMMS4x+wnVu4yVPqmd4?=
 =?us-ascii?Q?L7T3yltKrrKkutgVGfgACrRgXhPB13dFrxpgjEcx1KWeGk3bl+LZ+YYJAVqn?=
 =?us-ascii?Q?cVJ7vOk6HdbPVT4XWqoo/hD0/B/MvRUd1oN0keCqKdMafIsLTJ5doofBN4Sm?=
 =?us-ascii?Q?fRicM+9uRedM3EvCR/9IkKWQhhIxiTECZ9TEAwqdapk+TOK97XIqU/NpP+SG?=
 =?us-ascii?Q?xZiXyYEwHWiI5FxDWt9pAFKcToC1LY/kZ+fUh3CTV7HSMo6jMYjZvfhDmvIU?=
 =?us-ascii?Q?WrLNvFlMlxhVIjk3vJPO+0EBNFm1xTZn9sEytqUjXIXLGxwkPB+V8AW7M60K?=
 =?us-ascii?Q?Z76anFpxsF7cayAzjblW9bbVNZLnv0Vg3vfSH/f8CQLaGB/XYgyS/kmVy4yw?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c876c9-855b-4da4-c9d4-08dbcabcd1e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 00:47:32.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5pstMBzTWZ7nsgJCy2dn6orQDPxjC0am7k4Zw3bqJ0wQfzeuV5W4NILJ3GVJx4xJ3a2/TZCKTmsdXqe36BZ+owl31M28hKtIS9aFAE62lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5926
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:15:02PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 09, 2023 at 04:42:56PM -0400, Gregory Price wrote:
> > == Mutex to Semaphore change:
> > 
> > The memory tiering subsystem is extended in this patch set to have
> > externally available information (weights), and therefore additional
> > controls need to be added to ensure values are not changed (or tiers
> > changed/added/removed) during various calculations.
> > 
> > Since it is expected that many threads will be accessing this data
> > during allocations, a mutex is not appropriate.
> > 
> > Since write-updates (weight changes, hotplug events) are rare events,
> > a simple rw semaphore is sufficient.
> 
> Given how you're using it, wouldn't the existing RCU mechanism be
> better than converting this to an rwsem?
> 

... yes, and a smarter person would have just done that first :P

derp derp, thanks, I'll update.

~Gregory
