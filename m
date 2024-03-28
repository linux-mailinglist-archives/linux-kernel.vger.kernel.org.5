Return-Path: <linux-kernel+bounces-122246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C6F88F437
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38F11C33837
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A05364CD;
	Thu, 28 Mar 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2limyeC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77C816
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586826; cv=none; b=WHDMoFcyN6I7LvnaGxpryHObs25+7y1VNo2ppBHUZjOSbpEDHl+divdYdPnfPLxzE2HFBlcTdVM+ZNsw/h9wNybtSHblcuazKlXlDnj16i7U8XmPSSWDL+4snmvFi9Zrbjm2Yg5amZ+lKap4ONWsUu5GcF71APS6rvBq3u4f7AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586826; c=relaxed/simple;
	bh=5O0BckSJkMcZIPPF6A3HpA/50UE6EVGOMA31bgfACvo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4OI4b42nM/H86YVyK33iL3Tb+ScSI1QVp52WUYIM2ksl9WAmrHWxfygEGnMCD6bpYmGbBBnr+ixSaSai3N9mNFtO5tCdIIU7gaGWndCmotvr5AM5zanC+78ydW8bRgn+X9vbldoC9al1H9//giufLsOUtRPeOtAdngp4wHSoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2limyeC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711586823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5O0BckSJkMcZIPPF6A3HpA/50UE6EVGOMA31bgfACvo=;
	b=R2limyeCOhyS/KCKX4B5Vc6pF4TG0ZJLHqoIqz5mGHhNZ5x/O6/i8tCvHNjAHe8CDO5yX3
	rKSqffwXfPpRqBha7ARlKpP5EFiRyPqv/aCi7YGpLiEl41T7fSeuGJe84NGnZbF5kaFna0
	1Dp2SIz/ZA+WenwQDLfbXbCxJsAZjtg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Ta9YYY_zOsiOXRpy_Ar6WQ-1; Wed, 27 Mar 2024 20:47:01 -0400
X-MC-Unique: Ta9YYY_zOsiOXRpy_Ar6WQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d48517c975so1925201fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711586819; x=1712191619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5O0BckSJkMcZIPPF6A3HpA/50UE6EVGOMA31bgfACvo=;
        b=TngLK47JEJOwwBUXYYdkPJDY8iwMoRvfNDm6iKq9PH6TbbUuHoXKogkewJ3xnvt7qZ
         3Tl/6D3M4UOUQLfcNqAPoeED+sNyehjTBeuK+5DsNX+ur7x7aUTTCsY42FhQsOHhgFBX
         PGv9djDyWCSxwovhHdVlcLHtRrVLbUQ1+fIYbWCSkwte6UtJ95OPJtN+Lr8gHSLIVUvM
         BVbByNSvDqCf0exb9UByipnzrmIiKixsaqC69mpp57RaQsvci964OFzhQfio4hWS8DcJ
         YaTUYAMNgNt0sPBab/vy0Fi/+7aygq74oiSsOPIUjMAtXzfxTRu4clysdQCrbsgXnDff
         vARQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRuT2MMEoyLPvneXF52jsltKlVpLfPBmV/ao1+weaaZ+nHCCWvaHJjNJo4IVHStIqvESHoIMNEw6pPfasTN4MEhY7W+cPciydYjmeN
X-Gm-Message-State: AOJu0YxQStFYPF4k70ikA4OjdSEAf7dE+Vaf6JXX9XnaMdQWxamnJ+vL
	MNzr7Nppne9dfGkDh8a/7JchPcGoqVGMnP3IL1nb1Q+cTJjN+ShOqITVrqlPEN6kGEi1QiStT2o
	qmpHhHUzXVk2ohhRMQMj+mJ6+mj77X13MlWa8wZnR1T8RoycdrXhVj0fH7N9Hwg5BeCGUaVloGn
	0zX8MAx85I6RBMNpnqdukwfsQHsU+YfEsBwD4W3pahO9Xy
X-Received: by 2002:a2e:9f50:0:b0:2d6:f96c:d84d with SMTP id v16-20020a2e9f50000000b002d6f96cd84dmr867643ljk.16.1711586819578;
        Wed, 27 Mar 2024 17:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDWK6joV0/iQh5KlYwN44LS5IngAbC7R1Qkn/dm1JPxH6MSFYi0B6bfaI3/MpIh/ZUSeiKhOszWywYXmQfdeQ=
X-Received: by 2002:a2e:9f50:0:b0:2d6:f96c:d84d with SMTP id
 v16-20020a2e9f50000000b002d6f96cd84dmr867635ljk.16.1711586819340; Wed, 27 Mar
 2024 17:46:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Mar 2024 17:46:58 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240325204740.1393349-1-ast@fiberby.net> <20240325204740.1393349-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325204740.1393349-3-ast@fiberby.net>
Date: Wed, 27 Mar 2024 17:46:58 -0700
Message-ID: <CALnP8ZYMJufj1ALQ5ffojNaY6fj+K8rsSo4JyFx1qoSTjpXg8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/3] net: sched: cls_api: add filter counter
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vlad Buslov <vladbu@nvidia.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llu@fiberby.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:47:35PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen =
wrote:
> Maintain a count of filters per block.
>
> Counter updates are protected by cb_lock, which is
> also used to protect the offload counters.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


