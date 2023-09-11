Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD60E79B360
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbjIKVV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbjIKMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:49:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A70CEB;
        Mon, 11 Sep 2023 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694436591; x=1725972591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RbPcSFPHs/Ylahk1ZJintbe/kjOnFWdoOtyNfLzf+VA=;
  b=mdvYbuqNGCpfG7rIfUM/nrM4PjuSwW2QKz9Wb1CZsLkbm1LJCuZTM4EV
   7Hv7tzEzzB4xK+voPtzJ/xy3Cce4QH4MXfW8QlH6fh4CNRhE6ufAXlrrb
   JXqd5R0kT5LCBOHE3vIhTl2xQcSyPicvlN/jW9TRLDUW7De6uIh/tr1R8
   gk6SQv8AMLm8eda25ID91Ii1vrc3LVKS6ValpT9R2lYsOEBCEdyax5RIt
   dNuxUncGNLIiWDEQEFoyOoUoiYVhmTBLjPVHc1PXqhr6HXXvWJ4WQdfIb
   inVCsnS3D/FOj6GdRh8+j5YOcb/mqxm0W8D6JwSm7ua2pQk288YcqcHCV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="380771099"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="380771099"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833491262"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="833491262"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by FMSMGA003.fm.intel.com with SMTP; 11 Sep 2023 05:49:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 Sep 2023 15:49:47 +0300
Date:   Mon, 11 Sep 2023 15:49:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "# 5 . 16" <stable@vger.kernel.org>
Subject: Re: usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command
 fails
Message-ID: <ZP8M6zqgsLTK25PI@kuha.fi.intel.com>
References: <1694423055-8440-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694423055-8440-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 02:34:15PM +0530, Prashanth K wrote:
> Currently if ucsi_send_command() fails, then we bail out without
> clearing EVENT_PENDING flag. So when the next connector change
> event comes, ucsi_connector_change() won't queue the con->work,
> because of which none of the new events will be processed.
> 
> Fix this by clearing EVENT_PENDING flag if ucsi_send_command()
> fails.
> 
> Cc: <stable@vger.kernel.org> # 5.16
> Fixes: 512df95b9432 ("usb: typec: ucsi: Better fix for missing unplug events issue")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index c6dfe3d..509c67c 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -884,6 +884,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  	if (ret < 0) {
>  		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
>  			__func__, ret);
> +		clear_bit(EVENT_PENDING, &con->ucsi->flags);
>  		goto out_unlock;
>  	}

I think it would be better to just move that label (out_unlock) above
the point where clear_bit() is already called instead of separately
calling it like that. That way the Connector Change Event will
also get acknowledged.

If this really can happen, then I think it would be good to also
schedule a task for ucsi_check_connection():

        if (ret < 0) {
                dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
                        __func__, ret);
+               ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
                goto out_unlock;
        }

thanks,

-- 
heikki
