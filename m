Return-Path: <linux-kernel+bounces-92516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB0872182
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E4E289150
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02551F95E;
	Tue,  5 Mar 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FPvfMNsO"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E550EC2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649189; cv=none; b=iynQUKW9F5/2SicdqJBUP9qKmtRSek6RcathZWCKeYKcMk8RkkIi1pDS8aeX1/mY+TtG4lCMX5VsBOry+KIWw6NQ3iepeBsSPvpky2tyKrvAG9iA0xU2HTE1aLtnvybpQFUgox9wqC2RdXNCTjdjMbMruQJwMbEQt4F/MHJB0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649189; c=relaxed/simple;
	bh=X3osxuXjIttKURCzFETBwIDv2CVhPf8fUO7rGAAuMv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq2wfRYP0TeSCIt7kYrSX/uSwKWbq4pIc0tw79mg61uLC0wW+5FCXmWvvbZwgvGej1yOVe7IzN1RHX4LDhRPJd9yYBS/zPh1717s1HC2LIMJsoWpeCR1w3Jdk1Z6my6OiN6m6EqdGKaUjB8svpd3FJwt87bNYVqenumYCa6EOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FPvfMNsO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso1257264966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709649186; x=1710253986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3osxuXjIttKURCzFETBwIDv2CVhPf8fUO7rGAAuMv4=;
        b=FPvfMNsOtB2Z04cVXUt4lkuOcORgCN8ZJMgo9ohvhQol0M2ql3gFNKR8Z6b5xqBPVS
         BumeQ7TYedeFieKXznOVkqYSDj1gQaV3VxQpIwA0PxfxThu12TUZyXMcKEyMqCjRF2Wy
         2BXf9GRPNUpdncJbpYrc4GuyjAGCSFk+2YP9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649186; x=1710253986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3osxuXjIttKURCzFETBwIDv2CVhPf8fUO7rGAAuMv4=;
        b=gabqnO2kICGy37r5xuwMgM9uNWjoHMWn+jQ6xqBnF4BL4F2b0CUGjEIclXdveNybZh
         dIB/RM8rY0BlotmEvQcveFv1QUbXIgURYFP4xdxu+8IpWBchcKLbqRAlDs4mszop1Okg
         Phu9QcYSn/25zQ+iTVu/E4Er3orWJOHiCXNSIEHGnQucR0J73Fn9Q3i+gNbvKOsqTgQX
         M8oo3gRXiL3HoUx6NDCj6EjcOCrTgcI4ok2WKWpTVZhBf+PuV5OiDbjPWwb2fRQmjlVg
         v+LGjviXIKnDXlYOd/x3+4Teff3dNqQvHj5xC+2PPII8GlfMKwZySW1fEjN8uBwtEXC+
         xlqg==
X-Forwarded-Encrypted: i=1; AJvYcCWQUOTc/0fy7Et7VcjdKaH8aYElwcMPcxogypMt8i8uFX3h1nx7HE6V2uzy+TmjGR6NqCHNdJ+2jUdTULcpBnq+u/fNNKjxoNi9fG32
X-Gm-Message-State: AOJu0YyhE2LOyAfmpk8F/E8wI7A8xYJnwc4GKIvz4fHw5h08qVGvB3ab
	blKu85hGWbeqZOydWDpXawec/TEriJhJQrF2zxgenJKkf/ayU+399ZzFA7+NGeQS9IiezjWgtLG
	i2L+w/8MVQIeBk4jFa1+jvYXNDhlveRZEi74MvA==
X-Google-Smtp-Source: AGHT+IE3S+29C0ctynYJjZWRQvHHk0cRS3is4y8AM+jGqB69PffROPblGdFzMf6mbswY4nMzrWZg6x+FQKY9VOtDgxM=
X-Received: by 2002:a17:907:764b:b0:a3f:f8a7:e1f7 with SMTP id
 kj11-20020a170907764b00b00a3ff8a7e1f7mr2681846ejc.5.1709649185848; Tue, 05
 Mar 2024 06:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com> <20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:32:54 +0100
Message-ID: <CAJfpegvPkLuU6n_4twNkVDfKNj9MUSAv0usrswBs2AhKnFudDg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] fuse: __kuid_val/__kgid_val helpers in fuse_fill_attr_from_inode()
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 16:22, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> For the sake of consistency, let's use these helpers to extract
> {u,g}id_t values from k{u,g}id_t ones.
>
> There are no functional changes, just to make code cleaner.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Applied, thanks.

Miklos

