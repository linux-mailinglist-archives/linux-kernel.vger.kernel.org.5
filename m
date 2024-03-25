Return-Path: <linux-kernel+bounces-117178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A26F88A876
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD6C342BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8DD137765;
	Mon, 25 Mar 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ItB557KN"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999EA6FBB7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374737; cv=none; b=hSFdaAZSLWZcfEfIOXLHW+NXM4ZeDnHc+TfHGJ+m6moO/m0LvY3D8t9kNkJ2sHBXlAI0oHRjWhCnQ9H6cZMjsOPI8Mb2ibRA56qXOWVBZ8rdN6YQu6vUzosVF3nxD/ohE+KswIjlkTY88pfHKkVoZMdZ2/Qho0XYJ1BPgwxSfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374737; c=relaxed/simple;
	bh=svPkrUsWc31u5PxOeTcURerKjA9TBu7K7e3w1kgsNqo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ce+i+75ISuJwS56ZyluR418HoTSoXRqKF+Nxk+xItqjG4v4DQoH5GdHR9VWTLZfNHpENKAFnNJgRMkGmMYvZ9VDvINOtUfphc0TgF/4SZKsZ5oSM6vMN5AYVLAbJIkn7GUOEhfp3KngJf+7GC0aQcB1GNCkK4zo0pvtOKN5URyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ItB557KN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44f2d894b7so532582866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711374734; x=1711979534; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=svPkrUsWc31u5PxOeTcURerKjA9TBu7K7e3w1kgsNqo=;
        b=ItB557KNcARm08KdTuyx10BNBt5q+1kn7Rn2lWbeemwIQBzkaWDPLCPNzm/cCgAaaj
         IAGr0TS7y7XYQvcDUpk9Znl0/ez4l4ZNLjKX3J0tALTQ4UAO1Mtf2RCuPoDNgKLrTPUF
         5E5JnAVLaLlF+MzdAVTzwZ4UtI6xfPUI+qZdM/ymwbvQe8h6OvrpkNXZY2gLH0NrxWkf
         23tV+yUqmwOSKbGJEfSj2CxR6ETP0FIU5eLTRzT5jhM7CEQpBK9csY65hmramFPP7Hp1
         iWb6KoK4x1sgEdJhV45B5HVjmbZ2Rzug6hrnJpQ+L5k1srqWKlqv1prrLhVzFC8zcJfR
         PEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374734; x=1711979534;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svPkrUsWc31u5PxOeTcURerKjA9TBu7K7e3w1kgsNqo=;
        b=uwdxo7Jrr8pPIZo6yJ12D2BUJK3a98hmNEDd1fNgxYYdXMwerhLuFxZFGS/lTTSDcK
         56A1p6w0wsoTCvs7O5eRm4TisMLeyUtibrYitLJFPWc3Be/m0pX9I6bJOmjhy+W/8Zym
         5lviY+JCpNpRziqUlx0nHI+ZBV13RV7uRelS/MVKxhqAHf1KLR8p/4mTD5g4sTueM3kD
         6atL8m+dPvWPDIhnvvLfNjhhFpqdH+So8WCwSkpFqZcp/Y0XbwSXHtGnPj0fQ7U5iip8
         5CLTckIEh2N3hCqKA5V1XQj2ANQN2hnlTE+gXiXfXKw+f5tSr6WRlXKS/8fZ0xiPxr8l
         AF+g==
X-Forwarded-Encrypted: i=1; AJvYcCWVZVfupn0l/KMDc6di6RZRtJBkkDa4YVTeNjvWvHJ8CMBli1rLKlvaMSvp3jzF4Qrvd8/Sn6x1+C6VG4wMDGZrTOsUFqvNlwR80iCl
X-Gm-Message-State: AOJu0YzMTrME65km+laS/0jYKeOj4b4kmMDgcZA5ovyOipRQOwSmrrEK
	dJEOXrX/GL30t3/YfrsmHCyNsdAeOZaqi8msPCRiNuyRU7qmTlAYR/T2LT2fZr4=
X-Google-Smtp-Source: AGHT+IGmFzRBxjkHf31z6d3Lq36FFy7Enc6jBbimLiq65p2x3hU5JphLJecADC001IRmMLuW5xDSbw==
X-Received: by 2002:a17:906:3b09:b0:a46:ba19:2e99 with SMTP id g9-20020a1709063b0900b00a46ba192e99mr4763483ejf.26.1711374733929;
        Mon, 25 Mar 2024 06:52:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a6])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906090f00b00a46d9966ff8sm3114614ejd.147.2024.03.25.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:52:13 -0700 (PDT)
References: <000000000000dc9aca0613ec855c@google.com>
 <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
 <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
 <87y1a6biie.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Edward Adam Davis
 <eadavis@qq.com>, John Fastabend <john.fastabend@gmail.com>
Cc: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com,
 42.hyeyoo@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, namhyung@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, peterz@infradead.org, songliubraving@fb.com,
 syzkaller-bugs@googlegroups.com, yhs@fb.com
Subject: Re: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
Date: Mon, 25 Mar 2024 14:49:19 +0100
In-reply-to: <87y1a6biie.fsf@cloudflare.com>
Message-ID: <87ttkuber7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 25, 2024 at 01:23 PM +01, Jakub Sitnicki wrote:

[...]

> But we also need to cover sock_map_unref->sock_sock_map_del_link called
> from sock_hash_delete_elem. It also grabs a spin lock.

On second look, no need to disable interrupts in
sock_map_unref->sock_sock_map_del_link. Call is enclosed in the critical
section in sock_hash_delete_elem that has been updated.

I have a question, though, why are we patching sock_hash_free? It
doesn't get called unless there are no more existing users of the BPF
map. So nothing can mutate it from interrupt context.

[...]

