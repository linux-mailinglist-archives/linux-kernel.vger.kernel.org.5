Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB35878EA36
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbjHaKaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjHaKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:30:15 -0400
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808D1CF3;
        Thu, 31 Aug 2023 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=V6+vGYvq9Ire2nZ/1cMUzhYc/H6nR5gZGxtRuso2jbY=; b=hW3U+E/zCfg97z1i5EnmqtycDO
        oBHvbe4PWhtWQWadGcmKSZBJUaN4PA8LgLz6fmya4vC66dkY+dNkDW3VWD8o9VEAXNoL2rRCtvSjK
        oeoGVmsuf66/rv9OEnt/3tkaumPdhOYVZfmce2hN4aX6pjUSRQMp5LFqQRy41AQRts8FrjeAQKUdx
        nwHKoA1r1j5IflSfQPNd3iYiK2GEDq1A+Q1Ie9hqZxA/mhVvm0chA9/L62DHFqmnP7admGVNLid2U
        4TCe2RW5uRbYZX5JxLVjl5gV8T+wKewVaLSNJVRfFJl+7frpV4XbKhuk5Ahv4iA7r78fmR1amf22Y
        P6CQexUw==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qbew9-009TQG-De; Thu, 31 Aug 2023 10:30:05 +0000
Date:   Thu, 31 Aug 2023 10:30:05 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steve French <smfrench@gmail.com>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] smb3 client fixes
Message-ID: <ZPBrrfEw5xDx44Gm@gallifrey>
References: <CAH2r5mtpOtiP3Hk6FJPav8tYDhKJTQmELP31zYzVxf4DPNKbiQ@mail.gmail.com>
 <CAHk-=wiCPoGieS-hkV+ze6UqvzNyPNT7WoD_v54ZuVwi-d5Bmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHk-=wiCPoGieS-hkV+ze6UqvzNyPNT7WoD_v54ZuVwi-d5Bmw@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 10:27:51 up 55 days, 19:59,  1 user,  load average: 0.01, 0.01, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@linux-foundation.org) wrote:
> On Wed, 30 Aug 2023 at 13:48, Steve French <smfrench@gmail.com> wrote:
> >
> > - move UCS-2 conversion code to fs/nls and update cifs.ko and jfs.ko to use them
> 
> I've pulled this, but I think the new NLS_UCS2_UTILS config option
> shouldn't be something that is asked about. The filesystems that want
> it already select it, and users shouldn't be asked about a module with
> no use.
> 
> The way to do that is to simply not have a user query string for it,
> ie instead of
> 
>   config NLS_UCS2_UTILS
>           tristate "NLS UCS-2 UTILS"
> 
> it could be (an dI think should be) just
> 
>   config NLS_UCS2_UTILS
>           tristate
> 
> which tells the config system not to ask users about it.
>
> Because users really shouldn't be asked questions that there is no point in.

Agreed.
I'll check it today and send a patch.

Thanks,

Dave

> 
> And then, on a purely visual commentary about your pull request -
> lines like these are just noise:
> 
> >  fs/{smb/server/uniupr.h => nls/nls_ucs2_utils.c} | 156
> > +++++-------------------------------------
> >  fs/nls/nls_ucs2_utils.h                          | 285
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> and the problem seems to be that you generate the diffstat in a very
> wide terminal (where git tries to be helpful and give you lots of
> detail), and then you cut-and-paste the result.
> 
> If you pipe it to a tool instead (xsel, perhaps), git will limit the
> width of the diffstat to something sane.
> 
> Or, if you really want to use a terminal and cut-and-paste it
> manually, you could try to tell git to use '--stat=72' to limit the
> stat to 72 characters (which is the canonical "width for email", as
> the Lord spake unto us all in rfc822, even if the Lord was confused
> and also mentioned the number 65).
> 
>                          Linus
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
