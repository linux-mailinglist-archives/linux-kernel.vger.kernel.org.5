Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBDC7E4749
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjKGRnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjKGRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:43:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10379125
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:43:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E65AC433C7;
        Tue,  7 Nov 2023 17:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699378981;
        bh=AA29qJmLk5KV97FY2zltETr0dL2/GW30s2k0IJRqsJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KjYMFS4RKf6uYko4T43yEVuaUcBj+EzN33jxepRw/8L/c7DQRQ/FXw9E/FMRQuF59
         JzQGYvu/AFH60XsGCXIAtsKh08uZy9xA4k/D9KG5SE6hx1HspbgSSm6iF5vLMkCmts
         jj0w1YDg4AsdODnUp7GJWHTD4Ne0jghsSw8IvuUZRhXd+sKewXvLkhXtzu0yy+OYk6
         viUqbRK45BkAmYTYtR+bTTfm3kuFqY3brlSCXse9jrJnBQkzt7vY3rnC4gyyS1E9ln
         VEEIXSoLDoj25YqrDxZw6lLGly0uwImWCuynKe7vXrna67RtKHG0VOBdBaei+5oaMW
         mnPf+GsASX3yA==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1r0Q6N-00BD8q-4T;
        Tue, 07 Nov 2023 17:42:59 +0000
MIME-Version: 1.0
Date:   Tue, 07 Nov 2023 17:42:58 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: Move Mediatek GIC quirk handling from
 irqchip to core
In-Reply-To: <CAD=FV=Xv7XKvePTZ6LKT97EViG81d8hqk+T68B5eXamKTU407A@mail.gmail.com>
References: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <9b2e37a0-32ee-4aa4-99e8-d37103674847@collabora.com>
 <CAD=FV=Xv7XKvePTZ6LKT97EViG81d8hqk+T68B5eXamKTU407A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <e2e7762bfd16f67bdc253dc23a967c46@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: dianders@chromium.org, angelogioacchino.delregno@collabora.com, mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, wenst@chromium.org, amit.kachhap@arm.com, james.morse@arm.com, joey.gouly@arm.com, broonie@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-07 17:37, Doug Anderson wrote:
> Hi,
> 
> On Tue, Nov 7, 2023 at 8:30 AM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>> 
>> > +static __init void detect_system_supports_pseudo_nmi(void)
>> > +{
>> > +     struct device_node *np;
>> > +
>> > +     if (!enable_pseudo_nmi)
>> > +             return;
>> > +
>> > +     /*
>> > +      * Detect broken Mediatek firmware that doesn't properly save and
>> 
>> s/Mediatek/MediaTek/g
>> 
>> Apart from that,
>> 
>> Reviewed-by: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
>> 
>> On MT8195, MT8192, MT8186:
>> Tested-by: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com>
> 
> Thanks! Unless someone wants me to spin it more quickly, I'll plan to
> send a V3 with the Mediatek=>MediaTek change tomorrow.

I really don't think that's worth the effort.

Catalin can fix this when applying the patch, and even then,
nobody is going to notice that sort of pretty irrelevant
detail.

         M.
-- 
Jazz is not dead. It just smells funny...
