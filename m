Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257737BA2C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjJEPpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjJEPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:45:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9207694;
        Thu,  5 Oct 2023 07:32:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68020C433BC;
        Thu,  5 Oct 2023 07:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696490769;
        bh=OX4KD6sfNOWtabDqGM1DP4NFuApW1Y4ZymyK5RMSEPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZ6jTkFREYPJRFOwRFjbSPJ7/FDC/aGBRU0UrLvX7xZstG1VZmUsL6+x41d8A02ZI
         B1CRAWlPaX2eIFD4fr/SJJUP0l1sY957YCEBfpwHesJjjfIbCPlxxhfYhDtckIPXdh
         hRC5DUDj8QFpvjPzyLsuC+CQdlzXujp6enO4QlzNhEEY7zfWp5ceqDfwz1qf4/AXub
         71OC4T1LFCeeUf5BB/SxQk9+G7TsMlk9Pw/PUz7xK2sQ5Ds/OMHsAf8GrhvDXppNj9
         Ot2y4YfFLZ3VRZxUeubUk5FBbOZJPPvVk258+Jhs0dOOw63K9smDgiHwyFFOkcz2VQ
         H+ZIDfq3b9wwQ==
Date:   Thu, 5 Oct 2023 08:26:04 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        linux-serial@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Message-ID: <20231005072604.GC83257@google.com>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
 <20231003185500.GD8453@google.com>
 <2023100457-entail-freefall-06fd@gregkh>
 <20231004090918.GB9374@google.com>
 <2023100425-unwieldy-reaffirm-2a1b@gregkh>
 <20231004125758.GB83257@google.com>
 <1c2afee3-6c1b-4703-8b9a-487f96a2526b@kernel.org>
 <2023100511-unpeeled-dinginess-fefd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023100511-unpeeled-dinginess-fefd@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023, Greg Kroah-Hartman wrote:

> On Thu, Oct 05, 2023 at 06:59:50AM +0200, Jiri Slaby wrote:
> > On 04. 10. 23, 14:57, Lee Jones wrote:
> > > > > n_gsm is available on all the systems I have available.  The mention of
> > > > > 'EXPERIMENTAL' in the module description appears to have zero effect on
> > > > > whether distros choose to make it available or not.  If you're saying
> > > > > that we know this module is BROKEN however, then perhaps we should mark
> > > > > it as such.
> > > > 
> > > > Also, I think this requires root to set this line discipline to the
> > > > console, right?  A normal user can't do that, or am I missing a code
> > > > path here?
> > > 
> > > I haven't been testing long, but yes, early indications show that root
> > > is required.
> > 
> > FWIW I concluded to the same yesterday, so I disputed the connected
> > CVE-2023-31082. Waiting for mitre's ack/nack.
> 
> Trying to dispute obviously-wrong CVEs is a never-ending task.
> 
> Personally, it's fun to see who keeps popping up to attempt to resolve
> this issue showing what companies have their security policies dictated
> by a random government authority that can be modified by anyone :)

It's a struggle! :)

-- 
Lee Jones [李琼斯]
