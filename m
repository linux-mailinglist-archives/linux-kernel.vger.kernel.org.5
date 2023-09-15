Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020567A204D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjION6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjION6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:58:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E411FCC;
        Fri, 15 Sep 2023 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694786279; x=1726322279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=51q7+p6dAkVEPA2ULlkDzpUZ/83tyHXQyFDeaZwHaSE=;
  b=Ktz7RrvsbrYDxigFOw5mW5bF6Nc4e/6ZkVqYc6ci6yEATFqzg/9ysQPA
   bTsUprueaJdkTJBcKBRmt0jOssKqrlNzT++F43RCGsAtG6XEd3gVxEMTl
   wBkDyYgaQCmvxtme321CAqF5kCY6th88mmmYvzbaxpDH3LmVhvPwkGu1T
   gkpJP7/lIo7XkJ3YJHSg0nlREzKovmrg6d+yggx6q68Dt6MHmoFoFO1Y5
   HXjFJZG2DvpTA5Bag4aPNX1pZSaDbuJEGAkk/CBg37iu91nyPBqmakDlQ
   khmK+Fy/3yEH1U9fZv3mBu8OGSZfa0Npr0pp71TKLu38Y3Hq1QwzMgLkk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="378165579"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="378165579"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 06:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="738332618"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="738332618"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga007.jf.intel.com with SMTP; 15 Sep 2023 06:57:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 Sep 2023 16:57:47 +0300
Date:   Fri, 15 Sep 2023 16:57:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "# 5 . 16" <stable@vger.kernel.org>
Subject: Re: usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command
 fails
Message-ID: <ZQRi20nC0j5c4LGI@kuha.fi.intel.com>
References: <1694423055-8440-1-git-send-email-quic_prashk@quicinc.com>
 <ZP8M6zqgsLTK25PI@kuha.fi.intel.com>
 <21d247d3-83be-ba53-c982-2ab0e2e4ffb3@quicinc.com>
 <ZQROzNqr7fbmJC87@kuha.fi.intel.com>
 <4e876097-aed1-2b0d-ecb4-6434add4ef26@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e876097-aed1-2b0d-ecb4-6434add4ef26@quicinc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashanth,

On Fri, Sep 15, 2023 at 07:10:25PM +0530, Prashanth K wrote:
> On 15-09-23 06:02 pm, Heikki Krogerus wrote:
> > On Tue, Sep 12, 2023 at 04:37:47PM +0530, Prashanth K wrote:
> > > 
> > > 
> > > On 11-09-23 06:19 pm, Heikki Krogerus wrote:
> > > > On Mon, Sep 11, 2023 at 02:34:15PM +0530, Prashanth K wrote:
> > > > > Currently if ucsi_send_command() fails, then we bail out without
> > > > > clearing EVENT_PENDING flag. So when the next connector change
> > > > > event comes, ucsi_connector_change() won't queue the con->work,
> > > > > because of which none of the new events will be processed.
> > > > > 
> > > > > Fix this by clearing EVENT_PENDING flag if ucsi_send_command()
> > > > > fails.
> > > > > 
> > > > > Cc: <stable@vger.kernel.org> # 5.16
> > > > > Fixes: 512df95b9432 ("usb: typec: ucsi: Better fix for missing unplug events issue")
> > > > > Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> > > > > ---
> > > > >    drivers/usb/typec/ucsi/ucsi.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > > > index c6dfe3d..509c67c 100644
> > > > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > > > @@ -884,6 +884,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
> > > > >    	if (ret < 0) {
> > > > >    		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
> > > > >    			__func__, ret);
> > > > > +		clear_bit(EVENT_PENDING, &con->ucsi->flags);
> > > > >    		goto out_unlock;
> > > > >    	}
> > > > 
> > > > I think it would be better to just move that label (out_unlock) above
> > > > the point where clear_bit() is already called instead of separately
> > > > calling it like that. That way the Connector Change Event will
> > > > also get acknowledged.
> > > Do we really need to ACK in this case since we didn't process the current
> > > connector change event
> > 
> > You won't get the next event before the first one was ACK'd, right?
> > 
> 
> The spec says that we need to ACK if we received AND processed a CCI
> 
> "4.5.4 Acknowledge Command Completion and/or Change Indication (R)
> This command is used to acknowledge to the PPM that the OPM received and
> processed a Command Completion and/or a Connector Change Indication."
> 
> And here in this case, we have received, but not processed the event.
> So I'm not really sure what to do here in this case. If we don't send an
> ACK, then would the PPM think that OPM is not responding and reset it?
> OR would it resend the previous event again since we didn't ACK?

Every PPM behaves differently.

Did you actually see that happening - GET_CONNECTOR_STATUS failed? Can
you reproduce it?

thanks,

-- 
heikki
