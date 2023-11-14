Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59F7EB6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjKNTqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNTqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:46:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C96102
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:46:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C4C433C8;
        Tue, 14 Nov 2023 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699991180;
        bh=AfQYtqw1u7wsFVHfP47gHFUSQcLDhEVnJ7hauFQ5jpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mc0NpQ+k08h14Z+307Z/NobOsarsKopdrQl8w2+I4MpTiCEcNYjXvP6yREXScljVb
         JkI7R0h083vbAQFhHUJ1rFA7aOFR75K573ai3L6di43nJw28N5yjHnZ3PyTotRFffT
         x55cVIV4A5mFnHMco5xJLDZlMQTzszrRJSJ5334HTv3bpiYus+lEXbkzYvMgnhcgmP
         Jkrd4GKAeIauZt1H0Md0Zns9hSizsw4cPs6yjY7LOMUfEOtnpz5clcg3Xq0a9wc8tU
         dexgdm1CTFqOfo62dD0vjPKAWMpCy8SbuE4T9DLmM6s9HorAT2xRJHnZTF1Zxxo8+d
         wvxGNIu/GGcsg==
Date:   Tue, 14 Nov 2023 19:46:16 +0000
From:   Simon Horman <horms@kernel.org>
To:     Johnathan Mantey <johnathanx.mantey@intel.com>
Cc:     netdev@vger.kernel.org, sam@mendozajonas.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] Revert ncsi: Propagate carrier gain/loss events
 to the NCSI controller
Message-ID: <20231114194616.GG74656@kernel.org>
References: <20231113163029.106912-1-johnathanx.mantey@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113163029.106912-1-johnathanx.mantey@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:30:29AM -0800, Johnathan Mantey wrote:
> This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.
> 
> The cited commit introduced unwanted behavior.
> 
> The intent for the commit was to be able to detect carrier loss/gain
> for just the NIC connected to the BMC. The unwanted effect is a
> carrier loss for auxiliary paths also causes the BMC to lose
> carrier. The BMC never regains carrier despite the secondary NIC
> regaining a link.
> 
> This change, when merged, needs to be backported to stable kernels.
> 5.4-stable, 5.10-stable, 5.15-stable, 6.1-stable, 6.5-stable
> 
> Fixes: 3780bb29311e ("ncsi: Propagate carrier gain/loss events to the NCSI controller")
> CC: stable@vger.kernel.org
> Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>

Hi Jonathan,

thanks for addressing my feedback on v2.

So far as addressing a regression goes, this looks good to me.
But I do wonder what can be done about the issue that
the cited commit was intended to address: will this patch regress things
on that front?

...
