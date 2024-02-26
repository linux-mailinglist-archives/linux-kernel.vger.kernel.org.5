Return-Path: <linux-kernel+bounces-81243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E5A86727E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366841F2F33B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D561EA7C;
	Mon, 26 Feb 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NhlSJoG7"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC961D529
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945283; cv=none; b=JrYu7+mvUlJ3ZSZhJKm6DGxKOq1ZiU8HiKkFJVMaN7bs6vqsJYq2TAGrnWYC4RlPR2f4fX4FFCwBax7pa9FZKMltQyxTDEH+SULw1r4FWPJ48Vwcl6ho0LF2K+X3aEx96rqiNRzlLiTeD2pdByjP5P/LlUHs6809uk0lmO7x7rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945283; c=relaxed/simple;
	bh=juxQVp3I/YjyYARAtGCN8X/19oTMac3vT+el0k1zlu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFcKyIRKkdotiAKO6cMQnIEoFST2SCqg4PaLn1MqyWEUm8PgyZkYZ9S12297Xpt3eYPQVohwxGAl8KYk+uOJxg2QLvZ78ORPx7RGLydt8scylYkdRIN431S5diD7QTK4Sg46pGK2AsOEBSsZFc1CpXMvDG63bWMvftIrrGQsJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NhlSJoG7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso4539512a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708945279; x=1709550079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=atstUUlrLgN4yEFx8AxqTmKurc2j6JQEEGnl6tIdudM=;
        b=NhlSJoG79kZxTNqwc29mqmpmHIVQaBp0yymv5D1K5QuPa97iwGhGNQKc6EYLrjfdpN
         fuY6l/wPPN3D3F/RkPJiSBH4imVd0ISBdWiVQaj8Npnbk0DbCh+G1NdnIEsLRbpqgrCy
         QKDyps1GHACRJhdol3f+kG11M37okkuQDbVJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945279; x=1709550079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atstUUlrLgN4yEFx8AxqTmKurc2j6JQEEGnl6tIdudM=;
        b=FE5IchMo/QzBgeW00pyOk7q43tawj94BpWHFEm9pA2wxuGKn0oqDQQgKzXlPpHCHhy
         3O4IkxKkmGK8LZ7a500U2RTpweEsX1D/hDE78gmzv2aZll6cuLCoi8J4xS3yXTmjRWRf
         7gwkcUFersHM2fsHuutbfccgv9T2Tr40v5yUeefmKK65ieupk1QqHM8dBFFub+WOhkM6
         IxQIN+96YTX1asl/gjyKLNW1rse80D1n+8tba0C0XL4MMkS4NmOTXbb/1YAK/AIkUMEo
         gCAlIFBBFji33FAiSgfct8iCFgssOaK7F6qiPGF3AMXOivUvvJ2ew7GAgbEUWhWx7voW
         7uPA==
X-Forwarded-Encrypted: i=1; AJvYcCUmKlrAWLJhHJkvzt/21k+nQY/KULUW6FayM1nXHsCkWV+3f0TA663jc0Iwe1ITVyZ4e1yFK9ySd3XaDvS9sJApwa8jYIZk+ScdgTFI
X-Gm-Message-State: AOJu0Yx9nLSTFpA8KTlSXdpYOcFbEqnQcN5s5xw2a2YCpd5NQIMdYIAk
	7kmt3jmAE+oVldW5w0iAU8V+dz0KPbPnKqipOO2ECIpkeY9KGZoU9umdG+52un6lNvGW5qq+fto
	1yd8FShmz00xXBwhaM8CdcqvMo/p1RI6BUTnnMg==
X-Google-Smtp-Source: AGHT+IHMsjBbafkh6QL3dPH4Ad4HwgAUJtI9jWeU/cH6WDQzC7JP1FUcGOG9KpmIzU1vGmBATdAMeS6QuLd3vOjO3R4=
X-Received: by 2002:a17:906:5297:b0:a3f:14f5:2f87 with SMTP id
 c23-20020a170906529700b00a3f14f52f87mr4558182ejm.42.1708945278859; Mon, 26
 Feb 2024 03:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com> <20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Feb 2024 12:01:07 +0100
Message-ID: <CAJfpegsttFdeZnahAFQS=jG_uaw6XMHFfw7WKgAhujLaNszcsw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 16:21, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> fuse_dev_alloc() is called from the process context and it makes
> sense to properly account allocated memory to the kmemcg as these
> allocations are for long living objects.

Are the rules about when to use __GFP_ACCOUNT and when not documented somewhere?

I notice that most filesystem objects are allocated with
__GFP_ACCOUNT, but struct super_block isn't.  Is there a reason for
that?

Thanks,
Miklos

