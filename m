Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEBB7DC18F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjJ3VF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjJ3VFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B653CE1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698699916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JmURPcvLtSqLUUbFA7SrmnbERd26AC5lme3Qx7nOkM=;
        b=T/cc2gdQ9Ogl+lNkXTZ4+MnJ/+1mcVUxPEUf8ftjlI/eaC6EoR3O5e072R9RT6+ZUOhngS
        Zy2U9EMqDQIYd1ioRSLCsv+BX76lhLwZkAwyDJTKF3IUpN9ZpA1rvJ5qCbyhxG4axrEdrO
        SIyR3OfJgEF4zfFvBZeDCKx0BIc2rkE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-n5jPfTScMcG6JlCWLTDk8A-1; Mon, 30 Oct 2023 17:05:13 -0400
X-MC-Unique: n5jPfTScMcG6JlCWLTDk8A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b7bf1c206fso2996241a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699912; x=1699304712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JmURPcvLtSqLUUbFA7SrmnbERd26AC5lme3Qx7nOkM=;
        b=E5v87nffN4aPLmyZDJ9PxciP5WYPfed0NZX9hElGizhIvNLcPOSlBDmxVK0/MOcMbd
         mC4NSfo/vq4aaaNKzJcDvH3NSgcVrwm48huVMpUoRuZCgbBNLD7GbqN4WgWR6zvRuVdl
         Rd8PLWhW4JrHFvrgbyzXGejmRfaOVz50O+zyE9zl2dQodIh8zZ55A8dfQ9jyG5fJih7m
         rl697YE4VzmOc9ZAK1Z29iF1LHIKV8wqqFA5NEA9R4AR29wU3ybk3TpKjU9BghO/9Tfj
         t9cP5FlYbaTF7A/CDQl/FiT8pV2QFD1ez4FCzHhSXDDg0UyHM4FIOQFbDYDRf/4lv5Qf
         SgoA==
X-Gm-Message-State: AOJu0YzI1CkqUPsoAjLrz4rPC5nz3iJtHzm/GgHG5NWkZSa9EClNbE9E
        3KrA/v8ZpJV9pW5aUSZc645zmB4QWitOxLE/8gbaXTWsKUFKLgiiEt6hxODFgsNiNUldqLEG7zW
        7L/jhlYirv32vNZIqUu/x8KbSityTrF0wF7IduIs+
X-Received: by 2002:a17:902:bf44:b0:1ca:c490:8537 with SMTP id u4-20020a170902bf4400b001cac4908537mr8378144pls.14.1698699912579;
        Mon, 30 Oct 2023 14:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzbZk3QaOS4ZLoC9Xi0ie7QckJKqDxiUMckdm8KX4ydz1J+XDcKYN3ZT+xrDzl974H1L6JMnNQ06VhK1wjIKY=
X-Received: by 2002:a17:902:bf44:b0:1ca:c490:8537 with SMTP id
 u4-20020a170902bf4400b001cac4908537mr8378130pls.14.1698699912248; Mon, 30 Oct
 2023 14:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000c44b0060760bd00@google.com> <000000000000c92c0d06082091ee@google.com>
 <20231025032133.GA1247614@ZenIV>
In-Reply-To: <20231025032133.GA1247614@ZenIV>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 30 Oct 2023 22:05:00 +0100
Message-ID: <CAHc6FU4Zd0szGBzZBx212K4MgjFJAEMwD1jbTraw0ihMG14Z2w@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>,
        cluster-devel@redhat.com, gfs2@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        postmaster@duagon.onmicrosoft.com, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

On Wed, Oct 25, 2023 at 5:29=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Fri, Oct 20, 2023 at 12:10:38AM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 0abd1557e21c617bd13fc18f7725fc6363c05913
> > Author: Al Viro <viro@zeniv.linux.org.uk>
> > Date:   Mon Oct 2 02:33:44 2023 +0000
> >
> >     gfs2: fix an oops in gfs2_permission
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10b21c33=
680000
> > start commit:   2dac75696c6d Add linux-next specific files for 20231018
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12b21c33=
680000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14b21c33680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6f8545e1ef7=
a2b66
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3e5130844b0c0=
e2b4948
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D101c8d096=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11a07475680=
000
> >
> > Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com
> > Fixes: 0abd1557e21c ("gfs2: fix an oops in gfs2_permission")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> Complaints about rcu_dereference() outside of rcu_read_lock().
>
> We could replace that line with
>         if (mask & MAY_NOT_BLOCK)
>                 gl =3D rcu_dereference(ip->i_gl);
>         else
>                 gl =3D ip->i_gl;
> or by any equivalent way to tell lockdep it ought to STFU.

the following should do then, right?

    gl =3D rcu_dereference_check(ip->i_gl, !(mask & MAY_NOT_BLOCK));

> BTW, the amount of rcu_dereference_protected(..., true) is somewhat depre=
ssing...
>
> Probably need to turn
>                 ip->i_gl =3D NULL;
> in the end of gfs2_evict_inode() into rcu_assign_pointer(ip->i_gl, NULL);

That's what commit 0abd1557e21c6 does already so there's nothing to fix, ri=
ght?

> and transpose it with the previous line -
>                 gfs2_glock_put_eventually(ip->i_gl);
>
> I don't think it really matters in this case, though - destruction of the=
 object
> it used to point to is delayed in all cases.  Matter of taste (and lockde=
p
> false positives)...

I don't understand. What would lockdep complain about here?

Thanks,
Andreas

