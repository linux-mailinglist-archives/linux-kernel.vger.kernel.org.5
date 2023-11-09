Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586617E6B48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjKINgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjKINf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:35:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0330CF;
        Thu,  9 Nov 2023 05:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699536957; x=1731072957;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WfSoMeS0iv8RL/K/+nqVLdbB6g5UHuc+PD+KhKFpc8o=;
  b=dAhlkoIss3ZtQQyKKVOI7vcGEH7ZVK9LryxoZLaHhrD0W/xgdae2VT8H
   VBTDF0lfwrpm+7bf8StujSDOpyJJysIgBcWv9FiSeu+vzZIFfHZI/+9iB
   s7YB2S7jfIQC/ekqYjdEKr4ALZEnTB1U4Xtm0fe5W4xGLItnWH/788VRl
   5jU/v9whxQMKRC/SJH3E7Btdhjr/1X1D8EZXlYAiPJJMiNkyXr5QWLUE2
   +HueM8AYgcxM4+/3cEQlLMjRxb52bxwPZplO16BXaoMXBF63dvOqJNo0V
   X0Rj5uQkbhVEZFah9YaM0Qa7+H4Wto9qQ4uuR/rpUVLxkWnNpwLE0LftJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="3013006"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="3013006"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 05:35:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="798318234"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="798318234"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.mshome.net) ([10.237.66.38])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 05:35:53 -0800
Date:   Thu, 9 Nov 2023 15:35:50 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3] tty: serial: Add RS422 flag to struct serial_rs485
In-Reply-To: <20231108060719.11775-1-crescentcy.hsieh@moxa.com>
Message-ID: <c247dda3-40d0-f1ab-fe59-2649f779f3@linux.intel.com>
References: <20231108060719.11775-1-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023, Crescent CY Hsieh wrote:

> Add "SER_RS485_MODE_RS422" flag to struct serial_rs485, so that serial
> port can switch interface into RS422 if supported by using ioctl command
> "TIOCSRS485".
> 
> By treating RS422 as a mode of RS485, which means while enabling RS422
> there are two flags need to be set (SER_RS485_ENABLED and
> SER_RS485_MODE_RS422), it would make things much easier. For example
> some places that checks for "SER_RS485_ENABLED" won't need to be rewritten.
> 
> There are only two things need to be noticed:
> 
> - While enabling RS422, other RS485 flags should not be set.
> - RS422 doesn't need to deal with termination, so while disabling RS485
>   or enabling RS422, uart_set_rs485_termination() shall return.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> 
> ---
> Changes from v2 to v3:
> - Remove "SER_RS422_ENABLED" flag from legacy flags.
> - Revise "SER_RS422_ENABLED" into "SER_RS485_MODE_RS422".
> - Remove the code which checks the conflicts between SER_RS485_ENABLED
>   and SER_RS422_ENABLED.
> - Add return check in uart_set_rs485_termination().
> 
> Changes from v1 to v2:
> - Revise the logic that checks whether RS422/RS485 are enabled
>   simultaneously.
> 
> v2: https://lore.kernel.org/all/20231101064404.45711-1-crescentcy.hsieh@moxa.com/
> v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@moxa.com/
> 
> ---

> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -137,17 +137,19 @@ struct serial_icounter_struct {
>   * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
>   * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
>   * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
> + * * %SER_RS485_MODE_RS422	- Enable RS422. Requires %SER_RS485_ENABLED.
>   */
>  struct serial_rs485 {
>  	__u32	flags;
> -#define SER_RS485_ENABLED		(1 << 0)
> -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
> -#define SER_RS485_RX_DURING_TX		(1 << 4)
> -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> -#define SER_RS485_ADDRB			(1 << 6)
> -#define SER_RS485_ADDR_RECV		(1 << 7)
> -#define SER_RS485_ADDR_DEST		(1 << 8)
> +#define SER_RS485_ENABLED		BIT(0)
> +#define SER_RS485_RTS_ON_SEND		BIT(1)
> +#define SER_RS485_RTS_AFTER_SEND	BIT(2)
> +#define SER_RS485_RX_DURING_TX		BIT(3)
> +#define SER_RS485_TERMINATE_BUS		BIT(4)
> +#define SER_RS485_ADDRB			BIT(5)
> +#define SER_RS485_ADDR_RECV		BIT(6)
> +#define SER_RS485_ADDR_DEST		BIT(7)
> +#define SER_RS485_MODE_RS422		BIT(8)

Is BIT() allowed in uapi headers these days?

-- 
 i.

