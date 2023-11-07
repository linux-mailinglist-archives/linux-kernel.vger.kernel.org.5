Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F97B7E3B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjKGLhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:37:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC13EA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:37:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23444C433C7;
        Tue,  7 Nov 2023 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699357041;
        bh=txhWC7Qk/B+OuUbVMEFoUuEQ+inCT1iopvkXocpTbpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nLI4zejY3Awsws4zBH2Um0JJUz32OBAW7xmtGH7vvZ1dz1Wu0Rp63D1NMYOQXwRJ+
         e2a8+oHGAthz7QNzYYBdR5AUn4kOpZzbO6Cjmcbj7eg1/erqLEYbnyQvAskU3bHWbu
         2oObyICVXiIDe2rEgcmPqBhe6flbtAbFCFwxEP8IanBA1QiVHM9LEi0YoeALUlV071
         s0vILooiXx8N8Nn5zY1nzleZOTlHZ9R6Gq6PZrkmvOCUimLuASBXz9YsTwaR8tjryv
         +fxmj+smX+T4+1+fa/9brOIy0AdErquwXKZJekQLIaOoaMWlBpKNrlZ4k3xgVdNZ2Q
         yKkzmCLIX72DQ==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1r0KOU-00B4hc-CM;
        Tue, 07 Nov 2023 11:37:18 +0000
MIME-Version: 1.0
Date:   Tue, 07 Nov 2023 11:37:18 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Remove Mediatek pseudo-NMI firmware
 quirk handling
In-Reply-To: <CAD=FV=UVkE9k=o3-3UT2L172hhAH-gtpe5ByELN8srC+a-7mJw@mail.gmail.com>
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <20231006151547.3.Ie582d33cfe46f9ec2248e7f2dabdd6bbd66486a6@changeid>
 <ZS-8k22ZWgn5hcCd@FVFF77S0Q05N>
 <CAD=FV=UVkE9k=o3-3UT2L172hhAH-gtpe5ByELN8srC+a-7mJw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <0efbd5a2cfb5dab0876038ae726dc180@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: dianders@chromium.org, mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, wenst@chromium.org, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-30 23:01, Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 18, 2023 at 4:08 AM Mark Rutland <mark.rutland@arm.com> 
> wrote:
>> 
>> On Fri, Oct 06, 2023 at 03:15:53PM -0700, Douglas Anderson wrote:
>> > This is a partial revert of commit 44bd78dd2b88 ("irqchip/gic-v3:
>> > Disable pseudo NMIs on Mediatek devices w/ firmware issues"). In the
>> > patch ("arm64: Disable GiC priorities on Mediatek devices w/ firmware
>> > issues") we've moved the quirk handling to another place and so it's
>> > not needed in the GiC driver.
>> >
>> > NOTE: this isn't a full revert because it leaves some of the changes
>> > to the "quirks" structure around in case future code needs it.
>> >
>> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> > ---
>> 
>> I think it might make sense to fold this into the patch adding the 
>> cpucap
>> detection. Otherwise, if you apply my suggestions to the first patch, 
>> there's a
>> 2-commit window where we'll have two places that log that NMI is being 
>> disabled
>> due to the FW issue. That's not a functional issue, so doesn't matter 
>> that
>> much.
>> 
>> Either way:
>> 
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> I'm happy to go either way so I'd love some advice from maintainers
> (Marc Zyngier, Catalin Marinas, Will Deacon) about what you'd prefer.

I honestly don't mind either way. The sooner we have these fixes
upstream, the better, so my only advise would be to respin it
shortly.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
