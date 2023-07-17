Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B333755D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGQHt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGQHtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:49:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D01705
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:49:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0EF636603203;
        Mon, 17 Jul 2023 08:49:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689580148;
        bh=yObxiZcHxzX5TeLYp8bl5WtcJZJkSQMr2izYqJlgGp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GVyJjA7RGvEAWbuj+c3CFXrubnOwMnQxmKAcUDQeJNVknemhAfSMgixQwBdQY8nEo
         IM+kpEyK+FPhKf2VIlEi8+d7K4MwB4E6Wgsg506LTV4VWnXMS8QFXQsmedgOzMLSA7
         pijbQm4F/LB4qnXsW6frQBVEWDhrE0uKH7RISjr7D/PDgXKnxnk12rQpXGtA9UFcRH
         xKbA2Shryh26p4kkE+FnvPAsrTtzOpeArW3M2GAW7YFxeFTH/J+2hI6LHxLi8qy8MJ
         TUC5yf3FGR26NrYY97cmEE0Y3U9ZHZf9DBauy34sEQIMVejPzI5dduuc0kJ9j/JcYO
         9bUcos0QOoQ7g==
Date:   Mon, 17 Jul 2023 09:49:05 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v1] drm/panfrost: Sync IRQ by job's timeout handler
Message-ID: <20230717094905.7a1ee007@collabora.com>
In-Reply-To: <80de081a-e443-85a2-1a61-6a8885e8d529@collabora.com>
References: <20230717065254.1061033-1-dmitry.osipenko@collabora.com>
        <20230717090506.2ded4594@collabora.com>
        <80de081a-e443-85a2-1a61-6a8885e8d529@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 10:20:02 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> Hi,
> 
> On 7/17/23 10:05, Boris Brezillon wrote:
> > Hi Dmitry,
> > 
> > On Mon, 17 Jul 2023 09:52:54 +0300
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >   
> >> Panfrost IRQ handler may stuck for a long time, for example this happens
> >> when there is a bad HDMI connection and HDMI handler takes a long time to
> >> finish processing, holding Panfrost. Make Panfrost's job timeout handler
> >> to sync IRQ before checking fence signal status in order to prevent
> >> spurious job timeouts due to a slow IRQ processing.  
> > 
> > Feels like the problem should be fixed in the HDMI encoder driver
> > instead, so it doesn't stall the whole system when processing its
> > IRQs (use threaded irqs, maybe). I honestly don't think blocking in the
> > job timeout path to flush IRQs is a good strategy.  
> 
> The syncing is necessary to have for correctness regardless of whether
> it's HDMI problem or something else, there could be other reasons for
> CPU to delay IRQ processing. It's wrong to say that hw is hung, while
> it's not.

Well, hardware is effectively hung, if not indefinitely, at least
temporarily. All you do here is block in the timeout handler path
waiting for the GPU interrupt handlers to finish, handler that's
probably waiting in the queue, because the raw HDMI handler is blocking
it somehow. So, in the end, you might just be delaying the time of HWR a
bit more. I know it's not GPU's fault in that case, and the job could
have finished in time if the HDMI encoder hadn't stall the interrupt
handling pipeline, but I'm not sure we should care for that specific
situation. And more importantly, if it took more than 500ms to get a
frame rendered (or, in that case, to get the event that a frame is
rendered), you already lost, so I'm not sure correctness matters:
rendering didn't make it in time, and the watchdog kicked in to try and
unblock the situation. Feels like we're just papering over an HDMI
encoder driver bug here, really.
