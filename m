Return-Path: <linux-kernel+bounces-20266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF18827CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF69E2853FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E70187E;
	Tue,  9 Jan 2024 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NZke+FNT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CE17D3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e4d778e5eso3703395e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 17:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704765250; x=1705370050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=INEVilcVOIiCkbe5/NRvOP8Bp+cgU+a660cL/Y+5uIM=;
        b=NZke+FNT/mkPiE3vdb2P6mFnhuo2IglVjBBopmtv5YsJPZxpefMEoNfRL3MesXaxs7
         dQj7Wtm5SZTwHg1kVUxvYFS/NBWkW0Yd0QBXRU9S0TxhSbST7D9OVeJeDZOOOPu3Jw++
         pGBt50xHegl7XW70eNPan8FDNFTr8zAXHI/0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704765250; x=1705370050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INEVilcVOIiCkbe5/NRvOP8Bp+cgU+a660cL/Y+5uIM=;
        b=CpB37AtjMAmoAaC4/MFZch+L0s5wl0BPye/GZTkzH1J1M8NozNnQj31HdKBRC9zsDT
         VDirYk5JD7S6q7jvAH8JOYnLq6QiW0dsmjZVpEGI1RzokzSzV7rn8IClOiW9MRw3i/sJ
         T3bEQzfW5+cK4baR2ZatMywbIG5wn6Kg2xukaP18Ftskl6W/Kei1t4VxEYy5ve98QN0c
         IWXyUz+DwzwutISFXTyZHbsS6vmsCdceUw4nolqgwkVIx5coaKFluT1bRMwHIgjS5XFH
         QwnkjsYbP31Wg8GAzjP5f4rMUADX9cX/qf0ovAfsv+Mo0Ti4pdsts+MibLcWmFvKr1Hm
         1I5w==
X-Gm-Message-State: AOJu0YzlJvcaUBVZumtJP+ZynIGc4B/k37j6ZRugflvTG88KoiJfBOPH
	arIcH2vMq5XTPPpDlWSQek8SpDiTnaitENoPqMYvj2l/K2X9PBCw
X-Google-Smtp-Source: AGHT+IE9uPaVCzEaTXtL+YqZUg3/Rgu7UlFt1hWIMGcaKuGyRIDf/gkhDFhX68hp0yITmzj2zSolmg==
X-Received: by 2002:a05:600c:214d:b0:40c:416c:d99b with SMTP id v13-20020a05600c214d00b0040c416cd99bmr2391807wml.47.1704765249744;
        Mon, 08 Jan 2024 17:54:09 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id fx15-20020a170906b74f00b00a26f22dca5asm482098ejb.0.2024.01.08.17.54.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 17:54:09 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2adc52f213so135794066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 17:54:09 -0800 (PST)
X-Received: by 2002:a17:907:bd8:b0:a28:1fab:cfab with SMTP id
 ez24-20020a1709070bd800b00a281fabcfabmr101140ejc.33.1704765248901; Mon, 08
 Jan 2024 17:54:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org>
In-Reply-To: <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 17:53:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnLA7Jhjiuz8W76PRyQheLCkNS__=D1onenqbhpiXsVQ@mail.gmail.com>
Message-ID: <CAHk-=wgnLA7Jhjiuz8W76PRyQheLCkNS__=D1onenqbhpiXsVQ@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>, Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 17:48, Kees Cook <kees@kernel.org> wrote:
>
> This was exactly the feedback I had originally and wrote almost what you suggest:
>
> https://lore.kernel.org/lkml/202209161637.9EDAF6B18@keescook/
>
> But the perf testing of my proposed "look it up once" patch showed a
> net loss to the successful execs which no one could explain. In the
> end we went with the original proposal.

Basing things one one random benchmark which must clearly have some
very particular cache effects or something is not ok.

End result: I'm not taking a random "look up filename twice because we
can't understand what is going on".

Because I *guarantee* that we can trivially write another benchmark
that shows that looking up the pathname twice is worse.

                Linus

