Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941E87A2181
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjIOOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjIOOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:51:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB241FD2;
        Fri, 15 Sep 2023 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694789474; x=1726325474;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZhU/YBjNOOPe5s3iZG0OgiJEfBTYLPIc8dia6attIks=;
  b=Oj8SeQ1p3D5QjbJv8HZ9bS0r7JYrbfemlfQxR9njDaqUMVI/aK4J+rvv
   4ag/mTD9wvpD1Go8owcaiXuB4vFtH2p1DdPJCVW4ZuUQDwBDoeJ9BE7RA
   D0ZHU9Iyk0KLwNR7siHXM0dptncWKm171lNhkXUlNGPXDCcKn71p4RYAm
   IcXn5I/N64ud+Om1YvtQAp3Ohl9Sbd6vBkEgIxDG1CsxHL0aYcJjwJHHk
   WuQFO5L5BsQ1xEA7Duknd5ba9wBml/oNtQWYimYYP5j7aQp7dloUQ2UmO
   bI6j+SwTkk+V5ofe1QDHOcigleSaU1/qxVmbYFusve09SOlORr8XBrspV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="443326475"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="443326475"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="860181871"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="860181871"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:49:55 -0700
Date:   Fri, 15 Sep 2023 17:49:53 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v4 4/4] platform/x86: intel_scu_ipc: Fail IPC send if
 still busy
In-Reply-To: <20230913212723.3055315-5-swboyd@chromium.org>
Message-ID: <3e17994a-9481-acc5-dfac-3878929b7038@linux.intel.com>
References: <20230913212723.3055315-1-swboyd@chromium.org> <20230913212723.3055315-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-496999276-1694789398=:2347"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-496999276-1694789398=:2347
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 13 Sep 2023, Stephen Boyd wrote:

> It's possible for interrupts to get significantly delayed to the point
> that callers of intel_scu_ipc_dev_command() and friends can call the
> function once, hit a timeout, and call it again while the interrupt
> still hasn't been processed. This driver will get seriously confused if
> the interrupt is finally processed after the second IPC has been sent
> with ipc_command(). It won't know which IPC has been completed. This
> could be quite disastrous if calling code assumes something has happened
> upon return from intel_scu_ipc_dev_simple_command() when it actually
> hasn't.
> 
> Let's avoid this scenario by simply returning -EBUSY in this case.
> Hopefully higher layers will know to back off or fail gracefully when
> this happens. It's all highly unlikely anyway, but it's better to be
> correct here as we have no way to know which IPC the status register is
> telling us about if we send a second IPC while the previous IPC is still
> processing.
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Fixes: ed12f295bfd5 ("ipc: Added support for IPC interrupt mode")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> ---
>  drivers/platform/x86/intel_scu_ipc.c | 40 +++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 3271f81a9c00..a68df4133403 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -265,6 +265,24 @@ static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
>  	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
>  }
>  
> +static struct intel_scu_ipc_dev *intel_scu_ipc_get(struct intel_scu_ipc_dev *scu)
> +{
> +	u8 status;
> +
> +	if (!scu)
> +		scu = ipcdev;
> +	if (!scu)
> +		return ERR_PTR(-ENODEV);
> +
> +	status = ipc_read_status(scu);
> +	if (status & IPC_STATUS_BUSY) {
> +		dev_dbg(&scu->dev, "device is busy\n");
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	return scu;
> +}
> +
>  /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
>  static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
>  			u32 count, u32 op, u32 id)
> @@ -278,11 +296,10 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
>  	memset(cbuf, 0, sizeof(cbuf));
>  
>  	mutex_lock(&ipclock);
> -	if (!scu)
> -		scu = ipcdev;
> -	if (!scu) {
> +	scu = intel_scu_ipc_get(scu);
> +	if (IS_ERR(scu)) {
>  		mutex_unlock(&ipclock);
> -		return -ENODEV;
> +		return PTR_ERR(scu);
>  	}
>  
>  	for (nc = 0; nc < count; nc++, offset += 2) {
> @@ -437,12 +454,12 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
>  	int err;
>  
>  	mutex_lock(&ipclock);
> -	if (!scu)
> -		scu = ipcdev;
> -	if (!scu) {
> +	scu = intel_scu_ipc_get(scu);
> +	if (IS_ERR(scu)) {
>  		mutex_unlock(&ipclock);
> -		return -ENODEV;
> +		return PTR_ERR(scu);
>  	}
> +
>  	cmdval = sub << 12 | cmd;
>  	ipc_command(scu, cmdval);
>  	err = intel_scu_ipc_check_status(scu);
> @@ -482,11 +499,10 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
>  		return -EINVAL;
>  
>  	mutex_lock(&ipclock);
> -	if (!scu)
> -		scu = ipcdev;
> -	if (!scu) {
> +	scu = intel_scu_ipc_get(scu);
> +	if (IS_ERR(scu)) {
>  		mutex_unlock(&ipclock);
> -		return -ENODEV;
> +		return PTR_ERR(scu);
>  	}
>  
>  	memcpy(inbuf, in, inlen);
> 
--8323329-496999276-1694789398=:2347--
