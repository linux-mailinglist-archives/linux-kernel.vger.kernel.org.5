Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2B7DB633
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjJ3Jdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJ3Jdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:33:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C471C5;
        Mon, 30 Oct 2023 02:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698658416; x=1730194416;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MGg7v733cJVIT8wJVh7PM70i+jR+qkVB9DzADA8OUSY=;
  b=XufLPj3gYhXw94I3awud52zmqtlyxoNa40w01xE9bFdZFnIWOUFFnjkg
   8BzF51QceRWqihWOIjHQw5wQGrCdBJ1DxEqC4CanIJjI0Soxt2WT+5/2K
   EJ3Zay4po7eAUjFHKK7wCsrlkgDDRHK7p5gwS4o4cWSN7XzNzkW/QY8bQ
   XJjem/yNP6O6Svj/UObKNFWLvcQYgZ8BUMpGKqQAPezjNc0ToHg29zGnt
   MD4wIZ5Ea09qZ5RZSvuTJNp2Fx9IaCsObMzRp+Ja+9IJ+0g0jUrRAX0jl
   7kkNxbUOrSJbVwg89Nh4K/+DdiUQv2YKTUlwT6nwtUvomAPeVMirqRuXQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="378414013"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="378414013"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="8283768"
Received: from sgruszka-mobl.ger.corp.intel.com ([10.252.50.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:33:33 -0700
Date:   Mon, 30 Oct 2023 11:33:30 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vamshi Gajjela <vamshigajjela@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH v5 2/2] serial: core: Clean up uart_update_timeout()
 function
In-Reply-To: <20231030073542.251281-3-vamshigajjela@google.com>
Message-ID: <275b9b10-204f-534e-2155-98f623d9f63a@linux.intel.com>
References: <20231030073542.251281-1-vamshigajjela@google.com> <20231030073542.251281-3-vamshigajjela@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023, Vamshi Gajjela wrote:

> Rename the variable size to temp and change its data type from
> unsigned int to u64 to avoid type casting in multiplication. Remove the
> intermediate variable frame_time and use temp instead to accommodate
> the nanoseconds. port->frame_time is an unsigned int, therefore an
> explicit cast is used to improve readability.

You should focus more on why instead of what. So add explanation that the 
frame time is small (you could even calculate the largest value and add 
it to the commit message) and therefore it always fits safely to unsigned 
int. And that we do not upconvert the type to avoid unnecessary costly 
64-bit arithmetic done in a few places in the serial code.

> Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> ---
> v5:
> - shortlog changed from "serial: core: Make local variable size to
>   u64" to "Clean up uart_update_timeout() function"
> - renamed local variable size to temp, generic name
> - removed intermediate variable frame_time
> - added typecast "unsigned int" while assigning to port->frame_time
> v4:
> - no change, not submitted with series
> v3:
> - no change, not submitted with series
> v2:
> - no change, not submitted with series
> 
>  drivers/tty/serial/serial_core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 7bdc21d5e13b..21d345a9812a 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -410,11 +410,10 @@ void
>  uart_update_timeout(struct uart_port *port, unsigned int cflag,
>  		    unsigned int baud)
>  {
> -	unsigned int size = tty_get_frame_size(cflag);
> -	u64 frame_time;
> +	u64 temp = tty_get_frame_size(cflag);
>  
> -	frame_time = (u64)size * NSEC_PER_SEC;
> -	port->frame_time = DIV64_U64_ROUND_UP(frame_time, baud);
> +	temp *= NSEC_PER_SEC;
> +	port->frame_time = (unsigned int)DIV64_U64_ROUND_UP(temp, baud);
>  }
>  EXPORT_SYMBOL(uart_update_timeout);
>  
> 

-- 
 i.

