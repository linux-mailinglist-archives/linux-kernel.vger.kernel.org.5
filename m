Return-Path: <linux-kernel+bounces-89589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFAF86F25F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3ACB22862
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA781CA93;
	Sat,  2 Mar 2024 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aitx2lkC"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD18111A8
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709411602; cv=none; b=m9/nN3pz2/1hmaclnOZT4g/R+VNmEZuxegv+WSU+M4XSiAQwbbK9WST3D8IbFmDdIasdjIlRlZNTUx0i3kaALOUkOIf8iPzFGFgve0u0qdtvFKq0a8XxCsRQrZyvI4LKsGTOM2X/v73Xm+hTVyfaFl6GLjTpi5jHxQKY/I6pN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709411602; c=relaxed/simple;
	bh=7DWqrpqHr3YxSwdqyoZ39XcdkGbJk2Qf4RpMXVYPS80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULgQzQHytpm3ySUO1IiVI5oVn9mrxOTP7odkWCbMdBT5pCvKyV26M5opVadPt7ReHfDdsAU+vfXEkhX6Mv8EpAIdu1EzIrF+3YALk3LLE1Vdbsuaz8XxaF1B2UrPhhcBx11l2O0/d3gb3lRZ8/8hlDxjuL9giM8B8RciLnOhdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aitx2lkC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso4868076a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709411598; x=1710016398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QoLijErEWyv284K7pa8Q/kzfjstXfvrRR9j3RtFqrzg=;
        b=aitx2lkCBFhvMzNA1AqYzFadKSt1yofKjYEJIjzq7RWJwmexTLi7B6HrMiZBWsGxFA
         POnM4lPPgy4Pjy8KlDhtDtO6k3IUjLE7pjlBx28c0Sf2bMXS7aV/SAXCZgGZ/R3SVXX4
         UuPw7m5hbzHbNArRFe6Wi95G7CALq9u4Z3oSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709411598; x=1710016398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoLijErEWyv284K7pa8Q/kzfjstXfvrRR9j3RtFqrzg=;
        b=kydPoUnoPz5UveplwyBq7Zz/5jwc5/i/v4if65pV24xxBeH65A0L2huhUZ8mtOPYjI
         h+24d23m2W70LdPaCa+OJe0EkIaphXj7zjIwtIn8izaZ2K3VjT+S19FDzERepZPq0B84
         91S7xhIwbzk3eOUE/OEq9dyh2ONXWS6E8L6dlFluEYCtclv3wk0ue7xidyg27otXQcYG
         uY4WjU6ecea2izr3fligeUzihOBjFm+pfXMDiuwqnlHqw5JDn6pnBloci0s2he5KwrIZ
         dTMy67zS6yTUpy/d/6koIl4HCxNnFPU+6ZEQEXJOKtZTEJBoFOSjfOAOBlQov8u6x0Us
         PiMQ==
X-Gm-Message-State: AOJu0Yxtoc39DXYqwpaTu4CVphFHvk7JTv8iLf1XS80mDrLaf5qVeTZT
	jG5tCDt0ohDW596iRGpxFRQiSHKLQlVCIsl5eOWN8aauvxviZ9LwVa8Tpt1BHGV7MneXROiNYq5
	Y+/ZvCg==
X-Google-Smtp-Source: AGHT+IGlOKWyRAlGTdFsOHkXIEsBetrWV3cGSs4+sntWmYoGlIZsEpfMLPmkjVVMpG2edOyCOcqOYg==
X-Received: by 2002:a05:6402:b3c:b0:566:ac5e:9eef with SMTP id bo28-20020a0564020b3c00b00566ac5e9eefmr3377476edb.34.1709411598614;
        Sat, 02 Mar 2024 12:33:18 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm107883edb.57.2024.03.02.12.33.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 12:33:18 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-566adfeced4so3390951a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 12:33:18 -0800 (PST)
X-Received: by 2002:a17:906:37da:b0:a44:1b00:1c67 with SMTP id
 o26-20020a17090637da00b00a441b001c67mr3861485ejc.56.1709411597879; Sat, 02
 Mar 2024 12:33:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302111244.3a1674be@gandalf.local.home> <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
 <20240302145958.05aabdd2@rorschach.local.home>
In-Reply-To: <20240302145958.05aabdd2@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 12:33:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
Message-ID: <CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 12:00, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The error isn't printk, it's vsnprintf() that is writing to a seq_file
> to user space. There's no stack or printk involved here.

Look again. The code uses 'struct printf_spec' and we literally have a

   static_assert(sizeof(struct printf_spec) == 8);

because we want the compiler to generate sane calling conventions and
not waste space and code with arguments on the stack. That's literally
why we do all those limits in a bitfield - because the code in
question is written to say "unreasonable people can go screw
themselves".

I'm not interested in arguing this. We're not doing some completely
idiotic "let's edge up to the physical limit of what our printk code
is willing to do".

I'm perfectly happy having that WARN_ON() to continue to tell people
they are doing stupid things that won't work.

And if you ever decide that a sane limit is ok, you can send that in.

            Linus

