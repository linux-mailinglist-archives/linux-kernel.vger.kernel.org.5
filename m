Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026917FB64D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbjK1Jv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbjK1JvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:51:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E3109;
        Tue, 28 Nov 2023 01:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701165092; x=1732701092;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zLsHcMhIvU8wVZf2s893M6aCyB1ZsP/PLYWAFq1Nklw=;
  b=LMZaj79YFjFu6oWLZEIz+7QgLcqVC1Yh5V+BKXiskdtIhSHh3VfkiZzN
   uld+UOCetUUMJsmrqAuAUag7uGh8pEdu+8ssi4H7dMy6FR8fItNNKNkqz
   gXfDshxs3Rty6xGafE9IiAE1kYFgynmnWz/+OX+Lgcfs9KdRTiv24q4f6
   iy1jsw8FvVimiPMtSA0FMWnS0aElQEqt3Iwo8DOQU0orROpYWkPbxbusG
   ooXViUvXP6LpgQ3kDBJSo2Dcdan69eS6QynpWUEeAQHW1qOYxSRKaXA06
   XiRGiYU5cID8It9pXmHGWehIM0b32DNgaB/6PZKmPvRscIXLNB30zJOh5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="373059739"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="373059739"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:51:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1015861139"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="1015861139"
Received: from haslam-mobl1.ger.corp.intel.com ([10.252.43.79])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:51:19 -0800
Date:   Tue, 28 Nov 2023 11:51:16 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kunwu Chan <chentao@kylinos.cn>
cc:     Hans de Goede <hdegoede@redhat.com>, vadimp@nvidia.com,
        jiri@resnulli.us, shravankr@nvidia.com, kunwu.chan@hotmail.com,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/mellanox: Add a null pointer check in
 mlxbf_pmc_create_groups
In-Reply-To: <20231127063433.1549064-1-chentao@kylinos.cn>
Message-ID: <5aa96a9-336a-d865-d6b9-3857ebe89db@linux.intel.com>
References: <20231127063433.1549064-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023, Kunwu Chan wrote:

> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 0b427fc24a96..59bbe5e13f6b 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -1882,6 +1882,8 @@ static int mlxbf_pmc_create_groups(struct device *dev, int blk_num)
>  	pmc->block[blk_num].block_attr_grp.attrs = pmc->block[blk_num].block_attr;
>  	pmc->block[blk_num].block_attr_grp.name = devm_kasprintf(
>  		dev, GFP_KERNEL, pmc->block_name[blk_num]);
> +	if (!pmc->block[blk_num].block_attr_grp.name)
> +		return -ENOMEM;
>  	pmc->groups[pmc->group_num] = &pmc->block[blk_num].block_attr_grp;
>  	pmc->group_num++;

I'm totally lost, why did you fix only one devm_kasprintf() location?
Don't all of them need this check?

-- 
 i.

