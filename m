Return-Path: <linux-kernel+bounces-90641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ABE8702A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1DA1C2395D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D473D98E;
	Mon,  4 Mar 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPWl5M1Z"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94323D55E;
	Mon,  4 Mar 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558764; cv=none; b=Z+MR5MqLxsM1wH+g+LsS1BJf6UGLbW9GtLCW3pdmuE7ENfPmJlwwmoBbYky8qYfW5tprOWJw+m4I+MjN1dquKp8/iVBUrFLocC2bWEQeNSigQ35FYbkht06iFUwIopptMRs5mIEMa//KB9NnlCfnDROc7xq4eGhaZ6QsqcV36nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558764; c=relaxed/simple;
	bh=1v0A7i2+W2cHjoJY6glR5gGnX34Ee+tCNN+/JkQeFN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6Yuae0OJnrIKFtSCgP4dKd6b0W9MmgxwzvZhXz6Gq5NmqftF1UzmS7tUnSZywrqb5OI1/NyJg6I1crdKpJ4hmTQvXFyQLmQh6b03mA75qrtG3MZ1d8pCuy9EkgVUkkdrxZCPA+wWoZh7n8Ud9eYrHY+RwAgQ1wihkydTzEgTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPWl5M1Z; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so5258581e87.0;
        Mon, 04 Mar 2024 05:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709558761; x=1710163561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v0A7i2+W2cHjoJY6glR5gGnX34Ee+tCNN+/JkQeFN0=;
        b=cPWl5M1ZfMTtxaeV2ik5WCXTygplocnUUXPaiRcvEouokzc8YwDgd7Pdso79gFQ6zJ
         ke2SX3aivo+M9i1zmN/ffPROXG+LtdzJVxg1xpuOHz449CXp+XI4r86VUs2llDhUjQ/M
         ZSD5H6F1etd5is3wjAfbuV195RsbvqsPITRYxlFSYa4WDKinT462EDlQlGXaJZ56I074
         tgncWVY6aKtaRD64xpDitUSrfNiNGQFmHVeyDqETD43soeWCBfaiXIbC8rhLGP/Mp1f6
         1Ap8Sfu6F/a4+wWvef118DAj9SWJ5KwF+45PtZ83WYMWqVEmwVOsHQi2UVLofU3y14qi
         eZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709558761; x=1710163561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1v0A7i2+W2cHjoJY6glR5gGnX34Ee+tCNN+/JkQeFN0=;
        b=QkkwELC0FTJPMOh67EzGvwWg3N6D6vHJeEgMCD2hCgM0cNriZHHqIjucbNmr1ecwTD
         +L/Bry2VtKyUde93Z51Acpj8wb2bGHEImQaojNdve+ertDxMzYtp162cAfN2utFemPeJ
         wAlSkThJilCJmqNux3VRQCre7X8jtcxLooAJ8L2eY1qV5YpenHjyUCbq+UxRBwjkZKTf
         fHY0u86OkPFjAEZZMlJtxcqOMoNLghkMNnbqVT7wpR32rWTGFLScArYUt4MDtHtEFr7R
         JVJBRr6geckRz4Trg5Deqy0zBjCJiY8z88G3mi3Y4YAjTlItg2apS0Fpn6Ua9MYct8Nb
         CK8g==
X-Forwarded-Encrypted: i=1; AJvYcCXpuQOuGVtb3AY8Rn9ZBYj1rblm6s+aR0VnagNDUi5mAzcHruvrdUF1SbF+CvHWp2LGUdk3/VPAfYhswf3iW8fZ7FSIahKxFqLc5kSMeJi3R+Macybg5NGTJpUb0HfP5lCqYq+p
X-Gm-Message-State: AOJu0YwwOz9eRhJ5wC/n80alisdvnRv/H0C3q238L2+Tv3QPLUD5jkUL
	7mfNu+xRn1txf5YRmhCMRRZZ8Ld0DGXFZV26NntefhHtNb21dinPm1HxGhZJs9eYWlDOOBC3llG
	+JFRnmSZ+pf7yC+tblSnCKvRwq24=
X-Google-Smtp-Source: AGHT+IEsmvkbJaxwXF4IPadvIrH7L1gO8TbxPmvdmvojZtEL/J/pOP3xZiRN6cokIPtD4T0zUUAYJBti9BwB4vS7Iss=
X-Received: by 2002:ac2:48a2:0:b0:512:f1a5:709 with SMTP id
 u2-20020ac248a2000000b00512f1a50709mr5560291lfg.41.1709558760578; Mon, 04 Mar
 2024 05:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000>
 <CAL+tcoDAmA4q+FxJchgA1LQ2fxhD8oRdjDOmVPeJ1-eSnkSt5Q@mail.gmail.com> <CABbqxmcJ+bybv0e-Rby9Q1jVR59Na_XE9MBee+f_zu0HUTmvqA@mail.gmail.com>
In-Reply-To: <CABbqxmcJ+bybv0e-Rby9Q1jVR59Na_XE9MBee+f_zu0HUTmvqA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 4 Mar 2024 21:25:23 +0800
Message-ID: <CAL+tcoDkTPLFksXWReGXNjujOQbgtiTKN0_-MW1f7Yhj8+CzgA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/nlmon: Cancel setting the fields of
 statistics to zero.
To: yuanli fu <fuyuanli0722@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 7:14=E2=80=AFPM yuanli fu <fuyuanli0722@gmail.com> w=
rote:
>
> Jason Xing <kerneljasonxing@gmail.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=884=
=E6=97=A5=E5=91=A8=E4=B8=80 15:05=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sun, Mar 3, 2024 at 7:43=E2=80=AFPM fuyuanli <fuyuanli@didiglobal.co=
m> wrote:
> > >
> > > Since fields of rtnl_link_stats64 have been set to zero in the previo=
us
> > > dev_get_stats function, there is no need to set them again in the
> > > ndo_get_stats64 function.
> > >
> > > Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> > > Link: https://lore.kernel.org/netdev/20240302105224.GA7223@didi-Think=
Centre-M920t-N000/
> >
> > Suggested-by: Jason Xing <kerneljasonxing@gmail.com>
> > See https://lore.kernel.org/all/CAL+tcoA=3DFVBJi2eJgAELhWG_f+N-kwmrHc+X=
RfKXhYk2RJcPKg@mail.gmail.com/
> OK, I will submit a v3 patch which updating commit message, thanks.

I don't think you need to send a new version of the patch unless
someone points out other changes that should be made.

Thanks,
Jason

> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >

