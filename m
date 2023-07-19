Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA67598D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGSOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGSOua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:50:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2112.outbound.protection.outlook.com [40.107.243.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F72137;
        Wed, 19 Jul 2023 07:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUinR/gthL+4wOMT0XtQiC53fcT+6NBLqQpauJlv38+gNm2NZvWeSTtfrAkksumrqjQdn9X9dIttdCJiHrPXCDFsx1eY6sNfLEBSY9FZ4YT78njdEqkbJ1Vti//dvrOMm1ncI7gIxmriE/9umhgws9MVX+w3S+yokMpc+KFwZ8DJa0svn/WDGMJRoX1ihqRMMbVEaPC8Ps4EZqWKwMsMNNm6YKEZVefPgZ+Dhu7NvecBDXTqZ8mkRG0YBDQP3Cwmkt61WxE/HVLWGsOHH6Lic2cbm3vtihnWE9uz5RV2fErwtf0U9Z8vhrLX/UyFw6akC9P5GahHvS9kb1f3ywTG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPr81LvKj49RgTjS8yk3ARW5PKbWnpc21I6/fnMH1qI=;
 b=ZhSj1p0wR2760c08fWHG+dQc+aAOP9l0uRji3Fbsj2brYiEO84P+cDQsC113iFFr9foHdjma1yRXoPzHpMyJ1iA2sRngbJneqLMllamqQE5cNZpsGxZHJa9WSies5Z7RWLLUgXSEaxbWu11PDeVWcjmi0pc0/EKBp+NtTuIvlOPFKG5/TG+o8unqJJu+P2m1u3KnGGiQdw6CVgbb+GtNNYZfzDn7Q+aec1HwvjbxSbZhP1d5upUO2YNGfKsKg9prBXWMgo6HOQNWIeIkebivj+204TDTxvWk7dNZ4ZF3aD+6cMX5p9tN9GZtIf432LblBwcIMzqoE7EcMmO/3FIuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPr81LvKj49RgTjS8yk3ARW5PKbWnpc21I6/fnMH1qI=;
 b=FmDIr6NTZrEcb/ME9+RN6Q8/BMoRs8eqBfPNch1Ri0lKvGr8atfOxnRIg8i8YGt1eE5aIj9slaoSbwBZHqKSd6d2l0tLvuvfCAkclP82wJnePKX0ffKBloVYDCdiXg6HnUyqHfvegrmP0Sbn0N2h58cw2e1el3JcR481Tm3qBec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5997.namprd13.prod.outlook.com (2603:10b6:510:161::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 14:49:58 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 14:49:58 +0000
Date:   Wed, 19 Jul 2023 15:49:48 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V3 1/2] octeontx2-af: Fix hash extraction mbox message
Message-ID: <ZLf4DKJ6IU8+Z2zS@corigine.com>
References: <20230716193049.2499410-1-sumang@marvell.com>
 <20230716193049.2499410-2-sumang@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716193049.2499410-2-sumang@marvell.com>
X-ClientProxiedBy: LO2P265CA0450.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b9aa2d-414b-4726-9248-08db88676be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+FZR0wkvuDRMTmsuTOyuoDSSTaGd95IjL8PP+uhQBEMmTa/cpkrYYbL0Bs7qq86G0j7wimokbkb4UqVDk0D8NuDSFQMap4bww64/dTILgK+/cZh403lows/bfCQWZpKZI6I2RtO2XLtmQwK+7PwkRhz1G6VBQPCtr+asrENQP4PMcET699z5G9CNjGrBdXM85jfQgY3UajE/hy4n1ebWstwhhKmjfb3glxkvW58dqzVzUcid0eh17/5TS5f7ROqyMXvngnslTpvTzPlrj78F+zSZfuFpSLE6owsQ1pjYLQfDo43dwVwr4zXu/wOZFFj0GCQjIe+eW9ZgZVWLwyY33YIdE+E+t0xNZ8CiIlIv4/AufhDCLtNfQk8gaMjo1rqimCracIOIcFWyKr97NCtbrJapww7DCDYdbMcVusxBRo2eFvz6NnXeNR4+GyK+ZEd5r+gcxW/8aK+2ZuW+SovlmewHDXjB25WXO6RJMXS385huyyPmtBcft/j5gnJhKtiUqIgxe3NKMw81S1pEk6JvSnlEZJngQEbRXTbEgh1Q0KRyqYMUe5CWyzlVQqOCyj1gGN6Y06K0GAqfsW99A+hVbeD7q0xvH8C/MtsgyGw2QS1+kXsvcFX7LbqQbkiKYCZmLIM9NCFYrPmiQJ0pSlOiCK4w5hRISFvHhgHCSusxZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39830400003)(396003)(366004)(451199021)(55236004)(26005)(186003)(6506007)(478600001)(15650500001)(41300700001)(6486002)(6916009)(83380400001)(4326008)(5660300002)(66556008)(66476007)(66946007)(316002)(6666004)(8676002)(8936002)(6512007)(36756003)(44832011)(7416002)(38100700002)(86362001)(2906002)(2616005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2gJ7Am6q42gMTZaOYJmOb2EU7oVinE4xSqEFMz9hPfyNCEA8Wy+stWwOv1AO?=
 =?us-ascii?Q?kU/b/7F4BfcDKrIH/cW+KwkDrB/whKi6ViR0RYC9ofRPGRJX9OrB072dlsUy?=
 =?us-ascii?Q?g6qLMcil+5Hd1aigCClcaX/AE0WIIndfV1UTh03WWWKZAu77DKSgJtwM1KNW?=
 =?us-ascii?Q?l3Zb0PQ82syjews+IGnnsBYO/qU9qkAjk97D+IWcYXv7OCzIjorhWH0kY19F?=
 =?us-ascii?Q?DysVRHRhz2dpMkEO5RT9/HS0NjeSGFqtzhXrF0k/fhTAFKZRss7BNYlXREEX?=
 =?us-ascii?Q?RICRisMpyfrYwxFnwr5He8Rp1cN0hdzmxx6grje01D7Rqg29f4I56DW/Vc/C?=
 =?us-ascii?Q?HE/uWnt99hk4uEz29DfgAMcEiqdl5nxB5BWB6z/vZvBnnMc6iBznOYUlLLpg?=
 =?us-ascii?Q?FLPrkOmvrHu8noRAZdVzjU1O8dnXqhob/cg/ShCi+A+8WubPfV9YFRLtzEqi?=
 =?us-ascii?Q?MLESYx+FJuKz4podV2cvRmHVIfemoJQl9Sc5+dhN6cWfUAzebNQjErK4AwP3?=
 =?us-ascii?Q?jNN/ITChm9zlAgOc5qx4cgVm5IHnYYrohLLuX77zmd5eGbfxgbbZKD5B8M3r?=
 =?us-ascii?Q?OzPitBlAmHB9qK3ji1qfkLig8HChOBSgbBpEUWrBL08xSVgxNFh1yFJQGO3Z?=
 =?us-ascii?Q?seC1b6fjh24Qt9CzQplux5+UuNhKMI48OkmngrhMMsV7e3CutjSWpo7SDpOa?=
 =?us-ascii?Q?wxoO1CxUofki+6RCJs49VsN0FiQ6sRkSrJ5F2Ff1n4k9PuHk+hO5Psa7N1FM?=
 =?us-ascii?Q?hfUVRtQTKrup4GRhQHAmmf8H3B9O/jiQ9TY0eZiHc/IIqZRKPoWMIKJ3ZGtr?=
 =?us-ascii?Q?mrk3UGf+F11seAOBEsg/Q8JsLXLnCORIidlaoVuJUXYOFe13vpLhJOYiMP6s?=
 =?us-ascii?Q?H+mualxmv5Lz6JxjtKWyCaku94ANbLNFiySzzp1Vsg4VRloikjyMClL8txvf?=
 =?us-ascii?Q?x933kisENJ82OjQvhk5hHtWooX+FRbAAevx6SngTyvD3h2SVmUEUNoRRs+B/?=
 =?us-ascii?Q?APQ89XRKKgR6hqf3Rk8b6WkcPPovxUfNOO/qoG+Ej3wWxMPtUVyF1mfE+Lkm?=
 =?us-ascii?Q?H/NUiHWtfHgqSCtKF3MNFl+zWXWqbbbEXHe6mTRAXn/zqazqhQ8aaV1J202k?=
 =?us-ascii?Q?D68dF1k1yCAJj9vkVrMIIfRFakhqnTOTKbfMuRDBKNwlQQocLGNyoo9B+zAo?=
 =?us-ascii?Q?qew4gxahJK8107yvaFciNKRH4UU3+IWwHu4iPxjGrNKfiRZPjaQnQeQ+rHls?=
 =?us-ascii?Q?a3ZCP75u82oApSR47TlhEFsy6m+OozmwC/+ln6Y0AVv0ewlDVt9IURJ0laP1?=
 =?us-ascii?Q?NCz27+wxEhznrtY+9VVJ/ooa6w/WFfi47eFuW1DIt6ICawreVXcRL6m6YVHx?=
 =?us-ascii?Q?JLB55t5vRKN+ykfZSGBufBLbZDpxkWAftrTMDjg4TtjOk0/b3u02vpWdogrH?=
 =?us-ascii?Q?UJYYpD3RuatVcCfor9utMYJ3HdaVIFVmwEhJdifxzciP09udA2l8/GG50nrP?=
 =?us-ascii?Q?eOgb68Co3Yy/W2U7Q96LX0JZ6+fpJM2xAFMYk8bKlKbfniH90nxWkzd/iSNg?=
 =?us-ascii?Q?itaECeLkzFb+c0JEYgkDMFdB+D3Y+a9z1yOu6p70RI8Icw2OSHg6mZnueHmz?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b9aa2d-414b-4726-9248-08db88676be2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:49:57.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLjlt/HToaSiVUKt2BzVhDhPneKnF2jBDGf35OEhKJ1G1DjARjTWM6+rJn23QRRVtIUnN3xVqGuIgRrLY4HTWRQWncbAtcYYSXq3xDAZVIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5997
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 01:00:48AM +0530, Suman Ghosh wrote:
> As of today, hash extraction mbox message response supports only the
> secret key which is not a complete solution. This patch fixes that and
> adds support to extract both hash mask and hash control along with the
> secret key. These are needed to use hash reduction of 128 bit IPv6
> address to 32 bit. Hash mask decides on the bits from the 128 bit IPv6
> address which should be used for 32 bit hash calculation. After
> generating the 32 bit hash, hash control decides how many bits from the
> 32 bit hash can be taken into consideration.
> 
> Fixes: a95ab93550d3 ("octeontx2-af: Use hashed field in MCAM key")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  6 ++---
>  .../marvell/octeontx2/af/rvu_npc_hash.c       | 27 ++++++++++---------
>  .../marvell/octeontx2/af/rvu_npc_hash.h       |  9 ++++---
>  3 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index eba307eee2b2..5a5c23a02261 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -246,9 +246,9 @@ M(NPC_MCAM_READ_BASE_RULE, 0x6011, npc_read_base_steer_rule,            \
>  M(NPC_MCAM_GET_STATS, 0x6012, npc_mcam_entry_stats,                     \
>  				   npc_mcam_get_stats_req,              \
>  				   npc_mcam_get_stats_rsp)              \
> -M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,                     \
> -				   npc_get_field_hash_info_req,              \
> -				   npc_get_field_hash_info_rsp)              \
> +M(NPC_GET_FIELD_HASH_INFO, 0x6013, npc_get_field_hash_info,             \
> +				   npc_get_field_hash_info_req,         \
> +				   npc_get_field_hash_info_rsp)         \
>  M(NPC_GET_FIELD_STATUS, 0x6014, npc_get_field_status,                     \
>  				   npc_get_field_status_req,              \
>  				   npc_get_field_status_rsp)              \

This hunk is a white-space only change that doesn't seem
related to the patch description.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> index 6fe67f3a7f6f..a3bc53d22dc0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
> @@ -96,7 +96,7 @@ u32 npc_field_hash_calc(u64 *ldata, struct npc_get_field_hash_info_rsp rsp,
>  	field_hash = rvu_npc_toeplitz_hash(data_padded, hash_key, 128, 159);
>  
>  	field_hash &= FIELD_GET(GENMASK(63, 32), rsp.hash_ctrl[intf][hash_idx]);
> -	field_hash += FIELD_GET(GENMASK(31, 0), rsp.hash_ctrl[intf][hash_idx]);
> +	field_hash |= FIELD_GET(GENMASK(31, 0), rsp.hash_ctrl[intf][hash_idx]);
>  	return field_hash;
>  }
>  
> @@ -253,7 +253,8 @@ void npc_update_field_hash(struct rvu *rvu, u8 intf,
>  	}
>  
>  	req.intf = intf;
> -	rvu_mbox_handler_npc_get_field_hash_info(rvu, &req, &rsp);
> +	if (rvu_mbox_handler_npc_get_field_hash_info(rvu, &req, &rsp))
> +		return;
>  
>  	for (hash_idx = 0; hash_idx < NPC_MAX_HASH; hash_idx++) {
>  		cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_CFG(intf, hash_idx));
> @@ -319,9 +320,9 @@ int rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
>  					     struct npc_get_field_hash_info_req *req,
>  					     struct npc_get_field_hash_info_rsp *rsp)
>  {
> +	int hash_idx, hash_mask_idx, blkaddr;
>  	u64 *secret_key = rsp->secret_key;
>  	u8 intf = req->intf;
> -	int i, j, blkaddr;
>  
>  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
>  	if (blkaddr < 0) {
> @@ -333,18 +334,18 @@ int rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
>  	secret_key[1] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY1(intf));
>  	secret_key[2] = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY2(intf));
>  
> -	for (i = 0; i < NPC_MAX_HASH; i++) {
> -		for (j = 0; j < NPC_MAX_HASH_MASK; j++) {
> -			rsp->hash_mask[NIX_INTF_RX][i][j] =
> -				GET_KEX_LD_HASH_MASK(NIX_INTF_RX, i, j);
> -			rsp->hash_mask[NIX_INTF_TX][i][j] =
> -				GET_KEX_LD_HASH_MASK(NIX_INTF_TX, i, j);
> +	for (hash_idx = 0; hash_idx < NPC_MAX_HASH; hash_idx++)
> +		for (hash_mask_idx = 0; hash_mask_idx < NPC_MAX_HASH_MASK; hash_mask_idx++) {
> +			rsp->hash_mask[NIX_INTF_RX][hash_idx][hash_mask_idx] =
> +				GET_KEX_LD_HASH_MASK(NIX_INTF_RX, hash_idx, hash_mask_idx);
> +			rsp->hash_mask[NIX_INTF_TX][hash_idx][hash_mask_idx] =
> +				GET_KEX_LD_HASH_MASK(NIX_INTF_TX, hash_idx, hash_mask_idx);
>  		}
> -	}
>  
> -	for (i = 0; i < NPC_MAX_INTF; i++)
> -		for (j = 0; j < NPC_MAX_HASH; j++)
> -			rsp->hash_ctrl[i][j] = GET_KEX_LD_HASH_CTRL(i, j);
> +	for (hash_idx = 0; hash_idx < NPC_MAX_INTF; hash_idx++)
> +		for (hash_mask_idx = 0; hash_mask_idx < NPC_MAX_HASH; hash_mask_idx++)
> +			rsp->hash_ctrl[hash_idx][hash_mask_idx] =
> +				GET_KEX_LD_HASH_CTRL(hash_idx, hash_mask_idx);
>  
>  	return 0;
>  }

The three hunks above appear to change the iterator variables for the loops
without changing functionality. This doesn't seem to match the patch
description.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
> index a1c3d987b804..eb9cb311b934 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h
> @@ -12,9 +12,6 @@
>  #define RVU_NPC_HASH_SECRET_KEY1 0xa9d5af4c9fbc87b4
>  #define RVU_NPC_HASH_SECRET_KEY2 0x5954c9e7
>  
> -#define NPC_MAX_HASH 2
> -#define NPC_MAX_HASH_MASK 2
> -

This seems to remove duplicated #defines.
This doesn't seem to match the patch description.

>  #define KEX_LD_CFG_USE_HASH(use_hash, bytesm1, hdr_ofs, ena, flags_ena, key_ofs) \
>  			    ((use_hash) << 20 | ((bytesm1) << 16) | ((hdr_ofs) << 8) | \
>  			     ((ena) << 7) | ((flags_ena) << 6) | ((key_ofs) & 0x3F))
> @@ -41,6 +38,12 @@
>  	rvu_write64(rvu, blkaddr,	\
>  		    NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld), cfg)
>  
> +#define GET_KEX_LD_HASH_CTRL(intf, ld)  \
> +	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_RESULT_CTRL(intf, ld))
> +
> +#define GET_KEX_LD_HASH_MASK(intf, ld, mask_idx)	\
> +	rvu_read64(rvu, blkaddr, NPC_AF_INTFX_HASHX_MASKX(intf, ld, mask_idx))
> +

This seems to duplicate existing MACROS,
which appear a few lines further above in this file.

>  struct npc_mcam_kex_hash {
>  	/* NPC_AF_INTF(0..1)_LID(0..7)_LT(0..15)_LD(0..1)_CFG */
>  	bool lid_lt_ld_hash_en[NPC_MAX_INTF][NPC_MAX_LID][NPC_MAX_LT][NPC_MAX_LD];
> -- 
> 2.25.1
> 
> 
