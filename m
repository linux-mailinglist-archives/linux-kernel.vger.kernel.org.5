Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBA4754773
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 10:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGOIOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 04:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGOIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 04:14:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656813A99;
        Sat, 15 Jul 2023 01:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/kGLwN3ec9+nmyvzUDxexuK3BLKFDGpWqrzLfBzqVxprwny+hW33blMBTaBMShCgp8bp8D6ExmBfYzW1iwJuE1vyApHwpnM4W9IsMB6u2mNL/hjJDR6M8P5YGEGAfjp2VyCKr7IbwUrZPui5e6hgVEpX17zOdm2sIf1mU+5jmfBwvq3MM75il9ufQLkVJPzuxVRaE+sd9l4QiYVm3xF0TtrgDgvG6RfH7UKcIzUrm+xM1PcyN7EW5eXDtJcjvGFg/g5XiB3HQ6e+l+xFzz28bpqUWd7508jhWqcMR5Z4R7YyCBMsykkJxVFOfU6fyrExHZFBijRI6Z5xw1fDnnAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77JAfvlV1I1BbuOqtzJOgNfgfK9JGyDaKe6ITZmHJDg=;
 b=ZEn6y0BlUmL0scMieJGpLmFoTXQvIPKwLdAQvceTYRlvx3shT+DeOJI6pQTKsCGa0yMDh6apjLyKu020l784P68Wwqn3mAOmytC0sso8k6uHXKHTrcvm1wazK09hG27EKYq//6d0G/ZiM9Km2yjoHGIUXfaKViSnAD+N+YvV97Mj8UqIxzv8uj6eoJbLAsVsbGPsQnXQOC3Wn94pkh0SzzetvbhlVrbmADYRzyOMeoS/leT4rVz+IDjlpikMFInNy8b8SHWpLwL2PoXY52JOGLPS9UaogyCjG/mVuZgCqRNc3skljgQiaHGmlbVbGpSW4Lwkn5zMWnCcwPe1k7hf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77JAfvlV1I1BbuOqtzJOgNfgfK9JGyDaKe6ITZmHJDg=;
 b=bgHvkZDGdQcTVAmqgGq2kn6Jjay03QGPyCCHFTdEA/sorhBqj1PeNbtQWy3lBsj/X45DM6xF24TlY7eD38c34KbvI6ddTzepOR02NOrMSeFUS6Tz7hR5h3CrRm8R2fNo0fQIjA3KnR0l1Zxuxy0Ezan6TtDTyVJ3sSie/tqLIkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5792.namprd13.prod.outlook.com (2603:10b6:806:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Sat, 15 Jul
 2023 08:14:23 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 08:14:22 +0000
Date:   Sat, 15 Jul 2023 09:14:14 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] octeontx2-pf: Install TC filter rules in
 hardware based on priority
Message-ID: <ZLJVVh6BMRqaZZpU@corigine.com>
References: <20230712184011.2409691-1-sumang@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712184011.2409691-1-sumang@marvell.com>
X-ClientProxiedBy: LO4P123CA0379.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: c7eec931-f6fe-4b9d-3083-08db850b7e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxybI+aPkLXFKw3nTr+lnbaGBfbhxNczufikuLraCjLVAq7Y2PMwIhuX/LD2CKTVZJKVLGhLmLX+wqHWYHwDWW/gp9axDRS0QCTlAkEuVRBKN1y2HxC22tQ0xnia5mP12dRunKBtlZ0uN8BTy8dYd0iXWs5rkUU/GYPxBwWehjGr8lAYRXrBUOVC4c91lAswB5zVh+uyzxLTW7cogIi6epOWDN4r5pRKXqS1lEG37S9TZv8WvFATMgO1xHEyMSJ3DmkrBKUsy/SOWGC26y7kVgJgLTDrApZcmYba+kyqfZuYpaQHEfKnsRfRb2qjd8oDGwnZxPvlWq5A6zmhTPQRei1vawHzXtUZXV7hBIpe0TiZdV7scin8tJUYYE35SrWh+utkuyAQEtkmDeGEffmXdt+4YwsDTCFA/48VjwPOCkLn01WPT5J/x3DkWDOzDesitIfC9DrVOs2fdFXbAO+YF3j3jmrCRo4I0wTb3YpA9a1MARGSafgr8s5aGZiNuSfSH6i9gW6MBa/XXVa9cwszA4hJpI+ABTOc6klfECCVjy8gkFbWeSCtRBI+wQnBDZ+S9Ib7/SW5AF32uCQRnFfCt5h4/7TngQwfTRF+gMLV37Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39830400003)(396003)(366004)(376002)(346002)(451199021)(478600001)(38100700002)(4326008)(86362001)(6666004)(6916009)(66556008)(66946007)(66476007)(6486002)(6512007)(316002)(41300700001)(83380400001)(30864003)(186003)(2906002)(2616005)(36756003)(8936002)(8676002)(44832011)(7416002)(5660300002)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtUHyM1pYenZGQYNFQ++/7Jnzc8M2E749FRvppR4qOqAeRleAvA2lxjFaQ3e?=
 =?us-ascii?Q?2GZO3SBOxYN6hG3YivIWN9WdMVkbtL5VGJ9B1QyxtiDunGMSpWZXxD6ZFEpY?=
 =?us-ascii?Q?04QPSds3aD13wjnHmXdYjeJj/s5W7p6yazYgnstQoPnZBecb7pvNFHKRTr6W?=
 =?us-ascii?Q?zERdPbnJMRErwU18UhmPhs+Lnn7BLZ3dG+QkjCi4uz9d53xAvZWBjzUITvNU?=
 =?us-ascii?Q?qTE7DvrC28fieGjSZwchyi2AjcfP81KisB0TKb2/J+B93/jsWFpyjJBzYXPi?=
 =?us-ascii?Q?ulgQO8Pl2b4IHUW7JaImW2+iVhmKL0P2zquwGBmL9U8Ht6d+qNHL1LHg/xaC?=
 =?us-ascii?Q?w8nwMK0u3P8AE5d8mLiTrd/SheAnZMl3LWgTqsYbu00COd/d115Fit4u+Rfl?=
 =?us-ascii?Q?itRjtf8fnFSfEFI+WQ7LZVJqUcGq9EjB/M1vL278Fsuq2zL3cpiW0DmauBZm?=
 =?us-ascii?Q?utiQTqnTycrOXfywVoxxCJuBoMoezz5A5tYuGB547nCGEq39RiNL1fwpc2jh?=
 =?us-ascii?Q?0BAus5DQ6SBcwAdHYrX06wESBCgokj96EvIqBsr5iwTEPsiBNzX9yQbFqROS?=
 =?us-ascii?Q?cZWU3Zw/kfCbloH4yXxhXnAehSi3cIJR+BkS264jDyZvWXL6lMo6/gD7xgM5?=
 =?us-ascii?Q?rp5/zN6CVA9qj8T4xtQl2Q1MB1sVUaFrwSqyB6rQOQbLcXOKpaUZoTgzY/SU?=
 =?us-ascii?Q?1q/2MnD6AvNb1L5TpFyQkNRPG4ewWwOfkgwfsmvxMLtnQ9Ln6WeMx9z3Bj/e?=
 =?us-ascii?Q?JolH4pfOPuOk6RAPTAoe+oEXAV/YGtbicInEggdYaeSF6nwLfiSUXmvSkM83?=
 =?us-ascii?Q?4oMIcPCwcvykfVu/lxm5pX4nWmuqtGP+Hy/dWYrnA0Mo1SxVgKVG2RAUhrab?=
 =?us-ascii?Q?UXYMPuUzbfeFSL1i/q9qi4Y1J8gBHwSTdGpg9Z1P65uNtW8EeZDnJu3TdS6X?=
 =?us-ascii?Q?B/iQ6X8ehKlAC/DD/vF2UBJO1EWZrHTpfpFrUxVwYeYnXg92bwATKPu/GGQI?=
 =?us-ascii?Q?mykX4GSZDASYrqJ+MwAIQyr8Kk+eRnaZtTlAiV/njk2PX3jliysoIFBcCicm?=
 =?us-ascii?Q?16zORxyQs8f7cK7N+646NRS14fUxQc/WAWvKCCL42sr+GwYRTEkrq/IkQ+F/?=
 =?us-ascii?Q?b/zIh4Yi+un8Lb6I/nC6/vJJiuxpIrXnL3ZP7jbKQFF8ec3ZxFavBkvf5PM4?=
 =?us-ascii?Q?8KrLv9qSb8hEjZ7O1IezPQ+/wKaRjfbQzuKpQRL5FdySa2W6VTen/lwNj5Ib?=
 =?us-ascii?Q?ta3cAQ/onIFgetH4QaNJWAoG/qYphP6ZJEvTTlVHGcXC2Lm5QfSj9wFpmMws?=
 =?us-ascii?Q?LKyaSKd5qcp1XzhrVMB/fV9TMjzrtwvHuBtuXcT+QK9Bo5UapHI0jQm7/Y4C?=
 =?us-ascii?Q?KLHP5yCkmhteOcKE53W7z3jrMFQKzfVfAX4iEILggZa7Sryisbb+Gb7PN4wj?=
 =?us-ascii?Q?mqFmvTAVOQ0ybH9PSSQyd2WE7Wvhs6RezYy5IQQE+HV4/THoDtVGEPu0VctY?=
 =?us-ascii?Q?Vp3s1785mvCZUQOYKkE3eZi1qJxUlz+5BBuavUKNeoCW8AxPPCp1qrslauYF?=
 =?us-ascii?Q?ZHxNI82yajDo9t2HfwV5fSDzQn6UkTmlGBjOjsmGbZoByksNLxiDynkvRCRQ?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eec931-f6fe-4b9d-3083-08db850b7e9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 08:14:22.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgO9nJlPgrBaiyTMicUNDPeIFxhCDnC7MGp6dKyqgMlgMTFf65HC7vgBz0y1+xHT+Yjzo4TPPKHGjA+lzpk1pFCNICj2w2qgHgevVwCcYoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5792
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:10:11AM +0530, Suman Ghosh wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Hi Suman,

unfortunately this patch does not appear to apply to net-next,
which breaks our processes.

Please consider posting a v2 rebased on net-next.

Thanks!

> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   9 +-
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |  10 +-
>  .../marvell/octeontx2/af/rvu_switch.c         |   6 +-
>  .../marvell/octeontx2/nic/otx2_common.h       |  11 +-
>  .../marvell/octeontx2/nic/otx2_devlink.c      |   1 -
>  .../marvell/octeontx2/nic/otx2_flows.c        |   2 +
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 315 +++++++++++++-----
>  7 files changed, 251 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 8d5d5a0f68c4..ba6e249ee1df 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -231,7 +231,7 @@ M(NPC_GET_KEX_CFG,	  0x600c, npc_get_kex_cfg,			\
>  M(NPC_INSTALL_FLOW,	  0x600d, npc_install_flow,			       \
>  				  npc_install_flow_req, npc_install_flow_rsp)  \
>  M(NPC_DELETE_FLOW,	  0x600e, npc_delete_flow,			\
> -				  npc_delete_flow_req, msg_rsp)		\
> +				  npc_delete_flow_req, npc_delete_flow_rsp)	\
>  M(NPC_MCAM_READ_ENTRY,	  0x600f, npc_mcam_read_entry,			\
>  				  npc_mcam_read_entry_req,		\
>  				  npc_mcam_read_entry_rsp)		\
> @@ -1467,6 +1467,8 @@ struct npc_install_flow_req {
>  	u8  vtag0_op;
>  	u16 vtag1_def;
>  	u8  vtag1_op;
> +	/* old counter value */
> +	u16 cntr_val;
>  };
>  
>  struct npc_install_flow_rsp {
> @@ -1482,6 +1484,11 @@ struct npc_delete_flow_req {
>  	u8 all; /* PF + VFs */
>  };
>  
> +struct npc_delete_flow_rsp {
> +	struct mbox_msghdr hdr;
> +	u16 cntr_val;
> +};
> +
>  struct npc_mcam_read_entry_req {
>  	struct mbox_msghdr hdr;
>  	u16 entry;	 /* MCAM entry to read */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index 50d3994efa97..e016669bc327 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1148,7 +1148,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
>  	write_req.enable_entry = (u8)enable;
>  	/* if counter is available then clear and use it */
>  	if (req->set_cntr && rule->has_cntr) {
> -		rvu_write64(rvu, blkaddr, NPC_AF_MATCH_STATX(rule->cntr), 0x00);
> +		rvu_write64(rvu, blkaddr, NPC_AF_MATCH_STATX(rule->cntr), req->cntr_val);
>  		write_req.set_cntr = 1;
>  		write_req.cntr = rule->cntr;
>  	}
> @@ -1362,12 +1362,13 @@ static int npc_delete_flow(struct rvu *rvu, struct rvu_npc_mcam_rule *rule,
>  
>  int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
>  				     struct npc_delete_flow_req *req,
> -				     struct msg_rsp *rsp)
> +				     struct npc_delete_flow_rsp *rsp)
>  {
>  	struct npc_mcam *mcam = &rvu->hw->mcam;
>  	struct rvu_npc_mcam_rule *iter, *tmp;
>  	u16 pcifunc = req->hdr.pcifunc;
>  	struct list_head del_list;
> +	int blkaddr;
>  
>  	INIT_LIST_HEAD(&del_list);
>  
> @@ -1383,6 +1384,11 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
>  				list_move_tail(&iter->list, &del_list);
>  			/* single rule */
>  			} else if (req->entry == iter->entry) {
> +				blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> +				if (blkaddr)
> +					rsp->cntr_val = rvu_read64(rvu, blkaddr,
> +								   NPC_AF_MATCH_STATX(iter->cntr));
> +
>  				list_move_tail(&iter->list, &del_list);
>  				break;
>  			}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> index 3392487f6b47..329b5a02914d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> @@ -145,6 +145,7 @@ void rvu_switch_enable(struct rvu *rvu)
>  	struct npc_mcam_alloc_entry_req alloc_req = { 0 };
>  	struct npc_mcam_alloc_entry_rsp alloc_rsp = { 0 };
>  	struct npc_delete_flow_req uninstall_req = { 0 };
> +	struct npc_delete_flow_rsp uninstall_rsp = { 0 };
>  	struct npc_mcam_free_entry_req free_req = { 0 };
>  	struct rvu_switch *rswitch = &rvu->rswitch;
>  	struct msg_rsp rsp;
> @@ -184,7 +185,7 @@ void rvu_switch_enable(struct rvu *rvu)
>  uninstall_rules:
>  	uninstall_req.start = rswitch->start_entry;
>  	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
> -	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &rsp);
> +	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
>  	kfree(rswitch->entry2pcifunc);
>  free_entries:
>  	free_req.all = 1;
> @@ -196,6 +197,7 @@ void rvu_switch_enable(struct rvu *rvu)
>  void rvu_switch_disable(struct rvu *rvu)
>  {
>  	struct npc_delete_flow_req uninstall_req = { 0 };
> +	struct npc_delete_flow_rsp uninstall_rsp = { 0 };
>  	struct npc_mcam_free_entry_req free_req = { 0 };
>  	struct rvu_switch *rswitch = &rvu->rswitch;
>  	struct rvu_hwinfo *hw = rvu->hw;
> @@ -232,7 +234,7 @@ void rvu_switch_disable(struct rvu *rvu)
>  	uninstall_req.start = rswitch->start_entry;
>  	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
>  	free_req.all = 1;
> -	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &rsp);
> +	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
>  	rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
>  	rswitch->used_entries = 0;
>  	kfree(rswitch->entry2pcifunc);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 282db6fe3b08..6f1ff03cdc77 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -337,13 +337,8 @@ struct otx2_flow_config {
>  	u32			*bmap_to_dmacindex;
>  	unsigned long		*dmacflt_bmap;
>  	struct list_head	flow_list;
> -};
> -
> -struct otx2_tc_info {
> -	/* hash table to store TC offloaded flows */
> -	struct rhashtable		flow_table;
> -	struct rhashtable_params	flow_ht_params;
> -	unsigned long			*tc_entries_bitmap;
> +	struct list_head	flow_list_tc;
> +	bool			ntuple;
>  };
>  
>  struct dev_hw_ops {
> @@ -463,7 +458,6 @@ struct otx2_nic {
>  	/* NPC MCAM */
>  	struct otx2_flow_config	*flow_cfg;
>  	struct otx2_mac_table	*mac_table;
> -	struct otx2_tc_info	tc_info;
>  
>  	u64			reset_count;
>  	struct work_struct	reset_task;
> @@ -1001,7 +995,6 @@ int otx2_init_tc(struct otx2_nic *nic);
>  void otx2_shutdown_tc(struct otx2_nic *nic);
>  int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>  		  void *type_data);
> -int otx2_tc_alloc_ent_bitmap(struct otx2_nic *nic);
>  /* CGX/RPM DMAC filters support */
>  int otx2_dmacflt_get_max_cnt(struct otx2_nic *pf);
>  int otx2_dmacflt_add(struct otx2_nic *pf, const u8 *mac, u32 bit_pos);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> index 777a27047c8e..5f71a72f95e5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> @@ -41,7 +41,6 @@ static int otx2_dl_mcam_count_set(struct devlink *devlink, u32 id,
>  		return 0;
>  
>  	otx2_alloc_mcam_entries(pfvf, ctx->val.vu16);
> -	otx2_tc_alloc_ent_bitmap(pfvf);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 709fc0114fbd..70c3ae2caddd 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> @@ -253,6 +253,7 @@ int otx2vf_mcam_flow_init(struct otx2_nic *pfvf)
>  
>  	flow_cfg = pfvf->flow_cfg;
>  	INIT_LIST_HEAD(&flow_cfg->flow_list);
> +	INIT_LIST_HEAD(&flow_cfg->flow_list_tc);
>  	flow_cfg->max_flows = 0;
>  
>  	return 0;
> @@ -275,6 +276,7 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
>  		return -ENOMEM;
>  
>  	INIT_LIST_HEAD(&pf->flow_cfg->flow_list);
> +	INIT_LIST_HEAD(&pf->flow_cfg->flow_list_tc);
>  
>  	/* Allocate bare minimum number of MCAM entries needed for
>  	 * unicast and ntuple filters.
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index e64318c110fd..070210e86778 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -48,9 +48,8 @@ struct otx2_tc_flow_stats {
>  };
>  
>  struct otx2_tc_flow {
> -	struct rhash_head		node;
> +	struct list_head		list;
>  	unsigned long			cookie;
> -	unsigned int			bitpos;
>  	struct rcu_head			rcu;
>  	struct otx2_tc_flow_stats	stats;
>  	spinlock_t			lock; /* lock for stats */
> @@ -58,31 +57,10 @@ struct otx2_tc_flow {
>  	u16				entry;
>  	u16				leaf_profile;
>  	bool				is_act_police;
> +	u32				prio;
> +	struct npc_install_flow_req	req;
>  };
>  
> -int otx2_tc_alloc_ent_bitmap(struct otx2_nic *nic)
> -{
> -	struct otx2_tc_info *tc = &nic->tc_info;
> -
> -	if (!nic->flow_cfg->max_flows)
> -		return 0;
> -
> -	/* Max flows changed, free the existing bitmap */
> -	kfree(tc->tc_entries_bitmap);
> -
> -	tc->tc_entries_bitmap =
> -			kcalloc(BITS_TO_LONGS(nic->flow_cfg->max_flows),
> -				sizeof(long), GFP_KERNEL);
> -	if (!tc->tc_entries_bitmap) {
> -		netdev_err(nic->netdev,
> -			   "Unable to alloc TC flow entries bitmap\n");
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(otx2_tc_alloc_ent_bitmap);
> -
>  static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
>  				      u32 *burst_exp, u32 *burst_mantissa)
>  {
> @@ -674,8 +652,119 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>  	return otx2_tc_parse_actions(nic, &rule->action, req, f, node);
>  }
>  
> -static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry)
> +static void otx2_destroy_tc_flow_list(struct otx2_nic *pfvf)
> +{
> +	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
> +	struct otx2_tc_flow *iter, *tmp;
> +
> +	if (!(pfvf->flags & OTX2_FLAG_MCAM_ENTRIES_ALLOC))
> +		return;
> +
> +	list_for_each_entry_safe(iter, tmp, &flow_cfg->flow_list_tc, list) {
> +		list_del(&iter->list);
> +		kfree(iter);
> +		flow_cfg->nr_flows--;
> +	}
> +}
> +
> +static struct otx2_tc_flow *otx2_tc_get_entry_by_cookie(struct otx2_flow_config *flow_cfg,
> +							unsigned long cookie)
> +{
> +	struct otx2_tc_flow *tmp;
> +
> +	list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list) {
> +		if (tmp->cookie == cookie)
> +			return tmp;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct otx2_tc_flow *otx2_tc_get_entry_by_index(struct otx2_flow_config *flow_cfg,
> +						       int index)
> +{
> +	struct otx2_tc_flow *tmp;
> +	int i = 0;
> +
> +	list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list) {
> +		if (i == index)
> +			return tmp;
> +
> +		i++;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void otx2_tc_del_from_flow_list(struct otx2_flow_config *flow_cfg,
> +				       struct otx2_tc_flow *node)
>  {
> +	struct list_head *pos, *n;
> +	struct otx2_tc_flow *tmp;
> +
> +	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
> +		tmp = list_entry(pos, struct otx2_tc_flow, list);
> +		if (node == tmp) {
> +			list_del(&node->list);
> +			return;
> +		}
> +	}
> +}
> +
> +static int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
> +				    struct otx2_tc_flow *node)
> +{
> +	struct list_head *pos, *n;
> +	struct otx2_tc_flow *tmp;
> +	int index = 0;
> +
> +	/* If the flow list is empty then add the new node */
> +	if (list_empty(&flow_cfg->flow_list_tc)) {
> +		list_add(&node->list, &flow_cfg->flow_list_tc);
> +		return index;
> +	}
> +
> +	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
> +		tmp = list_entry(pos, struct otx2_tc_flow, list);
> +		if (node->prio < tmp->prio)
> +			break;
> +
> +		index++;
> +	}
> +
> +	list_add(&node->list, pos->prev);
> +	return index;
> +}
> +
> +static int otx2_add_mcam_flow_entry(struct otx2_nic *nic, struct npc_install_flow_req *req)
> +{
> +	struct npc_install_flow_req *tmp_req;
> +	int err;
> +
> +	mutex_lock(&nic->mbox.lock);
> +	tmp_req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
> +	if (!tmp_req) {
> +		mutex_unlock(&nic->mbox.lock);
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(tmp_req, req, sizeof(struct npc_install_flow_req));
> +	/* Send message to AF */
> +	err = otx2_sync_mbox_msg(&nic->mbox);
> +	if (err) {
> +		netdev_err(nic->netdev, "Failed to install MCAM flow entry %d\n",
> +			   req->entry);
> +		mutex_unlock(&nic->mbox.lock);
> +		return -EFAULT;
> +	}
> +
> +	mutex_unlock(&nic->mbox.lock);
> +	return 0;
> +}
> +
> +static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry, u16 *cntr_val)
> +{
> +	struct npc_delete_flow_rsp __maybe_unused *rsp;
>  	struct npc_delete_flow_req *req;
>  	int err;
>  
> @@ -696,22 +785,107 @@ static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry)
>  		mutex_unlock(&nic->mbox.lock);
>  		return -EFAULT;
>  	}
> +
> +	if (cntr_val) {
> +		rsp = (struct npc_delete_flow_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
> +								      0, &req->hdr);
> +		*cntr_val = rsp->cntr_val;
> +	}
> +
>  	mutex_unlock(&nic->mbox.lock);
>  
>  	return 0;
>  }
>  
> +static int otx2_tc_update_mcam_table_del_req(struct otx2_nic *nic,
> +					     struct otx2_flow_config *flow_cfg,
> +					     struct otx2_tc_flow *node)
> +{
> +	struct list_head *pos, *n;
> +	struct otx2_tc_flow *tmp;
> +	int i = 0, index = 0;
> +	u16 cntr_val;
> +
> +	/* Find and delete the entry from the list and re-install
> +	 * all the entries from beginning to the index of the
> +	 * deleted entry to higher mcam indexes.
> +	 */
> +	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
> +		tmp = list_entry(pos, struct otx2_tc_flow, list);
> +		if (node == tmp) {
> +			list_del(&tmp->list);
> +			break;
> +		}
> +
> +		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
> +		tmp->entry++;
> +		tmp->req.entry = tmp->entry;
> +		tmp->req.cntr_val = cntr_val;
> +		index++;
> +	}
> +
> +	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
> +		if (i == index)
> +			break;
> +
> +		tmp = list_entry(pos, struct otx2_tc_flow, list);
> +		otx2_add_mcam_flow_entry(nic, &tmp->req);
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int otx2_tc_update_mcam_table_add_req(struct otx2_nic *nic,
> +					     struct otx2_flow_config *flow_cfg,
> +					     struct otx2_tc_flow *node)
> +{
> +	int mcam_idx = flow_cfg->max_flows - flow_cfg->nr_flows - 1;
> +	struct otx2_tc_flow *tmp;
> +	int list_idx, i;
> +	u16 cntr_val;
> +
> +	/* Find the index of the entry(list_idx) whose priority
> +	 * is greater than the new entry and re-install all
> +	 * the entries from beginning to list_idx to higher
> +	 * mcam indexes.
> +	 */
> +	list_idx = otx2_tc_add_to_flow_list(flow_cfg, node);
> +	for (i = 0; i < list_idx; i++) {
> +		tmp = otx2_tc_get_entry_by_index(flow_cfg, i);
> +		if (!tmp)
> +			return -ENOMEM;
> +
> +		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
> +		tmp->entry = flow_cfg->flow_ent[mcam_idx];
> +		tmp->req.entry = tmp->entry;
> +		tmp->req.cntr_val = cntr_val;
> +		otx2_add_mcam_flow_entry(nic, &tmp->req);
> +		mcam_idx++;
> +	}
> +
> +	return mcam_idx;
> +}
> +
> +static int otx2_tc_update_mcam_table(struct otx2_nic *nic,
> +				     struct otx2_flow_config *flow_cfg,
> +				     struct otx2_tc_flow *node,
> +				     bool add_req)
> +{
> +	if (add_req)
> +		return otx2_tc_update_mcam_table_add_req(nic, flow_cfg, node);
> +
> +	return otx2_tc_update_mcam_table_del_req(nic, flow_cfg, node);
> +}
> +
>  static int otx2_tc_del_flow(struct otx2_nic *nic,
>  			    struct flow_cls_offload *tc_flow_cmd)
>  {
>  	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
> -	struct otx2_tc_info *tc_info = &nic->tc_info;
>  	struct otx2_tc_flow *flow_node;
>  	int err;
>  
> -	flow_node = rhashtable_lookup_fast(&tc_info->flow_table,
> -					   &tc_flow_cmd->cookie,
> -					   tc_info->flow_ht_params);
> +	flow_node = otx2_tc_get_entry_by_cookie(flow_cfg, tc_flow_cmd->cookie);
>  	if (!flow_node) {
>  		netdev_err(nic->netdev, "tc flow not found for cookie 0x%lx\n",
>  			   tc_flow_cmd->cookie);
> @@ -739,14 +913,10 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  		mutex_unlock(&nic->mbox.lock);
>  	}
>  
> -	otx2_del_mcam_flow_entry(nic, flow_node->entry);
> -
> -	WARN_ON(rhashtable_remove_fast(&nic->tc_info.flow_table,
> -				       &flow_node->node,
> -				       nic->tc_info.flow_ht_params));
> +	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
> +	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
>  	kfree_rcu(flow_node, rcu);
>  
> -	clear_bit(flow_node->bitpos, tc_info->tc_entries_bitmap);
>  	flow_cfg->nr_flows--;
>  
>  	return 0;
> @@ -757,15 +927,14 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  {
>  	struct netlink_ext_ack *extack = tc_flow_cmd->common.extack;
>  	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
> -	struct otx2_tc_info *tc_info = &nic->tc_info;
>  	struct otx2_tc_flow *new_node, *old_node;
>  	struct npc_install_flow_req *req, dummy;
> -	int rc, err;
> +	int rc, err, mcam_idx;
>  
>  	if (!(nic->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
>  		return -ENOMEM;
>  
> -	if (bitmap_full(tc_info->tc_entries_bitmap, flow_cfg->max_flows)) {
> +	if (flow_cfg->nr_flows == flow_cfg->max_flows) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "Free MCAM entry not available to add the flow");
>  		return -ENOMEM;
> @@ -777,6 +946,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  		return -ENOMEM;
>  	spin_lock_init(&new_node->lock);
>  	new_node->cookie = tc_flow_cmd->cookie;
> +	new_node->prio = tc_flow_cmd->common.prio;
>  
>  	memset(&dummy, 0, sizeof(struct npc_install_flow_req));
>  
> @@ -787,12 +957,11 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  	}
>  
>  	/* If a flow exists with the same cookie, delete it */
> -	old_node = rhashtable_lookup_fast(&tc_info->flow_table,
> -					  &tc_flow_cmd->cookie,
> -					  tc_info->flow_ht_params);
> +	old_node = otx2_tc_get_entry_by_cookie(flow_cfg, tc_flow_cmd->cookie);
>  	if (old_node)
>  		otx2_tc_del_flow(nic, tc_flow_cmd);
>  
> +	mcam_idx = otx2_tc_update_mcam_table(nic, flow_cfg, new_node, true);
>  	mutex_lock(&nic->mbox.lock);
>  	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
>  	if (!req) {
> @@ -804,10 +973,8 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  	memcpy(&dummy.hdr, &req->hdr, sizeof(struct mbox_msghdr));
>  	memcpy(req, &dummy, sizeof(struct npc_install_flow_req));
>  
> -	new_node->bitpos = find_first_zero_bit(tc_info->tc_entries_bitmap,
> -					       flow_cfg->max_flows);
>  	req->channel = nic->hw.rx_chan_base;
> -	req->entry = flow_cfg->flow_ent[flow_cfg->max_flows - new_node->bitpos - 1];
> +	req->entry = flow_cfg->flow_ent[mcam_idx];
>  	req->intf = NIX_INTF_RX;
>  	req->set_cntr = 1;
>  	new_node->entry = req->entry;
> @@ -817,26 +984,18 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  	if (rc) {
>  		NL_SET_ERR_MSG_MOD(extack, "Failed to install MCAM flow entry");
>  		mutex_unlock(&nic->mbox.lock);
> -		kfree_rcu(new_node, rcu);
>  		goto free_leaf;
>  	}
> -	mutex_unlock(&nic->mbox.lock);
>  
> -	/* add new flow to flow-table */
> -	rc = rhashtable_insert_fast(&nic->tc_info.flow_table, &new_node->node,
> -				    nic->tc_info.flow_ht_params);
> -	if (rc) {
> -		otx2_del_mcam_flow_entry(nic, req->entry);
> -		kfree_rcu(new_node, rcu);
> -		goto free_leaf;
> -	}
> -
> -	set_bit(new_node->bitpos, tc_info->tc_entries_bitmap);
> +	mutex_unlock(&nic->mbox.lock);
> +	memcpy(&new_node->req, req, sizeof(struct npc_install_flow_req));
>  	flow_cfg->nr_flows++;
>  
>  	return 0;
>  
>  free_leaf:
> +	otx2_tc_del_from_flow_list(flow_cfg, new_node);
> +	kfree_rcu(new_node, rcu);
>  	if (new_node->is_act_police) {
>  		mutex_lock(&nic->mbox.lock);
>  
> @@ -863,16 +1022,13 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  static int otx2_tc_get_flow_stats(struct otx2_nic *nic,
>  				  struct flow_cls_offload *tc_flow_cmd)
>  {
> -	struct otx2_tc_info *tc_info = &nic->tc_info;
>  	struct npc_mcam_get_stats_req *req;
>  	struct npc_mcam_get_stats_rsp *rsp;
>  	struct otx2_tc_flow_stats *stats;
>  	struct otx2_tc_flow *flow_node;
>  	int err;
>  
> -	flow_node = rhashtable_lookup_fast(&tc_info->flow_table,
> -					   &tc_flow_cmd->cookie,
> -					   tc_info->flow_ht_params);
> +	flow_node = otx2_tc_get_entry_by_cookie(nic->flow_cfg, tc_flow_cmd->cookie);
>  	if (!flow_node) {
>  		netdev_info(nic->netdev, "tc flow not found for cookie %lx",
>  			    tc_flow_cmd->cookie);
> @@ -1020,12 +1176,20 @@ static int otx2_setup_tc_block_ingress_cb(enum tc_setup_type type,
>  					  void *type_data, void *cb_priv)
>  {
>  	struct otx2_nic *nic = cb_priv;
> +	bool ntuple;
>  
>  	if (!tc_cls_can_offload_and_chain0(nic->netdev, type_data))
>  		return -EOPNOTSUPP;
>  
> +	ntuple = !!(nic->netdev->features & NETIF_F_NTUPLE);
>  	switch (type) {
>  	case TC_SETUP_CLSFLOWER:
> +		if (ntuple) {
> +			netdev_warn(nic->netdev,
> +				    "Can't install TC flower offload rule when NTUPLE is active");
> +			return -EOPNOTSUPP;
> +		}
> +
>  		return otx2_setup_tc_cls_flower(nic, type_data);
>  	case TC_SETUP_CLSMATCHALL:
>  		return otx2_setup_tc_ingress_matchall(nic, type_data);
> @@ -1108,41 +1272,16 @@ int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>  }
>  EXPORT_SYMBOL(otx2_setup_tc);
>  
> -static const struct rhashtable_params tc_flow_ht_params = {
> -	.head_offset = offsetof(struct otx2_tc_flow, node),
> -	.key_offset = offsetof(struct otx2_tc_flow, cookie),
> -	.key_len = sizeof(((struct otx2_tc_flow *)0)->cookie),
> -	.automatic_shrinking = true,
> -};
> -
>  int otx2_init_tc(struct otx2_nic *nic)
>  {
> -	struct otx2_tc_info *tc = &nic->tc_info;
> -	int err;
> -
>  	/* Exclude receive queue 0 being used for police action */
>  	set_bit(0, &nic->rq_bmap);
> -
> -	if (!nic->flow_cfg) {
> -		netdev_err(nic->netdev,
> -			   "Can't init TC, nic->flow_cfg is not setup\n");
> -		return -EINVAL;
> -	}
> -
> -	err = otx2_tc_alloc_ent_bitmap(nic);
> -	if (err)
> -		return err;
> -
> -	tc->flow_ht_params = tc_flow_ht_params;
> -	return rhashtable_init(&tc->flow_table, &tc->flow_ht_params);
> +	return 0;
>  }
>  EXPORT_SYMBOL(otx2_init_tc);
>  
>  void otx2_shutdown_tc(struct otx2_nic *nic)
>  {
> -	struct otx2_tc_info *tc = &nic->tc_info;
> -
> -	kfree(tc->tc_entries_bitmap);
> -	rhashtable_destroy(&tc->flow_table);
> +	otx2_destroy_tc_flow_list(nic);
>  }
>  EXPORT_SYMBOL(otx2_shutdown_tc);
> -- 
> 2.25.1
> 
> 
