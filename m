Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE7776F948
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjHDFHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHDFFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888BC5588
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 22:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 499B261F26
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58969C433C8;
        Fri,  4 Aug 2023 05:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691125314;
        bh=ayVx67NI7whJIEYM/PRTa+Z5Dqnme7NKXeSusGW3xoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPxCnF3eK2hlZbSFjh/cXLqmvBWOJsXEZJ6gv1SmPMfdNreoNc/jZwvWlcVS3CPHV
         G8bg68ve2U+2olqN3F48L9mH52Gex/LYAN5lRgHS4cV8DH0g+VvAqqpYMRG5oeQ6QU
         TaPKASXVXbp5mK3/ce8xuMmKkjQ7kSCF08W0X//Y=
Date:   Fri, 4 Aug 2023 07:01:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Raut <rauji.raut@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] ipc:msg: replace one-element array with
 flexible-array member
Message-ID: <2023080434-angrily-colossal-22b5@gregkh>
References: <20230804041949.5724-1-rauji.raut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804041949.5724-1-rauji.raut@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:19:49PM -0700, Atul Raut wrote:
> One-element arrays are obsolete, and flexible
> array members have taken their place. So, in
> struct compat_msgbuf, replace the one-element
> array with a flexible-array member.
> 
> This fixes warnings such as:
> ./ipc/msg.c:981:6-11: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> ---
>  ipc/msg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ipc/msg.c b/ipc/msg.c
> index fd08b3cb36d7..ee6af4fe52bf 100644
> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -978,7 +978,7 @@ SYSCALL_DEFINE4(msgsnd, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
>  
>  struct compat_msgbuf {
>  	compat_long_t mtype;
> -	char mtext[1];
> +	char mtext[];
>  };
>  
>  long compat_ksys_msgsnd(int msqid, compat_uptr_t msgp,
> -- 
> 2.34.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees

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
