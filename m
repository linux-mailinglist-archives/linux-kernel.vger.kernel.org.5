Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E13F7E517F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjKHH6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKHH6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:58:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92831171D;
        Tue,  7 Nov 2023 23:58:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A22CC433CA;
        Wed,  8 Nov 2023 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699430324;
        bh=/7dt/Cvecp2TaRoRRfdH0FfeT15JD49KeWWQ74HCxkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRWF/y0nr4Vo0b/zqASi2aeEg46eJaHit71ua87oNM+VcnMkIX15jzZ60Y1g0Qa7K
         b9VDjItdfrIIx1oBqTKK1FAKz0jJamxBeOkk7ezZgJ7eKrdA6MNJa06NJ9JGG5oDHM
         /OUySAEx9otUhxAVhvKHjZ29jBMx92N8ER6SUeDt2DvuKJVQkLkmCG8A+bZ23Z/dF+
         o2gKCbIv0uO+kBmCRyv/UJqxtpiYPj0itMo9HmxTNTwFE2oVgCkhQdC6MAwukAyMvE
         +4mrhbFVIQqPIHRl9kwp3s3pXXmaJEXW0TwUok7LFjcBFN/HZPL0ckGFzQ0U7t+g6p
         HDheGhUYdd+Tw==
Date:   Wed, 8 Nov 2023 08:58:32 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 4/6] add statmount(2) syscall
Message-ID: <20231108-zwerge-unheil-b3f48a84038d@brauner>
References: <20231025140205.3586473-5-mszeredi@redhat.com>
 <4ab327f80c4f98dffa5736a1acba3e0d.paul@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ab327f80c4f98dffa5736a1acba3e0d.paul@paul-moore.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int do_statmount(struct stmt_state *s)
> > +{
> > +	struct statmnt *sm = &s->sm;
> > +	struct mount *m = real_mount(s->mnt);
> > +	size_t copysize = min_t(size_t, s->bufsize, sizeof(*sm));
> > +	int err;
> > +
> > +	err = security_sb_statfs(s->mnt->mnt_root);
> > +	if (err)
> > +		return err;
> > +
> > +	if (!capable(CAP_SYS_ADMIN) &&
> > +	    !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> > +		return -EPERM;
> 
> In order to be consistent with our typical access control ordering,
> please move the security_sb_statfs() call down to here, after the
> capability checks.

I've moved the security_sb_statfs() calls accordingly.
