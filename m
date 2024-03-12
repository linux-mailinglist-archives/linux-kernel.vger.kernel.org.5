Return-Path: <linux-kernel+bounces-99991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A83879067
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB071C21B84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0503778260;
	Tue, 12 Mar 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKlIAMlH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3777F08
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234648; cv=none; b=mI0JgzVQ0atXiRZKgnnlLpsa5AqBnRpeIlsueAaxgBsZFGqdFM8lWImdKEazshPIt9k3ogLqUPXS00x4VGdk9CgjzPXts5+55Ixh0VUZHWuQHNzar/iwgHypJencCQJ/wfFhgpHkmIaXn8YgJp3l9uGksxyL9mQwHE9UeJbKlOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234648; c=relaxed/simple;
	bh=XLzhBx5cmeltLUsekaqo1Gq+d+APrkdNzuOlUguUReU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mkFiwnkhTUn9tynkGScq8lTfJP2lvIrAgNAG8ZEHfv6Dl4lWyklyV/KvhaxzpA3BgpJdaEY9jeu1NVC8RsAv5bBUHf0rz2ae2pB/SQNHsGkBfGwXSlwlSdL0o29ZOGa4FlnCP2Jvhw1aUVs4BGCBBYrH9xKdS8ylle3Qv8JpXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKlIAMlH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710234644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLzhBx5cmeltLUsekaqo1Gq+d+APrkdNzuOlUguUReU=;
	b=hKlIAMlHxuzxIHfmwmIpxl30GJRScSHcvHEqTPgR5+OTT+0Z9ZNqAZLdP8eE7PrB+lv6sT
	IFI4zTGD2mYgFegtkQ6Wcpn9zLCgghkts2sOi3cgoNtiIz0S+XZXiFuaGIZxclsg/k2iDk
	4GLghQJWppskKU5zyFFRBt3l5JJCImE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-z3BY7JueObCNeWV0m9iXjw-1; Tue, 12 Mar 2024 05:10:42 -0400
X-MC-Unique: z3BY7JueObCNeWV0m9iXjw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4623e798aeso82282866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234641; x=1710839441;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLzhBx5cmeltLUsekaqo1Gq+d+APrkdNzuOlUguUReU=;
        b=qExcFXnftUojsNkVTJ6A7sqRSE9PXXBWNwG4ky3Lo2Ms9bOhbzYR43KbzdvkPHtdt1
         SqH14MSyy3pYbSZqrOg/FEwYndXOvhA/bXGpp+Ez5D0Q0acDf3XfCf6M73ZqUr39dc0N
         IsfmWkVwS2q4ByzCS49LYX924dbvCxEMwwOVAdE5A2J8/iCOVIW/DPmycLu2V679Fj01
         cNrxlHwljp4CEqPeWRaMnwVr8p7uoGUxIzKvpPLWCluG2NWWEej34Yt59Nmjz8JL1qSf
         HP3xA9/Nn++sNA8fkIdyTXC0rnP+Tr36cFu9LKP+CxnEi3r0hgWdVsLsr/OhAFGUlgp8
         QDaA==
X-Forwarded-Encrypted: i=1; AJvYcCUHkXacmFWITrlqxwimLEuqTZlDPjiep5dr/XNqsE3AKSQs5CuYxhi9BR9ZB4pNEttEeq2i33GE00B+KdIRsu3s/VCjUVK5I60NSrAG
X-Gm-Message-State: AOJu0YzePBhRh6OgoXra/WyrW9o8ClYbJzvM4kOL+VyIKacogZn+wlEs
	/xoAzUGBA3hMWNxHWgAgsl4Y7kqLVft3akR8quGoBKHqh/mDThNJXtq10R0/idUPADufWVPzUjM
	WLqWzIp9xxWW3LfzWOBddQxRxmPGCjjy/VImB3YcS/Pr+c2xlAfhHW33zbdtD4g==
X-Received: by 2002:a17:906:d206:b0:a45:f271:38cc with SMTP id w6-20020a170906d20600b00a45f27138ccmr5282601ejz.43.1710234641722;
        Tue, 12 Mar 2024 02:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4maF56cAVVp3+GQAq6WH2ZI2cZeje5dJfkzEzjFvOejm3qAJ68TvKD0FXaOV+xbAibJG/GQ==
X-Received: by 2002:a17:906:d206:b0:a45:f271:38cc with SMTP id w6-20020a170906d20600b00a45f27138ccmr5282590ejz.43.1710234641379;
        Tue, 12 Mar 2024 02:10:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2067599ejb.126.2024.03.12.02.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:10:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 98575112FB6F; Tue, 12 Mar 2024 10:10:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ignat Korchagin <ignat@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com, Ignat Korchagin <ignat@cloudflare.com>
Subject: Re: [PATCH] net: veth: do not manipulate GRO when using XDP
In-Reply-To: <20240311124015.38106-1-ignat@cloudflare.com>
References: <20240311124015.38106-1-ignat@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 12 Mar 2024 10:10:40 +0100
Message-ID: <87zfv3q0hb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ignat Korchagin <ignat@cloudflare.com> writes:

> Commit d3256efd8e8b ("veth: allow enabling NAPI even without XDP") tried =
to fix
> the fact that GRO was not possible without XDP, because veth did not use =
NAPI
> without XDP. However, it also introduced the behaviour that GRO is always
> enabled, when XDP is enabled.
>
> While it might be desired for most cases, it is confusing for the user at=
 best
> as the GRO flag sudddenly changes, when an XDP program is attached. It al=
so
> introduces some complexities in state management as was partially address=
ed in
> commit fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when do=
wn").
>
> But the biggest problem is that it is not possible to disable GRO at all,=
 when
> an XDP program is attached, which might be needed for some use cases.
>
> Fix this by not touching the GRO flag on XDP enable/disable as the code a=
lready
> supports switching to NAPI if either GRO or XDP is requested.

Sounds reasonable

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


