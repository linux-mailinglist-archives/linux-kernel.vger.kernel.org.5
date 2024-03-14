Return-Path: <linux-kernel+bounces-103066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1763987BA97
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8072283EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3D35D478;
	Thu, 14 Mar 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DoZKLHqH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF326CDA3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409127; cv=none; b=DUfFVz4umBbao2GoaF77i9p+BkUryjUZtshMhaT+eTRCyetVnzwC1rN9S3CCMs+f/ZR4QoQyAJZB4L9yUJjL40OJ2nB+tJwXWUxWxoIY7+LvDSlrDfspPXTJIdhgt7fknjNwEt6lA63n7iwmHHJZ2Cf8PdSdeo604qxkAEdc0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409127; c=relaxed/simple;
	bh=99jdUBguX0rRbr0EjMK/qjwxyH/ALk+EX4vPa6MmEgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFYy0wR8FT/Zm1o2evY96GnESXk8XcmL4U8s0GoLI0G1wOy5wsMz2of7OjME64BY1pcm48OKUgx1lMjYh0Fgo6Gb+DkOWX2d9IXkR7VI60jtZ6fYzXQ52l0cKf/xAaERJ6U0IDixGc3q53oGNlzMjHk3MLtccJQcnPTNyW5/XAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DoZKLHqH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso905879a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710409124; x=1711013924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99jdUBguX0rRbr0EjMK/qjwxyH/ALk+EX4vPa6MmEgM=;
        b=DoZKLHqHJjKooT7J4OCNGXuI/f8GMQXmFpBykZY+/C9fTvXOxcZEKiAoTGt/S8rt04
         yxflKBrpFbGo4FKn4+nrwDh3K8LqcvIb/i5CNcJ5XH9fYGyxa6FPxk/GA2O5zJMNaEBM
         KJnoscu1Y1vxqItcha1CJPd/4AY+j1q8B+PKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710409124; x=1711013924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99jdUBguX0rRbr0EjMK/qjwxyH/ALk+EX4vPa6MmEgM=;
        b=HguYtRVNb7GT5LO9THTC1D61JkT/NWZeuqygwH8HmaghMLAd+nO5S5qb+PlrdXG80i
         8I39ztj0/Ow7WlNf7IY6j0e6QatfBsb0rc3pKKrMPGzYDLxkUD39YXopi8PFlGigz+la
         kl9eaC12D7BFFVYbjV0ceHDZFx6R2G0a+rEqxiYqkOcxFufN4BnMtflTt3KLqg1W3dOb
         e+f8AWO8+m7wpqT5T1JEvi9LPy6DnZY7tYdSi85HnrcE7aiQfHpLDZoQC4KabqmlrJgf
         GlQ0gGxjWsADxTJLbUf0z8fwt//59Iwq5ABlpCb8eBFfDdIcKoDf6qsJvcxjo6BsUyE+
         pHZw==
X-Forwarded-Encrypted: i=1; AJvYcCV2FCY4wODmoAVO4sWY8WFiOiOQQ8ualbNWyQSuwLxauSfI7EGBlZW8WhJDlxc8kESrycwkHryn08iEpUl8qqGdtCLQ2THSggvuKBTC
X-Gm-Message-State: AOJu0YyYH+0AsnMU/8s+koCUaBv560bTQSO3+Z2gT0eDfXfdO9AoqcSl
	cpJRJV+HfQsiMGT8QykK7Nt2TVX++X1qmC1/NJD/Wb98G7Yt7yiUb5y4FMWf5QF58CEYUqhCh96
	2GkIpWY1P5jjdxRklw7iEkKdsixvcRCvsX64y4w==
X-Google-Smtp-Source: AGHT+IFJydnHavfoQj7GUYh55PHRwLEm1dCHo24SSZNO/gRuXbw54y6GXsBk03f130OZZShAe0+mXoV5Dw6q3SS+Q8U=
X-Received: by 2002:a17:907:6b88:b0:a46:7183:14ff with SMTP id
 rg8-20020a1709076b8800b00a46718314ffmr827861ejc.48.1710409124273; Thu, 14 Mar
 2024 02:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000043c5e70613882ad1@google.com> <CAOQ4uxjtkRns4_EiradMnRUd6xAkqevTiYZZ61oVh7yDzBn_-g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjtkRns4_EiradMnRUd6xAkqevTiYZZ61oVh7yDzBn_-g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Mar 2024 10:38:33 +0100
Message-ID: <CAJfpegu8Rjj1cHkB6JD=TY1CWuVaH8YpSRLQe0cOfG9aQXj6Vw@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_copy_up_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 21:55, Amir Goldstein <amir73il@gmail.com> wrote:

> The WARN_ON that I put in ovl_verify_area() may be too harsh.
> I think they can happen if lower file is changed (i_size) while file is being
> copied up after reading i_size into the copy length and this could be
> the case with this syzbot reproducer that keeps mounting overlayfs
> instances over same path.
>
> Should probably demote those WARN_ON to just returning EIO?

Sounds good.

Thanks,
Miklos

