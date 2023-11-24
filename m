Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D727F7AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKXR6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:58:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A0919D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:58:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8522BC433C7;
        Fri, 24 Nov 2023 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700848716;
        bh=LY+9y5MHsF+KtKlVmFalF03dxEUBitUaShH1kcZwyMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxXKU0rap66ZevMPKcQXRiKXP8J2gYakqTq+nJirZkwzxzF7yy+Ptz6gEJhCuhj5K
         FToDAcVdR6P/ccUFnRwU5DJkTLlJXisDEvxzZt3kO6gnYprvRQz9RPvi7grQ+lIK3o
         pGAk9+lTCG8uHj+Yl7awdeqyWcFgmbA+zh2wBCeUocMod1Ie2g2pOgvLHh0URQfs15
         6pVjgQLYfUd/XJndJN+AMgpWOcxaZUSm1j8yreXCKamp69v6Gmt4S/O7/0eMXLURr/
         35gssgI/QUcy96TtBISjX1bxYBv2in8qLIivUrDLfsP7AQ4jVtmMS4+wsBYWWL26yy
         xHIIGc6Vgf9kw==
Date:   Fri, 24 Nov 2023 17:58:30 +0000
From:   Simon Horman <horms@kernel.org>
To:     Elena Salomatkina <elena.salomatkina.cmc@gmail.com>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] octeontx2-af: Fix possible buffer overflow
Message-ID: <20231124175830.GV50352@kernel.org>
References: <20231123173630.32919-1-elena.salomatkina.cmc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123173630.32919-1-elena.salomatkina.cmc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 08:36:30PM +0300, Elena Salomatkina wrote:
> A loop in rvu_mbox_handler_nix_bandprof_free() contains
> a break if (idx == MAX_BANDPROF_PER_PFFUNC),
> but if idx may reach MAX_BANDPROF_PER_PFFUNC
> buffer '(*req->prof_idx)[layer]' overflow happens before that check.
> 
> The patch moves the break to the
> beginning of the loop.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e8e095b3b370 ("octeontx2-af: cn10k: Bandwidth profiles config support").
> Signed-off-by: Elena Salomatkina <elena.salomatkina.cmc@gmail.com>

Thanks Elena,

I agree with your analysis and that this seems to be
an appropriate fix for the problem.

As this is a fix, it should be targeted at the net, as opposed to net-next,
tree.  Please keep this in mind for future patch submissions.

	Subject: [PATCH net] ...

Link https://docs.kernel.org/process/maintainer-netdev.html

The above nit notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>
