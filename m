Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55657777AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjHJOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHJOdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058D22698;
        Thu, 10 Aug 2023 07:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A0A6341B;
        Thu, 10 Aug 2023 14:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD37C433C8;
        Thu, 10 Aug 2023 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691678034;
        bh=WqlM6z8LVtWUOQQF2diUDLPd+E8rFCp1jue2qltP+o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p26mWUsjFPi/9fGERTPqWNn3k2cdqyogDgIvZeRO5qJeB0+AcANXUzJhj8N+azueZ
         CUMjB2fmvq7kj3+fkWZyYaR2eJBscJeo+XoL+uxRQAaMvzGactfPD1w8PcLjP833hJ
         w65nYa3MF0qXIm8aT5amGeCvaPI8LZmn90cDdgT5Z07pOgx2tmBVwAQiOOBcC6z3lw
         +d4GQCvfJASLQTKGWgWcKwmhrQ6RacnM2iZ194MlmXz+J6a3lyH4yRDw9QpA+cGkxw
         tF+z2cdoBkmcQF7ZaD56OzhOZesVhaV5fy6FEIuAzktEVOReVrX3MK1X944yZ2IIDX
         ojDjrf0u3K5lw==
Date:   Thu, 10 Aug 2023 07:36:45 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Hugo Villeneuve <hugo@hugovil.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, bartosz.golaszewski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Subject: Re: [PATCH RESEND] tty: serial: qcom-geni-serial: Poll primary
 sequencer irq status after cancel_tx
Message-ID: <7mdlnuxzm7rxstl2r3kyyiuefbj3wpyqprzufdrsxe7hy5fvfo@tdwfhi6a27hj>
References: <1691583100-15689-1-git-send-email-quic_vnivarth@quicinc.com>
 <20230809091951.fbcc682d00deacd4d7b55b44@hugovil.com>
 <9be10770-d3df-467e-0541-8839bcd22fee@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be10770-d3df-467e-0541-8839bcd22fee@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 10:51:54PM +0530, Vijaya Krishna Nivarthi wrote:
> Hi,
> 
> Thank you very much for the review...
> 

Thank you for the bug fix, Vijaya.

> 
> On 8/9/2023 6:49 PM, Hugo Villeneuve wrote:
> > On Wed,  9 Aug 2023 17:41:40 +0530
> > Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com> wrote:
> > 
> > > TX is handled by primary sequencer. After cancelling primary command, poll
> > > primary sequencer's irq status instead of that of secondary.
> > Hi,
> > it is not clear to me if this is a bug fix or an improvement?
> This is a bug fix.

Please describe the actual problem you're solving, to allow others
working in and around this driver to know what issue(s) are corrected.

This will save others debugging time, and it will teach others to help
you maintain this driver.

The section in the documentation on how to describe your changes is
good, please read it:
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> > 
> > > While at it, also remove a couple of redundant lines that read from IRQ_EN
> > > register and write back same.
> > This should go into a separate patch.
> 
> The changes were too close by so I wasn't sure it could be split into 2
> patches.
> 
> I see that the earlier patch has already been signed off by Greg. (I did a
> RESEND after realising that I had Bjorn Andersson's email address incorrect)

Please use ./scripts/get_maintainer.pl on the upstream tree, as this
uses up to date information about recipients.

> 
> Will post another version if original patch doesn't get merged for any
> reason.
> 

Please double check linux-next [1], if it's unclear if Greg picked up
your previous patch (he's usually quite explicit about it...). I really
would like some more details on the bug fix...

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

Regards,
Bjorn
