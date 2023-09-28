Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1117B28D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjI1Xcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1Xcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:32:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2132.outbound.protection.outlook.com [40.107.113.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A563B139;
        Thu, 28 Sep 2023 16:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODSUqwMWhaYN7DMaZwz4lMOTxf875WzCWroJiNEbCXurG5RWtV3z+W9GVupIEpETb/s0Cq460XaO/B1wCUEwBo8YNtCwBOy496HwmXIFUP6HAEqZedMeUiQV7aZ3OBfO/9vPvC6Xp2iP3ouHSasZb0m4meou9tlUC9zSSRl4pLYK3Z8OPMDRfGiPFgsk/NwdBVJFlDGffSPCYPIZqT3FDRLtNW011PIt7G8dzF1oSjH7GlrVSZv2Go9+GKYRWEKtogqfNxG/hF6xG8FepujWOjsk0X86qk4CCi+mtYKopKK+0+wfC8PnL0cJSJKf10R3ujmDsjIlOoSkPl7rXopuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjwsPkta7prLfjFXZ7ADtYEk5ixh/LdgyTBARBaxRaE=;
 b=DZYZb5/zI1KQAcwjtJTYsr69/aSLaVgaybcn9YC3nomRSF/wMo0/4sJg8mi0FAeuGgGngjZD4SYPoRLMYXwepBjNGufi0vNoMwlERsp6HnUfEDGEkgh3/XiXrbgp8eQ7Ce9Nzgx9wQ/qxS071ITxRC1Jh8qITtyOZX3AyISTjtt/e0YwjLZAac575A9xTscYvYlBmsJHAx/v9EzQKeqprW8bId3+TFthAxOH2vnFokiINkpuxymJniwdKCPx1DNRMpg/RTOy17oWEA5f8grBeEE9LFfPiSI1KI1nLPFxBcGWyVRquqQ08wNkc9pwphoUeesL1m0jbCFokeTxQrwD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjwsPkta7prLfjFXZ7ADtYEk5ixh/LdgyTBARBaxRaE=;
 b=AEEaGr5XtrkBOupTfM3kt4C5+e+rXwwQF3jq1JffCBeojT61BroKtVXUIy9pxhEABg83RTzyfp+1yCr6k7oNYMer1Mgb9kXM5uqKZyvHA0ZVZ7R4iQX2ZOYMOgpj0qt5MKRMqnqvERdenBOQyQV13AZIeuJIhEPMrysZ8QppjNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by OS3PR01MB5637.jpnprd01.prod.outlook.com (2603:1096:604:b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 28 Sep
 2023 23:32:35 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::d2a3:45df:a180:595c]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::d2a3:45df:a180:595c%6]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 23:32:34 +0000
Message-ID: <87h6ndho19.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: Simplify referencing dai-params.yaml
In-Reply-To: <20230928194126.1146622-1-robh@kernel.org>
References: <20230928194126.1146622-1-robh@kernel.org>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Thu, 28 Sep 2023 23:32:34 +0000
X-ClientProxiedBy: TYCP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::9) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|OS3PR01MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ba5dc4-9fb7-4066-234d-08dbc07b3193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLfJY6dio5yqM2bv7VS/WE1QTNq5D5HS29i5Q5z4P/0DDjM6U4a2uNGx8wohbUsFN8TKxQLOn0nv5QcXE0Q/fIJ57SwF8T7GlgYzTgWjqMBtJJ+YPUdodo0ETF8G7g029YCnSVT86hLq/rCYc2LlkBJt4nzxa5J0rFQ9tpdrbWiZ6LMfLtG8/jP7CNK0K+dRp+vcEAOvLY2gIgPA/1NhdGw2fCw/WmOb5CkGgzp4oJeMkuQQ86Po0UmXYAWAcKxWZTcm28rWrZUS5EuSEZtvnWjnU45658lRDhE9TRs8tU1TPbHu6RSyYLfCGrpXq4uhatKJDvENxDXSlHDuG/u4KYIXyE6A/AMnMGpAaAPR/mUz5hvhhYCG3z/2vKWfcjeydQEJCMUeS0rLQ3xoDMtJIFRq3qpvcNxCQcEJrpZZKOYkbHCaEVtHYOW10/YEyZGxyrqx5I3byKRoOXkaNx1DZb2ZG1EVJej8JgzDm3bvBgnnBimtK4+dGhL51p3U9fGzeBD5w/YLACO5g12yvqXEs0F7zReEYkR6kZE7MXp4u24XGMvwTogtlpLaa/xLfz/PuqLhXEmUWU5jwLLa4uR25AKaaaVbQg9Q4rWml+kAv2MskH/4PBVgBpkaYlXuUHUu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(52116002)(6506007)(2616005)(6512007)(478600001)(6486002)(26005)(4744005)(2906002)(316002)(66946007)(66556008)(66476007)(6916009)(54906003)(5660300002)(8676002)(8936002)(4326008)(41300700001)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pnjq3vhYBBB3CRoUIhpEIr6L0eU7bIPfuqSdmcRDKsigSkeqmkHK0B/QniCf?=
 =?us-ascii?Q?GRtUZVf0J/NwmSaAy3C7yGz6Q5OHXLSgV8hTNrE6EJQPpTbTK+FtonbAj5gV?=
 =?us-ascii?Q?wib77iRw8Q3KM6dpxeE44SJsUwtHAqKAZYltggynIUFB9N8EkRtas4cxEneb?=
 =?us-ascii?Q?ZAuDk0RmlSST5u9pcLHPsPH2WCTObcSx7cB/6P47r4FCQq0iq14jcDMurT8J?=
 =?us-ascii?Q?BAuRXM2Nk3O3zUkTuzB9O0pLKjP+nKzXttFQZ+uUwUdsWuxHSSRjWvrWkY9v?=
 =?us-ascii?Q?QxRNnsdz2OU0VHzCvSIVbaEjWoCjd9TL2lxFqGD8w7rjAC9g07AMIunlAI8r?=
 =?us-ascii?Q?tZrudo1tYGSlv0l/Slff3bNFU0650XMedQ8V2aL0BHdHNXnpvptp8QiReE+Q?=
 =?us-ascii?Q?/+NBwoREULloQFPlBLkzFEQClLpKrVxdp3WvkyFrGwV7PqkvDIujpBJEGkKs?=
 =?us-ascii?Q?xGW3YN1y1KZ7VpBgfN6L6s5XNTJNlLW+ck55RSHmIS6l5RS831GfLMHpRJjQ?=
 =?us-ascii?Q?/uWkY+ZP08dFr48yO44aVEHIUt4YErnj/bv1LuZbWu9h77GhVDU/0ld+ldFw?=
 =?us-ascii?Q?ocFJHho686usAncDY40607C19EHvZa5L2JXonaJNyUYGiN9mfBrUEuFePZMS?=
 =?us-ascii?Q?tAV11RFxAjgQWzGV8XpObdsJX/uEoIyIIndB0m/2g6yTzbJSxBksTPrTOuVh?=
 =?us-ascii?Q?2DVFD2Zpo2MsoS+jQGFbU+3E0KLNwMsKBKQ9XX/YVilqLEQ6FK0hl1rhHa6r?=
 =?us-ascii?Q?KmoEtxXjE7yLWJan/AzGfYCgzV4g1IH6adMAAb71CPic1ch5E/Klc8xJ3Tq7?=
 =?us-ascii?Q?V7bRAq2eorq6I3LjirpkdB4bMS6fKms2ome1XCFzTNPU9DdV3Jwa41135/mZ?=
 =?us-ascii?Q?8i6h6PNWMQyp+sEL7agtRjjY9J+M/LrSF0EmsP/2lihpSF74ho4gwkg7rDtD?=
 =?us-ascii?Q?l7RONcVJmaXDNApqeIpm2O+Kz/L+vylYx8HjspclMVfugFr2zO7JTVyFdua9?=
 =?us-ascii?Q?NYqamLuGPfV/CvP1irFIMUCiYENohhxsh5b0re2SbL5dX2g17K7DtqHOAiJt?=
 =?us-ascii?Q?UFAjCSBL0IXkeTzXFqq/wDL66jj/gScsujSXkvWDoNfGy0gWhpN4WOifuvuM?=
 =?us-ascii?Q?oGpDgMe6BreBtBF0KRBPjBfFBNGV6lWLEah/4WS+dVbJVd+vlMYxl5gjiGfM?=
 =?us-ascii?Q?aC86uOCkNLdDV8P2Ug9I5LuyKWUTulppfjoOB1/2Z804U+38k9RidbLnoVHl?=
 =?us-ascii?Q?FWlEDJ9qheAXY/kiDPnMtedfaZ7WJwsF1wxlhyBM2Y+NhUXZRziw/oDy+zD+?=
 =?us-ascii?Q?/mlCz2jeu+DptUycMyDMK8KHuXj9/ig2wXEwT7D4j3DK98h19tgOWbX0WLyN?=
 =?us-ascii?Q?bYFUBYnkWtjzsAGlJNIgknS4f0y3f4vRc93Qalz8Gj0yQh3Ly/PsfjIcpzxs?=
 =?us-ascii?Q?vutZ3jUuPAleLOAuYIiwiaYuX7rNVOHv10tmObDe2Mg90fHqZ5c2wS7oneMX?=
 =?us-ascii?Q?ezg0otmhGFXQfjYEPH+PQ70w1arBOSVCNGxmyeLS1Q1saUAi57HBvSXMO8FR?=
 =?us-ascii?Q?23co/Gkn992ZZ/Dy5649K/SxSih7btdg+xi0UGWEt9YmUPZlKFfl/O/Rus+C?=
 =?us-ascii?Q?k0SVVJduGoNXeMhX+UtjjH8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ba5dc4-9fb7-4066-234d-08dbc07b3193
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 23:32:34.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wq9Kpu7iLKtNFGgIPf1g9OzetT9V7MnJ5ZnKIyo0/4hPfdXq/udFz/pB6vtvymjljnh/CauKGfjUJ53qF0RNfhTO1LlJN2f4iL44lSgOmEQdLU7oQm2PZaA2oEyRB4fp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5637
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> There's generally no need to use definitions to reference from
> individual properties. All the property names are the same, and all the
> defined properties are used by all the users.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto
