Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81987A5F41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjISKPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:14:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4B013A;
        Tue, 19 Sep 2023 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695118492; x=1726654492;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aFy4gttMLp+ZVD7LS7GAnQ4aq6k3jPbVH88NEZMjFK0=;
  b=L+OFlSnK6qh48aEtdB1xBbcXFF/1ewhQ5UdOGer84T8EAnzucU50YNRt
   Y8+9PYm4LZ1XHSazjTpIC5FLeRqQKGP6MjDYyp8K3FpIv52t/jX4XYUq4
   riaZSu+VlClQs/BBCl4l/WoimQ2RpeTjPICq34crLMc+JKhEJ6fP2AN8+
   Ay8fx2WnCvmOesbBqFSfRWSkwMiP7gC4+t3L4PIpPFRmbMgfNv2UPLxT0
   gjA+57tVMebsfdmllzbXTAYQhQWFkR/gPb5oEBmJinwq1T/0U7/lTHVq6
   qFs7mMSmgNTD8XbeowyR89tP7JpdTcfBj0QFuEV4SmmnSclecV477FBdf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359301635"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="359301635"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="869926779"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="869926779"
Received: from laichele-mobl1.ger.corp.intel.com ([10.252.38.7])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:14:50 -0700
Date:   Tue, 19 Sep 2023 13:14:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] tty: don't check for signal_pending() in
 send_break()
In-Reply-To: <20230919085156.1578-15-jirislaby@kernel.org>
Message-ID: <7746d25a-bcbc-fece-eaa3-2dbea9c0f93e@linux.intel.com>
References: <20230919085156.1578-1-jirislaby@kernel.org> <20230919085156.1578-15-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023, Jiri Slaby (SUSE) wrote:

> msleep_interruptible() will check on its own. So no need to do the check

For clarity:

... will check !signal_pending() on its own.

> in send_break() before calling the above.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/tty_io.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 87bb5094e0bb..24833b31b81c 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2484,8 +2484,7 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
>  	retval = tty->ops->break_ctl(tty, -1);
>  	if (retval)
>  		goto out;
> -	if (!signal_pending(current))
> -		msleep_interruptible(duration);
> +	msleep_interruptible(duration);
>  	retval = tty->ops->break_ctl(tty, 0);
>  out:
>  	tty_write_unlock(tty);
> 

-- 
 i.

