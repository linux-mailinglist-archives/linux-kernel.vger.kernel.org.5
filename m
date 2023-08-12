Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD7779E15
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjHLIMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:12:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEDBCE;
        Sat, 12 Aug 2023 01:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1B60615F8;
        Sat, 12 Aug 2023 08:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9D5C433C9;
        Sat, 12 Aug 2023 08:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691827950;
        bh=QMyHJ0pOpeEAtM/F3tV+sSzHR92XcXu30lxgdjpZuHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAlLs1xyWRvCEbSOc3UENsygoSVfdfDXyuRBzFYIxwub2FxkxzjMD8AusQtHXMNBU
         JcPZeukOnKs57ijCbZ/wEr/1xb6a6KcaUPqguxXRPXH8RBkSi8yuKa1+OxXZXRjvzA
         H49OJr66z3Me8isiu6jRuvXC/gGaigBnqV4V196g=
Date:   Sat, 12 Aug 2023 10:12:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] test_fimware: return -ENOMEM instead of -ENOSPC
 on failed memory allocation
Message-ID: <2023081246-dimple-polygon-9097@gregkh>
References: <20230812054346.168223-1-mirsad.todorovac@alu.unizg.hr>
 <2023081213-reset-tadpole-fc94@gregkh>
 <4de9ce71-2d6d-6955-4316-e604b211ff8d@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de9ce71-2d6d-6955-4316-e604b211ff8d@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 10:06:53AM +0200, Mirsad Todorovac wrote:
> 
> 
> On 8/12/23 09:29, Greg KH wrote:
> > On Sat, Aug 12, 2023 at 07:43:47AM +0200, Mirsad Todorovac wrote:
> > > [ Upstream commit 7dae593cd226a0bca61201cf85ceb9335cf63682 ]
> > > 
> > > In a couple of situations like
> > > 
> > > 	name = kstrndup(buf, count, GFP_KERNEL);
> > > 	if (!name)
> > > 		return -ENOSPC;
> > > 
> > > the error is not actually "No space left on device", but "Out of memory".
> > > 
> > > It is semantically correct to return -ENOMEM in all failed kstrndup()
> > > and kzalloc() cases in this driver, as it is not a problem with disk
> > > space, but with kernel memory allocator failing allocation.
> > > 
> > > The semantically correct should be:
> > > 
> > >          name = kstrndup(buf, count, GFP_KERNEL);
> > >          if (!name)
> > >                  return -ENOMEM;
> > > 
> > > Cc: Dan Carpenter <error27@gmail.com>
> > > Cc: Takashi Iwai <tiwai@suse.de>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> > > Cc: Brian Norris <computersforpeace@gmail.com>
> > > Cc: stable@vger.kernel.org # 4.14
> > > Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
> > > Fixes: 0a8adf584759c ("test: add firmware_class loader test")
> > > Fixes: eb910947c82f9 ("test: firmware_class: add asynchronous request trigger")
> > > Fixes: 061132d2b9c95 ("test_firmware: add test custom fallback trigger")
> > > Link: https://lore.kernel.org/all/20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr/
> > > Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> > > 
> > > [ This is the backport of the patch to 4.19 and 4.14 branches. There are no	]
> > > [ semantic differences in the commit. Backport is provided for completenes sake	]
> > > [ so it would apply to all of the supported LTS kernels				]
> > 
> > This commit is already in the 4.19.291 release, does it need to be
> > included in there again for some reason?
> 
> Hi Mr. Greg,
> 
> I think the patchwork did not apply the commit to the 4.14 stable tree.
> Only the 19be3eccd000 ("test_firmware: fix a memory leak with reqs buffer" propagated to 4.14.322.
> 
> I would like to have us this chapter (backporting) completed before moving on.

That's fine, but your comment here said that this is for 4.19, but this
is already in 4.19, so I'm confused.  I'll queue this up for 4.14.y
now...

thanks,

greg k-h
