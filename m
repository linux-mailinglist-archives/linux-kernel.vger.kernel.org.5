Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7A97BEB5D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378568AbjJIUNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378555AbjJIUNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:13:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BECD8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1696882425; bh=ulLk2LfGe6WlK9vRunNHr+kO3Sko+WRiVOrmjUWzvkw=;
        h=Date:From:To:Subject:From;
        b=alZpDoQ+IeZO+8x6z3t9ZnnOTA8qk/DOJNII8Dy4vfGQS/U7V0Te6a2mpF83pvowa
         fCUnz0iPJIczIY/n+S5C4xKUyb6aMOe4WWNKfTi7UP3afinL2AOMAYRmUEOHh9vNeK
         Sy6HMnBPwsazwAAaOaLfYe4tERedWFBc2HizEr60=
Date:   Mon, 9 Oct 2023 22:13:45 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     loongarch@lists.linux.dev
Subject: qemu direct kernel boot on LoongArch
Message-ID: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to boot a LoongArch Linux via the direct kernel mode of qemu.
( qemu -kernel vmlinux -append "verbose" )
This doesn't work so well.

A few problems I encoutered:

* Linux reads the cmdline from $a1 during boot, but qemu doesn't place it there.
* Qemu puts a FDT at 1MiB but Linux doesn't use it.
* Qemu does not put the cmdline into the FDT.
* Linux panics in memory_present() because memblock_init() in
  arch/loongarch/kernel/mem.c did not set up any memblocks.
* Qemu has no support for initrds in direct kernel mode on LoongArch.

(All observations based on current git versions)

For the other architectures I'm using Linux/qemu with the direct kernel
mode works nicely including cmdline and initrds.

Are these restrictions by design/intentional or is it just for somebody
to do the necessary legwork?

The direct kernel mode is nice because it does not require the
installation of the additional EFI binary.


Thanks,
Thomas
