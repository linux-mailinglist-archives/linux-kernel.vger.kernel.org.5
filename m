Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA2080F6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377141AbjLLTiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLTiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:38:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC856E3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702409887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IuPeLZWXHE618u58SYZuwlY/nbyijM369pAi7qe4tc=;
        b=TErN9J6wBBWeXWGVnSvnlWF8MwY6G5r9LWtymLiiwq+YlfWC4IyvdkXRacl0soTLCJbguW
        e1u6DcAqeNGDe0T/n9+60dNcf1xNplzNLtdwU2KC+ftHQjTjHDU4BCS5kaNWnBJQxG5fk/
        tS6juAT+d1GsvKPH6Bpt6F51h9R2qv0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-4hvy0escO82QLaECBEMHsQ-1; Tue, 12 Dec 2023 14:38:06 -0500
X-MC-Unique: 4hvy0escO82QLaECBEMHsQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c1b986082dso3797853a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409885; x=1703014685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IuPeLZWXHE618u58SYZuwlY/nbyijM369pAi7qe4tc=;
        b=ufMU2edca9qe4kDT6ToIpTyP3dZtpr0ygk8pOk7RJfpcRJYrdJqZen3JEP9aybGbbB
         Y6p+BisxNUtZQKvIBzBgvikc7M1E17IOy6jCWp/1zSJd+dUf/n9pgDCj+SHCdpj06afL
         vBRsmuU7vmoCv4/WUHInNFOYi9q5rkbcgjuipgUVTSFmkCaL3GbctuYt6PGKu7fQbUGs
         VmiOOl1GOGCJx7C1CoQN0Vcalk0mMjWQrLwqgUGF1QPK00mIMrPUhBuqiVims6mKez+5
         QlDbDTA16rQoFiEcvsh6LI7DB9RXTmliALXr70aZV3qres8phbBydFBCDc6mGIYoknYa
         jHlw==
X-Gm-Message-State: AOJu0YyP27UJ0PuvFG8BNNmOo29+nf8b2I9Y5FdEWjfRKyXXOFRFzWCj
        3Zi9iJT1TXa3md1wq+reB2UvW51uo8X+85ciKiglT6zNMRG2136jgPebOhwdMCmJ2f/oqedzdIL
        nWJ+OM4EuSQ3/XG4WJk2PRBRRGW6eK04L76/f49KW
X-Received: by 2002:a05:6a20:8e14:b0:190:23b2:cf1a with SMTP id y20-20020a056a208e1400b0019023b2cf1amr8374156pzj.22.1702409885415;
        Tue, 12 Dec 2023 11:38:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+xGISr5WA3vtBh1oLpeAPWxlRJLMhZYbs8WjSt+jRJh3aqZk+WkaQSNeow/CJnj8A0Z8u1z+KDKAxLqOe2Ig=
X-Received: by 2002:a05:6a20:8e14:b0:190:23b2:cf1a with SMTP id
 y20-20020a056a208e1400b0019023b2cf1amr8374144pzj.22.1702409885088; Tue, 12
 Dec 2023 11:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20231109190844.2044940-1-agruenba@redhat.com> <20231109220018.GI1957730@ZenIV>
 <CAHpGcMJfNNRDAvGhH-1Fs79uTks10XhLXBLeCqABoxufZeLGzw@mail.gmail.com> <20231109222254.GK1957730@ZenIV>
In-Reply-To: <20231109222254.GK1957730@ZenIV>
From:   Abhi Das <adas@redhat.com>
Date:   Tue, 12 Dec 2023 13:37:54 -0600
Message-ID: <CACrDRjhqrcDivT=gtYA_qMAzXEvBWg0LEnDSwSxYVvkuaT2fVw@mail.gmail.com>
Subject: Re: [PATCH] fs: RESOLVE_CACHED final path component fix
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Did you get a chance to look into the RCU pathwalk stuff a bit more?
Any ideas on how to allow may_open() to indicate to inode_permission()
that it's part of a RESOLVE_CACHED lookup?

Cheers!
--Abhi


On Thu, Nov 9, 2023 at 4:23=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Nov 09, 2023 at 11:12:32PM +0100, Andreas Gr=C3=BCnbacher wrote:
> > Am Do., 9. Nov. 2023 um 23:00 Uhr schrieb Al Viro <viro@zeniv.linux.org=
.uk>:
> > > On Thu, Nov 09, 2023 at 08:08:44PM +0100, Andreas Gruenbacher wrote:
> > > > Jens,
> > > >
> > > > since your commit 99668f618062, applications can request cached loo=
kups
> > > > with the RESOLVE_CACHED openat2() flag.  When adding support for th=
at in
> > > > gfs2, we found that this causes the ->permission inode operation to=
 be
> > > > called with the MAY_NOT_BLOCK flag set for directories along the pa=
th,
> > > > which is good, but the ->permission check on the final path compone=
nt is
> > > > missing that flag.  The filesystem will then sleep when it needs to=
 read
> > > > in the ACL, for example.
> > > >
> > > > This doesn't look like the intended RESOLVE_CACHED behavior.
> > > >
> > > > The file permission checks in path_openat() happen as follows:
> > > >
> > > > (1) link_path_walk() -> may_lookup() -> inode_permission() is calle=
d for
> > > > each but the final path component. If the LOOKUP_RCU nameidata flag=
 is
> > > > set, may_lookup() passes the MAY_NOT_BLOCK flag on to
> > > > inode_permission(), which passes it on to the permission inode
> > > > operation.
> > > >
> > > > (2) do_open() -> may_open() -> inode_permission() is called for the
> > > > final path component. The MAY_* flags passed to inode_permission() =
are
> > > > computed by build_open_flags(), outside of do_open(), and passed do=
wn
> > > > from there. The MAY_NOT_BLOCK flag doesn't get set.
> > > >
> > > > I think we can fix this in build_open_flags(), by setting the
> > > > MAY_NOT_BLOCK flag when a RESOLVE_CACHED lookup is requested, right
> > > > where RESOLVE_CACHED is mapped to LOOKUP_CACHED as well.
> > >
> > > No.  This will expose ->permission() instances to previously impossib=
le
> > > cases of MAY_NOT_BLOCK lookups, and we already have enough trouble
> > > in that area.
> >
> > True, lockdep wouldn't be happy.
> >
> > >  See RCU pathwalk patches I posted last cycle;
> >
> > Do you have a pointer? Thanks.
>
> Thread starting with Message-ID: <20231002022815.GQ800259@ZenIV>
> I don't remember if I posted the audit notes into it; I'll get around
> to resurrecting that stuff this weekend, when the mainline settles down
> enough to bother with that.
>

