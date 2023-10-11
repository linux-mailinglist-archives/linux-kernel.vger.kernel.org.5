Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA07C5D96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346876AbjJKTVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjJKTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:21:46 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B885B7;
        Wed, 11 Oct 2023 12:21:43 -0700 (PDT)
Received: from [192.168.42.20] (p5b164245.dip0.t-ipconnect.de [91.22.66.69])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 372672FC004D;
        Wed, 11 Oct 2023 21:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1697052102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HzLD8pPukh5eiY+IQZbApyMi2NuuYDOnW3cApZb8tE=;
        b=ZeQmIBq+hZAxfSMcsP+0c6IcXR0mRX2Gg3XeSS5uZTJpH6S8OH1Qqm/HhkWklpsUlT19JP
        MASxjW5obIvxXo0cfphln6Laa7wiDmVBCPoPsYWm7H71l4EY7trYaLwDhhDkaKx6CZz6qp
        HpThsZHqqHf0xQbWJs+C0QYXKS3617g=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <79c27c71-a86b-4b30-aa1a-96b2f7bf26b4@tuxedocomputers.com>
Date:   Wed, 11 Oct 2023 21:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: rgb: Implement per-key keyboard backlight for
 several TUXEDO devices
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20231011190017.1230898-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 11.10.23 um 21:00 schrieb Werner Sembach:
> From: Christoffer Sandberg <cs@tuxedo.de>
>
> Implement per-key keyboard backlight in the leds sysfs interface for
> several TUXEDO devices using the ite8291 controller.
>
> There are however some known short comings:
> - The sysfs leds interface does only allow to write one key at a time. The
> controller however can only update row wise or the whole keyboard at once
> (whole keyboard update is currently not implemented). This means that even
> when you want to updated a whole row, the whole row is actually updated
> once for each key. So you actually write up to 18x as much as would be
> required.
> - When you want to update the brightness of the whole keyboard you have to
> write 126 sysfs entries, which inherently is somewhat slow, especially when
> using a slider that is live updating the brightness.
> - While the controller manages up to 126 leds, not all are actually
> populated. However the unused are not grouped at the end but also in
> between. To not have dead sysfs entries, this would require manual testing
> for each implemented device to see which leds are used and some kind of
> bitmap in the driver to sort out the unconnected ones.
> - It is not communicated to userspace which led entry controls which key
> exactly
>
> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>

The first time I submit a whole module, so please let me know if it made any 
mistakes e.g. I'm unsure if I need add myself explicitly as a maintainer, if 
MODULE_AUTHOR has to be a human, or if i have to split this up into smaller junks.

Also please let me know if i somehow misinterpreted the current API and the 
shortcomings can actually be avoided.

I have not yet looked deeply into triggers, but one idea i had is to only have 
one kbd_backlight by default that just makes the whole keyboard the same color 
and brightness. In addition to that a trigger per_key_control, that, when set, 
adds 125*3 subleds to write the whole keyboard in rainbow colors with a single 
echo to multi_intensity.

The keyboard also supports hardware color effects like color cycle, which 
continuously and smoothly cycles through up to 7 colors. Could this also be 
implemented with a trigger? That trigger would need to add a new entry nr_colors 
and also respectively additional subleds or additional multi_intensity_* entries.

An additional though I had was that it would be nice if the driver could somehow 
communicate the physical location of the key to the userspace for UIs to 
automatically generate a keyboard view to graphically set individual colors.

Kind regards,

Werner Sembach

