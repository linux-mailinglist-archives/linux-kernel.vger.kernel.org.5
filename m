Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16B87A13E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjIOCki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjIOCkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:40:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2095.outbound.protection.outlook.com [40.107.93.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023A726AB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5AcEQAks25Xyu2g/qHVGgR9xKuDF5EYl9pRX3/ooRYQSVbgkz3nL8bnPFuvBGOW0uEixP8lVhmRBREpVAMM2RZWFiJUFQG6Do/bNPDsSeG4yPV5XC1tWBa7dYJNWBn6QIzTntHXH7fZjt2/qCpBgNmt6QmLByLZTI8ae4JoVqm1tGVww7LAwBpNktqFUG494J4ZG9WENO67y4J6urY8q6iTU23XMEl4SzXFKQcfxxp3CarFZ/9T575xw904nf3HBeNyAo9NWJDucYP0HGXHFMQxVz/UF402eGFBeQNe02Qc5um9rfembvJc4mURcJrPQAKkTRbQf88CWGvzKX/qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEAg1tDQUaAJnpY7k0n2nvYWHLiQzAvDJlUHQxkf6R4=;
 b=Pv/qovqoTIXi1Q+DpEsHB7zue/2Z5RbU0TksH8JFVDS180/EVrCni4UzvE0wK4V/7ibdaB4jBkFsSBl6cvR09rF6Je8kR9KnrRd+EGskwS+KRJTJ8C5F+hCtGajGw9qDXyKHE9b+gsAnwumvBajiS02eyQpoDW0sgqwaJkbqOIC4flZ8TQHwRAy0s7+hzWRwHUu4CYbAKA5Bp8Tuuu2N8zbSaMVCujfx7YLr/mgVP7dWiq2itaIdTZBiET5ZCbmLAjI40ZJ6VfEynRIXDa52uedVGk2iI8OlpvKJC9pmJ04eVg0q9GqzlyHOTjYhbPpqmEj29S/v19wDSS5CK0qkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEAg1tDQUaAJnpY7k0n2nvYWHLiQzAvDJlUHQxkf6R4=;
 b=S+J/rNDvNaORGIBs91P7MG4Jz4KngZHYKHIrE8mayKWvKcPVxqEZiq7zSPeo3XI7TmYUzbacXqp+IbB+tHrgkZOMIa/2QHKhL+sQf0mY062w2PkNnAHPiMwAuWoZAhpg4bZ+LQJR3Yq6PzOp2t1bM9STPVY3pwcO1u03RLts5R0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 PH0PR01MB6151.prod.exchangelabs.com (2603:10b6:510:18::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.38; Fri, 15 Sep 2023 02:40:29 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::66e5:a568:4a5b:c19a]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::66e5:a568:4a5b:c19a%6]) with mapi id 15.20.6768.036; Fri, 15 Sep 2023
 02:40:28 +0000
Date:   Thu, 14 Sep 2023 19:40:22 -0700 (PDT)
From:   "Lameter, Christopher" <cl@os.amperecomputing.com>
To:     Feng Tang <feng.tang@intel.com>
cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch 3/3] mm/slub: setup maxim per-node partial according
 to cpu numbers
In-Reply-To: <ZQKwu3TrorCvgH9b@feng-clx>
Message-ID: <21a0ba8b-bf05-0799-7c78-2a35f8c8d52a@os.amperecomputing.com>
References: <20230905141348.32946-1-feng.tang@intel.com> <20230905141348.32946-4-feng.tang@intel.com> <CAB=+i9RWVvUb5LyoTpzZ0XXWoSNxbKJuA6fynvOd4U+P5q+uaA@mail.gmail.com> <ZQKwu3TrorCvgH9b@feng-clx>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:610:b2::14) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|PH0PR01MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 619f18a9-a364-4992-c36f-08dbb5951f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31zrhD68mrY8iHCffcA+SEvMJalj9V2/gPS4NLQ+OMpDQq5j01TTBConl+r5t9p7NKdFnP/LYgZjJbP4wtph5EN+VIyWIV4w1Aw3SWrM0Cmig3Qvs+5o/IrrofXkrvkI6KPo8WgmG/oOfO99nv7dI/Z63ixR6CyLZnVfzR5n7MXh64ctdF8nrioWppGd0zJTShEv1uwkWjZuNWDcQUuS836L8Swxft5pPRF97GG+jtXyBQH6hmxv4lXalFYCFcZjPCQDuCZuQ3197pAgJDZyFdLVE5D7WIy07UIuMrfjAX4k+UXRFU0Tc6hwA7QYQwG8UMVsD923txPgbdc5xBTjSEixLcPcWSjjoKnO8E4RKOYIhLhtW+6Y548bABjOxNurep+wV2WufsLDLmYknbHBYL6gcJliCHUabWpRBZwPOFVkSkjO8O36kepyl8f+i2QOBiwHT7ttyRsODLS3vZX7CUiZgZEEhf7ih0e1s/+lwY8SDt+YuHRX5vlVfBmI7Gr4lnxWpYtvcbXj6B8czKxOZZWVLsxDHbXvjJ+8yafxpD7fLZBXfQAGmVTSQ5v3BiIt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39850400004)(366004)(396003)(1800799009)(186009)(451199024)(5660300002)(478600001)(41300700001)(316002)(8936002)(8676002)(2616005)(26005)(86362001)(31696002)(4326008)(6916009)(54906003)(83380400001)(31686004)(2906002)(4744005)(7416002)(38100700002)(6506007)(6512007)(6486002)(66556008)(66476007)(66946007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YBhbxfNllOxrpOmVV2zDpO0QEBvSowThon2dor67Lr0aT58GcF6WJFhMwinI?=
 =?us-ascii?Q?f2DGONJFOacBaN/u9FTC7ilyGH5uMbfqh1h/WlcZNRzrpqYkjqxtNsgP1UFM?=
 =?us-ascii?Q?aub7HWPz6bskIsioUe9nkCDjVMwpBe0JU3qYyIoxzSQP+lbL/MoRPYeJCzxH?=
 =?us-ascii?Q?K76Qr+7amvGedSYFp3Bvjtbx/GvvA1hNVXITk0aYh2BPyd0aJz7OgTuvSGul?=
 =?us-ascii?Q?j5XC72RnIoD66XvRm4BnMZ5D8RLjp8cL0Ol/AeMxiPdmsSe5Qp14GWy2iwwv?=
 =?us-ascii?Q?mfQXFsmtUFgzNR3gUJiapPCZk/5YiSmt5KjL7EcRdmmfSYQ1JK+ZDad/IGOP?=
 =?us-ascii?Q?b1PjDKnzH/j/z5+ei4tbfOes2fJHcgWaE/wJgIUugDKITpIkyzCVrM3bx/y7?=
 =?us-ascii?Q?uTu0PgQ5xWrBejcJZrYm8PA80XnaSxSS74POCgmvlD4LlX86y7v2h109JqJA?=
 =?us-ascii?Q?L305X1wNZYQmUhBm/82YtuJWRdsmbIiW75j40qlv+2tFHhuyngCSb376HgMI?=
 =?us-ascii?Q?3eJ47hb0GZ6P7fIK/lQrM6UxXB8JnjeThed5O5KxD8npsvpbO+sOTX3uFlQk?=
 =?us-ascii?Q?+mSKxkfuhl8/aVqPRnbUKFT94pkI08sKPGd6W4KRfZT1Prvn0UV4k4Enn1L4?=
 =?us-ascii?Q?ctt50fohwn/rpqRGbp1Uj2073mO3ce3vJCnWgNB9uIVmmws/75wFx6PE7XO/?=
 =?us-ascii?Q?qBsdCRjyBbI3ZJbdCnDHqDrbmdt0Zi+8BiatXczxjH2t+WQ9TrdJlB7sjSWM?=
 =?us-ascii?Q?98NYxrjGGlI0P3WbxMlBZ/XpILzIlPdyaSZ7gHgzuTi9ih5JZSULD/pxobXu?=
 =?us-ascii?Q?26EsOMPW8jn+dCDTI/L6mCJ0bdBWrpnD4KMNumcKOlfYSw/rtISh3wxVS7lY?=
 =?us-ascii?Q?ts+IsPOclVSw244+pKBJ+iV69xqxzK5NPrC2P3aktbAjLzThsDo806siQ7zI?=
 =?us-ascii?Q?BLpMd98LSZ14ZtroVSAVfjDc3rMYHwU14QK6axVAV8yrdeD4fhMDa8NAMn7Z?=
 =?us-ascii?Q?epPNNPLP+QKTQGF5LONSBUsRMtP7tSYW1akd10QvglEFky4GiH9iT+sRvvG/?=
 =?us-ascii?Q?JmrSAH9MgN3Yat5PKQTMZQ4/iBDYIV7W8xvEXRYG0hLKJq2R+itFQgHKqjaa?=
 =?us-ascii?Q?W1k4VVN0wjUg+xT3c17lGULYmvAnD8ak5Yf0WlP2GKqp77eA8PhmnseNLbCs?=
 =?us-ascii?Q?0El4bF28ORFsJ9La9xk4MfbKvqcsSJ02mJCVLlVZZqYWMY/HzyAnxTgAMJek?=
 =?us-ascii?Q?xSr9BrUXvxEq7+0sbWIKyCVwpjVhV1e/llAiwfHJlu54bATJu2suT6OaPJX9?=
 =?us-ascii?Q?SpBg8GlyhMeSNfFjgt72PgMqjstOmCnxtQ4rrdmb906t+BRoxgHQLNjRnONG?=
 =?us-ascii?Q?yaqi6K1cCVMfng4O5XAk9fuUp/jyBaITKpcuICbFXgBsxJZU/aiEM7UMwN8s?=
 =?us-ascii?Q?oVdjLaxB5BJxFGYQEO//RBiLvMIorbbLQ+diOGfXUeOywn2jxIbAeL4lRpkD?=
 =?us-ascii?Q?1CevMNsBikvvleuErDdUIe9cCx6QhvrkOaAZjsHqSdtAuHYf5jSlB/GMzWw1?=
 =?us-ascii?Q?ARtPiPzo6MKYvXprngPGErLi/EEfMRQyyBKWfKQAGWTaIxa3ANknwmV5HHjr?=
 =?us-ascii?Q?CpBGQUat2vXEsRQT65Brudg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619f18a9-a364-4992-c36f-08dbb5951f39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 02:40:28.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3XddJRDRf0jPj6tA2iokEwIfZKQuT3GRKt95qNC/Nf3Z536AsN/pBPQefKXfcgpdJU8o3yyq4Rsc3FOjc5o/43okQoeyq96QJivAOxqQas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6151
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023, Feng Tang wrote:

> One reason I wanted to revisit the MIN_PARTIAL is, it was changed from
> 2 to 5 in 2007 by Christoph, in commit 76be895001f2 ("SLUB: Improve
> hackbench speed"), the system has been much huger since then.
> Currently while a per-cpu partial can already have 5 or more slabs,
> the limit for a node with possible 100+ CPU could be reconsidered.

Well the trick that I keep using in large systems with lots of memory is 
to use huge page sized page allocation. The applications on those 
already are using the same page size. Doing so usually removes a lot of 
overhead and speeds up things significantly.

Try booting with "slab_min_order=9"
