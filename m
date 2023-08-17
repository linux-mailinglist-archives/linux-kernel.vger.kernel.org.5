Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E6B780101
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355721AbjHQW0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355722AbjHQWZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:25:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ABE30D8;
        Thu, 17 Aug 2023 15:25:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26E5540004;
        Thu, 17 Aug 2023 22:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692311144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2nCrCLg8EL+bZyyRQk0feFNmHoHFKKt/ijVy++3LtKk=;
        b=V7MLkHrwUIrsRLDQLJdLOJHZ/vMc7Ez65l1Uxv1vF3jjsAmiCMaKdwdpMxSBipZMXnNW3g
        8OEjM7Qkbz8Hb7hQMhtELoCuxQ1MUl5n6AiHykXcj6VIK7SImkcayiLVwhhq1r0/M1AydL
        yjOqwWk4wltbZTppHF1nfX9MPkWK4YGf6uTB+xBYJd/bHnSYng7HTnrnFAA+XLAYAf3mX2
        mX15aiLyxPH24H2adjz8fodreoh1dfnhls+Owo5s0XdrI4QWfVViNmV6ArYBDYuCuxUiTe
        yuDK5NKErQ+hmAfeN9U04zAxif+h+t7aeenkUY3YSJUSmT3AaIw49ZmnYhDYog==
Date:   Fri, 18 Aug 2023 00:25:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf85363: Allow to wake up system without IRQ
Message-ID: <202308172225433f4bb84b@mail.local>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.eeedf5db-4013-4c3b-be1c-1121df58f897@emailsignatures365.codetwo.com>
 <20230502055458.11004-1-mike.looijmans@topic.nl>
 <202308162140170c067ce7@mail.local>
 <ec2d7ef3-3dcc-aebb-1a4f-c2e01a09f750@topic.nl>
 <202308170817599c17a369@mail.local>
 <5113ab6e-881b-fa6b-00c4-118b32be4a4c@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5113ab6e-881b-fa6b-00c4-118b32be4a4c@topic.nl>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 11:02:43+0200, Mike Looijmans wrote:
> > My comment was also for device_init_wakeup(&client->dev, true);. I think
> > the easiest would be to move this block later on and set client->irq to
> > 0 when devm_request_threaded_irq fails.
> > 
> 
> Ah, clear. That also properly handles things when IRQ fails but
> wakeup-source was present. In table form:
> 
> IRQ   wakeup-source   Call "device_init_wakeup" etc.
> N/A   No              No
> N/A   Yes             Yes
> OK    No              Yes
> OK    Yes             Yes

This case is forbidden, you must not have an interrupt property and
wakeup-source at the same time.

> FAIL  No              No
> FAIL  Yes             Yes

This is then also forbidden
> 
> We still have to program the registers before registering the IRQ I think.

Yes, certainly.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
