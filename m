Return-Path: <linux-kernel+bounces-68733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC99857F26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38AFFB21467
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D612CDA0;
	Fri, 16 Feb 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8FrulaG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392D12BF24
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093212; cv=none; b=lBTy2B/pVAU6I17wK5LjWrqG2lxuvGsTp/AdMdJMyo03KUZ5gcv9JfaBT3QPUWMH4Pf5jBd8JdGqfQUkbh0DLF4I+g86f0wflLSqe4HM+U0zN7CQgBDBV00liGmU4QCvOqAUfEnCaZDEAGMrGsbZ07CJml4g/seWnzkBKxF3Sbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093212; c=relaxed/simple;
	bh=AeJy7JV2hQVTRmMq4am9/8y0pxu/DVW/wVFGgVfz4j4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZvbtRGSGl4D/RSRtD26c0Uyw8oK7MeODfqaVxyAIdsk5uLp4lHv4BONZgpr6lEOm02tVKiNwF13gcFryEETtp0xwUdNRx4rzgBIag3+C66jAIT9wLBRR2VtbLp0iMDjITdiuDoRsia7wcVLao64cppsLeMs+2shZqAMLN4pbjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8FrulaG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708093210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ci0yy+9I7QlXhvTWg0bk5A4FPE/qqC8wC9ZrpH68ucs=;
	b=H8FrulaGkaJe2AXkijdslaJrWtIlT0nweaiakmkMhcp6poLyAOMSuyWFLK8f8YMzSgHgCn
	SJPOO6uxgDQ0l4jgElIBzv2rnLXaZ0YkAFyw/mc6aomQV3flxfXRk6Iz8WNdnCQvUD+MiM
	srstVEsHZ5tpYAQpagNut0VJVpaEq28=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-msgdNx5dOWCrPvVRT_-Ymw-1; Fri, 16 Feb 2024 09:20:08 -0500
X-MC-Unique: msgdNx5dOWCrPvVRT_-Ymw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2c4e9cb449so152008566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708093208; x=1708698008;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ci0yy+9I7QlXhvTWg0bk5A4FPE/qqC8wC9ZrpH68ucs=;
        b=j30rvHSt9YTzchj3FpWnZFXX2eFsrHwRXWp9MSIvgNHu6NRYd8Al5UzoaeCMaGSVv+
         6RhGZ1Jcng/oUfrjz8DJFhFw/ZyHT0Kd0KEDua6Rge391N9ziwHYD5INlA13yNjG7BQT
         zhOPDVlMDIeDoJBgko9Cy4yDTfQPGOgTw/j8fBxAKvZXqSe8ycxx0Zk1t//yaG0m29Qa
         WYxMehQVd0WZ1SpGMJEneVgXhCdyof+eOyATCYz6eqmarIoOKpJBvDsysGk4lEufVW3S
         ScS6AcSA+jsRmd5ajvoMtTuU5ypI6a6epuDyl6FcJwq/VoU46jeovfVRLUhWRhZ2Eneq
         frug==
X-Forwarded-Encrypted: i=1; AJvYcCWDVazzSmxaLpBP4sbPUJJ+jcvCuyCwbqpuUO3zEI8lNQheOM+/Kf4ve3BXU2zeg92TeCjf6yxW9+jgLx6XDlY7pJ0B7jno01lTGkiN
X-Gm-Message-State: AOJu0YxK3wR+cBc+VfVNL18A5WHlMc+MFrrysGPI8np+Q7/DpwKAyjeL
	bLsncji5vqrEI+8lgniq+o8TdVoWP8+9DmdGwazqcWXAioCsCkuzMi1l/8cdBhP9Th7EJ+rgOlD
	NxsUDaqStOiL6037dYsXCnG4HgSy7mjxNXtjfnw1ZVKRIRbwPT7K9REGJsWpiEw==
X-Received: by 2002:a17:906:eca9:b0:a3c:dbf1:ef8b with SMTP id qh9-20020a170906eca900b00a3cdbf1ef8bmr3930970ejb.76.1708093207884;
        Fri, 16 Feb 2024 06:20:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhbk60hDARtBuFq2XZdPqd7EFyGI+Pd7rc6jP1booLb+F0DovdYQvvhEuVAtq2n2zEPMc5yA==
X-Received: by 2002:a17:906:eca9:b0:a3c:dbf1:ef8b with SMTP id qh9-20020a170906eca900b00a3cdbf1ef8bmr3930948ejb.76.1708093207508;
        Fri, 16 Feb 2024 06:20:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id rs28-20020a170907037c00b00a3c66ac512asm1592316ejb.214.2024.02.16.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:20:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C2A8D10F5BF0; Fri, 16 Feb 2024 15:20:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable
 timers
In-Reply-To: <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 16 Feb 2024 15:20:06 +0100
Message-ID: <87bk8gcwyx.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Just one comment on one of your FIXMEs:

> +	rcu_assign_pointer(t->sleepable_cb_fn, NULL);
> +	/* FIXME: probably do something about the SLEEPABLE flag */

I guess we should store the flag in the timer struct somewhere, and then
restrict the set_callback() functions so that the regular variant only
works without the flag set, and the _sleepable version only works if the
flag is set? Otherwise we may end up calling a non-sleepable function in
sleepable context or vise versa...

-Toke


