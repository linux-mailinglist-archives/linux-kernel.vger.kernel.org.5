Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A17DA758
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjJ1NhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjJ1NhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:37:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD55E5;
        Sat, 28 Oct 2023 06:37:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CD2C433C7;
        Sat, 28 Oct 2023 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698500234;
        bh=5AyITzoVLQwUHHtk9sF0h2RjlIO0I7u9Y5FstB2snsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TwvLP4ZKyVK3qt+mAQGdFv4avg6KANxf+qPcDPHfatSjgISfN29B1pV2J82Lg+yWJ
         Oz+NYhlUmeRE4J+kTpXYbsdvkh0/rknzxDCSY9Etl1M78QpvfGF0VHWl+RRgTtzk6Q
         iZ/FO1OSZH4B9dZ8hqCZ9eF3qtBw6vr8SfIuEUSWGf16B/5LbQ7fJWKXgLN7lfi4VN
         7keIQU1We7Y5BAzt9yrEFG6dsMqMbJysVsEv2wAZErAcvfsNjrWGyOwy0ryoA8+J48
         0ZgJ7LJK7DgugerYLOWzYk+WsGCFduNszC2TN9ITLLo5OWxjDDxEBjRvQIYPZ+pagc
         XCoKPdonGc/tA==
Date:   Sat, 28 Oct 2023 14:36:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20231028143631.2545f93e@jic23-huawei>
In-Reply-To: <ab671f50-7a0f-4e72-98a0-fa4d5f2ed889@tweaklogic.com>
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
        <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
        <d7ba077d-6bcd-4e04-b678-51e4bbc935ca@linaro.org>
        <9e55b561-a0ad-4503-9f20-b7c98507afa0@tweaklogic.com>
        <ebcf3e9f-2bc2-4d91-8b5c-51405236e4ab@linaro.org>
        <ab671f50-7a0f-4e72-98a0-fa4d5f2ed889@tweaklogic.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Fri, 27 Oct 2023 22:12:11 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 27/10/23 21:34, Krzysztof Kozlowski wrote:
> > On 27/10/2023 10:42, Subhajit Ghosh wrote:  
> >> 4. Conor reviewed the patch and said that it would be better that I handle all
> >>      these operations in apds9306 driver (this) patch series rather than submitting
> >>      a new patch.
> >>      "Ahh apologies then. The best course of action would likely be to include
> >>       the patch merging the two bindings in your series adding the third user."
> >> 5. As per this patch series -- RFC->v0->v1-v2  
> > 
> > RFC was the first version sent to mailing list. So after RFC there is
> > second version - v2. This is v4.  
> 
> Acknowledging all your other comments. Appreciate your time and effort in reviewing
> this. One last question on this - So what version should I use for the patchset
> which I will submit next - "v3" or "v5" in the Subject of the emails?
Go with v5 and play it safe given possible confusion.

Numbering when there has previously been one or more RFC versions is always rather
confusing, but we tend not to have a v0!  So RFC-> v1 -> v2 -> V3 would have
been fine in my opinion, or
RFC -> V2 -> v3 
With a note in v2 cover letter saying changes from RFC to make it clear there
was not a separate v1.

Jonathan

> 
> Regards,
> Subhajit Ghosh
> 

