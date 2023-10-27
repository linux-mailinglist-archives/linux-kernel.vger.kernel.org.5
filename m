Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC39F7D8CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbjJ0BaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0BaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:30:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879AD1B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 18:30:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0828C433C8;
        Fri, 27 Oct 2023 01:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698370211;
        bh=YOWD4N121xIJhA9vwpTTpOpv0xx0mse7znzmlAJoBog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wj4A3uMGS3yFDPXYQ8aIxkhnakLmR0yyl6SHkfJlU+TNpqqH8xLB6Ub9zwuAZQsFg
         zkVYmO/TxqN8r2sYYe7tSJalSIE3/9g2PrUaKvMKX7mNw5PPew2rr6orVBaDLFXrla
         kG91GUJVBpf+wpGxcDl6LPa5N3xDbX3uj+T8ayKYzQMCF566Q8CdkStqx0Q7CXYx0B
         iKjue9Azn2JUy0EUdUGiSujP8TgxFkOzbgoOoRXWi10N//0f8v2zQQoi68NIXVdVPX
         /vPXm3/mj7Imz9k4Q2DQ5eHlWmYyPdpYMOXy6wnhF1LyqpduzPU9pZUGdx5SGI6P5x
         sPdI21GPo96FQ==
Date:   Fri, 27 Oct 2023 09:30:01 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
Message-ID: <20231027013001.GA1669606@nchen-desktop>
References: <20231026073737.165450-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026073737.165450-1-pawell@cadence.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-26 09:37:37, Pawel Laszczak wrote:
> Patch removes TRB_FLUSH_ENDPOINT command from driver.
> This command is not supported by controller and
> USBSSP returns TRB Error completion code for it.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdnsp-debug.h  |  3 ---
>  drivers/usb/cdns3/cdnsp-gadget.c |  6 +-----
>  drivers/usb/cdns3/cdnsp-gadget.h |  5 -----
>  drivers/usb/cdns3/cdnsp-ring.c   | 24 ------------------------
>  4 files changed, 1 insertion(+), 37 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
> index f0ca865cce2a..ad617b7455b9 100644
> --- a/drivers/usb/cdns3/cdnsp-debug.h
> +++ b/drivers/usb/cdns3/cdnsp-debug.h
> @@ -131,8 +131,6 @@ static inline const char *cdnsp_trb_type_string(u8 type)
>  		return "Endpoint Not ready";
>  	case TRB_HALT_ENDPOINT:
>  		return "Halt Endpoint";
> -	case TRB_FLUSH_ENDPOINT:
> -		return "FLush Endpoint";
>  	default:
>  		return "UNKNOWN";
>  	}
> @@ -328,7 +326,6 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
>  		break;
>  	case TRB_RESET_EP:
>  	case TRB_HALT_ENDPOINT:
> -	case TRB_FLUSH_ENDPOINT:
>  		ret = snprintf(str, size,
>  			       "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
>  			       cdnsp_trb_type_string(type),
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 4b67749edb99..4a3f0f958256 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1024,10 +1024,8 @@ static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
>  	pep->ep_state |= EP_DIS_IN_RROGRESS;
>  
>  	/* Endpoint was unconfigured by Reset Device command. */
> -	if (!(pep->ep_state & EP_UNCONFIGURED)) {
> +	if (!(pep->ep_state & EP_UNCONFIGURED))
>  		cdnsp_cmd_stop_ep(pdev, pep);
> -		cdnsp_cmd_flush_ep(pdev, pep);
> -	}
>  
>  	/* Remove all queued USB requests. */
>  	while (!list_empty(&pep->pending_list)) {
> @@ -1424,8 +1422,6 @@ static void cdnsp_stop(struct cdnsp_device *pdev)
>  {
>  	u32 temp;
>  
> -	cdnsp_cmd_flush_ep(pdev, &pdev->eps[0]);
> -
>  	/* Remove internally queued request for ep0. */
>  	if (!list_empty(&pdev->eps[0].pending_list)) {
>  		struct cdnsp_request *req;
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index e1b5801fdddf..dbee6f085277 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -1128,8 +1128,6 @@ union cdnsp_trb {
>  #define TRB_HALT_ENDPOINT	54
>  /* Doorbell Overflow Event. */
>  #define TRB_DRB_OVERFLOW	57
> -/* Flush Endpoint Command. */
> -#define TRB_FLUSH_ENDPOINT	58
>  
>  #define TRB_TYPE_LINK(x)	(((x) & TRB_TYPE_BITMASK) == TRB_TYPE(TRB_LINK))
>  #define TRB_TYPE_LINK_LE32(x)	(((x) & cpu_to_le32(TRB_TYPE_BITMASK)) == \
> @@ -1539,8 +1537,6 @@ void cdnsp_queue_configure_endpoint(struct cdnsp_device *pdev,
>  void cdnsp_queue_reset_ep(struct cdnsp_device *pdev, unsigned int ep_index);
>  void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev,
>  			       unsigned int ep_index);
> -void cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
> -				unsigned int ep_index);
>  void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num);
>  void cdnsp_queue_reset_device(struct cdnsp_device *pdev);
>  void cdnsp_queue_new_dequeue_state(struct cdnsp_device *pdev,
> @@ -1574,7 +1570,6 @@ void cdnsp_irq_reset(struct cdnsp_device *pdev);
>  int cdnsp_halt_endpoint(struct cdnsp_device *pdev,
>  			struct cdnsp_ep *pep, int value);
>  int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
> -int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
>  void cdnsp_setup_analyze(struct cdnsp_device *pdev);
>  int cdnsp_status_stage(struct cdnsp_device *pdev);
>  int cdnsp_reset_device(struct cdnsp_device *pdev);
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index 07f6068342d4..af981778382d 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -2123,19 +2123,6 @@ int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
>  	return ret;
>  }
>  
> -int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> -{
> -	int ret;
> -
> -	cdnsp_queue_flush_endpoint(pdev, pep->idx);
> -	cdnsp_ring_cmd_db(pdev);
> -	ret = cdnsp_wait_for_cmd_compl(pdev);
> -
> -	trace_cdnsp_handle_cmd_flush_ep(pep->out_ctx);
> -
> -	return ret;
> -}
> -
>  /*
>   * The transfer burst count field of the isochronous TRB defines the number of
>   * bursts that are required to move all packets in this TD. Only SuperSpeed
> @@ -2465,17 +2452,6 @@ void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev, unsigned int ep_index)
>  			    EP_ID_FOR_TRB(ep_index));
>  }
>  
> -/*
> - * Queue a flush endpoint request on the command ring.
> - */
> -void  cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
> -				 unsigned int ep_index)
> -{
> -	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_FLUSH_ENDPOINT) |
> -			    SLOT_ID_FOR_TRB(pdev->slot_id) |
> -			    EP_ID_FOR_TRB(ep_index));
> -}
> -
>  void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
>  {
>  	u32 lo, mid;
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen
