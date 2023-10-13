Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2797C8780
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjJMOHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjJMOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:07:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB8BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:07:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F572C433C8;
        Fri, 13 Oct 2023 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697206067;
        bh=w/mdAXQ4DIZNVExM6+HaBdT5TCkbE6ZvzTL0s1NL0EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTT0h/SDDSXoXOqvm4V87CtMdIqrsWe9l3sCV0TdNFc8QE/PG2bfTzBWAqNdmqdLe
         ThjDf2biYkFOMh/2RxiANbMq8dZA6G1ZJbLWr1gVwAHmH3lcqMYYtiK0XD+rO0JtLk
         AkJBkYar4rnpuj5HUV3AAQdZ7IZhjCCVLmSm/udfvd2PND6EjpbjXEgio8fdDTDB5w
         39E0e6AX+hL+YeDreXFmuthXHOLR9xWHy97lDeUGgYXULbYmjJl+1ixmNfmF9mUKvI
         9dmQ1zDw9kf4AMMcL+f5rDhJtfgM7MwdG3G8PM9XCH5itqRvH35tSdLNkifxHgRLQr
         NX1eMCoe4mqyQ==
Date:   Fri, 13 Oct 2023 08:07:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: update firmware version after commit
Message-ID: <ZSlPMcLHZywXGhdR@kbusch-mbp>
References: <20231013062623.6745-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013062623.6745-1-dwagner@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 08:26:23AM +0200, Daniel Wagner wrote:
> +static void nvme_update_firmware_rev(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_id_ctrl *id;
> +	int ret;
> +
> +	ret = nvme_identify_ctrl(ctrl, &id);
> +	if (ret) {
> +		dev_warn(ctrl->device, "Identify Controller failed (%d)\n", ret);
> +		return;
> +	}
> +	memcpy(ctrl->subsys->firmware_rev, id->fr,
> +	       sizeof(ctrl->subsys->firmware_rev));
> +}
> +
>  static void nvme_fw_act_work(struct work_struct *work)
>  {
>  	struct nvme_ctrl *ctrl = container_of(work,
> @@ -4109,6 +4123,7 @@ static void nvme_fw_act_work(struct work_struct *work)
>  	nvme_unquiesce_io_queues(ctrl);
>  	/* read FW slot information to clear the AER */
>  	nvme_get_fw_slot_info(ctrl);
> +	nvme_update_firmware_rev(ctrl);

The "fw_slot_info()" call also gets the firmware version, so no need to
do it a different way. Just add the memcpy to that function instead of
introducing a new one.
