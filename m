Return-Path: <linux-kernel+bounces-72343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C82A85B23D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97DD1F24296
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260B56B8E;
	Tue, 20 Feb 2024 05:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9oGn/Tm"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51F4437C;
	Tue, 20 Feb 2024 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708406758; cv=none; b=ssm3svpb5/jrRqGF2cybpOy4nojjpHpCzXFeNbGZWaRghQvRS+PAjuWnETvq5Z7V98HI+OhVFA/CMsvCnQFt4X7sm4li6J5TdtP3fx3/JxzsJpQ6cERoAhNU3w2YrERC2H9iM+aNmw9LYDmpWV+ssIC1TtfTSGQc6jT9WoUPkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708406758; c=relaxed/simple;
	bh=SpC6PE4ZdyyyyG2sD5SuIMdpP1EGBICmyv6bE7fjHHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqVGXCC29O9SWLLcSe1BmRB/QK1C7wcNHP6bBYCEdVFdOsbc9LdiWUyuWJVEz1v6dYp55TqjYweuJuGTB62otYDFyGL2RO/hVffMMPrxDuZmka1qK+SGb5+nIaUtpayiV3Co8a+7Ffk+0OUm+t29513g82K2oWAVbXOfp1cMSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9oGn/Tm; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d2e21181c1so2908486241.3;
        Mon, 19 Feb 2024 21:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708406756; x=1709011556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpC6PE4ZdyyyyG2sD5SuIMdpP1EGBICmyv6bE7fjHHY=;
        b=a9oGn/Tmf2z4W8B+L/XoPLpGAh6XDO4wiETkVU72OY2SIi08dhrehbZzNvBVw+HOkd
         5ZA/M9I48pDIUiH+GzU8p0gMsYCRP3S9oLKOjwOb5dFBfAGyRbBp0QPdLdnaIgkIaK6G
         8nW0E9XBBvbUZ75pcrLGT93B4cMZaasqDh5DbWAE1AeHhRWW07Fm7co0XMb75MSyyDhh
         K/gNr+Mi0TPl5W5SJUCzMq3NirelZrmkhuWogVoj0jDxmlTFBPLOx00Ji7aEq2MMQxD7
         AIyR+B2EMFTI7F7JaiIwYM2z67RgjMtj/UtbBp5TMk10IVzLNLGaGDkde7fctDWdSgGv
         M3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708406756; x=1709011556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpC6PE4ZdyyyyG2sD5SuIMdpP1EGBICmyv6bE7fjHHY=;
        b=k2/O8MMLdI2hZTZWksA+2oV93Xc/B5s+3Roa0mckOYl1sn4iMJHo37NpAGqIDqzSG/
         /U2teNeJRO0UVACjVXzt5x4dyDeOk8izhSEGc7g6er15FcqFofJ+HictPufhf4OIEbq1
         oI3e/d+zycmrfjRhI7+ZstMA+L9q+TNadnOxu59jf15a8dOLgz3RBW2Dik1C/UEkKNd1
         X7c/NtKhsMIGBRoL8azHdTj3yLkkqAz4zW29KDm4TbAxZbr5HVy1YqNrcDR5ibU+YuBj
         78aHZ7kttej9hjtMX+t7Fxhzy7GKD/O0vGtU1evn2JTZqJxCTzySXK9RaagnFbZFocfG
         Of5g==
X-Forwarded-Encrypted: i=1; AJvYcCXUcNP/Zr4Pq9nexftS6yGA/z+pw2otKBBrzQVBj5P6/BajHFL0C99gSkWwpzfggmuE8AwzoN4fvZoA+SFt4giGbF6pWOgXgcPFDVYdV7vEzSlnZYI26sFSbGmn99mHsEDSKsyKfBWXtig3
X-Gm-Message-State: AOJu0YwA4p42s+7ltDAgpaqSnry8JXvL0uZE+0y5PbLmf5PBe5rJGetK
	ZfidC0YhIUpBcOS936+FAjWaBqPj6EetYezcoMo+hFP7TThIc6EEWb/gZRHqAaNJDdMVAVN3/4l
	lSf/+4jY0YxEEN5zUvvx/bz/Kgc8=
X-Google-Smtp-Source: AGHT+IHcj5k5EYbcoeqHn2on4FdIBQ/Wm4BBJ9PcfW1aap5cPQAfiZFsoDFpz55mzwidkFR0GKopwMLAmxAo4X+AdsM=
X-Received: by 2002:a1f:ca06:0:b0:4c0:6478:4b7 with SMTP id
 a6-20020a1fca06000000b004c0647804b7mr11018882vkg.16.1708406755760; Mon, 19
 Feb 2024 21:25:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220025545.194886-1-21cnbao@gmail.com> <20240220025545.194886-2-21cnbao@gmail.com>
 <ZdQm7n6Jc3tqsg1F@gondor.apana.org.au> <CAGsJ_4yP1Z4xAy5DEiaPB14YsOSYuYa80C-UY6SC2_eT7vhK9g@mail.gmail.com>
 <ZdQ0Bfw82Uzsv7cK@gondor.apana.org.au>
In-Reply-To: <ZdQ0Bfw82Uzsv7cK@gondor.apana.org.au>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 18:25:44 +1300
Message-ID: <CAGsJ_4xgAT-02ejSxPe+B2+3m8XVzSL2o--=O-gCFx54KMdPqQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] crypto: introduce crypto_acomp_get_alg_flags to
 expose algorithm flags
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-crypto@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Chris Li <chriscli@google.com>, Chris Li <chrisl@kernel.org>, 
	Dan Streetman <ddstreet@ieee.org>, LKML <linux-kernel@vger.kernel.org>, 
	Seth Jennings <sjenning@redhat.com>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Barry Song <v-songbaohua@oppo.com>, Yang Shen <shenyang39@huawei.com>, 
	Zhou Wang <wangzhou1@hisilicon.com>, Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:09=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Tue, Feb 20, 2024 at 06:05:16PM +1300, Barry Song wrote:
> >
> > So it could be something like:
> > if data is short, acomp driver works by polling; if data is
> > long, acomp driver works by sleeping and waiting.
>
> This sort of logic is specific to each piece of hardware and
> should go into the driver.
>
> There is no reason why an async driver cannot return synchronously.
> The API fully supports this mode of operation.

Nice to know! Thanks for clarification.

>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks
Barry

