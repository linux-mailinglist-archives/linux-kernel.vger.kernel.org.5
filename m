Return-Path: <linux-kernel+bounces-109883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A758688572C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C7CB22196
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47855C3A;
	Thu, 21 Mar 2024 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZzdcuzN"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C27273FE;
	Thu, 21 Mar 2024 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015992; cv=none; b=TH+sVtalgr75oQSS8bFyUMwGyERupN7OlH9mMY9k5JiTIaDAt/hDTeQ8Q0+d7+ds4Qh0hwQG/asr/HasvuwqxzmEcQcl0kMFQUWzdMfJRZc30Bgou419uz9zWeSS44NzUBUyapIFpQtnfBjstEhclygsJcw8zIkqYEX63C4pN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015992; c=relaxed/simple;
	bh=NDlc9kSKVp6whfV6OCumf4TLoMiSy65wKZXhPwkDNls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d+D+mdUwqvZdUWe+/k7lxxHVyATiC9TVJLrnsOMQQmRsdNmqs7oxiHNDjL7rN9UAUOelr5WvxjzzE6LFqd3bCFQIPTUznmvzpgaSjZQvJc29jS+7fUQsHVq7m38dcmNPBXARMLQBVMAqXlEyc4ES8id5SWWCs54j1dal2v4Bbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZzdcuzN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34169f28460so365166f8f.2;
        Thu, 21 Mar 2024 03:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711015989; x=1711620789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MitwkFHcwxqVaWGfFKUTbbx5/3olZ8yXIR5unmZmN/I=;
        b=JZzdcuzNFJVzqPkPvynBmyyJKhKaFLc+xVsXrSLtkhGR12wN6iNztpuFoSgtA0ItaQ
         mXX+yi/PeYb7W6eHjqb7FOXCr/C5YnhSPC7Y/P93PNhQz0EWMsIDtbbJTz9RgQNsmtkX
         8VkIl4KQE95AdkUvi3iIK8PFdBN2OiBpLChwevE4tB2z7xoCkJUfZV7KP0KNqcKfp0F7
         nb9LZQhSFev4z7XhPhpuRFbCOfqp7AqhL8Iwj0i+yoUyLX7z8ApnPQZBWo7e/clMWeRk
         jzvEZ7Iw7L4W6QfWyIPmJjvhiqWOUsT9R/QCal5J64gplaED8n3npeXanvh8s86WQUdN
         8m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711015989; x=1711620789;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MitwkFHcwxqVaWGfFKUTbbx5/3olZ8yXIR5unmZmN/I=;
        b=jCtvJVPEA8PX2iVFWirH4C/Hxe9xnyUXgymGnki2nX+daEhO8guRLtMtUGmGddAf/L
         SFAAgb4qzAW2xAgrJ+JDAOgLxbxiQTDto2ZB+KJySwDm3JCsgEzaFJK6zLiWkVwCACEt
         vrihI8Tfam3i8yEhroN0eb3IlQFg2A76rnXqYE7u8mucxqnmNGtJEUQDd4vGBiZ6QWxg
         nCOrEj/Ok27EWqXTEHP4yHmkeka8+2u6wnyG6FvxfNaHuq+z3Vu7laH/Px7xBW/Gc2y6
         4z06bZyde6rMsUqSgKHvA8HXGkYVblXE9TgX2kEnpRc1C0Wh35ldfFbtHClRinQmJYqN
         6R+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs6Zv6YFagURWdNdoOWHLyUjSbvOvwyyjbSSA6s7XM0/jMU5FdlPMpzdK2FiVFVJQIYhha00zQSExOfNSy5PvZhgXV2zeMT5b17dBjb8/Yn6yfH85e03854taDAjxt4EXe+i5l6Dfz6z1kmMGcEfqN7wtqUqBAuM81
X-Gm-Message-State: AOJu0YwkOqU/C3wlgiWo7aygR5kNIm88HhZ0rap5rcd6K1oK8miJhhcH
	wR6aClSnUr5+TFzpIING08pakApxWsdsquMeQjnrIWPLwengiNuP
X-Google-Smtp-Source: AGHT+IH3lgtbtEkFdAZ5LS4VQ7Wsu2mG0uTJGuw0oiji2OqfMfgdDtslJiSxdtvEYObdfwPwln0zXw==
X-Received: by 2002:a5d:5346:0:b0:33e:767a:c3a2 with SMTP id t6-20020a5d5346000000b0033e767ac3a2mr5429651wrv.17.1711015989199;
        Thu, 21 Mar 2024 03:13:09 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id co14-20020a0560000a0e00b0033e052be14fsm3822595wrb.98.2024.03.21.03.13.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2024 03:13:08 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Network
 Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: verifier: prevent userspace memory access
In-Reply-To: <ed5cozsc7mduzmgbwrlw3lou4tlb6zpivhs2xrqwgpq2rhvkue@l7aifknll4tb>
References: <20240320105436.4781-1-puranjay12@gmail.com>
 <CAADnVQJ3o6DsURi=N_KXx+mbW9r7__3LrwYLyYwuoMOsqFHPkw@mail.gmail.com>
 <ed5cozsc7mduzmgbwrlw3lou4tlb6zpivhs2xrqwgpq2rhvkue@l7aifknll4tb>
Date: Thu, 21 Mar 2024 10:13:06 +0000
Message-ID: <mb61pzfursxjh.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Wed, Mar 20, 2024 at 11:08:00PM -0700, Alexei Starovoitov wrote:
>> On Wed, Mar 20, 2024 at 3:55=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
com> wrote:
>> >
>> > The JITs need to implement bpf_arch_uaddress_limit() to define where
>> > the userspace addresses end for that architecture or TASK_SIZE is taken
>> > as default.
>> >
>> > The implementation is as follows:
>> >
>> > REG_AX =3D  SRC_REG
>> > if(offset)
>> >         REG_AX +=3D offset;
>> > REG_AX >>=3D 32;
>> > if (REG_AX <=3D (uaddress_limit >> 32))
>> >         DST_REG =3D 0;
>> > else
>> >         DST_REG =3D *(size *)(SRC_REG + offset);
>>=20
>> The patch looks good, but it seems to be causing s390 CI failures.
>>=20
>> Ilya,
>> could you help us understand is this check needed on s390
>> and if so, what should be the uaddress_limit ?
>
> s390x does not define ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
> Userspace and kernel run in completely different and isolated address
> spaces, so it's not possible to determine from a pointer value whether
> it's a user or a kernel pointer.
> But the good news is that whatever you deference without using
> special instruction sequences will refer to the kernel address space.
> So I wonder if we could somehow disable this check on s390x altogether?
> And if we are not sure whether it's a valid pointer, use BPF_PROBE_MEM
> as always.

Thanks for the details. I understand that s390x doesn't need this extra
check because all normal accesses are in the kernel address space and they
will be marked with BPF_PROBE_MEM by the verifier if the pointer is
untrusted.

I have sent v2 of this patch with this check disabled on s390x
https://lore.kernel.org/bpf/20240321101058.68530-1-puranjay12@gmail.com/

Thanks,
Puranjay


