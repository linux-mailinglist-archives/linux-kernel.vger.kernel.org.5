Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C47816D9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244416AbjHSCu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244431AbjHSCuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2213C34
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 19:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B3F60B5E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 02:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AA4C433C8;
        Sat, 19 Aug 2023 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692413442;
        bh=zkt9PU/oOgNUJ6FKKoLOe558w9veSeidDWOpQEEZejw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RVMfRv2WT9roy4vPyP+NL7hto2hVfxL5qE9s6kfSVJ+OWLd4hFV8xsCMjCZCpreCZ
         wdyWuGbG+On54WuiUgv5Q4VXjOOxnMrTWnGaYw0Eljr/H5WDwYdqhOPEB4cwUPSjMS
         /vhGVw6rbxiyeaTYf/i9OymX4eEuRhUhmYRZL7ejDoIH8En8QH8S/TRR4DZUHTXBp8
         fhc4quKoDzIc56MoEO9MLxD94MVV6NzWgVHxVndHqSxNh44wDZnNDPmfaSuZa5CkT7
         kQZSfbHN4RqwPeNOorJkHCLHjBel8qn9+aEcsijsr9kdsKnNyHO7cqdtneY4RfK49B
         goQyyxuYGgcbw==
Date:   Fri, 18 Aug 2023 19:50:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [net-next Patch 4/5] octeontx2-af: replace generic error codes
Message-ID: <20230818195041.1fd54fb3@kernel.org>
In-Reply-To: <20230817112357.25874-5-hkelam@marvell.com>
References: <20230817112357.25874-1-hkelam@marvell.com>
        <20230817112357.25874-5-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 16:53:56 +0530 Hariprasad Kelam wrote:
> currently, if any netdev is not mapped to the MAC block(cgx/rpm)
> requests MAC feature, AF driver returns a generic error like -EPERM.
> This patch replaces generic error codes with driver-specific error
> codes for better debugging

The custom error codes are not liked upstream, they make much harder
for people who don't work on the driver to refactor it.

If you want debugging isn't it better to add a tracepoint to the
checks?
-- 
pw-bot: cr
