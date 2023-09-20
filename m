Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402FF7A8642
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjITOMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjITOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:11:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 388BED9;
        Wed, 20 Sep 2023 07:11:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EBD11FB;
        Wed, 20 Sep 2023 07:12:28 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994813F5A1;
        Wed, 20 Sep 2023 07:11:49 -0700 (PDT)
Date:   Wed, 20 Sep 2023 15:11:47 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     rafael@kernel.org, rafael.j.wysocki@intel.com,
        xuwei5@hisilicon.com, Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        liuyonglong@huawei.com
Subject: Re: [PATCH v2 2/2] soc: kunpeng_hccs: add the check for PCC subspace
 type
Message-ID: <20230920141147.bq7cjiqjk6c36t6d@bogus>
References: <20230914115753.9064-1-lihuisong@huawei.com>
 <20230920064703.23543-1-lihuisong@huawei.com>
 <20230920064703.23543-3-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920064703.23543-3-lihuisong@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:47:03PM +0800, Huisong Li wrote:
> Currently, HCCS driver directly uses Generic Communications Channel Shared
> Memory Region which is used in type0/1/2 to communicate with platform,
> but actually doesn't support type3/4/5.
> So this patch adds the check for PCC subspace type.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index f3810d9d1caa..4ba3bfd45a01 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -174,6 +174,19 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>  	return rc;
>  }
>  
> +static int hccs_check_pcc_info(struct hccs_dev *hdev)
> +{
> +	struct pcc_mbox_chan *pcc_chan = hdev->cl_info.pcc_chan;
> +
> +	if (pcc_chan->type >= ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE) {
> +		dev_err(hdev->dev, "unsupport for subspace type%u.\n",
> +			pcc_chan->type);
> +		return -EOPNOTSUPP;
> +	}
 
Is this the only use of the PCC type information you have or do you plan to
use it for something other than the validation.

Just for sake of argument, I can say all users of PCC must then do the
similar validation. I don't know where to draw the line here.

Ideally I would expect the driver to make this transparent and give error
during transmit if not supported.

The driver must be able to work with different PCC type to support variety
of platforms TBH. What is the issue exactly here ? Is this to prevent the
use of Type 4 ? I think we must do something better but I don't know what
that is yet.

-- 
Regards,
Sudeep
