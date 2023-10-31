Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6B7DC6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbjJaG6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjJaG6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:58:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7DFC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:58:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492B2C433C7;
        Tue, 31 Oct 2023 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698735484;
        bh=HdAiznUxhcZXhph48HNgf6qwmxfrkOwTlXXXo/pqitg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESlHlmb1+47hH7FJttzJCOocaB1rSSWN7vgtgaDpPydStmBvlebLsgdgBNM+h2lLp
         YlNYUYa5B2TXzkQWCwlqMYL4O2UY0SHwXst3MU5iMri1Yl4ME0TRi9xLxmswjoFDJH
         TKpopbRGjuHLePvSOtXrtNGUMxNNL67+Rzd7WJkE=
Date:   Tue, 31 Oct 2023 07:58:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tingwei Zhang <quic_tingweiz@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>
Subject: Re: How to pass software configuration to driver built as module in
 boot up phase
Message-ID: <2023103108-guacamole-neurotic-f59b@gregkh>
References: <1c001c6f-9902-4803-9406-39e3325422bf@quicinc.com>
 <2023103021-revolving-clapper-632d@gregkh>
 <c244eae0-d3d8-414b-8d1f-c902bd46bd61@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c244eae0-d3d8-414b-8d1f-c902bd46bd61@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:56:23AM +0800, Tingwei Zhang wrote:
> On 10/30/2023 7:30 PM, Greg Kroah-Hartman wrote:
> > On Mon, Oct 30, 2023 at 07:21:48PM +0800, Tingwei Zhang wrote:
> > > Hi Masami, Greg and Rafael,
> > > 
> > > I have one driver that needs a bunch to software configuration like 1000
> > > settings. These settings can be different according to the use case.
> > 
> > That seems very odd, what type of driver is this?
> The example use case is below DCC driver which is a DMA engine. It can be
> configured to read/write registers while whose registers need to be
> configured by software. It's mainly used to debug device crash issue.
> https://lore.kernel.org/lkml/cover.1691496290.git.quic_schowdhu@quicinc.com/T/

Given that no one listened to my last review cycle of that driver, why
are you asking us again?

> > > They are required in boot up phase so we can't reply on user space to make
> > > the configuration.
> > > 
> > > Boot config is not preferred since we'd like to build that driver as dynamic
> > > load Kernel module.
> > > 
> > > Could you let me know if there's any mechanism in Kernel to do that?
> > 
> > What is wrong with the existing ways of doing this that all other
> > drivers use?
> I'm not aware of all the existing ways. Below ways are what I know and they
> may not be suitable for some reason.
> 1. Let user space to configure with sysfs/debugfs/ioctl interface. Since we
> need this configuration to be done in early stage before user space is up.

I really doubt that you need this before userspace starts, as that's not
what "device crash" stuff should be dealing with.  That happens after
init starts, because you have a working kernel (i.e. this is not for
hardware bringup.)

> This doesn't work.

Why do you need this before init?  Specific reasons please.

> 2. Use device tree to pass the configuration to driver. Since the
> configuration is software configuration instead of hardware descirption. It
> doesn't fit in device tree.
> 3. Boot config or commandline parameter. If the driver is built in, it can
> work. But it doesn't work for dynamically loadable Kernel module.

If you have a module, then you can do this after init starts, so you
are reporting conflicting "requirements" here, which make this
impossible for us to understand :(

Please work with the kernel developers at your company to come up with a
solution for this, you have the experience, do not require the community
to do your work for you.

thanks,

greg k-h
