Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9825976BFB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjHAV5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjHAV52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:57:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA1212C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F2206173E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21991C433C8;
        Tue,  1 Aug 2023 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690927044;
        bh=1zkqubEp693ty9VDXEnLFMNBXktoPzOqeY6em4mcsBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mSJmmFwTIK1f3qjDv2+Be05QntUSJk3XdeJZV0zBsLuNLIECiDpRKr7K5o1y7Xa1M
         dBWUQAa7dpGZ461KXdxHBBMyfRq20Hzwl8koKlYxZnazkorzpDP5RGhXOlHNkaMki7
         yujhhJupHhv38SRstlQ0L7adI0sp6DPnvWPk2hqlScYcW276A/wOv2F6DfW8EAYUBH
         fIkp6xDwBFCZ9u1deCxGl5txyHchxyuTQUaCgnPRVoxG3jaWGqwij/51NMIYjVK2GG
         o7CfvTKVSbR3nHzEGADMzx9H2QIN9CLFgmcVNEI/OvLfJo8IUr04MSFWrBr8Ijh8a/
         8m/NSlh8Lw3ww==
Date:   Tue, 1 Aug 2023 14:57:23 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230801145723.7ddc2dba@kernel.org>
In-Reply-To: <20230731060025.3117343-1-wei.fang@nxp.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 14:00:25 +0800 Wei Fang wrote:
>  	case XDP_TX:
> +		err = fec_enet_xdp_tx_xmit(fep->netdev, xdp);
> +		if (err) {
> +			ret = FEC_ENET_XDP_CONSUMED;
> +			page = virt_to_head_page(xdp->data);
> +			page_pool_put_page(rxq->page_pool, page, sync, true);

The error path should call trace_xdp_exception().
-- 
pw-bot: cr
