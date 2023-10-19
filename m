Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714C57D0234
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbjJSTGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjJSTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:06:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582AC126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mv//YJ5Y/OluILOI04DfqTF/GB8fPGIft9LcmhAdW+c=; b=X8X18lgZC3/p8L7xipCAnzOv8o
        +gzi3qeEWT4dFm58E/xLOauMfzlhB8UYC7GHFZdSEJ5gWtIe0weHbmJlTcqQmTiZXZub8PUazVSOe
        dvV+jotpniHURusMUWOakNGIiEEvE6Q8CcZtiZ38jEIZUc0fPh5CUrwvc+ZmfRRh5uKY+TCOk9VZd
        KZO9M9pWBdFJDz33ZMvVpN0BGEF3QlbDIHaltyuCo+7ZGkery34biCAa6hha7US61n2Le28oq2oGF
        UeH62cbez4RqYxtVhNEnG7q4pz0aBdQ+DPbZDpHeSmKD+KiyNWzzPW9cJI/YJsfQ20ueyEVYhfjHq
        u6vYidiQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qtYLw-000ZD0-2k;
        Thu, 19 Oct 2023 19:06:40 +0000
Date:   Thu, 19 Oct 2023 12:06:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     russell.h.weight@intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] firmware_loader: Abort new fw load request once
 firmware core knows about reboot
Message-ID: <ZTF+QLjm8ceL9a00@bombadil.infradead.org>
References: <1696482420-1329-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696482420-1329-1-git-send-email-quic_mojha@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 10:37:00AM +0530, Mukesh Ojha wrote:
> There could be following scenario where there is a ongoing reboot
> is going from processA which tries to call all the reboot notifier
> callback and one of them is firmware reboot call which tries to
> abort all the ongoing firmware userspace request under fw_lock but
> there could be another processB which tries to do request firmware,
> which came just after abort done from ProcessA and ask for userspace
> to load the firmware and this can stop the ongoing reboot ProcessA
> to stall for next 60s(default timeout) which may not be expected
> behaviour everyone like to see, instead we should abort any firmware
> load request which came once firmware knows about the reboot through
> notification.
> 
>       ProcessA                             ProcessB
> 
> kernel_restart_prepare
>   blocking_notifier_call_chain
>    fw_shutdown_notify
>      kill_pending_fw_fallback_reqs
>       __fw_load_abort
>        fw_state_aborted	               request_firmware
>          __fw_state_set                 firmware_fallback_sysfs
> ...                                       fw_load_from_user_helper
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
> Changes from v2: https://lore.kernel.org/lkml/1696431327-7369-1-git-send-email-quic_mojha@quicinc.com/
>  - Renamed the flag to fw_abort_load.
> 
> Changes from v1: https://lore.kernel.org/lkml/1694773288-15755-1-git-send-email-quic_mojha@quicinc.com/
>  - Renamed the flag to fw_load_abort.
>  - Kept the flag under fw_lock.
>  - Repharsed commit text.
> 
>  drivers/base/firmware_loader/fallback.c | 6 +++++-
>  drivers/base/firmware_loader/firmware.h | 1 +
>  drivers/base/firmware_loader/main.c     | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index bf68e3947814..a162020e98f2 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -57,6 +57,10 @@ void kill_pending_fw_fallback_reqs(bool only_kill_custom)

This routine uses a bool for only_kill_custom for when the events we
should kill ar ecustom or not. Piggy backing on it to assume that the
negative of value represents a shutdown is abusing the semantics
and muddies the waters. So to avoid that, just extend the arguments
to kill_pending_fw_fallback_reqs() for a new bool shutdown, that allows
the code to be clearer and the intent is kept clear.

>  		if (!fw_priv->need_uevent || !only_kill_custom)
>  			 __fw_load_abort(fw_priv);
>  	}
> +
> +	if (!only_kill_custom)
> +		fw_abort_load = true;
> +
>  	mutex_unlock(&fw_lock);
>  }
>  
> @@ -86,7 +90,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>  	}
>  
>  	mutex_lock(&fw_lock);
> -	if (fw_state_is_aborted(fw_priv)) {
> +	if (fw_abort_load || fw_state_is_aborted(fw_priv)) {

However, do we really need this ? Could we just use:

if (system_state == SYSTEM_HALT ||
    system_state == SYSTEM_POWER_OFF ||
    system_state == SYSTEM_RESTART ||
    fw_state_is_aborted(fw_priv))

?

  Luis
