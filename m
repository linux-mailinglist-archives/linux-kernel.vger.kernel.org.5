Return-Path: <linux-kernel+bounces-144729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB08A49CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CE5285C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27D737719;
	Mon, 15 Apr 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JY7WVL3i"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2E376E5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168561; cv=none; b=mjzdnf92WPCEdwg/OxokdDogFsf5JMoVvVWLDcyYRa074xWd2B2N1mvEZEe8UyNYEveSRcYnckTp2IWNll67/i0V2FIxwoMW0nPaNt7YV0F0VnDfuuoD2/cJEOBglpY7Xcxdpw+zBtsDD9MOsysa1uEolqcNlL0WUGSsW4kn3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168561; c=relaxed/simple;
	bh=YwT+akiycT7zUiBlGUGl+TAPvveigRMKj7UEv7P0iyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKjjhcdzt2FGRX2QiM58lreMVa/flRJ2R0valReh8tACDbd+KgW5FJEDnb9F1Y5UQp0MTmkelMvQRneC9Zqf8GRoljFFeC8htyv9Ewn1e5I6V9NJZtw51ByHnlt2fLetBURhBbtFAelWUKMNmI35LLqPGNbG/eo4SaSAYnBHiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JY7WVL3i; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so2749676a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713168557; x=1713773357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pHvyqQ17Tn2O1Y0m3BirRC4u7vNkpQHjAXPedl5MpWU=;
        b=JY7WVL3iVR1YLrQJA7nhoQOedXkhesVg2XEwHh8rAUu/acPKqm0qf44vf+48wWkWTX
         +O6aby62bOxOX1VjWQBgTgy0fQX2rx9AYcF3Ds854NornsqjRUFMozqBVDanOliOXjaC
         ABMew1MNiWf/XcKre597vqyus32SD6AwiwqYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168557; x=1713773357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHvyqQ17Tn2O1Y0m3BirRC4u7vNkpQHjAXPedl5MpWU=;
        b=kr6iX3v5HdPnXZlZElWMtifO6W/ddsgkfv7ENnwA9dJ3yWYIPFIznJg5zKJjZ9mujz
         U02NAUAbf7rLeimBLm5gkE6a1da4LNIYpdarJ6Y5hN0At2tkwouqhLZ6lr/Ps91Y6i/9
         aagfRmoyKpwW6HNks7KcqpODOyJ3J3mJC3Fk+j4yLGyfASA/OmMotS/7ICxQ9eX7mYvw
         h5wNSs4Pxa7Sa1ve4eG0FrogPEZMzrFoxzpRIpbi39TbDBQl1xoCTocc0e5/bvZ6g4fR
         IE+gr+Anw0Uu/fwFWQv0K3OhJrkP6ZPIkYtgoQ09P8NDsUNiIDujAEFqy5nOmNf1UTfb
         i99Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSij340TErSBKNX+V9k8j10PJZMladkwPtlJEXK0aH6iCXyQX/9MAIGQ6XaegTB+u9hFcznqtUnpu4hKDjtAXDGeAVBJh1aOvdaxqb
X-Gm-Message-State: AOJu0YxkZNTI5XH4XrJniyfQX0BMQLx4b51S0BaGa2rAf9u/6Wwgrrl7
	0OFMAuukbmZP7pIgEpONmbZ5wht9V1ZYDkDZbbn9OvKiSfjv1yFfV5IwKfj9Ouy1pnpKHOfH7yj
	7WQZFFxsJoqMdzEGJqP7m8g5fLLu9Xh8Djv/07w==
X-Google-Smtp-Source: AGHT+IGoqJvq2Ws+YedI2hZHMr9V8PWREbeZlVZIRGIcxv9MlUvw5e4bwOV6DFMx4/NAgcd9Hj0J1HO6Mylueh0Bijo=
X-Received: by 2002:a17:907:7da1:b0:a51:b0e1:8640 with SMTP id
 oz33-20020a1709077da100b00a51b0e18640mr7941615ejc.9.1713168557383; Mon, 15
 Apr 2024 01:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
 <20240412140122.2607743-3-stefanb@linux.ibm.com> <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
In-Reply-To: <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Apr 2024 10:09:05 +0200
Message-ID: <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-integrity@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 21:09, Stefan Berger <stefanb@linux.ibm.com> wrote:

> I was hoping that this would be sufficiently generic to work with
> potential future stacked filesystems as well that would need to also
> provide support for D_REAL_FILEDATA.

I also have very bad feelings from IMA digging in the internals of overlayfs.

We should strive to get rid of remaining d_real() instances, not add more.

On a related note, D_REAL_METADATA was apparently added for IMA
(commit 11b3f8ae7081 ("fs: remove the inode argument to ->d_real()
method")), but there's no current user.  What's up with this?

Thanks,
Miklos
,

