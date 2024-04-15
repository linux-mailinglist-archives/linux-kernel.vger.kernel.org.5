Return-Path: <linux-kernel+bounces-144563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95368A47CC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A647A28393F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F445DF5B;
	Mon, 15 Apr 2024 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ty0ZYcFK"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142A1F600
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161312; cv=none; b=PfMbmxd/m+YvPMy4efApeQrhRON66ORGyB3x8dG/E/PP+d/Gm6hAtnqDs+C6+bAkC38KDxpqw7pdczsEISqhnZfuTtgWx7NjUGZthEk1Tmvb+TpA+vfbGnRj9kBAAIzEjNiqFR0n760Uqe/TUHN/r73GZDQML+/qA7NUQz/uffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161312; c=relaxed/simple;
	bh=Dh0BEONubHSWkUhbrgjErptQ214kGH+jO5kDL2sMEio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PH9YiAC8x2KmcuD0fOzjbQWyMQrfvyxpqMO3wuj3FO/R3A39f2TuYPO27wAE0i9F5NitwxY0iBsySbQaS1bL0aLYnWOyeWC2W5T6IJfUhSCmHpEnLXBAkFNxVwTy+9KOp3f9X9sWQ5CdprU3LF+67penKlE0C4K39IZQ9c0X5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ty0ZYcFK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so9306a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713161308; x=1713766108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh0BEONubHSWkUhbrgjErptQ214kGH+jO5kDL2sMEio=;
        b=ty0ZYcFKVu229Bkm8lx8lPlYlAfWH7kbODam5GwXEu4auuFwz1aPJ2SKImhWqzlxba
         Pb/9OXACJjNPJU5xqvfLsR4k23qAvOwzpTYCybq1fcSdIK58lBZs21yCKk0+JvsWQGF8
         CYb6W2oJHZL0MjO1+B8zrsTV7LGeV1/3LCPVX1NOzjn9Nb6csp2sLzjdbNipwJI2SFzo
         QjiW5MCmYNGofQLqD6gba+JrWa1Xj0ObSIa6ARB62cLwLF36+dxuU+f2RpI9eXOImzro
         qYDSDbC+gyAIBTL1A4MhX/tBbo9UHgmWxsM7Qu2N3npXRKePIXUACG7wFyxJjSl/8dbC
         OOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713161308; x=1713766108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh0BEONubHSWkUhbrgjErptQ214kGH+jO5kDL2sMEio=;
        b=CIiRvr+4uLdu7Rk+0x1YLsSSkI5U+FNv3vUEj6TqT2TUm7Ok3IQUiLlHzLTYyDnfxC
         2gDw1dK7jkkMeUR5cMSH3g8iI0+6N+nHLy10jDfNlJ98J5HpaE2gUBitn31iKjemBRhJ
         yNcaGwdY48b8vp3ryuHjutQLynk9rz8x0kK3sgocNLHnUceH6CuVb6TRx/ReKZtBJ7Lw
         oqhsFeUHnV1zGOUMaFwf4lxImTWQao0vA1Z1tfJlj0oOhiNgCIVO0j9HFdB5pu5v9Msc
         MzKQaCOJtGrTAHZEQfcsfoGr8PE9t4+dYKXElnmsVySZLJqBQat13tm9Hi/FUiauLmlc
         FTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrYcysg7LBXryuWBGrhg7Yr83cnlujXh+OO7FQjel1qaDbjUkROOGC3MEQatk1RtTi70mTdxEikvuYRbjMhfXZyqPmYu+uUu1DmGfX
X-Gm-Message-State: AOJu0Yxq+JMolfkWXisBkS0giTwNSsJJqEIJ/KY53bV9weUA3vngWrnW
	0/TJp2Bx+9O+XrO1s7hTYHAvAZsD0V5YAu/sfiNC/jBo3nTTZ+R82PCwdrJgTsix5A+Ge14CG7R
	VdDxEp5Jytjzak4nj2/Ae6K47YKdcrgO4mqfL
X-Google-Smtp-Source: AGHT+IGkKQ4N0s3PGi6BIB8WtJWu2/RvtunZs1E8+AV4HgGQK/X0CNWjK8z99EceRmHAgAj1bJOUFAbAysAoWg64+Ns=
X-Received: by 2002:a05:6402:34cd:b0:570:2bbc:77c6 with SMTP id
 w13-20020a05640234cd00b005702bbc77c6mr54200edc.3.1713161307799; Sun, 14 Apr
 2024 23:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415020247.2207781-1-lei.chen@smartx.com>
In-Reply-To: <20240415020247.2207781-1-lei.chen@smartx.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Apr 2024 08:08:16 +0200
Message-ID: <CANn89i+PMxOks+ZvHendXovZ_CHFJcUyqT1GLpSk=2bwS4SjGw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] tun: limit printing rate when illegal packet
 received by tun dev
To: Lei Chen <lei.chen@smartx.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:03=E2=80=AFAM Lei Chen <lei.chen@smartx.com> wrot=
e:
>
> vhost_worker will call tun call backs to receive packets. If too many
> illegal packets arrives, tun_do_read will keep dumping packet contents.
> When console is enabled, it will costs much more cpu time to dump
> packet and soft lockup will be detected.
>
> net_ratelimit mechanism can be used to limit the dumping rate.
>
> Fixes: ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")
> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

