Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA1378B2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjH1OSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjH1OS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:18:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26357107
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrAEaR67ehvhTzx9CnCElUKzpsxT/OhmqQAw6Z5ottYvBPAhNVupstJ4pXwxkIix1rmZLyT2jL0O0PZebU7MJ7rClqRU4S4EINYumOusgHJviddNUEaN/FxCItLFJ6wcxrrAFSsMepCiInaJSCBIXsUMcDo1Tm3/CAOdf10vWz+bvkViiWSmrL0n+4AkA/iYVVF0zepOGRHAIyVSG47FWC2PuLsKs9vOnEKdfzXIckzY/crJV9qwsK86SSf4qonlHVvq/ZUniOrF6LcBBTxzU9G7srLYWkBsmFVgwwd4yu4EZz89wu5hqvBjfP4POK7sTh2l9SEyzPs1OxqGLUaDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlXMKlTHXdL3MS7GGcRQb6C/6xfciiixRivI/i+VNJI=;
 b=hGBOn1Ot1Bp8uqskJa810SdIORB3mZQ3jLsd5B2lS6sJLfciDUD0qlM1VdSciuc3lnvnM7Y2rSN7TPGFzpHOfapOd+PoYe+ludNr7G0KJaJyK7gvh6pVukOp5eL6yBNlAENMH5bBz8RISsm5vLWI08KtP7G0DNOIwDDP0cG/Mia0xfo0Q4+QuLEcU1QnUVPQ+3B343cuAwEaIRQa1XmhyWA4qoAEe0ISceHQfprdLXrgBT+Pyt5/8dntIc42jSJur+LysihZ7IZLqnPP9Byr2ntrJfkb4Ks6z7xjb6i08DputUZxDwigbbv+gdTuwRbSdmQ7N340ePdCom2oHKPXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlXMKlTHXdL3MS7GGcRQb6C/6xfciiixRivI/i+VNJI=;
 b=SyK638/qNltLKSQf1KVu4mrplEv6BOFPXOcKGLqN53e6jwAkQJkkkEV19QT/0dCvkDIXZZ+7Dz2d/+GeSaZKitaCfHO6DSeZjNNb/pKgR4xJwACI1Zkzf255Tfu6KweLtAI5yR9rLs9d0oZC1CC7IavfnHZBmcz9Oq6Sjchq2gDWUFa19kCpkfENuHcMlcN9aTzEqKPC1WnHbhPBZUJ3klU7fLuGezp/FF3mKvfAADvAKkh6smZz8nBCTHxHisIsTIIjAaHMUwk+zV3yHYqYiRPE4bELyL2he21+SbbMgSed59y+elLNePkQgpcZEnYem4orMye7uSIaVHpPlm3/+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 14:18:22 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 14:18:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, david@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, hughd@google.com
Subject: Re: [PATCH v2 8/8] mm: migrate: remove isolated variable in
 add_page_for_migration()
Date:   Mon, 28 Aug 2023 10:18:20 -0400
X-Mailer: MailMate (1.14r5971)
Message-ID: <879D24CB-B7C1-401D-8046-1FDF1A147BB1@nvidia.com>
In-Reply-To: <20230821115624.158759-9-wangkefeng.wang@huawei.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-9-wangkefeng.wang@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_391D5F8F-58D7-40BF-BA98-CC1034FC9036_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL6PEPF00013E10.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:15) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 47417fb3-6130-4787-9c5b-08dba7d1a2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4bMHZlOcD6MSC8HR8hgnwa89/KB7wm20pfLIY8g8Lv3K2fc/U+LQdrmcWqKg7LUA4Ul/jpiZ1BTXS4puWfCBG2CTtTeH/cW64a6Zv383dY9G/FQXvH0iyXjAviQv2vZC8EwHI/uwAQaJFyzAi0UIFbNFNoZNs3g4L2LKgRx62zVSZjQP+XAMXCsH3Vma8ykawT8it05gDVvvM1JnuMJFhMSFIxcukjAiWBOTG2odKxUg0KY+0EXSdXowTnj3tl9dlZzpACSpsIb2KngwctCJwwhw10nTj2ykYC50SVPcpplR2mYsZILVI0nP9e3F0sBPCmqGIrBu0YfoZzznXziSPqHhYI2nTRBrMG9DZdTGAuSbzFJfArOyF4ceSsp7YfiM1ypRGcs3meTYRN3+3aPHnX+eGG0Nuz2J3EjwLWcBHwRanXkf/DM1xERobsts/ukMsAwkzqpXCgCQqjtMJaLrU3jPNaInKvkLNYzLlUYoJEc+G4O1BB9NOh1HjGOFGsoMHrBFlGXfl8EVYjJUooclmgpSnthMzppM/SnCBdcLHfuP/sKPQgeQ6wC6ntAut6iCGrOnlwRGObTQNvRLjoL+O4ubj/NmFvzy2RPMx6Yki/T0jLTV7v07zQcPolVJbjTVF5CKKDffRf1EuopZ8Iy38A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(38100700002)(86362001)(83380400001)(478600001)(2616005)(26005)(6512007)(53546011)(6486002)(6506007)(66946007)(36756003)(66476007)(54906003)(6916009)(2906002)(33656002)(66556008)(316002)(5660300002)(8676002)(8936002)(4326008)(235185007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yLV2FYIKZwDRLl568DTstddO6qmGwYDPgHFULuOdm3IhhTePREMCjbAAs71p?=
 =?us-ascii?Q?kqESm90zYeF2pNFvXBzk6DiiD2mboi87nkOxLFN6TuUWJBPsVtwmnjfKtA37?=
 =?us-ascii?Q?RZfBDwllviXGw3Q/1bzlyh7NsWwIM1xckrWQbHNDZ+pxrwOeTbHmKbbFnGwq?=
 =?us-ascii?Q?0/jeXEb7E6U13wMTMe7KrpmW0C2ml4bBm+r9uHLy5F3pWNMip1QCxhYxCNjx?=
 =?us-ascii?Q?gnN1430RXBKMY6Line2R7LGzdZOcxelQHvGWSgVOvOhugo+MLMMisVE4ksFA?=
 =?us-ascii?Q?8ewaqc+wWWJ8uA+s8B8IQ5NgDOhLfscazk4Q57ZoknBZ2ob5DuwCnY6ScTLx?=
 =?us-ascii?Q?A/lY9mKN3L9f4cafv5bBwQdeH06ohvA1zOfZiXGi+4e4DZ3KElAiarkPrwRr?=
 =?us-ascii?Q?W9Yld5ZQjvoed7bMvUBfS1vltfa3SAL8WzwqfePmOYyH5e9Rvgo+FssBDSWb?=
 =?us-ascii?Q?T1UKOqNE+RjMc5aUAFV6jtRRinDC2i37d1S1dFl7EHkztvMQR9yC+CUX7ZJv?=
 =?us-ascii?Q?6IzEmR3EmerxCA51e5KJafXA6hoC29lD9rBe8WHEip0KXitM3JLHvQdxqRij?=
 =?us-ascii?Q?9sw8mLdGPaJK7YNvWwx1bPlYzRYm3XOeRI34c//XCydvTX+Ud8wLNq93LSoX?=
 =?us-ascii?Q?iCMNQyVBJr7GQIJGG6yuTXJsG9Bq5ZU7LHaLAcluu9dx7WI6rpksFrPls8SE?=
 =?us-ascii?Q?pcjtFXPATgvuyfT9mPwAVsz3NaeIovOz33ZKRiylFV8eY1q9sJGb15N7jFto?=
 =?us-ascii?Q?ULsguU5suQrxAaRvyUAm5NIUqiKNXiwKT1Mznzxo0laKoNtIwKHY0XXkY7cA?=
 =?us-ascii?Q?2kstNX2mpbOk6cAiYzwINlBgBB0qT0Vu3owtf5sT4cIgVpJQzWHPfmmViru9?=
 =?us-ascii?Q?G2oG9xuW2O9ZwPKkwtEOvdajpMzzFFP71kX7HGPRLWDlK5V5xPLn3IOUHLLk?=
 =?us-ascii?Q?uKnoUY2KzS9jCsWw7rUItlJ29Rf7a5wngdLMm3+fkDqQGLtuWJr5P20pLzKP?=
 =?us-ascii?Q?zU//Pw0CR84+qRA2HauyGj3FsIIPohUlS6qMGjCmQdZFqPH1E1qA7u04htkh?=
 =?us-ascii?Q?dB8XldvYvtKDClEac3Fn9jZXsyCPEXjmCQ6Amn+0USQlw7ZvBunFtTJpepk7?=
 =?us-ascii?Q?lrXPv538HFqlRUHYVwacLUtyP6khbTi3n4zHZjpZU8zw6rakpE5HxSWyhGcU?=
 =?us-ascii?Q?KC9ZTZk+PEzF7AyQ5z3EN4g5fvXvTbq5xcGCgMdqq3k3SvUpaHu4eYpeC277?=
 =?us-ascii?Q?d+fFDnQXx9YHHkqvqicPj8fnacBa9BExouOsY2cDrYxo3lVYSiLQXF1hPdt0?=
 =?us-ascii?Q?8k0oa+nHFYMKnU7dbO1QMcGA++FZvSTvcDZk6+Msxh1qYwQrIFfqbY1rgSr3?=
 =?us-ascii?Q?eF0AzqkW4nvSuB15AHG47EDl592oxtM1vmOAMvRmW5wyALC+wsBs8PorCdQo?=
 =?us-ascii?Q?H3yJ/zEk9PzEGv1N7BqgRhYOhhImLWvvd6VfXfEbmGQC4bpxApHaWixdGT9n?=
 =?us-ascii?Q?VTJ40HzYTc5DYmnOx6hA69JwcHiYaSfbVvw0BuaoeqTFlw0bUjylpEsIoQSf?=
 =?us-ascii?Q?17L7NxeFXXZ+OW5B8Ew=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47417fb3-6130-4787-9c5b-08dba7d1a2e9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:18:22.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uLt9MoM0LQwNZBUclCMf96QyVrE1tcZ08Ec8PZEQU/MOU74KTYja1r0kGMIGsTf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_391D5F8F-58D7-40BF-BA98-CC1034FC9036_=
Content-Type: text/plain

On 21 Aug 2023, at 7:56, Kefeng Wang wrote:

> Directly check the return of isolate_hugetlb() and folio_isolate_lru()
> to remove isolated variable, also setup err = -EBUSY in advance before
> isolation, and update err only when successfully queued for migration,
> which could help us to unify and simplify code a bit.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/migrate.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_391D5F8F-58D7-40BF-BA98-CC1034FC9036_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTsrKwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUw78P/jWqx6BjWr+lv4aTSZxmqzispFMaH+xwaFRJ
M1oAfATavNawAfimU2jbdE08D0BHyFenDRFYWB9YkWtyCdwSlnawCLoCAKEnqywl
aLn3FNHJxAilK2QnIuA4LOxK8hNR0ACyyr3N6f7E+TXEJZ074HXy4eoQAFVy+Rld
chWgDVqczXd2jHNlCZq6p+m4zMN1NDOSKPARr4GxMesDGFIWkEPcfkVgjQuS7zgy
uvQ8BOsYIn8df3hp33N29in9OKJZG4CeoxduOgILlmVchzQgJD+e0B08m/8W8bbv
NtKdUHAKaAfbjmFJQXUieRH+3vEC3yT6z1fln5q2052hxprSf1gYvM3SDKCVpKRD
ZwAdMYdsZ/+RAKpDqI3//Pu3n7LZVKnHVeqHyqxJrM+1mVkP1AasyoAhV9Nyjgdk
BSHeUYdCu8PUisic1VMV1AH/mMafuDbIkEMu/JcCigm6ym9F4OE8b33uhIanDc7T
I1sHWeT6IYkJt/gK9ruJjHlKx8A45UfkIS5IbTjzablBPTFN4K5spnJb/l/BrhbR
bc2hLrbLnHUx8HP8wvm90F+Q4Zx12/e+4EvnvZ6pWcfYBvzulgb9Oe5GnEedtPgK
o1igA2GwKFpsPRkpJxaV0k48Yb3B7SztJXVbDTT+4HcL1avoudkzWZ/yQs7AWspG
0LmgkqxT
=xFNU
-----END PGP SIGNATURE-----

--=_MailMate_391D5F8F-58D7-40BF-BA98-CC1034FC9036_=--
