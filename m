Return-Path: <linux-kernel+bounces-10081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D397081CFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161BE28404B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEC82F858;
	Fri, 22 Dec 2023 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VCv3oHEG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C182F845
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e23a4df33so2753455e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703283899; x=1703888699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u6tkYvfFf9EYx0akzruZKSySHUudDMJfGX8YApzObPA=;
        b=VCv3oHEGJxPF7qyf7bMNqXSSpH8V4FAlCKoLel9d+EclcAXSp9/F1TPdz2Q2wy1YyF
         uUK7LHhkeSynMQnQ2VvjBjEyGHcPMqB7uhFS091We3xRYUIRxCy/hilalq45t+4OeKMa
         aQ8ydEt3sJG2S4+xK4xxzL+vDiDE5JEkc8E5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703283899; x=1703888699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6tkYvfFf9EYx0akzruZKSySHUudDMJfGX8YApzObPA=;
        b=eijq2bXR4YEIV66MFof/yBC/88Q9yW9eFex0Hnu/T/pwYsZ8Jjta/BtZ+O5qArswf0
         UEGv4JWQCaEztbh4i7oPzgQyp3+98rldpn799svSLWStIXrK3CJQaqnE4VUnVsbk1G+/
         NeNusm4lAhlszt7K8yGA+Zv6L40nG+lvKmCkKQizsiivQXhVDEZA8TvMRAoAwNIBXjGa
         /VBAaaeXHW9+9H4xHBrb5zpO6oBMmL2BFhH/wy1H5yIHMQRWB9E6qXlehUYJbJ8AO6JK
         S1BVWSNiuqy92pw1Df2zdZRqGfbdPoUNWUfcWp/ENpOXgeNTScmi9+GZl56CUOQG7Y5R
         /SfQ==
X-Gm-Message-State: AOJu0YxxRTCmar9QAWl/Ro2hF1k1qJ7qVhb1dOcwjZJ8oYhcoObK/nlX
	D9tRfn852xmTp8gBKZQ09Rv+PLuY8KWrcca7+2ESNZgkqce0Xg==
X-Google-Smtp-Source: AGHT+IF7W7MXIfiTJRUOrJX2SppAqvTlEXJbUGVoLVHJRtGWPvhCIg7ff5zO/R10rfIcE2Jog6tkMg==
X-Received: by 2002:a05:6512:2083:b0:50e:34d3:563b with SMTP id t3-20020a056512208300b0050e34d3563bmr981430lfr.0.1703283899472;
        Fri, 22 Dec 2023 14:24:59 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id f20-20020a056402195400b005543f50e53asm1973905edz.93.2023.12.22.14.24.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 14:24:58 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2340c803c6so271628566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:24:58 -0800 (PST)
X-Received: by 2002:a17:906:259b:b0:a26:9c9f:c2ed with SMTP id
 m27-20020a170906259b00b00a269c9fc2edmr1081032ejb.4.1703283898326; Fri, 22 Dec
 2023 14:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222082959.7d08894a@gandalf.local.home>
In-Reply-To: <20231222082959.7d08894a@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Dec 2023 14:24:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjxd29418Y913yQAZH9-Ye4S8yOvubAaDN4fg8v6sKnhg@mail.gmail.com>
Message-ID: <CAHk-=wjxd29418Y913yQAZH9-Ye4S8yOvubAaDN4fg8v6sKnhg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fix eventfs ownership again
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dongliang Cui <cuidongliang390@gmail.com>, Hongyu Jin <hongyu.jin@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Dec 2023 at 05:29, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> tracing: Fix eventfs owenrship

Instead of doing these daily pulls for fixes that fix the previous fix
that fixed another fix from a week ago, I'll just wait a few weeks and
maybe it will actually be right then.

                 Linus

