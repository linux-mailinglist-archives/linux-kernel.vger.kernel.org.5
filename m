Return-Path: <linux-kernel+bounces-36970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB2F83A9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039A6286687
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A6063132;
	Wed, 24 Jan 2024 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HPbVp9vo"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9960EF5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099022; cv=none; b=XrEVLYjOm5VNRve4sHIGpcUMfGy3jURZViLmVpQaT/KHFJc+j3qA3/RCRzKw25Eokx5xt2lQAJLDACrfC6MVzrejs2CIKZvujBlRhc/XPVV6sK404wEAVl9ke/MQsBZBk5t9mEHsWqautd4SSeMtsQeyiR6e+nFoFL21hm6S8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099022; c=relaxed/simple;
	bh=5dyjjztVeMEAxqjCQmekyTt/14O/JPnAAQEh7nAcAVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L55eXqZxia0mE5TSoQNiUMdfqYKYauTJmsVGoFgjCCgoYodvaarnX77sD8w8VXgVe73SsULmmmUS/PJPPx2B1TKBeFYeuHMEilxQMq+G78KyyBv8gJWq9wzhGbjPsGFHsfcrzOrXwh+F1uB7vXBfTPVnCHF2rQhT+w9LWYrtCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HPbVp9vo; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc223463ee4so4801990276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706099018; x=1706703818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VQJj2Pvltg34D1JxmSzpikuY5oxwe75zkMRd1oYgk90=;
        b=HPbVp9voPLIVmz4Dh8+TSPBRDQD7ZINL4QriqM9x//SldYvLHSwUZGNDXYvpNOyG3N
         H8pwNbNdkAj/nrSHPWVl+frSYBErma/Ylv/4PsbflcVoekL2iw5SnjQIPSFDUU9XfA9v
         oi/J5eTiBb//TYHqXK4ASHWue5/Fdsyc+XnVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099018; x=1706703818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQJj2Pvltg34D1JxmSzpikuY5oxwe75zkMRd1oYgk90=;
        b=rnFkVv0PG03lgjLPVptG4wDXbUMgTgv2y/6BreUhtCSdQ4IDKH6QBSVc/GzJBvUoX4
         w8YyEpvcobn16s9b0RtT5WebOXs1bnSct2rbo/EtA/cM8pl4N66eHfnYtJ7ezyDVSplQ
         t80NTs61+7PhYWEEUWvkQBmfs2by2g309emYEM79xeoh/KRASlwietHZwJTW0J3DmanL
         HhD18QWbXUrQTbC4aCmqmgNQPa04mgode3PQc5256wEJ30vph/h7LkE4AxyxEdQRPjiE
         igmhvNbv77Fmo+mM19148NGvjYELAY5M53a772GZf+/geZEkdq4YiHDRGIF5buCFb3t1
         hUag==
X-Gm-Message-State: AOJu0Ywvn42B7+yJeL7Jf6QcN6dYfhFtpzVZJaCzP+pXIMseyR63RMcv
	viaCx8VmMGjj0bb99mUbwjvgJrtH0OtTZi1IZ9o3FTTo3fKr6jqpstLC6eyEKLuzlg9VPnESnXI
	Y5/KDib1uDvWw+WqqEL+nxG/Zj82ViaEgMhwM5w==
X-Google-Smtp-Source: AGHT+IE8szCTPfpSzvW9b+xBq8pihCslPhQeZGAadtd5+Z8bxnNbMVcT6WiZGDSQH25QtDuVHNtDzXqw2dWrBjzIcdc=
X-Received: by 2002:a5b:10a:0:b0:dc2:1ffe:92b3 with SMTP id
 10-20020a5b010a000000b00dc21ffe92b3mr501479ybx.81.1706099018730; Wed, 24 Jan
 2024 04:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Jan 2024 13:23:26 +0100
Message-ID: <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangjiachen.jaycee@bytedance.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> From: Xu Ji <laoji.jx@alibaba-inc.com>
>
> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of a
> single request is increased.

The only worry is about where this memory is getting accounted to.
This needs to be thought through, since the we are increasing the
possible memory that an unprivileged user is allowed to pin.



>
> This optimizes the write performance especially when the optimal IO size
> of the backend store at the fuse daemon side is greater than the original
> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
> 4096 PAGE_SIZE).
>
> Be noted that this only increases the upper limit of the maximum request
> size, while the real maximum request size relies on the FUSE_INIT
> negotiation with the fuse daemon.
>
> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
> Bytedance floks seems to had increased the maximum request size to 8M
> and saw a ~20% performance boost.

The 20% is against the 256 pages, I guess.  It would be interesting to
see the how the number of pages per request affects performance and
why.

Thanks,
Miklos

