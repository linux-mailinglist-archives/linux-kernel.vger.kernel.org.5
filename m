Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00407A1EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjIOMcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjIOMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:32:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7121A5;
        Fri, 15 Sep 2023 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694781136; x=1726317136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xhzmIM0A6FvMonQOUj08NuTR8MxP5gbC35qu4BkzgQU=;
  b=hvhXrms8WOU4AwB8pu+wENpl2CmBTiEb2ubzan2wYhsy8e7scvSunAaH
   rdIeEaNfyXKE+nM3hddpSD4ROtJnvmElnwUExpLoLtoPLY0QFet3YJkz0
   72yy/CrBxmOHbBghLYzgCMcGgWwIY6nS4ZqlNxpkHjgopPMWcUwPeDPYk
   lKoQwyYoYyCHJaDpaJWZJt21Vkb8nFBujyhGCvbShNV3ynhD9ztaJ8eJM
   zuPcWuoBVm8Rlat+00+5nFRrWJ6Dg/QJvbseZH3odKMVkVBT9LNiQBrAl
   p89h1tFFSn0cqtVsMDWJgrne/siU5Q8szGXWPlIXzsAT+Z+hJHxbSpamC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="358651885"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="358651885"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 05:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="774301594"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="774301594"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga008.jf.intel.com with SMTP; 15 Sep 2023 05:32:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 Sep 2023 15:32:12 +0300
Date:   Fri, 15 Sep 2023 15:32:12 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "# 5 . 16" <stable@vger.kernel.org>
Subject: Re: usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command
 fails
Message-ID: <ZQROzNqr7fbmJC87@kuha.fi.intel.com>
References: <1694423055-8440-1-git-send-email-quic_prashk@quicinc.com>
 <ZP8M6zqgsLTK25PI@kuha.fi.intel.com>
 <21d247d3-83be-ba53-c982-2ab0e2e4ffb3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d247d3-83be-ba53-c982-2ab0e2e4ffb3@quicinc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 04:37:47PM +0530, Prashanth K wrote:
> 
> 
> On 11-09-23 06:19 pm, Heikki Krogerus wrote:
> > On Mon, Sep 11, 2023 at 02:34:15PM +0530, Prashanth K wrote:
> > > Currently if ucsi_send_command() fails, then we bail out without
> > > clearing EVENT_PENDING flag. So when the next connector change
> > > event comes, ucsi_connector_change() won't queue the con->work,
> > > because of which none of the new events will be processed.
> > > 
> > > Fix this by clearing EVENT_PENDING flag if ucsi_send_command()
> > > fails.
> > > 
> > > Cc: <stable@vger.kernel.org> # 5.16
> > > Fixes: 512df95b9432 ("usb: typec: ucsi: Better fix for missing unplug events issue")
> > > Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> > > ---
> > >   drivers/usb/typec/ucsi/ucsi.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > index c6dfe3d..509c67c 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -884,6 +884,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
> > >   	if (ret < 0) {
> > >   		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
> > >   			__func__, ret);
> > > +		clear_bit(EVENT_PENDING, &con->ucsi->flags);
> > >   		goto out_unlock;
> > >   	}
> > 
> > I think it would be better to just move that label (out_unlock) above
> > the point where clear_bit() is already called instead of separately
> > calling it like that. That way the Connector Change Event will
> > also get acknowledged.
> Do we really need to ACK in this case since we didn't process the current
> connector change event

You won't get the next event before the first one was ACK'd, right?

> > 
> > If this really can happen, then I think it would be good to also
> > schedule a task for ucsi_check_connection():
> > 
> >          if (ret < 0) {
> >                  dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
> >                          __func__, ret);
> > +               ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
> >                  goto out_unlock;
> >          }
> > 
> > thanks,
> > 
> Retrying is a good idea, but ucsi_check_connection() doesn't have the full
> functionality compared to handle_connector_change. I guess
> ucsi_check_connection() will send a set_role, but won't handle the
> connector_change scenarios happening due to PR/DR swap, which will lead to
> deadlocks (due to wait_for_completion). This is just an example. So its
> better to bail out and process the next events, because the failure here is
> from the glink layer.

Fair enough.

-- 
heikki
