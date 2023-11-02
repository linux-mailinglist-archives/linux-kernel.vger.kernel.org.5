Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D807DEC1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348480AbjKBFHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKBFHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:07:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DACFFB;
        Wed,  1 Nov 2023 22:07:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0153C433C7;
        Thu,  2 Nov 2023 05:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698901653;
        bh=bEaqdWR5b16aP9FDPsmLQydpfrRhMcFq4QOwyVtFKS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TqDFwTYbT8gI8nvfa1xBpWQh9zmD09Z+mSW4JUajvZ+0YIvjbFd8KLQ8ha0Yzp5Ub
         E8uUwtAOMjzxKY6WJy9nwXKFL42E4PtHR6/CHL2Uw6kZJnAqxT12zgwmWktS6Yyh4g
         moP5nIAyrl331+He0lEmuZ8RFON57hqb9gTLg9F5N2WQcHQ/fSKlC8hB48XvTGuNzR
         mHJXoi1I4WrOjLGfu36QE/7BhbzrT/MyOq2INwpRZIFE/CQI9doBRuz1HU2/ehCMTI
         pfqAeEqo5YiNcWkzG21X8vmkgIKVYTIpF7DgoQ8e6hAHM1DY3XXN3/6pnIqNN3hWJX
         H8F4kwsqfpiSg==
Date:   Wed, 1 Nov 2023 22:07:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net,v2] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Message-ID: <20231101220730.2b7cc7d1@kernel.org>
In-Reply-To: <1698355354-12869-1-git-send-email-haiyangz@microsoft.com>
References: <1698355354-12869-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 14:22:34 -0700 Haiyang Zhang wrote:
> And, move register_netdevice_notifier() earlier, so the call back
> function is set before probing.

Are you sure you need this? I thought the netdev notifier "replays"
registration events (i.e. sends "fake" events for already present
netdevs).

If I'm wrong this should still be a separate patch from the rtnl
reorder.
-- 
pw-bot: cr
