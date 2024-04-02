Return-Path: <linux-kernel+bounces-128734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F786895ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34230289540
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899D15E80B;
	Tue,  2 Apr 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OYSBwejq"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB515E5D5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093768; cv=none; b=c2QydElxWNSCco0qvF/+I7mLuCFGJYHTzcdmVWU0UJL2SHKJbnAP/Mlg5uvfF8Tg0luXYDcyIlpsWe5MVFSpnJUCohHzAh9EMYrRNLzOp1rRvj3GFA5XTzxcnmgzXWjBSBU/6RAPQ7lWad1UmnLOJD42LaeCtJ2k9S7SFX2Kmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093768; c=relaxed/simple;
	bh=A+i2scP1i3n04ntHseA7vuTsn6YdwPi7luBLLidTYoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQC4Db8ErPDHIs5B0K/cb+vuIbF/eAHD1+B8pdFo+Tnm8ZH3nl+4yI4FDke8iXB42Db8/+92zyURVtglgGWQY88jtbcatXNONbI/6YgbfqqApfQwauVnDqsXyk9IayIDqfA195BfbgORyG4wsV0jXjlHpvS8jDumSNAh8SadCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OYSBwejq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516ab4b3251so2366728e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712093764; x=1712698564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P45Bu4wHn5RquDWpNCud3aZNlC5obFSwexJqgolasMk=;
        b=OYSBwejqUZSJatrUYwPEm5e8aXr1KKX1f4eM0m5EkMhAJGXumLRkdluegK0Snm5Ygu
         ciE9jICnlWSZmNV4MECoE2A8oBtEBktFme39CPNrRKoqgZTcyWywWo7ttQBowdD54+/I
         4gKWCirpXTcLXispnYV0PxICMRWz5MJfeb9Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093764; x=1712698564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P45Bu4wHn5RquDWpNCud3aZNlC5obFSwexJqgolasMk=;
        b=rrkbPPIjhI89JrS5Fp5fIKaa7aYatB0ins5ti89Q8BNIK9sOUxbHaJrtkua1dsyi1L
         BbWpHoqlVviE1FJyza5jOhWMfsMMk5gLsGkT9KKgcnhMzDAU2MLuvu2dliokMyWznEtw
         dYT9bI/Y4nbVNUETxvSV3Vhb0q8l6x+Hs0mlXV02WiZ6pHYgSjLEw1AYddK89YsUlNhu
         qKWO3n8Ef3pK9ncJKSt2RLwrLuMaZ/GeJ5XrpPk3hetb0cpseUHaIH3b8wE/0r+DecMC
         kjQbSdAjGUhLjRo+7m0zBYRsE6jQthbXvht6+GOCuvx5lSyc+BicGxH1RXeOgSCnj1Iq
         Tu0g==
X-Forwarded-Encrypted: i=1; AJvYcCWDCjEDY1qJPU0I0ejJXnjRIbFw09v6SrvYm2GEiHPhpU0rbOZ7j7NHeq/KPTOi+oTqIqA1SEG2SJQmETsK+z4AsCIvynhK3PQcfYyE
X-Gm-Message-State: AOJu0YxGp0DCQvOJ/MwNvDhPLSiZ2F8upnEzX/fh6Q4pornlg+JQEDMb
	OUPhX3ZEGFo3Q40Un2Oaj79tQaB0tFgSyUp+3HGYi/FdIV8VPwVEojFPCO8rcpJ/uHAIMwFfwdi
	r0I0=
X-Google-Smtp-Source: AGHT+IHHywaB9LV86Ayepl42a7Ei2Y1DQmhqYw6d9NQpVnzwkA4ajRfkIJpx3nb5GaWmhDNRSoUo+w==
X-Received: by 2002:a19:8c04:0:b0:515:9aba:743a with SMTP id o4-20020a198c04000000b005159aba743amr8999332lfd.59.1712093764453;
        Tue, 02 Apr 2024 14:36:04 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709062ec400b00a4a33cfe593sm6958186eji.39.2024.04.02.14.36.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 14:36:03 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e030624d1so388562a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 14:36:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKkyn1vSSfdNgiyAU5Zd3otytsvdtheL+D28RQ1oIetx2nz8AERDFwft747OPuVXKR0wLzx7FeqFOv1LKr9aIaUoXeipAYQgcaRrGR
X-Received: by 2002:a17:907:944a:b0:a4e:48d6:b9d7 with SMTP id
 dl10-20020a170907944a00b00a4e48d6b9d7mr11214699ejc.56.1712093763393; Tue, 02
 Apr 2024 14:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
 <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com> <20240402210035.GI538574@ZenIV>
In-Reply-To: <20240402210035.GI538574@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 14:35:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikLJEzBT1_7K5CMfc6DjNNevuYR8z-CfKgYLgwwDLVDA@mail.gmail.com>
Message-ID: <CAHk-=wikLJEzBT1_7K5CMfc6DjNNevuYR8z-CfKgYLgwwDLVDA@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 14:00, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         1) location of that hook is wrong.  It's really "how do we catch
> file creation that does not come through open() - yes, you can use
> mknod(2) for that".  It should've been after the call of vfs_create(),
> not the entire switch.  LSM folks have a disturbing fondness of inserting
> hooks in various places, but IMO this one has no business being where
> they'd placed it.  Bikeshedding regarding the name/arguments/etc. for
> that thing is, IMO, not interesting...

Hmm. I guess that's right - for a non-file node, there's nothing that
the security layer can really check after-the-fact anyway.

It's not like you can attest the contents of a character device or whatever...

>         2) the only ->mknod() instance in the tree that tries to leave
> dentry unhashed negative on success is CIFS (and only one case in it).
> From conversation with CIFS folks it's actually cheaper to instantiate
> in that case as well - leaving instantiation to the next lookup will
> cost several extra roundtrips for no good reason.

Ack.

>         3) documentation (in vfs.rst) is way too vague.  The actual
> rules are
>         * ->create() must instantiate on success
>         * ->mkdir() is allowed to return unhashed negative on success and
> it might be forced to do so in some cases.  If a caller of vfs_mkdir()
> wants the damn thing positive, it should account for such possibility and do
> a lookup.  Normal callers don't care; see e.g. nfsd and overlayfs for example
> of those that do.
>         * ->mknod() is interesting - historically it had been "may leave
> unhashed negative", but e.g. unix_bind() expected that it won't do so;
> the reason it didn't blow up for CIFS is that this case (SFU) of their mknod()
> does not support FIFOs and sockets anyway.  Considering how few instances
> try to make use of that option and how it doesn't actually save them
> anything, I would prefer to declare that ->mknod() should act as ->create().
>         * ->symlink() - not sure; there are instances that make use of that
> option (coda and hostfs).  OTOH, the only callers of vfs_symlink() that
> care either way are nfsd and overlayfs, and neither is usable with coda
> or hostfs...  Could go either way, but we need to say it clearly in the
> docs, whichever way we choose.

Fair enough.

Anyway, it does sound like maybe the minimal fix would be just that
"move it into the
                case 0: case S_IFREG:
path".

Although if somebody already has the cifs patch to just do the
d_instantiate() for mknod, that might be even better.

I will leave this in more competent hands for now.

Let the bike-shedding commence,

               Linus

