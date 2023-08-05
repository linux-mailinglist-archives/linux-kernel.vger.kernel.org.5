Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A255771218
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjHEUZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHEUZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:25:01 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7B513E;
        Sat,  5 Aug 2023 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=dNu2egnhMUuwuP0JymsvaeCUIB7L8YRoiDijl0XGqF4=; b=1bIGNScm0IlJWgpkYH1OZiiSSD
        uHkr6jYSWQ5cc3wxwc1OdW+tKzWVw1aYJr/qO0+4yBJ+eG/TKtZMchreUC63QrMnYOqh5wjNate88
        Iqffy5k7Xm5gMKqojm+G4Z4okBjK1iIjdgyGu0bPyz3bSZ0IgPK4CR3fmqraKDsaPO3I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qSNp9-003DAy-Il; Sat, 05 Aug 2023 22:24:31 +0200
Date:   Sat, 5 Aug 2023 22:24:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthew Cover <werekraken@gmail.com>
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthew Cover <matthew.cover@stackpath.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net-next] Add bnxt_netlink to facilitate representor pair
 configurations.
Message-ID: <3987add6-4928-4cd9-9fe6-a232f202ecc6@lunn.ch>
References: <20230804212954.98868-1-matthew.cover@stackpath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804212954.98868-1-matthew.cover@stackpath.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 02:29:54PM -0700, Matthew Cover wrote:
> To leverage the SmartNIC capabilities available in Broadcom
> NetXtreme-C/E ethernet devices, representor pairs must be configured
> via bnxt-ctl

Could you give a link to the bnxt-ctl sources. Also give a brief
description of what they do. 

> @@ -0,0 +1,231 @@
> +/* Broadcom NetXtreme-C/E network driver.
> + *
> + * Copyright (c) 2014-2016 Broadcom Corporation
> + * Copyright (c) 2016-2017 Broadcom Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation.

Please remove the license boilerplate and use a SPDX-License-Identifier.

> + */
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +#include "bnxt_hsi.h"
> +#include "bnxt_netlink.h"
> +#include "bnxt.h"
> +#include "bnxt_hwrm.h"
> +
> +/* attribute policy */
> +static struct nla_policy bnxt_netlink_policy[BNXT_NUM_ATTRS] = {
> +	[BNXT_ATTR_PID] = { .type = NLA_U32 },
> +	[BNXT_ATTR_IF_INDEX] = { .type = NLA_U32 },
> +	[BNXT_ATTR_REQUEST] = { .type = NLA_BINARY },
> +	[BNXT_ATTR_RESPONSE] = { .type = NLA_BINARY },

Passing binary blobs from user space to firmware will not be
accepted. You need well defined and documented individual commands.


    Andrew

---
pw-bot: cr
