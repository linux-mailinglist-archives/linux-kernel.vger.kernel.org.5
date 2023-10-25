Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49377D5F04
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbjJYAV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbjJYAV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:21:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809C118
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:21:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CEFC433C7;
        Wed, 25 Oct 2023 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698193312;
        bh=bSb6lFJWhOO+xj/NDMEeOkBFoXydyY6bxf7XMv2ArVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NjxOhjtwoKdQ3UgCoeY/58mRDR40YFwMjdJFTvXp8v3ZwzkpUSTo3371ZEgcQ/MD3
         g7fVYkajpSDQK9il3+2Lv3bO6Bc5iNUZs/joAZY/06zhS/nXgqb2vHQBhbCPRFhjsi
         BYNPM6nexCdjqmwlTY7cgBU2h9SzEu6MwpHfpmR0/T2HMGRpzUQnsw0NQhxaBnnN7L
         2xq/yXV+N35C6I7d6ZwT3Od/hqLfZRB1Sum41gCz8uN6o5ZpuOF1xthJVkOmhObt2/
         XaEhON5dyV4l9JSxY97k0wrGNZdnvsak4F8KCa4AsR6IrX5jrJjmiTVgoG8NQwdzgz
         a+mUugyhSxphA==
Date:   Tue, 24 Oct 2023 17:21:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more in
 transmit
Message-ID: <20231024172151.5fd1b29a@kernel.org>
In-Reply-To: <20231024145119.2366588-4-srasheed@marvell.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
        <20231024145119.2366588-4-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 07:51:18 -0700 Shinas Rasheed wrote:
>  	iq->host_write_index = wi;
> +	if (xmit_more &&
> +	    (atomic_read(&iq->instr_pending) <
> +	     (iq->max_count - OCTEP_WAKE_QUEUE_THRESHOLD)) &&
> +	    iq->fill_cnt < iq->fill_threshold)
> +		return NETDEV_TX_OK;

Does this guarantee that a full-sized skb can be accommodated?
If so - consider stopping stopping the queue when the condition
is not true. The recommended way of implementing 'driver flow control'
is to stop the queue once next packet may not fit, and then use
netif_xmit_stopped() when deciding whether we need to flush or we can
trust xmit_more. see 
https://www.kernel.org/doc/html/next/networking/driver.html#transmit-path-guidelines

>  	/* Flush the hw descriptor before writing to doorbell */
>  	wmb();
> -
> -	/* Ring Doorbell to notify the NIC there is a new packet */
> -	writel(1, iq->doorbell_reg);
> -	iq->stats.instr_posted++;
> +	/* Ring Doorbell to notify the NIC of new packets */
> +	writel(iq->fill_cnt, iq->doorbell_reg);
> +	iq->stats.instr_posted += iq->fill_cnt;
> +	iq->fill_cnt = 0;
>  	return NETDEV_TX_OK;
