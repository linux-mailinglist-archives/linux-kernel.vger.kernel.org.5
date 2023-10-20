Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419277D1957
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjJTWyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTWyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:54:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2101.outbound.protection.outlook.com [40.107.100.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071A7D6A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSrTl//agypOrFr8iWcaiUIxc1/gnqFVDUOs2Ol9mDan0/kM8xc1ZqGm906dBDWZSsTj70oKjSIuhwj6cfScCOt7UV73z+yPH4dneN70EF0Sd7xKRretM9ymhiNOmBtv/0ixT7sVCAw0/0YTWVrM6TTOpnYGpF8x08vxmZrmZGHz79vlU3hIZ8E2rE7AZsERDJGxQqGTr2YIY/iQyOVVMLpZcT6hBnVmUOZiApC13hf2hmoTE42TDo2e6Vp8cq/Wsue+qqIrMiNcZm/gvyN75RblMzT9NPO+K6qZwnw26gZwZ5khNYN3ogJ72fb1fc25PGc7Z9tMxAvAT+poYS4OTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9GbAHDDwrWQGA4u1vOS+pdBCtaf8/1VcXmL0S2nISE=;
 b=gbu69/ULWysssB/Xg4LeFMeJbSHPR/BsahYGZASy6ES8Z9j6TKK+N6tSm4wPF/8U1sBjbSUb2xNO6PTQispP8iWqaVmKDfA+thmKz5T8yx923s5mR+9R6fIuJqWTtnqzRmnKI3u9kGBA8kp747i3QP+Xu8Q8mITuVaC7xtr30e8JB5mLxI/mvw76DSHGs/SuvqHrMHxrPvrchRiFV+BPXH6pkeqtqvIF6cnmUppeKqEvmMt4qK0IcrRFZV4KfM3A23ImVvAWVWd3vbZh775L5nQ3Af51UZ1AIoTJtpgJiTimKz/ASQchCDDqITWUKck0XgPJKpH8kiIHLHQSA8YFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9GbAHDDwrWQGA4u1vOS+pdBCtaf8/1VcXmL0S2nISE=;
 b=XI6gZoAdYem9DYLkLfIJT7IAoOcFiUmhw8lWs3HkZqlz+piuDhEFSA7Zc6fTKqqeuVChvTUXd/SpuIe2addC1kHLrCkb5IEPSsjwA39hsVu4WhDqSFWr9ut1yXBO8mE7pXne0Vt5HtroqjX/ugm0iapeHZW8zsGEZoAeMqEpZLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB6792.prod.exchangelabs.com (2603:10b6:303:d5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.27; Fri, 20 Oct 2023 22:53:59 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 22:53:59 +0000
Date:   Fri, 20 Oct 2023 15:53:10 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, ilkka@os.amperecomputing.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH 2/3] perf/arm-cmn: Rework DTC counters (again)
In-Reply-To: <5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com>
Message-ID: <501e7c9a-be24-491-2abc-5895327d80e9@os.amperecomputing.com>
References: <cover.1697824215.git.robin.murphy@arm.com> <5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:610:53::39) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CO1PR01MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: e96633ca-a2c8-4c59-7cef-08dbd1bf726e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPCSjJ4QGma7BvEvaY22nyui71zrtRTKRLXhrTwVj15BwVmVBLRK8k54F3h2Qhwogkljy1wNhNhDf1W9s2HNi1jUItnRVe59v2aRJ2BmVLjMfjk0EU5M38HplZbj7fcApJRm1xQaLdy1vBcPA8NZxDYdg6LWFEwi03Ja3RIO4C/CJ7l4CK8thV89M9gzk4uxIwp/Xo9L9hjKvDzQxi5icaSDKLLpfQ84EqzqUmJWoDjWcf1zp0qIqTYPyDOUNMeTaMRigejAbZVqITO9nQVVSuwmlk+ydZFnaEW00WbpvSKpZVYOvcikQIscpc3/cLPo4dMxtW956HiHQjpRTOVvjv3lCPh0rejl2lLynRZSzs70wAueGCrY5JiHnl7rqSTmrk1BNDKRk8IeL8lSxrdXFm1XHVRVa7o/NLUlqMDxdV735lCLGr+xKjX7oPttDP0I5mKtjVGI/o4vxQ1BewrzarMYBOOaEKCttdzTkDvWGGsCC+mg1/pF+S1vVwQ0qG0UKcq9fv4tlYX3V13Xj3gN9kO1HmrzbR+kfiunN6A2FXRW/mMFt+BlyStY0cwsEnJ9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6666004)(4326008)(30864003)(8936002)(5660300002)(8676002)(41300700001)(83380400001)(26005)(6506007)(6512007)(2906002)(38100700002)(2616005)(86362001)(66556008)(66946007)(66476007)(478600001)(6916009)(6486002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zw+LTknNpp1SjXyLle3ueBreQOwQCwAZB2H7ubGqwinL2/vlOrmJ3iFAVWC/?=
 =?us-ascii?Q?QfvneRyut4dGACrlhK9hB9zJKeQLumlcXE+WkKbivcCDgnq3GakaeR0UrYYp?=
 =?us-ascii?Q?0NW5NCQLtteRxYRif1RE+pSvZUWNG0eyw9Qh7CnQIIoNlKRHxdVP07COYqOw?=
 =?us-ascii?Q?GGoQW68orANwa48AuC9XFHzYgqHgNt1SKchEA4eCqmdX54cjxsjXoxd+EnT0?=
 =?us-ascii?Q?CPUXmUv8NmCfhv7SsoX5kMtbQdpxXe7i4M3xmDu3sycZAOwkI/z9pJHh97jX?=
 =?us-ascii?Q?ZWc2R1IZey37BhPlfK6nVgziF7ypG3SkPi5o+mLDFLExKKbITvic7F07DRFm?=
 =?us-ascii?Q?VVNVOIxBjhGYbbuCS8Hhx1J9YhSGDVVy5JkymgyTfm0JQWEVUcDBh8hD6ls8?=
 =?us-ascii?Q?KjZSn5YWlFfSqzepMnnUStzzijwML0DfWfgzLSSbpgO0NDYzk4Cbddrb0vPz?=
 =?us-ascii?Q?NLykcbV894n+vdhvqjiqmu9gV7d3i47IZ7tlWbGXdm3ypHs7gm0414IWFqQ5?=
 =?us-ascii?Q?pOxBkKcUPptGgYF9YRypH1BurzevW0yBw0/S2FcWgpi/46qMytKa7FCtR65r?=
 =?us-ascii?Q?q+Fgu7ThNmlOMXGCxUQa3gvF4k88R+hXYn2/f92fTRAhQ2fNef2sSdkaICXk?=
 =?us-ascii?Q?gUBZI+CaDrFSg4e0LIexYaITTTdqRC8NeC6MvQ9T2ERR6ZqfrRxi/HhbyKV2?=
 =?us-ascii?Q?+bvBHH0sujo9QRUy+yZVJmOZnM4oaKnTDBpsJ7qIXwLRKPTC6bcsaQ0xBAF5?=
 =?us-ascii?Q?vvU8Of/CWpngPZp+UVxVw4GhDqPFrKu9/WfPZub31gB701lKkVQ/yJu2ndeB?=
 =?us-ascii?Q?ZCg9rbENJ437jAEoLopBOKasXxBQE93Kwyn/85+0NUmxIqVs2JH2Rld1Wk6O?=
 =?us-ascii?Q?LqCvXWeEYEt+cz2dgyPSQlabxB2ArSVfDV05dljAr2O5P6NntgW/E+QuTaBP?=
 =?us-ascii?Q?4j/v2wwKEccIaVsP23RwG/hn4UnK4NRysuIKJNYACcZUl+mGjhVuKxoiu0dK?=
 =?us-ascii?Q?M4nMcap2Ql4oOHh7iZ7jbWSTwZn7FecNeAOq2Evz2mfpbcsAzQIFJdK0DvOK?=
 =?us-ascii?Q?zuXu8H0N4UvupRhIcnRlndoHwnmj7bspTRARicRYSgG2qdVVi+zfhmJo/5uj?=
 =?us-ascii?Q?WqhuDwYyZII5/sIwyx6H+539KVjMKl3/1+tkHQxRXuKB1n1hlDTPKc70E4Qa?=
 =?us-ascii?Q?/w4Co5A91vXdlKPnvR8RLFTijvHmgdE4r3eXL864LAUrx8T2eW+l0ouI3/ge?=
 =?us-ascii?Q?VKsEGSvLCM3BqHVplv+HG8m0BOWHbYmwnajJyEa92vrQRdQEv9cNZXknVweg?=
 =?us-ascii?Q?SlTeu64/9zuI6fXmAGqo8g1URObTOv25LtR9kvD1JU3nTcw+ay5by9TupSMa?=
 =?us-ascii?Q?gTtk5gel/pZP8rOUXmhgd4YxixD1yFuCkWCjP+5IoQB6Foubs8bGymHIpiKz?=
 =?us-ascii?Q?4iGEpRwjFGacsdlxRRJoCX5IQm0+r+WV7FW7I+SANXE+gPJ1EgOz5GyxHGew?=
 =?us-ascii?Q?l4ZR0DXStOeLs3agpEoyDl3XJ4twp6W5U2gB2rNTlHnOFAPqOrCbKSi8v3dL?=
 =?us-ascii?Q?GjUpBNeh5h5zye+UWAEReDk3qEAoV3Fuh/VBIs/ZtBj0FEXZRRAFjcNaZzHO?=
 =?us-ascii?Q?Dj9Eb3gxOPN+OaSNIUpaDi4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96633ca-a2c8-4c59-7cef-08dbd1bf726e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 22:53:59.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5I2Zw8szfskacYi3UpnkbwlU5MCowKZTBNTmRchr/T5RuQavrO5qIOV3LwSCCr34pGaTc8KeH890t4TWOVxLYgUr3CCKKcDvsErLn5U4VUvnmqj9njrfGeMPSRYiGOk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6792
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Oct 2023, Robin Murphy wrote:
> The bitmap-based scheme for tracking DTC counter usage turns out to be a
> complete dead-end for its imagined purpose, since by the time we have to
> keep track of a per-DTC counter index anyway, we already have enough
> information to make the bitmap itself redundant. Revert the remains of
> it back to almost the original scheme, but now expanded to track per-DTC
> indices, in preparation for making use of them in anger.
>
> Note that since cycle count events always use a dedicated counter on a
> single DTC, we reuse the field to encode their DTC index directly.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks! I had that on my task list but never had time to start working on 
it.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> drivers/perf/arm-cmn.c | 126 +++++++++++++++++++++--------------------
> 1 file changed, 64 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f1ac8d0cdb3b..675f1638013e 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -281,16 +281,13 @@ struct arm_cmn_node {
> 	u16 id, logid;
> 	enum cmn_node_type type;
>
> -	int dtm;
> -	union {
> -		/* DN/HN-F/CXHA */
> -		struct {
> -			u8 val : 4;
> -			u8 count : 4;
> -		} occupid[SEL_MAX];
> -		/* XP */
> -		u8 dtc;
> -	};
> +	u8 dtm;
> +	s8 dtc;
> +	/* DN/HN-F/CXHA */
> +	struct {
> +		u8 val : 4;
> +		u8 count : 4;
> +	} occupid[SEL_MAX];
> 	union {
> 		u8 event[4];
> 		__le32 event_sel;
> @@ -540,12 +537,12 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
>
> 		seq_puts(s, "\n     |");
> 		for (x = 0; x < cmn->mesh_x; x++) {
> -			u8 dtc = cmn->xps[xp_base + x].dtc;
> +			s8 dtc = cmn->xps[xp_base + x].dtc;
>
> -			if (dtc & (dtc - 1))
> +			if (dtc < 0)
> 				seq_puts(s, " DTC ?? |");
> 			else
> -				seq_printf(s, " DTC %ld  |", __ffs(dtc));
> +				seq_printf(s, " DTC %d  |", dtc);
> 		}
> 		seq_puts(s, "\n     |");
> 		for (x = 0; x < cmn->mesh_x; x++)
> @@ -589,8 +586,7 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
> struct arm_cmn_hw_event {
> 	struct arm_cmn_node *dn;
> 	u64 dtm_idx[4];
> -	unsigned int dtc_idx;
> -	u8 dtcs_used;
> +	s8 dtc_idx[CMN_MAX_DTCS];
> 	u8 num_dns;
> 	u8 dtm_offset;
> 	bool wide_sel;
> @@ -600,6 +596,10 @@ struct arm_cmn_hw_event {
> #define for_each_hw_dn(hw, dn, i) \
> 	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
>
> +/* @i is the DTC number, @idx is the counter index on that DTC */
> +#define for_each_hw_dtc_idx(hw, i, idx) \
> +	for (int i = 0, idx; i < CMN_MAX_DTCS; i++) if ((idx = hw->dtc_idx[i]) >= 0)
> +
> static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
> {
> 	BUILD_BUG_ON(sizeof(struct arm_cmn_hw_event) > offsetof(struct hw_perf_event, target));
> @@ -1429,12 +1429,11 @@ static void arm_cmn_init_counter(struct perf_event *event)
> {
> 	struct arm_cmn *cmn = to_cmn(event->pmu);
> 	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
> -	unsigned int i, pmevcnt = CMN_DT_PMEVCNT(hw->dtc_idx);
> 	u64 count;
>
> -	for (i = 0; hw->dtcs_used & (1U << i); i++) {
> -		writel_relaxed(CMN_COUNTER_INIT, cmn->dtc[i].base + pmevcnt);
> -		cmn->dtc[i].counters[hw->dtc_idx] = event;
> +	for_each_hw_dtc_idx(hw, i, idx) {
> +		writel_relaxed(CMN_COUNTER_INIT, cmn->dtc[i].base + CMN_DT_PMEVCNT(idx));
> +		cmn->dtc[i].counters[idx] = event;
> 	}
>
> 	count = arm_cmn_read_dtm(cmn, hw, false);
> @@ -1447,11 +1446,9 @@ static void arm_cmn_event_read(struct perf_event *event)
> 	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
> 	u64 delta, new, prev;
> 	unsigned long flags;
> -	unsigned int i;
>
> -	if (hw->dtc_idx == CMN_DT_NUM_COUNTERS) {
> -		i = __ffs(hw->dtcs_used);
> -		delta = arm_cmn_read_cc(cmn->dtc + i);
> +	if (CMN_EVENT_TYPE(event) == CMN_TYPE_DTC) {
> +		delta = arm_cmn_read_cc(cmn->dtc + hw->dtc_idx[0]);
> 		local64_add(delta, &event->count);
> 		return;
> 	}
> @@ -1461,8 +1458,8 @@ static void arm_cmn_event_read(struct perf_event *event)
> 	delta = new - prev;
>
> 	local_irq_save(flags);
> -	for (i = 0; hw->dtcs_used & (1U << i); i++) {
> -		new = arm_cmn_read_counter(cmn->dtc + i, hw->dtc_idx);
> +	for_each_hw_dtc_idx(hw, i, idx) {
> +		new = arm_cmn_read_counter(cmn->dtc + i, idx);
> 		delta += new << 16;
> 	}
> 	local_irq_restore(flags);
> @@ -1518,7 +1515,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
> 	int i;
>
> 	if (type == CMN_TYPE_DTC) {
> -		i = __ffs(hw->dtcs_used);
> +		i = hw->dtc_idx[0];
> 		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + CMN_DT_PMCCNTR);
> 		cmn->dtc[i].cc_active = true;
> 	} else if (type == CMN_TYPE_WP) {
> @@ -1549,7 +1546,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
> 	int i;
>
> 	if (type == CMN_TYPE_DTC) {
> -		i = __ffs(hw->dtcs_used);
> +		i = hw->dtc_idx[0];
> 		cmn->dtc[i].cc_active = false;
> 	} else if (type == CMN_TYPE_WP) {
> 		int wp_idx = arm_cmn_wp_idx(event);
> @@ -1735,12 +1732,19 @@ static int arm_cmn_event_init(struct perf_event *event)
> 	hw->dn = arm_cmn_node(cmn, type);
> 	if (!hw->dn)
> 		return -EINVAL;
> +
> +	memset(hw->dtc_idx, -1, sizeof(hw->dtc_idx));
> 	for (dn = hw->dn; dn->type == type; dn++) {
> 		if (bynodeid && dn->id != nodeid) {
> 			hw->dn++;
> 			continue;
> 		}
> 		hw->num_dns++;
> +		if (dn->dtc < 0)
> +			memset(hw->dtc_idx, 0, cmn->num_dtcs);
> +		else
> +			hw->dtc_idx[dn->dtc] = 0;
> +
> 		if (bynodeid)
> 			break;
> 	}
> @@ -1752,12 +1756,6 @@ static int arm_cmn_event_init(struct perf_event *event)
> 			nodeid, nid.x, nid.y, nid.port, nid.dev, type);
> 		return -EINVAL;
> 	}
> -	/*
> -	 * Keep assuming non-cycles events count in all DTC domains; turns out
> -	 * it's hard to make a worthwhile optimisation around this, short of
> -	 * going all-in with domain-local counter allocation as well.
> -	 */
> -	hw->dtcs_used = (1U << cmn->num_dtcs) - 1;
>
> 	return arm_cmn_validate_group(cmn, event);
> }
> @@ -1783,28 +1781,25 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
> 	}
> 	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
>
> -	for (i = 0; hw->dtcs_used & (1U << i); i++)
> -		cmn->dtc[i].counters[hw->dtc_idx] = NULL;
> +	for_each_hw_dtc_idx(hw, j, idx)
> +		cmn->dtc[j].counters[idx] = NULL;
> }
>
> static int arm_cmn_event_add(struct perf_event *event, int flags)
> {
> 	struct arm_cmn *cmn = to_cmn(event->pmu);
> 	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
> -	struct arm_cmn_dtc *dtc = &cmn->dtc[0];
> 	struct arm_cmn_node *dn;
> 	enum cmn_node_type type = CMN_EVENT_TYPE(event);
> -	unsigned int i, dtc_idx, input_sel;
> +	unsigned int input_sel, i = 0;
>
> 	if (type == CMN_TYPE_DTC) {
> -		i = 0;
> 		while (cmn->dtc[i].cycles)
> 			if (++i == cmn->num_dtcs)
> 				return -ENOSPC;
>
> 		cmn->dtc[i].cycles = event;
> -		hw->dtc_idx = CMN_DT_NUM_COUNTERS;
> -		hw->dtcs_used = 1U << i;
> +		hw->dtc_idx[0] = i;
>
> 		if (flags & PERF_EF_START)
> 			arm_cmn_event_start(event, 0);
> @@ -1812,17 +1807,22 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
> 	}
>
> 	/* Grab a free global counter first... */
> -	dtc_idx = 0;
> -	while (dtc->counters[dtc_idx])
> -		if (++dtc_idx == CMN_DT_NUM_COUNTERS)
> -			return -ENOSPC;
> -
> -	hw->dtc_idx = dtc_idx;
> +	for_each_hw_dtc_idx(hw, j, idx) {
> +		if (j > 0) {
> +			idx = hw->dtc_idx[0];
> +		} else {
> +			idx = 0;
> +			while (cmn->dtc[j].counters[idx])
> +				if (++idx == CMN_DT_NUM_COUNTERS)
> +					goto free_dtms;
> +		}
> +		hw->dtc_idx[j] = idx;
> +	}
>
> 	/* ...then the local counters to feed it. */
> 	for_each_hw_dn(hw, dn, i) {
> 		struct arm_cmn_dtm *dtm = &cmn->dtms[dn->dtm] + hw->dtm_offset;
> -		unsigned int dtm_idx, shift;
> +		unsigned int dtm_idx, shift, d = 0;
> 		u64 reg;
>
> 		dtm_idx = 0;
> @@ -1841,11 +1841,11 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
>
> 			tmp = dtm->wp_event[wp_idx ^ 1];
> 			if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
> -					CMN_EVENT_WP_COMBINE(dtc->counters[tmp]))
> +					CMN_EVENT_WP_COMBINE(cmn->dtc[d].counters[tmp]))
> 				goto free_dtms;
>
> 			input_sel = CMN__PMEVCNT0_INPUT_SEL_WP + wp_idx;
> -			dtm->wp_event[wp_idx] = dtc_idx;
> +			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
> 			writel_relaxed(cfg, dtm->base + CMN_DTM_WPn_CONFIG(wp_idx));
> 		} else {
> 			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
> @@ -1865,7 +1865,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
> 		dtm->input_sel[dtm_idx] = input_sel;
> 		shift = CMN__PMEVCNTn_GLOBAL_NUM_SHIFT(dtm_idx);
> 		dtm->pmu_config_low &= ~(CMN__PMEVCNT0_GLOBAL_NUM << shift);
> -		dtm->pmu_config_low |= FIELD_PREP(CMN__PMEVCNT0_GLOBAL_NUM, dtc_idx) << shift;
> +		dtm->pmu_config_low |= FIELD_PREP(CMN__PMEVCNT0_GLOBAL_NUM, hw->dtc_idx[d]) << shift;
> 		dtm->pmu_config_low |= CMN__PMEVCNT_PAIRED(dtm_idx);
> 		reg = (u64)le32_to_cpu(dtm->pmu_config_high) << 32 | dtm->pmu_config_low;
> 		writeq_relaxed(reg, dtm->base + CMN_DTM_PMU_CONFIG);
> @@ -1893,7 +1893,7 @@ static void arm_cmn_event_del(struct perf_event *event, int flags)
> 	arm_cmn_event_stop(event, PERF_EF_UPDATE);
>
> 	if (type == CMN_TYPE_DTC)
> -		cmn->dtc[__ffs(hw->dtcs_used)].cycles = NULL;
> +		cmn->dtc[hw->dtc_idx[0]].cycles = NULL;
> 	else
> 		arm_cmn_event_clear(cmn, event, hw->num_dns);
> }
> @@ -2074,7 +2074,6 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
> {
> 	struct arm_cmn_node *dn, *xp;
> 	int dtc_idx = 0;
> -	u8 dtcs_present = (1 << cmn->num_dtcs) - 1;
>
> 	cmn->dtc = devm_kcalloc(cmn->dev, cmn->num_dtcs, sizeof(cmn->dtc[0]), GFP_KERNEL);
> 	if (!cmn->dtc)
> @@ -2084,23 +2083,26 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
>
> 	cmn->xps = arm_cmn_node(cmn, CMN_TYPE_XP);
>
> +	if (cmn->part == PART_CMN600 && cmn->num_dtcs > 1) {
> +		/* We do at least know that a DTC's XP must be in that DTC's domain */
> +		dn = arm_cmn_node(cmn, CMN_TYPE_DTC);
> +		for (int i = 0; i < cmn->num_dtcs; i++)
> +			arm_cmn_node_to_xp(cmn, dn + i)->dtc = i;
> +	}
> +
> 	for (dn = cmn->dns; dn->type; dn++) {
> -		if (dn->type == CMN_TYPE_XP) {
> -			dn->dtc &= dtcs_present;
> +		if (dn->type == CMN_TYPE_XP)
> 			continue;
> -		}
>
> 		xp = arm_cmn_node_to_xp(cmn, dn);
> +		dn->dtc = xp->dtc;
> 		dn->dtm = xp->dtm;
> 		if (cmn->multi_dtm)
> 			dn->dtm += arm_cmn_nid(cmn, dn->id).port / 2;
>
> 		if (dn->type == CMN_TYPE_DTC) {
> -			int err;
> -			/* We do at least know that a DTC's XP must be in that DTC's domain */
> -			if (xp->dtc == 0xf)
> -				xp->dtc = 1 << dtc_idx;
> -			err = arm_cmn_init_dtc(cmn, dn, dtc_idx++);
> +			int err = arm_cmn_init_dtc(cmn, dn, dtc_idx++);
> +
> 			if (err)
> 				return err;
> 		}
> @@ -2258,9 +2260,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 			cmn->mesh_x = xp->logid;
>
> 		if (cmn->part == PART_CMN600)
> -			xp->dtc = 0xf;
> +			xp->dtc = -1;
> 		else
> -			xp->dtc = 1 << arm_cmn_dtc_domain(cmn, xp_region);
> +			xp->dtc = arm_cmn_dtc_domain(cmn, xp_region);
>
> 		xp->dtm = dtm - cmn->dtms;
> 		arm_cmn_init_dtm(dtm++, xp, 0);
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
