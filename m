Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D984C760B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjGYHIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjGYHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:08:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2052ABD;
        Tue, 25 Jul 2023 00:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0C4C61129;
        Tue, 25 Jul 2023 07:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C13C433C8;
        Tue, 25 Jul 2023 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690268893;
        bh=8ZO+dQLtUiBc7Ah68ZPlpmAFo7aFZA5cxmTFAGgJ4qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tz1wvA2lxwAsPqVJtqbtnialvr10PrdMB1LuHZw47XVu1YM0unJi6kQQF1HczgJAC
         UgCBGXe3vZUin1qlo5WT/CIIDHxsIwhiSfQOVdm+fbtH0LQleRIJ+PKVGgfNRODelI
         Vn1hCwrXUEOBpUffiR2rRiCZMyPpXB1MXEfAN1XQ=
Date:   Tue, 25 Jul 2023 09:08:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dianders@chromium.org,
        caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipa: only reset hashed tables when supported
Message-ID: <2023072538-corned-falsify-d054@gregkh>
References: <20230724224106.1688869-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724224106.1688869-1-elder@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:41:06PM -0500, Alex Elder wrote:
> Last year, the code that manages GSI channel transactions switched
> from using spinlock-protected linked lists to using indexes into the
> ring buffer used for a channel.  Recently, Google reported seeing
> transaction reference count underflows occasionally during shutdown.
> 
> Doug Anderson found a way to reproduce the issue reliably, and
> bisected the issue to the commit that eliminated the linked lists
> and the lock.  The root cause was ultimately determined to be
> related to unused transactions being committed as part of the modem
> shutdown cleanup activity.  Unused transactions are not normally
> expected (except in error cases).
> 
> The modem uses some ranges of IPA-resident memory, and whenever it
> shuts down we zero those ranges.  In ipa_filter_reset_table() a
> transaction is allocated to zero modem filter table entries.  If
> hashing is not supported, hashed table memory should not be zeroed.
> But currently nothing prevents that, and the result is an unused
> transaction.  Something similar occurs when we zero routing table
> entries for the modem.
> 
> By preventing any attempt to clear hashed tables when hashing is not
> supported, the reference count underflow is avoided in this case.
> 
> Note that there likely remains an issue with properly freeing unused
> transactions (if they occur due to errors).  This patch addresses
> only the underflows that Google originally reported.
> 
> Fixes: d338ae28d8a8 ("net: ipa: kill all other transaction lists")
> Cc: <stable@vger.kernel.org>    # 6.1.x
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/net/ipa/ipa_table.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)

You sent 2 different versions of this patch?  Which one is for what
tree?  Is this in Linus's tree already?  If so, what's the git id?

confused,

greg k-h
