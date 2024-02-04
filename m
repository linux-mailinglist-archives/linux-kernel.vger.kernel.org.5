Return-Path: <linux-kernel+bounces-51362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A3848A26
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AA21C22DF9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3FF1364;
	Sun,  4 Feb 2024 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX1trNdl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49359EDC
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010022; cv=none; b=eGTS9CPDDsfNhkOuYz/mcZH6auK+r6LwCPd2tnvbuZbSMfUY7s6gZ4YfUk1s8eRqfPQLZT0GXxzcjRzUb9g7/2bSEHe3mqwyhCKA6s+yCSb0ymPrxAx6VegQGDTO3c4hg2+DOLkF4Uo6SOq0w5F369rxQ9PKx7htpm5Ps5CQ1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010022; c=relaxed/simple;
	bh=EbHyPq/e8zmbhFVu6l6AuI8lO+YbCkSelDyByV6X9Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUftcwj7VG3c/JOlOcUUh92ACcluYulj5BlXvcWIo0O5zo9P7fWYT4nZAzSxU52tNr2WoiMotXx2PcG9Hx6WxU0Y6ua3Fw88wm4IE+y+Ij9Zwrb/oFtJ4FACriE0FOS2KT6JHPG6ks4ZwGc5spZU84ooXT987F33JX3/4NqGO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PX1trNdl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707010019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/5rSTh5O6+3Z8TDl9oL5m0EarOHPUjVQ3ykUHSjRbo=;
	b=PX1trNdlEn3cWHvNoKIEx6rUphe2lo9oNw/NzV8++iBT2XN5plB2piH5x7+nyGUczNd4oT
	+IX6rMdcYkIsN6K+A5M4wjO6+gwp3iUx0y5qRxiGycjmfvrfqDDpSgM7GoonRk4O5wYDCH
	xGZli9CaGhZt4qD0eeuF8/7y6OxK7rE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-srwqOVf0NKKzCt8n-PsCzA-1; Sat, 03 Feb 2024 20:26:57 -0500
X-MC-Unique: srwqOVf0NKKzCt8n-PsCzA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-59874c4b5ceso3580322eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 17:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707010017; x=1707614817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/5rSTh5O6+3Z8TDl9oL5m0EarOHPUjVQ3ykUHSjRbo=;
        b=ntL0mpRTE7TUzQ6ASR2JmgKMJvFx8EH/o8hfEwPo5WjhN4Kmt5nmqPgYLhq4iGMjFE
         tRX2rU6mosBwrxh16qUKbgVWhPMFphT5X/L5HzPebkst7sAWeFFDxWlDA/AHwg6b9bso
         Lk2QcDaKk/rqooon+pbGuv3RwIIhTJBK9w3Gdr7+2CIJhN5Mrb8jXKiox7Nj/9J31mh3
         HK9/wccGc9p+BQG2r/7hDKfXoNno7gmYeUUcDLt80Xlj0bB23V9CyAebTfAU2hkrDAHP
         YpBnzts1lSAtDT93EtXNppMMT6Uw4y7ZMbvCBMS3IfbbXaTfXi1k196eYZP63udNLjIs
         1IoA==
X-Gm-Message-State: AOJu0YzVwmvPkvYvD5Hh/8zhJ8Y1KPOnUTLEC3Pd8dwW5k2SGMZ34NeS
	hF/kQzGLrXExcrRyLjCKZWVudfqa0aGrGaknPaQJ48JlXNfwgAg2JCM1vsVT8bq93PaN2HffVeG
	aREsB1qtCd3c/nVwOtXqxqT5hEVooe+PyBJvaYoQajCd5BUiBW2bUS0D7YgA1zwjVdgcv3OkYoi
	USKfi4wulMPCKt9fnu+s32y6C96xJ38Eqj/fP+
X-Received: by 2002:a05:6358:6184:b0:176:5bef:d337 with SMTP id w4-20020a056358618400b001765befd337mr13013792rww.3.1707010016937;
        Sat, 03 Feb 2024 17:26:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL7GUFwM4wvGQE/bEqw3pl1aZ644PP4TRzexyzf3V8ZcYDPON7gGZHdtKH0hUTcIPIgwoMq3wR8CVeEz3r4ck=
X-Received: by 2002:a05:6358:6184:b0:176:5bef:d337 with SMTP id
 w4-20020a056358618400b001765befd337mr13013773rww.3.1707010016618; Sat, 03 Feb
 2024 17:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Feb 2024 09:26:45 +0800
Message-ID: <CACGkMEvLOv9Mr5ayNxmuaJU_pHp0U2ND_BmKNYv3fDZvOjHnrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: Fix code style issues in <linux/if_tun.h>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xudingke@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:26=E2=80=AFPM Yunjian Wang <wangyunjian@huawei.com=
> wrote:
>
> This fixes the following code style problem:
> - WARNING: please, no spaces at the start of a line
> - CHECK: Please use a blank line after
>          function/struct/union/enum declarations
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


