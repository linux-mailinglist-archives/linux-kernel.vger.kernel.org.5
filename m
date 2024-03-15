Return-Path: <linux-kernel+bounces-104543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390587CF80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81361F23530
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE53CF4B;
	Fri, 15 Mar 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IgljK7aV"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028313A29B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514463; cv=none; b=tdIzZyXRKH56lwzPQkS5ov2IPw+6TRPt8pWT4YzkoXwIniBFb4E6R2TQHutL9sOn4sxQixowdhvdE71VcSfFhsoarBCfEE/UezydBfLSzHKPlM+YtSCDntFSX9zZjW60jfItpslFwqS2rDxaf9BHUX9k+6wLQAGuJAuKn4bz9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514463; c=relaxed/simple;
	bh=q0sxlmWZ/FVV1zfz2VpYFEe+xwviTDIZ5JEWihPHwp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjRPGl3edZzxERAyj3jWAdvA6pmoAEDoIb1eqzPfkVLEXY4bBPMIgxWnR7oL7CxZIIdOKR9eDs9U5mTJ5ZHXScvm6nw7T1wO7Sj6+p6h/ZgSZ+r4OS9Rd3lj8kLXqUAyBHBQR3nkhWw6vKADaFiuE5FnXZmLWP5qdq7ApedyhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IgljK7aV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso2621737a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710514460; x=1711119260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0sxlmWZ/FVV1zfz2VpYFEe+xwviTDIZ5JEWihPHwp8=;
        b=IgljK7aVz7mWTeCcuJciOzy5qhMHo0og5Gm486qtN0CqfaqiZdxFRnuQIxm1SdsMD1
         NqpjwVbyCCdFeV1w+/Q/BnnJM6lzny6BvB8ib+HeXGUS8fsnLTURXZtcWHb2of2fy9sT
         mUI3Qr2TquspS7KBq1cLk6L6fW8jmCTsjXk3btZ2qFHGnW1KFwq4jq2VLq9pYeq2Kha5
         FQ9X7wufb4zrVI0JebZNTjbZdIhkgqMw9qV5Cgfd/ey43GpHyEB1dcGeuCQOZebRqFWL
         mDKINfC35wpiE1iK9qIRUH2W8CjUz9ySDfoEcw71A9WOWwYdg9EVSDqswajQVQKDUfEB
         bBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710514460; x=1711119260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0sxlmWZ/FVV1zfz2VpYFEe+xwviTDIZ5JEWihPHwp8=;
        b=nvCmXHg9w2yqiJU/Y/2j/IRd4CI6EtEmI61bIGoZ3dVKAVRf3tsG/VJ1zmd91z1X7N
         KNTSXz5v9zmuwvwl7jl0i1TMd3F0vHGgPxAs39fRo+kBOW3roCwo95NRg25aSAXxCtN3
         lj0b5RR+4ZGLSjpGPrmcTPtFbPn0WW9HphZiOuuGJB0UH+BlKXbrdOa232my9EGvdzrp
         bF0Xu+T+wqrh0jq07ir02ICU07z/SMP5b/5RfGL5hk3RvrpOBhuUMApt1arHJt7OWFjV
         l76P5ctkh8WLbmZfxw9klHVVUg1fpMQFsZPt4iEvYV0vp+mn3Bfu7kFT2BqxQe0hwFKu
         1M3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9YhRUplV3gt4PK5gktM3Fc73RCw2xhQoF72G00Pa0P3WgseTxP45N8Gd3ERIGehfrw2W4ObdHbcAJxuxB8d5HXWTko1wIsZ0QU3zI
X-Gm-Message-State: AOJu0Yz7PXID+82Pz/6jK6QQmR7pv4PWCoL7tf7pCDhd7qDaJ3ax9RR5
	yQyDY2DOLqoTVR4UZMPcVNFd43UjdZ7f6jYWz4+KSQHWAr+U4AtHcqKzcRSxoI2ERst5jqOkWUs
	v7CYRrKmsTpDAie1x/eLDHxVfn9ADV3vb/qXVoQ==
X-Google-Smtp-Source: AGHT+IGAXuUW49fzljDaSHnEPf/5724NscYefKAehPQ4X765R6/8qKdPAaZTE8bvj8BPPDkeMk7rsijwG2UmAT6Fg4A=
X-Received: by 2002:a05:6402:913:b0:568:b95e:8012 with SMTP id
 g19-20020a056402091300b00568b95e8012mr259127edz.14.1710514460320; Fri, 15 Mar
 2024 07:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710346410.git.yan@cloudflare.com> <f71214e6221c5c50b32a62a33697473c756e604e.1710346410.git.yan@cloudflare.com>
 <20240314145459.7b3aedf1@kernel.org>
In-Reply-To: <20240314145459.7b3aedf1@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 15 Mar 2024 09:54:09 -0500
Message-ID: <CAO3-PbqTzsTX9UBgdC2aV4pLdL6ddrSKHTXeYNoD_m5yK6qdrQ@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/3] rcu: add a helper to report consolidated
 flavor QS
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 4:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 Mar 2024 09:25:49 -0700 Yan Zhai wrote:
> > +/**
> > + * rcu_softirq_qs_periodic - Periodically report consolidated quiescen=
t states
>
> > +#define rcu_softirq_qs_periodic(old_ts) \
>
> scripts/kernel-doc says:
>
TIL, thanks. Let me send v4 to amend the text.

Yan

> include/linux/rcupdate.h:271: warning: Function parameter or struct membe=
r 'old_ts' not described in 'rcu_softirq_qs_periodic'
> --
> pw-bot: cr

