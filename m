Return-Path: <linux-kernel+bounces-122245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E688F434
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9454B1C3371E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E82C6B8;
	Thu, 28 Mar 2024 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5J/8u+3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959D033CA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586809; cv=none; b=EpNzrQLwmLnSs45RzTU5iOh4DDTbiP2wCnVzzoWpeOJIpLilh52WVBt+TiPYSkxtAe1de8EjJt1VKX4L/sFb8pmy1rO+S0pZbuG4lIrrn2zDnZqyWWL6tnIwc4U4DDdeg5kNSvQe6Cc6p8SYycrZrLArYA5zDEYGt/OPEYJLZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586809; c=relaxed/simple;
	bh=e+4ifJmlrD+8SKr6HeH4k1UtmM7jreqdC8keZHdQwf0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0oUp1ahKhUQXyu2Ya2O+GzO74m0xtaYCW0ryz1XMQrKToy6gB4gZGoK9ZleqecuK5m4Sb3vW5oXyGHm5FcB3afCHSr8xeg7SlWGHdTn7TJhI5Y9WWayDsmwj0p3m6QzaOCszK7e5iH/LtLBPrZWkKAbmdrn4gA3hFx1ZK9V/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5J/8u+3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711586806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+4ifJmlrD+8SKr6HeH4k1UtmM7jreqdC8keZHdQwf0=;
	b=W5J/8u+3lz54ur8PhV9GkQL9fhl3reYVBZ/HawZ3NRP8QIpHH4KJGqqaNey2LSZ6uDq6Pv
	eInAztqX22ME5x481eEs95Eh+YjWekg3GHvsa3w9D3z5qn/obj+ptz8c+AmGzgSfjYF1jJ
	Cctw2JmmPZERmWaEEI0RdfTFc/VhPoQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-2s3kRB_4MzG9UYBq4BROtg-1; Wed, 27 Mar 2024 20:46:44 -0400
X-MC-Unique: 2s3kRB_4MzG9UYBq4BROtg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56c3dc8d331so246777a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711586804; x=1712191604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e+4ifJmlrD+8SKr6HeH4k1UtmM7jreqdC8keZHdQwf0=;
        b=pSAIFkFWteoQ59W8tC1rudJg8wZ9WsYdUkxmOmWH4Q91DgjzXrbI7dOW6bYdaQiOsC
         OfCQtdRLKuF+0QWWMAnW3XfmVJyQtWVpSTb9VXF1oBrUfkBU5pK/XwveIVYESLKX7PNM
         bysxAYMYvwN/ZLpUQ6MRUnMJiErDq/KhNqHdlfIQy1uP7jTOd4zYppx6f5d4b25we1vK
         7G9RXlErZ8Zvr6CVMFgU2Z6ZnLLbStF8FQQQv97Kqrjhpn7z/0vu19UKNo9LpRwEyrFJ
         j8VWgf8gLUHu6wpaIB/nxmWWSft859VnBnj8e8bzYZV1fHEZr1N8I2fD/TGlIOrWNC/R
         DTLw==
X-Forwarded-Encrypted: i=1; AJvYcCXvFLdxvA5UDHWqnCfPqb1SoQ35//RbZpgmQ3YSIfusmdbNhH7P4/bXC62+n3M4J9j9LHgu7bKaJOiwM5s3srW8Wh4jw4kyenmLg5dm
X-Gm-Message-State: AOJu0YybUOqupOXfo6zbhnd2qnRwx1UqGyyW1kxBWZx7FhItJ4KOQkOH
	W0iIqjsM+s+YrOxJJxf3BxZrWmFp0LXO28qUOYfZr0Ca/J3rr0bCNigr/bopyaAt5dZDpVA5k1O
	Omeq/EAOwo8gDnQrVlZJ1gR4HOPlBYo5+spO6jw6/O9fxSNhATrQJumndH5Ry4epNJaP3IMUxrB
	lQ43YSI2Ly9HjM5mVrU3FWfqIPfZ1hYKLHtkS+
X-Received: by 2002:a50:9fa8:0:b0:564:5150:76a2 with SMTP id c37-20020a509fa8000000b00564515076a2mr925400edf.4.1711586803869;
        Wed, 27 Mar 2024 17:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo7MTKWsxPOWCY0sh5A+mehC8NaHptcM/Ec8NiDt6wp2lZwJVSnB6nWvqHv/BpBW9t2V7A+CiPQN6cuEBTVXA=
X-Received: by 2002:a50:9fa8:0:b0:564:5150:76a2 with SMTP id
 c37-20020a509fa8000000b00564515076a2mr925392edf.4.1711586803521; Wed, 27 Mar
 2024 17:46:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Mar 2024 17:46:42 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240325204740.1393349-1-ast@fiberby.net> <20240325204740.1393349-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325204740.1393349-2-ast@fiberby.net>
Date: Wed, 27 Mar 2024 17:46:42 -0700
Message-ID: <CALnP8Zb0US7-BPKm9nYSR2nKMrCknw1QnQGQbSSWhcz=ro+raw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/3] net: sched: cls_api: add skip_sw counter
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vlad Buslov <vladbu@nvidia.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llu@fiberby.dk, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:47:34PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen =
wrote:
> Maintain a count of skip_sw filters.
>
> This counter is protected by the cb_lock, and is updated
> at the same time as offloadcnt.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


