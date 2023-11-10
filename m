Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA897E8665
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbjKJXQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjKJXQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:16:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DDA125
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:16:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BE0C433C7;
        Fri, 10 Nov 2023 23:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699658174;
        bh=fIaDoeAJ5wEfd3OqiFmAviiP1M+nZrBz6caAN+IfwHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uKGnaQ8aeJx2XbhW1g+57sxckv/co5/lbVNdOgEwSz1N4reK/MBR/a2xSiC3RWOqB
         JUf8rwg+LznxWD/D05rUgWqp79yZ5J24OYnBeNQ80xF1NgW8XnRrZ49vpYgv0B5fhn
         YPwumFdi6/7Yx+B6iaK9vYj/3KWLgB4Yrui79+OAZxGfS6HTp6VojG8O1lUksc4NUE
         B+lBm+9udQDqEM5gJ2Kc4WhGDwrZ+sVjwJ3+Jdvi5wAnmHXha2L0ZRVfLgR5Mt6/F7
         NjlU/YhswwRu9H6tlY2W8scb81qY1j0UQ6J8URn3XvrJgCr2QAdIjXF11rw+yvn/B8
         E4z+bIfKpc6Ww==
Date:   Fri, 10 Nov 2023 15:16:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
Message-ID: <20231110151612.3dcca11d@kernel.org>
In-Reply-To: <3a1b5412bee202affc6a7cc74cd939e182b9a18e.camel@redhat.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-11-almasrymina@google.com>
        <ZUk0FGuJ28s1d9OX@google.com>
        <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
        <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
        <ZUlp8XutSAScKs_0@google.com>
        <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
        <3a1b5412bee202affc6a7cc74cd939e182b9a18e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2023 12:05:37 +0100 Paolo Abeni wrote:
> > I suppose we just disagree on the elegance of the API.
> 
> FWIW, I think sockopt +cmsg is the right API.

FWIW it's fine by me as well.
