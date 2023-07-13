Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD57525AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjGMOyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjGMOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:54:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21919A6;
        Thu, 13 Jul 2023 07:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWIU7QwuEgMDN+MWM1OlPiK2mXp7PDp4VlK3eoLjfvwHcpii6MYVOYwFY/n0S/9O1Adk//pF17M0GbTzV+J4YAAQ4/7M40pjoMpCgnUdkDAO1aOfFCqX135dXUAcbBeNmbcVLnqcNS5Tw2z7VTCMxf9ZBDtE3gSQnuSSyVG+4XFCHRkoEceELIVxKcx7+1/Inkf0wzymCQtNkVwSb/PZGPKupOD/ZI6aJujwjbydASQUwtrhcYAM4NbK87T3SN+Lj9H952mUwY+QXgEo2V6MJRwzHrXhmzc7xm0jHTrL6qfbne/2FyM9nt8r+0wDrUQcDhYUUoy+zTr+o6IC943uLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMA2iJih2x5vh0owzdOLHipzoGdROmEj0gp6IHU4vfo=;
 b=NludfD+bjlotHivmV1C4DMnt/VgtQwVMH6Fnr4Hm7sTyhb6kgPNwYWPfKfcs5AImfeKcAvB18DtuNjtxiMJYK54MT/GmbsdkAwAeOa/k8X8cDK+2WR5Qh567CCLAao3g/sHrh6h/dYiXVwOL3FBewxD8S4ut7yjNdZUh73On6Ummp4spiautaCWDb3yxNuWrBf6xf9rDQLtc6x/sY7zqWgd3R4uwbF967WQUknF9ssSzjfVT+OewcX6BrlcX61dKYtfNkSijHfdR3kYxDV0TNU/SiwZkozqAjmNtIH9u0IihzLgQjcdINUyz2fh+5FtbmF8N1C8+RuZfNz6iKuluSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMA2iJih2x5vh0owzdOLHipzoGdROmEj0gp6IHU4vfo=;
 b=DGlrRnDvwKb4tGB3Ux0u9e+fKCtzISVb4ArilzP4WM/eu1uzM+m8oWA1IVN1owiWnN8urGHeU+V0MTEgtSYIsjxzJou2Qd8NLQyg5zV5QV6HlXsJf+65dQ0c4tvwgcBCtLQnoE0VSuMz6tBkKq6IjeenaKr+qCnaZFkMvJVf8Sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3712.namprd13.prod.outlook.com (2603:10b6:208:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 14:54:08 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 14:54:08 +0000
Date:   Thu, 13 Jul 2023 15:54:01 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc:     mani@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_clew@quicinc.com
Subject: Re: [PATCH net-next 1/3] net: qrtr: ns: Change servers radix tree to
 xarray
Message-ID: <ZLAQCTcRd2uoHE9i@corigine.com>
References: <20230712112631.3461793-1-quic_viswanat@quicinc.com>
 <20230712112631.3461793-2-quic_viswanat@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712112631.3461793-2-quic_viswanat@quicinc.com>
X-ClientProxiedBy: LO0P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3712:EE_
X-MS-Office365-Filtering-Correlation-Id: 6467e5b2-ebc0-40d5-e5fc-08db83b1026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEnoAOEugEPY8JuYM5GNDmNf7/LotPaEQnrxI8PtfI4PkbeLlGWhZzvgD3LiJWcL5f3D6cFkl5Dy2S/d4W/Xf4+UJWy4X8Z5sLlYQSw57vveS5pEvxGQI4ZwMcle9eOs+BZO5YA+FIMGpqBGBjIwabGUPI+aR3Zgz6aQTdTpqv3HEYUGyrzJNZtYT8IBWdh0PA+uZNKzRuV+fSmRJ8XV9SSJI+P9rnU8pQn+GnUqSkc+1eFzcOId/ddUM8pp0yIGFBNuINNkDw0PeA4/esgIuSZkHqv+CtwtT45VNuEYwGxn+foRJX7Kq+dUm3P78nZhThSzC4hGD66UXq6zV4uvXmhlCNL1r6zI0C06DcofGJiooV6t67JrXZlsxZBruAUPh+qKYXuF77v3ZjLiPuPKH8JFDMVGCzNisNiXGNIxrqZUPIhuON5OyS6NWopWYAaPDn/QOk0WjHaopVLK/2ARDcBETdRyR2udvCJlS7WSUiZwZIQa2nXcyEdhmozORjzPcyP3LNUh+HY763LpxKXFO1djMnpt5iG212fgEpHSipzvniqmT3dEHs9mkedMruted+ycX7/JvnQ3D4xMkPBGjmsJE84d9/jibWsBqZ3R6+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(366004)(136003)(396003)(346002)(451199021)(66946007)(6916009)(66556008)(4326008)(66476007)(478600001)(86362001)(6506007)(26005)(186003)(36756003)(6666004)(6512007)(6486002)(83380400001)(2616005)(38100700002)(41300700001)(7416002)(44832011)(8676002)(8936002)(5660300002)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+hKmlypyXsSsNnpIEAh5tRWxt00N7iSPWXC9HngCDA4jNi+gC/f07HeZK3w?=
 =?us-ascii?Q?gDVV6Uc4cGDVpdYGnInPTNVxDAFQ+Cqq0OTKneYiBFxMSTWBsrDFCqK0BhNR?=
 =?us-ascii?Q?WT2mgPM+ECWjYOSORxwBd89XJ8lIkR3f1LMcaGXACJhc1nyRskjHJyV5WYcG?=
 =?us-ascii?Q?axpzUJkWa4Lm0Lt4+oO6P8JoZ21buo4iIBCIDlT9qZ9PES9CGYqncEB+bmZt?=
 =?us-ascii?Q?rJMq1T3Ejd5ppEvLu4huxlxDsF66pj/6z7LNQupCjePh/X4DGeAQtkZrsed7?=
 =?us-ascii?Q?qHBuEs59CmszXfnjq5SUVN8acQLxe10ERr9h8JvAXdOlmZT0DqMbyTf8/IGR?=
 =?us-ascii?Q?Uq191fNg1x6dteyX+SlDBAzDVE6DFZ7vKAQKEj7OCkMKW2TWq1AfrUZXHPf4?=
 =?us-ascii?Q?wpB2s2MvmaU9dkXVAU+6CSAuP+57ZJqX0sR/NaZmoAdsX/LilqdPVUEPAs53?=
 =?us-ascii?Q?Yp7gDVTsyKX41BK9a0hRAoWi6f3FMXcPTj1hAdpeDSX0C3rnsQLNy2BCAB7G?=
 =?us-ascii?Q?NhOHIc/nmekdBhciKDjv7jRuzFwHt1/EyZD1k1+cJ4OF+7Ae2p7ALnOuhb25?=
 =?us-ascii?Q?7URr7DrMGoRHPHppfW3uHSQCfu+4NJ5+EO5IIXLbyO7Fv8cegX2ouyrbFG5E?=
 =?us-ascii?Q?MJONxw+os5CQ6zhE1zJ7Vmm1oekNbVvE8DZCSjXV1gz3gEZ+9HrzbeK0sF2z?=
 =?us-ascii?Q?Kmmg73WXCf9VHWhdX0oVfdmZCLAOmBr+HV2Qjua0uRC10j0WY34oVO369mSJ?=
 =?us-ascii?Q?/2kZVJoAptEaohjecrOg5kMq6TjmxkqW3/TzFaPhx5bN4rCsfea9fTFpu3Qo?=
 =?us-ascii?Q?2HijljMV7J51tQtKXHROkf13JJSp7vb4CP3elYW2JaJMms/vf95/3tzPiuAk?=
 =?us-ascii?Q?ZiehTKmv1SDRSfG9gn3T1LLRW9+rmnArJe4SK4gZBVZT25flT0DwpK729QHS?=
 =?us-ascii?Q?cQekGVX8mir0I0GtDRrVMTcgmtpl1LVzgXblg8pVn7AtP0bDiz/sFw8SPsAZ?=
 =?us-ascii?Q?y7ilDhR+3IxBfaSunwgHnjaNtJ14o9BspmIIIL9ISAIHd9ev+TN7mlXVzwE1?=
 =?us-ascii?Q?byh7IN15oYqDFgIv7MlrunX9Zz9Wg7Icc+G/312Nx/bCHFlDG/9VrFQ9azTh?=
 =?us-ascii?Q?KWxPKtD9HOy5vTbsUKjdeWDOQxVubPnbnZKPlwBUYBZHPEK6xkFIQzeiN+c0?=
 =?us-ascii?Q?7RhATcWWxxg+Uk1NiEHT+BZZRSkuMW+5UF5FTJMGwGp5tgKDGDKpD6WRuiNN?=
 =?us-ascii?Q?V4ibXkNnZ5LnAKrVLHTmvZK1N7slxPYpht3zfcUxeuY/JGFaxsnVlHFW4AFt?=
 =?us-ascii?Q?AJVyP5ARjnPtq2KiLokOlA07VwolSk03O5WF9qwLxXa1rkKAGQidYxWpJbv8?=
 =?us-ascii?Q?m+Bn8Na5/Qxnh4zAeVYE6IV3/Y43JQnDRKYoedE/U1Duj3DKABeJwO4SuLfj?=
 =?us-ascii?Q?90w85gVjxU4C/26MWo5fEi6ta+1fyeMoX/95ZgKZfW7vgZuMV+R8roHLJFNh?=
 =?us-ascii?Q?9pVb8YIU6HZbgRFjqLsDgRirKg0Qkfin81La2TZFBx8cUA/E7DSa05pS5mD5?=
 =?us-ascii?Q?zORL7X+U3+B9VnHN0Jxh935LDjArUrh75stg/EvJOczvkla9Zup9j7OLT4Pi?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6467e5b2-ebc0-40d5-e5fc-08db83b1026f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:54:07.9890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10iIkQgVb9VADuaweSy6g5wYDAT3dwMOUG93QQGwKnEHg4CopnJJQfltfRy1PQ3cL9GH+cJLcGO40bieVndLMmpV4/6nZtPaWFbaqgOMWfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3712
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:56:29PM +0530, Vignesh Viswanathan wrote:
> There is a use after free scenario while iterating through the servers
> radix tree despite the ns being a single threaded process. This can
> happen when the radix tree APIs are not synchronized with the
> rcu_read_lock() APIs.
> 
> Convert the radix tree for servers to xarray to take advantage of the
> built in rcu lock usage provided by xarray.
> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

A few very minor nits below.

...

> @@ -256,14 +240,17 @@ static struct qrtr_server *server_add(unsigned int service,
>  		goto err;
>  
>  	/* Delete the old server on the same port */
> -	old = radix_tree_lookup(&node->servers, port);
> +	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
>  	if (old) {
> -		radix_tree_delete(&node->servers, port);
> -		kfree(old);
> +		if (xa_is_err(old)) {
> +			pr_err("failed to add server [0x%x:0x%x] ret:%d\n",
> +				srv->service, srv->instance, xa_err(old));

The indentation of the line above is not correct.
It should be:

			pr_err("failed to add server [0x%x:0x%x] ret:%d\n",
			       srv->service, srv->instance, xa_err(old));

> +			goto err;
> +		} else {
> +			kfree(old);
> +		}
>  	}
>  
> -	radix_tree_insert(&node->servers, port, srv);
> -
>  	trace_qrtr_ns_server_add(srv->service, srv->instance,
>  				 srv->node, srv->port);
>  

...

> @@ -576,13 +518,12 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
>  static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
>  			       unsigned int service, unsigned int instance)
>  {
> -	struct radix_tree_iter node_iter;
>  	struct qrtr_server_filter filter;
> -	struct radix_tree_iter srv_iter;
>  	struct qrtr_lookup *lookup;
>  	struct qrtr_node *node;
> -	void __rcu **node_slot;
> -	void __rcu **srv_slot;
> +	struct qrtr_server *srv;

This breaks reverse xmas tree ordering of local variables.
The srv line should be directly above rather than below the node line.

> +	unsigned long node_idx;
> +	unsigned long srv_idx;
>  
>  	/* Accept only local observers */
>  	if (from->sq_node != qrtr_ns.local_node)

...
