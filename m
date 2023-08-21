Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639478217A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjHUCez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjHUCey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:34:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B29C;
        Sun, 20 Aug 2023 19:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L959pCVF3ORHz+LKotJUhEOqoqiaEViALDFjj4lcSr7cqte+4Wj6HgUH/kiGDw4y4DVr2NTpCtHRagtYeEYi+ifRM5aRyBBgk9AHLkwmW4W673mFHPn2da2qJxEg8O+3WqqS99P/Hx5NoPIwAvWaRlwGDYE98aGbxHUmYG6UMoyecoGdxTfTMk0B7IGezEhqcjrZPXQDvlSXQ/8Abu0F8HWsAynygk7Fd+6F6+EZzibaW8SfNiDppZ3LybVprVV1gnRKd0FrA2gLZQ5epWj+o2+0wmjMsrRvXGWFcfRQGXOQciSSgPQfO+leJ8JIjbIJZZeyD8YUOs+1owJXtLrLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y1A8ajtGdmCQOaTAirPEl7oKNU+/BTVmEmTEnni3AA=;
 b=cVpeVgSkACc41dQ3UA1DeS7f46f4/1rT6kaxOSen7eN8SYFbEzO9BnMIRm5KQd0iDNGTVkLYRh9hEqeUWGmcgvdTPqqoQG5MbqwdmryBvNrSlmTvUKnlaP1LoImclgKhqxe+vbjwx0viIIV0t/Gj6TOQenlT38QLhYBZPzx0beFwWvQofd3SARilSPjS6wsC5yOYaS11If9L3GHHaIVIoakRYhR4fPziFaU5cVmoOEnX54a94Tkg/Uoci35NzywfdqBEyLKcHlPguKE2Z4LYj9jLsme+0vdmfdk9/L85xTwHh74SEaY9MHniXy1CnQu1TbWYmRh52gw5if/mw/INUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y1A8ajtGdmCQOaTAirPEl7oKNU+/BTVmEmTEnni3AA=;
 b=kQi0XTGkizwuxRGnsJgXbF6Jv+P9NvsSABq0csB9/qwZD40YqwxVfu/KFveha31/f+FNTU7oAdFPzSpI2tbL6VDVhIhC+JM8qNDCdh/P+knEWmH1Yry3e+BJXGgIm75Cz+FSQqAfoXqA2lKLPFHaonnz8A2ApQcjVgjZn66Cqek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 02:34:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 02:34:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux@armlinux.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
        jeremy.kerr@canonical.com
Cc:     isaacmanjarres@google.com, hdegoede@redhat.com,
        ulf.hansson@linaro.org, rafael@kernel.org,
        grant.likely@secretlab.ca, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/2] amba: bus: fix refcount leak
Date:   Mon, 21 Aug 2023 10:39:27 +0800
Message-Id: <20230821023928.3324283-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b1909f-4d1e-41d5-ace2-08dba1ef30f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDNkphMo2DZO50z+1FpQUuWksbiIUYC0Af8b+FQQ4lRmQL+BMoKVUdCO0Pb3uysGUwPuXaRcIifhAAKV71fcmfLd2H1tcpmPB0FlnpAMBo6MhHM7cStatVsoTJgO/dfzXL9u4UeliFp3/gksSviOoCpAHNg0NLnxggAHX6hv3qVfzYm9mXO7pKJ8D+ROfjn0giX+/DphZO9SMDfhFhmt+4MwelqO6BR4yIbKXDU1Y64xNYVpkbBne9CmI1fOU7udWO6fdqGWUneC+Zpkl47z0hSmVqfeaAlj+nvfQ1XJ80V+8/ZIV1ikMR38A+08aruchBcwC1xdY/gumGqRZ8hD6oiMf6k0nft+ZzJf/WhfqfhJrRxP9o3MLHNfotJMgBKoPo9Y+iy7zgFvPNlj/7d+Gz50BRNkO7t4LdJdP0mSV/wgh+vUCJTYTMBc1iqc373G+WHzRgrc7esjDf7DZ0u7dkemkCortGFFHAvps5lSj0klTRPF3QLpNf7vdzUXdoAJKRN7LL2Yu8xLQEjlX9Uephf9K7ziFAsIH9Q6JqFGruJ89GpCA43UIt+/dLDmCcqQyLFMizaC0B8Xf7ve6R145/DesXtzbgF6ohUrfJf2AAVjl0s+kkShwORcTFMYCj69RTk0wk93UaMiHeTKhuaWsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(86362001)(921005)(316002)(478600001)(66476007)(66556008)(66946007)(41300700001)(38350700002)(38100700002)(6486002)(26005)(6666004)(6506007)(52116002)(6512007)(1076003)(8676002)(2906002)(8936002)(4744005)(7416002)(4326008)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6kES0Y7RLfQHadeouxtY4BskmIVlze7BGcOqpSMW9LkCb8NjTXaG4v+g07Em?=
 =?us-ascii?Q?/Z1oF9ijf3QHG+eX17xA+op7VKc1XkmY6K4Vs5+sNIxUTenAqGLo5zHo7Lhu?=
 =?us-ascii?Q?U09rFEpz2NPikONudf9ReOQ7gZsaAzIKqbyBrhwxKRNW6IvM44tpQZwxvDIG?=
 =?us-ascii?Q?CfKriqRrh5IeCSCxFza9Z0f9RVPYR5AdoE21QWc+Y3qafK+sJr7x+9jIEFyX?=
 =?us-ascii?Q?yxc8vjWDMyttIhgI4pAUoKR3++zDqFICRDpOZtEfJnGXAFIWsqf2H+uPFSMY?=
 =?us-ascii?Q?GjTPhhFCb9ydsns95WGpWqq7XFdjjr9SUS/uV493ybFRvmwi7wI4r3Wp1Puv?=
 =?us-ascii?Q?bx1lg1G/MmxmsUDKOj6jUrDkbMzM5M6Co47iKiSHKZAWZ/OPsgH1AB9nrrPE?=
 =?us-ascii?Q?fewOShFL3dMoWz6ziQZFcV6BXdXdjqXUbO73E6rKCPfFEFyQVRljXABihKZs?=
 =?us-ascii?Q?2kwSRvCDKH8bY2xMw/gAMa2luqaslcpHoj88QcUz0+J+qHSbgykpkb2CruLA?=
 =?us-ascii?Q?IP/VpfWMrFpqQtgqJ6Z8s7pb+MHvfT9ejDL0bpWhhiby8EXXAc7+on/FNE2U?=
 =?us-ascii?Q?dxh6EMaP+RIcqB18aVLQFuxKTlztrY+wTcojrU5WI3s3Ls/BexweLDVj3UO6?=
 =?us-ascii?Q?zMuH3bN7W8aYA7wQmTz3pn4NUqNQ5olwjCbPqgPGTUQiBif6AwHgD6PqK977?=
 =?us-ascii?Q?H/i7s8W6eQKQZn4j/xcT/vBaYQT+kYnSnxdQq913qNLFvvVAu8SOfWk4bDzm?=
 =?us-ascii?Q?+5U7cNDIyqQmBajGwbmqFLk7LP7k8IHTv1EBlc+hZrmfUSVACpBSp3jhdzw2?=
 =?us-ascii?Q?1Hyb2Gzk1K+thBO0CaY/txnRQQthNoFNquLDvlIOs2uq/jcqwX+Eu7TioREl?=
 =?us-ascii?Q?n6aSbAHyFGLQzUUppajxkw/rCIS7GH3cF0JSwJPAN/NfI2f38XZNAvKKSv3b?=
 =?us-ascii?Q?x1J+4+YivltVEJD3zSiAZ6Ps3Z+mLWPbQ7EwKkUKWeYJvK2PwiNvWZfDEszz?=
 =?us-ascii?Q?XIpv1MM2MX5DKFo5bLYGMb0SuTBkUIKPOEZl53x7MTIm/14c5vJeW8UrJxnW?=
 =?us-ascii?Q?HktqI2uJOkuEVQe4xxHUgZK3irQhcTqYFnnLFkucpz0i9Ttgf+jipgcegIwc?=
 =?us-ascii?Q?NnhH2k3hS1mFVkbUrz6poBkneWR/PYo8bKTEI8H0X3+V8CSW1c7++fUo8rUK?=
 =?us-ascii?Q?mA9tFG3IkEqr/kOlO0kO3GSxHpxZwgIP8Fzkpwe2mVZ2rbEW/TfVsEyh2lJL?=
 =?us-ascii?Q?rsZJRnvvk5FnxZHXWic79vd6bDcT279uLRORXI13eerFD/Y2yvrtMTMja4gR?=
 =?us-ascii?Q?wJELkiR1c8VgEVjsvV7o+KrdGn2SfU4Rw8tCHXuMyXBDo5FSl9q9fwiPfnjX?=
 =?us-ascii?Q?B16MEJkTOKwXFQS/NRCXkFrYvJEGLKI2EkxDy+VbsA8cACzTEgWY9AwAHDu5?=
 =?us-ascii?Q?hnf+AP/6iBVErdXhGuoByhnkqAbHMks+VQA7My+Mym858WpVD9xEExnbBT0M?=
 =?us-ascii?Q?xXkE4cdE30lr0nBTXLoK/0qCfAd7iFRgzxJIgr6CHfjU+4WxLe7AC4OdEgWT?=
 =?us-ascii?Q?Fnmn+tUjrKy3Y6iknGWDvhB5zL2dxUL7rdDZACY+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b1909f-4d1e-41d5-ace2-08dba1ef30f3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 02:34:49.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLA4Xu4zH66Rk3cq8JdflQkAMvLUl0sUjZOCuorjqMu2LDn/sJnxelrKFpdH/IR/MgT+NmP021DgpG2FVmcCyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 5de1540b7bc4 ("drivers/amba: create devices from device tree")
increases the refcount of of_node, but not releases it in
amba_device_release, so there is refcount leak. By using of_node_put
to avoid refcount leak.

Fixes: 5de1540b7bc4 ("drivers/amba: create devices from device tree")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

Note: Code inspection, not tested.

V3:
 Move this out from patch V2 1/1

 drivers/amba/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index ce88af9eb562..09e72967b8ab 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -528,6 +528,7 @@ static void amba_device_release(struct device *dev)
 {
 	struct amba_device *d = to_amba_device(dev);
 
+	of_node_put(d->dev.of_node);
 	if (d->res.parent)
 		release_resource(&d->res);
 	mutex_destroy(&d->periphid_lock);
-- 
2.37.1

