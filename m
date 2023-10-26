Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12E57D88C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjJZTMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:12:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FA11A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoRzYRhrLWwhKE2obukk1MTDcpxA8yIi66ovpgfKQ/STyUgfyQWrckEExKYevZ8jV84pKD3hQySjRULB9hVrbr0gh7P3OGVtxXugbCwEltrKqbu5ckf8eB9nYWqbbB8C65vTzfHW9wFBXph04rLfCPjZWLsrinFFbbOW9OEZiq0vJU8CriHAEjk+S+euRwfHdg6Iz4/XMDNvH/tUFJMV9kpP8P3WE9qEfusb0KVbka+lcYXZ4hRHi0+7EVPUaM9CgA1P46goePnIpvBQZ5EtSLVzlkKevL6FFqrhGEWrRETqMdJQbF2noa7KIlgqzFVQcxeImb+ibS2Npd3sDnxWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sRQxJf/rdX5sUEU+OmOiAtAGTpKjNlVeBdTeMRqkAQ=;
 b=NMY8RMFFTms8k/ZB3TMixMoBbCT7zaOO5TVl8c32Rb1tvIhjfviV8kIDKrCOufI1xN13SjcFfnVv+TD53w/AIXtG6lOhpRw2c0Gu0g+UrQWRAKU5mXOSet9Y6DXTec09XZLwzbMQed4jTMADyY37yKSUIq28bj8FvqAnDP5ydzeJgDWoUCQm037gQrqjJTl4yrdxD49s695F+//1qh0+n/u/n0TVl2Jvi1zmNJZeFCM3R63doxE8coCuPIM11vvp9hCdmalCWnUagoPvBVaNfIM/ccza0jr5NGxLKmOKJIidhBMqcVvHG8+bTNF7SR4Y28TUnvwap+fJvNqahD/9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sRQxJf/rdX5sUEU+OmOiAtAGTpKjNlVeBdTeMRqkAQ=;
 b=OLCwod0ITGxMb+u/Li3+Ym9T4Fy+6yfkqCPnLJSfdET7w96jPeelmYET9NRns7d6jRaPjeuZExeSbEx5ymeo/hu6tcxdLiJsw3N2Ss+Bn8oe8NbKdhANcHpwOah7Q4MYL5BkE/7Ui6oX6QxSL1rovs69toSH9FJuIZ86dnK/xy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB5924.namprd17.prod.outlook.com (2603:10b6:8:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Thu, 26 Oct
 2023 19:12:45 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6933.014; Thu, 26 Oct 2023
 19:12:44 +0000
Date:   Thu, 26 Oct 2023 15:12:41 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        vbabka@suse.cz, naoya.horiguchi@linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kpageflags: respect folio head-page flag placement
Message-ID: <ZTq6KRn9tKp5KOJA@memverge.com>
References: <20231025201237.948993-1-gregory.price@memverge.com>
 <3ac68b3be0f62cfcd930ee84b87fbdc8244fe45e.camel@surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ac68b3be0f62cfcd930ee84b87fbdc8244fe45e.camel@surriel.com>
X-ClientProxiedBy: SJ0PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::14) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 72694037-2873-4343-5afc-08dbd657889c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //uC/2C4fSEM/6vUX729jnc0XjWGIAFJpPpi/Z2tB8Bd9lsTSINBBSz96F0qplOA+x/JycgQ1DIvKEyFm4LE+MuQ0M9mMoFP2YlDzxrEjxqK7NKk49tPWBMVhXMk8COtUCsL5T1W1ZKWLyDcbs3VGgOWHncjx17CPZDQZh1pDJXIspUC6oouPahfrrY4FWZzeV8lBQlNZmElH4fTHEQfeUDPEE4jtv4HjQnYG0rIVowoNndxu4PkccX0FV7yUhonn9Pntn2BE3Wj56ShskSflQSAj9dDGcLE2Fn52LpiVHqOC/o7KLG99bTDLEK7lic8udr5BAW0Lyfmc1jpu8UJ+WU+x6GpTsQYFqon3ZTzVcQjZ4NaxZyReM0d7qCF3xZu6JQK0yDIWeFbq3B0KJZuWeaQK8w1fwIYIbO3LPCLuv1/J8aU7resvConLOYW9EDQdzx3wuJoLK7x+LWaK+cmBtDrmZBuMtq7YzckEqkBLe27Cjk+SOWblIFbMw30pwZtj7gY9JFq/k2b7fuuhaLh/STvXAOgy8DQ3vGCzQWTDuR79/m5/a8NHc8odHffVJPR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39840400004)(346002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(8936002)(8676002)(44832011)(41300700001)(4326008)(2906002)(4001150100001)(4744005)(5660300002)(6666004)(6512007)(6506007)(36756003)(83380400001)(2616005)(38100700002)(66946007)(86362001)(6916009)(66556008)(26005)(6486002)(66476007)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?o0UG23SqoPQx1XVJP4FKAWE1KLj0rVB6JG1Tl3ZIZILp7seF1DPILk3Ty9?=
 =?iso-8859-1?Q?CZoKiX9ALDHeovWcBv8kOm0mY6cWjDZVcheunhUeXTRrkypQj8o/EA6crL?=
 =?iso-8859-1?Q?FOA7p/lKx+2gHQb8zRnBHwzE4OofH/ksd0KQzSr/cdzV/63LW51Og72E5A?=
 =?iso-8859-1?Q?4zdgdi9OCPM4nU0RstaTuqMxKoPW+Cy3OmZXx8OZJM1rvYpk13ivy/se0E?=
 =?iso-8859-1?Q?KtF8Yhe8X/ITvdCsS4bKa3R3UKo2FTQgY1jp1CP/UFe3A5nAHaBFwoFqKp?=
 =?iso-8859-1?Q?CiaGlRdpS9ibdKObUq7RBmARJQsGmb9oofdoWkmGXcEqyYOaFy/Lx0pKBK?=
 =?iso-8859-1?Q?lVtpmJkbtHCIlXS0gfo/AURXDu/pD2NDzZ5+0B7FZBUJglZL9jldiCkPAE?=
 =?iso-8859-1?Q?k8fQp46I+kTuHWAK/jTKaDOXomuoRWo/KlVD6M51NKK149FD+uSJOrCwql?=
 =?iso-8859-1?Q?l6keI/0HMouZ1ZVt2uPwnz2ZRdjJL7q7eIp2n9aNlVV008F/X9tVn1CmWR?=
 =?iso-8859-1?Q?pbf6rj8i2poiCRU9ErxwIKtH+UJcI3hJT3Ya/nFpsmT0QH9H0xTVZhM8Ss?=
 =?iso-8859-1?Q?e5ye7eIVHojJGmqFuw+U+hsN3bpw5bfUgMbtKS0fpjr7MW0FvzD7T+imSS?=
 =?iso-8859-1?Q?jtC5QSqr6svr/eyu37opuZQ29YHAxQh0y6bac/ny0sTD/j5XsiN2ENrtAM?=
 =?iso-8859-1?Q?TfIeDCDoOE6AOt5b5CZ1GOOmKwndmGSUlTogFBNh0YWxpDTwsXkXq5l2FE?=
 =?iso-8859-1?Q?3rpieyeP/k4yZsMwlTPujrBPJVYiAURRrYuWIrqcDVCkkbKynOQuG6Cw+z?=
 =?iso-8859-1?Q?Zm+elfAcJukBoESOTjGAFLUdoxk+mUz6uU3cBH7JP2jnI1+yiKdv/2Q/P7?=
 =?iso-8859-1?Q?iAOok4HgQRTzUIlCIM6+B6YxKBNoQ0cbcUfyGkgn0C4n/IZZXakQvBoV4U?=
 =?iso-8859-1?Q?24+aZICKiC8gsC1BgeooIMs6bkX0bpXtMJwZNJ+4SehKiEt2mt0KmJCDJa?=
 =?iso-8859-1?Q?0ADGqC6bfaykjz3V8oOt/k1w2wpV4UQpJD9ZA8vfwHLogUdsVylCaft7KY?=
 =?iso-8859-1?Q?oPIMLUoggtL0J4R3Z/crH9YFTpJKmFEmU5JdhFBFf+E1oF24oRAFa2Pq49?=
 =?iso-8859-1?Q?SpsF120VX1gZZeKuNIhYcHW+igvRhf7v1K33cEQ1uHaNnWBeVyyv0BdqNu?=
 =?iso-8859-1?Q?Ytcv6zHfLTlDGQCYb2O0UvbKo5fCOUhXjoRliPDtoYal8LTkua+EeUC/NF?=
 =?iso-8859-1?Q?a86c++Kh+EGj4sjSjv2TtGdnRvuKovZFgXvQ+PjcucFpAqQcCbfDbMw/Ir?=
 =?iso-8859-1?Q?Wb9ZgfhNJCXRhRxjpBRz83DSnE5JMDFwuYxUhnQnJguZlfVFsThpX+tzUi?=
 =?iso-8859-1?Q?GVMoY1sHnY1/SSpVUhPSctmUUr51w0gMwYKMZAbQJSc/1FxQcFDzToV7dA?=
 =?iso-8859-1?Q?RKPhDlwwG+3WCYyZmiZjLXSjLxIsv8EXlyJralYW73tuSiodQcyeW8ZWx8?=
 =?iso-8859-1?Q?vXQUw2gXiHf5H7VIV4viVjWiBcjyLQxEHNwR0H9s5hhSoqlIjl14SCa1nM?=
 =?iso-8859-1?Q?FFqU9kHnS3E+bGnwsEgd+gijk8XYfgGA93gKinQITixzT9c2BY8fsCHnuK?=
 =?iso-8859-1?Q?jsMMcvVxmpaqHek20LvkJakV1MtyahrF8AsoCgBk2/tiyTIG0UoSt+Ew?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72694037-2873-4343-5afc-08dbd657889c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 19:12:44.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je808Pjl/Ty7XLRkgClvF+RpbMAGAXzp5ktgNYikvCBiuVB5BJnZiiZfHycPlBZoGTbU1GIMRDQIV2dH5ywRlvN338+CU8WEOpyaSgWmSs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB5924
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:34:15PM -0400, Rik van Riel wrote:
> On Wed, 2023-10-25 at 16:12 -0400, Gregory Price wrote:
> >         u |= kpf_copy_bit(k, KPF_SWAPBACKED,    PG_swapbacked);
> > 
> 
> Aren't PG_locked, PG_reclaim, and PG_swapbacked also maintained only on
> the folio/head?
> 
> Would it make sense to convert those over as well?
> 

I see them registered as PF_NO_TAIL in include/linux/page-flags.h

Certainly i think there are other updates that are likely needed, but
I wasn't quite sure how to handle ONLY_HEAD and NO_TAIL and other
conditionals.  Should the bits always be 0 or should it refer to HEAD?

Just not sure at the moment.

~Gregory
