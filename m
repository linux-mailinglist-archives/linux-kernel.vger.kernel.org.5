Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0157F963D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjKZWyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:54:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74301E4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:54:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C52C433C7;
        Sun, 26 Nov 2023 22:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701039299;
        bh=ikD1IcWn7pY0Kg0l7nVoix086nkdC/HUPPp5zrf1b4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJJu32y9fKFumvgnuECyyu2TS9UMK5Ap6sAmKlCfNCIG1Ao17kQtALBfEDRHWruyO
         DySl8NfRpcr0kz1FfH4ylkBz9WhCBgh1+yrcz1LlzRXqi0F9fbuqKnm0Y0EkefUhBv
         +BlB1H8xSLp75zBwmJO7XbcyVO3eU+mrChAMiPaESALpb0qMwVpHK4if+s/SYfXFhh
         z5cka8YmKQ06Ep6beWWA8c//zo/sCaoGMbvkO8tsW5erj/DaDz8pZtydLkcg8wYb2O
         CuVWAF09Fi9PHhwx4TTHQM/mIoGXhKf0+nUBa0QWRwhdql1pBW2d92lF+pfo0q6CYZ
         pehRSiZD2QmSQ==
Date:   Sun, 26 Nov 2023 14:54:57 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/14] page_pool: make sure frag API fields
 don't span between cachelines
Message-ID: <20231126145457.400726e4@kernel.org>
In-Reply-To: <20231124154732.1623518-2-aleksander.lobakin@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
        <20231124154732.1623518-2-aleksander.lobakin@intel.com>
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

On Fri, 24 Nov 2023 16:47:19 +0100 Alexander Lobakin wrote:
> -	long frag_users;
> +	long frag_users __aligned(4 * sizeof(long));

A comment for the somewhat unusual alignment size would be good.
