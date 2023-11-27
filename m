Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583247F9763
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjK0CH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjK0CH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:07:57 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2110.outbound.protection.outlook.com [40.107.102.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B93E11B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:08:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBTTPu9M6BBQoaj6daptJRWoEFGfzHaW7hy7SbSLVR4dX1VQGT9Hk98RLfgWKQS+g95B311UwQ/tVOj7lesf30HgOjEGWxvquGiZfxcc486Tjg+AtzYh0kaeVjtHycX7PuFe4Xv9DgWhihSpR57KW5dmh2ee8ifPsdM8eCI6UoGdo6WJA7gvOZc5Tm56Tm4wC5LuHhQCyqXXtSki9o56tg+kXEcGjrKIQ6TS5cqc8ixgXRvc5NTmHHghH3EMV0tRD0Uphuow5r5tQ8Tx2k5lW2CGO6qFxJzpsTJxnthIjznIx55JFZRS6xzMA7Ckf0aizr5nTCW0lvc/ITSH4v8UzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJydsXx1Ha46Vgcq4zg6QmrLj2CWYUVkrM2cHsJj6eA=;
 b=dNYREbQ9f8yI4OU4o5pevy2sKPdH4I4qPuxTiRpBiCM32P7B8B6y21DRiC/lgBhioQUUMwHolmI8yYZwqtiPdSo0VLMzK0ysRM889DWvlRE54zU+5/vm6JO4OFC85Y9mivGW1n94zM8ggrvkSkWmZOurnaPZDe7uqXQ4vEzfJFKiaK9k1CggM5ocFqyO5smpte43hjBlNCfS0tzfbiJygO2p4IWn48SPspxEcoyYm4x2DL+IX8321EM//1+M4fADOrEOnuIjwxUYffjqvs0oc0DPEuHV1HmOYjLJ6KHCMFDfapSB0a5E2EZx/4O0MREgYsof0KYoBQ3knp7nF2rdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJydsXx1Ha46Vgcq4zg6QmrLj2CWYUVkrM2cHsJj6eA=;
 b=JpG3MkPZocaNGwT4yTKJy7SZD7DpUnHPE04JgjwgDlMuMXsrQSJY5+PXyfWY2etbG4DV0JeAys455yGzaSo2XgQn8GFkUegoPU+MehY2HuWp/wZ63UAbUxaVq6FQ2D5gYmmLQA3xyaSSrf4C92cqkLL9BN72AMqVBZDjVwgyDq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ0PR01MB6381.prod.exchangelabs.com (2603:10b6:a03:29b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Mon, 27 Nov 2023 02:07:53 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7025.020; Mon, 27 Nov 2023
 02:07:53 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     bhe@redhat.com
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP is enabled
Date:   Mon, 27 Nov 2023 10:07:27 +0800
Message-Id: <20231127020727.25296-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:930:1c::27) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ0PR01MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 10038ec7-0fbb-4b63-932f-08dbeeeda9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMxgxyvz6uOZgWYjWmH7Ih6FBlkViWb/0+eKORhXXm8F/nP1rmY3YX9DVsAlRZst2NkgWdsfFjnt8v5o0ucAPHmOvDtwGLGxpRpH8Gx/aiI+mrCTf7omtTNvFG78MTo1rrwH/1auahrvhcx+Zz4+1FXCQYGrHrI2joKF6aflojtVs48leI9mObNVytMWL4jHg0T8XO84xcXSioOa9kSINvuLccX5YIZwYjpH+34WOY+XpkX48fM8CQdkSLj8siiju46VZwAT+K0A3Fej9irMOLG3t/Tz8d0HVHD1rv6MO3dUKUTbK8cuV8IJshZzBDQuem4v2er4shLkyA5KGvHOb4qDSbivwIDznFAPcC5Jt5tNVQiUbGKYRHZ6jpAuIMUZcoGkGAbQ0ZqZMt5r2UkCzkX3nINpWXS0WGxg6d/Uv4RhrpZcKGaHH9ZF6YN1Q8T/swqrGGxkZ5Dw8Mv51ikvfQaWnE1Gbfh5hbmRRbNCEs2Yn5MiW428A/KuA9BzbVPiTsut5KOB5mi1/J2QIfY12JUBTKcWh9F5wgzHXIMP9i72YH7nMzrHsoRreGe5nEwgDuGqCLbMU1GorUq/SSrK3JtO7XANFkiFt3e26rVlva69XBs38vDNP/g09Xl17nt8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(4326008)(41300700001)(2906002)(4744005)(8936002)(8676002)(6512007)(2616005)(107886003)(86362001)(52116002)(6506007)(316002)(66476007)(66556008)(38350700005)(66946007)(6916009)(5660300002)(1076003)(478600001)(26005)(6666004)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DsoWxVtbugW9vwM2OAnhcIC7g19oRsdv+Vbf6pITwS0iVR1/BxNHFgquqCJf?=
 =?us-ascii?Q?L0br6ynlIwTx2Qp9s4f1ZSHvEqRHZN2uhN66TojNWL3UuWaglgSq7vwv9g3H?=
 =?us-ascii?Q?bRBMl8lycqwxta3lY+wY8Rdsn/oXX24VZNn283jwgs4241UdH3JYS0R1Gn6c?=
 =?us-ascii?Q?Z8UvIp2t0z8BLfyqnuIYHSPC0fyaDf5Ty/6J+pfinkDRcMdyc6jBThNKIe8s?=
 =?us-ascii?Q?AskOowLpIWSPC2WbHeY9dPVDwkl1QAXwqiInhMWNI3p0mvdZOYy+4bVtfkZr?=
 =?us-ascii?Q?c3+8BXjV6aVc74CvAU0enoafNbaVWWUlSxyq7rdC2rIra5Xo5vBLswKQUHnA?=
 =?us-ascii?Q?oH+6f48uMJHuBc4HZMjYKF4W6jfnqWtXdD2Wwq6VILMtdIJFVBhyqa6Jfcxc?=
 =?us-ascii?Q?YUdg7BQiD3CJOAB+8sW15tu+xNgkka8i9kHUHAksHFKzyNjcfg+NH4teu96v?=
 =?us-ascii?Q?8RwU/+zX15cThin/6EHZ282xB1nq0pfEYnI0GluOsaa3nFAwCiWWmSNrOa6b?=
 =?us-ascii?Q?LMq8K4etrw4iwjFztnFH10AEMyaiKKwNXclIqixYrYbQYXyX9+4lxPXQPYiO?=
 =?us-ascii?Q?xvKyGPf4tjxx3nYKbiNPurn2EreLZ9nVpUdMr88S1J6DCf1x57hFRLqbdx1R?=
 =?us-ascii?Q?+dU54Hy2MEW4LDxNenbJHRYVa4WqHTRdhTcOPlrgUSYdJU3jwXbjIt1KqN6t?=
 =?us-ascii?Q?7PcBa/Q7+kTrk6EVCpDvvgWJJsQyMK5fSGqnXXh2S+Quegl4xOoe3ar9vp9p?=
 =?us-ascii?Q?5BUf6aHlftieh/nk0V9LZP/B0gY1VegWWRgtUsktbLdQ8B2UybPvIYcLLfPa?=
 =?us-ascii?Q?M7fdQ1EgHXCAAclRhn6dzr30tw5glWcw8tlG9sHvflK+DU57mHSx7D+WKu2v?=
 =?us-ascii?Q?Q4n0hRVdZXfvgobO3vdNn4UBF4pgQmPoXceuhZzBXOBOhxERfH0idigukJcO?=
 =?us-ascii?Q?/URwRVc8RmQQbEglZE9N+ztSkq8xOGumqedVQmLdFKsNHVEw8lCqRi8c0j33?=
 =?us-ascii?Q?j6moXkYdPlA/6dYMrJYZstQZWeaNkNkQdnV74KL5hthhqrDOM/yu7oiYuUvT?=
 =?us-ascii?Q?PQBnSJqy+PmdPPyN4cDCNVEqjSmOoyX7HwiegBttlQ3ATyUDpZYdEiJKNfgK?=
 =?us-ascii?Q?85uvxvB/sVmUGLqCpeEh6/E8kiOcBHum46Re9erusPHk986aDGtmMwF9vPYk?=
 =?us-ascii?Q?jIZKqehomneh+g46eDz+zchPCghtL+270enwtPRFlenFJF86CbbyZzNdHCOh?=
 =?us-ascii?Q?nYODY86v2e9qGZF/b18zWTF4D0mG10QI6AFnB9sP3ciLgFn1svqpSyH/rSWI?=
 =?us-ascii?Q?Z3qZ6sO36OQrStwfHKpF0BWPQ58nv3rcOTA7KegrhQHOeLXED+i50NbuziQC?=
 =?us-ascii?Q?Kxe7/DkuOP88vh90nbf9QxlBacK4bDGwMIACvQrP02LfXQo3wYS5O2ccvTti?=
 =?us-ascii?Q?S6Y830zEV4MLVds1me2NDT8Jcamz3aP2fDmcAUpWMOrdU+PpoYSes7ymPXgz?=
 =?us-ascii?Q?QxADido+BLazSR/sb/dDbqwowP8WigNSyzRSh/UBMNnIKqPHLsMapF1dDzwI?=
 =?us-ascii?Q?1BFcHPSQKONOk7jmw3JdWKYGAFuGC1nq6l3idX1AQwzgU1KCV9i8n/eQhrXq?=
 =?us-ascii?Q?LFqywBDPvpuBC/hLTRcf2iM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10038ec7-0fbb-4b63-932f-08dbeeeda9e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 02:07:53.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLEWB2YQr7Eeb4pdqVmJM0cFun/CyUm/x4RBGge7PQO6l5QQzGCt0gpJt84OXoJBfaJFzu1L4xC+vbHsdRQUXweuqwNsyOtnqJjHY1OjTPx7tQYbVkt5A/ZY6pmygIT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6381
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
and kernel will not use the "classic sparse" to do the
__pfn_to_page/page_to_pfn.

So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
This makes the user applications (crash, etc) get faster
pfn_to_page/page_to_pfn operations too.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/crash_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..9653c4177191 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -765,6 +765,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(mem_map);
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	VMCOREINFO_SYMBOL_ARRAY(vmemmap);
+#endif
 #ifdef CONFIG_SPARSEMEM
 	VMCOREINFO_SYMBOL_ARRAY(mem_section);
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
-- 
2.40.1

