Return-Path: <linux-kernel+bounces-47655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361958450CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45771F21A46
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47840384;
	Thu,  1 Feb 2024 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3rPQN3Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2ED1A290
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765879; cv=none; b=HuO0+9QCzhaeYWOzFJag4Tjj7rSXO+iBGULR+N0/nT93CxasgLaDa/WR/jeeiWV9jOhLJTwp8DRErRRjlt2RksarrXXCRsUAvQHY7UHkRxe6jF+gOGBOUJhXDSfBvsCvP5mlsAa/fDOULA3SYUQRj5in/QAj42HuD0tqA8q1A4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765879; c=relaxed/simple;
	bh=FbYPWBWSx4JTQEcSOXlxcmIuQLcFq8DTiKoSLKe1dkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJ0DugFvXSj/niVSj+pcM+L+p69u9990FwB5lAp/ganwJklgCMO//P6k+dkqGDLLImcJjhUpBwqR8N7y5XnhkovwlGyhikFAFBe28/xT9OGOWeG+IyDR6okjZks54XNeoEALYnqkIwL4m5JNZomGSkezw/rph1hGvUlFEn4aQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3rPQN3Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706765876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbYPWBWSx4JTQEcSOXlxcmIuQLcFq8DTiKoSLKe1dkw=;
	b=J3rPQN3Q3kxUoHn63DHiKD7gKFgtKyoMuiUNxcgOc1WMQYetofi9hm8aFCmnFq1ADIkEZB
	iCYWg5xvxrq7ZQ2s1ks/U6WQr+5UCOuDWkgYAESOtcYC2XgMv4jBuQjAUFPvoLJKg/q0OP
	7m4VANIro0a+LZRiePsf8D0Cxt+4tRU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-1cmB_qgwNP2HQEvFsjN0oQ-1; Thu, 01 Feb 2024 00:37:54 -0500
X-MC-Unique: 1cmB_qgwNP2HQEvFsjN0oQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-292bc8b6b7cso501966a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706765874; x=1707370674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbYPWBWSx4JTQEcSOXlxcmIuQLcFq8DTiKoSLKe1dkw=;
        b=xQooyExaro2mFbs7X7Dd7WTAYEyxHZPYmra+AMYhZUJgGcwdyEh1tnO1gclywfvTTb
         nFGqTXDSy07uwcp23o5XccimkT8NSvfUefdbZmA4WOPDFTJLXLr6In4gXJuwF7NW5pyK
         SbO0KwLQ8TDNz7/LMkr1c6k2XiorOVZdWtUQCk312FnEqj91YrKdbSbdigkSNZVRmRwE
         cYrs9YcltMhVPK7mWceBgqaHusONu15Qd/iRIP7RUaQdQk/4cex5d+8nRZP7Gii7ISrp
         rdT5RcqioMRm9wYQdzWvn9QsvxfwGvbVswZRjHxUELf8GAfMZ6371d+hbtGdoi56QQ7i
         8pLg==
X-Gm-Message-State: AOJu0YwcmlGOgSP1cFSIhT8nEZy3Zpr8Feqy40H9J0ZpGZuZiWUEK9Kh
	BzetR9p4orZ+ML6x48vyb74fJ7RGeGxAAh3CsDxuQToQh7dwvyM8e7kNi3YtnzHWsCGd6qVsY1E
	0j47ISMJdFlxFIiTr8QzHe+sjUasfqxiLpIQfbpVJb+z9p8virKTzcUMZecfAx4elPgRFX9mGJh
	DlGkTj/8j/ZflJpzBI4ju4G5YAmNpnLdmGi9i9
X-Received: by 2002:a17:90a:1189:b0:295:cca3:73d4 with SMTP id e9-20020a17090a118900b00295cca373d4mr3873879pja.4.1706765873817;
        Wed, 31 Jan 2024 21:37:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhjcbJELHa6M870aBPEiK+ULPeq/Cay0m3VpUBudp/caBPr4O0l9QR82oXMQV39Dl/Tgu2DgMKZZqxBtd7b1M=
X-Received: by 2002:a17:90a:1189:b0:295:cca3:73d4 with SMTP id
 e9-20020a17090a118900b00295cca373d4mr3873869pja.4.1706765873535; Wed, 31 Jan
 2024 21:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131035535.22258-1-liangchen.linux@gmail.com>
In-Reply-To: <20240131035535.22258-1-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Feb 2024 13:37:42 +0800
Message-ID: <CACGkMEuaGiH4H3pvjTK5rUh0DmL9ZMsLRaVQ3+5GOfnrj8OxPA@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:55=E2=80=AFAM Liang Chen <liangchen.linux@gmail.=
com> wrote:
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
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


