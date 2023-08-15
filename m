Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF6B77D1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbjHOS1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbjHOS0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:26:55 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 11:26:50 PDT
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [IPv6:2801:82:80ff:7fff::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7161BC3;
        Tue, 15 Aug 2023 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
        s=201705; t=1692123684;
        bh=TkKvsvTvLj1lSaJ4bUsIIoSnianpIUv77sSM6JDMvWs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=VOXL8isBfWIm+K7u4j8y147AIL2NW7xcmABqRBGXslTE6DA42AoGkwlX7HIdXoUmD
         sAIofZmygjS6NZUhBSdzNg8gxQWAtvwgJ5pCkywciLT5M7D4q/xtvvKjDe9EZInbj3
         58La+bGroMVqezoRJHQOtQW+98hi0tuqfG/vVwuNFAzbo1Mvl+OEYEqOtfRgHygHd/
         YadD7iR4W15IYl8TxCQ8iSUv4TMUMbTLaP0d1HSzWp9ZJ3G1JWl5g7doEfVwJUCpcB
         AMpo17ljbfCh+/ePtgC07kZr92pq8+RZZE+qpzIGHHI9BHkIH4URe1NAp4px/kI7ti
         Qtwc9OzIA08aQ==
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
        id 8B4113620851; Tue, 15 Aug 2023 15:21:24 -0300 (-03)
Date:   Tue, 15 Aug 2023 15:21:24 -0300
From:   Carlos Carvalho <carlos@fisica.ufpr.br>
To:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZNvCJAclBEJf7uUA@fisica.ufpr.br>
References: <ZNqWfQPTScJDkmpX@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNqWfQPTScJDkmpX@gallifrey>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. David Alan Gilbert (dave@treblig.org) wrote on Mon, Aug 14, 2023 at 06:02:53PM -03:
>   I'm seeing a few hangs on a fs after upgrading to fedora 39's bleeding
> edge; which is running kernel 6.5.0-0.rc5.20230808git14f9643dc90a.37.fc39.x86_64
> It was always solid prior to that.  It seems to trigger on heavy IO
> on this fs.

Good news! No, I didn't forget the smiley... Maybe now the problem has become
sufficiently bad to be visible/solvable...

6.4.* also doesn't run in one of our machines, which has heavy I/O load. The
first symptom is that rsync downloads hang and abort with timeout. 1 or 2
days later the amount of modified pages waiting to go to disk reaches several
GB, as reported by /proc/meminfo, but disks remain idle. Finally reading from
the arrays collapses.

This is just the worst case. Since early 5.* I/O performance has dropped
absurdly. In all our disk servers this is easy to see: just generate lots of
writes quickly (for example expanding a kernel tarball). Using top I see that
kworker starts using 100% cpu but disks stay idle (as seen by dstat or sar). If
you do a sync or umount it takes looooong to reach ~0 modified pages for the
sync or umount to return.

In the server I mentioned above where 6.4.* don't stand the load, which is one
of the largest free software mirrors of the world, even sometimes 6.1
collapses: I/O becomes so slow that service (apache) stops.

The problem gets progressively worse with time after booting. It's hardly
noticeable in the first hour after boot, and easily seen after ~3-4 days of
uptime. The higher the (write) I/O load the faster it appears.

All this is with ext4 and raid6 with >~ 14 disks in the arrays.

I don't have debug info because these are production machines and I only
compile in the kernel the bare minimum essential for operation. It's always
pure kernel.org releases; gcc versions vary, for 6.4* it's gcc-13, for 6.1*
gcc-12 is used, on Debian unstable updated more than 4 times/week.
