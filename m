Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB17576008C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGXUcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGXUcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:32:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2106.outbound.protection.outlook.com [40.107.94.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5231C19B7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HofvsIC50kNOWSoWSUX1tGpAQhiiEhRt7Yhp0ECIrBPToeMqQDS5ZqoU2w79f5dT9siUW/9K+Qb05sUaUXL2P4tWs2Xy1AZUXStQo5ReVyj3sW288Kg4Ao+qs7z/tGraNa/2GP1WRSZv9TA6YveRIeLu3jf7Uz89bGSoBrecxOc2HT1SbrLyYaeIwx7bU91M3sHixX61FfPtvGlrhoxINLUeERE8VLMBCWzR8lE7qOeP78nsayp1NaRHp8BS8m1+MWH8v7dzSQ/FuDLakgJ2f2xr0KUWNua7ioMH9HrcLdFI7S9q+M6dj1loHVT6ruJZ8we3ZU8ig1njBumIzUcmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN/GFiGlihbN0zIVYJUg3FXA6ZKfUgPVfgmd8g4YHLQ=;
 b=f5yWyxUoAl3trHWoy6qRMNEDFy2jinRgDbTAxAYTTIcFBjGoyc6bNfKxuDskjNBy+Xiguku0CE2hmLX8TE4rNB65sb3Qq4P+ZVhgAzLeEdp84AxNYKcS+E7/DxeYYheKrkkVlnY0qAqL0Dxl0xHbpsk1QDw4cjkRactV6uhhi/ZgzwfL6LcUW7MxQtvG5nEU7wvJrgWc++4ZCjiBGXcT9Qnmf9ioCn8P6L5Ol2N8Xs3IaUq1sNkEXiu7G4bOlkuz8Ivm46SQYwYKP5mSsLhuQ8OoD2jlLYNDXCf4EUVeo9zd7JCBpSOsmce8A/YKCnV0PMApRWkykbe4YGuI2ccUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN/GFiGlihbN0zIVYJUg3FXA6ZKfUgPVfgmd8g4YHLQ=;
 b=ZbqF/v6mIUuLsRmW4218y02UocMSgQ6eebZJbhZeAae5uL46Yq6Q96LXI3PZmn/eBwN4zNiSIyaycRonolYdIpFb13UC6/0LlMKl+k0wCZt1La2gMYogPz6dMqN8MIuXm+5AZd0Un8+Ace9R1ZaRgE9436n02A9PB9RmcQhO8vA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 MN0PR01MB7659.prod.exchangelabs.com (2603:10b6:208:37a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 24 Jul 2023 20:31:52 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c58d:cd3d:cb50:e870]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c58d:cd3d:cb50:e870%6]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 20:31:52 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: Re: [PATCH v6] arm64: sdei: abort running SDEI handlers during crash
In-Reply-To: <20230627002939.2758-1-scott@os.amperecomputing.com>
References: <20230627002939.2758-1-scott@os.amperecomputing.com>
Date:   Mon, 24 Jul 2023 13:31:51 -0700
Message-ID: <86wmypoxu0.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:610:51::13) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|MN0PR01MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: e53d8cc6-9834-4340-d10b-08db8c85034b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9sQCtDABP/BErs4+PyrQ1RALOQcwF36Ow5YMPon2Y/C5qrXOagFpHK+OZ2kVxAEN469jEbULEoEdpbgFKMd/3srIRhuY6bjaoJl2CPNCF+baXj4Xqggmxib4LjI18XNoyHxyJU+ZXPYn+uerE+lENe9j/gpuB4jGLhImS69vfzdZ8AK0pGZkjSFZSWosU0UfBIbXsgvnV32qyFmWhenJizievcSBoyQ74CwmKWIkD1FUTxK3d8TdyAH3E1sLdnbfiPTwA5K1YlcSbE6i0o+Es+Yg3eKOTFyw0s1uDvBWoELgQhi3BcgzaVsTscjtHmkqAEmWIrTj8Uu828bH1gMOZ7KSSgPH86sPbiO4G7konbEW6ExCI56cWy1hwOoTBNVt5dLAscc+ddWqgZJXAn9dcQQX3TfRzp/ximvkNPqBW0vxtFqumZYhvWyzx81zmt6BnBbgUWQwY72AaAskWys69ry1Fa97iHX4UW9aPQsSdUqsITv4AybSffOtOuTf8uN6SWYgXjjbQ0VPaSoJJMSvi9W9WhsULklxNwMp9cU3xnywoPuUVVVUPYme+8wN1ZsulxMIrsC9sMll5yhrSCXJMnhmkp1iIniMeU5gY4duWvLlm64tzIIgF8+ZH+wPY6a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(451199021)(478600001)(52116002)(6486002)(54906003)(86362001)(4744005)(83380400001)(8936002)(66476007)(6506007)(186003)(9686003)(38350700002)(26005)(6512007)(41300700001)(38100700002)(2906002)(8676002)(6916009)(66946007)(316002)(66556008)(5660300002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kI+JOI7neWPaCxxRHetqD0NZzXMhuyP3p3JReeH7O2MjPUe/CTuduW5bNjmM?=
 =?us-ascii?Q?bDTqetHB7xLm2TrFQseLiFDQcnWLVi9IRDN2jaol7AOai40o/JWKoQawMFIM?=
 =?us-ascii?Q?rGtbZ0bs23ePENZYmbRm6fCvMiUMQ5aBJiA6TzFqr9IwqdLU4jYn08MxYQHi?=
 =?us-ascii?Q?rAPFdyGRWz3pHfpToQks64rRSS1j/4kbsMWWKXnoXOPmV/NaD6c8GxznLfIA?=
 =?us-ascii?Q?vGBJyCPYtUnuxzZQkMaGb2fEP+OR7c7eCTcx5QJH6AvIJdiNRcGVDLnDNOdi?=
 =?us-ascii?Q?rvJiHpYp3TYqRMg7vMnHMO8wmfox+Dv8D57eXUAkLPFJWa3MJFSlh52Gtc6S?=
 =?us-ascii?Q?Ucny9bCL8PUf6m+iY4Jx0cWqumr59py0NvB1AdAuY6fHPu/8iEHZGe3mY3zr?=
 =?us-ascii?Q?1PxDVg5r1IhHgYVCsY81hVbuhhfv09eE13rssxQCXKqsAX9C1dIMqZFL1L1S?=
 =?us-ascii?Q?DD+l6WFYwlS/202XFVVH2Pd//Ryf5Q6pDl3fctymxlESSbfGxjvV6UGB6unF?=
 =?us-ascii?Q?GNlq8bT5H04bGtVCxUx45LKGMO482nukvPRyppVTy4Vvsp5g0B4BmBTDwoZ2?=
 =?us-ascii?Q?o0InCFwCQuZ6Agek7/P2Uzrm2FjCQ/QEbXrv0Pl3ittqjhiIpGtvt3UkPKmR?=
 =?us-ascii?Q?p9kYkXLWbp4O7XNUXQXLJDbjFAIftsnbo8pKNyKItECUo5KCec+QNLuPlWGD?=
 =?us-ascii?Q?P7vnGf5KQEchHR2W7B/45+dyxP1vhaaBVnyG7EpdMe8OEjBhKPQur6cKedB1?=
 =?us-ascii?Q?5VYwZmXWL6lOrTSaZhoNpLiiX8s7+c6KPa/yClNvvb6nWW//z4r3/43DgHik?=
 =?us-ascii?Q?bWCxxilfPN6WPygpD5Sh/jKpbe6YM+KrbwIC8lw9/0MesSIO9/QYtEyXMrYN?=
 =?us-ascii?Q?Eh2y6EcDYTQMRxEjFaDAg0Ly6oui68xQwmwgLaasB88HaSq07kTbLup6fX/m?=
 =?us-ascii?Q?IfkuLdYfBwwrJzIK+xcG2K9DEtltC5Ey179V8sAgdHgYPEdrWHl9U+VSLPTF?=
 =?us-ascii?Q?RM7crf3HOfo3X8Y5Wp/acJsBtvHU0E/dtBNn/0MTRzqH5YQEP3dp9BaGs4+R?=
 =?us-ascii?Q?b/z48bSnnLJQyiu3pHxudXazujexl5ztK2RyjVuzDSSVas/WqGbsLnlbz/hJ?=
 =?us-ascii?Q?2E3S4/qMTDoQuz4+QmrSTAp/IDKemJPYmPFk520AKqQcmWcTYksGOamBqaF/?=
 =?us-ascii?Q?sCfBgUgr27dZE+CB4L0D+OgPFR8Pusm1i6UFA1Nht/T6XvJlEobelG3z7A4V?=
 =?us-ascii?Q?z4p6olR16GBlm+8b79DNJ1oek+vAxlwzW4lXl2yYMpZZBHTXPJk23SHSVY36?=
 =?us-ascii?Q?NzU0CMYuiHEySLozV29eEOTBuC0cVqo3Nf2pZbS16/ljvxSC1Ymm9/ke9jMe?=
 =?us-ascii?Q?QhkmAlHZ5xd6L6LpUZUqgIQmuVYa6tpqOqKFb8/eY7EqvKzS+M3WrdeKNSdM?=
 =?us-ascii?Q?X9JEvTpsJOetVCsR29Fws6qtz84UdZyTjxPJhA3RBy7FjrDmRMpYATIb9/Wt?=
 =?us-ascii?Q?W9Ge9DUx/5PHN9I4gfwmkL8rk2zp13qyJVucMOFV2Cxz1J/wDTEwepgCuyPq?=
 =?us-ascii?Q?OPzPQ+KX+7VPxzgrvZbToaf20vm21ZfjqaGlOvj8vFftcevsef6xe5h56nM2?=
 =?us-ascii?Q?Fd6kgd9WsCXF4b0d8kGIi7M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53d8cc6-9834-4340-d10b-08db8c85034b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 20:31:51.9343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PwEAvbx9qC4vh7wBayTIw+9ZSQi+pE37om9fKp+BBGsZ8g1qRsSIhjR0lMZSO/ItPmSEwVAeS4zMxb2T4fFBeLvqYZiyD5NP/58NpNUD8ViE1E4YyvhEVRyYxPYBQM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7659
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D Scott Phillips <scott@os.amperecomputing.com> writes:

> Interrupts are blocked in SDEI context, per the SDEI spec: "The client
> interrupts cannot preempt the event handler." If we crashed in the SDEI
> handler-running context (as with ACPI's AGDI) then we need to clean up the
> SDEI state before proceeding to the crash kernel so that the crash kernel
> can have working interrupts.
>
> Track the active SDEI handler per-cpu so that we can COMPLETE_AND_RESUME
> the handler, discarding the interrupted context.
>
> Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry code and CPU masking")
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> Cc: stable@vger.kernel.org

Hi James, ping on this
