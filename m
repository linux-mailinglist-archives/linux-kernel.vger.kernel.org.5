Return-Path: <linux-kernel+bounces-156949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6658B0AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10F81C242C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9B15B98B;
	Wed, 24 Apr 2024 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW6lI8te"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325C15821F;
	Wed, 24 Apr 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964899; cv=none; b=cIRYZ21OFjZaxDZyX1HAV6BqfXduP0uSUwXGErUjykEywE9nOIkRjjwWK2aDCxT9qatjqSmm8nIllxE3BCnZABl4kWzyKxhvbPk1e3ZZXzqsGhNvLjqgz7dRxE/TKH4fidJyi1PPXMMoY6hKsYSGE8vydIYwBnmf9xoNowfCLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964899; c=relaxed/simple;
	bh=PJb7aHAZTGNRgu0ckayfF/yub4XepCE5tuhF1zIWTiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaTfbFSb81IxzyC9ZwkY0fjJsHpFr9ti5iuMEpRta6uiOeMr2ov5h7Rz3wjkK/+u59n6bG1e9MBrv7wTSzUNA5ztjfkzc9Fxrbc+I4TJQwABUweb5ROc32ju8tv3LS3vm/dftV6ONLDDh1msx4iVl56NNblhnZalrU2RzHH20kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW6lI8te; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c6f785223fso273179b6e.1;
        Wed, 24 Apr 2024 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713964897; x=1714569697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wiv6Ur85tzjJM8dSRsKgLVS3vAahPk5DSGQsWuI+AAc=;
        b=fW6lI8tebGG7/w/zbI+fiOo/mU7sEuDu0HRVbx3K8x+sBcSSAKLwV1fbP2Ne7HDEjR
         QW6skUgm5IvDbvGHLVRjXCXzHgjOLR+t8YMrI5YAhbHxF/AoKJXvjmHndjGJD6ikCwYz
         H/+UDdHrQQz7Ua3SC/uioOJT3/AGYGPnTc6UBr90O59pJdW0RTexqF5RlNkqsQY9C/1v
         HNCopS8m8P2kk/qukQyHKNzgVXEmmfT8df+qo8cur0K19TcZCZTgc6d53JIpyVesjl/v
         tbXSV/aL6LX/UYOKP/vvCGLshrrrcH9yaavTUsLnJquGETd1W1+Op8Ld2wpsjF6mDf3D
         Qq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964897; x=1714569697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wiv6Ur85tzjJM8dSRsKgLVS3vAahPk5DSGQsWuI+AAc=;
        b=SXdnukk0F9XbeJAYpb50A6YvyR2P16hNm+9UGoDmZQiH/P7HJMnSD+JBC9ZCn91ZUB
         5fhbqFoEmYMPnMdl97OIoO+8/skgmrrrlJOjrHOTmOnmsS8Bs1h9rgx4fzaP6NjJFbXX
         1vaIQrVsis7VUTjxuRWGIhs1ltK5cF5nwrrgOq07txBgAl8YfbdmMzDRcO8hWzXEKTRK
         Vpnkf3mQTwf4cEVhRR+HvMDLllei1oZFIaPP/h9ENg2lok2o3V2Rc9PGV6WLxrB+0cdX
         ljAGA4n5+kfj/MLsTu/jbX1T8r/g7MgOXo6P6AgM6ZgQbYFcA2hooo6xDj2+C0NeTJtl
         elTA==
X-Forwarded-Encrypted: i=1; AJvYcCXSs6r0+DaLK6ZouBRbvNXac0pCI8/D2ThpJEui8rBcRyx7dK9W5utt17Ej2OYAJ6PHfmiBKwA/8FZ2oN33uqFq/U2dzOAhmX2CPRw=
X-Gm-Message-State: AOJu0YwgRv2Bypqp1gk3XcY581kcToganf0LPY/kI7QLUGohDowVuVfg
	HQZ8y7yyCzjumEaLhOaBaO0M0AGeNzr53Ds8Y6cOz1PmoV6rTkApZVyn6uJoY3ZVZBofvPl690l
	y2fpZNkjRX/YJ/6l2dm5bPjgO37QwCon5ohf8gAvR
X-Google-Smtp-Source: AGHT+IEGm4DC6PtDuqmtZywGCS4SdK012A7q67NCec7GTwwIxO9u+x9A90G1cJIOZJ6W3zMWnz+oTPEryI8qZy7CSDc=
X-Received: by 2002:a05:6808:201e:b0:3c5:f29a:5fda with SMTP id
 q30-20020a056808201e00b003c5f29a5fdamr2757356oiw.3.1713964897050; Wed, 24 Apr
 2024 06:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
 <874jcl7e83.wl-tiwai@suse.de> <CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
 <87v851e2di.wl-tiwai@suse.de> <CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
 <87h6glt9zc.wl-tiwai@suse.de> <CABXGCsMcazRvmiN4XtiHQCE9=dB=M=VsRqB=v+RPmtuhBL29DA@mail.gmail.com>
 <a6f4e20ea2a68f56a7d2c4d76280bca44d6bf421.camel@gmail.com> <CABXGCsPdqfXeZUw1ocx8O3NdOEb+h4yQ77+zdNpcwP_4JrYXuQ@mail.gmail.com>
In-Reply-To: <CABXGCsPdqfXeZUw1ocx8O3NdOEb+h4yQ77+zdNpcwP_4JrYXuQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 24 Apr 2024 18:21:26 +0500
Message-ID: <CABXGCsMTbmU4CP8CHUqRVXWkGiErFtEVG4COy6RSRWsAuK_-CQ@mail.gmail.com>
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592
 decrease 30% of gaming performance
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:22=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, Apr 2, 2024 at 12:29=E2=80=AFAM <mikhail.v.gavrilov@gmail.com> wr=
ote:
> >
> > On Mon, 2024-04-01 at 21:50 +0500, Mikhail Gavrilov wrote:
> > > On Mon, Apr 1, 2024 at 7:48=E2=80=AFPM Takashi Iwai <tiwai@suse.de> w=
rote:
> > > >
> > > >
> > > > Then it shouldn't be dmix/dsnoop.  You'd better try profiling
> > > > what's
> > > > going on there.  e.g. try to get perf results with and without the
> > > > commit.
> > >
> > >
> > > Here is original perf files:
> > > [1] perf-with-revert-587d67fd929a.data -
> > > https://mega.nz/file/EpZmXbgL#vEnxuODoB__jM6TwV6XbwC_TWMMqvT7qaWkJU22=
JY48
> > > [2] perf-with-revert-587d67fd929a-beb45974dd49.data -
> > > https://mega.nz/file/0lI31CDA#hKsv6vX7t5u-Sx1_p2E7-Y32-z5VFPlW2Y793oM=
-JRU
> > >
>
> Excuse me. Can you have time to look in my perf files?
>

This is a friendly reminder

--=20
Best Regards,
Mike Gavrilov.

