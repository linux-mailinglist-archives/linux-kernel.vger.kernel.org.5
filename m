Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188627A351E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjIQKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjIQKM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 06:12:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AFE18E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 03:12:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8CFC433C8;
        Sun, 17 Sep 2023 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694945541;
        bh=Vz8TqJ5fsUVWBLlxF+L0vgftJ77qy5DyQpFe/T5uDSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IE2A6HVdA9KavFz4dMfFOepJ9/8SSmeIB+lV5zTQ5vWljEypbJEsJzdSWTLKoaapa
         dWiRE76rvsvkyyPMOAaR263XKCunZTVKrYdz/p7oSrkjcyJT22/xBgngWvXMjxNh12
         V2ihRnpn/Qyz7vNvpie2bpUArdx9wvOcgSd6iY5w=
Date:   Sun, 17 Sep 2023 12:12:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     mcgrof@kernel.org, russell.h.weight@intel.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Add reboot_in_progress for user helper
 path
Message-ID: <2023091727-clever-schilling-3814@gregkh>
References: <1694773288-15755-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694773288-15755-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:51:28PM +0530, Mukesh Ojha wrote:
> There could be following scenario where there is a ongoing reboot
> is going from processA which tries to call all the reboot notifier
> callback and one of them is firmware reboot call which tries to
> abort all the ongoing firmware userspace request under fw_lock
> but there could be another processB which tries to do request
> firmware, which came just after abort done from ProcessA and
> ask for userspace to load the firmware and this can stop the
> ongoing reboot ProcessA to stall for next 60s(default timeout)
> which may be expected behaviour everyone like to see, instead
> we should abort every request which came after once firmware
> marks reboot notification.
> 
>       ProcessA                             ProcessB
> 
> kernel_restart_prepare
>   blocking_notifier_call_chain
>    fw_shutdown_notify
>      kill_pending_fw_fallback_reqs
>       __fw_load_abort
>        fw_state_aborted	              request_firmware
>          __fw_state_set                   firmware_fallback_sysfs
> ...                                        fw_load_from_user_helper
> ..                                         ...
> .                                          ..
>                                             usermodehelper_read_trylock
>                                              fw_load_sysfs_fallback
>                                               fw_sysfs_wait_timeout
> usermodehelper_disable
>  __usermodehelper_disable
>   down_write()
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/base/firmware_loader/fallback.c | 2 +-
>  drivers/base/firmware_loader/firmware.h | 1 +
>  drivers/base/firmware_loader/main.c     | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index bf68e3947814..a5546aeea91f 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -86,7 +86,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>  	}
>  
>  	mutex_lock(&fw_lock);
> -	if (fw_state_is_aborted(fw_priv)) {
> +	if (reboot_in_progress || fw_state_is_aborted(fw_priv)) {
>  		mutex_unlock(&fw_lock);
>  		retval = -EINTR;
>  		goto out;

What prevents reboot_in_progress to change right after you check it
here?

And what kernel driver is trying to call the reboot notifier that gets
mixed up in this?  Why not fix that driver to not need the reboot
notifier at all (hint, I really doubt it needs it...)

> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -93,6 +93,7 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
>  DEFINE_MUTEX(fw_lock);
>  
>  struct firmware_cache fw_cache;
> +bool reboot_in_progress;

Bad global name for a variable in the firmware_loader core.

thanks,

greg k-h
