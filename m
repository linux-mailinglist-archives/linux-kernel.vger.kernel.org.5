Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1629078E774
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjHaH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjHaH6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:58:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5D1A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30C25B8212F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873E4C433C8;
        Thu, 31 Aug 2023 07:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693468686;
        bh=egUkiVsevLMU8xG5XU5h1UuKxB2QeM6GeSDTlW2cmUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IT4fE548/yUWkzJkJXUfarQ2N0rVHpLsTCG9Pzf/ssUC960n1s9u1v3LmYTN98wly
         fw1DxLoILilmmUSEbRlsPc5od3XI+X2A5tEG5RyGz/nfE+z7RjlTbeAnEcoc0OI6CT
         bWDtbzc+TJejuNPw3PIFe1qvrJW/jW9sSrDx++AQ=
Date:   Thu, 31 Aug 2023 09:58:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: Stability guarantees on uevent variables?
Message-ID: <2023083110-delicacy-thinly-5af6@gregkh>
References: <c0d32695-9e3e-4173-8448-7d123f38824e@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0d32695-9e3e-4173-8448-7d123f38824e@notapiano>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 07:08:39PM -0400, Nícolas F. R. A. Prado wrote:
> Hi,
> 
> my question boils down to the following:
> 
> Is there a stability guarantee on the format and content of the variables in
> uevents produced by the kernel?

Only if the normal userspace tools that use those variables require it.

> I would assume so, given that uevents are explicitly produced for userspace, and
> users will rely on them. However, looking through the ABI documentation I could
> only find two instances of uevents being defined (testing/usb-uevent and
> testing/usb-charger-uevent) and neither mention the variables added in the
> KOBJ_ADD action. The document for the uevent file in sysfs,
> testing/sysfs-uevent, only mentions writing synthetic uevents, rather than
> reading existing ones. Is the documentation simply lacking or is it intentional
> that uevent variables aren't covered?
> 
> I'm particularly interested in the format for the MODALIAS uevent variable. My
> understanding is that its only use is to match against the modules' aliases in
> the modules.alias file. For that reason I'm wondering whether for this variable,
> the guarantee would only be that the format of the value will match the one in
> modules.alias, but the precise format is not guaranteed (for example, a new
> field could potentially be introduced in the future if added to both the device
> uevent and module's alias). However, I do see a few ABI documentation pages for
> the modalias file in sysfs (eg in testing/sysfs-bus-pci), which explicitly
> describe the format, and that's supposed to be the same as the MODALIAS uevent,
> so does that mean the format itself is stable?

No, modalias is not stable, it can change over time (add new fields), as
it is just a userspace representation of how to call 'modprobe' and
match up with the kernel-provided module alias fields.

So the value will always match the module alias fields, but userspace
shouldn't be attempting to parse the thing at all, as that makes no
sense (the kernel understands the format, userspace does not need to.)

> I'll be happy to improve the ABI documentation based on the reply to these
> questions.
> 
> As for the full context for these questions, as part of an effort to improve the
> detection of regressions affecting device probe, I want to be able to check
> whether devices under a discoverable bus (USB, PCI) were populated and probed by
> a driver.

So you want to see if a driver is possible for this device, or if the
driver failed to bind to the device?  Those are different things.

> We currently do this by checking against driver and device names [1],
> but as has been pointed out before, that's not stable ABI, and the test might
> break if things get renamed or moved around.

Yes, driver names get changed all the time, and move around the kernel
tree as well.  That's not going to stop, but it shouldn't affect
testing, right?

> So my intention is to change that
> check to use modaliases or other uevents to find the device in a stable way and
> check for the driver symlink to verify it's been probed.

Just use the symlink, that shows if a device actually has a driver bound
to it.  Note that drivers can refuse to bind to a device for loads of
reasons, even if it's probe function is properly called by the kernel.

So for regressions, just see if there is a link from all devices to a
driver and you should be fine.  No need to mess around with module
aliases at all, as you don't want to put the parsing of those structures
in userspace as well, right?

thanks,

greg k-h
