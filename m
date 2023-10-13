Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CEF7C8B97
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjJMQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjJMQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:43:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972A95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:43:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF32C433C8;
        Fri, 13 Oct 2023 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697215431;
        bh=fNhicONj1ekrnfRc2uQFmE8uC7unApfdctES3UAtqYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbTDyQbr7+0/56UsczyfBJ8nS3mFVQfES2Fe83+LMZe5j1B5lOx2W038HcUClejtm
         OgErDdh+Zh+hBfoRY9TWRdiVjemnIixGyvLKiL1MiEO6+Ry9NA7GeGe0iMpx4OwOPy
         G1camTGX7s3RX/+fQ/0S6dT36Bi0BWm2ljexKCnkVZskzMx6OumyGtHVl0dD2Kd3MX
         eswvh/CcBP6KhRFj2ee72GMUZNL+W9SAZ27nPgM/23pnZR1jKXTVar2itkaoYlflhv
         MehZM8WTZPCeJNiRZvUFGVIKmrpmt6FsA6+Cb1dvvLgcSW3Gz5e8duc1s6/vtu7zX4
         evd7rsRxp77DQ==
Date:   Fri, 13 Oct 2023 10:43:48 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Message-ID: <ZSlzxGx8k9pgkhDk@kbusch-mbp>
References: <20231013163420.3097-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013163420.3097-1-dwagner@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 06:34:20PM +0200, Daniel Wagner wrote:
>  	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
> -			log, sizeof(*log), 0))
> +			 log, sizeof(*log), 0)) {
>  		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
> +		goto out_free_log;
> +	}
> +
> +	afi = le64_to_cpu(log->afi);
> +	if (afi & 0x30) {

That should be 'afi & 0x70'.

> +		dev_info(ctrl->device,
> +			 "Firmware is activated after next Controller Level Reset\n");
> +		goto out_free_log;
> +	}
> +
> +	memcpy(ctrl->subsys->firmware_rev, &log->frs[afi & 0x3],

and 'afi & 0x7'.
