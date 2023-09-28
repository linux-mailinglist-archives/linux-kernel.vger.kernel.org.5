Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDEC7B1E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjI1NfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjI1NfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:35:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22B11F;
        Thu, 28 Sep 2023 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695908100; x=1727444100;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=2q/ofJbjVnxsiWF4wpyLGs7XzpOCXPm/6xI4ePXLves=;
  b=AapLIZpfhIbLoy2Bxnc3/gaTMXAiw948rsHJtPSPwuyuZO1+AEeUaoaw
   NEJC1PLrRRpU7eX117AmHyxkBaIUXoicCsieo/l/V4rRGLhAIFPuGBUnx
   xB2pc6+8XwLBKtkrWQjm1PIQNMv2flyGAMFwMLmb/SM465ovRE5TIzBMo
   UTH8ktwTDNv66boYuM+x6UEo0OYw3vpMx6JGqXowVoJcCJUHhbiuu5wok
   7NIRP8dQuliZlbdB8RNCgGTSNoy4yL+ecDz33KS2g+ZK/fLI3ERRp+7AN
   eWKgvfu/gmt8+DznE9UmRlJhrRQDgo91U7mE+nqAL+Yt2md7wAgzAv4vb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="381968817"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="381968817"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="923216353"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="923216353"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 28 Sep 2023 06:30:28 -0700
Message-ID: <6e9d2094-0bf9-b2ac-29f3-99115b456fdb@linux.intel.com>
Date:   Thu, 28 Sep 2023 16:31:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-3-quic_wcheng@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v7 02/33] xhci: add helper to stop endpoint and wait for
 completion
In-Reply-To: <20230921214843.18450-3-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.9.2023 0.48, Wesley Cheng wrote:
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> Expose xhci_stop_endpoint_sync() which is a synchronous variant of
> xhci_queue_stop_endpoint().  This is useful for client drivers that are
> using the secondary interrupters, and need to stop/clean up the current
> session.  The stop endpoint command handler will also take care of cleaning
> up the ring.
> 
> Modifications to repurpose the new API into existing stop endpoint
> sequences was implemented by Wesley Cheng.
> 
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Co-developed-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   drivers/usb/host/xhci-hub.c | 29 +++---------------
>   drivers/usb/host/xhci.c     | 60 +++++++++++++++++++++++++++----------
>   drivers/usb/host/xhci.h     |  2 ++
>   3 files changed, 50 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 0054d02239e2..2f7309bdc922 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -489,7 +489,6 @@ EXPORT_SYMBOL_GPL(xhci_find_slot_id_by_port);
>   static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
>   {
>   	struct xhci_virt_device *virt_dev;
> -	struct xhci_command *cmd;
>   	unsigned long flags;
>   	int ret;
>   	int i;
> @@ -501,10 +500,6 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
>   
>   	trace_xhci_stop_device(virt_dev);
>   
> -	cmd = xhci_alloc_command(xhci, true, GFP_NOIO);
> -	if (!cmd)
> -		return -ENOMEM;
> -
>   	spin_lock_irqsave(&xhci->lock, flags);
>   	for (i = LAST_EP_INDEX; i > 0; i--) {
>   		if (virt_dev->eps[i].ring && virt_dev->eps[i].ring->dequeue) {
> @@ -521,7 +516,7 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
>   			if (!command) {
>   				spin_unlock_irqrestore(&xhci->lock, flags);
>   				ret = -ENOMEM;
> -				goto cmd_cleanup;
> +				goto out;
>   			}
>   
>   			ret = xhci_queue_stop_endpoint(xhci, command, slot_id,
> @@ -529,30 +524,14 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
>   			if (ret) {
>   				spin_unlock_irqrestore(&xhci->lock, flags);
>   				xhci_free_command(xhci, command);
> -				goto cmd_cleanup;
> +				goto out;
>   			}
>   		}
>   	}
> -	ret = xhci_queue_stop_endpoint(xhci, cmd, slot_id, 0, suspend);
> -	if (ret) {
> -		spin_unlock_irqrestore(&xhci->lock, flags);
> -		goto cmd_cleanup;
> -	}
> -
> -	xhci_ring_cmd_db(xhci);
>   	spin_unlock_irqrestore(&xhci->lock, flags);
> +	ret = xhci_stop_endpoint_sync(xhci, &virt_dev->eps[0], suspend);

I didn't take this new xhci_stop_endpoint_sync() helper into use as it causes an extra
xhci spinlock release and reacquire here.

Also the memory allocation flags differ, GFP_NOIO is turned into GFP_KERNEL after this change.

>   
> -	/* Wait for last stop endpoint command to finish */
> -	wait_for_completion(cmd->completion);
> -
> -	if (cmd->status == COMP_COMMAND_ABORTED ||
> -	    cmd->status == COMP_COMMAND_RING_STOPPED) {
> -		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
> -		ret = -ETIME;
> -	}
> -
> -cmd_cleanup:
> -	xhci_free_command(xhci, cmd);
> +out:
>   	return ret;
>   }
>   
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 3fd2b58ee1d3..163d533d6200 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -2758,6 +2758,46 @@ static int xhci_reserve_bandwidth(struct xhci_hcd *xhci,
>   	return -ENOMEM;
>   }
>   
> +/*
> + * Synchronous XHCI stop endpoint helper.  Issues the stop endpoint command and
> + * waits for the command completion before returning.
> + */
> +int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep, int suspend)
> +{
> +	struct xhci_command *command;
> +	unsigned long flags;
> +	int ret;
> +
> +	command = xhci_alloc_command(xhci, true, GFP_KERNEL);
> +	if (!command)
> +		return -ENOMEM;
> +
> +	spin_lock_irqsave(&xhci->lock, flags);
> +	ret = xhci_queue_stop_endpoint(xhci, command, ep->vdev->slot_id,
> +				       ep->ep_index, suspend);
> +	if (ret < 0) {
> +		spin_unlock_irqrestore(&xhci->lock, flags);
> +		goto out;
> +	}
> +
> +	xhci_ring_cmd_db(xhci);
> +	spin_unlock_irqrestore(&xhci->lock, flags);
> +
> +	ret = wait_for_completion_timeout(command->completion, msecs_to_jiffies(3000));
> +	if (!ret)
> +		xhci_warn(xhci, "%s: Unable to stop endpoint.\n",
> +				__func__);
> +
> +	if (command->status == COMP_COMMAND_ABORTED ||
> +	    command->status == COMP_COMMAND_RING_STOPPED) {
> +		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
> +		ret = -ETIME;
> +	}
> +out:
> +	xhci_free_command(xhci, command);
> +
> +	return ret;
> +}
>   
>   /* Issue a configure endpoint command or evaluate context command
>    * and wait for it to finish.
> @@ -3078,7 +3118,7 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
>   	struct xhci_virt_device *vdev;
>   	struct xhci_virt_ep *ep;
>   	struct xhci_input_control_ctx *ctrl_ctx;
> -	struct xhci_command *stop_cmd, *cfg_cmd;
> +	struct xhci_command *cfg_cmd;
>   	unsigned int ep_index;
>   	unsigned long flags;
>   	u32 ep_flag;
> @@ -3118,10 +3158,6 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
>   	if (ep_flag == SLOT_FLAG || ep_flag == EP0_FLAG)
>   		return;
>   
> -	stop_cmd = xhci_alloc_command(xhci, true, GFP_NOWAIT);
> -	if (!stop_cmd)
> -		return;
> -
>   	cfg_cmd = xhci_alloc_command_with_ctx(xhci, true, GFP_NOWAIT);
>   	if (!cfg_cmd)
>   		goto cleanup;
> @@ -3144,23 +3180,16 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
>   		goto cleanup;
>   	}
>   
> -	err = xhci_queue_stop_endpoint(xhci, stop_cmd, udev->slot_id,
> -					ep_index, 0);
> +	spin_unlock_irqrestore(&xhci->lock, flags);
> +

Same here, extra unlock -> lock, and GFP flags differ.


> +	err = xhci_stop_endpoint_sync(xhci, ep, 0);

Thanks
Mathias

