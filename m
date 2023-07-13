Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657F7527A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjGMPri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjGMPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B1F1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2764A60A70
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3151DC433C7;
        Thu, 13 Jul 2023 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689263254;
        bh=i37Pn35Ma5iz47/BovQHmpsTpruTD//Fx78Ggq9VeG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8vX1KqKm+k+fEp+TeFwoalLYLV2z+vFifI7I1H8DW8a0Oh+jY0JWg829fbHqEavj
         0Q2nP3bYFd6N2AFPf7F4oMMprkM3GVPg9UJM60uO9V12CDUpUADsRD74By9aksh4bN
         gqePTIMYsg4jks6P4rnr1V3SwurIm/DF7uzGgES4=
Date:   Thu, 13 Jul 2023 17:47:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hanyu001@208suo.com
Cc:     tglx@linutronix.de, peterz@infradead.org, vschneid@redhat.com,
        dwmw@amazon.co.uk, akpm@linux-foundation.org, npiggin@gmail.com,
        pauld@redhat.com, vdonnefort@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] kernel:  convert sysfs snprintf to sysfs_emit
Message-ID: <2023071353-garage-twisty-8414@gregkh>
References: <tencent_48D17833D10F2D6A2DF87986804C357D2506@qq.com>
 <ef672732fbb865f338d88db89fc11062@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef672732fbb865f338d88db89fc11062@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 05:20:49PM +0800, hanyu001@208suo.com wrote:
> Fix the following coccicheck warnings:
> drivers/tty/vt/vt.c:3942:8-16:
> WARNING: use scnprintf or sprintf
> drivers/tty/vt/vt.c:3950:8-16:
> WARNING: use scnprintf or sprintf
> 
> ./kernel/cpu.c:2920:8-16: WARNING: use scnprintf or sprintf
> ./kernel/cpu.c:2907:8-16: WARNING: use scnprintf or sprintf
> 
> Signed-off-by: ztt <1549089851@qq.com>
> ---
>  kernel/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index ed65aeaa94b5..1a9634236b54 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2904,7 +2904,7 @@ static ssize_t control_show(struct device *dev,
>  {
>      const char *state = smt_states[cpu_smt_control];
> 
> -    return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
> +    return scnprintf(buf, PAGE_SIZE - 2, "%s\n", state);
>  }
> 
>  static ssize_t control_store(struct device *dev, struct device_attribute
> *attr,
> @@ -2917,7 +2917,7 @@ static DEVICE_ATTR_RW(control);
>  static ssize_t active_show(struct device *dev,
>                 struct device_attribute *attr, char *buf)
>  {
> -    return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
> +    return scnprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
>  }
>  static DEVICE_ATTR_RO(active);

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
