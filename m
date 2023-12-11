Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F380C6CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjLKKhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjLKKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:37:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8DAD0;
        Mon, 11 Dec 2023 02:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702291027; x=1733827027;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hHtobIbjGrWsDPGAnvtGAAfDp/QQJRNIOz1kL4DmbOw=;
  b=drtvES98zKyIrJDvCiLB6UlCFVH8mEkYoL9ZzlrJrt7bQw1+lAJKHA45
   KeYGmiKAsxf/xIlNY/53f2DdkOK4+w6meoJ/sYCpug/cGTx4ItvbmuoK7
   u+fqE+pf4AbpQAMoKdO/x7P0SH7EAhOK2DTgl7PDxaOQjDytiHlzcy+c9
   v3OSnzybX6ra2FVNNxw6JvMmZRv3fRW3PHJjReh4r6Nk1C9GItByaFbNB
   Xqc/i8dbCcDRQTIv0e5yeTByQL66krf1TA8Ze7GNd06KxZYuWOzM/cFNL
   qckRywPz2gUF23E2zvoY1+kNrCitNBXJoKPJWO7CRXIYuuDVAbnhCieeC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="16180046"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="16180046"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="772998121"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="772998121"
Received: from lmckeon-mobl.ger.corp.intel.com (HELO iboscu-mobl2.ger.corp.intel.com) ([10.252.48.111])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:37:01 -0800
Date:   Mon, 11 Dec 2023 12:36:59 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LinoSanfilippo@gmx.de, Lukas Wunner <lukas@wunner.de>,
        p.rosenberger@kunbus.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 2/7] serial: core: set missing supported flag for RX
 during TX GPIO
In-Reply-To: <20231209125836.16294-3-l.sanfilippo@kunbus.com>
Message-ID: <f128419a-6782-fc4d-df6f-3b7deebbb467@linux.intel.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com> <20231209125836.16294-3-l.sanfilippo@kunbus.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1849002651-1702291025=:1867"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1849002651-1702291025=:1867
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Sat, 9 Dec 2023, Lino Sanfilippo wrote:

> If the RS485 feature RX-during-TX is supported by means of a GPIO set the
> according supported flag. Otherwise setting this feature from userspace may
> not be possible, since in uart_sanitize_serial_rs485() the passed RS485
> configuration is matched against the supported features and unsupported
> settings are thereby removed and thus take no effect.
> 
> Cc: stable@vger.kernel.org
> Fixes: 163f080eb717 ("serial: core: Add option to output RS485 RX_DURING_TX state via GPIO")
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index a0290a5fe8b3..c254e88c8452 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3632,6 +3632,8 @@ int uart_get_rs485_mode(struct uart_port *port)
>  	if (IS_ERR(desc))
>  		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-gpios\n");
>  	port->rs485_rx_during_tx_gpio = desc;
> +	if (port->rs485_rx_during_tx_gpio)
> +		port->rs485_supported.flags |= SER_RS485_RX_DURING_TX;
>  
>  	return 0;
>  }

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1849002651-1702291025=:1867--
