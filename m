Return-Path: <linux-kernel+bounces-163846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1258B7487
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1734287CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69B12D77D;
	Tue, 30 Apr 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ovy3tA4L"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28182128816
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476700; cv=none; b=GQOYNDF5e0ZBYmeqndiHadKGJMR5PN1Vtpp6JkUrOc+deL0s21VPbG/jxoF3UtIx1gkszZddogQVK6A6OZB00Ypofx5f08NajkANcIC8QSN7rWwnLyo8b7DbWzLswp5bp2Qvw19/U5O13dV5jNfWb6haNntmMUu1nxPOir8QFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476700; c=relaxed/simple;
	bh=yUIj4+FkYMEG1DEHNAUghGWkLxVUu3cILbv8A0YQeVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dG0SitN9HQ+GZYmWyXdehVlN2O2XAzwOPKgLpy817xzEHeDFsx0S1nw8/sWYaVV6hoZKfOLLMXOBTTwCUMcJPZ73lTrF1SrFYFutr6Mf2cR699TyXLu6DBhW1rB/2R0/vK0bNewDM/9tDVm+YaVyshhzEendKrhU5XdXsriSf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ovy3tA4L; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b48daaaf4so46665e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714476696; x=1715081496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUIj4+FkYMEG1DEHNAUghGWkLxVUu3cILbv8A0YQeVU=;
        b=Ovy3tA4L9+QP3L4K3+g2c/RtCV3QqZ9TPLFsooCAeZYNTQmuSJBiyfIWdxv9pBEFhP
         cmOkpzrBvC88mY6L5vishllQvGubhs8kv6XGRKTCFxmz/ZWIFOc7RNfRzt2gJLG6oFZN
         qNADq4exrCvSIVFeKY5XbRegPmQjdeIUJlyfn+h7zzyHVq4XOgmXWnvr6haMVa/JI5gj
         TTue32WNhTEKK6r/yQGYkrz4Eor5dC2UcSzZ1kydDvYtohEQOsYMTxLvzSDxJyLDuJn6
         8ih5KndArM896GpGQsycCwC5+Xl2puaXFp7MU5dBGpAmTYc7kqhGJ2jLpDXod98vHJzR
         VvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714476696; x=1715081496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUIj4+FkYMEG1DEHNAUghGWkLxVUu3cILbv8A0YQeVU=;
        b=p/+EsaRssZ3Ve37kYY8LcJ0S1eviaF9p2F3S/3b49cS/CPLVYzcqk7hcFI3eTdt9Ns
         h5dMPncQgyNXvdOgBgi2Zy9Wrg6/GFWr/qkDd4DUfNPzztiNHiylN/GiHI5kzhj1/KCb
         AWx+qq039mk6tW99J9xf0b5uNeZ1ON9LngcdkuTeatcOdZy10+Q5rETRq74RoP8W6ooA
         1IJYLaWR7sOTgNLNCebhJm4b4AokbIgUkPPxEBprC+wuPflwsX5xDF1sOxEQJKFUJfdC
         tFegAUWlqSyQdu40/xlcrNHGx5LGyXascsv8qCOuOzNwN4XUMeREvbm4WPdD1PbSM0qY
         9mdw==
X-Forwarded-Encrypted: i=1; AJvYcCV98ebOx/VmRJOd61bKeSYDeTOiPva0YYFwPoEsRsafaFuUyPRO0En/mHoNdsDS0xTSJJgXCxyelxP+t1zIDq7GkYdTs0MkuKyWj5UN
X-Gm-Message-State: AOJu0Yy/W/KCO6p16EeTGjJ3bmNb4bwPBFuHur/nGhlnAWJF/5h0Jyx/
	tw8Tx3w20+rJ96BLfbfCkl/UJ2YoWHXePaiZb/uOhay3cGRvcjSaYIVAJqZcifFt3GoTJZ6xxRW
	TNGq2cHJMX63gtAPSLglWJq23boNBPF2CwQNCSN/GyndNG80shA==
X-Google-Smtp-Source: AGHT+IEZq+my3yJo4Codkqnr73ObIgvGdkvuSMgijj2W/0iEJpAGKjWPpu49gTHc+sAbFKv+yXyQLhkOgeUQcBKjn4s=
X-Received: by 2002:a05:600c:4754:b0:419:f1b4:b426 with SMTP id
 w20-20020a05600c475400b00419f1b4b426mr171453wmo.2.1714476696227; Tue, 30 Apr
 2024 04:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427182305.24461-1-nbd@nbd.name> <20240427182305.24461-3-nbd@nbd.name>
In-Reply-To: <20240427182305.24461-3-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 13:31:25 +0200
Message-ID: <CANn89i+-uWYYhxjnsqtxhDD_kjoiMBo+PO-5ZAtYVdh=njje-w@mail.gmail.com>
Subject: Re: [PATCH v4 net-next v4 2/6] net: add support for segmenting TCP
 fraglist GSO packets
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 8:23=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> Preparation for adding TCP fraglist GRO support. It expects packets to be
> combined in a similar way as UDP fraglist GSO packets.
> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

