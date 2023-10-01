Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16807B475E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjJAMXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjJAMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:23:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F389E;
        Sun,  1 Oct 2023 05:23:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68F6C433C8;
        Sun,  1 Oct 2023 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696163001;
        bh=cw7CS63l0RAvgmBKjdZgE6Zr9SOJsQukYNn5TfNmzr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8YO6GTkfcj4JiT/lH4zt0qDUd2lojUD8TpeAx+1zp7uWa9ifFLdGKzh7y1z6lhsW
         CDk08CMgP+W9YzEAGGKPzJHTsrBor8YENr+PsefYeTUusTDE1ln4Kx4o0/D8LlrZUE
         a7kxz+bseGR8Gf+mW8ZgDIcCu57ht0VFowX4cLurZvtvuXeU3oc3ku32I2I1KeGJdb
         HEO6YDCSeRJ2a3f3xBJ1W2tc8fNDyxmeir8lGm9rMXJdK8jYt+0Fxsd+gBnniSgZX4
         g7Qs4SLCDj4AopzW/FqrxBPbsWb0WRWUwbA/YsbMGchSFPXt2EMvvbTUKmJlZezEku
         vbbH09vxKxuuw==
Date:   Sun, 1 Oct 2023 14:23:16 +0200
From:   Simon Horman <horms@kernel.org>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 04/14] can: m_can: Implement receive coalescing
Message-ID: <20231001122316.GL92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-5-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-5-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:12:54PM +0200, Markus Schneider-Pargmann wrote:
> m_can offers the possibility to set an interrupt on reaching a watermark
> level in the receive FIFO. This can be used to implement coalescing.
> Unfortunately there is no hardware timeout available to trigger an
> interrupt if only a few messages were received within a given time. To
> solve this I am using a hrtimer to wake up the irq thread after x
> microseconds.
> 
> The timer is always started if receive coalescing is enabled and new
> received frames were available during an interrupt. The timer is stopped
> if during a interrupt handling no new data was available.
> 
> If the timer is started the new item interrupt is disabled and the
> watermark interrupt takes over. If the timer is not started again, the
> new item interrupt is enabled again, notifying the handler about every
> new item received.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>

