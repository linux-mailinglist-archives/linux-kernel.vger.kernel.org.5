Return-Path: <linux-kernel+bounces-163171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28AD8B66B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D15DB224F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA9ECF;
	Tue, 30 Apr 2024 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RV6ud2O9"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A6170
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714435560; cv=none; b=FRmpnF3Kt4PdEYrx4HLI6G7Ky1JrRe3b7lKIi9iE7gzMyYj+C/CF6oHWSJeDVowSl2xdLE32rA5VdVoN5/8BoFll5RxoL4SLTkhu+EcY5+sRo4pidfXE8cNtBA4MajPF2lbZ34JTYckQWP3geFtu9URSK6Pd3tAGQ2MAV5pMA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714435560; c=relaxed/simple;
	bh=gJuDTVJm9AcKVDDIfX5i9uqqPFvs2NbSxmNtE3G0c24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDTOHMde0hbLajN7RRizFx+E5SsZbneu0bIzIMMqtB8cWpjiAoDdaKFEG1C+Il8aGbMwJZ6wg6o3DPZOerU6JYnzfmIkXHJJrHwi0Yj/KahecS3jWjQAc0C5Fqk5tp0hkAvpWpyW9KPUy1qjmbFh326fTw4gvtWkKhU7vyJ8g50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RV6ud2O9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db17e8767cso59719951fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714435557; x=1715040357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls/x91/XqY1/yjdZUA1T/JakK/e7WGx+3CLMLeqey1k=;
        b=RV6ud2O97o16AxkDsaWza9NUsBsd9YiP1YW6+Ax5oA05hYs6PadoC+q75C0kZntcWu
         MGQ5RporloUf4qb9aaSVHA+pP2wzJTBWloTV1CIoBVwyyNdfkE8HARp0SlWh9yPHVKuP
         ZuJZHZN6q7lHuBG+ZEvCdKxPaU9KtsooWOMJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714435557; x=1715040357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ls/x91/XqY1/yjdZUA1T/JakK/e7WGx+3CLMLeqey1k=;
        b=fWCdE9m0nLC0Sc/tpQTMcgi/UsDpHc9AqN+bs2lm1KwGS6VIrZnb7M7AxfFpm3LD0k
         1m3aWLb8d38zCh7fPkBDLNLx9nZ6nX20Cjb6RIHY2dTDgdI91xmEvk3tV9fmawZxK8uU
         cCCvnsdDQZJJ1JQruDirYrPyeVmgHvBmmBrqS3iDLlkiAu3rSDgP4SulZ9ZOfSOSX91s
         4Q6I5FtBQlbWz5ea8Npis+YuE9XNTTjXnOb59121vHzvx3aITxw+Q8a9PHtos/WBjTPk
         6ZMn5mQhAY9W7vpElhxAssntT3pOFeBQGB0GMuw+8WUOzPQT/BBsdS6qQp+66322MfCf
         9BfA==
X-Forwarded-Encrypted: i=1; AJvYcCXJxknuENTW5xyh6Td9G7qCL4j2A+Aq904DiC8yXhU6O9Kv08YsiuSl9B+qbo5HMy5Md9xlhnuwFIwG0vCIl8l3PaG7fAT0NQ+DiSp3
X-Gm-Message-State: AOJu0Ywu37PxYeSz3IUCKaUVg5TjnEJyrPvQcMmPQe+gFDryqKczDHEZ
	GdqfU+x025aG6OCxm+WqbxQVswe3kMmMg+F4gB23934UCq48Q92fB/d5N7J9Q0g1jGDS5R801Gg
	hsgt8iw==
X-Google-Smtp-Source: AGHT+IHB4BK/a/X4pZTsuezkhcwbgu0ydRpkPzMDVKKu2fEO6oK8CaZB71aWLyXqtyJODxsVZ8d2OA==
X-Received: by 2002:a2e:b8c7:0:b0:2df:ebd2:6fdb with SMTP id s7-20020a2eb8c7000000b002dfebd26fdbmr865338ljp.28.1714435556813;
        Mon, 29 Apr 2024 17:05:56 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id q21-20020a2e9695000000b002da25e60918sm3804641lji.18.2024.04.29.17.05.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 17:05:56 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51967f75729so6036787e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:05:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9f5zkkhdD/rOKXoh5zXmrsyaMITW4q8+KzJabk1fCp/GqdfctYLjUmL6vyxTVS+MNo+OPO4DJxoNx6db7BStTifSHcfTlGS1/UBTw
X-Received: by 2002:ac2:47ee:0:b0:51d:6f21:d3a4 with SMTP id
 b14-20020ac247ee000000b0051d6f21d3a4mr624436lfp.66.1714435555174; Mon, 29 Apr
 2024 17:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com> <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
 <Zi9Ts1HcqiKzy9GX@gmail.com> <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
 <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
 <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com> <CALCETrXHJ7837+cmahg-wjR3iRHbDJ6JtVGaoDFC4dx-L8r8OA@mail.gmail.com>
In-Reply-To: <CALCETrXHJ7837+cmahg-wjR3iRHbDJ6JtVGaoDFC4dx-L8r8OA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 17:05:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW=HyBNE2sx+rVyB2q+Xuuah+Ycp4o89+prgHUFHm_hQ@mail.gmail.com>
Message-ID: <CAHk-=wiW=HyBNE2sx+rVyB2q+Xuuah+Ycp4o89+prgHUFHm_hQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@kernel.org>, Hillf Danton <hdanton@sina.com>, Peter Anvin <hpa@zytor.com>, 
	Adrian Bunk <bunk@kernel.org>, 
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 16:30, Andy Lutomirski <luto@amacapital.net> wrote:
>
> What strange page table handling do we do for XONLY?

Ahh, I misread set_vsyscall_pgtable_user_bits(). It's used for EMULATE
not for XONLY.

And the code in pti_setup_vsyscall() is just wrong, and does it for all cases.

> So I think we should remove EMULATE before removing XONLY.

Ok, looking at that again, I don't disagree. I misread that XONLY as
mapping it executable, but it is actually just mapping it readable

Yes, let's remove EMULATE, and keep XONLY.

           Linus

