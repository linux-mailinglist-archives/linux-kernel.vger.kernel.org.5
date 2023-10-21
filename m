Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EA57D1F0E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 21:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjJUTX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 15:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUTX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 15:23:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C66126;
        Sat, 21 Oct 2023 12:23:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C029FC433C8;
        Sat, 21 Oct 2023 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697916202;
        bh=yhDGV+afbKRRSHX9sgNtz5SsFfBE8tY3ozhHoe4H7gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnTTsZIQfovQp8cjxbyLj0z4ii9wo96GH4bh3XuUbQiaTrIw2ltzGJJNk0B9EbsgS
         ZxN5xq8AsyFd+1tEf5wMDdKXGIrfXQgAGfCcWrWMVTe07wrQcAKlK/kop4uLKbqA6e
         TA247/a3LeZ6zPrs7bGxQt14+ep72B5C784txzM4=
Date:   Sat, 21 Oct 2023 21:23:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     keescook@chromium.org, Robert Richter <rric@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/thunderx: Fix some potential buffer overflow in
 thunderx_ocx_com_threaded_isr()
Message-ID: <2023102149-scrunch-carrousel-dcc3@gregkh>
References: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 07:13:51PM +0200, Christophe JAILLET wrote:
> strncat() usage in thunderx_ocx_com_threaded_isr() is wrong.
> The size given to strncat() is the maximum number of bytes that can be
> written, excluding the trailing NULL.
> 
> Here, the size of the 'msg' buffer is used (i.e. OCX_MESSAGE_SIZE), not
> the space that is remaining.
> The space for the ending NULL is also not taken into account.
> 
> in order to fix it:
>    - call decode_register() before the snprintf() calls
>    - use scnprintf() instead of snprintf() and compute, in the 'remaining'
>      variable, the space that is still available in the 'msg' buffer
>    - add a %s at the end of the format strings and append directly the
>      result of decode_register() stored in 'other'
>    - write directly at the right position in the 'msg' buffer when
>      appending some data in the for loop.
> 
> Doing so, all usages of strncat() are removed.
> 
> Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This is cross-compile tested only.
> Review with care.
> 
> v2: remove some other erroneous usage of strncat()
> ---
>  drivers/edac/thunderx_edac.c | 44 ++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)

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

- You have marked a patch with a Fixes: tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
