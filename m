Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F2F7E28E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjKFPlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjKFPlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:41:12 -0500
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A15B10A;
        Mon,  6 Nov 2023 07:41:08 -0800 (PST)
Message-ID: <919fa20e0951f962944b1f5c337a5911.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1699285266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91z7ELyQh9QsVWjhG+Jw0Nh7GkaLuv75onmOXjXEpqs=;
        b=IrOI4ZzXo1pU7MQ8AaXfJo9qPuIR5a9leW+i2RydPEMWFpeXlihreM+UsZHxZ9SiGC0ctq
        I6iCqX3PH4h0Uygf6kXtKQ9lrN0vlxrPsnUE978UWCp3uLdyca4AnuP0SB1ByMwLsfeHbE
        Xc8wDx7tenHVxyYQCOCMCyw6MawOqYXLxAbr5XG8/XSZPuDz/PrXaG+cGSBsJoP+bdYWMO
        3GBJgugK6xvCtaSNWyL/pNj4GXacItXKmqCS/On/UzLCvbkA5UoDOO/lpJalF3+m+2vg8S
        8dfs1yC/y2R/6kKPW2lPtHmrHKozqxYUw+j3Jk8M17psjierGAkTr6MODLcrlw==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1699285266; a=rsa-sha256;
        cv=none;
        b=rb5yJBo0+t2qoQ8Wt0xey1Y3HCSlFWJyNay4GFixF3FoE2EqC8qVHOrid2kvoyacFGr9t/
        SpTkp2gmpVwyOijrn7h68cpwO7vTKBqrXpqA8E+RFoDi+l84qMLWPL0j4A1d+Bp2vMPfMO
        3+FhxZ+HtQ3ePRJF1K4+7F6/Sthsx2xUPV1oqUOszSi6l1RcLOTBeN6Rr66xgClO6GhA59
        Smth8mRpO9sJhcji8ohpdaL78Ix5YncBKpMFqS2u0mKlOxk6cm00KiCRPY1enZIDDDI3cJ
        zQ+fyIr4ONXKQWmEkjbYEq9TPCs309LC6eGyKhVSaMVtJv7mjwdWN4jJ85YVwg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1699285266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91z7ELyQh9QsVWjhG+Jw0Nh7GkaLuv75onmOXjXEpqs=;
        b=sFnJj1JXUZOZ+TmfIXD/4uWQy6/5NTw9EgDiVKlRmWmfqg3ZfIjX3gEtCQTDL4CWanpTy6
        /wo/6DiK42PE7oLN3zA8z+EjTZxsewI5cwkDsfDc75j22IaIQtO9shPYf18utob3MwVPSX
        +zmhTRkkFgvxwTcYX2k5qmCyHTnZaWMNzLLewckxJabsHeRPryDFAtx/KCE6mw7EqR2ksg
        W69TaPeh0NtfTQl48px4XVUve8n5H/YenbEWyEr940RDIVi9QP0iWOhwdtvHe6TgSwcbqA
        qn0o6zlUX4jlBnu+sul/7Ypc1MHqs+b13dAYLOURCT4muTxjlT3UCFol9qw6ZQ==
From:   Paulo Alcantara <pc@manguebit.com>
To:     David Howells <dhowells@redhat.com>,
        Damian Tometzki <damian@riscv-rocks.de>
Cc:     dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
        Steve French <smfrench@gmail.com>,
        John Sanpe <sanpeqf@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cifs: Fix encryption of cleared, but unset rq_iter data
 buffers
In-Reply-To: <2610852.1699281611@warthog.procyon.org.uk>
References: <ZUiXkPPP1TuOgmmf@fedora.fritz.box>
 <20231022183917.1013135-1-sanpeqf@gmail.com>
 <ZUfQo47uo0p2ZsYg@fedora.fritz.box>
 <CAH2r5msde65PMtn-96VZDAQkT_rq+e-2G4O+zbPUR8zSWGxMsg@mail.gmail.com>
 <20231105193601.GB91123@sol.localdomain>
 <ZUfvk-6y2pER6Rmc@fedora.fritz.box>
 <20231105201516.GC91123@sol.localdomain>
 <2610852.1699281611@warthog.procyon.org.uk>
Date:   Mon, 06 Nov 2023 12:41:01 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> cifs: Fix encryption of cleared, but unset rq_iter data buffers
>
> Each smb_rqst struct contains two things: an array of kvecs (rq_iov) that
> contains the protocol data for an RPC op and an iterator (rq_iter) that
> contains the data payload of an RPC op.  When an smb_rqst is allocated
> rq_iter is it always cleared, but we don't set it up unless we're going to
> use it.
>
> The functions that determines the size of the ciphertext buffer that will
> be needed to encrypt a request, cifs_get_num_sgs(), assumes that rq_iter is
> always initialised - and employs user_backed_iter() to check that the
> iterator isn't user-backed.  This used to incidentally work, because
> ->user_backed was set to false because the iterator has never been
> initialised, but with commit f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74[1]
> which changes user_backed_iter() to determine this based on the iterator
> type insted, a warning is now emitted:
>
>         WARNING: CPU: 7 PID: 4584 at fs/smb/client/cifsglob.h:2165 smb2_get_aead_req+0x3fc/0x420 [cifs]
>         ...
>         RIP: 0010:smb2_get_aead_req+0x3fc/0x420 [cifs]
>         ...
>          crypt_message+0x33e/0x550 [cifs]
>          smb3_init_transform_rq+0x27d/0x3f0 [cifs]
>          smb_send_rqst+0xc7/0x160 [cifs]
>          compound_send_recv+0x3ca/0x9f0 [cifs]
>          cifs_send_recv+0x25/0x30 [cifs]
>          SMB2_tcon+0x38a/0x820 [cifs]
>          cifs_get_smb_ses+0x69c/0xee0 [cifs]
>          cifs_mount_get_session+0x76/0x1d0 [cifs]
>          dfs_mount_share+0x74/0x9d0 [cifs]
>          cifs_mount+0x6e/0x2e0 [cifs]
>          cifs_smb3_do_mount+0x143/0x300 [cifs]
>          smb3_get_tree+0x15e/0x290 [cifs]
>          vfs_get_tree+0x2d/0xe0
>          do_new_mount+0x124/0x340
>          __se_sys_mount+0x143/0x1a0
>
> The problem is that rq_iter was never set, so the type is 0 (ie. ITER_UBUF)
> which causes user_backed_iter() to return true.  The code doesn't
> malfunction because it checks the size of the iterator - which is 0.
>
> Fix cifs_get_num_sgs() to ignore rq_iter if its count is 0, thereby
> bypassing the warnings.
>
> It might be better to explicitly initialise rq_iter to a zero-length
> ITER_BVEC, say, as it can always be reinitialised later.

Agreed.  We could probably set those in ->init_transform_rq().

> Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
> Reported-by: Damian Tometzki <damian@riscv-rocks.de>
> Link: https://lore.kernel.org/r/ZUfQo47uo0p2ZsYg@fedora.fritz.box/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Namjae Jeon <linkinjeon@kernel.org>
> cc: Tom Talpey <tom@talpey.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Eric Biggers <ebiggers@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1b4cb650b9a0eeba206d8f069fcdc532bfbcd74 [1]
> ---
>  fs/smb/client/cifsglob.h |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

FWIW, the patch fixes mounts of shares with encryption enabled.

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
