Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0297CD129
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjJRAPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJRAPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:15:45 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C604BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 17:15:43 -0700 (PDT)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.184.89])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 8F615100004F7;
        Wed, 18 Oct 2023 00:15:41 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1697588140.972000
X-TM-MAIL-UUID: d38766e5-5abb-4ca8-b512-331d9a606d38
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id ED8D810001285;
        Wed, 18 Oct 2023 00:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEyrQuPf/Ki5clpRRyoKfphe9J6z/VxEVJ9489qUNxVBgqOm9r1tPOrcf9SHwPftA6edNZtkQBpeEGPS8uxmtebCrnEw7tUwGIpWqper+063KXzv+oODA6Um/WglBzg9rHh1H0wX1Mzb6tFEF8HatPQK3+3K8cE9Qj9LC4IiJkRqa5wYPiBko1ZtlDd+QJwSsrZCVq08exAvRxG6pLtLCgmyWW1FDtOQbU2PD4tWYXHl0O9LGU5s5qsJ2Q7QWeqWrranKAOvmFmRM/lyXWP2Pw1HVwCq86UzGYTOyK8A+qVOivnBu4l24xVynqclKQni3gmC3m4HEDJVN7iwB+BMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjuGpLsF92lho6XO92Q4+gSdbPTMmYDqaDG+7JwAl3k=;
 b=aGUyu9vDF6FQDPncAx8eL5nC2mR99zVUGxR7rk2UeQpthd8MG/y0MXkRziNDtTi+Q+Uj23X/z7JQQqAe14i1FPGWwjA92russBUG5rg/6CuaWCHcHGx/bFQp8PJpLP7yXR6qTOXJhV8IYLal4+kiCLH9ufvwzNgNmVOxL/z4CGosha34Tltpn6EqXyZh9vkSdjkXQhGeDNchs1x01hkDOKRuCWADsZJlKeq+X72Vde9CjDQugRK5dGuhvSCiBt4xkRlR8RXuaS6A6DhfFy7QOzi6G7YP0KdTFXBZqbFqsUeZPMDTJcG9qytzr9+/gwTc2ccZisHVL3acpaoiq5EBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <28e51b45-2221-4d6d-b160-977991833908@opensynergy.com>
Date:   Wed, 18 Oct 2023 09:15:18 +0900
Subject: Re: [RFC PATCH] ALSA: virtio: use copy and fill_silence callbacks
To:     Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc:     mst@redhat.com, perex@perex.cz, tiwai@suse.com,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
References: <ZSgMeoMx6NX2zCx/@fedora>
 <6384c982-2b6d-474b-bf29-d495422aff20@opensynergy.com>
 <ZS6EBZ7oyGB9nhay@fedora>
Content-Language: en-US
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
In-Reply-To: <ZS6EBZ7oyGB9nhay@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:22::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR0P281MB2382:EE_|BE1P281MB2290:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaa388b-e2c9-42ff-fd57-08dbcf6f5b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QU87f/q6P8+jdrFQCG74i7k6UB2BXpcKRBhyGJRO8dn4XVVnnOBexa2hwyeMfTHQrTcY0BHbmnYLpq4w7rjhzH6XD3PXfUakLGHfwwLIA3rQoTXh5LXRWPfSfTF1u6CRhXvUsmIYr1KssLHCSj2Wnxr7eDF+Rptq33AzNPfpedgG9Fdgyz1s/ez85VBheFctEIiWWqfK2QmA1EJKu9RoDxdJzU2JEu0FUdabZBoewP9oFTShmzPnPDFiyIrfkk8WMGFaFt62WEJSNT3UoOhnIrlWAfUdjTNdiusTl/RFkBwboOX9mmLUVlJLSyXNkzkdib1TtY/coLLIpTKUzKwkWd8McFDrt0zC5lc208gU6CQ+qEMCp2M7AmRMVj0T+xgFzVS1B1/kfoofKPU+s2cbCEXbRh9EzFjUWhJTrkMi9ofh9m45tx5Pv7yFgCospXEeS8KGl5atRv4sJgErv1lmlQGuuaMJ1UtXb62IDlNhGqsB2PUhzJrtHX7p5LqAs8vJKdQg9DIgw//YNNPzc2bLTtrIIRwXtwmG+vs+mjTiZ5gpPCE2UbzOQxKee/0UmWB+L6bKTBXt2+BuBBvAffqnVcOUzFvvOHydNxw6P4H+uZVKqFDV4CsrxPJ8ErhEX4MvLS1veNWUBLqDIZGAuUOjIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39840400004)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(31686004)(38100700002)(41300700001)(5660300002)(44832011)(66476007)(66556008)(42186006)(66946007)(8936002)(8676002)(4326008)(7416002)(4744005)(6916009)(31696002)(86362001)(316002)(53546011)(478600001)(2906002)(2616005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmlZYU9VYktyS01abzMvejE3KzZYUE11dGtRNUsyRHZEeVRiUlhIYnIzbWc4?=
 =?utf-8?B?bVV3dWdPUzZKRDNVUHZsQ3FtYjVzYk52SUFydEpsajBmclhnUWljeGE2RXBW?=
 =?utf-8?B?cGRlRDFKUjJ5MmwvVzFQaVUzUjVtWXpPcTZzdG9uYnB0VDNrUkhFZjNuemd1?=
 =?utf-8?B?dkpiZC8rSHZZczNHMCtCelpRL2ZxZis4bVJYSDVmV3JyTFVMa0ZCeXRKcnM3?=
 =?utf-8?B?MGx6cVVleGRVRDh6SVIvamFoZ3BPYTNQK2hXeUozclpsaW5YTkZXbG50SlZD?=
 =?utf-8?B?VnFUOUlYZ0ZmV0NYallnSnRMRk1PdHhqQ3ZzU2k1aW5sSm1hbno2TWdwZ0tK?=
 =?utf-8?B?NG16bzk1eXh6SFZpcGR1a1ZrUG1tRlprS2dIRjhBMXZaOUltZ21McVVENFgv?=
 =?utf-8?B?VllpMktXQjdBTFhjL2R1MTJraFpQdmxtcCs1RXBqRDlkajBjd2thYUNLVVNn?=
 =?utf-8?B?WU9OMkF5M1lHVUNaeEhzYk9sSmFIeUM2cnJ3dUVYMUNndVdFaklrMXozMDVG?=
 =?utf-8?B?KzJJVzBFekpObW4zVjVnREZoU3FrOFdYdFdLSDV2eUp5akUwblo2N05naUxN?=
 =?utf-8?B?RDhoQ0FqN1ZIcm16TmFGWnluWUhNb21pZkdmVkhCUkRXeW1qbHNoQ3hHNWd2?=
 =?utf-8?B?RThXZ3hiV1hGS3B4aWY0dk0zZWZFS0lhR01nU3dWWDVPMXNWa240WUg5Vmhr?=
 =?utf-8?B?NzBEOHdoVzgydGFLRjF0TE9ML2xvamdoMEk3bHd3RWwxNTBpbFV5M2s5b00x?=
 =?utf-8?B?QS9WWWNGRjR4aDh0OHpmTndaU2E3R0NSNGpmUXkrRnVUZlVYMjZoL0dGLzll?=
 =?utf-8?B?T2JNdjNjNUx2M1lGK1Z2NGZGcXlNZ1J0VmpRV2JQMStweWowYVhPakFWUkxM?=
 =?utf-8?B?RGlmYzdVaXJRbm1oY1FSRUx0VUI2ajhlRU9Fd1BBUjc5YXhYNnpxUUF2dm9B?=
 =?utf-8?B?TjAyZVAzRTk4ZFdFTFlidjhTMkw2SlZSVTZRTmMzU2R1dXlqdXVKM2pJVDYr?=
 =?utf-8?B?eVB0SjUrcEJvdzdUWmx2MmRqemV5RzlCMFlHd05IZFVuV2tiWXpsTzhtcktn?=
 =?utf-8?B?TDNtaUIxWUkza2gybjhJeC95MFpPc2plUW5jY3ZjOUNBdllxUXhuWUs2bm95?=
 =?utf-8?B?WlFFeVVBUGhjaC9EV0xHcnozZGExeGZ0Yk9JUlNneWJCYzVrTjBpS2s5Wk5q?=
 =?utf-8?B?NHlQcXEySUIvN0R0ZjR1dXdEMWRyaGlJU2hmVGV6VE1Lb3JvR2JNZEZ0UlNB?=
 =?utf-8?B?eHlPUDUzRWRPazRlZm5ZaWYvVzB4YmJXSThuQ3ZvVTlPQVl5THQ1NXlXVTRa?=
 =?utf-8?B?WU5CdnNoU3hnYm1XSzBIOTBwemlGanlvU0cwNHVwMm5hR0NxKzRNYitWT0FW?=
 =?utf-8?B?RmlwQllIRGV6YzRwRHdqbmhMTmNQc0hTdnhqbWJQeXFXYjJkQ3lOa2dIbUp0?=
 =?utf-8?B?cnY4RjdvWDQ1cFd1b2xJWEl3d09zUGhsYlBvSkkxV296Q1Fzdm90WmtwRjF3?=
 =?utf-8?B?VGNvZFp3a1d5K05EekhUZ1F3RkpuM09hZWV1VFVKUmJWdmQrMFU4Um4xSE8r?=
 =?utf-8?B?RHpPU2F1Z1pLYXZVWDhPNlZHaU9ET1ZEWVlpcVFBUmlVb3Nla3NGQ2VlaE5K?=
 =?utf-8?B?d1U1MW54Q1A4K3ppb0xIcUx4ZlpUeVpyVEZDOTcvbG1CVVJZVVI4NW1MWFBq?=
 =?utf-8?B?N01rMlpuWXF3V2pQS3lPQWtEOE5VaURCb1JzVHo1aFE2WFVwNE4wQWZ2eTA0?=
 =?utf-8?B?ZWVHcVpwaE9uOWF1QUV6SzFYUEZuZVFEYjYwREtVZUZ4RWcrMk5zSFV0cHN4?=
 =?utf-8?B?WGNPelA3ODA3Y21lQTRXNTZJd0FrayttOTZEV1I4RGVMUk9ndG5nc0srbjVv?=
 =?utf-8?B?RmJhd08xSTBnemtZYmhySW9BSHNjRXRwLzVYc3Brc2N6bGNZM2QzODgyQjVv?=
 =?utf-8?B?SXJqZk9vVnp6ckNmSnl3UHhlbDMyellITzJudVM3aUMvcUx6VHFhMXpia0t5?=
 =?utf-8?B?UHN1OVFnRkFDeTJ5djBwQlBXeThrUko2QWYrd2NEdEJCQWh0UXRUYmFPdldO?=
 =?utf-8?B?bHFnT0pPNUlMc2pXQWhRT1NlU3diZXhyR1RiWVF2OHpQUHh5WlM5bThhUTlj?=
 =?utf-8?Q?rkQqgWuNBmSovYmvSoZMIfoG6?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaa388b-e2c9-42ff-fd57-08dbcf6f5b57
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 00:15:39.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoDscNCANC29Y6QU7l2pRzE4HFjKrcxhnun2s2lmGVjQzvD3iQ9kcfSzxnG8kKV6fkl4of48ZAOikQSMQSwkcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2290
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27942.003
X-TMASE-Result: 10--8.304000-4.000000
X-TMASE-MatchedRID: +c13yJDs901TzAVQ78TKJRhvdi92BBAu+HAk4j3F9/Qa9RqlFbRIduAA
        SvqZjfN4M2ta6t23unXTsSdxipbi+7dpEPyORLdV0RneM2u5ms9W1n4bHTHoQZXVwPqFeiBVT0B
        RZNI+YwbANog326X8vo19zNGhZoVDsM/3m9ko3yj27frq98KnmgaG4Utj+sREcYO7LzLWqS6Xn7
        CqFttPWxjSLVDqKI5E8BB++qkUITWZDRZvymtiMn7DsKL7bCLU
X-TMASE-XGENCLOUD: 54600590-e107-48d1-8b60-efb7cefc22e0-0-0-200-0
X-TM-Deliver-Signature: E80A9620F45A3CA3C6291C30DB18BAAF
X-TM-Addin-Auth: /mXZCuS4ctFgXJQPaxm7A2Q8/sfBvTnBbeBj+x5F2/precZizm9nOqzCO9+
        9mA+K/jpIB86KjFcqmdn9/YwgyMGRHzsuPr2238+ytOb4TXdpZVhFaZNa5vDKBHvxgrsEBQDZ7R
        JWY6aWM5H+iovWpLf7YeQnAr2flfDX0emq9AeSckuOjjvaCpJJPMhufVT/gfgHMx6jixhZ0msLc
        h+k2kb3C1uc4IggswgksRofczonZQPvxXGnDAOCVe6kj7wPoIBZzaT56U8PXiifrFQCuvqaHRWB
        3LP9xABtYs66/8s=.B1QJHwPnJ24MfwB19uvkS6/5gMCIGd7qEj+4BZkokFB7q6lJcHRQIrUDym
        c0QEO+wBNie82NoxMeM0cKzhfl/hJfdqk45WgKAV1JI6RKRT5xQz2QJTtUYqv7EQakL6x8Icyy5
        jSImbp2KSi35ipH3ccExektRdhfa57IouwPwFm8iEkAl9bcczHf5Wc8cQ8elHNaFpvmxmyq2sB7
        1OWjfPUMXfxSC+bW789OHA/icQzglST573a8nvaBJ+g2T5cEg9NeFlPJXXBsEgCr3YfZUWgwvXL
        oNpsPgLggChWtMbR0mi0Ia7uC7cP4QySYEz5lnOBq/Hq76A0KFLlQmgdE8g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1697588141;
        bh=rxwaXK7wsHQ9yjJMtig2FrHLjvYQY+JGipH32QfMqIQ=; l=393;
        h=Date:To:From;
        b=hTsIpO9wa+IfpIzgum0b1VXB8UnHH3NjtzX39+8yO/pZ8RIb5p6V0qgQMgm0GphId
         l9bG6OR3WQh+BskpSdJdxQAWIFhvSLS3SJZY1paLphReojfjK0AnXmTWX3Xs/euNFX
         9PRzMUI3wbjg0kf5H9okr6ApmfoNS7hr6mkDy/k1fNuRc2/Nq93o7OS/4lZ1mATCTP
         l4ZVDygujmwZ7M7Vy/a7o+Gf3l1wRqE++mqNqQw9ypBJk1V9ykqu4JB+XbdNO4DXNf
         UiHgYn2N1Oz0RxvobKrtf/HwQt7+0S2bWqntlQ2eU+dRr+CV08rXoyhmJ4eVzQzLjr
         Hu3POQdVApPEA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matias,

On 17.10.2023 21:54, Matias Ezequiel Vara Larsen wrote:
> Hello Anton,
> 
> Thanks for your help! I am going to send a second version of the patch
> with your changes. Is it OK if I add you with the "Co-developed-by"
> tag?.

Yes, I'm fine with that. :)


Best regards,

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
