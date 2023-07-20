Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB9375B34B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjGTPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjGTPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:44:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2098.outbound.protection.outlook.com [40.107.237.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F955E52;
        Thu, 20 Jul 2023 08:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER1TryIeJgUXFcYn82Hg9rZtTnkut2zVwhBjIhXoFf6tcortqVAk8112oqErgZaI8e81wXBIQIl49Xiu10UJfGvv6VS2JwyR3bSWoN+m7wImBAcor8TT67xumR09jyNSKEy3U4pxKmnp02xlVD835QMevWlLgxKDSygOYunS17VGhOekLze73kmfiM6lUpiHkis4vx1aE88mweMl1Ng53Of410Z0zTLu/1B6cOxLL8rfGtjf/i42LiJyLLKxh8xxS5aIOgxWTqznyNBuWNJDpsG6rfj3xkvtsJ2DNZgzRN4ACp3q2ADpBQ7J7NNbH6Alr6uZwLIbHGQUO1mCgoK/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyiW9oPCRFuXOHPQe91Z9Sy98IH++YAsVwchIRCU85s=;
 b=MWL1Y20ZP1iBxofzVPCUvaqccTht+FrRYaNtyB7jGaS/lk+68gCdr8E6Zx1/XBilGJnZN+m3pLDApaHSAi2+rxnsP5mBKMhgsRGvu27XXBCCXi7t1aRrFmFBMNQK8cX+GxEUbRPzWzVho9btRQlnpbvd7N0FUsEus1SpXTDbraj2wEpNG3pA7Q4gGNvDtRSvXdD7fIzCPczkSQWGkEjhaKFUXCejvg1mPvWKUpr/vDHdR4+uHdlBwikaub0t0KsHxdVktKQSmolI5tdXG9OtHounYJSj59O4LbQO4Mrf1c6uO+qTqx0yz/beg8j5svWFlT8OXzY3i2VcmLOcJbhX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyiW9oPCRFuXOHPQe91Z9Sy98IH++YAsVwchIRCU85s=;
 b=bVevilb4wi00BjVCB50XqqhUFG27a02Uyaw7d8E36m/+3CA8hajoi8aoIymQNkr0c1WatJtm2FMz5WKc8Iv/ED3ZhPTIlP8ljJjZDA81R88u6KZ1Y79KXaZioQWMPjY5snw+6MkAXzosz7A66/OqXleqNUgUwi9E0iQp6lWC4mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB6016.namprd13.prod.outlook.com (2603:10b6:a03:3b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 15:44:09 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 15:44:09 +0000
Date:   Thu, 20 Jul 2023 16:44:01 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v5 01/12] can: m_can: Write transmit header and data in
 one transaction
Message-ID: <ZLlWQeJqkispLIV+@corigine.com>
References: <20230718075708.958094-1-msp@baylibre.com>
 <20230718075708.958094-2-msp@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718075708.958094-2-msp@baylibre.com>
X-ClientProxiedBy: LO4P123CA0397.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8399fac9-2b43-4f3d-0578-08db89382868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cOsLmZ/0CcCyS0EDZaCA+k7wGxJiR5PxN5zYyJ/JM7OT79v/waVE20/92Hk4M206daj3z7zll4DZ9qaXLW64b+64XFRBv8AXVui+V1zEa/J/bY/M9M+u8f1bOwnXHej1v8AVpQmhdhdqOCXRg3TkDh6g7YylZ8AD9PakDigqZW0UGGKqWS2p9INydONW9UK5x7UQCnyh6tedi9Jt7+0TWz5KPaoeFHSZ7zcinTNBRUsmvCpRNkiyXAhVBjJrqLM3UyByJgiJxTZg3YE0D3cie3QW24OiSSMt/qOwyEZEV9xO5LbLb847PD3aWnwYz4pccngHHjXk0uN6EUSxxgnd8nK2jp9oRkk+4l9gHNECaItYGFI29/SR8lrw5ocZqUoUMi9L8/Kvkfb+I3q3mz1rKonBjy5m2iIdhBZPOfCTX5nxXpLAN8iFUn3boy1ayDprCy7tsjWOPnJoRHvBxxG3YqoJDyPDNsgkfB4Y+136X0sHanehAflkeZrEoHojTbf4nSlyvcmadzlGkXo0bKxhHOLLSX2A+O9stA8UcNtDtAOGg8aNMwloI5ETmwKzSozI9773lfmvdO3cWrTDzhOZt8JO1y81+93yhzjgVxhGjwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39840400004)(366004)(136003)(376002)(451199021)(2906002)(66946007)(66556008)(66476007)(6916009)(4326008)(38100700002)(2616005)(55236004)(86362001)(186003)(6506007)(26005)(558084003)(36756003)(478600001)(6512007)(6486002)(6666004)(54906003)(7416002)(41300700001)(8676002)(8936002)(5660300002)(44832011)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q6+utVtmbJ3KkS4lEx0kspBs7BtKjok2GdeXsjyZ+Qyhd0n3/yTe7I+prceg?=
 =?us-ascii?Q?Z+bvkY7ieYfDEISe5BwMo9Zd+XPOZ59Xs6yoqlWprR9yPzFO3RmRC4Vzf1zx?=
 =?us-ascii?Q?Wda+1hDnzjv5RTNUymqnuvQTi9BCwtHuHJgDzlFXsAb/yJeEfRatclXEbXPN?=
 =?us-ascii?Q?4oGkizSLQ/1q44O0+rIdT2tI066ksfcS9jijVjX12no9Bdo+Spt0bK+5wuyA?=
 =?us-ascii?Q?el7nTpF1+fPz4vlDa2SAK29QYwkFOgpcS+F5M+e1DBc8+P7XSZ/LSsCTKrQj?=
 =?us-ascii?Q?1Oq1ICE2Wtes98wWeTabdvUcJr5gRcgbCMOxE7lW3vRoRS6FINCv183lxRJG?=
 =?us-ascii?Q?8qqm6Ltn4USeGCQQ65NypgNUg/c8boa84SBYTTO81n7Nc7fmrj3tDFZ/QsHr?=
 =?us-ascii?Q?Tnr2R2zn2hESo7sxxbKtuPPBDW6COtK0TvJi1Y8qdNJMHm6XxKssGqaknnb4?=
 =?us-ascii?Q?0RrfYe/8B1zWs9d6DxsIrSM/y565Aik2M4c8/S0cJfLqafHhQNlO5Fc4P3F2?=
 =?us-ascii?Q?HxBduU09Nl1zmO3wMuW6Td7ubygngxa2sZ9rnumpPVb7KyOVHaj31HSW+Qw+?=
 =?us-ascii?Q?LSQQbLORMFaVELOFG2f3TlnQTFa+0PhhwYnE8o2hTvfl0JV9ggZeNd1TuzPB?=
 =?us-ascii?Q?cd3Nbcz/xootJf9iaPLc+8iG+3QxOiS1KwOrAHNfeM/i0BO69+B3stoM78u7?=
 =?us-ascii?Q?PAUxXEmL1DvHUWM/FfrArwW8J9YftyAvOLDigyVzmEpEuBTVuCYUfPQ5jAYl?=
 =?us-ascii?Q?EtNmZxw+dvyWThbJhbBnJO+1hEIzt8AYE6kJJNvYkmHPt9OOQA9SyVlzVWce?=
 =?us-ascii?Q?946GvUD4qhS7bMeL8sYuU4Eh5PEIsf7aUJPbj82DaD11VIOObBX0w5uK6vrR?=
 =?us-ascii?Q?yi3bshy+KjafgDD5FhWSRaJMVI/XQjcR65f3pb7uuNRnRhd59G5ciiNWfevh?=
 =?us-ascii?Q?5b0ArnrK/5RYZHk+mz2kxGM0ilFslCzIwrihN38nbBxG8jpj3MJBiZe8/73R?=
 =?us-ascii?Q?N8wT5ZySxNuGiK0/FIJ0X9T94FTz8Iv4/jtLvRCsugywUfgaI85mJqLGDfgi?=
 =?us-ascii?Q?jrb8x2b4iU1wpTc1K3LG6G4seE/bKuiuiU4nEJMYEPMCNg3nGQLKBBsJ3D3j?=
 =?us-ascii?Q?MPzOGzcXEH7+wwz40ynXEDfkih4TG28DGk0I3ZqPmqjY2tSfwyB1QrqKfBOm?=
 =?us-ascii?Q?yYgwazjH85xA+TfUb6zBqYRNaxGOpJrlW/6QfKRNYPp7dUesfhKGMirkai1M?=
 =?us-ascii?Q?16JO96l4XOSJqSn9VtXO2g3lWuomiqN3d4nXzGgxJphuL4cqdcWa9kP5mbKY?=
 =?us-ascii?Q?CKm6rqinJbXPSnOEkToBbk38YH2tSyJnTDIzuY0thCaPJ65yjcNCUfTiyd2G?=
 =?us-ascii?Q?Bu3Bl1mMT2X5i3zD7tn6HWehHXTW/GWLRAspsDBGhhah35/vg/RnJYwVc+20?=
 =?us-ascii?Q?LU7kn1VbvkKL7t5YW412UYWjKHX1Bdt30CF5KtemCL2QOpCEwXJFsDBwqPYY?=
 =?us-ascii?Q?U/wahYvPcqF7T4hiY6fnUi2TzCp1RFiG8ZD/fc+hLJAeNv9nNLqTvOQYgi8N?=
 =?us-ascii?Q?PzuziSbWxCpwzJccGo3SUdCTw/Pm/vEQ9npQ8fLSmztY8UHaP57iBtPrspFt?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8399fac9-2b43-4f3d-0578-08db89382868
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 15:44:09.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O/TCLXZDYa5dUPZCzv38aTB/eyQVHT3J5oFafi4sbLwZHLF7WdWXCMOAuIPFqbnyT69+GSd6oEyWDag0N1DrEY38w39flFEFmXFi8B5iVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB6016
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:56:57AM +0200, Markus Schneider-Pargmann wrote:
> Combine header and data before writing to the transmit fifo to reduce
> the overhead for peripheral chips.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
