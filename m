Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF55761DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGYP43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGYP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:56:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D574A2118;
        Tue, 25 Jul 2023 08:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP2UEnAYTaLIPO6yj869kocAtR2MGyI2FC+qBw9J5ybL9EKLHoiDi6EeDdy/29l6XLeC6suOrCqs8gHWvT2Q5aAQdnwd6Azxs8OkbYwqph3jmqo+ikwD/oqUur8+KAywwwC3WCtzCN0OmonvyCj5rP33jhDG6hcP1XPV+G0wRA6B/CpJ4TTmDtSt5WJL0J2jTOzonpO8Izmx3N3qA+SYQ6Ml9mz99rVqIWmSKxUi4YTua5E6HpuC7An+H2hL3J2HG4QhMVdRRrDbGXeJ5U2W/sYxiWtFE5IIWYY85HZr6dzS+q0qsUvqFUT/b0XoNFpU0culHVCBSafUbRH+Jj6+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7buwkHa7lrOUmL+6+7Qe3dwXfjyQ332DSWeELyWlj8c=;
 b=c2SwFkRKN4H0TNXpJ0ehJHFDkOE+Z0nUCsk51fYxtLCTUEf/4OXalhDKxb05544n6YZRCAal2Z8obXtq9+Zfjl4sgiUEZhLxABbLMSP0oofZZOwCFd7mkuEcQnRvihwor0WBIFdTZHQzBi9CGzEN8EfPV4C+8kTuKluIDwybnQRXyN/BNbBnJznRKphOy1mOGji3aEyLn4wpeD7xzQDCslJgu8HrNnF2XHMfdpZ9e4io8jXIZv8QceH1EJKFfu7YPcrDZ/xhUHJYlV0F2+AEAv0DFeDU3JJfW+f3ZNwiEvKliBO0thTrrgcT7IrbQhvN0TICNMckf1pPF4cRrc292w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7buwkHa7lrOUmL+6+7Qe3dwXfjyQ332DSWeELyWlj8c=;
 b=UlFkXlqCBgVihG19/35X/nY6rqedpJELMokSGJoAajQv+/DGg+QJ6rDp6hx5+qliN+wmJh0CrI0baqdvwFLXV9q0WrH/EjfrfGDjgd6AA7iy25VA4lOPYXtkM1hfMgPnEerv+b0/+MsKgmAIZu3cWkX/SFMYlgG+EKYd6F8UPhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH3PR13MB6536.namprd13.prod.outlook.com (2603:10b6:610:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 15:56:05 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:56:05 +0000
Date:   Tue, 25 Jul 2023 17:55:59 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bcmasp: BCMASP should depend on ARCH_BRCMSTB
Message-ID: <ZL/wjzv4BlcTc4ow@corigine.com>
References: <1e8b998aa8dcc6e38323e295ee2430b48245cc79.1690299794.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e8b998aa8dcc6e38323e295ee2430b48245cc79.1690299794.git.geert+renesas@glider.be>
X-ClientProxiedBy: AS4PR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH3PR13MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: d96480eb-2c67-4f93-4b2c-08db8d27a75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70NiS3noaukySS/m0H89WmLvvemj4TPlHrTjf/X8zQCAxVbWSvljqEM26EUOSdEuBbUu7UM+YkYnhojvw1lBAd66LwdU7tTHSjpL1UaWuf7lZGxt42UHwFPH2tHqcFPFdEWy2rimRLinsrsg8qIOVEKOyoAlbHequiJ37+DY7X+iB7kaDROiZyfGqJubRjcr0HVvirv5t3heCBcXN8gcrWEyc5VVwEQMNAIXZNITHQCbZ7det8XuWY/hyzEoeJGuaEfZaxRJZvQTc7tXF2IskcRknKUPCkLP4eXeWHkKWc9DhtMqXu0/VVK9FVJMfdYepNWF4uAwpSRBzt9nJZd20NY15Ea+DdUfyNX/XXT2xlyHvULLjeNmZD0JdDD0BECgyyZu24aMedQAerTZxTQLv356t/OFNcxXazb/09wOx+UfLRyR65ByWEkW3iOSC1QV2KJ/fRdxxZRYAiHkEa3V52hCUD4PDrSABCQtO+TPagPtGj2SRVfxC5cB987fI0eZbUFz9lUolMpqp6sNl2ucb/G3X+RqAu3pLziywDXZigk/pCjMdrfpwOMP7NKDauNdh+QQwdKQp9LRvoDhWfWn1iCqxrZY24gDQCf2ZPqN14I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39840400004)(376002)(451199021)(6512007)(478600001)(6486002)(54906003)(6666004)(86362001)(4744005)(44832011)(2906002)(2616005)(186003)(36756003)(6506007)(66556008)(38100700002)(66476007)(4326008)(5660300002)(41300700001)(8936002)(8676002)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UwoC4bSqb6a8wiaAJPsxC+BU1wGBpd1kHgrVYCWs4U5OFX/+P/oo2bt5T0tl?=
 =?us-ascii?Q?AWFON6Akkx6p+zVFCkN5dE475rmtNhJ1bMRqWgID6JE1SsVQegBp39VejJ22?=
 =?us-ascii?Q?qxHaYk8blKzVo+3z/YkiOBB7Hl92jnie97cBDbal1N6pqxGMxMNBv0Tuk9Fw?=
 =?us-ascii?Q?6fxl3G2fdgc3YmHIrZ0qDxU2oHyML5frawNwmLC2TrTMGvQnH2TlC419maRR?=
 =?us-ascii?Q?OACjTwbA/DhqlaGxPMevaCZP5/x3T9Vo8UajGEtbBJnujXWI7tiMrU0CXqUt?=
 =?us-ascii?Q?NH9HJPrCcdXTKQsq/utG15kfMx2kCbx1Ti/RF5kXAj/NolIM8h2WqiNhyEua?=
 =?us-ascii?Q?iD/N1P3MDa+ylvknOWtI2M6n/aCFgPeCuPH/tYld4Hhe9dHRdrUZbvN3mZu1?=
 =?us-ascii?Q?OXGIdc/kMdjvijmqEHTKPvdTbrtdSJML5qN5zus/PnMinnnl0EhOpWa1WTQ3?=
 =?us-ascii?Q?6EL2qlSh+Kt16EPqBrcr2Yfrh48P7SLQssQ+V4uMx2zA6FmNyP8lCGNy85Vn?=
 =?us-ascii?Q?ziJdP8bO82aweCfuUyGFNbiL12MtJpJ8SHee6JkkVEXc3qvRrgsemBCmojCf?=
 =?us-ascii?Q?ts/9kHEYT6VgVdtakM5AeJ8VIntMM2jfQIXJFbgAsi4dpxi5iuTm0VHFZDXU?=
 =?us-ascii?Q?lznF2Yz4LYkITp12B5hPBPTj+c6x4LckyQAd0z9XIx8V7RZoP+qNB0ajw4PP?=
 =?us-ascii?Q?IUkihvBnnt7HMhuu5tY9JL1jmDuahxz+ooLmNoK8l50FxjKoId8WtHqexscu?=
 =?us-ascii?Q?va/qDc4ZqRncEIuU3mPzsx3+0MhAnTpHMdS0PoNb8aviiOHe2dvtdvoguUdy?=
 =?us-ascii?Q?vf6EfmbiSx+SSLLFoLNRSYh/J5o9dIQ/40OwsGAE6JYI3hDJ/W3NXtqnaDyk?=
 =?us-ascii?Q?pKY/zyoQj6P6A2iQqNY+rAZi71xOITeXW1ksND93qZFsYl+dZdNzkPoxrSjy?=
 =?us-ascii?Q?GMFuGjPXeiaN3HW5HXDJa+xjKCO8v0M8qj1RJJmpppnnLX9MpLlhTHF65JL+?=
 =?us-ascii?Q?qULxxEz8rnn8rgdTyslIrJdqxsqJbeJc1ftcUImJQMx+ZzXsiLwAfZjK1ZR9?=
 =?us-ascii?Q?QXbOselRhuOZ/NQErtX/ADJZez+zbJLMacWc00avUnSWKyTkLsV7BaNApZn4?=
 =?us-ascii?Q?qHmoGAOzDV3bKVuE/WW/PwRo/DFPFNpnRmUZ6L2rybUHVBPTbldJk9RQXDTo?=
 =?us-ascii?Q?lzB2RYKwJvPLV47oVPQ+OUK0zJUQkJakthp2kGhwdcLlprnWwY7+62tZscmo?=
 =?us-ascii?Q?YwC4SGAN5sisoaurQyNWhmoT39SNeu0b+atSjEYLX7byyjfIxPM7L1SIm5Zq?=
 =?us-ascii?Q?6orroyoc8RlHkr2MyzkWYx+TaFtob9c77MJ2pLwBAkQo+kF/tcwqXonkorDO?=
 =?us-ascii?Q?eQU2g2izOI0DcoVkPo/vsAuCK5HMKflxuoM5FsmVVowCvAF3jrKh+ts5Ii7L?=
 =?us-ascii?Q?4wR+XRGoVBU+uolX2iBxq41f4DcNpy2/N7Gzdo5RIRcYsJqFsw9x05exEgnj?=
 =?us-ascii?Q?ObXOJ0lfoZ0nidnm3h/5AhOuKLL5HPXXYwx5ezS6uUn3bvHHXtfhUO+tpsXA?=
 =?us-ascii?Q?H4YeCiR3T5mrnrl8syolqjHDz1uJ3kuiIB/H+9T9ZUfHSmvcAQFOSJCmXl/0?=
 =?us-ascii?Q?CJ0zOOi4gXdU6usHvB0VRFaLRS3pTR3NviAKz8KCSqwCyC/YTB955OOf04zc?=
 =?us-ascii?Q?ROGVjw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96480eb-2c67-4f93-4b2c-08db8d27a75d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:56:05.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/ahp3mDU9aOHiog1Ks6uPUMc8d2r2QZd/nRBJhAC+mMv1UQNNyhjOA9C4+VaftYQNsIBlDdi/6DFgM46omOiSpB5TghplI/QuaDRj1QdX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6536
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 05:46:37PM +0200, Geert Uytterhoeven wrote:
> The Broadcom ASP 2.0 Ethernet controller is only present on Broadcom STB
> SoCs.  Hence add a dependency on ARCH_BRCMSTB, to prevent asking the
> user about this driver when configuring a kernel without Broadcom
> ARM-based set-top box chipset support.
> 
> Fixes: 490cb412007de593 ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

