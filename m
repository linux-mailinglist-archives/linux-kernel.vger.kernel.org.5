Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE9F7E107F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 18:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjKDRdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 13:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKDRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 13:33:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157D1BF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699119178;
        bh=dfkf51YavrShtsViHN2it78NydaNomWdIeuQ4qET9dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8rYY3UqyXk+A2iW11irbG84Pbfx1Y/2CtaLyRchBWeNql5vJHtCIxkGiym+2Et6E
         9Nah0b643xH5JwEFpqhhqo3zQlu0m80nW4IBveLBfT2U2R0glaqa/u1wBks3iFyK+O
         oTiQN75v9t04lpJ+t1ROSq0gx7KZq1M7q64/9FIo=
Date:   Sat, 4 Nov 2023 18:32:57 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Message-ID: <fc373999-466d-4587-b049-9f90076b4bd0@t-8ch.de>
References: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
 <2023110407-unselect-uptight-b96d@gregkh>
 <365bbe1f-5ee8-40fe-bec0-53d9e7395c18@t-8ch.de>
 <2023110431-pacemaker-pruning-0e4c@gregkh>
 <59ed7f70-2953-443e-9fa5-d46c566e4a08@t-8ch.de>
 <ZUZNkpEiHHWsmZhT@1wt.eu>
 <2023110418-unreached-smith-5625@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023110418-unreached-smith-5625@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-04 18:07:21+0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 04, 2023 at 02:56:34PM +0100, Willy Tarreau wrote:
> > On Sat, Nov 04, 2023 at 02:53:37PM +0100, Thomas Weißschuh wrote:
> > > > > The real reason probably doesn't matter today as the header propably
> > > > > can't be dropped from Linux anyways for compatibility reasons.
> > > > > 
> > > > > > And if they need to be here, why not use the proper BIT() macro for it?
> > > > > 
> > > > > This was for uniformity with the existing code.
> > > > > I can send a (standalone?) patch to fix it up.
> > > > 
> > > > If we keep it, sure, that would be nice.  But let's try to drop it if
> > > > possible :)
> > > 
> > > It will break the mentioned scripts/update-linux-headers.sh from qemu.
> > > 
> > > 
> > > Note:
> > > 
> > > BIT() is part of include/vdso/bits.h which is not part of the
> > > uapi. How is it supposed to work?
> > > Some other uapi header also use BIT() but that seems to work by accident
> > > as the users have the macro defined themselves.
> > 
> > Be careful here, we don't want to expose this kernel macro to userland,
> > it would break programs that define their own (possibly different) BIT
> > macro. BIT() is used in kernel headers but we should not presume that
> > it is available from userland.
> 
> It's already there :(
> 
> I thought we had a uapi-safe version somewhere, but I can't seem to find
> it anymore, so I don't remember what it is called.

It seems to be _BITUL() and _BITULL() from include/uapi/linux/const.h.

But first we'd need to figure out if we he can drop the pvpanic.h uapi
header. I hoped you could give a definitive answer for that.
Personally I'd hate to break stuff for qemu.


Thomas
