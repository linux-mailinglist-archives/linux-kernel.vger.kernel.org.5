Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B6B80872A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379111AbjLGL5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjLGL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:57:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07231D4A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:57:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DB6C433C8;
        Thu,  7 Dec 2023 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701950276;
        bh=ZadLVg2xVw24qHq11LzSKHwhUbpz7A2+VUUzqsY+gLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4JRmYPDzmJcuIpWDoFr/AgUuC/LimYiBWcKw4SKa/rIIAtvW5457js1EIRnSAKp9
         oiaGYfk70CtpyYTBw7P9x+5nAzh8+51Ivyiep0AfKrmW2Ww+vIRA8i6a0rtKk3weII
         o+wouwc0EAcKUT2uFS0BbXEm0oLi8+yTfqEBSPcHVKvp0TBzTatvJnyQkTFJsHDZbF
         xHeb6fw4PLDs0XjSz73zpfC5U4skvJPyA4sKyyFciJECWNNLeAmY2NZ28yHa/wwV2j
         gky0Np8hxDExwZzEjtV/D0cvI8PYHhAobsq0ipFtKJxLs4lGyDG49/GfnvnDYedEEg
         VsCQ/2YvkuYgw==
Date:   Thu, 7 Dec 2023 11:57:51 +0000
From:   Simon Horman <horms@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org,
        Michal Kubiak <michal.kubiak@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl] idpf: fix corrupted frames and skb leaks in singleq
 mode
Message-ID: <20231207115751.GG50400@kernel.org>
References: <20231201143821.1091005-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201143821.1091005-1-aleksander.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:38:21PM +0100, Alexander Lobakin wrote:
> idpf_ring::skb serves only for keeping an incomplete frame between
> several NAPI Rx polling cycles, as one cycle may end up before
> processing the end of packet descriptor. The pointer is taken from
> the ring onto the stack before entering the loop and gets written
> there after the loop exits. When inside the loop, only the onstack
> pointer is used.
> For some reason, the logics is broken in the singleq mode, where the
> pointer is taken from the ring each iteration. This means that if a
> frame got fragmented into several descriptors, each fragment will have
> its own skb, but only the last one will be passed up the stack
> (containing garbage), leaving the rest leaked.
> Just don't touch the ring skb field inside the polling loop, letting
> the onstack skb pointer work as expected: build a new skb if it's the
> first frame descriptor and attach a frag otherwise.
> 
> Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

