Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB97E620D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjKICNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjKICNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:13:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792C226A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 18:13:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C46C433C7;
        Thu,  9 Nov 2023 02:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699496000;
        bh=CIfWFmoLFCkhaqyQ5UtCPzZFqwtq4QVkAFXMOQeAhyQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tb4b226AHLMk/bHc4vzM6Gv0V5XrNewAX5nu+rrNis/m+mV+43a3g7SyHvOrfJ0tF
         +zmRR8OTFtUnKt0C4G44zVNEynBy2qNh+Tr5AhO1gi4qlNt2DR1MUC/P+8kyVI/tvO
         JGLm2GpNxozNWFCaf5xaYPNi8Mtzea/XoLFTlsV7RjLvGXgINJmCz61csbuFYae6Io
         HwRQTfLlXN0JaXzUTfZfuMo20KkJS8D/0gSRa172S2oFSswuvRJNEcnDy4pOPnJubD
         XckToT4r04J3+BqRyhtKBTRfKdZ4FDUJIbp8oD+qCF/vwojzndVZPBNsPa/DVQHHAF
         OOSu1FWJVUAOA==
Date:   Wed, 8 Nov 2023 18:13:18 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231108181318.5360af18@kernel.org>
In-Reply-To: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
References: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 14:56:52 -0800 longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When a VF is being exposed form the kernel, it should be marked as "slave"
> before exposing to the user-mode. The VF is not usable without netvsc running
> as master. The user-mode should never see a VF without the "slave" flag.
> 
> An example of a user-mode program depending on this flag is cloud-init
> (https://github.com/canonical/cloud-init/blob/19.3/cloudinit/net/__init__.py)

Quick grep for "flags", "priv" and "slave" doesn't show anything.
Can you point me to the line of code?

> When scanning interfaces, it checks on if this interface has a master to
> decide if it should be configured. There are other user-mode programs perform
> similar checks.
> 
> This commit moves the code of setting the slave flag to the time before VF is
> exposed to user-mode.

> Change since v3:
> Change target to net-next.

You don't consider this a fix? It seems like a race condition.

> -		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
> -			netdev_notice(vf_netdev,
> -				      "falling back to mac addr based matching\n");
> +		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
> +		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))

This change doesn't seem to be described in the commit message.

Please note that we have a rule against reposting patches within 24h:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review
