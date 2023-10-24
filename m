Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FFC7D4572
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjJXCYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXCYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:24:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7317CC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:24:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8A9C433C7;
        Tue, 24 Oct 2023 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698114276;
        bh=b07IW6onHHyGfMZgKFIvnNFhOtkZkOOgJ9t2POWbmRs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oy3/JmEHd9Z4kheIA9EKM6UApScmCdcCisvBFeijpylMGB9icb/ybF52szjNEsFNK
         BsDsG6dV6iarpwc9ZpoPPBdwWYgB41lj5TEae4bLE8kbQEcHkip9FzEN+b4KLUPeNi
         i/7kjU2HPzxUEnOtIVHsNSjxXqYT2aqUe0rZg7IWJjhpVtiGthUOTgkYhdBN5UcnZv
         CYMNlJRywkXhSd7ef0W1v2d8kqo/XIiSKIOQfYCIuiU88NDnmL9ZDP0q6HfH/XS1NA
         h+J821kmQdxrA/lY5pS3jvkT49rmvS8t0X1TMWLmV2TK+lFExT0LGsNX76dS73YFZv
         5h2gbbKLSqDZA==
Date:   Mon, 23 Oct 2023 19:24:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v12 0/5] introduce page_pool_alloc() related
 API
Message-ID: <20231023192434.40f5ee98@kernel.org>
In-Reply-To: <20231020095952.11055-1-linyunsheng@huawei.com>
References: <20231020095952.11055-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 17:59:47 +0800 Yunsheng Lin wrote:
> In [1] & [2] & [3], there are usecases for veth and virtio_net
> to use frag support in page pool to reduce memory usage, and it
> may request different frag size depending on the head/tail
> room space for xdp_frame/shinfo and mtu/packet size. When the
> requested frag size is large enough that a single page can not
> be split into more than one frag, using frag support only have
> performance penalty because of the extra frag count handling
> for frag support.
> 
> So this patchset provides a page pool API for the driver to
> allocate memory with least memory utilization and performance
> penalty when it doesn't know the size of memory it need
> beforehand.

I don't mean to cut off the discussion, if any is still to happen.
But AFAIU we have a general agreement that this is a good direction,
we're at v12 already, and it's getting late in the release cycle.
To give this series a chance of making v6.7 I will apply it now.
If there are any unresolved concerns in a couple of days we can drop it.
