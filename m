Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6277DCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243208AbjHPJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbjHPJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:04:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE5119A6;
        Wed, 16 Aug 2023 02:04:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 598E8218F2;
        Wed, 16 Aug 2023 09:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692176653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anUcfyAE4+NBXY3tfz1B3qnney7hrLbp9wtjZaob6K4=;
        b=oeMRFZb2APz95e77YPGo7PBSxqZKwN4HwIMQ6R+GysL3KyGbpyc/Z6W0bEVhzQk+7lfn8a
        iRVrSJEfDXpSuNWJQYAMglmdI7gh6HXtIpv8BNvXEebfzymZodUaDPkm1LdPx7hQC+jm17
        4uEKA5u0dvgYfrM01tguexn2GRtDQUE=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DDD632C143;
        Wed, 16 Aug 2023 09:04:12 +0000 (UTC)
Date:   Wed, 16 Aug 2023 11:04:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hexdump: add a new dump prefix DUMP_PREFIX_CUSTOM
Message-ID: <ZNyRC9wHuLTDZVQV@alley>
References: <20230811074922.1388-1-thunder.leizhen@huaweicloud.com>
 <20230811074922.1388-3-thunder.leizhen@huaweicloud.com>
 <ZNuMGyJ2x21RpVyR@alley>
 <167a4aee-7a9d-a024-7594-97b84146196c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167a4aee-7a9d-a024-7594-97b84146196c@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-08-16 11:20:32, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/8/15 22:30, Petr Mladek wrote:
> > Added Kees and hardening mailing list into Cc.
> > 
> > On Fri 2023-08-11 15:49:21, thunder.leizhen@huaweicloud.com wrote:
> >> From: Zhen Lei <thunder.leizhen@huawei.com>
> >>
> >> Currently, function print_hex_dump() supports three dump prefixes:
> >> DUMP_PREFIX_NONE, DUMP_PREFIX_ADDRESS and DUMP_PREFIX_OFFSET. But for some
> >> usage scenarios, they don't work perfectly. For example, dump the content
> >> of one task's stack. In order to quickly identify a stack frame,
> >> DUMP_PREFIX_ADDRESS is preferred. But without boot option no_hash_pointers
> >> , DUMP_PREFIX_ADDRESS just print the 32-bit hash value.
> >>
> >> dump memory at sp=ffff800080903aa0:
> >> 00000000a00a1d32: 80903ac0 ffff8000 8feeae24 ffffc356
> >> 000000007993ef27: 9811c000 ffff0d98 8ad2e500 ffff0d98
> >> 00000000b1a0b2de: 80903b30 ffff8000 8ff3a618 ffffc356
> >> ... ...
> >> 00000000a7a9048b: 9810b3c0 ffff0d98 00000000 00000000
> >> 0000000011cda415: 80903cb0 ffff8000 00000000 00000000
> >> 000000002dbdf9cd: 981f8400 ffff0d98 00000001 00000000
> >>
> >> On the other hand, printing multiple 64-bit addresses is redundant when
> >> the 'sp' value is already printed. Generally, we do not dump more than
> >> 64 KiB memory. It is sufficient to print only the lower 16 bits of the
> >> address.
> >>
> >> dump memory at sp=ffff800080883a90:
> >> 3a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
> >> 3aa0: 5833f000 ffff3580 00000001 00000000
> >> 3ab0: 40299840 ffff3580 590dfa00 ffff3580
> >> 3ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
> >> 3ad0: 40877180 ffff3580 590dfa00 ffff3580
> >> 3ae0: 4090f600 ffff3580 80883cb0 ffff8000
> >> 3af0: 00000010 00000000 00000000 00000000
> >> 3b00: 4090f700 ffff3580 00000001 00000000
> >>
> >> Let's add DUMP_PREFIX_CUSTOM, allows users to make some adjustments to
> >> their needs.
> >>
> >> For example:
> >> pr_info("dump memory at sp=%px:\n", sp);
> >> print_hex_dump(KERN_INFO, "%s%16hx: %s\n",
> >>                DUMP_PREFIX_CUSTOM, 16, 1, sp, 16, false);
> >> print_hex_dump(KERN_INFO, "%s%16x: %s\n",
> >>                DUMP_PREFIX_CUSTOM, 16, 1, sp, 16, false);
> >> print_hex_dump(KERN_INFO, "%s%px: %s\n",
> >>                DUMP_PREFIX_CUSTOM, 16, 1, sp, 16, false);
> > 
> > IMHO, this is pretty bad interface.
> > 
> >   + From the user POV:
> > 
> >     It is far from clear what values will be passed for the given
> >     printf format. It can be docummented but...
> > 
> > 
> >   + From the security POV:
> > 
> >     The compiler could not check if the printk() parameters
> >     match the format. I mean if the number of types of
> >     the parameters are correct.
> 
> Yes, it has these problems. So, back to v2, how about add DUMP_PREFIX_ADDRESS_LOW16?
> Or named DUMP_PREFIX_ADDR16 or others. Or change the format of DUMP_PREFIX_ADDRESS
> from "%p" to "%px"，Or add DUMP_PREFIX_RAWADDR. Or keep the status quo.

I would personally keep the status quo.

First, raw address should not be printed unless no_hash_pointers is
used. Otherwise, it would be a security hole. Yes, printing the last
16b is less risky. But it is still part of the puzzle. And for
debugging, people want/need to set "no_hash_pointers" anyway.

Second, IMHO, printing only the last 16b of the address is not much
useful for debugging. It can't be compared easily against other
addresses.

Third, 00000000a00a1d32 can be interpreted more easily than 1d32.
I mean, it is much more obvious that it is an "hashed" address.
Of course, this is less important for people who analyze hex
dumps on daily basis.

That said, the above would be valid when DUMP_PREFIX_ADDRESS_LOW16
is used in plain kernel sources. I understand that it might be
useful for temporary added debug messages. I am not sure what
was the use case which motivated this patch.

> Also, do you have any comments on patch 1/2?

I do not have strong opinion.

The auto adjusting of the width makes it easier to read for humans.
But it might complicate some post-processing using a script.

Best Regards,
Petr
