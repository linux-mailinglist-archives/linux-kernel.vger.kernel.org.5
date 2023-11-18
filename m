Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283A97EFCE0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjKRBLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjKRBLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:11:33 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2030.outbound.protection.outlook.com [40.92.21.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8BD6D;
        Fri, 17 Nov 2023 17:11:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq1SXw+euepTop9tSZahioNjg3uUg3zTmVDKNkF4tqgcP5e1ddG1YVscfLu2mjz6uVg1CXcM/VyYtHeunkT55KTE8SuA+JthzMd0wOGTK+aUmW0m/Hr4B2pUs/4vN0sKtWIATZ4RIiNMXMrL/wvB+PJFL4HH4msuDlHw32vxr4toUA5XEqyR70pV6DnU6TRzjS3c0grXaXZ145Iw0O6llTyxwxh1RawD6+etX3eyRgwA6pFaCrxjz6sJv6bDo96aaNx8orURBCsjoOCl6u0DFFD1EPvxaD9xuFsZPBPu8fTnpnuAAToBaLxrhruSFm9puRxhelbflCVqdSbbDkazrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DmTJi34iK8HL+4QtFUrV4nOMjkffzblzpTD+rwDAt8=;
 b=Ye8eVuIvRdh+T6oJLI7NxpPBTO6ocvvUONDBWHPGKJKas8+vO6bZTe0kwBeI1KBtj3iACE7IyIhhHino9cRk+CpWS+q553H3rQXDcZQcb6PxgZ8/ywYxP9aXD+jBcX1+yRIKeshTjMNZDJZizqmMW+dSYPZpFRzvHnLzdD1O5V+s82hb2rfO5wF4OuSeo3Wu36oq+3DzSQjkdpKezgqaPiv4ai528lWQO+ixIwpXxKImufOKSmD5obVv6HItAWtT3iAh3o6Mls/hWOMlzzr0OmAuBEzGuR6Qrhr1pusFV6vjpy8zlAm5lK1X0QUkci3mcWuZUpWisBnmdTyr4jHu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DmTJi34iK8HL+4QtFUrV4nOMjkffzblzpTD+rwDAt8=;
 b=KkrwWqV5DrMVeArAC9ufOoVq+oPeQvDzkVqxpTzrKchT9NNe2Nbs63tLIj3lcKKwcGmwioLT4R3nY1ou/r8mHX4hNvL4li8ZHBUvSfOHT2esvq0kHbbZGx2oGbHVPr9BDqeB0eb1vOb/aTqkJtUcHYhrB8d+M8r78VRen+LDC7I7eA9LwYgTDLaUjIGwJGiNWt8RKXMboHugtq7MAd+JD0jGmHbfG3kS+0lMzkdzOkmh01nMY8AMSMjOzv9kgdnE1g6YLWEt1QJmKJFG/o+W/+Z2+chsnompgGQNkjK6LC08MpE6syHwjlHs4FdJXUnQq8vIQmwKGbg2Gio9H9kMIQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by DS7PR20MB3968.namprd20.prod.outlook.com (2603:10b6:5:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Sat, 18 Nov
 2023 01:11:28 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::84ba:de35:b4b5:8eaf]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::84ba:de35:b4b5:8eaf%4]) with mapi id 15.20.7002.015; Sat, 18 Nov 2023
 01:11:28 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor.Dooley@microchip.com
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Sat, 18 Nov 2023 09:12:04 +0800
Message-ID: <IA1PR20MB4953EB3FABA3A0DDC6EC9D5DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cd5e88b0-db70-663a-6436-e892f589e3a3@microchip.com>
References: <cd5e88b0-db70-663a-6436-e892f589e3a3@microchip.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [jr10hnC1yrr2CWTkE20zEeGusQKg/yl0kOlPzcXizW4=]
X-ClientProxiedBy: TYCP286CA0168.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231118011205.67697-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|DS7PR20MB3968:EE_
X-MS-Office365-Filtering-Correlation-Id: 04543c87-0bbe-4bd4-12ae-08dbe7d349b1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UG/ZBHEo7RzxXLY1JI1TS5DP9VKTd4BHf8rczURAb+wZac/gXEsUGO5Pn66/Agm6hEF0+JlZl3/2EFomVexiIFhkb9HDJpap5ptykr1/VVIyJd2xX1xJ9ULQGwLAPOxQNP9C0jCFR0x1o7wukZ/jgsf1GmqYpYh9ygaaoXPp1i+8yetR8N61SVx8+cZfs+vTQGx9mGENifO8QNdgUPRABTNpbw2H0QGA4EbEg98uh3KnrLDKI75RfwJ29gX+qUXmhbhydMU3oUXNb/XPS8kWyQ31YTxg8ubj7zDfblab7V8IbBa2JGLxy8q/rDxkKQ3CHSuwk3PeGb8LN3/gFBe1lA0ZfS0Xx3F7DGrVcVZAdAZAV+jORjSX81yhr9TcfPV4kStnrFyD0ZPqs2rhu6MNDDsTVgh4s7sdzaDSHmAoiC5Zzlm9a1uGCZQdOuA2miHI743YVayrGv39Ab06DEowD/rJ8SCCbOAAmuNRcg/tIIjyyHCvN9O4Oe/w0R3DsivLkmPliwKiqKcjIculjQTAn6yi29JfLFIVmB0ZotBcJsKuZWD7tBRHsxS5/cU/EDEo3Gv8fD2ZthZlz9r2vIhSU0+8L7BQJ9MtWRUyN7lWT1PuR1CNMvSnv1h3jI1a+QM2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ZI3f8mAD6oQjanObljGHaMbrdoKVrgtm/pS77l1dkvJOGCl9M9iq72sPUw3?=
 =?us-ascii?Q?hPexxIUEvhbge73lpieA18Crao0YNneb81EykBw8S86ZHZeSc+rsX7EU3/es?=
 =?us-ascii?Q?bIpOaGiZXnHkdlcfsN5s8cSsRJ4CZSpBdKl96zvXJyDB3J6MjD2jwyIwBSHK?=
 =?us-ascii?Q?732s8GBuKsM3ePDdmJ720pJu+NK0fJyy3SF/gedSy9nfVeQVxLX6x9ScYv8b?=
 =?us-ascii?Q?Ht3Ox4VrllVkPRJcfJDLh+sHjqtbBd6ZvroPHEIn7/T6a4X+nTXfQNcy8rGX?=
 =?us-ascii?Q?znGS01acPUBFoazkw5EcoSY0L7vX+ic6qiuDWlKTDKWd13EKl4ZK3LL04mOv?=
 =?us-ascii?Q?Y8Mo451VZyKD0mg17PnsxyG6O201/H6NaeVqTgWf1XyXnZ8q08ZiZXgFn152?=
 =?us-ascii?Q?4MzgwJG3oOum8pYZQIkS5VDh9j5N9H8TqbYunBEXHsFjWtuQaUEBEgnoJNQx?=
 =?us-ascii?Q?qPdNZFlzlCLu99awyGrIHvEP52BPNEIAFGefClRXiyprzN6Axfk7L91xUe56?=
 =?us-ascii?Q?FrGJ6H3IqSYbvYem56VeZrfuXXaKJdWg4Hpx2D0d+Q/+uhXXABkRNiyXBVcQ?=
 =?us-ascii?Q?qqmoQiswHevNjgrQSsPzblNMiEvOIspF5SecqD59k/NlX3Z+YpHyTyDBodl3?=
 =?us-ascii?Q?auXbTsuhHg5ySB+otRVHBHuyOFe/NVKxayp873MNyWpfxf7Mbazn4Cd+m/KT?=
 =?us-ascii?Q?YUb8KUgK+hpYsaVlZntH+Hb6sYWJWLa43CcLdWQN9ev9C2evvUYhcXXorpuv?=
 =?us-ascii?Q?jUj3IyoGI5jVlTwo30Ktl5ewIrAbOW+Un2Xmb4QXY41MY5/EhbFAQSfQemcR?=
 =?us-ascii?Q?O5UEEKb9kRtTZnJdWkgk8pW9lfl/o0mFXuaVdsy+LHj3Hu2g5JDqnSW40xFw?=
 =?us-ascii?Q?gtLw4AAjx0oIihMOxKZuEmzgizjLHLc5zA+JXVH7o3/vC7ScJ4gSEHtOXtsA?=
 =?us-ascii?Q?ztNNxXoJnBrHBlUlTFvgD71s3Qq3PF0YtFxlDMUArYpiBpfiNCb2pog/c45r?=
 =?us-ascii?Q?qG6pZknWiQOR9rxCJO6aqjLBcOVNSGrehENaNYi1NQ+3Xo28WVepiB7Z3EV6?=
 =?us-ascii?Q?DfhtPMn6NGbwtv/4jsq/V9Ugrr5oiR3OOrTQvb4Xo+UOTimQ96vw6ZesT6Ow?=
 =?us-ascii?Q?jDd6AQGfhHR7IRUSyc1ODQjesX+m7xq495R4gx/i/SXxA2Ugc58i0T1J1cCf?=
 =?us-ascii?Q?b/xpmliLuOLxLfLpKfriGqPs77vG3urHUIeriRnz5FGO3Zlup+sULp/MuXk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04543c87-0bbe-4bd4-12ae-08dbe7d349b1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 01:11:28.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB3968
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Thanks for your clarification. If I understand you correctly, the binding
>> should have all registers that ACLINT has. But for specific use case,
>> it should only contain supported registers and omit unsupported. Please
>> correct me if I misunderstood. Thanks.
>
>Yes.
>

Thanks, I will prepare a new binding for this.
