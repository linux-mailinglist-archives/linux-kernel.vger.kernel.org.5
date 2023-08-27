Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1815E78A02F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjH0QdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjH0QdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8DBFE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 09:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E8062415
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75C7C433C7;
        Sun, 27 Aug 2023 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693153990;
        bh=SKIGxINZphwjOwTRw2aotndWK4/5JrK1CjkNZQ2GaTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSJ1B8VbzWcyyzYjc5p5/dPAqq8nZJ9RifM1OOliQYBjUhQ2w8JMvP+MRjdh6nTAy
         JiGTe6ZQ7WvcBcPKF+qJXl2JJCpF43gGbr398inFRGTK0s3CRaJcvF6KBuMMwh0MTj
         Go7fvnNJCV8ufS4BQRgwnFLQoY4HVqfAJ4LBnjds=
Date:   Sun, 27 Aug 2023 18:33:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Crumrine <ozlinux@hotmail.com>
Cc:     colin.i.king@gmail.com, sumitraartsy@gmail.com,
        u.kleine-koenig@pengutronix.de, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: octeon: clean up octeon ethernet driver
Message-ID: <2023082744-alike-spendable-5b87@gregkh>
References: <PH7PR11MB7643572E8C1231C013762613BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7643572E8C1231C013762613BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 09:02:07AM -0400, Oliver Crumrine wrote:
> Make the octeon ethernet driver better adhere to the kernel
> coding standard
> 
> Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
> ---
>  drivers/staging/octeon/ethernet.c     |  6 +--
>  drivers/staging/octeon/octeon-stubs.h | 53 ++++++++++++++-------------
>  2 files changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> index 9eee28f2940c..8e1f4b987a25 100644
> --- a/drivers/staging/octeon/ethernet.c
> +++ b/drivers/staging/octeon/ethernet.c
> @@ -201,8 +201,8 @@ EXPORT_SYMBOL(cvm_oct_free_work);
>   */
>  static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
>  {
> -	cvmx_pip_port_status_t rx_status;
> -	cvmx_pko_port_status_t tx_status;
> +	struct cvmx_pip_port_status rx_status;
> +	struct cvmx_pko_port_status tx_status;
>  	struct octeon_ethernet *priv = netdev_priv(dev);
>  
>  	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
> @@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
>  
>  	num_interfaces = cvmx_helper_get_number_of_interfaces();
>  	for (interface = 0; interface < num_interfaces; interface++) {
> -		cvmx_helper_interface_mode_t imode =
> +		enum cvmx_helper_interface_mode imode =
>  		    cvmx_helper_interface_get_mode(interface);
>  		int num_ports = cvmx_helper_ports_on_interface(interface);
>  		int port;
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index 3e7b92cd2e35..1e3b32b304dc 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -213,14 +213,14 @@ enum cvmx_fau_op_size {
>  	CVMX_FAU_OP_SIZE_64 = 3
>  };
>  
> -typedef enum {
> +enum cvmx_spi_mode {
>  	CVMX_SPI_MODE_UNKNOWN = 0,
>  	CVMX_SPI_MODE_TX_HALFPLEX = 1,
>  	CVMX_SPI_MODE_RX_HALFPLEX = 2,
>  	CVMX_SPI_MODE_DUPLEX = 3
> -} cvmx_spi_mode_t;
> +};
>  
> -typedef enum {
> +enum cvmx_helper_interface_mode {
>  	CVMX_HELPER_INTERFACE_MODE_DISABLED,
>  	CVMX_HELPER_INTERFACE_MODE_RGMII,
>  	CVMX_HELPER_INTERFACE_MODE_GMII,
> @@ -231,20 +231,20 @@ typedef enum {
>  	CVMX_HELPER_INTERFACE_MODE_PICMG,
>  	CVMX_HELPER_INTERFACE_MODE_NPI,
>  	CVMX_HELPER_INTERFACE_MODE_LOOP,
> -} cvmx_helper_interface_mode_t;
> +};
>  
> -typedef enum {
> +enum cvmx_pow_wait {
>  	CVMX_POW_WAIT = 1,
>  	CVMX_POW_NO_WAIT = 0,
> -} cvmx_pow_wait_t;
> +};
>  
> -typedef enum {
> +enum cvmx_pko_lock {
>  	CVMX_PKO_LOCK_NONE = 0,
>  	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
>  	CVMX_PKO_LOCK_CMD_QUEUE = 2,
> -} cvmx_pko_lock_t;
> +};
>  
> -typedef enum {
> +enum cvmx_pko_status {
>  	CVMX_PKO_SUCCESS,
>  	CVMX_PKO_INVALID_PORT,
>  	CVMX_PKO_INVALID_QUEUE,
> @@ -252,7 +252,7 @@ typedef enum {
>  	CVMX_PKO_NO_MEMORY,
>  	CVMX_PKO_PORT_ALREADY_SETUP,
>  	CVMX_PKO_CMD_QUEUE_INIT_ERROR
> -} cvmx_pko_status_t;
> +};
>  
>  enum cvmx_pow_tag_type {
>  	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
> @@ -384,7 +384,7 @@ union cvmx_ipd_sub_port_qos_cnt {
>  	} s;
>  };
>  
> -typedef struct {
> +struct cvmx_pip_port_status {
>  	uint32_t dropped_octets;
>  	uint32_t dropped_packets;
>  	uint32_t pci_raw_packets;
> @@ -407,13 +407,13 @@ typedef struct {
>  	uint32_t inb_packets;
>  	uint64_t inb_octets;
>  	uint16_t inb_errors;
> -} cvmx_pip_port_status_t;
> +};
>  
> -typedef struct {
> +struct cvmx_pko_port_status {
>  	uint32_t packets;
>  	uint64_t octets;
>  	uint64_t doorbell;
> -} cvmx_pko_port_status_t;
> +};
>  
>  union cvmx_pip_frm_len_chkx {
>  	uint64_t u64;
> @@ -1258,15 +1258,15 @@ static inline int octeon_is_simulation(void)
>  }
>  
>  static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
> -					    cvmx_pip_port_status_t *status)
> +					    struct cvmx_pip_port_status *status)
>  { }
>  
>  static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
> -					    cvmx_pko_port_status_t *status)
> +					    struct cvmx_pko_port_status *status)
>  { }
>  
> -static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
> -								   interface)
> +static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
> +									     interface)
>  {
>  	return 0;
>  }
> @@ -1342,11 +1342,11 @@ static inline unsigned int cvmx_get_core_num(void)
>  }
>  
>  static inline void cvmx_pow_work_request_async_nocheck(int scr_addr,
> -						       cvmx_pow_wait_t wait)
> +						       enum cvmx_pow_wait wait)
>  { }
>  
>  static inline void cvmx_pow_work_request_async(int scr_addr,
> -					       cvmx_pow_wait_t wait)
> +					       enum cvmx_pow_wait wait)
>  { }
>  
>  static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
> @@ -1356,13 +1356,13 @@ static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
>  	return wqe;
>  }
>  
> -static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
> +static inline struct cvmx_wqe *cvmx_pow_work_request_sync(enum cvmx_pow_wait wait)
>  {
>  	return (void *)(unsigned long)wait;
>  }
>  
>  static inline int cvmx_spi_restart_interface(int interface,
> -					cvmx_spi_mode_t mode, int timeout)
> +					     enum cvmx_spi_mode mode, int timeout)
>  {
>  	return 0;
>  }
> @@ -1381,12 +1381,13 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
>  }
>  
>  static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
> -						cvmx_pko_lock_t use_locking)
> +						enum cvmx_pko_lock use_locking)
>  { }
>  
> -static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
> -		uint64_t queue, union cvmx_pko_command_word0 pko_command,
> -		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
> +static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port, uint64_t queue,
> +							       union cvmx_pko_command_word0 pko_command,
> +							       union cvmx_buf_ptr packet,
> +							       enum cvmx_pko_lock use_locking)
>  {
>  	return 0;
>  }
> -- 
> 2.39.3
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
