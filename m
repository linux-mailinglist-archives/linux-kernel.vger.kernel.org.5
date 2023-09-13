Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64079E7CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbjIMMUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:20:29 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B579519A8;
        Wed, 13 Sep 2023 05:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=9fjohWWyeQwCPIoP4ypoYm41HAX/BcH8sWQeNzqML3s=; b=tO6wyliQMAg4HHakrUy4uugtK8
        0pr0AC+xQRdcusx7kPBY09WkFgvz4bXZHUcJ8QT6OMnd3IdMci0otVUK+Bo0JxJDfH73F+8kjvJ8C
        v5OrXwRktbaKnvhjJR5+rHgu8BPO6m06kPrx5u5m6RjiDeiC4AaACEkTrmbHSOBMmCus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgOqb-006Iux-2J; Wed, 13 Sep 2023 14:19:57 +0200
Date:   Wed, 13 Sep 2023 14:19:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, Pekka Varis <p-varis@ti.com>
Subject: Re: [RFC PATCH net-next 3/4] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware on AM654 PG2.0 EVM
Message-ID: <055e781e-f614-4436-9d8d-e60e17fac5c9@lunn.ch>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-4-danishanwar@ti.com>
 <1fb683f4-d762-427b-98b7-8567ca1f797c@lunn.ch>
 <0d70cebf-8fd0-cf04-ccc2-6f240b27ecca@ti.com>
 <12c11462-5449-b100-5f92-f66c775237fa@kernel.org>
 <3fbf9514-8f9f-d362-9006-1fd435540e67@ti.com>
 <09931a97-df62-9803-967f-df6135dc3be7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09931a97-df62-9803-967f-df6135dc3be7@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As discussed on this thread, switching operation can work with the ICSSG
> switch firmware, without creating bridge. However without bridge only
> forwarding works. If we want the switch to consume packets bridge is
> required.

What packets will the switch consume? The only packets i can think of
are pause frames. Everything else get passed to the CPU.

You also need to think of what happens when a single switch port is
added to the bridge, and an external port, like a tun/tap device for a
VPN is added to the bridge.

For most switches, a port not being a member of a switch means the
port is pretty dumb and every frame is forwarded to the CPU. There are
however some switches which perform address learning as usual,
learning if an address is on the port, or on the CPU. Maybe you can
see if that is possible.

It might be you need your firmware people involved to produce a new
firmware version which combines both firmwares in one.

	 Andrew
