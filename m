Return-Path: <linux-kernel+bounces-44987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9938429FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A491F2952E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05073129A82;
	Tue, 30 Jan 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D/7vVAYS"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768421292DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633508; cv=none; b=PikqG7dtpb8GNpaeuVeGakEJblNIxE4ip0hhtgAXzph5uWL+YFi0MYxL/cOvoQaE6nicoh/4O1wbtES+W/klR/XLzpPVVBSIeYiMmbQjOnK3gp09DrfLJwcPU6bMoGcWEy55qfALE54iCBVhdobfI6dpeaL5NtTjF2iuu2Kg2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633508; c=relaxed/simple;
	bh=6pk4EMPwM/GZJqfsyNUfNAyQZvIdX3nzBLZMjB+WaU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3VUL6qH6lfnZ0lzlkODyhIlrVLmTtwgvpZ15ZCGLjNZH9kfUUReuWClA3ePgtRnyVFpqBIsbT+2t8Unjh7VKk5w3iRXpJgpfVfM0wv0d0BtoQTJt3nN50ovs9nF/389p2p/w2magHeMILR8SH4GoOxa3bsLGnRC6OTUqzk0qes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D/7vVAYS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3604697d63so220548566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706633504; x=1707238304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9RgrDb4wmHhcjvdDxKDrDt4lCtyY1QCJi2L90SuDuf4=;
        b=D/7vVAYSsfbaDpRQk0LwDFFa3ivzsSwReBaXQdYBkOmNEaChjEdE20v0FHPKJ4xTwU
         xfyvBl2mG2RaNDjAMKWVdgrjYa1mMHEv5rakgZTUHDgXXagFk8/ms2w4duOL/PgGstNI
         3ykngGJXXEZw4x/NamVy9j8cy2brQahcIp3YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706633504; x=1707238304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RgrDb4wmHhcjvdDxKDrDt4lCtyY1QCJi2L90SuDuf4=;
        b=QC82V3U5ijaJQDtZER7fVbHoPYEjEyhyhJcPtqCyWM5WEU0Yjmv6wfddo0AKkowjLp
         RkzMw21KPcKcB8VLzyHc9G/c8iE69FYUpjeWbdd581UwojYtRVAZdnsdOu3rU+AsueyQ
         K+p+yi0d+vufPCiDo09y+SOdN743y/Ey9U3tSrSr6sOmH19+6zwj8H2/drzTLJX5Sa7P
         J83EWKtzaE+8tHjysKfOyzWODA23uDlub34Cv8gGrmx4SAzcisvY3ybkd6o6JMPYF+XF
         WP7PkkLeUnJgryloXqErLOqePjcBPL6bHgw9HUjAQu6PYUoMIPAc/U6GToEuCP27YREr
         zjww==
X-Gm-Message-State: AOJu0YwPN5HQn4ZlydLi/6FN0Bc72ZkFKCH+EakibztwM7bqQFauFnme
	FNA3Duv3Y0XWWAoaq21YU1SzHbDxfSBJ6crXbICk8mE6kq+W73zX25n0MlCD+pOnpNM8Iz5SS3s
	u9ZSEBQ==
X-Google-Smtp-Source: AGHT+IEy6cxtaUzHbnJ51cgzh/f5xK97cz+waeUzuC6xM70++QeSPr09wbd4PhENDekcG8a/Li+INg==
X-Received: by 2002:a17:906:f2d6:b0:a31:5941:4f7 with SMTP id gz22-20020a170906f2d600b00a31594104f7mr6626993ejb.39.1706633504290;
        Tue, 30 Jan 2024 08:51:44 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id tl10-20020a170907c30a00b00a3554bb5d22sm3882462ejc.69.2024.01.30.08.51.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:51:43 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so4487458a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:51:43 -0800 (PST)
X-Received: by 2002:a05:6402:b76:b0:55e:f3ce:c621 with SMTP id
 cb22-20020a0564020b7600b0055ef3cec621mr4340740edb.2.1706633503394; Tue, 30
 Jan 2024 08:51:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
 <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
 <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com> <20240130093942.56206ff1@gandalf.local.home>
In-Reply-To: <20240130093942.56206ff1@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 08:51:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=whe_qeQVrz9=pVjCNVva8+OOJjmrpCj5CiHW3QStUf+6w@mail.gmail.com>
Message-ID: <CAHk-=whe_qeQVrz9=pVjCNVva8+OOJjmrpCj5CiHW3QStUf+6w@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 06:39, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 30 Jan 2024 01:12:05 -0800
> >
> > I suspect the solution is to make eventfs_create_dir() do the same as
> > the events directory case does, and actually pin the directory dentry
> > and save it off.
>
> I rather not have the create do that because that happens for every event
> directory.

I wasn't thinking straight yesterday - the real fix is to just do a
"d_revalidate()". It's literally why that thing exists: check whether
a dentry is still valid.

In fact, that trivially gets rid of the 'events' subdirectory issues
too, so we can stop doing that horrendous simple_recursive_removal()
too.

Let me reboot into the trivial fix. I just needed to think about this
the right way.

None of this is anything that the VFS layer has any problems with.

               Linus

