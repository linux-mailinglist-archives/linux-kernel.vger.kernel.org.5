Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A744766371
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjG1E4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1E4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:56:01 -0400
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Jul 2023 21:55:59 PDT
Received: from mailhost.m5p.com (mailhost.m5p.com [74.104.188.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1DC272D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:55:59 -0700 (PDT)
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
        by mailhost.m5p.com (8.16.1/8.15.2) with ESMTPS id 36S4kbWF078991
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 28 Jul 2023 00:46:43 -0400 (EDT)
        (envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
        by m5p.com (8.16.1/8.15.2/Submit) id 36S4ka3c078990;
        Thu, 27 Jul 2023 21:46:36 -0700 (PDT)
        (envelope-from ehem)
Date:   Thu, 27 Jul 2023 21:46:36 -0700
From:   Elliott Mitchell <ehem+xen@m5p.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, xen-devel@lists.xenproject.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ALSA: xen-front: refactor deprecated strncpy
Message-ID: <ZMNILDgqHEGf8fNF@mattapan.m5p.com>
References: <20230727-sound-xen-v1-1-89dd161351f1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727-sound-xen-v1-1-89dd161351f1@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:53:24PM +0000, Justin Stitt wrote:
> Technically, my patch yields subtly different behavior. The original
> implementation with `strncpy` would fill the entire destination buffer
> with null bytes [3] while `strscpy` will leave the junk, uninitialized
> bytes trailing after the _mandatory_ NUL-termination. So, if somehow
> `pcm->name` or `card->driver/shortname/longname` require this
> NUL-padding behavior then `strscpy_pad` should be used. My
> interpretation, though, is that the aforementioned fields are just fine
> as NUL-terminated strings. Please correct my assumptions if needed and
> I'll send in a v2.

"uninitialized bytes" => "leak of sensitive information" => "security hole"

One hopes the unitialized bytes don't contain sensitive information, but
that is the start of the chain.  One can hope the VM on the other end is
friendly, but that isn't something to rely on.

I'm not in charge of any of the appropriate subsystems, I just happened
to randomly look at this as message on a mailing list I'm on.  Could be
the maintainers will find this acceptable.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445


