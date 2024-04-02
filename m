Return-Path: <linux-kernel+bounces-128639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159E895D52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E451C22A77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACA115CD78;
	Tue,  2 Apr 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRZEVrU0"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18715CD56
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088604; cv=none; b=OL0oOtsBJ0lsMXCpNWgIsCjcBDhg+xHewA752iqoGbsmTc7GFjxCRre/iMX3QdFzR5l6vpkGozidu64t2JtWIlPmw1HUGtUaUk1BsYP46z5Fe3ysxHk+7U27xr+atu5W+feOw9ZTN8W/8ksM42cJUAROCDDxhNhUCk+Scepb748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088604; c=relaxed/simple;
	bh=JvT+46GWOEcN/uaSFs7+qveTnYJkxDvYzU2BDn91cRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEQ6N+mUJmsRHtdkkVx7AA9Kbx9060gLyb1Le3RKMQAAkU8hyW59VUT81DukEW0KuMGr7KheZQZEcKEbNkeZysZgd+MJv74WjHo2s1mFmsrjUVZzkc28YCoXI40UpAFa49JioR9Q29bwmasYpAStAh2dBuNTa0h6UKIBM+Wthf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRZEVrU0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430bf84977dso31712421cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712088602; x=1712693402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JvT+46GWOEcN/uaSFs7+qveTnYJkxDvYzU2BDn91cRg=;
        b=XRZEVrU0xQ7prUQ+byOmCCsXmudyJQ9jnbUSEjPgyW6mDm+xIWBbiDcErFrcsKNxnX
         0Ac/VoFmkJ+yeZL0ASkH6bJfpKBmRiFK/ActMTnVDCm0qnunpo/w71ZL9QuHxC97zlmF
         6rUSB2NPh2Gs2I66Gz0CHVshRd0wMtbWQ6NHPZ/0bd18ErjnHMcledxfAcvpWjGxdsPX
         T0bMVaMGP73BYQqWfDUONZR6dyR3cQD3jwxDmosAKwt0VSNWrDcjl/VhrYkd+YRhSEBI
         gQJExwrsz8+HC+wy50MGvazG7Z+mRrF790dFo8ZjZL7GThyqzgKnpYfcTRP9XW5Nzbby
         e9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712088602; x=1712693402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvT+46GWOEcN/uaSFs7+qveTnYJkxDvYzU2BDn91cRg=;
        b=m/WndRvonc7mnHs35HEaZVYeKY8SfuNKiDr0yUALLOeOdRT3kSmhRycNmbZhyFtsvb
         7FWhg/qsoKxknYJK0iDLtaOouCcDzXXGwVI6c9bvKzujwKDl8cSOSc02IiVj+eWmgvQW
         /nOszVOdtVpAS9WfxcNL8+UUM1CczCgMOEDmpBTpZWhW5iX97p/DTZop4c8yeoJKLX0J
         XkIA1eqv7ciJ13Wh9LP/jM8n8vtLyP0mZgopeDqzLwo/SVE6BZIoX9H0YkxznXfZTM/B
         RuDohUg2e0xpCjAR7k/3Y5iFt3J3DkZiFFVVIkk54h+BluqU9y9FpPHHMuCg3eKaKkBK
         DS8w==
X-Forwarded-Encrypted: i=1; AJvYcCV0jIAsSMfNYaMpV+wHIDlrTeaJHhEaZzvvzENUkDaQZfx5CHhsdQXj+IG0JeHXQVcDbbNY3oM6KfgyHa8IK8H/lFdnCY+tkqLqRFxz
X-Gm-Message-State: AOJu0YzMezxHk1x9xknbkpmA/BOafX7kEemy/kMjUee5a3Rho9jrvWUR
	JK337Wpw9pSp5aNAl9ARKUBNnAX9PWbfdSOXKcxgo2af0PzKtfRKuYVFpC1ZXF/OXKEJbtkQ2De
	YkGzkMRK3gKdF93MAfO1RiQpeUms=
X-Google-Smtp-Source: AGHT+IGYbL137c+yb583TrFqkgahv3G3M+9wj47TTt5HHHFK8KbtmKR8k3vJDSajRv5wEynHIUprjnOxXgTYXiImp24=
X-Received: by 2002:a05:622a:28e:b0:432:f64a:7bde with SMTP id
 z14-20020a05622a028e00b00432f64a7bdemr769721qtw.50.1712088601712; Tue, 02 Apr
 2024 13:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
 <CAFULd4a75kS=3cJzYKsOcJ3ULjW8k5M1cvPYZQ25zZqTo3QX9Q@mail.gmail.com>
 <CAFGhKbx3dzrMC0euRMNe5=sAhM87v=6gLwOT+c9HwWKZrWc5Gg@mail.gmail.com>
 <CAFULd4ZNi7eONVu8syiWyA5ek2TgHTf6jTM+Pf7SaSG6WyHoNw@mail.gmail.com> <CAFGhKbwqrr=_bOnKW+wqtX2OyW0xpS_9wkJnHpwxmwx7MHGhfg@mail.gmail.com>
In-Reply-To: <CAFGhKbwqrr=_bOnKW+wqtX2OyW0xpS_9wkJnHpwxmwx7MHGhfg@mail.gmail.com>
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Tue, 2 Apr 2024 22:09:50 +0200
Message-ID: <CAFGhKbzdWLw7fmRTLYPhEycWZvfjE-OCvnWct2A_kWVe94-p-A@mail.gmail.com>
Subject: Re: warning: cast removes address space '__percpu' of expression
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Am Di., 2. Apr. 2024 um 11:53 Uhr schrieb Charlemagne Lasse
<charlemagnelasse@gmail.com>:
>
> Am Di., 2. Apr. 2024 um 11:43 Uhr schrieb Uros Bizjak <ubizjak@gmail.com>:
> [snip]
> > Please try the attached patch that informs sparse about this action.
>
> I've tested it using
>
> ```
> git reset --hard v6.9-rc2
> patch -p1 -i ~/p.diff.txt
> git clean -dfx
> make allnoconfig -j$(nproc)
> make kvm_guest.config
> make prepare -j$(nproc)
> touch include/linux/netdevice.h
> make C=1 net/core/dev.o CHECK="sparse -Wcast-from-as"
> ```
>
> And it seems to work. Thanks

But I found another problem which seem to have been introduced by
commit ed2f752e0e0a ("x86/percpu: Introduce const-qualified
const_pcpu_hot to micro-optimize code generation")


```
git reset --hard ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e
git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
patch -p1 -i ~/p.diff.txt
git clean -dfx
make allnoconfig -j$(nproc)
make kvm_guest.config
echo CONFIG_MODULES=y >> .config
echo CONFIG_NET_9P_VIRTIO=m >> .config
make olddefconfig
make prepare -j$(nproc)
touch net/9p/trans_virtio.o
make C=1 M=net/9p/ trans_virtio.o CHECK="sparse -Wconstexpr-not-const"
```

This now shows the warning:

```
net/9p/trans_virtio.c:831:1: warning: non-constant initializer for static object
net/9p/trans_virtio.c:832:1: warning: non-constant initializer for static object
```

Which is from

```
module_init(p9_virtio_init);
module_exit(p9_virtio_cleanup);
```

The same happens when directly switching to the mentioned commit:

```
git reset --hard ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e
git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
patch -p1 -i ~/p.diff.txt
git clean -dfx
make allnoconfig -j$(nproc)
make kvm_guest.config
echo CONFIG_MODULES=y >> .config
echo CONFIG_NET_9P_VIRTIO=m >> .config
make olddefconfig
make prepare -j$(nproc)
touch net/9p/trans_virtio.o
make C=1 M=net/9p/ trans_virtio.o CHECK="sparse -Wconstexpr-not-const"
```


So something for module_init and module_exit changed with this commit.
I can't see this when switching to a version before this commit:

```
git reset --hard ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e~1
git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
git clean -dfx
make allnoconfig -j$(nproc)
make kvm_guest.config
echo CONFIG_MODULES=y >> .config
echo CONFIG_NET_9P_VIRTIO=m >> .config
make olddefconfig
make prepare -j$(nproc)
touch net/9p/trans_virtio.o
make C=1 M=net/9p/ trans_virtio.o CHECK="sparse -Wconstexpr-not-const"
```

