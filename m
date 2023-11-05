Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA857E1651
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjKEUPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKEUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:15:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D1D9;
        Sun,  5 Nov 2023 12:15:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7775FC433C8;
        Sun,  5 Nov 2023 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699215318;
        bh=9MlvejV7rzo/nwVHuRYjeemjlpne3ZKQI5XVKZjAhtg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MMS46jnYMuApKwnMas117htvbNlG4va75xtF0p13nR2evQANDyuCN+pbmDUfC8g4a
         I5wF2ulngEoTOU2chey4HRrby3cpWpp1QbuSqhckq8egE8/Bj95NerRa7iMrj3AYnj
         ugzSa4RTU6+dsYoO6gfDUwR+8bH8RQ/eyCU4dHqleBQ4CYm6v5FE+ZSFds0zLUiEhR
         gqyehNDjgwc6F2b/PuggrsLkgJLFRV/DJDlAtI2V/Lx98+Arxq+szwrDARW7F1yDP4
         D3rzeN0QydGyX3Kf+3o2AWGlDFqz5zZ/Fs2I0zYmMtxFL8E4A0aRlt6Xaqv+s/q+TN
         KK74SLkfahrZw==
Date:   Sun, 5 Nov 2023 12:15:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Steve French <smfrench@gmail.com>,
        Damian Tometzki <damian@riscv-rocks.de>,
        John Sanpe <sanpeqf@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Paulo Alcantara <pc@manguebit.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: smb cifs: Linux 6.7 pre rc-1 kernel dump in smb2_get_aead_req
Message-ID: <20231105201516.GC91123@sol.localdomain>
References: <20231022183917.1013135-1-sanpeqf@gmail.com>
 <ZUfQo47uo0p2ZsYg@fedora.fritz.box>
 <CAH2r5msde65PMtn-96VZDAQkT_rq+e-2G4O+zbPUR8zSWGxMsg@mail.gmail.com>
 <20231105193601.GB91123@sol.localdomain>
 <ZUfvk-6y2pER6Rmc@fedora.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUfvk-6y2pER6Rmc@fedora.fritz.box>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 08:40:03PM +0100, Damian Tometzki wrote:
> On Sun, 05. Nov 11:36, Eric Biggers wrote:
> > On Sun, Nov 05, 2023 at 11:05:30AM -0700, Steve French wrote:
> > > maybe related to this recent crypto patch?
> > > 
> > > https://git.samba.org/?p=sfrench/cifs-2.6.git;a=commit;h=783fa2c94f4150fe1b7f7d88b3baf6d98f82b41b
> > > 
> > > On Sun, Nov 5, 2023, 10:32 Damian Tometzki <damian@riscv-rocks.de> wrote:
> > > > [   83.530503] CPU: 7 PID: 4584 Comm: mount.cifs Tainted: G        W
> > > >     6.6.0 #61
> > > > [   83.530508] Hardware name: LENOVO 20XWCTO1WW/20XWCTO1WW, BIOS N32ET86W
> > > > (1.62 ) 07/12/2023
> > 
> > The above suggests that this warning occurred on 6.6, not on 6.7 pre rc1.
> > 
> > - Eric
> Hello,
> 
> is little bit missleading but it is 6.6 from linus mainline git with all
> the pull request. 
> 
> Damian
> 

Okay, next time please mention the actual commit ID.  Anyway, the warning is
'WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter))', so maybe take a look at
changes from 

    commit f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74
    Author: David Howells <dhowells@redhat.com>
    Date:   Mon Sep 25 13:03:03 2023 +0100

        iov_iter: Derive user-backedness from the iterator type

and the pull request that contained it:

    commit df9c65b5fc7ef1caabdb7a01a2415cbb8a00908d
    Merge: 3b3f874cc1d07 b5f0e20f444cd
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Mon Oct 30 09:24:21 2023 -1000

        Merge tag 'vfs-6.7.iov_iter' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs

        Pull iov_iter updates from Christian Brauner:
         "This contain's David's iov_iter cleanup work to convert the iov_iter
          iteration macros to inline functions:
