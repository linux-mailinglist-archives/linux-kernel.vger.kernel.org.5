Return-Path: <linux-kernel+bounces-45327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD680842E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AED2B2442C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D582B762DD;
	Tue, 30 Jan 2024 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQoCLCiI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E46762C3;
	Tue, 30 Jan 2024 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649371; cv=none; b=uaG/VsIZXuTVa1YSUQx7xDE9xzq6qQxsaiK5hcpy+/tbZSCuEETek7yRZDiNT8IMzgCvSzAs5JzfksJrHOVkIpckXBN34RYCKGlTSohcUa0AYZ2iYYBi9UFlOVCqUrxmqIxQoZqW4fi5iWmifmkQy4J8wcEGlk+DLVZqnj09PGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649371; c=relaxed/simple;
	bh=QEITiAA4fWnHv2p/4qhjdzmkLWUAM9VU7hpD8HwJ/Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhaVly2g1hVoA/yk8xDj0Mv5atmRQOVsAuJQrnTpYqG8KhmdVvMcW0/w0Sj3n7ccco/Fu5JekNv2354iIQoKqm0hOxqhR8A8u4oYvGrdA4jRBdOVVyIvJObSYtxZBVg/IPAMsqB2AEAjG1BbsxzsLcHDHlWdDwv4fD0VR076ywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQoCLCiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69782C433C7;
	Tue, 30 Jan 2024 21:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706649370;
	bh=QEITiAA4fWnHv2p/4qhjdzmkLWUAM9VU7hpD8HwJ/Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQoCLCiIRs0madwA6Bf1jlvV8wCtLFch0d00Z3zjj5Yl+IERbCzF6BKSAZWlaWonK
	 7PPEqqo1zhdR1soCXIjN3+KCJ84LZHdxRg/TqvAgNtMf4XCnRRAflYAyiT2cDyTE74
	 gknj7zAUVf5DXtz0prmR2p+Jk/MUTLuCpjznRk7hM8yhl0ugvL8Ye0x9IUdwjydBBx
	 0zVcnzjm3huFtRFAsaX/F4xIr4Zs/8p9/MW79STbUGNHjja5GiahUSsEiGyhoJIs8w
	 NdzHjYI++eZTdqj7mP3CQO3QtE2VTQ8FPURdfxbI3jMco9mMlrZa7JGJn1h+nMkxlh
	 0ZZCkTVmTXUsg==
Date: Tue, 30 Jan 2024 16:16:09 -0500
From: Sasha Levin <sashal@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 4.19 11/12] gfs2: Refcounting fix in
 gfs2_thaw_super
Message-ID: <ZblnGTNLbufz4gZx@sashalap>
References: <20240116002817.216837-1-sashal@kernel.org>
 <20240116002817.216837-11-sashal@kernel.org>
 <ZabrPnsVr6WHz2lM@duo.ucw.cz>
 <CAHc6FU70RD8fktBp=Srv6xeq3qXoLCdT8pi6y=1Y7bMHFK-mtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU70RD8fktBp=Srv6xeq3qXoLCdT8pi6y=1Y7bMHFK-mtQ@mail.gmail.com>

On Thu, Jan 18, 2024 at 12:50:37PM +0100, Andreas Gruenbacher wrote:
>On Tue, Jan 16, 2024 at 9:53 PM Pavel Machek <pavel@denx.de> wrote:
>> Hi!
>>
>> > From: Andreas Gruenbacher <agruenba@redhat.com>
>> >
>> > [ Upstream commit 4e58543e7da4859c4ba61d15493e3522b6ad71fd ]
>> >
>> > It turns out that the .freeze_super and .thaw_super operations require
>> > the filesystem to manage the superblock refcount itself.  We are using
>> > the freeze_super() and thaw_super() helpers to mostly take care of that
>> > for us, but this means that the superblock may no longer be around by
>> > when thaw_super() returns, and gfs2_thaw_super() will then access freed
>> > memory.  Take an extra superblock reference in gfs2_thaw_super() to fix
>> > that.
>>
>> Patch was broken during backport.
>>
>> > +++ b/fs/gfs2/super.c
>> > @@ -1013,6 +1013,7 @@ static int gfs2_freeze(struct super_block *sb)
>> >               goto out;
>> >       }
>> >
>> > +     atomic_inc(&sb->s_active);
>> >       for (;;) {
>> >               error = gfs2_lock_fs_check_clean(sdp, &sdp->sd_freeze_gh);
>> >               if (!error)
>> > @@ -1034,6 +1035,7 @@ static int gfs2_freeze(struct super_block *sb)
>> >       error = 0;
>> >  out:
>> >       mutex_unlock(&sdp->sd_freeze_mutex);
>> > +     deactivate_super(sb);
>> >       return error;
>> >  }
>>
>> Notice the goto out? That now jumps around the atomic_inc, but we
>> still do decrease. This will break 4.19, please fix or drop.
>
>Thanks, Pavel.
>
>Sasha, you don't want that fix without "gfs2: Rework freeze / thaw
>logic" and the follow-up fixes, and backporting that probably isn't
>going to be worth it.

I'll drop it, thanks!

-- 
Thanks,
Sasha

