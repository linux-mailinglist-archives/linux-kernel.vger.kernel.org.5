Return-Path: <linux-kernel+bounces-112826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC66887EBC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2891C2098F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75619DDD8;
	Sun, 24 Mar 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foM7Ctxs"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B2D2FA;
	Sun, 24 Mar 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711308902; cv=none; b=RdtWGveKNpOk/E3PXaV0Fhc+9RjKrxddkfiQxBPV3jXopHIXOCdJC2gSFLNW/he0MmH8zj2CVqlnGAaGbyNzkjGVNTq5spzOThgFMIb3eOHILPSXp/kldbapebgbhiTgQ+i+2ii5ZFyGElThDpNqrKydMrpO+VxBkg59uAeK8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711308902; c=relaxed/simple;
	bh=RmbHBtKGxqnehgU6KCeaN5vJdwL0CAYv0l8NKaQ7tq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CQRNn0nj4XK4vAdU8xEpXutco3z+AtBN3wYBRch8/zxegpcDLyekGjBSS3DgeytPleMKygm8rIYELt7+R7RUch4OyQVLNWtEuTrOn6ifIOkiVdML6+Rv2D7bSWKpGLHdrmAG9vUIl5Ys96aLov24fGW++KsAWoF+dJ0GqM3ll9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foM7Ctxs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ddd1624beso2249663f8f.1;
        Sun, 24 Mar 2024 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711308899; x=1711913699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K++84jGCvgRAOjfcS7GRgBqt3OMCsGd1if5k62amUmk=;
        b=foM7CtxsnluZoVfx9zTf9Gbhj+0F7NeKvZqxLqOkPs5UjxH2fs0V5XyarHzRnSClbr
         PbiRRk8BMGy10cNk4CKFFAdBaa91GTG9xX2WkZ4aQDoeCUUkeZhH42aGYKYd5iHBVFgU
         G7qs/ey22XR9MosmA/ADl3tqlaQmNp0dnCbxA+l6nzhloxKN/zsNZUFpe9k/q3YAhx42
         274DQi7tWaIO78vWVULEaoDAhu3XhTnaOB224UXdmPUv+FZccePdsKQDu6J4KzTPxTxo
         bbpId31gtHMYHJtjTx9mEomb+te6zuFL0LoQWBlHUILVEMuur2Vd7fqklSsoBA+QDWQ/
         Trlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711308899; x=1711913699;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K++84jGCvgRAOjfcS7GRgBqt3OMCsGd1if5k62amUmk=;
        b=UaejZZjEK/ZTfh10sQ8zkafcbIkWlTmvvtSZMOgGyV9JIBw0AtdwBGDhzbFcgdLu08
         7TnMnSd6+759xY3ejjOORinvad+oRub3Y6+U4sSGu7ol2BDymVNg7wOL5hWGB5ZEgGQq
         vuoBC2wJH0JM67IhKjE8EHUSJQxOSM2wDAuX8TXgZRshlMO9kz0vS7UjGEJogb9YcbTi
         Z9e7uvIMEBTQUKYbdnRJDip9XfNBpdGwbWDMmqlUAuU6zjj0X46anAXO+yxygA8KG2Wg
         bez/18qdeyzYWo5higsKS+NX0fbPcNQjGLfQAHUHraFPqKotHIG/+NpPUnwZJHthRWXp
         ksng==
X-Forwarded-Encrypted: i=1; AJvYcCVdvq/bl1wUBz9Nu49lLNs/0ZuXgBAQFyQvWmxBKxvuh8uuXENzgAtOK1q+dUcmPJd6dDs3xxDBLj2mVVbdMwtgOz30lBm/3a34zRo18tH54PHmUdrTiVXoDr/jH/GU4l3qsnuFU0ydp5MhRhKtyQAwc/tOIkYHl1hK
X-Gm-Message-State: AOJu0Yzr+BxBsr8Dp0blGQBWPJWt5gmdY2/VGctvfbUHxmb6/4BrPPhZ
	yYR4kTCyIhV2oMrJzDfmSTfTOHqPqyVcTwupdNcDnrK9ZhB3y0Oy
X-Google-Smtp-Source: AGHT+IG7URdMcZEZazGkRHQQK2qTzWnOkEmaf38Qi3NDvtNbVzpDKawSD0/haWHfa9jkQxsqAry9zw==
X-Received: by 2002:a05:6000:d41:b0:33d:61c7:9b2c with SMTP id du1-20020a0560000d4100b0033d61c79b2cmr3620336wrb.34.1711308899390;
        Sun, 24 Mar 2024 12:34:59 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id en9-20020a056000420900b00341b451a31asm1192512wrb.36.2024.03.24.12.34.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2024 12:34:58 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <linux-kernel@vger.kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf v5] bpf: verifier: prevent userspace memory access
In-Reply-To: <CAADnVQKW2ajQ25BkOO_D2=N2wOHt9fdNY+tWRunXe_sN-w+33g@mail.gmail.com>
References: <20240324185356.59111-1-puranjay12@gmail.com>
 <CAADnVQKW2ajQ25BkOO_D2=N2wOHt9fdNY+tWRunXe_sN-w+33g@mail.gmail.com>
Date: Sun, 24 Mar 2024 19:34:56 +0000
Message-ID: <mb61pwmprbezj.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sun, Mar 24, 2024 at 11:54=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
com> wrote:
>>
>> +u64 bpf_arch_uaddress_limit(void)
>> +{
>> +       return max(TASK_SIZE_MAX + PAGE_SIZE, VSYSCALL_ADDR);
>
> This is broken. See my other email.
> Sadly you didn't test it.

Yes, sorry for this. I was relying on the CI for the test this time as
thought it would work. I just realised this would reject all addresses!

Given that the current x86-64 JIT just tests for TASK_SIZE_MAX +
PAGE_SIZE can we go ahead with this and later fix it for VSYSCALL_ADDR
as it is specific for x86-64?

Also, I will spend some time figuring out the best way to do this, there
should be some mathematical trick somewhere.

