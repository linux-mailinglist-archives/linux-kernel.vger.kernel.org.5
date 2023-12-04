Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85CD802C8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjLDH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjLDH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:58:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95309AC;
        Sun,  3 Dec 2023 23:58:26 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701676704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olLQmfouF3da3Ez0MZE8XTk1beuCISuKI3rPjmx3/hc=;
        b=jROt4+AA2gHCjQQejTIJ4vx61px4E4T6n7je/BoGancpAFJzJip5U7lrImJxKWIqbbMRtq
        6m5nmG8i3VblkEIRlbtxchdeGxnLTRgHOfbPcp6e1doolQTYPM3nQxS48f+2396sY04H3K
        AQa/bymq0fZit98BLuQWFsktYiAx9A2kt/HaXVoWxeU0DbC+m7maUCeeHta7XD7bkH33+G
        Y4l9w4vk77GVv6YHcaiXBxkFEPjXcRomvw0tdn/apFOqCVUrMU/FjOHXztPcy2fZIeQZN+
        lUF9etwZ2a5wpRp3KdgjkdImnU2gAeMF5oRpJDHp9RxgARd5oA3G8KaBaQunow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701676704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=olLQmfouF3da3Ez0MZE8XTk1beuCISuKI3rPjmx3/hc=;
        b=BfloaVnhH1keEIYiuj2GPUgURfGHFRALvHxjv42XRmGBcfK9HphTyelqVddlgAlKPMoJTx
        zZ5jWZZYCHljWXBw==
To:     Jiqian Chen <Jiqian.Chen@amd.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Stefano Stabellini <stefano.stabellini@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
In-Reply-To: <20231124103123.3263471-2-Jiqian.Chen@amd.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com>
Date:   Mon, 04 Dec 2023 08:58:22 +0100
Message-ID: <87edg2xuu9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24 2023 at 18:31, Jiqian Chen wrote:
> When device on dom0 side has been reset, the vpci on Xen side
> won't get notification, so that the cached state in vpci is
> all out of date with the real device state.
> To solve that problem, this patch add a function to clear all

Please get rid of 'this patch' all over the series.

# grep -r 'This patch' Documentation/process/

> vpci device state when device is reset on dom0 side.
>
> And call that function in pcistub_init_device. Because when
> we use "pci-assignable-add" to assign a passthrough device in
> Xen, it will reset passthrough device and the vpci state will
> out of date, and then device will fail to restore bar state.
>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

This Signed-off-by chain is incorrect.

Documentation/process/submitting-patches.rst has a full chapter about
S-O-B and the correct usage.

Thanks,

        tglx
