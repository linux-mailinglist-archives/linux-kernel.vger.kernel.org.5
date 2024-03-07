Return-Path: <linux-kernel+bounces-95333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE730874C67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B05B21F28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44E85280;
	Thu,  7 Mar 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T703hviq"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57585277
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807563; cv=none; b=h0NdLYo3YcibBHTJx+604PKvJAH1sncrbY9Ew2qwS2aRqeT7V/wvIZsrwAPYrK9dJrPQSvKajtOIyhdRgWS/Q8jffRbmypBVkkQC87UNvdWSFO9CLkEcO+YKxhmYCT0Kv6RmIf5sY5oLYn78ygMIFl85QS/CHMkHRZSA88WJRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807563; c=relaxed/simple;
	bh=wxkDjhkD5a+Y6VrB7ttMH2m1F90rKXIXRLbM/C0qwh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KL6Hj+s5UTjNRn/nTfjvkP6G6OBLaPikfTY2LzLPl0fUlv+sZU/k6YxL2SIGAy15WDcxJyB8KtrQm5SkVumAPOMJvOIGIde6GzOfPOtHauAQeOkPqqyjgQeBvU/WRNroWgFfbBr/HtAR9x/Q+IdQOGyUolqi/gO2KSd8MO7qyls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T703hviq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso765884a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709807560; x=1710412360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV8VykTlfYEay4JYWZz+3S/orVQV57jVe8+6o6hgukI=;
        b=T703hviq/OcM4rFht8w3xCVSBFAEAChB0vRllbBHOzV1rYjZjOeuiR28TCJX7eD11M
         lRDJ6EspbJhGBaziaVcrLw96rPeHmy9jTN//hYMUa+T0D8GItMV/ou5tG4u6gXYiwPHK
         MyZVzLxGpbowrZGjBw6SJD2d08zsb8T/S9bCcjIuRrGHbcxEP2G6O610DZQd3z3n36V7
         W2dPvEbGtr6ROpQkgCeCWQ4ISynTrfMoocj0CqUsn/dAhdRDeaz4rFGFo3YxnPIQRtuc
         m2A771bfHGDd2uP6lGSdazWvrTk1w1SrcTO8YHWCIgoudX6A9G3nQWSrdkT2nabd5f+1
         m5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807560; x=1710412360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV8VykTlfYEay4JYWZz+3S/orVQV57jVe8+6o6hgukI=;
        b=r0tj0VaNhbBjDVdOqT2u0UZGzpOki5Wb2ncTp7liG0PYOCWiWN08t3Q4hVtiC5PI47
         dkeaqjX++fpFsPym/sU160uxxMtEuWni1NB0sE9TzDuTAL63m81BB+1yllMh4RquwOUZ
         uPrSbGkMt+sdcOZPOa9SICYM1vAsXG4F0TABJRigk5DPyIR6vsOx8NP+Vsyps3v/tImR
         kCZLY2XzA0Fk6SJCU00xVj+mqQKhNQyU+olEm/YpevbNp7NkwmodNXuMchBU4q/xjQlk
         GNktJ6kIVphleV1uZSlAFy/eRiSTIvkTNGqdQTi+T9Cz4ITtxcYEJqpQg419syX6Adgc
         ZPOw==
X-Forwarded-Encrypted: i=1; AJvYcCWWq1GKDc1HixmJ5FFXDcSaBWPl935PfQMrF3DEwJ1ey9ACv4xaFEPknGSqAV1HDd4of8XsimeeYrfQLTWlo26GDTbEbX8MhEQGpkU9
X-Gm-Message-State: AOJu0Yy2j9F0z4QwUk+RY0ESFTyOYQCcLvWrcMVOpiSkp/6BgwRHIGcD
	OxCGymknjx4+puQ+5WW9W/JZr5FCHBT7AyuJYHP8f57Y9lziKatOCP1ivsOckW8AXYAFJIXLwW2
	iUqISZH0qaoAJx9R07/Gb2nSjjKI=
X-Google-Smtp-Source: AGHT+IEKtFy41Zi9l86FeDZm6p26SRwK8CTEeZ2dXozva1J6FKXwmOCFBMdGgGHCPc3OTMp6o5ORJETxtXVL13ssLTk=
X-Received: by 2002:a17:906:1693:b0:a45:a6e1:30d3 with SMTP id
 s19-20020a170906169300b00a45a6e130d3mr5335228ejd.60.1709807560112; Thu, 07
 Mar 2024 02:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228091417.40110-1-brookxu.cn@gmail.com> <6eae3879-f9d2-4fe3-96b1-c9e2aa939264@grimberg.me>
In-Reply-To: <6eae3879-f9d2-4fe3-96b1-c9e2aa939264@grimberg.me>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Thu, 7 Mar 2024 18:32:27 +0800
Message-ID: <CADtkEeeiNDO87L9MwC392gEp7YhhGGxojRu8nW_epkTe-jxcyg@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix reconnection fail due to reserved tag allocation
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for review, seems that we should revert this patch
ed01fee283a0, ed01fee283a0 seems just a alone 'optimization'.  If no
double, I will send another patch.

Thanks

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2024=E5=B9=B43=E6=9C=887=E6=97=A5=
=E5=91=A8=E5=9B=9B 17:36=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 28/02/2024 11:14, brookxu.cn wrote:
> > From: Chunguang Xu <chunguang.xu@shopee.com>
> >
> > We found a issue on production environment while using NVMe
> > over RDMA, admin_q reconnect failed forever while remote
> > target and network is ok. After dig into it, we found it
> > may caused by a ABBA deadlock due to tag allocation. In my
> > case, the tag was hold by a keep alive request waiting
> > inside admin_q, as we quiesced admin_q while reset ctrl,
> > so the request maked as idle and will not process before
> > reset success. As fabric_q shares tagset with admin_q,
> > while reconnect remote target, we need a tag for connect
> > command, but the only one reserved tag was held by keep
> > alive command which waiting inside admin_q. As a result,
> > we failed to reconnect admin_q forever.
> >
> > In order to workaround this issue, I think we should not
> > retry keep alive request while controller reconnecting,
> > as we have stopped keep alive while resetting controller,
> > and will start it again while init finish, so it maybe ok
> > to drop it.
>
> This is the wrong fix.
> First we should note that this is a regression caused by:
> ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
>
> Then, you need to restore reserving two tags for the admin
> tagset.

