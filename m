Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15BE80AB1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574474AbjLHRsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574421AbjLHRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:48:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E7AD54
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:48:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B6C433C7;
        Fri,  8 Dec 2023 17:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702057715;
        bh=QhXQPyvQgWIfvDkbSx67u+Zj6uEqAYuquxDBwKePCJE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vG3IUgCI7Vl1Ae7jqY3QTraWz66PaiSD+WpG1WvnBrANgyZraJ2iA8SAnKT3INQU1
         LVtpqSYOJ9jbHnCfywwcF7ri2RUAha1/EgX+42PNhDgQRuFRKz3ra0rg1DtBj9H9KJ
         RoNZsIGJ2YbO1TilE2f329bwgtfBR5Lg+IvgWvF0hqn/2yhF5oFSu2vNWsFAk0b/gZ
         rTidktVHR0u7SzSqDA9u7ShRYuFqrCmUFLY6J8SOVqhfrC6mUBoqKWEYdaBAQ9nADl
         6hzrOGEKkLY9HhwOn/M1/P6d9j/R6K2mTpn1xHIzAf+7KIiRibqlj8BlKFQi4kS5ym
         tFNg+JaK/IVqA==
Message-ID: <5752508c-f7bc-44ac-8778-c807b2ee5831@kernel.org>
Date:   Fri, 8 Dec 2023 10:48:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1 06/16] netdev: support binding dma-buf to netdevice
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-7-almasrymina@google.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231208005250.2910004-7-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
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

On 12/7/23 5:52 PM, Mina Almasry wrote:
> +
> +static int netdev_restart_rx_queue(struct net_device *dev, int rxq_idx)
> +{
> +	void *new_mem;
> +	void *old_mem;
> +	int err;
> +
> +	if (!dev || !dev->netdev_ops)
> +		return -EINVAL;
> +
> +	if (!dev->netdev_ops->ndo_queue_stop ||
> +	    !dev->netdev_ops->ndo_queue_mem_free ||
> +	    !dev->netdev_ops->ndo_queue_mem_alloc ||
> +	    !dev->netdev_ops->ndo_queue_start)
> +		return -EOPNOTSUPP;
> +
> +	new_mem = dev->netdev_ops->ndo_queue_mem_alloc(dev, rxq_idx);
> +	if (!new_mem)
> +		return -ENOMEM;
> +
> +	err = dev->netdev_ops->ndo_queue_stop(dev, rxq_idx, &old_mem);
> +	if (err)
> +		goto err_free_new_mem;
> +
> +	err = dev->netdev_ops->ndo_queue_start(dev, rxq_idx, new_mem);
> +	if (err)
> +		goto err_start_queue;
> +
> +	dev->netdev_ops->ndo_queue_mem_free(dev, old_mem);
> +
> +	return 0;
> +
> +err_start_queue:
> +	dev->netdev_ops->ndo_queue_start(dev, rxq_idx, old_mem);
> +
> +err_free_new_mem:
> +	dev->netdev_ops->ndo_queue_mem_free(dev, new_mem);
> +
> +	return err;
> +}
> +
> +/* Protected by rtnl_lock() */
> +static DEFINE_XARRAY_FLAGS(netdev_dmabuf_bindings, XA_FLAGS_ALLOC1);
> +
> +void netdev_unbind_dmabuf(struct netdev_dmabuf_binding *binding)
> +{
> +	struct netdev_rx_queue *rxq;
> +	unsigned long xa_idx;
> +	unsigned int rxq_idx;
> +
> +	if (!binding)
> +		return;
> +
> +	if (binding->list.next)
> +		list_del(&binding->list);
> +
> +	xa_for_each(&binding->bound_rxq_list, xa_idx, rxq) {
> +		if (rxq->binding == binding) {
> +			/* We hold the rtnl_lock while binding/unbinding
> +			 * dma-buf, so we can't race with another thread that
> +			 * is also modifying this value. However, the driver
> +			 * may read this config while it's creating its
> +			 * rx-queues. WRITE_ONCE() here to match the
> +			 * READ_ONCE() in the driver.
> +			 */
> +			WRITE_ONCE(rxq->binding, NULL);
> +
> +			rxq_idx = get_netdev_rx_queue_index(rxq);
> +
> +			netdev_restart_rx_queue(binding->dev, rxq_idx);

Blindly restarting a queue when a dmabuf is heavy handed. If the dmabuf
has no outstanding references (ie., no references in the RxQ), then no
restart is needed.

> +		}
> +	}
> +
> +	xa_erase(&netdev_dmabuf_bindings, binding->id);
> +
> +	netdev_dmabuf_binding_put(binding);
> +}
> +
> +int netdev_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> +				struct netdev_dmabuf_binding *binding)
> +{
> +	struct netdev_rx_queue *rxq;
> +	u32 xa_idx;
> +	int err;
> +
> +	rxq = __netif_get_rx_queue(dev, rxq_idx);
> +
> +	if (rxq->binding)
> +		return -EEXIST;
> +
> +	err = xa_alloc(&binding->bound_rxq_list, &xa_idx, rxq, xa_limit_32b,
> +		       GFP_KERNEL);
> +	if (err)
> +		return err;
> +
> +	/* We hold the rtnl_lock while binding/unbinding dma-buf, so we can't
> +	 * race with another thread that is also modifying this value. However,
> +	 * the driver may read this config while it's creating its * rx-queues.
> +	 * WRITE_ONCE() here to match the READ_ONCE() in the driver.
> +	 */
> +	WRITE_ONCE(rxq->binding, binding);
> +
> +	err = netdev_restart_rx_queue(dev, rxq_idx);

Similarly, here binding a dmabuf to a queue. I was expecting the dmabuf
binding to add entries to the page pool for the queue. If the pool was
previously empty, then maybe the queue needs to be "started" in the
sense of creating with h/w or just pushing buffers into the queue and
moving the pidx.


