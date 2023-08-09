Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85665776AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjHIVHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHIVHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:07:15 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751451BCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1691615231; bh=TczaNzCCWInwxTWH9BEieH6YTfWb9w0jqfVznd0qGhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvZfkAWGJozPowH8xPqnsYyuM7miVuqwf5AasON8orjw5/xMFB2ln+xIn/f4ik8TY
         pjDXaWjCSAWuk9evqfHq41sK2yUEMY8i3If9x0fa5i7MXYxMYhUlK+ZEPEbHNcSZ3B
         ygoHn9wJz7noVl7ThMTu0jNjurUqfmzV6sz4KS1I=
Date:   Wed, 9 Aug 2023 23:07:10 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: few dozen pollfress.t segfaults messages in system log
Message-ID: <0072e883-1c09-4a8d-86f8-a3de26b18b1e@t-8ch.de>
References: <5890bdee-ead3-a5c9-46e0-7abb7de1fb15@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5890bdee-ead3-a5c9-46e0-7abb7de1fb15@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-09 21:45:57+0200, Toralf Förster wrote:
> I got a bunch of
> 
> $ grep pollfree messages
> Aug  9 02:10:14 mr-fox kernel: pollfree.t[18582]: segfault at 10b ip
> 0000563c9619b373 sp 00007f69511a2eb0 error 4 in
> pollfree.t[563c9619a000+3000] likely on CPU 14 (core 14, socket 0)
> Aug  9 02:10:14 mr-fox kernel: pollfree.t[18594]: segfault at 10b ip
> 0000563c9619b373 sp 00007f69511a2eb0 error 4 in
> pollfree.t[563c9619a000+3000] likely on CPU 4 (core 4, socket 0)
> Aug  9 02:10:14 mr-fox kernel: pollfree.t[18597]: segfault at 10b ip
> 0000563c9619b373 sp 00007f69511a2eb0 error 4 in
> pollfree.t[563c9619a000+3000] likely on CPU 11 (core 11, socket 0)
> Aug  9 02:10:14 mr-fox kernel: pollfree.t[18601]: segfault at 10b ip
> 0000563c9619b373 sp 00007f69511a2eb0 error 4 in
> pollfree.t[563c9619a000+3000] likely on CPU 26 (core 10, socket 0)
> 
> last night with kernel 6.4.9 at a stable hardened Gentoo Linux:
> 
> Linux p14s 6.1.44 #34 SMP Tue Aug  8 21:43:00 CEST 2023 x86_64 AMD Ryzen
> 7 PRO 6850U with Radeon Graphics AuthenticAMD GNU/Linux
> 
> I do wonder if those messages are related to the host kernel or if they
> are coming from a buggy app within one of the images of the build bot I
> do run at that machine ?

Probably from the "pollfree" test of liburing [0].

Thomas

[0] https://github.com/axboe/liburing/blob/master/test/pollfree.c
