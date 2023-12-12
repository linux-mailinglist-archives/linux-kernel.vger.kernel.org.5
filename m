Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB480F655
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377239AbjLLTOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377301AbjLLTOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:14:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B246129
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:14:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B19FC433C7;
        Tue, 12 Dec 2023 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408452;
        bh=jfJ0OG1jhC1TwOyrhyKpWYMGrNHXhy6qAspQp8BrzWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9gl44nTCJgaqnzRkDIohjT3NlWPJJa/xDes26AfFQfmtNc2cfCuCd70WURIpsEls
         vTZdu0MOZxt7XB2RoDt3NiKq0uZ0e5XZ9uNAJvt20SeYNL3Xnev1VOWhSDgT1cLHKO
         UzAbw2cpbggtF8AKB+xIzHnQW+N3E8y0VN03Sx8xuf6xSXbWBlqTx0DkvlJGiyTCHv
         Pn9XBi+4REFO/1aggIX1ADNZxAcOPZjzUtdYPvmGKd9kwXCW92/oirZULVxo77Eat3
         6uRKCSS5S1kMdmbIvOp4MFWEThbL6iJKtUsHbQc5uHQLX7S+inbhcpAYL5tX1R7y0R
         68pLVmdZZ2tDg==
Date:   Tue, 12 Dec 2023 19:14:04 +0000
From:   Simon Horman <horms@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [net-next v1 15/16] net: add devmem TCP documentation
Message-ID: <20231212191404.GC5817@kernel.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-16-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208005250.2910004-16-almasrymina@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 04:52:46PM -0800, Mina Almasry wrote:
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  Documentation/networking/devmem.rst | 270 ++++++++++++++++++++++++++++
>  1 file changed, 270 insertions(+)
>  create mode 100644 Documentation/networking/devmem.rst
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> new file mode 100644
> index 000000000000..ed0d9c88b708
> --- /dev/null
> +++ b/Documentation/networking/devmem.rst
> @@ -0,0 +1,270 @@

Hi Mina,

Please consider adding an SPDX header here.

And please consider adding devmem to index.rxt,
as make htmldocs currently warns:

  .../devmem.rst: WARNING: document isn't included in any toctree

....
