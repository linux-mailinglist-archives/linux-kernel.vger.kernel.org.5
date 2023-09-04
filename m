Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6249D79194A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345605AbjIDOCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjIDOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:02:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4699CD7;
        Mon,  4 Sep 2023 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=iA9dWLzNwmWgeVruKfWYQm9/Fv8+bNUF3EphUHboovM=; b=J/6wblO2pMDEzIC/YsObv6CEKC
        pefWd2u72eNAJUyYSlk71pPSSmj989fSEAAaSScqLgjSolpfXoTRw0Jy/WmZwvaXnOfhzetzRYcRe
        6KhV0Py7LNNKETCrilj3wV4PGA1pZuDUvZhKoWdZyvGJJ3Y1s/EPd1+WDbPjlcqCbOBY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qdA9m-005kBI-9E; Mon, 04 Sep 2023 16:02:22 +0200
Date:   Mon, 4 Sep 2023 16:02:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com
Subject: Re: [RFC PATCH net-next 1/4] net: ti: icssg-prueth: Add helper
 functions to configure FDB
Message-ID: <edfbaf8e-16df-4a25-8647-79b8730dca08@lunn.ch>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-2-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830110847.1219515-2-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
> +		       struct mgmt_cmd_rsp *rsp)
> +{
> +	struct prueth *prueth = emac->prueth;
> +	int slice = prueth_emac_slice(emac);
> +	int i = 10000;
> +	int addr;
> +
> +	addr = icssg_queue_pop(prueth, slice == 0 ?
> +			       ICSSG_CMD_POP_SLICE0 : ICSSG_CMD_POP_SLICE1);
> +	if (addr < 0)
> +		return addr;
> +
> +	/* First 4 bytes have FW owned buffer linking info which should
> +	 * not be touched
> +	 */
> +	memcpy_toio(prueth->shram.va + addr + 4, cmd, sizeof(*cmd));
> +	icssg_queue_push(prueth, slice == 0 ?
> +			 ICSSG_CMD_PUSH_SLICE0 : ICSSG_CMD_PUSH_SLICE1, addr);
> +	while (i--) {
> +		addr = icssg_queue_pop(prueth, slice == 0 ?
> +				       ICSSG_RSP_POP_SLICE0 : ICSSG_RSP_POP_SLICE1);
> +		if (addr < 0) {
> +			usleep_range(1000, 2000);
> +			continue;
> +		}

Please try to make use of include/linux/iopoll.h.

> +	if (i <= 0) {
> +		netdev_err(emac->ndev, "Timedout sending HWQ message\n");
> +		return -EINVAL;

Using iopoll.h will fix this, but -ETIMEDOUT, not -EINVAL.

      Andrew
