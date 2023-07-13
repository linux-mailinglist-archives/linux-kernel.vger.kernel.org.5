Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2B752129
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjGMMV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjGMMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:21:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C38272A;
        Thu, 13 Jul 2023 05:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO+tL0RH5hcsHYxjbbGJ6x1kIU1LDA80YyifalsUSjZ+cAdZGH+KldMjYYocnJUpWFD8Xhedzaly75x4WUCcB1De+ABEpq20+Df24zmTJ7AnnJ1TRUgqqo3vfKwgOPRZgL27oNo1JYBeHEth1tk4oB0hWxMGkkAOQbSFe6xW2iVOf3oFICCXChfOjHg5IDdUwR8eztozle1Gaiaxorl7poLuDUoGYZxsIpnqyERujJ62OiFY/gToX6ypJVNpuglFhvtGNFhAySKXu5qrG959LB/FDzt0eIWa1jKUalhopPiNfeIhZr8OwkJcW5kPcPG2hdq3kRDOJnf+i0tCZ/8qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANQ4C2tnrCk+CSroawOo7OH++aM+F0pp908RZsdICNA=;
 b=nfBjdTOcM1Umy/0ZwMMzCqOos9WR691vZqcLbf63r+f3w+enz5hAqG7982LJbkkQm1oZ9YaPpvQhL7V7fzNkRVY5s/7aPfZo5XSve9ZGNcySRhgPkAzenkSsrSpJ5616HrbUiRZSQYM0WeV2O8mFrWK2Xxpar58D0dIkbbSbkTqUyC99Df4xiKFC6sZzQIjhrmg8qjckAf3hfWjsbNfM0in1sg0CHMhXzAQepObfJlFAYmFUf2Y66Y31CtBMtZfvvbfGJRtGHR55udq3Z7E5mwbzRYcnifsVRsuaxhkKdU/87wNSE/2lMzr/OLalcg9zZ/XiBfhMceIMf3TT4w8GLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANQ4C2tnrCk+CSroawOo7OH++aM+F0pp908RZsdICNA=;
 b=I7Q2lo3BbAYah6K9zhl0kX7bcs3VV18J5wkxc6qHn+EHWaJyZx56oZg+sMotbXdc34qkTPhFRZD8vEv6T2ZEepp0YMAP+5mfj7Z2zU3eHSGx0Wng61vemR53kgBmErt1ZPQgvkUc6A7DlnO9hVdTNhR2IGuihA2Juny/8EpY/Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW5PR13MB5996.namprd13.prod.outlook.com (2603:10b6:303:1cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 12:20:19 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 12:20:19 +0000
Date:   Thu, 13 Jul 2023 13:20:11 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v8 2/2] net: ti:
 icssg-prueth: Add ICSSG ethernet driver
Message-ID: <ZK/r+xgo4oeCjAxw@corigine.com>
References: <20230710053550.89160-1-danishanwar@ti.com>
 <20230710053550.89160-3-danishanwar@ti.com>
 <ZK2VRYwW8DxIZCY2@corigine.com>
 <afbd4c9d-5ff7-e366-f866-6b718907d6fa@ti.com>
 <ZK+6zVnUSJG5GKd4@corigine.com>
 <b6e49136-1bad-8d32-ac6c-f9185dfaa9d3@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e49136-1bad-8d32-ac6c-f9185dfaa9d3@ti.com>
X-ClientProxiedBy: LO4P123CA0277.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::12) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW5PR13MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 750ec54c-2c19-46ab-e10b-08db839b85d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7FAYXSJ3hNC9faHBJGas4NntJoTB1zGn05sxN9SqMa7f7k3DfNzZuHcbS3JjtZ3BlxRWgNsJs7hZL2cFeXUMDoXRquenJ8u0uK1gSCCPvaJTar1M/CSelC226dLdLkUkaY++2bkFwfFajrL+p/usQPq/lfses+0aQ0SN+lC9TFcQco+lfiVD3KrvZ5S2HkKzB0jqlf9l8YNzplWTqbJ2Tw4YQjVaYtBZfkJC6SrGwm/B5OrZvWcXyNIk03wec7QsiGmBq8WvtzudNngywjulQQMPAu8WJn1bvehULUkDgxV2DHCG+BlJuv54wHfwb+NbxFaR6pZFnJ6AJvRH/B4FzhGE5aXkIYY95SyA2oPVZ+QK4L/hE42zdyH9e9TtU1BG6qbklsT99o2RBIfHA6rRJoACnZgtmTOj+Uo92jRP6NT0Kq1G8KBsZw5ylT9a6OtPVMXC47RFjCYIlPUS65DNDDTZ0vybCf2afmYnOX9xbMnrDeXcqbJjgasYaTQ22dWaJ4kHMjz7J2D2SNXUoT6+LNO1jEyYvdmNaeAeg3AkKE4GCGSJHoNyM2gQrp/Joal0vyiqRESBOjghE11RBU/2F21Sgs/GPVuWGI3pRRbto8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(136003)(366004)(346002)(376002)(451199021)(36756003)(86362001)(38100700002)(478600001)(6666004)(41300700001)(8676002)(54906003)(6486002)(6512007)(8936002)(44832011)(5660300002)(7416002)(2906002)(6916009)(4326008)(316002)(66476007)(66556008)(66946007)(2616005)(4744005)(186003)(26005)(6506007)(53546011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8n9mpeKJpC8R08Z42Otz8qpKaLBWzEkwOi/sfXBOjEcR/vQwX5dNi0TIudl?=
 =?us-ascii?Q?RaUFQbarbTdmAkOM1xbshwhDuBMG/5HovRmQ8/DqB3gWFA1LC/5oKkwEx2nZ?=
 =?us-ascii?Q?uRT1LaqABPc6Xz1b65wwe9z1q7Osx51gr/f2Z8/QkX+2pPQ5LUC24YzuHuk7?=
 =?us-ascii?Q?Lhx2TJRjeVgQfhxPqlsUBxy92++LtnXL9FR1rNh6aXRYNPoAWeEXQA2JUxbE?=
 =?us-ascii?Q?HpSk6UVh5JcyOpOekI13Ag8nCTBAY8+KPdgVJQLy8vkeGOxKE1WPl/pEwN7R?=
 =?us-ascii?Q?5ru6w8icHvAAmdpE3DYdlTXj4bOTPuqwswTCBDbo1yzdwMgdYp8kgvy5LcFm?=
 =?us-ascii?Q?AM4VWxn/CIyMuNk48ySw/h6DDbhlRnptDiFJYWW09csZ6pIqInhAEb0XoZ47?=
 =?us-ascii?Q?rbXwkGO/E9rPbocx48/Cpdt0TZyBR0qTFRazc9A7hQNM3DEMVpw6hMZ9gArn?=
 =?us-ascii?Q?7VGqfPbDkMSgarK05h66JtC4mFzLuWl4mDedXefm7bU7J1AgCaTN2XCbQhD8?=
 =?us-ascii?Q?2Vc4X9QFTtrFKHvHgDMz6fNa1+YpiOA7ggundYLRMlEabg6BZvU7JrlSqhAu?=
 =?us-ascii?Q?VIv5RzJRNNT+9FwGGsEwaAazPvby3iTgQ1EGLbHMtZ26ilooFv31XAFtHYqg?=
 =?us-ascii?Q?/+54+jGKC2ELjfR0cNkmPFwJVD+9L/pxLNx/WQQ0G7D6E/BIdVFAJTGFX1aQ?=
 =?us-ascii?Q?g/wSb93Xi6uuLaOqUNuRTyT+htapPW4PTz3jo6yz0ffQLeuVP7YfDFbpEuB0?=
 =?us-ascii?Q?kA1Pa2GkMLl/Rcp0yeGGZpGOSdbS2GyMdUkQJNqEQ/Xh7G7gKEVLtRAWMUzZ?=
 =?us-ascii?Q?chG7A3bMFJZMDLXAJsLtrELJxTK1F36QSnoL0RnES3CgwsGhS/JUqqDboJl6?=
 =?us-ascii?Q?jNPaNr40GJiwtUlxmHQ0rBQj6YtBPSLrkK6kTU0cMUWTWZlfu+7gjEe3P+8I?=
 =?us-ascii?Q?BdJMDdppNuQ86Yd8uALq3s/mEL7FXmcpunr5zIiRAtAJsV6i1iZtKAeYqchV?=
 =?us-ascii?Q?A/EJ+35uCC3LpML7w5wXl4dhPRq+yN+WocRphLLjsM7khUhJBfyajmDMp8SE?=
 =?us-ascii?Q?HP1qilap6PsW4ArAQFFYPOZO30lVNQKZhrWv58W18kavIw+45ruD67jr3wjZ?=
 =?us-ascii?Q?9810wm6Z9xmq26xLQozb+C2zTXY3HA5GNAFPFFxzv5ZwUHJW7cIJ3/JVxJfJ?=
 =?us-ascii?Q?dejAHHbiuLez0DGIbzsf52BEFdsANc6JQMhuUE72nn+ER9STWpquQJOiRN8g?=
 =?us-ascii?Q?9GeL/divTgl7NnQrOgJiDpaxOXwp3PCCZueqwMNiJhrjKJeOiuK7AUhjvAlP?=
 =?us-ascii?Q?GM7t8V3ARVI6/Gf8iRkpLJHX1WyM6eKg1xeZz8desHhvwjpb72lhKie671ZF?=
 =?us-ascii?Q?BL5WdY13+F/MgjukxQFjAwo4laOilfbxRkr9cv908v69k8PSHCa1yuXQZTBv?=
 =?us-ascii?Q?auk+ApHc7hGi8KXGkDBTAA0Bq2eJS2339NxXt9f6HDGRGEAuXLvfpJ+7lU7q?=
 =?us-ascii?Q?4ibW4HqmXLmD1oR6BtNq+uHgOkd/PLzDa7Z0AUUjILeLx8XbtCf6iJtPMrY9?=
 =?us-ascii?Q?GUaMiKHTpl5R2j8rfmNHivmEYYDtWzKjbXeoj8plUHUcFMIHctS7Eibr4/BL?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750ec54c-2c19-46ab-e10b-08db839b85d2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:20:19.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amoRQvsfVwvP9f3jZIqZjGePvTa1QO2Ewhla8nsARprPzVQXPQ+rcnmBqJoCN6G6HXyM1ivipfcHY8CeJhApL9mDTSGoWqeGHg4iPWHU8Xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5996
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danish,

On Thu, Jul 13, 2023 at 05:11:12PM +0530, Md Danish Anwar wrote:
> Hi Simon,
> 
> On 13/07/23 2:20 pm, Simon Horman wrote:
> > Hi Anwar,
> > 
> > On Wed, Jul 12, 2023 at 05:55:57PM +0530, Anwar, Md Danish wrote:
> >> Hi Simon
> >> On 7/11/2023 11:15 PM, Simon Horman wrote:
> >>> On Mon, Jul 10, 2023 at 11:05:50AM +0530, MD Danish Anwar wrote:
> >>>> From: Roger Quadros <rogerq@ti.com>

...

> >>> Smatch warns that eth0_node and eth1_node may be uninitialised here.
> >>>
> >>
> >> Sure, I will initialise eth0_node and eth1_node as NULL.
> > 
> > Thanks.
> > 
> > ...
> 
> I will fix all the sparse and smatch warning and send next revision.

Perfect, thanks!
