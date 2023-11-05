Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7133E7E126A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjKEG76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 01:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEG74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 01:59:56 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF532D3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 23:59:52 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3A56xgHk020716;
        Sun, 5 Nov 2023 07:59:42 +0100
Date:   Sun, 5 Nov 2023 07:59:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Message-ID: <20231105065942.GB20673@1wt.eu>
References: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
 <2023110407-unselect-uptight-b96d@gregkh>
 <365bbe1f-5ee8-40fe-bec0-53d9e7395c18@t-8ch.de>
 <2023110431-pacemaker-pruning-0e4c@gregkh>
 <59ed7f70-2953-443e-9fa5-d46c566e4a08@t-8ch.de>
 <ZUZNkpEiHHWsmZhT@1wt.eu>
 <2023110418-unreached-smith-5625@gregkh>
 <fc373999-466d-4587-b049-9f90076b4bd0@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc373999-466d-4587-b049-9f90076b4bd0@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 06:32:57PM +0100, Thomas Weißschuh wrote:
> On 2023-11-04 18:07:21+0100, Greg Kroah-Hartman wrote:
> > On Sat, Nov 04, 2023 at 02:56:34PM +0100, Willy Tarreau wrote:
> > > On Sat, Nov 04, 2023 at 02:53:37PM +0100, Thomas Weißschuh wrote:
> > > > > > The real reason probably doesn't matter today as the header propably
> > > > > > can't be dropped from Linux anyways for compatibility reasons.
> > > > > > 
> > > > > > > And if they need to be here, why not use the proper BIT() macro for it?
> > > > > > 
> > > > > > This was for uniformity with the existing code.
> > > > > > I can send a (standalone?) patch to fix it up.
> > > > > 
> > > > > If we keep it, sure, that would be nice.  But let's try to drop it if
> > > > > possible :)
> > > > 
> > > > It will break the mentioned scripts/update-linux-headers.sh from qemu.
> > > > 
> > > > 
> > > > Note:
> > > > 
> > > > BIT() is part of include/vdso/bits.h which is not part of the
> > > > uapi. How is it supposed to work?
> > > > Some other uapi header also use BIT() but that seems to work by accident
> > > > as the users have the macro defined themselves.
> > > 
> > > Be careful here, we don't want to expose this kernel macro to userland,
> > > it would break programs that define their own (possibly different) BIT
> > > macro. BIT() is used in kernel headers but we should not presume that
> > > it is available from userland.
> > 
> > It's already there :(
> > 
> > I thought we had a uapi-safe version somewhere, but I can't seem to find
> > it anymore, so I don't remember what it is called.
> 
> It seems to be _BITUL() and _BITULL() from include/uapi/linux/const.h.
> 
> But first we'd need to figure out if we he can drop the pvpanic.h uapi
> header. I hoped you could give a definitive answer for that.
> Personally I'd hate to break stuff for qemu.

Agreed, and I tend as well to be careful not to change uapi stuff in
ways that can break, as it can take time to flow to applications and
cause subtle breakage much later :-/

Willy
