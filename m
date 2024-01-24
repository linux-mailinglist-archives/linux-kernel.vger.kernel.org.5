Return-Path: <linux-kernel+bounces-37353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F290783AEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF721F229BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304077E578;
	Wed, 24 Jan 2024 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ed5XcKxR"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D17E564
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114782; cv=none; b=Epv6mYLgHx5VHqgCFZQaZSbVsUMwBV8zmvDdpvqDjQx/JHgijYhMgdavIKV8CmHD2URbfP6fwXTGXMK76amrdkBu3xpmkgJ4AAoCxp7EcFRHGxOFLl+TbCRq4SCvHGqJO/blgCHqj3O1nPZcLZttjQGyqwFOk5hY2favf7jlpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114782; c=relaxed/simple;
	bh=2p6qpEQ0FQqgHQ9MZJ6hGygl88/GlnO048hMSuetf9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJPh2Opgloi/Mtkk0KvhG/xU08J2J7e08j2C6Vfk6pW2WfaHFsx79fneMF4bkGH6FkNqq7+hSQfEAvo3GUlqBuu6d6lTB95V9VI7l0TBJboAMxwThh1t1nvZzeIcleENoXcU+PRoB54G/f3DA/fy/WZvP8XX4eQQMn38gQUUrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ed5XcKxR; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a30e445602cso253058266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706114778; x=1706719578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAV9hUjIFjsOqBZPLiRvCMjNyiBrTHJa47CjdZfZGyc=;
        b=Ed5XcKxRANEFyjUxjVjM+3EXeg433iIdKQ+NHDBO13fP02ova6nbaTF5/mIECUYlcC
         oXqTqFqOKVJSU//AI1yKMDVsZo2EU//OFwcHjf/BQTPjZ5k1gJqueUPRHoZt16kiA4OD
         B8HhzlYJYM3GkFggqr5BhGgp38ODjMzMEJ35o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114778; x=1706719578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAV9hUjIFjsOqBZPLiRvCMjNyiBrTHJa47CjdZfZGyc=;
        b=BTgALKaU9ejRLx8Yp/MOzCt+bdRlLMLSZh0FHztxxU4CFNVi01Yro86b2LG8tFfUYv
         yRG01P0uU8ZlVD3wA5X3tco88aw82DS4BWsL+E5wo+IUufzt4+IPslE0k1Zkg1Oz9+hq
         PSVyzNmyWWQtRfoAKTe+yTHt9d82UNX7YdQ12Eh3V8p4tkxm7AZOYhx5FniB2ykquO7E
         rEnCDmbL7y7sr3g875XY/gu3vPiGeVpLSD/sN4bYNctGyWMEoNuPBb8mbXOVrWzl+GO9
         nwWbRUWDeeZt5pac1pp05xoesMf/J4zP2xZdTtx/DlI4DvmsoHFcHxj0ARluKzqM3gq+
         2WWA==
X-Gm-Message-State: AOJu0Yyo4ZbNDKTLCyetZyfIPZGQ0PzZVyyfVXsKc7xljwNtn7vIuh9g
	L3mmtvrOoOo41PsAhz8XjDGwtK0ZraVKq4sR8Web8xoHh2dispFpUfI7gktsEcxLb1mWEtSr4Wc
	DQCAhLQ==
X-Google-Smtp-Source: AGHT+IHNL24nucBfshUVDSzQRPjH08wW9PegIDLUPa8Gmh/xrAjBVP7+x3cDhc/qK7B9b+WR7qQmIw==
X-Received: by 2002:a17:906:4097:b0:a30:d9ee:3db6 with SMTP id u23-20020a170906409700b00a30d9ee3db6mr1505217ejj.51.1706114778692;
        Wed, 24 Jan 2024 08:46:18 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906261700b00a311a356760sm65509ejc.68.2024.01.24.08.46.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:46:17 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55cdaa96f34so658776a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:46:17 -0800 (PST)
X-Received: by 2002:aa7:d44a:0:b0:55c:c7f5:4ce3 with SMTP id
 q10-20020aa7d44a000000b0055cc7f54ce3mr1287114edr.5.1706114777365; Wed, 24 Jan
 2024 08:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
In-Reply-To: <202401240832.02940B1A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 08:46:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
Message-ID: <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:35, Kees Cook <keescook@chromium.org> wrote:
>
> Oh, yikes. This means the LSM lost the knowledge that this open is an
> _exec_, not a _read_.
>
> I will starting looking at this. John might be able to point me in the
> right direction more quickly, though.

One obvious change in -rc1 is that the exec open was moved much
earlier: commit 978ffcbf00d8 ("execve: open the executable file before
doing anything else").

If the code ends up deciding "is this an exec" based on some state
flag that hasn't been set, that would explain it.

Something like "current->in_execve", perhaps?

               Linus

