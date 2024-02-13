Return-Path: <linux-kernel+bounces-63626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C981585326D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E981F24B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F8656B65;
	Tue, 13 Feb 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4+npAXG"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0756740
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832684; cv=none; b=jL6VxaysnUEQH/iMa2JkOCVX9isZp8TazzJgBmR73bseCQyS+DB1sD6St5lv3+0j52//ZNMdz8Pwe01cGeAdOXN1FeTrQ6sUaY7NlDX2TvmyjQvz8NG4+nmxBe5kyBkg7qHDt1+6blbJe5kk4WHsna9pAodkulearwlQo1wDQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832684; c=relaxed/simple;
	bh=PG0fnIj5fzPwDy7NKqOopv4gHng+od9OkxEHBqOwPyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkwYTALkAU31Wua9uoV7aVHwDe1Qaaricy3U+cspn5yNrSjWFCuPKCO/qe6INxc5VMoXMwROxf6XhKCFGVcd/r2aOp+JTufeiPazCAWUhQvZrUgyG1PCs7RNVnmKhahP0TIyhF/aLv2u2kvTgG3mD894agMfMfS3/SiZvdBeWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4+npAXG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso9211a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707832681; x=1708437481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbE5lBYMsBbNOMJCkljKpvO5qoGNkQekNJoA2aNf4aY=;
        b=D4+npAXG9fobh5Fw5uc+fz6WEtBM0rQM8CeL+RRR+5mgqTvfAnOyMjXp5tZ1FHvx5k
         bWVQdrl9P4XU4U79BRYu4c9NB9YC9YAE4GUw+VW+XLv/FDtMUHc05ssfhjgA4iMKVh9t
         TMoQk/x4fcY96MGb5WUTd7dTFNl6nuYndBYbe9TF+8GlIi2sdHNemuKuOgnP6j8/+67T
         m2Oc+0pQBPDlBvXnbbBGjNfjkoh2xyHNNw4P20/UN7OrQch0AXLtZYfPKbeqjJibSUT8
         otH1yjEKEphuPaxpHbyHLeHnVxunZLmDvs2et/fDp19fm/R/QAfoVuj43Tw0fizjjm+9
         bFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832681; x=1708437481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbE5lBYMsBbNOMJCkljKpvO5qoGNkQekNJoA2aNf4aY=;
        b=AAvAgVil8Y4RGpznN3pK1wx4VWjs2ge0alhyI7UPOej54d3gb57sMlmkFfPsYmdN8k
         rzv8hUcbsrfN3XexkD2dUuJ1dbqvo733qVhsGQdkS++EEmZVUZ+WZuR8VrMZSEPRQzf3
         mpvnEZ1jtBBrkX27ShFDuQcq+337di+sO+MfQ/TLlp6NKUgQybryiMHHrYZILlXfYzF4
         Z0GT4Mu3P7jZtCsmpRLfVfCoJmirymFnx97X3Y8ZVfuXVtFPiR9ZEDs1Nv3xK1PeQY9i
         E4Sqb3q+NfwUeJwHLzufWuXmDaqxBFNWsE9BZCUCIQDQDre0p+IBqBDs983ez1ZAsnQh
         +27A==
X-Forwarded-Encrypted: i=1; AJvYcCXHzusG6zM5IXdfXfMMrJO6Zcc1yA/sa259km8hC30rb4O26DzkLCkskx5iHxkReQ8lF1NzNhYoYGN9ZHG7ShfGnAWkfr5xmpF65cP0
X-Gm-Message-State: AOJu0Yx/k072mH4bk9HuV6qiCw+TvBkpJx+pXLo3ZrqNmafb49d55h2Z
	wNLFO130k9J4TJfGARNuEeZST7fXdEdMiyRUIMd7y4ZdxvbvIsAtJ6c5vUSyr8l55LI6WTJrMbq
	XqpDiOZU/YzgUppfMBaqOFv8psdh2UGwsQhov
X-Google-Smtp-Source: AGHT+IGfb6Z8v6hajoJG9DaoOpHtyuo/KUVPZbwc7KekimKgbqmQ3fGjlKpw8V/ld9ImDFucTk16eL40tenMPfDdd+Q=
X-Received: by 2002:a50:9b5e:0:b0:55f:8851:d03b with SMTP id
 a30-20020a509b5e000000b0055f8851d03bmr120225edj.5.1707832681004; Tue, 13 Feb
 2024 05:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202165315.2506384-1-leitao@debian.org>
In-Reply-To: <20240202165315.2506384-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 14:57:49 +0100
Message-ID: <CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on BQL
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Johannes Berg <johannes.berg@intel.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:55=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> softnet_data->time_squeeze is sometimes used as a proxy for
> host overload or indication of scheduling problems. In practice
> this statistic is very noisy and has hard to grasp units -
> e.g. is 10 squeezes a second to be expected, or high?
>
> Delaying network (NAPI) processing leads to drops on NIC queues
> but also RTT bloat, impacting pacing and CA decisions.
> Stalls are a little hard to detect on the Rx side, because
> there may simply have not been any packets received in given
> period of time. Packet timestamps help a little bit, but
> again we don't know if packets are stale because we're
> not keeping up or because someone (*cough* cgroups)
> disabled IRQs for a long time.

Please note that adding other sysfs entries is expensive for workloads
creating/deleting netdev and netns often.

I _think_ we should find a way for not creating
/sys/class/net/<interface>/queues/tx-{Q}/byte_queue_limits  directory
and files
for non BQL enabled devices (like loopback !)

