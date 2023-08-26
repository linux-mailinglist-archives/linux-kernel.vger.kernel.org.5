Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5905078935B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 04:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjHZC0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 22:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHZC0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 22:26:21 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012003.outbound.protection.outlook.com [40.93.200.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23A269E;
        Fri, 25 Aug 2023 19:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajctW6ZWEFuQNmcmZNrlc6AlB1QFqeH2pj0KTYufVg7K5V4lDWTM9nHtPuisqD0e5wjpHukrHsLlLwru4MMgAoGPD+mFIUBpRhVcrGZD5Lt9qc4CtQOYklFKFQPJpMmQsyrb5YYQY795rhi4MkXm2VMqNjQpaurJq536qq+WKRXqAeMMXycmm8HkgbzfXhs37YV8QyV/DA6lJ6bV/3PpF77seLvB+hR7THAcKOX8LqFAskK+10pXmB9MBIE5R//js4WDXOAenYW5pBrTv5hSrynWOugrEY9eZhS0opd0heltP1p/+28uzstZf+r7Y0dB4HWb0gEZ4lN8ri+N8dgHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuWk8xUZ1AkOK94Lb9X6dnCUkPL/9elKIr1nvgLD2NI=;
 b=Zl0J+rnAzsxf49UzIOkDvY9AYPF4wu8mFgbo4iCd+kOmD2v6L5qmnDGEqr5PN2BQFJlOTJSpuWA5FjX49WZxXctHCIBxcz7waRlApnxIvmX3W9L/SiPi7pIcLyvQQaCn3Uu5+Th58yqCRBvdgvpCLsoOKfIN23CxegHDLxoeAfk2aew7+ADnTLn7hmibIafJfWWFsy+fZ6WB1kjRTj32AN+JgF0cWvT8A1yWNv8LgEyY3/+Oak09c8pExu7jTGJQijS3fssefUffbEVpAuvJc6Sa4qf6xz/798mO2VybNxdAJINSzlSvf3y+5+V2Q02pOoe0kFPSFnLn6fz9OvjZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuWk8xUZ1AkOK94Lb9X6dnCUkPL/9elKIr1nvgLD2NI=;
 b=0EfWgqlrN38zxo2s081wjNjx3bynr3FSDhM5ZK6Di3o3fOf1ISr8EbD+cOvuJ0ESJBEZTl6l710xwulOpxJ9jtZv7HVC8L50PEOQ2VDI1mdsW6jHWb1kTO5+WsjhGS1UEOjgyRJhQkInCmyS2KOrOdrpsux17fZ23jw4hK6cNuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from DM6PR05MB5292.namprd05.prod.outlook.com (2603:10b6:5:5a::30) by
 PH7PR05MB10343.namprd05.prod.outlook.com (2603:10b6:510:2f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 02:26:15 +0000
Received: from DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::dc67:6f45:fb66:add7]) by DM6PR05MB5292.namprd05.prod.outlook.com
 ([fe80::dc67:6f45:fb66:add7%3]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 02:26:15 +0000
From:   Srish Srinivasan <ssrish@vmware.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, patches@lists.linux.dev,
        borrello@diag.uniroma1.it, peterz@infradead.org, pauld@redhat.com,
        rostedt@goodmis.org, sashal@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, akaher@vmware.com,
        vsirnapalli@vmware.com, amakhalov@vmware.com, tkundu@vmware.com,
        keerthanak@vmware.com, srinidhir@vmware.com,
        kashwindayan@vmware.com, vbrahmajosyula@vmware.com,
        Srish Srinivasan <ssrish@vmware.com>
Subject: [PATCH v4.19.y] sched/rt: pick_next_rt_entity(): check list_entry
Date:   Sat, 26 Aug 2023 07:45:35 +0530
Message-Id: <20230826021535.9065-1-ssrish@vmware.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::13) To DM6PR05MB5292.namprd05.prod.outlook.com
 (2603:10b6:5:5a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR05MB5292:EE_|PH7PR05MB10343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcbed87-83f6-4687-d228-08dba5dbd26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxX4C7qi8G3VpHi9C4mx3gc36N9DPV2L9xkWJ8KzmdH/vML7KJRk5TpKyHihL2OKZD2uXg2L5F5p2lwNH80h1WsPDcQZ/U45IWkwiv4Nr4Z7WN0lTAiLmwDYDzzJflPokxjmDtfG13oa+9kuCGVFmeFB6R5jhq+bzPcpsJU8Iph2eCyLt9YFS2nnlVfRYaP4azngRGH+V14VeFvmnJw+7Kymu39KpmoXtLVZDVG5yzRtdNfMimAlNc+y/TqL9gxDMKStCCN4BdZd337KngO8PlydetvuPOdReF9Nh+kakUTSLEkosE5FQ2gcnqVhKtNEF1R/AL7j8Kdpgv8Ct5seZKr150gPLt4KJIutUzGjRTizNS3rptrCTNGyVOp2WnzzD0Axx27PXpz/upyTqqbYsTZOHjHruXG+I+fsnKxpIlTjRWRW0H+joGgOLqrEUekMEqurY0PXlu9lW4cPXseprVPdhC1am9b4dHwkayufwoUQ8esTIvkeKFxUjExxZ5mv95Hm2pQ/c2N5YpiFPtuwCUpr4GLLvySYo5dHR32rkjD41c/S0jH/Mf9gqVzVG7/4AxglW3dUyyN8R8f5xw1pyno976KgTk5d61GCrNrxIYv4TRP7DTal9LWdq8OiORYE2rMdW/7kmnM8NHtpfT5fdZk1WdwQrumEXpmqdsN1pkffCVW0VceU8I+SG+RxSvNMD8/osjEp5H65KPk9y77gE712XmOVgUeD8vp7bzIVick=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB5292.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(83380400001)(478600001)(966005)(26005)(12101799020)(1076003)(2616005)(6486002)(6512007)(107886003)(52116002)(6506007)(6666004)(86362001)(5660300002)(2906002)(7416002)(6916009)(316002)(38100700002)(38350700002)(66946007)(66556008)(66476007)(4326008)(36756003)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92XL1iiEh2v2E/zzRrb440zr41WxN6CaF3R8GfZ7P5VHoRNok0/SdSfmFLrI?=
 =?us-ascii?Q?9JphvC9bdy2i+JHp3FJMHvEI5oYJOF9GEZMjq44fQI70qMnQ+RYuRyIoxki7?=
 =?us-ascii?Q?KA5sLVX4gM/gdKFuWahMhZx3RhGnTKACK2+m5KKNaYrjtrhGqxsOV3qzuw12?=
 =?us-ascii?Q?0cyYu6awuEuh4kkHb/WKoIzQfyAIRKH8kWcKCOllNbU8T7+uMfiVpuaZ8aiz?=
 =?us-ascii?Q?CSbC/Yyz5V1ye2EyNUe049Jge4eFlUzaZO6amRFOm4UrPxR5WvGvlmtUHHGB?=
 =?us-ascii?Q?3t7AAGXmnDgS8ZYYf4VRP8ZRMkkJcmMuRZyOmb5XbMIRWg16Llw87PeWJnFC?=
 =?us-ascii?Q?Sp+prv1ZjQoohIg/sRq2IHbB1WDG/D+v8+ZuLEWiSlYJHEt5ODi41e29MMBp?=
 =?us-ascii?Q?8Mx5ArWGJ43lbZAzTvUY73q0B7XFXM63oBZOUHAmy/44tWA1/CoIAjyUGbmb?=
 =?us-ascii?Q?e5bwx13L8AB9KTpopEgETrVjyVE1u5eR3VrwlTrmdV0U6xrqcXj9YwQ0PkdH?=
 =?us-ascii?Q?y4KQa+E/GG0X49gigJ04T5o8lQ27h7cDhgMDivixrJcsIu7Zr7UrioHMvufT?=
 =?us-ascii?Q?mJ62Mttc5/uhJIfJz98OSh1EbSGv8WDT/ugu/qBmWyEIq3eSzc17nTLdvvvs?=
 =?us-ascii?Q?+XamFR2f891mp7QjWX6liIYsEweTdQ/Cjn+V/UYD0LTnXDjQchOiKe0y92Jm?=
 =?us-ascii?Q?VE4xfqSDSuF0BfT+xiApmffqpgwcXX2cp6umZdyCxRZaYpRqATB1246dmyeH?=
 =?us-ascii?Q?xKCMwzwPjdVfJbE92NDA0CDBI++BNrLknG2/4GkoFvdF489fKMF+AefGU00Q?=
 =?us-ascii?Q?Qa6/xY7xHrVhmu6OciBYvQ8UV8ZOwkHiVg25Itc30ppkcixqbMVwa/TUf8ie?=
 =?us-ascii?Q?UnIdEcRKsqkZ02XkkKhuyhQ18dCiPeqsH7VKphv6XqQ3OkJQNs8PJHm3JoGD?=
 =?us-ascii?Q?5I9SFcXZRXgB3xumuocyjmiIxyZxdkMMufkXALBscRi3xdkYibURk/7PZm9U?=
 =?us-ascii?Q?nycx/u2c07GSHT8dushz/wacGM28eib7iW523qk+zo2NNvhjfQiaFQ3OilrC?=
 =?us-ascii?Q?DXRlp1s0tBi+M4kt4xWOcWlZ3cGwd6SdkwUEghk4CmAni7D2R0IWe0QudmHO?=
 =?us-ascii?Q?PLeuH8RKOpk/+fa60eq9UWqg/Nt1kun6HCGSGraCUM58D0p0KwsJu4CwGLMq?=
 =?us-ascii?Q?6895DuBcaIry5cmswljfMeDtXaZ09vsqJA84npnAEAIx/aK3IUWkGdPwrezq?=
 =?us-ascii?Q?f9+h3LAHFpNf+3biiu92hy8wsZ4JsX15aS0hTNuPzu/U2A0MXU+gjRuma83E?=
 =?us-ascii?Q?u5pbyUpFRL/4Z9GuYLg59Pxt7xGRd8np/6+prYyDtBCkoKw5iAacsxN5U8rU?=
 =?us-ascii?Q?RDdj9Kr0CCUzViF1KimWzrrsqGDTXnFwgO8yW1j40wkk9km+kUJlnp4PjWz+?=
 =?us-ascii?Q?YVvCZ0TVDFA5iwuv/r6wobxw4QocsmxCYSV23NDD/iv1WSawUY93efWQc1Jt?=
 =?us-ascii?Q?luAH5xXoyeD1ErB7+RAid9aC56s60xNVssCUwxah4NKckKrSHKeBdaH4I4/L?=
 =?us-ascii?Q?0MI4ONCDjpTbFik8+GNCj7FKActE9Qu6Rofta4mA?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcbed87-83f6-4687-d228-08dba5dbd26a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB5292.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 02:26:15.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYF6wxq0KhlemsnUb9xYWla29JEwmBfvQlpa4eNTQD+tOe/AJ9pFibHkAo4aVTTOQ/4an/KcuDHVR7xZcDL8lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB10343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pietro Borrello <borrello@diag.uniroma1.it>

commit 7c4a5b89a0b5a57a64b601775b296abf77a9fe97 upstream.

Commit 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
removed any path which could make pick_next_rt_entity() return NULL.
However, BUG_ON(!rt_se) in _pick_next_task_rt() (the only caller of
pick_next_rt_entity()) still checks the error condition, which can
never happen, since list_entry() never returns NULL.
Remove the BUG_ON check, and instead emit a warning in the only
possible error condition here: the queue being empty which should
never happen.

Fixes: 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Srish: Fixes CVE-2023-1077: sched/rt: pick_next_rt_entity(): check list_entry
	     An insufficient list empty checking in pick_next_rt_entity().
	     The _pick_next_task_rt() checks pick_next_rt_entity() returns
	     NULL or not but pick_next_rt_entity() never returns NULL.
	     So, even if the list is empty, _pick_next_task_rt() continues
	     its process.]
Signed-off-by: Srish Srinivasan <ssrish@vmware.com>
---
 kernel/sched/rt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9c6c3572b..394c66442 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1522,6 +1522,8 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 	BUG_ON(idx >= MAX_RT_PRIO);

 	queue = array->queue + idx;
+	if (SCHED_WARN_ON(list_empty(queue)))
+		return NULL;
 	next = list_entry(queue->next, struct sched_rt_entity, run_list);

 	return next;
@@ -1535,7 +1537,8 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)

 	do {
 		rt_se = pick_next_rt_entity(rq, rt_rq);
-		BUG_ON(!rt_se);
+		if (unlikely(!rt_se))
+			return NULL;
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);

--
2.35.6

