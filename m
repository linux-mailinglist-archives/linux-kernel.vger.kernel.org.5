Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E387DC387
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbjJaATn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbjJaATk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:19:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C8A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:19:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9325EC433C8;
        Tue, 31 Oct 2023 00:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698711578;
        bh=KqntrI6yWULYOqoFYjP2QovNdDJFLeRx3oez/l6mcTI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mObPa0r3sINbGo40LsSc7nvHUNR3hXs+ZjXhViF1YCKoPuxBTiEZSVviCUHutX4d5
         CJsTyR2gHbHVBhH+cFfWuKteME8CgZY37/s1sqDWtSns9uPJEX6iKd++/QHzuCS44K
         vGOesldheWZUdadPb8Ti2z8WfupkrRH2dCWfZdVijuklRAXvrFPmVuljx6eHkEL1NU
         uViFD8uqf+VZPbfWxtkod6niVIJ8d5m7FyTRp8zdBC6YQPXiLWCNWNc3DR7JsvbW5P
         hhVL579HWUOoP+I2a60Mm1vhfuP3WVAZ9gbzoNIerRCxBHqDk4j/TL4W8zTt3cJD2t
         lrN8t12dY0fcg==
Date:   Mon, 30 Oct 2023 17:19:36 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] xen/events: avoid using info_for_irq() in
 xen_send_IPI_one()
In-Reply-To: <20231030142732.1702-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.22.394.2310301719300.1625118@ubuntu-linux-20-04-desktop>
References: <20231030142732.1702-1-jgross@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023, Juergen Gross wrote:
> xen_send_IPI_one() is being used by cpuhp_report_idle_dead() after
> it calls rcu_report_dead(), meaning that any RCU usage by
> xen_send_IPI_one() is a bad idea.
> 
> Unfortunately xen_send_IPI_one() is using notify_remote_via_irq()
> today, which is using irq_get_chip_data() via info_for_irq(). And
> irq_get_chip_data() in turn is using a maple-tree lookup requiring
> RCU.
> 
> Avoid this problem by caching the ipi event channels in another
> percpu variable, allowing the use notify_remote_via_evtchn() in
> xen_send_IPI_one().
> 
> Fixes: 721255b9826b ("genirq: Use a maple tree for interrupt descriptor management")
> Reported-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: David Woodhouse <dwmw@amazon.co.uk>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>
