Return-Path: <linux-kernel+bounces-149354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8C8A8FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723141F2251A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6B8487;
	Thu, 18 Apr 2024 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDDhInLk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F16FA7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399865; cv=none; b=gPlrlNx/lX11fRY7i7LLRHjCFdWmZbj9NZoQPzcFmJVUZqMSQ4gzhgz8Byp0OZjW5nNhT2eRcXwDzQeQst81EG4iSoUV0Lk9p0ChuqXWrYa++1qtrxHI37I+O7AP0kaE438ktAEgvoftLtI5O2mKhAox7wojudIbxA946XYf4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399865; c=relaxed/simple;
	bh=6ygLYaCatgmj8esyzxPKSf1Vm5MNhsxUau+glf4fnUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILWaEe+r4f8uUOSN7uqFpvELb78USBqQ4YWLKfZ2z6xDNEBVO8i0VFrrynyUyO3Wj2SWlAClngWuDEmVEoQcp3lT0iX7GuSgL5Iw0wbbNLHZPh1VRMt2q1mEhJXNyxbW9AG9YKbVJ6l2feyjVfc1Rn00zWxGJ9UQrksUvgW9sgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDDhInLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713399863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ygLYaCatgmj8esyzxPKSf1Vm5MNhsxUau+glf4fnUA=;
	b=aDDhInLkSdKvMqKc3/8MCQYJDYpiHNShuS4WQqoMhms68A10RCFusCucxP/wobq0/WYHxu
	ifIs0ZHyPdA3jZm8jMCMvopt7Rh2yvewTvN0LMPAmDaJCnAt+m2pBuPeOnnhivJPpPtUH0
	zk3+YDbBN7TXBWGfQ8EHMQeyDO3vMUM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-fR9_WN6KPEqbleNJ_ulVuA-1; Wed, 17 Apr 2024 20:24:19 -0400
X-MC-Unique: fR9_WN6KPEqbleNJ_ulVuA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so303570a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713399858; x=1714004658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ygLYaCatgmj8esyzxPKSf1Vm5MNhsxUau+glf4fnUA=;
        b=cAWbfrN2OP18CvTCp3f922pJjbFHnoWsNcx/QY9ROFc6IVlGRZqXYTSVgSR/fbOkQ3
         xQIftvuunA0/IxxzFjTKG3fg5NOCIVX8cDRTqQQ3rXlwG1fW04b9GXVE3K4lNGn24Sna
         eiPCfV9KYoLWnqPO1IKAWxRHaxkZ4aWJoGnDeI+3rrEkiU+MzSdZcGFA6JyS4g2sU4gI
         0j7T+foMRnbUek19a6BTUhpYGYTafo2A/jxSvbg4rNjG9GX2RoWYqnP0L8CWbjDAEPgo
         5PPY8hQu4FHbG5c4v6uSqJzDwv4lEwwVNEWFGFJTdIDhr4rtZChL6Iz1y+jbc326NyHm
         +d/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcy+ZT7tAwkSqFyKVIjD8FJ/3Is6sX9TCI6ArIJD85rbEEWKDgr+px5LubprpDiSXr70Ztky/yXYUo60A3bE97yWMptmzAdsPZoNhC
X-Gm-Message-State: AOJu0YyDLbCn9MQP5g6i6SHtKzx9WzyrhFx9WobmI50twxylEZ+Mhs3X
	16oGRbUGq9dI/Tv6v2EAY407j5ePnv5eqck9ELS2Y7YDXsedX/yvz0opdC4cYEKg9IoMJh3gM2a
	2b2ptQQBjoN/7cUe8+VwODy+guapaYDv6r2hQssM5pxrL3dvxOhO+1o/XmwjILMfcU9cvmP0EVg
	CpPZw0ZTMIKj2InhN62izqCXe+fOrh/b/ceztK
X-Received: by 2002:a05:6a21:3a48:b0:1aa:9595:4261 with SMTP id zu8-20020a056a213a4800b001aa95954261mr870733pzb.22.1713399858445;
        Wed, 17 Apr 2024 17:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElOi+SwtyiWKoWx9Rs4yVtkTdu/i6pUpqiCyZiV2+/NEDFVMxkU8nklag1Drtb3Woi5q0BV46joIjy5ZPGPbE=
X-Received: by 2002:a05:6a21:3a48:b0:1aa:9595:4261 with SMTP id
 zu8-20020a056a213a4800b001aa95954261mr870713pzb.22.1713399858165; Wed, 17 Apr
 2024 17:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417071822.27831-1-liangchen.linux@gmail.com>
In-Reply-To: <20240417071822.27831-1-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 08:24:06 +0800
Message-ID: <CACGkMEuABgSn396Cfi1Pt42Q__fCsr-G3XJYZUH3CEOARZ5Opg@mail.gmail.com>
Subject: Re: [PATCH net-next v9] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:20=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
>
> 1.
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.=
com/#r
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


