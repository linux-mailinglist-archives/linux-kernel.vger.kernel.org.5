Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223975DE04
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGVSH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGVSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 14:07:54 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052132137
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=m9ibkvVetKnPgi6edUxyjCX+2jN94mCaaKhYLkGKRJI=; b=a1RBYg5cbsNdT8livfdgxdjmBP
        cXfkOQmosixCa9GvF0aup1zOvq83kylMXkxqSDOxYTZD9BUBF4YkQwrIJDqlyJueZdfBWcvj6YeZf
        XRR/vZofN/4uXCIbVuf6Z7jpH38odTD4vWRZwdfYp+TnkQ9/viW9YCQHRP5bLMkRshbQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:38384 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qNH15-0004Db-MI; Sat, 22 Jul 2023 14:07:44 -0400
Date:   Sat, 22 Jul 2023 14:07:43 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     me@davidreaver.com, poeschel@lemonage.de,
        Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Christian Meusel <christian.meusel@posteo.de>
Message-Id: <20230722140743.fe710f4f12c344f07d879c88@hugovil.com>
In-Reply-To: <CANiq72nO04+2BcwBe_P0uD8pXJtTMG3djAFAj5Ucez6VvT4g7g@mail.gmail.com>
References: <20230706185100.84322-1-hugo@hugovil.com>
        <CANiq72kZ0cHxCKkm_781G__9tJxYCw3tpJarqvLOFB4Jw6ZONw@mail.gmail.com>
        <20230706154937.1380bdcf9d84e1cff78911fa@hugovil.com>
        <7eb2d50baf269310e51854f700936e94@lemonage.de>
        <86wmysknde.fsf@davidreaver.com>
        <CANiq72nO04+2BcwBe_P0uD8pXJtTMG3djAFAj5Ucez6VvT4g7g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] auxdisplay: hd44780: move cursor home after clear
 display command
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2023 18:04:03 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Sat, Jul 22, 2023 at 4:54 PM David Reaver <me@davidreaver.com> wrote:
> >
> > I was actually hooking up a 16x2 HD44780 on my BeagleBone Black last
> > night before I came across this patch, so I was able to test this. It
> > works fine for me. I tested with:
> >
> >     $ printf '\f' > /dev/lcd
> >     $ printf 'Hello\nWorld!\n' > /dev/lcd
> >     $ printf '\x1b[LR' > /dev/lcd
> >     $ printf '\x1b[LR' > /dev/lcd
> >     $ printf '\x1b[LR' > /dev/lcd
> >     $ printf '\f' > /dev/lcd
> >     $ printf 'Goodbye\nWorld!\n' > /dev/lcd
> >
> > As expected, "Goodbye World!" was correctly placed left-aligned on the
> > display, split over both lines. Let me know if there is something else
> > you would like me to do to test this!
> >
> > Tested-by: David Reaver <me@davidreaver.com>
> 
> Thanks a lot, that is very helpful!
> 
> I will wait a while in case Christian or somebody else wants to test
> it, and send it for 6.6.

Hi Miguel,
in the meantime, I will send V2 of the patch with the changes you
suggested for the commit message and the comments.

Hugo.
