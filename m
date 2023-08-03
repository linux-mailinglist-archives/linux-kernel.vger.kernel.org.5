Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16A76F2FB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjHCStp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjHCStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:49:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4252D71
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ/ezv7PwRJSkIyGMtdG0rEA2BU1KuGxesmW9DXg7aN2QeGBwlyzbB1NufhoWnWx9PkXCLLT7HkWs8dGFPEGFVEF5BzL4n7oXWs4DEyoB/xxP0B83v65VO1Nef1IYbtI/DrvcomTRtHbyMDIRNNwQ4uI2MEz7Io6HuDESngJha7JiO/6VGh3hoAje3rHHyIPRKURTNMji2QMOCFfPv6O4CSNRZb/CH80QBHoezRunxhIP166dsdO3afQZ2octl+hDYYSn8rKaG8TccVY84Ckt3olZEwUSzRcmQs+3HY+24cCJ0T7llYjnSCX9UEPWvJe3homriv0GVmBr8+mH07rxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yBdzaQ5ow0BpbEVXmcG59X05eLoweM6AgDJFoWS3kY=;
 b=k+LALJPhK8wdxHFcz39ECB2egm/y3PTD0SXOBjsxtuhhH8xWeajINMgoIB3udYYzMYlDplDmt7DPWJhJb3l8z3ZPe5OfPCdlhPtQCeNalkY5+xGGG277uKCL/4RhMbzaoiQuopAQ1bu+n54WaUrhtMaQ65Lv4sNvInb6u/GOaA3bwCWIeSDY6+OQ756yux7WGogweeDznsTqCrygi14r6+NyqWZ8myE678eJB3whq/UwLsGo+ZcWveWyMLKFVDj01pmLKsf5ua+PPtiqKOnjQbrlHKmSO3NpPfp+3suh9yitiEOC+dfNkmIgtyMw2uN9FE9wtc1CEwSVovxE8kHfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yBdzaQ5ow0BpbEVXmcG59X05eLoweM6AgDJFoWS3kY=;
 b=ZrWi4B+kl06bIhaSmv2CiJZ8Yi+o6/hsYMcGU5ui1l9sBoFwCdt9Avv3Aomilr41SYKlTKdEFV8tM2QJs0lH6XOhaQC5iZ3YQsXSDH9J2mXHeKnNt1eSRXPuGXScEAlUi1M+7HeS5/6QqgjJGIZPjobbS4HnqoQmaNZS8KOTCoOkKURxMre/kNTEmS44H+BleCpC9fi208UJvR80W7jt2Wu7/0e40NWdCFuOt/OAv0rd936+xTVKiqWlzEQ4KGmLGasqPugiojc8mZz2aFtPI+vGBda1+Ymds4S55t72wEA9zzO2rfaO4PwNQoqs7E6OFAz99VchiSFinEMHleTOZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 3 Aug
 2023 18:47:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 18:47:54 +0000
Date:   Thu, 3 Aug 2023 15:47:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZMv2WJX6b2UBBelt@nvidia.com>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <CAKHBV26OsQYRCifuD0UjSf5uqcvMSK2tizjFULLv8DTdz0zD2g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV26OsQYRCifuD0UjSf5uqcvMSK2tizjFULLv8DTdz0zD2g@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:208:32d::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1df198-7853-4ece-39cd-08db94522574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8K/cwowKAt6yxZBQ1ec0x3zfGERtHa2EkBGyDXDv7F4ViSN4J1Ir5MOcxoBwOIEiw2474IKnpVfOwCJWXDg1L7spFoQgZlvAcxItkE6ByzRmmNBiSwNABR1XWMsD6Ix16dd2gl7sHCRDtcpmqc1bffl7+xFX89tttO8X4HHh5IwVKwBiuZAjAqDcgVASzSNc3XGs0G/i1gj6FjMG5AzZwRBu4K1qj1B2lERZAmQdqV4UzZBqG0ClDO9elxkC583TmJpMBqSjKa5YWuvF41NkOVS+9UZ6EYBp8HuGwoawIHXTJktV6Quu+vTjzIZYdRo3V5yXLKBEq+JUob0u8F5yq8NyLY5B0GC9V+zLBJ2CMmWDeqgWXUmD2c+RCotoQeqTK7WCsAh+xGyZmmihkBsTdwihLo+GelZ3frSr2Pz1TLbooQQbOb2ofe5jJrCfDMx4QkcY1AgMOwm1utqt5mAwdNRT6hylAtXv9K0KLTaRyTHNyZJRXg0wi4xUVfGuXVLs3LJ1THunZyHPzp506oe17iuQ8D4rwjmPP7IYSB91/zY2/Manogyk9bH6OYXZXrS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(2616005)(8676002)(8936002)(2906002)(83380400001)(86362001)(5660300002)(66556008)(66946007)(66476007)(36756003)(41300700001)(4326008)(6916009)(186003)(316002)(6506007)(26005)(478600001)(38100700002)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KK1xx3U0xLPr0uQNlqTmqcnCljy9Z5t6wyn7Uq95YG+aosF0GX7HbMoPYjRl?=
 =?us-ascii?Q?uc0Cqvb9qMj553onIdpFFCp/EqqhkLNray5HizwRAk3Qb9xsXx1Eb9ijmMhV?=
 =?us-ascii?Q?O60EnGSsRlj4HAvTUvNtI5ma9juvx6ZzZ+zGZmQtNG3O3oPPaHfv2c6Ek4Oh?=
 =?us-ascii?Q?0k+raWXBIvl56wOmgdtnroPVZ1VI/q+pyRO4+c++2ZWvXQoXIJnj6WSvQCQj?=
 =?us-ascii?Q?RsSMLFA6KT4K8qcjzo7phqIhkwJiMmB9+jFDOF5E3tN1Q7pRGxncLrz6f2ai?=
 =?us-ascii?Q?zOmEhUGoHlkKpOpEDnn9WKScDvfWdJgZxE+d9Xl1nwCIWOhcljs/Nzc9OXWV?=
 =?us-ascii?Q?V454o0hXyWrcVr6dP6uJ/76h5Ip8xun0D82O5tSKfzx2R7cz9usU771Y9ddr?=
 =?us-ascii?Q?MctV5e9d6Ak172QK9xmtoWdBulkcXIHc5xFhaMXM/+iurHTAUZ976TSJnEEa?=
 =?us-ascii?Q?u5HX/ObWLVKosgQ/PH/FqPxsjLbKHg4ihTLEFQkmEEgflDqd4GsX+Ar3ftNf?=
 =?us-ascii?Q?Ld+VAXLi0D0bxBUd/XEG/NlClW5xRna+rBiy7A4dCViizu0imGWwK75LaRmO?=
 =?us-ascii?Q?z0gbnrOSWWAYo8lsJFNQS1xFawo5nyDMYtgUNcKkECr44IBb4HWhii7Z+Crb?=
 =?us-ascii?Q?e3nEio1sE2Va0hdTJWg+Vaz0HqdHHrk9HeJpcpg50xwGoDuIht/e0f4dYUfX?=
 =?us-ascii?Q?H6dYIm1z6doEX9uP3hl81SxWy7mRHmVim+euq0dgbqRU9oNr7eVZTcb/K4Ba?=
 =?us-ascii?Q?8hWdgeYjUhDaDub2ERaBTq15jbFSl3NEhwMCUkTOQZLP3tglSLo7mzSiWR5P?=
 =?us-ascii?Q?jEb/EYZWRbuJrv1iUgz9CJmGLpJewjF33Wk2IwkWixKk3qndFvG/VzspBgdb?=
 =?us-ascii?Q?OvopUD6PN0QY8OkoH804FF9gHrUOzYnMze639Mb/WpSVY6DWt6nKWSxQZ/rd?=
 =?us-ascii?Q?NYcOUXVlcxGzUrn17vDOtEoMuED99x6X0FhHEFqzsGdy64CdnKwZCeZMxHKK?=
 =?us-ascii?Q?AuaVcrd54hDnVJkKgETiXSY5u3LLApWTp3jF+pSUVkj/ZE8ZAUUslk4HazUb?=
 =?us-ascii?Q?kArW1AaZK1FIDz5Gx9F5qFF5TwbhdreO27s3FMjztzP3SY8Eo7nDiVROD86h?=
 =?us-ascii?Q?MUyBHPyhw3vTVZM+D0MqSJQh1A2cqMP6H15fTx9hyqtHuu7A8J9Ya4Tc+98l?=
 =?us-ascii?Q?hSS9nwa4Ax7zThZOjneXY91q5OFAUDdRIbWkUGQOn4xp7urzuvZNN0dn8ZJT?=
 =?us-ascii?Q?0xBSmiQLJTJh8oR1Ip2UgR4mE094x2x4MVeNZfItlPBz/fSM+M+lYe9igXz8?=
 =?us-ascii?Q?/tUQeOZr3drGFADQaYgLqF5E2pZfNHz2cDyzK/nWsk2AIq57F6CKcYVBVbwt?=
 =?us-ascii?Q?MzvhJ1t8NkXGf2utRvsyuRYut267PkDq0oou13B/wIna48v7DmIhND8pVWnC?=
 =?us-ascii?Q?1iqcSy+m/l/TlynyiRwvKayZgjRGNe2Lbn8iobmDMvxFhG+M15WpdJtlohl5?=
 =?us-ascii?Q?QWA1XPc+HsfTeWQ+KCn5o+wgagAGPveczQTQsduwYPVdCFN3MtEEWRTRRFiq?=
 =?us-ascii?Q?Zz07rG7p92G06Lp7jksNerqibX1eaTofZQAHAM/d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1df198-7853-4ece-39cd-08db94522574
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 18:47:54.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voVXSFfNtLer3HXkiBIccwBl9FzGg6kqhpkmFrkCr7OXLTIajbldzP5Ol3mVymN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 01:56:12AM +0800, Michael Shavit wrote:
> This patch introduces a subtle bug.
> 
> Previously, the arm-smmu-v3 driver could get away with skipping the
> clearing of the CD entry on detach, since the table belonged to the
> domain and wouldn't be re-written on re-attach. When we switch to the
> master-owned table model, that CDTE in the master's table can get
> written to with different CD domains. When the CD domain get's
> switched to a new one without first being cleared, arm_smmu_write_ctx
> will mis-interpret its call as an ASID update instead of an entirely
> new Cd.

I'm not surprised, I think arm_smmu_write_ctx is a little too clever
for its own good..

I would have written it by computing the full target CD entry,
extracted directly from the domain.

Something like:

struct cd_entry {
	__le64 val[4];
};

static void arm_smmu_get_domain_cd_value(struct arm_smmu_domain *domain,
					 struct arm_smmu_master *master,
					 bool quiet, struct cd_entry *entry)
{
	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
	struct arm_smmu_ctx_desc *cd = &domain->cd;
	u64 val0;

	if (!domain) {
		memset(entry, 0, sizeof(*entry));
		return;
	}

	val0 = cd->tcr |
#ifdef __BIG_ENDIAN
	       CTXDESC_CD_0_ENDI |
#endif
	       CTXDESC_CD_0_R | CTXDESC_CD_0_A |
	       (cd->mm ? 0 : CTXDESC_CD_0_ASET) | CTXDESC_CD_0_AA64 |
	       FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) | CTXDESC_CD_0_V;

	if (cd_table->stall_enabled)
		val0 |= CTXDESC_CD_0_S;

	if (quiet)
		val0 |= CTXDESC_CD_0_TCR_EPD0;

	entry->val[0] = cpu_to_le64(val0);
	entry->val[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
	entry->val[2] = 0;
	entry->val[3] = cpu_to_le64(cd->mair);
}

int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
			    struct arm_smmu_ctx_desc *cd)
{
	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
	struct cd_entry *cur_cd;
	struct cd_entry new_cd;

	if (WARN_ON(ssid >= (1 << cd_table->max_cds_bits)))
		return -E2BIG;

	new_cd = arm_smmu_get_cd_ptr(master, ssid);
	if (!new_cd)
		return -ENOMEM;

	arm_smmu_get_domain_cd_value(domain, master, cd == &quiet_cd, &new_cd);

	/*
	 * The SMMU accesses 64-bit values atomically. See IHI0070Ca 3.21.3
	 * "Configuration structures and configuration invalidation completion"
	 *
	 *   The size of single-copy atomic reads made by the SMMU is
	 *   IMPLEMENTATION DEFINED but must be at least 64 bits. Any single
	 *   field within an aligned 64-bit span of a structure can be altered
	 *   without first making the structure invalid.
	 */

	/*
	 * Changing only dword 0 is common enough that we give it a fast path.
	 */
	if (cur_cd->val[1] != new_cd.val[1] ||
	    cur_cd->val[2] != new_cd.val[2] ||
	    cur_cd->val[3] != new_cd.val[3]) {
		/* Make it invalid so we can update all 4 values */
		if (le64_to_cpu(cur_cd->val[0]) & CTXDESC_CD_0_V) {
			if (le64_to_cpu(new_cd.val[0]) & CTXDESC_CD_0_V)
				WRITE_ONCE(cur_cd->val[0], 0);
			else
				WRITE_ONCE(cur_cd->val[0], new_cd.val[0]);
			arm_smmu_sync_cd(master, ssid, true);
		}

		cur_cd->val[1] = new_cd.val[1];
		cur_cd->val[2] = new_cd.val[2];
		cur_cd->val[3] = new_cd.val[3];

		/*
		 * CD entry may be live, and the SMMU might read dwords of this
		 * CD in any order. Ensure that it observes valid values before
		 * reading V=1.
		 */
		if (le64_to_cpu(new_cd.val[0]) & CTXDESC_CD_0_V)
			arm_smmu_sync_cd(master, ssid, true);
	}
	if (cur_cd->val[0] == new_cd.val[0])
		return 0;

	WRITE_ONCE(cur_cd->val[0], new_cd.val[0]);
	arm_smmu_sync_cd(master, ssid, true);
}

Jason
