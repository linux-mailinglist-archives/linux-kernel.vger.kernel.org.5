Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DFC7636D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjGZMy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjGZMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:53:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2118.outbound.protection.outlook.com [40.107.93.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A22706;
        Wed, 26 Jul 2023 05:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tv//zvokgVnXCpfRLN1DXbOZmkUrnZV0FFSAS/iGDbckSG18+q6OL3ob00uank4mxLgMxo40Kn43mfPgaKmGVtG1VyHyDZi9S3MKm6dp+w5oUbKY0YRec+HqKTTzyTpINYIxVSMRWXX5aiKrgUaK4/wKxsIKAkfYaTKyNmSe7iOeYDVFxUvueVrCIgtgo1utoyKF3/FiOdyuH0fEM1qKH3gvbdpMnVnR4Jr4jtyFVs9ehjF7re/z6EFov2y5uPFDKqL1FEhqfZEuVIYLvhKu3sY7d7QSkD8fpHqBr07SevSlVzRp06EFA8CZofRuIc++SWSo0imICDHhywjDZTF4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2wtpMppcJhMiCF6gqJKYQgwn1qYj/WSVoahmv7yXHs=;
 b=LNkaydDW12cSPjlXGb1vVjnBTnv08hft6JL1+qBDQ+SwSwDy+VVF/M22ahDnWqVUGada8oaR6j4i3o7UZJ8rsab8t+uTNnqrzXzrrxnPzRvs8k0uLFYGXCL9cDPM0jhSxd8kQ5ZTHzM7Srbplxky1leApKSaipKDLrywbeEnmJ76/C3UzS1jHDxZBEZskPQwIx2FjP8fEJhRs4QCIIjRt0oJp6AafVXZwHxAXem0tSTbuJDrL6x2BpsVNUnh6ODDN0mVt6+Vik8LApGWJegRZQPYm3ulkaTdDO7efygQ+VkvMeMb9aRtnqbwuDZCmTd0tt8bsv+2dFTHTk71xzFuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2wtpMppcJhMiCF6gqJKYQgwn1qYj/WSVoahmv7yXHs=;
 b=as4eVJ+8+zidtgmgMAOBkLpJiubue1RomWPSpQ5WG/eFptRwON65roGR2cPVj/L1Ni64P74koj82yfmX+YFNNR6wWE22D0Y2yHQDCLCkrzNvtjceiuQO2L62O5k6FRgxsSrWt9lnCQWGQbTMtVauJH/1XniIQ8mnxbQEZ3XkFxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB5030.namprd13.prod.outlook.com (2603:10b6:303:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 12:53:09 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 12:53:09 +0000
Date:   Wed, 26 Jul 2023 14:53:02 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Zhu Wang <wangzhu9@huawei.com>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kaber@trash.net,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nf_conntrack: fix -Wunused-const-variable=
Message-ID: <ZMEXLp4kyQj/Yb1/@corigine.com>
References: <20230726101531.169376-1-wangzhu9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726101531.169376-1-wangzhu9@huawei.com>
X-ClientProxiedBy: AM4PR0302CA0004.eurprd03.prod.outlook.com
 (2603:10a6:205:2::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: d402cc6f-ab51-441b-58df-08db8dd74335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKvQ5DSoy1Rtlsp7HkPJwyDU9T5+Q4omDWAQezRzAIw/076ierAqa03t9BinQqLiIhOc/6Dyd9ww/zoIWM2PeoEFh1i53Z8pX0Drg2ikrT3HL0vSlyvbNgg6tOlsOyfhE9Sq0Df+mWOcKt+V6/UVSuaLvN6PkzPfTDoy8eJSIyTLcU3MaMdXjZLED23asAUDaYGsJCCPT7GT9F7d+1MNhmYJ3jiV0XItDd3v6HYQfIWTxxzO2N7riwFU0mSQNoirrqYY50Lv+mYQdcP4YaQki9V9Y7fx+VtcAKBNW02QAC1qqPUszHUnp7gSdqW/gB9pjD7rbopJtnISxO35wsOJUy+mtn/jYTFfuS8SlFJlNClf8W548D73pPxX8OIpy0w3NdwVVN/fHBpLyZ8tTBMDArLp+o9SXRn/y/v8jL/l5STKTmpVxjQlfTiJjiJrtQa5zjq7Pxodav7c1ahPMRCHWh98+IucrXa+P9YmHZ1BFsZZFMNcZF/oSodGhPKjtt/SxDGrlkYvepVGI/o4Lqcx1pIy1T7C2vyZwlr0w7b5EGwaic+JrusSK6SRLdpgwVsidZijTZBaWtLq/SsSBCMr5iPMClqyWkoZfqranGAV5QE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39850400004)(376002)(346002)(396003)(451199021)(6666004)(6486002)(478600001)(83380400001)(6506007)(6512007)(6916009)(4326008)(66476007)(66556008)(66946007)(186003)(2616005)(38100700002)(44832011)(7416002)(8676002)(8936002)(5660300002)(4744005)(316002)(41300700001)(2906002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVY1UUlHWUUvU05pOGxud0JsZStDbmxlc0RkbHA2QURLQWpZSTNKcEhXRXZz?=
 =?utf-8?B?RFZwcjBFVzR0TUUyWFluaFR0RjNhV294RFQyeWlzdlA5cVpTcTU3bFptcFRi?=
 =?utf-8?B?RmZiQlZMNUJFS3dBeFVQNTdETWIreTdtWWh6ZWpaL1VUUjRMem9TT1VwQVll?=
 =?utf-8?B?eEtNbTd0UUx1WnNld2pjZnBXY0ZuaUllSkNrUUxwdzYvRm95bk5hcDlFMTNC?=
 =?utf-8?B?QUZTL1FNdnE1VG1mNUVMYWNkYmNrSzNnTHB1WnNqaUJtNElockhwWGJaNUlq?=
 =?utf-8?B?dEwrL0hydmZzRUw4aWFrSnRsZlpNQTI0cXJQUWRaOUhBNWpkTEc2SzYrbE05?=
 =?utf-8?B?eERGOE9iV0E5VXhZOUxnV0hhTi9RbGovMlZ6a1JuU0dZS2dNQ3hOcUw0cWZ0?=
 =?utf-8?B?OGdKTlNvdjE0dTRqcG5pTm5KYmpjd1RRYkE1Z0R5REJvVVViMEo4QUFjakpK?=
 =?utf-8?B?T1RsWkJEc3hEZmlvQ2pOajlhek9PYktBYkZ3OUVKbGxDUnJCYUpXZWtnRjYw?=
 =?utf-8?B?VFFkTHV6ZitwSmVqSGV4RVppdzI0Qmx3ZGVrNTVreUFSZGpqbnlyVXlnY0dY?=
 =?utf-8?B?cGtnMk5ZNXpWUVIxSDRlZ0xDdTBDNklYejVCVDkzdW8zNnl3Y3hBSit2bUJ3?=
 =?utf-8?B?eURwZkFhbzJiWFNNUVFjSzhvdkxxdVliakZLSnBwQXFFaVViQ0lQSWo3QVFp?=
 =?utf-8?B?UEwyQjV1ZmFxK2FvdTdGNFg1eEpvQ1dJelF6eTZiWElCQmtrTElONlpPS29T?=
 =?utf-8?B?Zis2KzRlaytKNlg1dnV4eTJFQjZTOHhOY1UzdzRFUU1Ca1dYZ3BqZW4xVjZ2?=
 =?utf-8?B?R24rYWZaQ2pubVNqbFU0U3RjREpkRW9XeUJ3ZXR5aUZraEl4TEtWb2tCZFZx?=
 =?utf-8?B?ZkdzNXo1NmVxdGE1eEg3cHhKeE5tejBFTDI3anpxUkwyM3lvTmhJZUhIY0g0?=
 =?utf-8?B?dUJmdkRkMXQwR2g0c3VSNmRnN2c0R1l6SUl1QjRBMHY0SDJIazJERU5CWllD?=
 =?utf-8?B?R3d2U2ZiZHhYSXhhUlhDNlBwMXJFOUhZZUdVY09rbktteXBHSlNNV0JCS2pS?=
 =?utf-8?B?OXdBSmF4MkJTRUJEWjB6S2ZVcENJMElDY3JPZS9JdGdSZlFzQlFITE1VR3JB?=
 =?utf-8?B?dkZJa2ltUEJSOHFDZURDeEtMTGxGTi96bjNFSjNOVmF5bjBrc1A2Qm5ObERl?=
 =?utf-8?B?TVBGZVBoNXVYZEFGclgxTVo1bURVZEFucldYQ1l5ZUJUNFBKSkN3bWFoTlZM?=
 =?utf-8?B?UExROWZMeDhibFJIRWUxS3hJQituVDgxcG9JeFRudkxIbWVtUWlTbVFmZHdP?=
 =?utf-8?B?a0ZFTWRHTkFwaitsaWp2SVR2dkpHT3l0QXVEZUsxZ2pNa3FqdFhtR0Q4dkZu?=
 =?utf-8?B?Q2dhQWhEUkNsTE1RVFJ6QkdzMC84dEpobFpEc1JmZmVSVW9FZXBrMmtlV1lX?=
 =?utf-8?B?Q0xJdGtrZmpqMUhXSzZiUEo2YkhORTlCUFo3TDZXMk1VNG1QK1JXWVpROUli?=
 =?utf-8?B?U0dLNG9WL3lKL2xnYzJPSURVanl4KzhsR3BQZFVMTk1WL3dIQzZhcU1HODhC?=
 =?utf-8?B?QkNUUDkzdldEb3hBZ0lsd21BdU1mOUhnWVd6Si9mRFcxZThIM2JRdWUvaVd6?=
 =?utf-8?B?MERPaFh6TGhKeC9OOHlILzFtNyt6dTcvQnpQKzVUaGpOMktZSFB2emNXM3dB?=
 =?utf-8?B?VjdERndLQXQ1Ky8xZDBXV0RjOWFmTFI0em4zZDFJbUh4VEh4clo5Q2JzaGcy?=
 =?utf-8?B?M1FJdUF0cG1CWDJNbmh0anlvZDRVS2RWZkoyVWFqMHl6QXo1K2VBNXpFY3or?=
 =?utf-8?B?NHE4ZGdwL0tuQ1VOSlZNcVZRMlJzalpOK2lqUE9Cb3RJaXBZeXZKVkNQS1Bp?=
 =?utf-8?B?ODR4UjdTaDR6V2JxVTlCWXFmOGUvLzZza0ZGWEpPbjNKSUwzNlhHdFU3VEZJ?=
 =?utf-8?B?M0d2VCtpd2NjSVA3RXhObWVMMStSWXZFclU1bU1MeGU1ZjhVVUFjaWxjODI2?=
 =?utf-8?B?bzdzbFpZUjNqNSs3cHdKM0JERHc4bFdOWUpFbHJqUHdNT25hODczT05LMzFq?=
 =?utf-8?B?R1kyRTJaaVZicnZESzZTZURlclhIS1RBenFCeWpwNitlUFZMYmxJZlhZbDRi?=
 =?utf-8?B?d0o1N3RkUnpyaTRIcnNEbDJiQ0xNazBFSVVKeGRLVGI1SENWTE9hejJkVmd0?=
 =?utf-8?B?T2wvNDd2ci92RmpuMDVMZHh5L0xtTzh2TE55ZTVoOFlaaStvQ1NFYWRhSmFU?=
 =?utf-8?B?UlNwQ2tBVTFYOVJBTDlWalFpRzZRPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d402cc6f-ab51-441b-58df-08db8dd74335
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 12:53:08.9592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV0CxCcL8e/PGGCJNl47OBV+y9+48u/RjOFLo2kfu5tRGEBiaTHqwMtsbpxGy/DrdHfkxfUkZFT1juOibAi9xnroVy0LpfG8RraX8ucCwTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5030
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:15:31PM +0800, Zhu Wang wrote:
> When building with W=1, the following warning occurs.
> 
> net/netfilter/nf_conntrack_proto_dccp.c:72:27: warning: ‘dccp_state_names’ defined but not used [-Wunused-const-variable=]
>  static const char * const dccp_state_names[] = {
> 
> We include dccp_state_names in the macro
> CONFIG_NF_CONNTRACK_PROCFS, since it is only used in the place
> which is included in the macro CONFIG_NF_CONNTRACK_PROCFS.
> 
> Fixes: 2bc780499aa3 ("[NETFILTER]: nf_conntrack: add DCCP protocol support")
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

