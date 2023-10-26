Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFE7D809D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjJZKVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:21:51 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAF9183;
        Thu, 26 Oct 2023 03:21:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7965AE000C;
        Thu, 26 Oct 2023 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698315706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGcZNXbWjy+iksWtqqJpAf6k6WVn04EIPNKOTg5UZUc=;
        b=Pkwrrz23POBOjesBMT1sSYR9fFmwNbamTDO7MR+WlTut6bzE/Pp4qMKH/N1T+p5R5hYwU4
        JgMPNXnd3Kw9EhTqcqd3lm0uG1EWFt+GzsHEwiN7Rf/aHw8/ijSToYg2y/hh3eOZZenaw0
        sa50XlY4/6Bsvn2rjv1/JNyXZw7/kinL92rLyD+V6xOMUqfD0LypvdU7u2ZtqPSl+ok9Fs
        +9mqCv5PY348oo9fufW6ySoa8hUtIDxUg0wZM/Xx/yRwNlk0uk9NXDdvPirJ6ExPK86Byf
        DS8Atf9WpyhFJGZlK/xc47v1PfGIvGanZzOUobEYVxbjaLRnDzOUSoCI/DsUAg==
Date:   Thu, 26 Oct 2023 12:21:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add hiz-output
 property
Message-ID: <202310261021467b56f131@mail.local>
References: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
 <20231024-topic-pcf85363_hiz_output-v1-2-50908aff0e52@wolfvision.net>
 <20231025222327c0b5d460@mail.local>
 <2f17c031-30f6-4242-b2a1-1628402b3091@wolfvision.net>
 <1c4a6185-fe09-45d1-900a-10abf48e3fc9@wolfvision.net>
 <20231026005008b8255799@mail.local>
 <8fec6c89-548b-43b5-8361-869663a58573@wolfvision.net>
 <202310260956166bdcb845@mail.local>
 <d3dcb034-f589-41bb-8a67-1de8ce51db8c@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3dcb034-f589-41bb-8a67-1de8ce51db8c@wolfvision.net>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 12:13:23+0200, Javier Carrasco wrote:
> I want to model the INTA pin as a clock source that only should run in
> sleep mode because its clock is only used in that mode. Therefore I want
> the pin to stay in hi-Z during normal operation.

Can you disclose what is the user of the clock, do you have a driver for
this device?

> 
> I do not want to get any interrupts from the INTA pin and the battery
> mode indication is not relevant for me either. I do not know the CCF
> mechanism in other RTCs though, but I think that the hi-Z mode
> accomplishes exactly what I described.The assumption about the battery
> mode is therefore beyond my knowledge, but my first reaction is that we
> already have the hi-Z for that.
> 
> So in the end I just need a mechanism to configure INTA as hi-Z, which
> the driver still does not support. There is another application where
> the clock output is not required even though it is physically connected,
> so hi-Z is again an interesting mode and the battery mode would be
> available if it ever becomes relevant for anyone.
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
