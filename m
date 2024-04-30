Return-Path: <linux-kernel+bounces-164615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43888B801A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A8F1F236D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193BA17BB1E;
	Tue, 30 Apr 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6WAD4Wh"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97114194C93
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502995; cv=none; b=dDduzsd9OkNh29i+nBFHsSn8B9oH38d0x7BfPHQ5X5fjAvAJbibGoZglMW/w+yDYEuWBYUqeA4SdwGQKQNCGOYo6FpH5Zr217ehi2h4QlK7aKs4MAPRLWJmMJpgPL6XI5OXCGyVLMmxZMYQJnwM+w/E80P/5yoRTvdYSQXSIuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502995; c=relaxed/simple;
	bh=8x9gEwb9HqLNuJ98o3+0GAsyQHChOQt79Vo+niXaXnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=A0rox62JzQxhsPvBaxtzC0e2fD/dkKcg3iRLZvyyHVfLCn1y3+oYE+1ubU/mzjLVQzAMF0zV5Bp0IjOnzWjt6WMITvRpWic0jzIHGs+6zbkm25tHTQOigfVeWY7bHeZOy3XuaNzdmWdLvtYDQVTPYeme/RjX/GRbRTIReupMQKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6WAD4Wh; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-47c5bf7aadaso679579137.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714502992; x=1715107792; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovRxnaBd6FTDXqV2H7WIeHH2Iv92ouqScbx2FXXHbgo=;
        b=a6WAD4WhCBMkvTTpDe4/Xw0PEbuu3A3jlwp0xipK1rYbxVlsXMGjWTX7n0S4IlnVQ0
         p2nRl37dSnswkEy9dZDPv38rxgAwakBJ16/luGPlvl4PvicM0y4Yao5P4uDfn1H6gQKe
         eAqwxzjBU6GNaXrk+lFb7rwNcitBUhdJ1zpjhV6sYUzI+FYZsYbHEnwXTXKp5JWagtgO
         UU+DLYwldRftkMoHtrCXNW+CFufD/EuIwoq0CgWHZxQ45KGa+CISum8YDEzym/6WVrbi
         v3umfZzgbg8O3nR4Xx4OUQuqu6LeeHVdqz73BKnUKD6cvLIqDdWpsxKm6IGMKqjQcb8Y
         x1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502992; x=1715107792;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovRxnaBd6FTDXqV2H7WIeHH2Iv92ouqScbx2FXXHbgo=;
        b=X1bH/77R/SkwS/JdkDh7vBSOWOeoHWXQeZWJu4kYvp++B9e9bF7Q8f1xfqFf8mg0P0
         RgP9BEjRHl5NtPnL06cl3gr/W32KkOVc/x1Lbva0hZ9/DDhYD3YyNxTcKO4puDsVIYbK
         n1exSVyzM491u9g3QQ6SpgnRt9FU87oWeEzBzFtrWvsZWePncyF+exmP5KlclSEFPngQ
         hwd3UXVhkDisHENJPPk+c3NZreNtlcuntQLY7O0lVGDWS5+r+dPQBkrAgSCiUEgSN8HG
         ONr0VMzzMv5xN/UVXiXRCT/OqC2/xdXOZhX2hU68mxaVphaqLs8ZEOB/PN57L8/3JCEE
         C4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCViTE50U5uazIeqspB8cLxar1F02AJNr5M9vdSlp07YwQpFfok4zxSd694CoxlHtHyfnoU4CuC+LqdaZjgOHchpT3a7rGTZC7g0pwn8
X-Gm-Message-State: AOJu0YzZpQl1d6sbNzWOfBtiJuKj5u7OIzuEO5VXlHU6BM2IlCE3Yhzl
	wU/OgUPVtWw0mqOx3qk8YzvBFb7Ry3MPRixRIU0R1LWBUBQmZobgNbBbwCbfZeezrg7mAPUUz7y
	taHtsIouM+Zzlzgv14dd7fKBd5bU=
X-Google-Smtp-Source: AGHT+IEYrpal3QoBPRQ++rwUqDaIC9CmdEKHvVPwvAQ+vncPDFl0h7pwu+HmwYOWtzcwQ1PiHyzGG1EvQK6S81Uls4s=
X-Received: by 2002:a67:eed7:0:b0:47d:8561:99aa with SMTP id
 o23-20020a67eed7000000b0047d856199aamr661606vsp.4.1714502992443; Tue, 30 Apr
 2024 11:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429193921.66648-1-jim.cromie@gmail.com> <20240429193921.66648-10-jim.cromie@gmail.com>
In-Reply-To: <20240429193921.66648-10-jim.cromie@gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 30 Apr 2024 12:49:26 -0600
Message-ID: <CAJfuBxxdfaATOCvZ2giY1Y-KTP+65UarRqwcKsg9tKjyrNtBXw@mail.gmail.com>
Subject: Re: [PATCH v8 29/35] dyndbg: add __counted_by annotations
To: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 1:39=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> Tell the compiler about our vectors (array,length), in 2 places:
>

these are not flex-arrays,  using counted-by is wrong here.

Ive dropped this commit, series rebases clean wo it.


> h: struct _ddebug_info, which keeps refs to the __dyndbg_* ELF/DATA
> sections, these are all vectors with a length.
>

