Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56E2784186
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjHVNFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjHVNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A69D7;
        Tue, 22 Aug 2023 06:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF19860C63;
        Tue, 22 Aug 2023 13:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98514C433C8;
        Tue, 22 Aug 2023 13:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692709547;
        bh=pvHZnfwRZa1Zh/yZFcFxSAFf+i6k+ATkzimoxm/IRYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFQpr0Hk8C5t5H3opAu/rKK5NN+OqB2gfyHncPTnSiUXhWnpDulEpKlSttKjDe+rf
         10JLxdKtdD1n4KO2D5wl37DkRJiHxBbNPd1kiastI1dZuFViUm0kv8vcTvSzaMFZty
         O2l7DXJZJ9iBVSJvE+FyZhBIoqH+ZCfnjVNTf7Rw=
Date:   Tue, 22 Aug 2023 15:05:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/9] tty: n_gsm: add restart flag to DLC specific
 ioctl config
Message-ID: <2023082227-morse-dreaded-4cd5@gregkh>
References: <20230817093231.2317-1-daniel.starke@siemens.com>
 <2023082241-stagnant-parched-215d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082241-stagnant-parched-215d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 03:05:10PM +0200, Greg KH wrote:
> On Thu, Aug 17, 2023 at 11:32:23AM +0200, D. Starke wrote:
> > From: Daniel Starke <daniel.starke@siemens.com>
> > 
> > Currently, changing the parameters of a DLCI gives no direct control to the
> > user whether this should trigger a channel reset or not. The decision is
> > solely made by the driver based on the assumption which parameter changes
> > are compatible or not. Therefore, the user has no means to perform an
> > automatic channel reset after parameter configuration for non-conflicting
> > changes.
> > 
> > Add the parameter 'flags' to 'gsm_dlci_config' to force a channel reset
> > after ioctl setting regardless of whether the changes made require this or
> > not by setting this to 'GSM_FL_RESTART'.
> > 
> > Note that 'GSM_FL_RESTART' is currently the only allow flag to allow
> > additions here.
> > 
> > Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> > ---
> >  drivers/tty/n_gsm.c         |  4 ++++
> >  include/uapi/linux/gsmmux.h | 15 ++++++++++++++-
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > v5 -> v6:
> > No changes.
> > 
> > Link: https://lore.kernel.org/all/20230517155704.5701-1-daniel.starke@siemens.com/
> > 
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > index 42759500b79e..a4268515920e 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -2532,6 +2532,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
> >  		return -EINVAL;
> >  	if (dc->k > 7)
> >  		return -EINVAL;
> > +	if (dc->flags & ~GSM_FL_RESTART)   /* allow future extensions */
> > +		return -EINVAL;
> >  
> >  	/*
> >  	 * See what is needed for reconfiguration
> > @@ -2546,6 +2548,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
> >  	/* Requires care */
> >  	if (dc->priority != dlci->prio)
> >  		need_restart = true;
> > +	if (dc->flags & GSM_FL_RESTART)
> > +		need_restart = true;
> >  
> >  	if ((open && gsm->wait_config) || need_restart)
> >  		need_open = true;
> > diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> > index eb67884e5f38..e56e2d7ea6eb 100644
> > --- a/include/uapi/linux/gsmmux.h
> > +++ b/include/uapi/linux/gsmmux.h
> > @@ -2,10 +2,22 @@
> >  #ifndef _LINUX_GSMMUX_H
> >  #define _LINUX_GSMMUX_H
> >  
> > +#include <linux/const.h>
> >  #include <linux/if.h>
> >  #include <linux/ioctl.h>
> >  #include <linux/types.h>
> >  
> > +/*
> > + * flags definition for n_gsm
> > + *
> > + * Used by:
> > + * struct gsm_dlci_config.flags
> > + */
> > +/* Forces a DLCI reset if set. Otherwise, a DLCI reset is only done if
> > + * incompatible settings were provided. Always cleared on retrieval.
> > + */
> > +#define GSM_FL_RESTART	_BITUL(0)
> > +
> >  struct gsm_config
> >  {
> >  	unsigned int adaption;
> > @@ -58,7 +70,8 @@ struct gsm_dlci_config {
> >  	__u32 priority;		/* Priority (0 for default value) */
> >  	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
> >  	__u32 k;		/* Window size (0 for default value) */
> > -	__u32 reserved[8];	/* For future use, must be initialized to zero */
> > +	__u32 flags;		/* DLCI specific flags. */
> 
> This should be called "dlci_flags" right?  Otherwise when you add more
> flags in the reserved area, what will you call them?

Oh nevermind, the name of the structure has it there, this is fine, I'll
take this...

thanks,

greg k-h
