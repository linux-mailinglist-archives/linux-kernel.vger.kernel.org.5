Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5AF783ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjHVH3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjHVH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:29:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D927186
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 942FE64E6F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6E1C433C7;
        Tue, 22 Aug 2023 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692689354;
        bh=GlJaG6ZRX4I+wLZZpdMZ3KFHFXQKGDaXAy2IBBc3GbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjgVnoGJcw74HmYSqB6jRUSxklL0xe0dMpoQ1IbbOzNF5O+BwkgcFUbgkCKQ7tChj
         F/6JaZh4IvIeNwAagbv/7PWVgxU8cM7KZMcUwjWqTq6wVM9OVHlQhytYWuAGXfRrkJ
         9o9bsNCL3trRb85Jjgq/twaGiFlXQGGxFb9LxVAYi8TLZ8CUaxhYXvhlWTuGnzOBFd
         ljJFeKnL6TS+NOQGJTV1laphANXn1ps5cOm6ugetCjsyL2LWsR3MupSfOctdQkrhul
         BSJRgf/JzGcAMkrJqavFt/5LoT1dyezUX3tP2/lL6hjwvFLhFxUGcypmbEKI6Mca9/
         G5CfjfofiRRIg==
Date:   Tue, 22 Aug 2023 09:29:09 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        richardcochran@gmail.com, kalesh-anakkur.purayil@broadcom.com,
        leon@kernel.org, Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v4] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Message-ID: <20230822072909.GM2711035@kernel.org>
References: <20230821103629.3799884-1-saikrishnag@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821103629.3799884-1-saikrishnag@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:06:29PM +0530, Sai Krishna wrote:
> Some of the newer silicon versions in CN10K series supports a feature
> where in the current PTP timestamp in HW can be updated atomically
> without losing any cpu cycles unlike read/modify/write register.
> This patch uses this feature so that PTP accuracy can be improved
> while adjusting the master offset in HW. There is no need for SW
> timecounter when using this feature. So removed references to SW
> timecounter wherever appropriate.
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
> v4:
>     - Addressed review comments given by Leon Romanovsky
>         1. Unlocked mutex in error conditions.
> v3:
>     - Addressed review comments given by Jakub Kicinski
>         1. Fixed re-ordering of headers in alphabetical order
>         2. Refactored SoC revision identification logic
>         3. CN10K errata revisions can be different from atomic update
>            supported revision devices.
>         4. Removed ptp device check.
> v2:
>     - Addressed review comments given by Simon Horman, Kalesh Anakkur Purayil
> 	1. Removed inline keyword for function in .c file
>         2. Modified/optimized conditions related boolean

Reviewed-by: Simon Horman <horms@kernel.org>

