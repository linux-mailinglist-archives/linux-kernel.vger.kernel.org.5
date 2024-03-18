Return-Path: <linux-kernel+bounces-106559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E54487F046
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85D0283C07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AA75674C;
	Mon, 18 Mar 2024 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P8nZzR4H"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F056468
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789280; cv=none; b=Pb9nukDWNDnWgmNBvxeePT+VG3737MjbzgTLOPTo6ImggMSSJWAzSGNch4KU9DFGQJ9XElx7pRz/p2piwCI/wcGo9M+xKklOJk/gTWsNOVB7jaP+fl8DgPiPBGNINYRT/IDk96ZrQI/ELP0mOYIE2w++PhrNzLILA5ZkwmxRTIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789280; c=relaxed/simple;
	bh=ZM7EmXC1nFNCsh6vA7OcOL1R8WaE0YVIRhn6pPNKQus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg7VJSpY+qqapFS2zmexR/BEYanhryEubBEnTziQ3vgy5V75mc8IBZwO2CuQ0wswSaMMGORMorjab3GNHRnHRDPVvwq4v9nvBE8BKAe/C4en2cHQLXO/XiWPL+zBjK+niHuf0AuHWVkhOrNXZg/HA3/Iz+3m2fTBheSJfQnligE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P8nZzR4H; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56a2b881911so1545650a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710789276; x=1711394076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oN4fiPM3Eza8VdazjMa5IGx7BirNAfpH5hEdexWHLK8=;
        b=P8nZzR4HLsB5KAB85y/fU9iCsYP6OfyJXGuVrHzMGhMvJ/weSlKrRV4XrQcNx0Z7xf
         wDV7fjsn2yg/p88LvQ/SylzKOEaFfIHMDDiqeOpJJnAFcMkIw+Dxzz/TahAYlpbLFAV3
         BdWJFqRIwiUiPX1hMJw2o2feiq4wEKNl/MzgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710789276; x=1711394076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oN4fiPM3Eza8VdazjMa5IGx7BirNAfpH5hEdexWHLK8=;
        b=cnxac6RsSUjzLe5wNs4MtJXMauVsOk8e45VrZyHguGFahZwqn3jUJ1tcvTpxYT+I03
         wpSAr2SX7sHeAU5xRa6Gsgaam6+D6hoFxj+QNUv25zJO0i81mLOmbeD+mksaYnl2d1Jp
         bWTkAP+WfAIEYoh37w9ENpu0YmnECPq8i7Org5L+iB+Z92aC71tYv+8sc23CVaVra5gq
         HwgSgHkLMTqVUG4MjssUPjLuH4WiVNe6VNtUoAhTgE/qvcUNTg+d7QpRl6nAQu6+4xEO
         fahcuj/fHN5mR16HI5mklFtT2BqOhCaqdjSGUmjWSJQwSrair0sJulf8jUEzb+cZ+S7G
         goZg==
X-Forwarded-Encrypted: i=1; AJvYcCWoKncsgaPASyzi9EUjUCZfo5EX5Xt9Th/pxn8Ef4Adx4J/EMT3k0epuOIBdL83f+5uAuzdeABwDVHwGrTU3wnygTMDSt5k3SEn/yla
X-Gm-Message-State: AOJu0YwXDHP5Sq0HnkDx46wtsoaTMD5BKNp+KR21eQYKJ5ugOg/NkO53
	NYpxhUBgLA55AVxJfe7g7lvdTMYDHY+O2gzfSWmnzR0lidu7zh/4btgg9GxvLk88e5Si51pI85U
	NmCpI6A==
X-Google-Smtp-Source: AGHT+IFsPU/tm7b9HYKTvS798L8Plm7bPrr8qvLzSpgVNQjyB4j4k7iYaDF862rVo4NGsAq8+Sirnw==
X-Received: by 2002:a05:6402:e0a:b0:566:8495:d4ef with SMTP id h10-20020a0564020e0a00b005668495d4efmr325212edh.32.1710789276590;
        Mon, 18 Mar 2024 12:14:36 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b00569aed32c32sm1447611edw.75.2024.03.18.12.14.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 12:14:36 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46cf8f649dso114966466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:14:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUq3NIiRCP8JdW8IPjGWAh3N7itpB6/qXE97Ro+P1AkO4DXIvtFSjZylHo76hPjBMC2joIrrLPo8LD6vednc+uZQODJYnD0TWUecmmU
X-Received: by 2002:a17:906:2ed7:b0:a46:bc3a:cc91 with SMTP id
 s23-20020a1709062ed700b00a46bc3acc91mr157204eji.44.1710789275586; Mon, 18 Mar
 2024 12:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
In-Reply-To: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Mar 2024 12:14:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
Message-ID: <CAHk-=wj-uKiYKh7g1=R9jkXB=GmwJ79uDdFKBKib2rDq79VDUQ@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Mar 2024 at 05:20, Christian Brauner <brauner@kernel.org> wrote:
>
> * Take a passive reference on the superblock when opening a block device
>   so the holder is available to concurrent callers from the block layer.

So I've pulled this, but I have to admit that I hate it.

The bdev "holder" logic is an abomination. And "struct blk_holder_ops"
is horrendous.

Afaik, we have exactly two cases of "struct blk_holder_ops" in the
whole kernel, and you edited one of them.

And the other one is in bcachefs, and is a completely empty one with
no actual ops, so I think that one shouldn't exist.

In other words, we have only *one* actual set of "holder ops".  That
makes me suspicious in the first place.

Now, let's then look at that new "holder->put_holder" use. It has
_one_ single user too, which is bd_end_claim(), which is called from
one place, which is bdev_release(). Which in turn is called from
exactly one place, which is blkdev_release(). Which is the release
function for def_blk_fops. Which is called from __fput() on the last
release of the file.

Fine, fine, fine. So let's chase down *who* actually uses that single
"blk_holder_ops". And it turns out that it's used in three places:
fs/super.c, fs/ext4/super.c, and fs/xfs/xfs_super.c.

So in those three cases, it would be absolutely *wrong* if the
'holder' was anything but the super-block (because that's what the new
get/put functions require for any of this to work.

This all smells horribly bad to me. The code looks and acts like it is
some generic interface, but in reality it really isn't. Yes, bcachefs
seems to make up some random holder (it's a one-byte kmalloc that
isn't actually used), and a random holder op structure (it's empty, as
mentioned), but none of this makes any sense at all.

I get the feeling that the "get/put" operations should just be done in
the three places that currently use that 'fs_holder_ops'.

IOW, isn't the 'get()' always basically paired with the mounting? And
the 'put()' would probably be best done iin kill_block_super()?

I don't know. Maybe I missed something really important, but this
smells like a specific case that simply shouldn't have gotten this
kind of "generic infrastructure" solution.

               Linus

