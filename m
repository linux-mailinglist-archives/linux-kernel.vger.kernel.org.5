Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C47E80F6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376774AbjLLT1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjLLT1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:27:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F8BB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:27:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2394C433CA;
        Tue, 12 Dec 2023 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702409258;
        bh=/cJEqTxk/CbtjQIWxlbZtNd3vqq4MbKnFPuX7Jd+ots=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hqztavui8CRP+Ml4w7lGCsb4/nmAXu2/48mPx4jh+/i4BJt7l4zLWC0D6ROr/ar7u
         lyDGJ4cIH/pL5/IzVGomF+W7N63GoDxlWYd/CPcDV4ahGZeBcNPXV+UxcMVQvMJhTn
         SLQN2nX0L5pXZff0Ro05+kSQ/W24RYNPmunvbrn2LBmZ9fCZr91UOX+MY0wOYlH/Xc
         +Cft2dqwIor0nG8bXnKtdqYEvA/vp00LKNsuSJHGOIqy6A4duP4BcYUJYbSiHXhwQK
         /2RDbOR7wxtNTXNlFaIJuDgzPtwtZ3vDOymgH9zaD7BcKy4Y2hyRPRK8m9QMr8bwfW
         lTlHkzIwX1cRg==
Date:   Tue, 12 Dec 2023 11:27:35 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 03/13] rtase: Implement the rtase_down
 function
Message-ID: <20231212112735.180d455f@kernel.org>
In-Reply-To: <20231208094733.1671296-4-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
        <20231208094733.1671296-4-justinlai0215@realtek.com>
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

On Fri, 8 Dec 2023 17:47:23 +0800 Justin Lai wrote:
> +	netif_stop_queue(dev);

You most likely want to stop the napi before you call this.
Otherwise NAPI can do some clean up and restart the queue.

> +	/* give a racing hard_start_xmit a few cycles to complete */
> +	synchronize_rcu();

Call netif_tx_disable() instead of stop_queue(), it takes the tx lock
so you don't have to worry about in-flight packets.

> +	netif_carrier_off(dev);
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		synchronize_irq(ivec->irq);

Why?

> +		/* wait for any pending NAPI task to complete */
> +		napi_disable(&ivec->napi);
> +	}
