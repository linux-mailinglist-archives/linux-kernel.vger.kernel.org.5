Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD580B0BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjLHX7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHX7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:59:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5BA171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 15:59:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE0EC433C8;
        Fri,  8 Dec 2023 23:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702079998;
        bh=UPg58Wz4ucBYZ9XevepIP3YycirRFgd2o4l6zt7Cie4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KK36Iq+aUSmr22DZbRxU01OqgemLY363GzmXTA1sCeNK846Ngp12J9t7PPwH4d+EA
         Ayyty3Q+dCNrPFP9uzTTBMFHGVPslApVSlZ3xcGbzDXjtRkrjFoV0FPPQPa6az348T
         a34naOwCGERAoBfyD7RPDtQb7iarcXQhYN0Mzck85XB6I4HQNzZW8XDuWI8xYJSWFx
         XiDzaPGlQFX+/HkDKYuJ9+BvmfksLw1y+CA4NqNXP1ABhGfmHvDYfyO9yDQTWhFFvU
         SH3ZkKGvxF1MGTKcz6D4aecCRhoCKfWD7aHjl/5x/inFrrdmzUtKpsAqi54bs6ccrb
         zuaRssr5F4Mtw==
Date:   Fri, 8 Dec 2023 15:59:57 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] qed: Fix a potential use-after-free in
 qed_cxt_tables_alloc
Message-ID: <20231208155957.088c372b@kernel.org>
In-Reply-To: <20231207093606.17868-1-dinghao.liu@zju.edu.cn>
References: <20231207093606.17868-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 17:36:06 +0800 Dinghao Liu wrote:
> v2: -Change the bug type from double-free to use-after-free.
>     -Move the null check against p_mngr->ilt_shadow to the beginning
>      of the function qed_ilt_shadow_free().
>     -When kcalloc() fails in qed_ilt_shadow_alloc(), just return
>      because there is nothing to free.

This refactoring is not acceptable as part of a fix, sorry.

> @@ -933,6 +936,7 @@ static void qed_ilt_shadow_free(struct qed_hwfn *p_hwfn)
>  		p_dma->virt_addr = NULL;
>  	}
>  	kfree(p_mngr->ilt_shadow);
> +	p_hwfn->p_cxt_mngr->ilt_shadow = NULL;

Why do you dereference p_hwfn here?
Seems more natural to use:

	p_mngr->ilt_shadow = NULL;

since that's the exact pointer that was passed to free.
-- 
pw-bot: cr
