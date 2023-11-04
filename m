Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F144E7E0FC1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjKDN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjKDN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:56:52 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BCF4134
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:56:48 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3A4DuYtw029688;
        Sat, 4 Nov 2023 14:56:34 +0100
Date:   Sat, 4 Nov 2023 14:56:34 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Message-ID: <ZUZNkpEiHHWsmZhT@1wt.eu>
References: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
 <2023110407-unselect-uptight-b96d@gregkh>
 <365bbe1f-5ee8-40fe-bec0-53d9e7395c18@t-8ch.de>
 <2023110431-pacemaker-pruning-0e4c@gregkh>
 <59ed7f70-2953-443e-9fa5-d46c566e4a08@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59ed7f70-2953-443e-9fa5-d46c566e4a08@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 02:53:37PM +0100, Thomas Weißschuh wrote:
> > > The real reason probably doesn't matter today as the header propably
> > > can't be dropped from Linux anyways for compatibility reasons.
> > > 
> > > > And if they need to be here, why not use the proper BIT() macro for it?
> > > 
> > > This was for uniformity with the existing code.
> > > I can send a (standalone?) patch to fix it up.
> > 
> > If we keep it, sure, that would be nice.  But let's try to drop it if
> > possible :)
> 
> It will break the mentioned scripts/update-linux-headers.sh from qemu.
> 
> 
> Note:
> 
> BIT() is part of include/vdso/bits.h which is not part of the
> uapi. How is it supposed to work?
> Some other uapi header also use BIT() but that seems to work by accident
> as the users have the macro defined themselves.

Be careful here, we don't want to expose this kernel macro to userland,
it would break programs that define their own (possibly different) BIT
macro. BIT() is used in kernel headers but we should not presume that
it is available from userland.

Willy
