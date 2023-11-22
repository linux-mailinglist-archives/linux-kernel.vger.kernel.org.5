Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ACA7F41A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjKVJ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjKVJ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:29:43 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20728.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::728])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41D9D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:29:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tka/BcHJ1A1pHUxVeZiRPz71/Bz2xasjJJE1q5WfEBf1TGsjziZa4ebVpTVkTEztkcZmjzdg38P6Dy4kBYgdlaisiAaYwBt8hE4KJscobnqvtxcHQgwINCVsC2QMY02udDHaio+9+zLoO2L2gxvQ8JBQW36zeh7otVL+ABhaLk9b2K9AlEt3cqHa0Uq6Jzobu2d9pOk48kg+/no4c0ClP8lCO0wPgXajc9lSX3Q7qmTdor5dOayCCs975Dh7hyyGAwmMlGugUg3bYa6ranFelaAxtwnqYHX1ZC1QYD3yjRLiGcC4LjViOYVb/PllhNleP4T0z9O9DUUYeGMsVrNg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pay8RLURv9xvPTlrsOKp9t2P6m8vcas0tiorJjQlGiY=;
 b=dv091JBNdHtPqkZKs1Py8HJs5hmUV40i0Xk+fRteYgQrz6hKG+UFGyAZ0FHUFjw5wr/uTmt16K/7j5CqXOtbCaNy93+9g++snncnNTOQrQiIePPNl5h2yvTjPhF0bEzWEShXIKDLb+MpBizaWScFhptFpA2qedu2mLzlTIZ1B/CWT7SmcelnDhgZ5ynDLXUJf31rH0YNrvSv3g1vqXzT0noDGDJFBCpKxh5tcNuhuMOysdnOyrtzqKUj4B6AvBpJGwkLFv+EcUt75+tivBHeXlfz4jQ271T6zyTvZ51RZdmjON1fwDtEKmkaalj7MukfvcaX651RDyyfVxNXYI+6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pay8RLURv9xvPTlrsOKp9t2P6m8vcas0tiorJjQlGiY=;
 b=VjOF06nF+aTlLrdcBTxI5tJswRYpa9PeSRgZY7XgPmQ/zNZs9prWpt0MfvSm86bWyl3R3vHfB2x1T2fFaoHCbDCndrsz8Llbaer8yHuk3syjcjkGk4Et35yhDgMhkyduIZwRXEtUNADxwM+EP7lMSG5EAXO4mnFm+0OCqShAG0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 CO1PR01MB6760.prod.exchangelabs.com (2603:10b6:303:f2::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.18; Wed, 22 Nov 2023 09:29:34 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 09:29:34 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        robh@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
        patches@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH 0/4] arm64: an optimization for AmpereOne
Date:   Wed, 22 Nov 2023 17:28:51 +0800
Message-Id: <20231122092855.4440-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|CO1PR01MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 49059411-ac29-48d2-9a53-08dbeb3d89d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvTl74pwLEX8iRjiVNE+SHRfXhHF5yovzc3/DiaXd13eg2x+MQBG4gGIM9NXe9iMSw/mzWpa0ADpBMaCMcowsmuxM1CiKIGvFRet5Q3fhEFPgaVXgAaHliU9NYQArSEamRj7fc+uO9WJk4sNAzJGTHmTyhbn+cSQDReEqJ6gnsyoOVbo4RPtivDFsvRIC9KRR9jL7FneHCJi0yky8yrnsamHdoVpV53qfl9QLaOiu5tNtnMtnA0vwkI25396fxuenoBS3PS+rwZLMFL1ZiN6zxcC3x/aMSqUKesugcTzf8tOtnruudyPC524BIuSyga5avvz5bfay3V1+fMjfeZE84S9euLxRUzP6wX7+5l3S8dDUQ1eIlyv8mRo7H+4bGdlAk34gq+hLK53lR8j53g62NvjW/aM+pGquJF18adHnKcoujOVuHTD2XuMo5ay1wJO4Mb6HXFlbshDp/WyYTC4VAZyOCBndhnpMmfptFVjN1QWTC2RPwm2yIJBZX1pzQn/vyzQDGaDsTLeD8UrERAKlqFcGiDrezySz4cfLTkkJDKD8Rpq5hm3jUN3phpaioUNpDol+xQWgc6TNgTjbNDKMFr9poYXo1dM3hHqHm1+IRAXvErGs1GzqUwKv1i4oDOT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2906002)(86362001)(7416002)(5660300002)(38350700005)(6512007)(2616005)(1076003)(26005)(478600001)(83380400001)(6486002)(107886003)(6506007)(52116002)(6666004)(38100700002)(66946007)(316002)(4326008)(8676002)(66556008)(8936002)(6916009)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lz1Y1jl4q8J7Qg+b9TCeJOZVWLEquVqUGu1KLfGRdr1MyCp603tTOj0VAJIT?=
 =?us-ascii?Q?s2Qa1fy0J1f3Pnj6j5QXDW8vEQX8F0I4jdkNfQFdIz5W79v7QF3D7s3qE7cA?=
 =?us-ascii?Q?BSt0vJR+xj80j2kjA8/JBEKFPhIAWE41q09sJQ2Ch0uQjIBRJgIa2kAAAghY?=
 =?us-ascii?Q?iEuQ+E1TD8xu4ZDkOhA8khFTSl9lOiaiOXna4Z9WI5n3NMATd9zOAq8PAw/k?=
 =?us-ascii?Q?UwefchrDdwrYZ11W8KfoqLfXPXK8HMXHRDXJFQfm2a1wTIJaj6KLVO2+bBao?=
 =?us-ascii?Q?GBvrF8hY71lDVIYdSj4zQ50UPv7aOT1DxH7aFZqUrv028/W+cUy9yG6RscCm?=
 =?us-ascii?Q?TC6+WyE3Zby/xtvk8JazdVWQMn7JoEArRQG4KsG0G4qUCM1czsGLm1MmWrdQ?=
 =?us-ascii?Q?sOuZR6FZVdGu/HQLlWkbvSHIA80/togxrgYbD2PtsGOBOnpKYmCbjk3YaytH?=
 =?us-ascii?Q?tyD4YVbEH2H810lH1vSe7rgwMvqizIApFJxhFW4ky/XWiyrQpar7/zRBEA6L?=
 =?us-ascii?Q?y+CXbZ5v78S4R0ZEDLwdxcglojwC/bac+Sr6kqd2cXlBYkphnvHhwt2Zaq1y?=
 =?us-ascii?Q?NH15Ip0Kp/4CachSJMKuy0D7JOsFq+zZSmzYsNC7EPwW2bmXNmdrAVIVodyK?=
 =?us-ascii?Q?YE2lvrFf18SSkqJCuZuSrteSur/EkDNM8IddFF2QQM0dIU1TOJG5aHyDVXHb?=
 =?us-ascii?Q?/u6Wjm1dx0SeI19M2E4lJJJs4v6BZd3DyAlxU4oCdm816gSO2RA/fZ1cYLJ/?=
 =?us-ascii?Q?75FKW8I2+Sx4C3EIix7fQJbWGueVmCZQ0TyGB+civlOc9Ae3R1ukJbMU6lm9?=
 =?us-ascii?Q?nlM3yCqDXdfXrSd6/1hLfoZDAVbPDKGi9MU2wjpInx8zX5yGwZ1Ynq4bQMtr?=
 =?us-ascii?Q?wmO4iD+rBpwSEyMQLP+urheP+Y+vX/bqwlNYSmNLL5WXeh5PL5OcDsDnXXxI?=
 =?us-ascii?Q?P1q25tlKPlQVMaSXhS0qMnqQq8q/V6njNqRqrsnfhU8LSpj+2YYeVFb4J+lQ?=
 =?us-ascii?Q?3o0uWMkPNpAsO11N0kVCFZPENwSTPdqFrL1cbJ5HKPWNuti3CkkbV2TDyJw9?=
 =?us-ascii?Q?MWWlAM5aAMpTgN/rAIc/qkEvKqpLjfjGWtFdSClmQbbrr0gh9epco1x4b0M2?=
 =?us-ascii?Q?dX6+xM92ducMV+hCEiejoKEXHNkDrxXkHzK1dir1i2TYwZgyT2g1eHejEZFS?=
 =?us-ascii?Q?PxtpMex9jBiuQ3w3YPjGKVh3pymsbxhx+iRanslDbCeeDNM/4pvTYTy+DyOK?=
 =?us-ascii?Q?ho+ELbBn1qPg3PXleZfDBxRi7U/5evi25nbc86TFVDaQz7n2803viOt2+1dw?=
 =?us-ascii?Q?sGyJapeXiWR2Y54cHYKkEBhDNmK1Bkvgdqx5ZV3fRK2fqIJkdSIHBmJ+nDjO?=
 =?us-ascii?Q?lhWii4AaqLVwzyj47I4XfwZWZR8tQf2exzFH87SEiUeZcJVinxwLP4ClNq3R?=
 =?us-ascii?Q?eXzhSwNDzO/uOixjoph17RBAls97CmJ1Gas/jflEOxqJItl/EZP5IjPVlrN9?=
 =?us-ascii?Q?UFC0N1Mv3fo428CAwEkcN6BNFSX67OESCCAVQBUQdfdsMuzpY6gPz0XJnl6h?=
 =?us-ascii?Q?q+ezV5vUybPqKO2Bv7weY0rZLIXJYhzvgdw5ePT1JCtzYkBx4AUoCrd2HPXh?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49059411-ac29-48d2-9a53-08dbeb3d89d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:29:34.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6gAJyveqbvRpphzvpEQOz+MmmxjkIFnXlWUX1rQTI93fvB36VGl7NnQlQ77vTtRzBTLqcHzBQXe3uMIr67jm7GkJPJm9ZI+ix64wOOQ6pjCp5kzGitgtjAsr7TvyrB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6760
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0) Background:
   We found that AmpereOne benefits from aggressive prefetches when
   using 4K page size.

1) This patch:
    1.1) adds new WORKAROUND_AMPERE_AC03_PREFETCH capability.
    1.2) uses MIDR_AMPERE1 to filter the processor.
    1.3) uses alternative_if to alternative the code
         for AmpereOne.
    1.4) adds software prefetches for the specific loop.
    	 Also add a macro add_prefetch.

2) Test result:
    In hugetlb or tmpfs, We can get big seqential read performance improvement
    up to 1.3x ~ 1.4x.


Huang Shijie (4):
  extable: add __sort_main_extable
  arm64: alternative: handle the kernel exception table
  arm64: copy_template.S: add loop_for_copy_128_bytes macro
  arm64: add software prefetches for AmpereOne

 arch/arm64/Kconfig.platforms    |  7 +++
 arch/arm64/kernel/alternative.c | 18 +++++++
 arch/arm64/kernel/cpu_errata.c  |  9 ++++
 arch/arm64/lib/copy_template.S  | 87 +++++++++++++++++++++++----------
 arch/arm64/tools/cpucaps        |  1 +
 include/linux/extable.h         |  2 +
 kernel/extable.c                |  8 ++-
 7 files changed, 105 insertions(+), 27 deletions(-)

-- 
2.40.1

