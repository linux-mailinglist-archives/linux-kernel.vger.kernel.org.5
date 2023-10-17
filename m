Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8167CBE01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjJQIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:44:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76C8E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:44:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso8298431a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697532285; x=1698137085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr+XWhxVZQc2UIG1oOGf/3IjaQX4b+MsDqjx/mx0qZY=;
        b=rNIDr4Edm8WJhZPyoomuBXa26jzhS1xYVTwABPYHVSuersDeAgWBBs61lcMf7M+ps6
         wgWXbCAbzii9zH8KZpJGLuZPvHy2rzOuKRQj//wIjRCApJd1licO6I6/iwmkeZQTSk86
         RoycsoVe6zcQGd2QY0jlxjXrUrGerzZUm8dkrEU0TuZDB4dbx7L435zCMarxCfEYNwDD
         TPsV8aWBkGLTgDC6xyy3iiCkaIx/OLDTdnutl18vtQbiJoNHKlvWE51/s6z4urbXhMlk
         hTfoF5ERJgUv/KozRxePYiJNZ3gHXqrNEPOImCkkKCOgAaIGmY5ftYMFz+YCfbIxxd5v
         qucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532285; x=1698137085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr+XWhxVZQc2UIG1oOGf/3IjaQX4b+MsDqjx/mx0qZY=;
        b=Se2wJ+Iir52xCOhKrmul6Bns2STdLHUqABd4QdFa0qoJ4u+ryeHmNWvR9VP6Jwf46Y
         5dxoxMN4P73PTFCfB4fxh/NXySevyH9AZgmPGDNhaeC54V+ux8NnIvOKTmdTp/Hi/Qth
         SFFOCKF5TvUglG7aQ2WTRu9t23MFm3qJBkDgGp5xYO6gmVHjl6wwEx+xfjYgAWdwTLV8
         gvIOCEGeimcFTL253yqIZtJEdEb54GD2dmARyHXAe416wmLMaKxrHD49BWqJ6JHAx0TA
         Ee/xuW5xupFUZycUP2qWAcx5NKsWM1CA2JhwiJBw4TQRvp2ivBt9Zv9Wo1C1nZaHeUo8
         plTw==
X-Gm-Message-State: AOJu0YwwMCfg65dU6cbCaKNud0waj00i5FXFxiAVcg90oBvrJHlQ3aqB
        bd5xOiEhmEY8Toc4f0wVCJuwAQ==
X-Google-Smtp-Source: AGHT+IH6pOIFjVQhflt+w9WbmSbqFBEXKKOKOe0WtuRqgl2x66utNIguqDEv4pybgwyguU4qUhn1wA==
X-Received: by 2002:aa7:cb57:0:b0:53e:1388:e056 with SMTP id w23-20020aa7cb57000000b0053e1388e056mr1148059edt.28.1697532284834;
        Tue, 17 Oct 2023 01:44:44 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:8222:872:4a5b:b69c:1318])
        by smtp.gmail.com with ESMTPSA id g26-20020a50d0da000000b00530bc7cf377sm797152edf.12.2023.10.17.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:44:44 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:44:43 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 00/14] can: m_can: Optimizations for m_can/tcan part 2
Message-ID: <20231017084443.ygmpagstzavs276y@blmsp>
References: <20230929141304.3934380-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Fri, Sep 29, 2023 at 04:12:50PM +0200, Markus Schneider-Pargmann wrote:
> Hi Marc, Simon, Martin and everyone,
> 
> v6 is a rebase on v6.6. As there was a conflicting change merged for
> v6.6 which introduced irq polling, I had to modify the patches that
> touch the hrtimer.

Did you have some time to have a look at this series? Anything I should
change?

Thanks!

Best,
Markus

> 
> @Simon: I removed a couple of your reviewed-by tags because of the
> changes.
> 
> @Martin: as the functionality changed, I did not apply your Tested-by
> tag as I may have introduced new bugs with the changes.
> 
> The series implements many small and bigger throughput improvements and
> adds rx/tx coalescing at the end.
> 
> Based on v6.6-rc2. Also available at
> https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.6?ref_type=heads
> 
> Best,
> Markus
> 
> Changes in v6:
> - Rebased to v6.6-rc2
> - Added two small changes for the newly integrated polling feature
> - Reuse the polling hrtimer for coalescing as the timer used for
>   coalescing has a similar purpose as the one for polling. Also polling
>   and coalescing will never be active at the same time.
> 
> Changes in v5:
> - Add back parenthesis in m_can_set_coalesce(). This will make
>   checkpatch unhappy but gcc happy.
> - Remove unused fifo_header variable in m_can_tx_handler().
> - Rebased to v6.5-rc1
> 
> Changes in v4:
> - Create and use struct m_can_fifo_element in m_can_tx_handler
> - Fix memcpy_and_pad to copy the full buffer
> - Fixed a few checkpatch warnings
> - Change putidx to be unsigned
> - Print hard_xmit error only once when TX FIFO is full
> 
> Changes in v3:
> - Remove parenthesis in error messages
> - Use memcpy_and_pad for buffer copy in 'can: m_can: Write transmit
>   header and data in one transaction'.
> - Replace spin_lock with spin_lock_irqsave. I got a report of a
>   interrupt that was calling start_xmit just after the netqueue was
>   woken up before the locked region was exited. spin_lock_irqsave should
>   fix this. I attached the full stack at the end of the mail if someone
>   wants to know.
> - Rebased to v6.3-rc1.
> - Removed tcan4x5x patches from this series.
> 
> Changes in v2:
> - Rebased on v6.2-rc5
> - Fixed missing/broken accounting for non peripheral m_can devices.
> 
> previous versions:
> v1 - https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
> v2 - https://lore.kernel.org/lkml/20230125195059.630377-1-msp@baylibre.com
> v3 - https://lore.kernel.org/lkml/20230315110546.2518305-1-msp@baylibre.com/
> v4 - https://lore.kernel.org/lkml/20230621092350.3130866-1-msp@baylibre.com/
> v5 - https://lore.kernel.org/lkml/20230718075708.958094-1-msp@baylibre.com
> 
> Markus Schneider-Pargmann (14):
>   can: m_can: Start/Cancel polling timer together with interrupts
>   can: m_can: Move hrtimer init to m_can_class_register
>   can: m_can: Write transmit header and data in one transaction
>   can: m_can: Implement receive coalescing
>   can: m_can: Implement transmit coalescing
>   can: m_can: Add rx coalescing ethtool support
>   can: m_can: Add tx coalescing ethtool support
>   can: m_can: Use u32 for putidx
>   can: m_can: Cache tx putidx
>   can: m_can: Use the workqueue as queue
>   can: m_can: Introduce a tx_fifo_in_flight counter
>   can: m_can: Use tx_fifo_in_flight for netif_queue control
>   can: m_can: Implement BQL
>   can: m_can: Implement transmit submission coalescing
> 
>  drivers/net/can/m_can/m_can.c          | 559 ++++++++++++++++++-------
>  drivers/net/can/m_can/m_can.h          |  34 +-
>  drivers/net/can/m_can/m_can_platform.c |   4 -
>  3 files changed, 447 insertions(+), 150 deletions(-)
> 
> 
> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
> -- 
> 2.40.1
> 
