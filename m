Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D611779104
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjHKNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjHKNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:50:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23FD18F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:50:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6AF381F88C;
        Fri, 11 Aug 2023 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691761814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRJwIFrdoiXP+vzELGTcek+8lDmoluEQ1v+M2HyTAE4=;
        b=c+lxeGuq4edGXg21rl/8/FQ6+OoqsWh+zeYZGJS7usxWhJEuX4AeHZN/sPCbYNUlfznkjR
        upuQwJWfnXAn8L0CvUhhyM1+ousfSvOk+Q6agRmnbAV09D3diatZiaFUTBpR2Zj2qahmet
        y6tp8xopfxDS95niqtGeTnZZipOD3fM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 39DAB2C142;
        Fri, 11 Aug 2023 13:50:14 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:50:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 8/8] printk: nbcon: Add functions for drivers
 to mark unsafe regions
Message-ID: <ZNY8koUN5a9TVzS2@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-9-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 02:08:33, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> For the write_atomic callback, the console driver may have unsafe
> regions that need to be appropriately marked. Provide functions
> that accept the nbcon_write_context struct to allow for the driver
> to enter and exit unsafe regions.
> 
> diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
> index e1f0e4278ffa..57b7539bbbb2 100644
> --- a/kernel/printk/printk_nbcon.c
> +++ b/kernel/printk/printk_nbcon.c
> @@ -761,7 +761,6 @@ EXPORT_SYMBOL_GPL(nbcon_can_proceed);
>   *
>   * Internal helper to avoid duplicated code
>   */
> -__maybe_unused
>  static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
>  {
>  	struct console *con = ctxt->console;

It might be better to define nbcon_context_update_unsafe()
in this patch. I guess that nbcon_enter_unsafe()/nbcon_exit_unsafe()
are the only callers.

> @@ -787,6 +786,46 @@ static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
>  	return true;
>  }
>  
> +/**
> + * nbcon_enter_unsafe - Enter an unsafe region in the driver
> + * @wctxt:	The write context that was handed to the write function
> + *
> + * Return:	True if the state is correct. False if ownership was
> + *		handed over or taken.

Same as in 7th patch. I would write:

 * Return:	True if this context still owns the console. False
		if the ownership has been handed over or taken.

> + *
> + * When this function returns false then the calling context is no longer
> + * the owner and is no longer allowed to go forward. In this case it must
> + * back out immediately and carefully. The buffer content is also no longer
> + * trusted since it no longer belongs to the calling context.
> + */
> +bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	return nbcon_context_update_unsafe(ctxt, true);
> +}
> +EXPORT_SYMBOL_GPL(nbcon_enter_unsafe);
> +
> +/**
> + * nbcon_exit_unsafe - Exit an unsafe region in the driver
> + * @wctxt:	The write context that was handed to the write function
> + *
> + * Return:	True if the state is correct. False if ownership was
> + *		handed over or taken.

Same here.

> + * When this function returns false then the calling context is no longer
> + * the owner and is no longer allowed to go forward. In this case it must
> + * back out immediately and carefully. The buffer content is also no longer
> + * trusted since it no longer belongs to the calling context.
> + */
> +bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	return nbcon_context_update_unsafe(ctxt, false);
> +}
> +EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
> +

Best Regards,
Petr
