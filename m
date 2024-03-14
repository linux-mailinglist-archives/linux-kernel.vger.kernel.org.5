Return-Path: <linux-kernel+bounces-102752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E65DB87B6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B84B225B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E6F53BE;
	Thu, 14 Mar 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BEIMofJj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881305382;
	Thu, 14 Mar 2024 03:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710387359; cv=none; b=AVxLuSFl/pQfZgKiSOL8f9QrBKMRKgTc/lfniPdQvVPobseOzvXzSYrP+gjSogZjlabAcPJ3Q+87pnkPpSG8mY2grInSU1PekB5xKBA4TOFWXElyV35nogQHypucwkJwMp4pYA3HgifzwUZAnYrL/EH5e2AT4eHwDD/P2QoU/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710387359; c=relaxed/simple;
	bh=ufLxwUri9oF1Ju7jFdR1vSsQE/010F+BadmW8nZ4azo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVDeJN4f7YRPwwnmoo2d8Q2nugU8ZvdJIJ5E99QtffY4UrUsIOOyz8ImpZGiX/48bcIJrAeG856norLheXxI+jVZQnOBRshYP8g+CrBBI7cAtzQlOjbaa33iiBgyNHl9A67wTwc21zkuD7kI6lEo2L3M9omiwQKpZ75eziXX6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=BEIMofJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9F0C43394;
	Thu, 14 Mar 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BEIMofJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710387356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufLxwUri9oF1Ju7jFdR1vSsQE/010F+BadmW8nZ4azo=;
	b=BEIMofJja6FJPbS0D4BCmOSOP5We16lRSkupRoio0Bsefglkxq59tI8PtUWz+mxGScPggl
	nnzfk+dXAQpAFpDjP6kKhsXLjJ6yh8bVDbmjQsL948nCNDUriGLP2qkrQuIlWR4RhJG7cM
	s+LHUDHYcOrIwl2bAAdfw6NzaMaq/lQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 01dbd829 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 03:35:56 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so404710276.0;
        Wed, 13 Mar 2024 20:35:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmd71sAgewmFy70qdRqoHbjoIe8eXAvse/15kB0t53gRbrVXZCtstkyG26+C20yYnxwhjoLMMS2nuzdr6yObrM+7AZPqE0Lh55diB2XLZngO0mtYvjscGW4ow66p9hF9aSebVQ
X-Gm-Message-State: AOJu0YxX+IdDwDuF5eDkCvsHfIwvJ21KMguZTXk7lOKl7r1CszHjsKWN
	UKBgxTXAbZzY2AyW9dAigeTdK7bmLdOWMls1XD9cz4+1pLWx1/NEskdlR1tyoz0wKRVn7JfCaL7
	uE2xV/s1OajmXR4cVB5d2e1VKRWs=
X-Google-Smtp-Source: AGHT+IGUdgKF/dbUVT5otlmUuvnWc2bC3zUXkuCsUJ2i/Uqok9paRwhbAvJI8AHnKgDRCdykiRdMzw+jO45j6wnIV6c=
X-Received: by 2002:a25:bfd1:0:b0:dc2:5553:ca12 with SMTP id
 q17-20020a25bfd1000000b00dc25553ca12mr555095ybm.14.1710387355458; Wed, 13 Mar
 2024 20:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308112746.2290505-1-leitao@debian.org> <ZfJtzhKJV4yo3LRF@zx2c4.com>
 <CAHmME9prrtWu8jkj20WKvTZV6mjQE2Vt_mFWGOuy9St1FOrEOg@mail.gmail.com>
In-Reply-To: <CAHmME9prrtWu8jkj20WKvTZV6mjQE2Vt_mFWGOuy9St1FOrEOg@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 13 Mar 2024 21:35:43 -0600
X-Gmail-Original-Message-ID: <CAHmME9oPPtJXd8DsA+xXvbdN7T0PbAM5kYpQj32KZXv9bKP1ng@mail.gmail.com>
Message-ID: <CAHmME9oPPtJXd8DsA+xXvbdN7T0PbAM5kYpQj32KZXv9bKP1ng@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] wireguard: Leverage core stats allocator
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horms@kernel.org, dsahern@kernel.org, 
	"open list:WIREGUARD SECURE NETWORK TUNNEL" <wireguard@lists.zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 9:27=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> On Wed, Mar 13, 2024 at 9:24=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.c=
om> wrote:
> >
> > I applied this series to the wireguard tree. Thanks for the patches.
>
> Actually, sorry, nevermind. 1/2 is fine, but 2/2 results in `ip -stats
> link ...` returning all zeros.

Ahh, okay, required some more commits from 6.8. Okay, seems to be
working. I'll let this cook a bit and then push it up in a while.


Jason

