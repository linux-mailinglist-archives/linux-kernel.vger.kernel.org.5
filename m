Return-Path: <linux-kernel+bounces-159637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34FB8B3167
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F563284401
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EABF13C3EB;
	Fri, 26 Apr 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZqJMYr2"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300713BC36
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116803; cv=none; b=MqIUdOikxNbDam2sHnNDYVisqYHG8DBobKlW+U35sZX3n6ovO0Q/BfI/AIiYtvNDVJhNuGENPEA/fIxPY82vYvStVV1msvFk+pQdfo33ETz+RTtcJ3UESIUOmYDaFYOVPa3zHdBF0QbA4RtN70N/+n1UFtlREZss8ArbEm8WGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116803; c=relaxed/simple;
	bh=VeXvoXACL25UjHU8k2pGOUmm1D9NjDb4mHfPS5pOncs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdatANMlsqThAuW0rAjDa8vZ2NqJsP/QgPyZvOXrmJG2zzyKh3FHaIAwTuAxEDEtmxenY9jPXwY5qKKoJORIRPcmR5zrwLLmC2ulW1sUbe+2eabQP+sTn4ECvWBs9AzkQCqME4+5bwIMntgqnTaJMv1SCF/eAPPvThgtvrAfG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZqJMYr2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so8501a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714116800; x=1714721600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeXvoXACL25UjHU8k2pGOUmm1D9NjDb4mHfPS5pOncs=;
        b=aZqJMYr21PcqwTbYxp/25D8INmiIU1jhE8LUmOz7/Er7K83wPvep94Kx8AT1ahosu8
         +DVzK6owP73YyBV4Z+Jg8xQWvFunSaU6Kv9rHO4PTZlRvh6BgrorR2Mdyol2mqJqUC1y
         rGTrMx/yQH1x80hy6duX8XtlMxoov7htpe52o1TIexRdMlh/r3TCfBp+cJ0LBB7ZU4tW
         7U9LWsYVrx4GRwagSScXeY/Gxf911dsZd5u1qh7BtFXm1tglNERP+FDBPy4NB+8jmWV8
         FS7LHLdlUttC7kw5mHw3Ctvjr20PbkfTUxxhzfjeI4o5HLE7oGZUXG5cHPe9aE0Fn1Yy
         +cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714116800; x=1714721600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeXvoXACL25UjHU8k2pGOUmm1D9NjDb4mHfPS5pOncs=;
        b=s5NIHRAc6QKoNqzQTwfolO4nm9IVH1sG19ypzJS0azxXSgm29/vcHtIYb85Yp6AHkF
         VCWb0Ti/udRXrLUYKA/E7SfdjxFaj1N0UpHNtAbAS18rn2ktlAiu+8ePYxIKyU9CL5Ka
         Efo6KAtpoj5CRoLpIpdRcZlZWrAnSBEmbQa1lGXr+3OxQaPR2N5Yyd6fBdyFF/5aVAhv
         KweZ3qWj3moZ0vDibW3oPslnGAfxu1IV2u8qjV8HY3fnQNo8QhUuLIza3b7wutTdNusU
         +hQWykVW7W2i42xmdAbCQcQ5MlN0u/pel1tSrEGTfQwCutcxEYSey/u/ikSfl/EWqklg
         eMGg==
X-Forwarded-Encrypted: i=1; AJvYcCXljUJaEEO6Bq23nYLloQuhlu1Yt4A0jEFQc9IQ+++DaAPnhfflLR5T9AoHIL0Htvnad7SrNCo1tsNh0LpFkG1VEnPnvvXcGfFbiaum
X-Gm-Message-State: AOJu0Ywr+G8JF3jcoMF/X0/hXl7eQ+y8/KQnW7woeABBB+RbmfClx2ss
	RoKce+aOSRnp4joG3krayO8zCCbW6c45W7TL4VwE2ex5QPinh6wL2pkg1FiaEqL8q8lZQzajrcT
	m6QJxyuJvxImhpTET/QVeug8CM8onkanuMB3HWdSpfHTtnuDPBQ==
X-Google-Smtp-Source: AGHT+IFThgRtdsQLo9VBTOlpLtMexsuemQAIhrWu83M0GKnW9dcH/4cbcdUtwWVkZ1K4lae/j4Uu+5K95AqiK/dyHWY=
X-Received: by 2002:a05:6402:2d9:b0:572:336b:31b7 with SMTP id
 b25-20020a05640202d900b00572336b31b7mr116253edx.2.1714116800073; Fri, 26 Apr
 2024 00:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-2-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-2-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:33:09 +0200
Message-ID: <CANn89iL8VJP4u1daKKN1rC9FE-cJ7M6_JvkfEHd4yOZT91sFAw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 1/6] net: move skb_gro_receive_list from
 udp to core
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> This helper function will be used for TCP fraglist GRO support
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Eric Dumazet <edumazet@google.com>

