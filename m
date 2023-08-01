Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E076AAD9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHAIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjHAIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:24:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FDE18D;
        Tue,  1 Aug 2023 01:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF33614B7;
        Tue,  1 Aug 2023 08:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342C0C433C8;
        Tue,  1 Aug 2023 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690878274;
        bh=gkk74t9As49XSJeT+8LUv0zRRxmwMv0p+C8NfbmPl7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZBz4x7Y8V6Yp4RfkN8c+sBfGIsAeDXHsN2N7xNltclI6Y37r0oskt+G6j7xErJbj
         5NEXOYonN050QVNcZj8D3Wb2b9m6fl1Hr2Kvtpx+MQVpeadYQuV95XVSBBKKM30D1w
         eg/sBJMZ61btbOLDO2LZz4Uo9f7mcybxSlrd1MlM=
Date:   Tue, 1 Aug 2023 10:24:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rishabh Bhatnagar <risbhat@amazon.com>
Cc:     lee@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH 4.14] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
Message-ID: <2023080102-certified-unrivaled-a048@gregkh>
References: <20230727191554.21333-1-risbhat@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727191554.21333-1-risbhat@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 07:15:54PM +0000, Rishabh Bhatnagar wrote:
> From: Lee Jones <lee@kernel.org>
> 
> Upstream commit 04c55383fa5689357bcdd2c8036725a55ed632bc.
> 
> In the event of a failure in tcf_change_indev(), u32_set_parms() will
> immediately return without decrementing the recently incremented
> reference counter.  If this happens enough times, the counter will
> rollover and the reference freed, leading to a double free which can be
> used to do 'bad things'.
> 
> In order to prevent this, move the point of possible failure above the
> point where the reference counter is incremented.  Also save any
> meaningful return values to be applied to the return data at the
> appropriate point in time.
> 
> This issue was caught with KASAN.
> 
> Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_change for newly allocated struct")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
> ---
>  net/sched/cls_u32.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

We need a 4.19.y backport before we can apply a 4.14.y version, as you
do not want to upgrade and have a regression.

thanks,

greg k-h
