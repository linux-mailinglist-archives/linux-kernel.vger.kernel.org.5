Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843ED77093E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjHDT76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHDT7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:59:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2239.outbound.protection.outlook.com [52.100.173.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CACE70;
        Fri,  4 Aug 2023 12:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCTTdef9NPmeoc/3HzVTagO53GnVS1RVNX4wwZE/5Qhme8Ov1wubjYYiqpqtjysP7qx6WhNlPkX5OROJWYaSNxuaZIEhfgyZ1t2W+Ll3/Zk5oqX8ybMez+u+R2Cody3HD4GJHbJnUz5E0wJcm55YY2ZevJI83etSnUJLvq+DLGWgj1p+uxaiLES+f2TZiONrxH9bpk3Hot8Wrl0Im+LZxYaxCTyl4UO1LXrhHtj3JhGtvhuMxkUf8dt7lP615vUZZ1giswxkN1JzRMgX+NhNAc7siqqctoRd0v4AJA3ktKqajf/YJAX27edMks7vQFB0/vohgTKyMI+WY+pbBCgCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBY6+BqwWkOeyRqsgv2LxiSRiR/Nz4wlbM/qBRZ0Vak=;
 b=SFyW3WBG9qbLIfaKWlZLalrSDqoJyqJAGd07y6ZRwtfhRchksVMW6jPuH0TaIUe7zaBNeiQUTFRv32wRvv/26nAHb4KJy+zWuLEeYLIfdWNEeJ+JSyuvGMXV0W7izdpJrGzLdomvwHHzjUAObNefDkviBp3yr2E7bfxRhcdln3iqGgJVPI2Rz8sqX7ewRoNuY7hT43sMay5BBh2Xj1Pbvi7nytw6xU2harUhJRG4+PuxiygKDVMO0qQcld+BMNHBvHw+FsXKMLWY4N80mnltdIOmqNLSGTc3yvMkdtNseTOgBqRm++q/H9f+WcPZ1pEfgo3yOVJYAjwI2lN3H1s+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBY6+BqwWkOeyRqsgv2LxiSRiR/Nz4wlbM/qBRZ0Vak=;
 b=NziYm3XZ6xos0x1ud5PkNhoXOoLJAcuspXfbTviDh5IBM1kX6sAqtqmwmVCl8QRKvokR7sqJCNiQ5gzxB9+lR9ePoDbha5UkbfcK4j3r6cv6WnmsCmUH0grTMHXopLLUIPtSHFc29DZSJjumT3VkW6sGwVuTdj+RA0WWjXjGBcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BN0PR01MB6974.prod.exchangelabs.com (2603:10b6:408:16d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.21; Fri, 4 Aug 2023 19:59:48 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 19:59:48 +0000
Date:   Fri, 4 Aug 2023 12:59:41 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     John Garry <john.g.garry@oracle.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 3/4] perf vendor events arm64: Add AmpereOne metrics
In-Reply-To: <ccce391b-da5e-584c-9c56-1de754df8362@oracle.com>
Message-ID: <e5879193-515b-662c-8597-ca8ea8e3fb4@os.amperecomputing.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com> <20230803211331.140553-4-ilkka@os.amperecomputing.com> <ccce391b-da5e-584c-9c56-1de754df8362@oracle.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:610:53::12) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BN0PR01MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c3e84c-0852-40f9-56fa-08db95255b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p3L1EQUouCeT74RZvykYNTXlMpN67A64DCeYQpiZ+P/E2unZzbm+E0SABbYv?=
 =?us-ascii?Q?knF3IPWXXuBn1yQX5y45fpZYv0P3USNcvUBOwFDqN6JqAB0dNZCaKDa+b4YY?=
 =?us-ascii?Q?/mbt5mJscNmIamrxQK/Ct3FOsvf200PstzYaGL6UGM9NQFDKBenOGRe7wnng?=
 =?us-ascii?Q?A6oj3kMYvID57oFV1sdEdkVYZvmedUCAuOQHkTuFotuny12UR7rhz8Q/Q/cp?=
 =?us-ascii?Q?4J4JZQbUBMRRUZ7e3v9C0m9t1Q0YjZx3IumdA9ZbN/MrYawkfPE9bV6xKfcb?=
 =?us-ascii?Q?cqJc0xBW8qe4p+AAwMlp7g6cwNcZj6KznagtdEpJKqqTttHH+EDPSwpV/6te?=
 =?us-ascii?Q?Y4Rl2AsVTJOzFhJqio6dJ82ATAeU9vXv9tuKG4trhZW4MXgR7I/BreDHsE7V?=
 =?us-ascii?Q?qsKdOYiRCNMTeDysa02fwn0og8FPInAnz2wlZgbQdXAJ5QMNifcyfnEn9Yyf?=
 =?us-ascii?Q?ZAkFPdlBDdT55Lizzoc8+nXyRvpAwTS8MBPd2ILjQnipnW7Pase1QsfBJgFf?=
 =?us-ascii?Q?qDh8HFBZMdZefNZRvzVgO8popJRjgxAryDJUTQvLBq85QfeXEA0Az/N76vJW?=
 =?us-ascii?Q?mceAO73qnzsCdh0KHy71+uOeyhK5QpCxf/NAXvldSb1snFw2uyrfPdm4CAOK?=
 =?us-ascii?Q?D2PlNR/NLw7/RYQBwu3uPsqJDaKjSdVpRQMIwxjiKh3Mb66JrUjutqREmQsE?=
 =?us-ascii?Q?u1HhAqvfKT4qfuW6Jwk/sLCavFzEBbLAqklnRJ1j7DTUkJa62bmoUcrn1eHM?=
 =?us-ascii?Q?wDTt7f2LLHygzGdWxZHmMRtUnbsEKsw+Yo1aPFmgNXGYyTYwuua3hPNgpkH5?=
 =?us-ascii?Q?HAZUmOv1nbR/8LapBHww6qnn7VB+vETvQSKzQHjSyYsUeHquRs5XJ4vYEagL?=
 =?us-ascii?Q?NbYSHyY2Os2FGxLN7GPxCMc17q4jHtMubU5Z+Hc8PAmYuvVf/+/7mj++Mb9d?=
 =?us-ascii?Q?3poeKUi5ZvqcjKvZ/07J3HUY41kpz2dhVxvz2b61FP8iFpdOCjMhJfiwYl8N?=
 =?us-ascii?Q?Df/mkCyPFczfCsOe7bMgOBCu1EnlLbq4/4ngctcTj1N87T0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230028)(4636009)(39850400004)(366004)(346002)(136003)(376002)(396003)(1800799003)(451199021)(186006)(2906002)(4744005)(52116002)(26005)(38350700002)(38100700002)(2616005)(53546011)(6506007)(7416002)(8676002)(8936002)(5660300002)(4326008)(6916009)(66556008)(66946007)(66476007)(316002)(41300700001)(6486002)(6512007)(6666004)(86362001)(54906003)(478600001)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VWto5GRl3Oku9mVUGwXVaQH+mzpUO3gYho8D3w7wuQpmO/bmydQVE4XWALTS?=
 =?us-ascii?Q?Ttd9DS8W9cewo3ysKLh3MaV01yt46YtMRWxmyXmIhzKsFMP1MUSgQ5AvUgxC?=
 =?us-ascii?Q?ADJsOHVOngOvIFyIKJLDr4eSM26F0eF4DaFm4N7zyv5bfpccn9pvXWQMx1a9?=
 =?us-ascii?Q?WF/EeAF0RFD5r3JVpqmjycFmBPQ0IjEY06BewRlgN2LfELiPIbIEWTVsjP/o?=
 =?us-ascii?Q?BQrCaHvLw8zMmXUxbNcZW49qbMYcygWFTbTYZhCVacU4VWDQqrbZ3neTOFBR?=
 =?us-ascii?Q?4jUNiM52Z0p1hLQxN4pUp7SOEk+5aK8/0y+bJ2k2z73k2yMEmlyOoonjp8FI?=
 =?us-ascii?Q?KKS/78RVV8l8EStcGfezzuoOQ5R08eSKLiL3mRbNmnmY+s9iCyWt1Ktj15dZ?=
 =?us-ascii?Q?EvwdfERdf8VDHGgnZIGMag3qHgI7SC6xXPHSKmSHbwV6peDXnf899pJ/EFSz?=
 =?us-ascii?Q?7C8gEupHLSDI4S4o5NAul81Su5uOMOxHJnEQgqScs4gIOu78EEYrTKEx0csf?=
 =?us-ascii?Q?XJ9eN9EgYvS6QNUPfkT2/URclw5T1tSFI3g+2gMwp40A1PoXhB8dc7iiGBs/?=
 =?us-ascii?Q?rLN3ptrzEIPnBQUubNeiMW0kq8gEyqMKzT9aBEA2Q9E3zLq2HLAPOaKfKIvf?=
 =?us-ascii?Q?YP5iT6wnzJ26RlzGRUoxIGJwvKORN+t0nSTuxAY3YLtnK7Un3Xf2X5+Vu6QQ?=
 =?us-ascii?Q?RXpEsiz+TRW4VOQtBnKhilyxFOWdotE+YCSmpHF+7H2qQj8BamTBRWVFAm7l?=
 =?us-ascii?Q?YbGhkDLW5HXC8lUbZMjWz0GxQQGaKNfXbkZP+58740fzFMOwCLAJy3mJBc6r?=
 =?us-ascii?Q?FKrm1r3Mr7gevoJHz7KaN6oYdWOd+8iYU+EQFxdnZf3IIbbJ1O+7Ky6SQHa1?=
 =?us-ascii?Q?gCaFNDElbzTTMpGqJ8fLy8S7+X50Hy1vBjDGYyVoDxwTTL4J97g1KbR8wxlL?=
 =?us-ascii?Q?WKsPYh3FEjpwopJWLF090++BRg1fckf0uht54/Bca6CybzTQI947OdikcNjK?=
 =?us-ascii?Q?kse5MiLjCYJBXyBvmkwzmGnNIY8Zh618QouDqWwyIcNltWFjzrJvMmaDcpNI?=
 =?us-ascii?Q?SF7BdtBZ+L70b/FNmBuviyzfAQBZVWxKsfHc1Z2K9d7O3pwsjwuk/DRQ6Tme?=
 =?us-ascii?Q?+NVLWcCpoP5LrU9RVb4JNOnHv3T8S34Ga8ZGyI48SlQnaN/mAeQvgUIu3ze7?=
 =?us-ascii?Q?Fy22nlibMu3CTLWGK8gNb+4AaMrYzCrNo0Q/FhaTdUDoj0HlP3PSiOx3R+Y5?=
 =?us-ascii?Q?4s4D4ofj7ORhzmE5Ssp6Z/KSdTrwCGtcnUPgeq2FSac20NbzT3tIPZbMMRAg?=
 =?us-ascii?Q?vPlSDDuf9LY0ilf92Sku2ruEIDfxq3tpr+DTagTGuBnikmFc0COmLPJSWSm1?=
 =?us-ascii?Q?65HGX4tsDUreDiT3JhivNdqbwifMVEn+Vo7alGOXF/bykNp/Q+qrEtxKutEd?=
 =?us-ascii?Q?CQkxG/agjLd+0j6uJ8IXiU4CWtBf8YiiRZOruQVWHXsa9N0mjit160pDupX9?=
 =?us-ascii?Q?oCoR2SO2trDUV6MyWuKSbtPpaF4BG1t9C4mX+HBwN7FLTXayN2XoyOpFdNkB?=
 =?us-ascii?Q?3p0fPwspchtyXxZZToBR0epnhLAm6e1AHLlUI/+K326SGpqywMXmwVrztmIl?=
 =?us-ascii?Q?i1G+pYxTgoUXlhbOpsIJQF8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c3e84c-0852-40f9-56fa-08db95255b4a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:59:48.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RpQhzloDVG4IpCxD8ntWI1oTFkNTnl9Zz/KDiLGyoXfHGXY4ibIor6skHl0suOLcrIztB2q1q5qWVRSEfk3imD43q8RiZse2pYMq9mscGGna2MeQ0SMXcWpldd5tC14
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6974
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi John

On Fri, 4 Aug 2023, John Garry wrote:
> On 03/08/2023 22:13, Ilkka Koskinen wrote:
>> This patch adds AmpereOne metrics. The metrics also work around
>> the issue related to some of the events.
>
> Just curious, are these events/metrics described in some publically-available 
> document?

I quickly checked that and there are a spreadsheet and a document 
available, which list the supported PMUs, their events and metrics in the 
customer connect website but that requires registering.

Cheers, Ilkka
