Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225C7EB94D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjKNWZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKNWZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:25:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC2BE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:25:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CFC433C7;
        Tue, 14 Nov 2023 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700000736;
        bh=CmbeBBJW6eNCnDWG7XFbzoz+Cww0cN4u7zfWKAxDRDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fURdyQnSVpbf5t99V71LcNGLgelOR6R2rlvm4Ps4Y94iRNSdGks4P+r39GuN8prsE
         SnwMYYPOcrMFzpgeZv5zPIx0DGuPNU0m4yZsJZH7GJ/3OycmmbUSdySaqA5cQpDsf1
         54YN7mHw2Ctl2/qxN2x6uury/PSVoI5x19U6FVTmQOnITzYzOfTAjI1MJiWNYaUNMx
         9N65IAi9cn+VznLN7nGXUZ/T5Xc/ufmD18N7dZH/ZWpRsySs1vJ06WkrIbw+Ea+hXA
         W2fV1SIKoKukwV8p6nFWFUwpDBuYf+L05OTkqLy9/75bseMChSyXwYbsZ51VS2y8Ra
         8b2fSnaLiENmg==
Date:   Tue, 14 Nov 2023 17:25:34 -0500
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Message-ID: <20231114172534.124f544c@kernel.org>
In-Reply-To: <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
        <20231113130041.58124-4-linyunsheng@huawei.com>
        <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
        <20231113180554.1d1c6b1a@kernel.org>
        <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
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

On Tue, 14 Nov 2023 16:23:29 +0800 Yunsheng Lin wrote:
> I would expect net stack, page pool, driver still see the 'struct page',
> only memory provider see the specific struct for itself, for the above,
> devmem memory provider sees the 'struct page_pool_iov'.

You can't lie to the driver that an _iov is a page either.
The driver must explicitly "opt-in" to using the _iov variant,
by calling the _iov set of APIs.

Only drivers which can support header-data split can reasonably
use the _iov API, for data pages.
