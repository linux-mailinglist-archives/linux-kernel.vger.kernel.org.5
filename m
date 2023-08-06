Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C97713CD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjHFGpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFGpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 02:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BCF1FD4;
        Sat,  5 Aug 2023 23:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54B9360F87;
        Sun,  6 Aug 2023 06:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC09C433C8;
        Sun,  6 Aug 2023 06:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691304308;
        bh=uNG7eW59DkHR03SvfUijrRfJtqldDdsoJpdtu0H745E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nD15+Jappd81Lbgw48rpkDz0SZ71w7vol38DHWguz7ueABSgNuRtGfhWXafG8aSF3
         lTrOEfpO25dyE7S2O6ktVGA5jtT5V/ipKdFCQAGD4UNDqKRtBrj70XVRUkt/k0N7gw
         rEhP9o7O8xmA4GX026uVgp6jFzJRjz86jJwKH89U=
Date:   Sun, 6 Aug 2023 08:45:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v7 8/8] kbuild: modinst: do modules_install step by step
Message-ID: <2023080630-entomb-ogle-3da8@gregkh>
References: <20230623145358.568971-1-yesshedi@gmail.com>
 <20230623145358.568971-9-yesshedi@gmail.com>
 <2023080434-verbose-value-1200@gregkh>
 <9ff945e6-c963-41d2-9df2-542d83ada519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff945e6-c963-41d2-9df2-542d83ada519@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 12:30:22AM +0530, Shreenidhi Shedi wrote:
> On 04/08/23 19:36, Greg KH wrote:
> > On Fri, Jun 23, 2023 at 08:23:58PM +0530, Shreenidhi Shedi wrote:
> > > Currently Makefile.modinst does three tasks on each module built:
> > > - Install modules
> > > - Sign modules
> > > - Compress modules
> > > 
> > > All the above tasks happen from a single place.
> > > 
> > > This patch divides this task further and uses a different makefile for
> > > each task.
> > > Signing module logic is completely refactored and everything happens
> > > from a shell script now.
> > > 
> > > Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
> > > ---
> > >   scripts/Makefile.compress |  53 ++++++++++++++++++
> > >   scripts/Makefile.install  |  66 +++++++++++++++++++++++
> > >   scripts/Makefile.modinst  | 111 +++-----------------------------------
> > >   scripts/Makefile.sign     |  37 +++++++++++++
> > >   scripts/signfile.sh       |  24 +++++++++
> > >   5 files changed, 186 insertions(+), 105 deletions(-)
> > >   create mode 100644 scripts/Makefile.compress
> > >   create mode 100644 scripts/Makefile.install
> > >   create mode 100644 scripts/Makefile.sign
> > >   create mode 100755 scripts/signfile.sh
> > 
> > As you are touching the build process, you should always cc: the proper
> > mailing list, and the KBUILD maintainer.  Please do so for this series,
> > as that is the proper tree for this to go through.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Thanks for the inputs Greg.
> 
> CC-ing linux-kbuild@vger.kernel.org as suggested.

This doesn't actually do anything, sorry.  Please resend the whole
patchset again and add the proper people and list.

thanks,

greg k-h
