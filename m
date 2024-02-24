Return-Path: <linux-kernel+bounces-79548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8518623FD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2271F22F49
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0C61B814;
	Sat, 24 Feb 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFzZTdey"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153C179AA;
	Sat, 24 Feb 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708768393; cv=none; b=YErM48GAq2XK2sYC7IMu7q1smyJE/IAoOw90jBO65dd7qyt74w59zhIK56JUnM1Fj5sNdBXrq36IGlBiJ1xb5biUywx0ifxOhHPKU+0MgaSLudY1VS4hweAuEfOa2MyqX1S0owl+DmIpUJSG5xalPZ8QC6hW+a8pL7I9Y4HPebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708768393; c=relaxed/simple;
	bh=PDHqNXMuRCqPjNS5bWxWkSAMWcKkWDnn+jOnhXHQmZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqMvUB8hXlzSGhxL5iBlffUtM8087XphO5xjDXqyMj4BB/0WNIpt7RWsXzgcR6tRo9LfGOpXmt1B+QNwjx97CCsTrQzcpiLsdxGKF/DX5bAAAiN0Kwcb/DNR4y3Oj54R5JzhlfifQRB5ud9DsEnZfCENxbcXR7ipKzQFPdWFdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFzZTdey; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e45d0c9676so819387b3a.0;
        Sat, 24 Feb 2024 01:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708768391; x=1709373191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pty+fRQQYtpnB6eAjS+4AxQbLg5aAO/xeli1234qY4A=;
        b=mFzZTdeymeZ5QED/xG/RsLeCntLkHdZ1zghSYrJrFEFzYVaV7fZyo16O+ssGRn2AAL
         n/gQibmTFcLTWRI70HaBPyae61XjkrsPKL8SrasHy2bHQFtRUTcnuYYkyIXEEaKCT2PU
         mTXXSpRtyfxe5PlozaQLVms+1tCtrBDjrJd5HCyr664/KN2mVZ4FXv8Yz+IoXmfWIaSV
         kDZ7INVIwFgH/xkYkZDruIflIspMtnYFs+lOc1dk7tMrNEVI3K7swjUXg8CChHV1Y+Pg
         4jWFNsJC6KwV+6nEkvrt2yL2JFkeM87sQWHlMrHuOtA1eb6KblZEbbdyfzzirpfKIyAY
         QHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708768391; x=1709373191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pty+fRQQYtpnB6eAjS+4AxQbLg5aAO/xeli1234qY4A=;
        b=bcnMUNxwMuUKPxYml8hoiDa/7ndtqG5PGj6ZbwpKb7sz8RgkYVxWQpFWB9PQmlcW8y
         9ELQIA1f+E78XOYLa7Aw8e79BwhOQpAhwLyMv06efaIZSHjGLNSe2o/GkD2uS/MJ4FEf
         p31fF6PbPUTiGbbEKPH/+7sKLK1CuHVXTiiodsd1ccpXAFxqLWqC3uNOPGzOY3FuHm4O
         GChOtfoT9S9MZqbMGUoY6U0l797d01s/Gorj5CwonhqCesmssTYy+C5BiIuzNMLL2gwI
         a9QYFW364zJfQNECvFcNmmxbMtW+sj/r6tYnJIQ6UCaURqtDHpZvHwCxeJ+sHI087vaY
         2k8A==
X-Forwarded-Encrypted: i=1; AJvYcCUDy+5FI9rMBenlybkn8HfYFVS5YABFvLT8M2DMkDknjMhijhhDKFwdcbG7+S92o3RaOKE6qUbP05y2cfgkQW5tpWmAKBNx96Y/2/DRL3cELflmZAvXimtipHasseK1k1yVIlK/
X-Gm-Message-State: AOJu0YzUQjxtELHKhopVeOvAgn8y92EClHrIJbfEvulFp7l9RisXfidz
	BdgMR7j70eHQteR6/l+oT/DpTLtxYHC9T1jXHwDTVgLQs7rB5LlHFgrNddK3895nGFq+2mlSvhm
	5fG9T0CfCcoVqZYKOVUqnbObsc4o=
X-Google-Smtp-Source: AGHT+IHVXYk9F0m3bDnCQOKUCRIOPOHERGPSbQZaEGYRpKDE8Vot+IL1bTRi9biZKNNN8qkFk0diUTiDUusQG3vW8kI=
X-Received: by 2002:a17:90a:f009:b0:29a:90ef:66f4 with SMTP id
 bt9-20020a17090af00900b0029a90ef66f4mr2691924pjb.17.1708768391196; Sat, 24
 Feb 2024 01:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed9e1bca-d07b-42fa-9ceb-d0eef3976168@gmx.de> <CADo9pHg2jgYqE1qxpV40E6GHL1s+G+mNm1JCcB9GgA-4XM59+w@mail.gmail.com>
 <2cc27421-8791-47bd-a3d6-83188332ad3c@gmx.de> <2024022326-wheat-heat-e4ba@gregkh>
 <CADo9pHgvjr6-=heOBuhjZqW0W2nhC1zBbaqYq9bWis9J-6SBAA@mail.gmail.com> <2024022432-fleshy-mumps-3b65@gregkh>
In-Reply-To: <2024022432-fleshy-mumps-3b65@gregkh>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Sat, 24 Feb 2024 10:52:58 +0100
Message-ID: <CADo9pHh+PxY9_0=naTCtUSbsMyo+YmrHpcEqiKX1y7M4bGnV+A@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Ronald Warsow <rwarsow@gmx.de>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alright i promise i will do that before posting next time, thanks for the h=
elp

Den l=C3=B6r 24 feb. 2024 kl 10:22 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Sat, Feb 24, 2024 at 10:01:36AM +0100, Luna Jernberg wrote:
> > How do i change to bottom instead of top posting in the gmail webinterf=
ace?
>
> Move to the bottom when responding, or use a different tool to access
> your gmail account.  There's a whole document in the kernel
> documentation directory for how to deal with email clients, I recommend
> reading that.
>
> thanks,
>
> gre gk-h

