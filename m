Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDD17E7F96
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjKJR4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKJRzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B3AFAC;
        Fri, 10 Nov 2023 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=aAA3dG3KqldTpNWyLJbx7Ihw915hKmwBjd6hcd38rpo=;
        t=1699607200; x=1700816800; b=U+TV4QmHX9inmiakgvsXStLBoJG5IjvkhQp86rF9jRCEiS7
        hwjlpSO1PK6on3C9ETbajn73FFlIAdMQjeKP3Hz3hH6JS6jnOyjO8JIruu1Azk2f7O9gk+O9zU0v6
        o6jcpNJ+7pH4Dohfp1jNF0H9MT8kqDPQOCzmRb2THqYNKA/DCzHknRuqIxYojOXgfgKUu/OB4kieG
        PP2mXmAhrlvjuAksMzozk0Bc2WeKhxd4MNNdy4L6vQWB1Ne98PWorkR0aBHlbNPQ33pbdYQZVvmhe
        K/IhoTWbwkN4Nqdow5BeLXE5kjZnTYvZtygmpfM3p6Kpl84XrIQoH5aiX3QRUpbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r1NTI-00000002u7Q-0SQI;
        Fri, 10 Nov 2023 10:06:36 +0100
Message-ID: <5cffded318675a981779194a73d97b274338b7d1.camel@sipsolutions.net>
Subject: Re: [PATCH] debugfs: only clean up d_fsdata for d_is_reg()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolai Stange <nicstange@gmail.com>
Date:   Fri, 10 Nov 2023 10:06:34 +0100
In-Reply-To: <2023111055-gratitude-prance-6074@gregkh>
References: <20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
         <2023111055-gratitude-prance-6074@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-10 at 04:56 +0100, Greg Kroah-Hartman wrote:
> >=20
> > Also check in debugfs_file_get() that it gets only called
> > on regular files, just to make things clearer.
> >=20
> > +++ b/fs/debugfs/file.c
> > @@ -84,6 +84,9 @@ int debugfs_file_get(struct dentry *dentry)
> >  	struct debugfs_fsdata *fsd;
> >  	void *d_fsd;
> > =20
> > +	if (WARN_ON(!d_is_reg(dentry)))
> > +		return -EINVAL;
>=20
> Note, the huge majority of Linux systems in the world run with "panic on
> warn" enabled, so if this is something that could actually happen,
> please just handle it and return the error, don't throw up a WARN()
> splat as that will reboot the system, causing you to have grumpy users.
>=20

Well, given the use of the d_fsdata, without this check you would get a
crash a few lines down in the code because:

1. if you call it with an automount dentry, the pointer is a function
   pointer and you can't increment a refcount in .text memory

2. if you call it with any other kind of entry other than regular, the
   pointer is NULL and you can't increment a refcount at just over NULL
   either

I would think this cannot happen in the current kernel now, so the check
is more (a) a sign to readers to show the intent of the function, and
(b) a help for future users of debugfs to tell them in easier terms when
they got it wrong. It just seemed nicer to not crash in weird ways (or
corrupt .text if you don't have read-only text, but is that still a
thing anywhere?) than crashing with strange errors (especially in 1.).

But hey, I can just as well remove it.

Note that the other part of the patch here is wrong anyway though, so
this patch isn't any good. I posted the replacement here:
https://lore.kernel.org/lkml/20231109222251.9e54cb55c700.I64fe5615568e87f9a=
e2d7fb2ac4e5fa96924cb50@changeid/

johannes
