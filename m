Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEF27F2888
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjKUJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:17:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06810C1;
        Tue, 21 Nov 2023 01:17:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96403C433C7;
        Tue, 21 Nov 2023 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558262;
        bh=KiJ/ru65Ua8lo4s4fh4OjLQfr8e6MLSoBb/RDxWensY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EY9G3e//vJF7k13VmW76Yg4tqo4bYwC2YfDojOjvxuSr9VIw4idRrZhBvYcNt5EFP
         SHaFaNcHn3iQA/LpGwavpXPMJMW19y14mBeHfC8DLz/r8WAZBA3w6hBwEMwd3H3qVh
         9ZKHx6kkjJ81fj5Dj5azu2nLiIaxaSeFlZWd9KFEosC8kjJPW6B3C9xuKYC8b3ETnh
         VcyG/gcTVUImvNkZpZx881dhtUmhnH6cnWL+a5f/U4Q6n0otk6WOinYAZyvLu79cqT
         +NdLMfiSgo7tuW7fllRQflnxVNvgMN2UX85GgfSolv6r7erH4kW+9Bux8cWc3ECHPp
         SjA5WXIvgy4LQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5MtF-00047b-1C;
        Tue, 21 Nov 2023 10:17:53 +0100
Date:   Tue, 21 Nov 2023 10:17:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/3] USB: dwc3: qcom: fix wakeup after probe deferral
Message-ID: <ZVx1wRefjNaN0byk@hovoldconsulting.com>
References: <20231120161607.7405-1-johan+linaro@kernel.org>
 <20231120161607.7405-3-johan+linaro@kernel.org>
 <pgmtla6j3dshuq5zdxstszbkkssxcthtzelv2etcbrlstdw4nu@wixz6v5dfpum>
 <3ff65t36p6n3k7faw2z75t2vfi6rb5p64x7wqosetsksbhhwli@5xaxnm7zz4tu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ff65t36p6n3k7faw2z75t2vfi6rb5p64x7wqosetsksbhhwli@5xaxnm7zz4tu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 02:50:52PM -0600, Andrew Halaney wrote:
> On Mon, Nov 20, 2023 at 11:39:07AM -0600, Andrew Halaney wrote:
> > On Mon, Nov 20, 2023 at 05:16:06PM +0100, Johan Hovold wrote:
> > > The Qualcomm glue driver is overriding the interrupt trigger types
> > > defined by firmware when requesting the wakeup interrupts during probe.
> > > 
> > > This can lead to a failure to map the DP/DM wakeup interrupts after a
> > > probe deferral as the firmware defined trigger types do not match the
> > > type used for the initial mapping:
> > > 
> > > 	irq: type mismatch, failed to map hwirq-14 for interrupt-controller@b220000!
> > > 	irq: type mismatch, failed to map hwirq-15 for interrupt-controller@b220000!
> > > 
> > > Fix this by not overriding the firmware provided trigger types when
> > > requesting the wakeup interrupts.
> > 
> > This series looks good to me and makes sense except for one point that
> > I'm struggling to understand. What exactly is the relationship with this
> > failure and probe deferral?
> 
> Eric Chanudet pointed out to me (thanks!) offlist that if you:
> 
>     1. Probe
>     2. Grab the IRQ
>     3. Request it (and muck with the trigger from the firmware default)
>     4. Defer out
>     5. Reprobe
>     6. Grab the IRQ again
> 
> You get that error, which I played with some this afternoon...
> and can confirm.
> 
> It really seems like maybe we should consider reworking messing with the
> trigger type at all (which is done later for runtime/system suspend)
> in a follow-up series?
> 
> As far as I can tell if you were to remove the driver and reprobe after
> a suspend you'd hit similar.

Correct, but people don't go around unloading modules (unlike probe
deferral which anyone can hit). It's a development (debugging) feature
so there being some corner cases are not that big of a deal.

> I've been sitting here scratching my head a
> bit trying to reason out why keeping it as IRQ_TYPE_EDGE_BOTH isn't
> acceptable in dwc3_qcom_enable_interrupts()... Correct me if you think
> that playing with the trigger there is really ok, but it seems like you
> run the same risks if you do that and then modprobe -r dwc3-qcom.

Changing the trigger type during runtime depending on use-case should be
fine. It just doesn't play well with the kernel's interrupt mapping
code, which assumes that if an interrupt already has a mapping then it
is a shared interrupt.

I considered addressing that in the core code, but yeah, I don't want
too much time since the remaining issue only affects module unload and
there are other ways to avoid that issue too.

> I get that dwc3_qcom_enable_interrupts() limits the scope of what wakes us
> up to what we expect given the current device (or lack thereof), but it
> doesn't seem like you're really meant to play with the IRQ triggers,
> or at least the warning you shared makes me think it is not a great idea
> if you plan to probe the device ever again in the future.
> 
> I'll post the current comment in dwc3_qcom_enable_interrupts() to
> explain the "limits the scope of what wakes us up" a bit more clearly:
> 
> 	/*
> 	 * Configure DP/DM line interrupts based on the USB2 device attached to
> 	 * the root hub port. When HS/FS device is connected, configure the DP line
> 	 * as falling edge to detect both disconnect and remote wakeup scenarios. When
> 	 * LS device is connected, configure DM line as falling edge to detect both
> 	 * disconnect and remote wakeup. When no device is connected, configure both
> 	 * DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
> 	 */

Yes, that is how it is currently implemented and I intend to change that
shortly. I just wanted to get the fixes out first.

Specifically, I consider the current implementation to be broken in that
it generates wakeup events on disconnect which is generally not want you
want. Consider closing the lid of your laptop and disconnecting a USB
mouse before putting it in your backpack. Now it's no longer suspended
as you would expect it to be.

With the devictrees soon fixed, we could also do away with changing the
trigger type, but since this is how it was implemented initially we now
need to consider backward compatibility with the broken DTs. We've dealt
with that before, but yeah, getting things right from the start would
have been so much better.

Johan
