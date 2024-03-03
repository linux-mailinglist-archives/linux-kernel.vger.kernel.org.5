Return-Path: <linux-kernel+bounces-89847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC3F86F677
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C2F1F21462
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7599376412;
	Sun,  3 Mar 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XnRPWI1Y"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985738F40
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709487507; cv=none; b=e3al6AWbs+B/Z3Vyvg+MiehhYt9U/wSZOAZbGntqagWYoz51LKk/c2Oa3iQkjtpD7U3Rxokqj53bOllLrzQxn2Zd0R3V0X2t+e7MqNoxcDvkqaIQVmADb0jyUjZ3LHdHcOnywHu6bZ8LKEv0rbsMC40JWu3ag13Dq3He9GkZyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709487507; c=relaxed/simple;
	bh=EraWs6zRpMrLuSDfy+wsdAKnpSaRQvG9MzaC/ej7704=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hm6cV7Mb3ltw+FBn78T6/qwBTx7X/H8fDHa9JDMRxcHeDm6KX8yhsrQvS/bmP/SGKXOfyR5M8Ag6fqP3DLRJgean50eIWCBhyefl98kvc8oGGnhcgfn2ebDJV96thfmm+ARGshzHjijHgVdz0ftBGvWTOJq+kSVsc1unqHtMuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XnRPWI1Y; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d27184197cso50738891fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 09:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709487502; x=1710092302; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6OXHcs0u7KBydjJek2lY4Er4rvAyb0qiJYU1ggCN13U=;
        b=XnRPWI1Y8KcJLA+aXdawlGcTFpycj8x5bG+BQYMzLAsiFYaMefmRYSNgu+ctrP4Fqm
         VE4jxYvyQUhqM068wg/4ZC7QDElG3h4JP4khdb5DnqaoeskcgWoT6pMGVTBdc73uhrqX
         sGhxUmPHZleom0VsNmg8WWyGUMAG7baMdfhV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709487502; x=1710092302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OXHcs0u7KBydjJek2lY4Er4rvAyb0qiJYU1ggCN13U=;
        b=fQRXbNOjnClfaza1svFW2RkzEHYfp4oZMTmdSvyjl3E/0C9lXrDg/7uMhF0G674Kr5
         PORu8BYdcoCoYEMQ07Jd4Im0tnOPY3R0xnQNQcj9QWo4emomSXwiL9gh8D4xFwWJSMLJ
         CPNq72XKVeS4s6/fLOide1RrBiL31EA964Ktat21lF6W9e/Xq4NKfTh/uGtsymeFgYzW
         u77x0OvGzw4XQfHjGwEwuskiO+EsLAT0/9iRix+FVsDcf5Nv7MTMzW3uvm1aGF9VkhiA
         6JklPYYn130C09Ble7im2fZ8PQybqY6pI27/ltJhRZmq0CsLkSOvLvuH9PbyzvJy3iRn
         S/6g==
X-Gm-Message-State: AOJu0Yw5bbudxuYLDwxvvLz3BtstnXasgUZ6jcs30uI8AO4XmRDioCbp
	36FXsv55IZe6dzZVe5zHZYmOdyIINB4Af1W0TqiDY5LVNfX2NSS0qKga0oGsWTbVJaNdrzFCNzM
	nWaX4rQ==
X-Google-Smtp-Source: AGHT+IHXi6Dc/Kd4AqK2M98TR5HSddqx7hbL3jqWMvfkf+R94cwDtyR+KwQYausdTy1TmP83jYOoEQ==
X-Received: by 2002:a05:6512:2fc:b0:513:201c:5dc6 with SMTP id m28-20020a05651202fc00b00513201c5dc6mr3826594lfq.61.1709487502493;
        Sun, 03 Mar 2024 09:38:22 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x8-20020ac24888000000b0051339f52ab2sm701921lfc.44.2024.03.03.09.38.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 09:38:21 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so42322331fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 09:38:21 -0800 (PST)
X-Received: by 2002:a19:4359:0:b0:512:9857:34f3 with SMTP id
 m25-20020a194359000000b00512985734f3mr4527253lfj.39.1709487501350; Sun, 03
 Mar 2024 09:38:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302111244.3a1674be@gandalf.local.home> <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
 <20240302145958.05aabdd2@rorschach.local.home> <CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
 <20240302154713.71e29402@rorschach.local.home> <CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
 <20240303075937.36fc6043@rorschach.local.home>
In-Reply-To: <20240303075937.36fc6043@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Mar 2024 09:38:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
Message-ID: <CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Mar 2024 at 04:59, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> -       trace_seq_printf(s, ": %.*s", max, field->buf);
> +       trace_seq_puts(s, ": ");
> +       /* Write 1K chunks at a time */
> +       p = field->buf;
> +       do {
> +               int pre = max > 1024 ? 1024 : max;
> +               trace_seq_printf(s, "%.*s", pre, p);
> +               max -= pre;
> +               p += pre;
> +       } while (max > 0);

The above loop is complete garbage.

If 'p' is a string, you're randomly just walking past the end of the
string with 'p += pre'

And if 'o' isn't a string but has a fixed size, you shouldn't use '%s'
in the first place, you should just use seq_write().

Just stop. You are doing things entirely wrong, and you're just adding
random code.

I'm not taking *any* fixes from you as things are now, you're once
again only making things worse.

What was wrong with saying "don't do that"? You seem to be bending
over backwards to doing stupid things, and then insisting on doing
them entirely wrong.

               Linus

