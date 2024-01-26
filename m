Return-Path: <linux-kernel+bounces-40539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F083E227
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B971C21DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FA4224C7;
	Fri, 26 Jan 2024 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cb6c0M8u"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA821373
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296014; cv=none; b=YIQgV6G+1JfqWIO6Se48bPmMFCY/x/1M0TXygEfhzE0LpKwPf2dQYUjWvQTvABEWvagPFJ6ZgixQGO6CPijsT1zHOMflz/vsaefb8hbg7kHYL1UCskLZZyU6W3w6jQC+f2S0/g2zb0QN9gUDlWZf8qQ85YWTNZ5b/mvmIONGrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296014; c=relaxed/simple;
	bh=u4QMmyhqfZPexfauxvPU4+cj2+a1AaNdzp8EfyoHBcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B54sMHPgt5jZirKOhCBQWxg4h0PKHgWMz09JKStpaJ+7lRt/Ysfp1e4SDkGmWarGS8aAdVTgnIe8z7xSkhC/IXGgH6O6GT0jHBpcCdaj4Ldmq31bqhnxisxcrGM/Lext+yKn/x5M4qsuSyvneCKl9m8Ddwn75KAQ0NF7VoTQoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cb6c0M8u; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso1411120e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706296011; x=1706900811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1dP7C1f8EQhzrHBctOG/vK1/Bgm4Z5gBZgBjg0ZQiw0=;
        b=cb6c0M8ubZW7HoFcqS3ikmBd69xWIDX3NWURSzf2rVUJTGOo1yj24X8aRCcuJichXM
         XXQh14UkDG3utibOXs7FNERUc/TXm9BGElsuszIlLEsosG7V7AiHgu5Z60uzwjhX6pEp
         eN74UJ8lMUMV9WslrvJGyDN5CYFooLUArHp7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706296011; x=1706900811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dP7C1f8EQhzrHBctOG/vK1/Bgm4Z5gBZgBjg0ZQiw0=;
        b=Kv00p6eBJU1PhoEWKIz07tI9kKIhPoMBnm3daBsK5bFRJ3acf5qHKlZ2N5tPkhhRAK
         Kd2cJdS+1r9b/pO28c0heyIQjYpbCgmtdV6WOY9MD9+oNQWbbp/S5CzxcIymmaofqdEi
         4SA7/n+gR3Datnbuonk/gQdNMafwUbx2Qbb3wn74O1y0TUtr66DO2bjGUbyUd7MsIob4
         FASePCASOgquRUzNpMDWTLeGwr9ArwC9uP0fW4UfAttDn4bwCRA5AvuMOU70thz5G/b5
         0IFUSkR/ct2javGof57YPcic5lyen6bu135E+V7JP9V2N+hpkinHdEUU1FT0F1r+/wXq
         RqRQ==
X-Gm-Message-State: AOJu0Yx3tb3DcTyN4/tscZWU9do5oiNcaJIqsCJMvf0B6vMS7w0lGH7g
	FfmmvucWXStI734NQ+rKu80ricL0nDRF8PuxeE3vARk8CYxgvRussoVRlRhfcJ2O9BN8uqB95QY
	Ur32sHQ==
X-Google-Smtp-Source: AGHT+IErICTsrL3TG79lXDbOTniEUoOHK0PUypvj3ZEijidjvXNQ8msiF6jxGw6c/sTT5UBBwt7j5w==
X-Received: by 2002:ac2:428a:0:b0:510:250b:494d with SMTP id m10-20020ac2428a000000b00510250b494dmr100210lfh.0.1706296010723;
        Fri, 26 Jan 2024 11:06:50 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id f19-20020a17090624d300b00a2f15b8cb76sm911285ejb.184.2024.01.26.11.06.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 11:06:50 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a8fb31fc2so615496a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:06:50 -0800 (PST)
X-Received: by 2002:a05:6402:1d9c:b0:55c:d7f5:d1e1 with SMTP id
 dk28-20020a0564021d9c00b0055cd7f5d1e1mr89897edb.22.1706296009700; Fri, 26 Jan
 2024 11:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126131837.36dbecc8@gandalf.local.home> <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
 <20240126134141.65139b5e@gandalf.local.home>
In-Reply-To: <20240126134141.65139b5e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 11:06:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTECUZLBgALpvm9zDN8TJCGxyc3VCEXXHMsFNAN+x5Fg@mail.gmail.com>
Message-ID: <CAHk-=wjTECUZLBgALpvm9zDN8TJCGxyc3VCEXXHMsFNAN+x5Fg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Give files a default of PAGE_SIZE size
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 10:41, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Fine, but I still plan on sending you the update to give all files unique
> inode numbers. If it screws up tar, it could possibly screw up something
> else.

Well, that in many ways just regularizes the code, and the dynamic
inode numbers are actually prettier than the odd fixed date-based one
you picked. I assume it's your birthdate (although I don't know what
the directory ino number was).

               Linus

