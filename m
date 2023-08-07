Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61136771CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjHGJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHGJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:05:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C9E6C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79697616CB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BDAC433C7;
        Mon,  7 Aug 2023 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691399155;
        bh=fYAbQyFmMc0crbh590YcVtXSCCMH0hHpEUhjTAW8ee0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAKRy5KZfQyI5Y6/XPz8LHdkfq/G0dOJwSVTJ3R8NscWNFy7zW9Mjnw491kYiMDhO
         NicewzgKxdM/6tXMnVVEu/gzi0mAsqu8G4zkhzVJt5pBWM0k/ibox86IN+/U5RDFvX
         hCiad1jKJguU7v0kW34AH8N+ReFWFJ7PCQ18jWUQ=
Date:   Mon, 7 Aug 2023 11:05:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v8 6/8] nvmem: core: Rework layouts to become platform
 devices
Message-ID: <2023080704-garage-amused-f18b@gregkh>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
 <20230807082419.38780-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807082419.38780-7-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 10:24:17AM +0200, Miquel Raynal wrote:
> Current layout support was initially written without modules support in
> mind. When the requirement for module support rose, the existing base
> was improved to adopt modularization support, but kind of a design flaw
> was introduced. With the existing implementation, when a storage device
> registers into NVMEM, the core tries to hook a layout (if any) and
> populates its cells immediately. This means, if the hardware description
> expects a layout to be hooked up, but no driver was provided for that,
> the storage medium will fail to probe and try later from
> scratch. Technically, the layouts are more like a "plus" and, even we
> consider that the hardware description shall be correct, we could still
> probe the storage device (especially if it contains the rootfs).
> 
> One way to overcome this situation is to consider the layouts as
> devices, and leverage the existing notifier mechanism. When a new NVMEM
> device is registered, we can:
> - populate its nvmem-layout child, if any
> - try to modprobe the relevant driver, if relevant
> - try to hook the NVMEM device with a layout in the notifier
> And when a new layout is registered:
> - try to hook all the existing NVMEM devices which are not yet hooked to
>   a layout with the new layout
> This way, there is no strong order to enforce, any NVMEM device creation
> or NVMEM layout driver insertion will be observed as a new event which
> may lead to the creation of additional cells, without disturbing the
> probes with costly (and sometimes endless) deferrals.

This is good, but why are you using a platform device here?  Is it a
real platform device, or just a "fake" one you created?  If a fake one,
please don't do that, use a real device, or a virtual device.  Platform
devices should ONLY represent actual, real, platform devices (i.e. ones
descibed by the firmware).

Sorry but I couldn't answer this question by looking at this patch, the
device creation path isn't exactly obvious :)

thanks,

greg k-h
