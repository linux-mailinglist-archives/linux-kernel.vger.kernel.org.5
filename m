Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450627BCC82
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbjJHGFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbjJHGFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:05:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F7C6;
        Sat,  7 Oct 2023 23:05:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA68C433C9;
        Sun,  8 Oct 2023 06:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696745143;
        bh=6G4E2k0CfxZ9RMVM/HKCgdTvuF8wdlnMz5WMcwKbtiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuqeMXVcKbcaBDb+fC1tnut7M9vrgyJMrCuNtLsk/3bJoBgGgW22YJk1NZzmTVLbw
         +t8OLkbdY5K541GwTxUqJ7J+MU7Vjq0eQvD0o4W1/0PC9lOoXljrbbu8vqzDRZbz75
         x0daNe4E/8V0YueTZfR4j2fKeO1D4NUq2inl0+hA=
Date:   Sun, 8 Oct 2023 08:05:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
Subject: Re: [PATCH] Bluetooth: hci_conn_failed: Fix memory leak
Message-ID: <2023100830-agreeably-jokingly-e6b4@gregkh>
References: <AM9P192MB1267F1B8CA16CEEF884C9F2CE8CFA@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P192MB1267F1B8CA16CEEF884C9F2CE8CFA@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 11:33:34AM +0530, Yuran Pereira wrote:
> The hci_conn_failed() function currently calls hci_connect_cfm(), which
> indirectly leads to the allocation of an l2cap_conn struct in 
> l2cap_conn_add().
> This operation results in a memory leak, as the l2cap_conn structure
> becomes unreferenced.
> 
> To address this issue and prevent the memory leak, this patch modifies
> hci_conn_failed() to replace the call to hci_connect_cfm() with a
> call to hci_disconn_cfm().
> 
> Fixes: 9b3628d79b46 ("Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted")
> Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=39ec16ff6cc18b1d066d
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  net/bluetooth/hci_conn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 7a6f20338db8..1d2d03b4a98a 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1248,7 +1248,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
>  	}
>  
>  	conn->state = BT_CLOSED;
> -	hci_connect_cfm(conn, status);
> +	hci_disconn_cfm(conn, status);
>  	hci_conn_del(conn);
>  }
>  
> -- 
> 2.25.1
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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documetnation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
