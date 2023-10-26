Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4C7D8A24
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjJZVRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:17:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E45C0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RAZ8HHKchqOYdcF3I8aqrN2sz0ZoEqDQCNwNy5dZLbU=; b=4rUOCii0h6li4mpuKW9ItFTN3w
        wMBnACxAgpkXtnYeWcQ3FIn3ENU5kCNAIJkqAWgFHd6pE8LVfbc3rrKXSw0jbu2iAv9NDg3le1xM7
        bdfUrUhbc47hiExqy0qHtdyqviyfJC/1o70fAvhRiGIYUNLC1yfhjE7xhxa+PI10FQCUn/vUgf1/O
        jZvPIK686ROG+uxFmd4ifsbfUuNkGIjcJGyiWCLWvhXB+15pt18kl0c9a1kq+RCcwYMETeHz5se5G
        oeXR55DookKghv1me17KG4+rfLFvCwFOha2nr0wpmA4k1YLQCX6iu9yQdmT4s9bp1rcX0QWf3EAut
        0+gMWiJQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qw7jJ-00FAJY-2H;
        Thu, 26 Oct 2023 21:17:25 +0000
Date:   Thu, 26 Oct 2023 14:17:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] firmware_loader: Abort all upcoming firmware load
 request once reboot triggered
Message-ID: <ZTrXZZw8P1QdfvFS@bombadil.infradead.org>
References: <1698330459-31776-1-git-send-email-quic_mojha@quicinc.com>
 <1698330459-31776-2-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698330459-31776-2-git-send-email-quic_mojha@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:57:39PM +0530, Mukesh Ojha wrote:
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
>        fw_state_aborted                request_firmware
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

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
