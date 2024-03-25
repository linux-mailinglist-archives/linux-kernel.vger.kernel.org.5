Return-Path: <linux-kernel+bounces-117830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC05A88B5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AD2B2CF94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7D1C68A;
	Mon, 25 Mar 2024 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+UlkKyz"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ECD1946C;
	Mon, 25 Mar 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395560; cv=none; b=Hkn1mT8Xx9tTFYxTdt7sZjdyaNy7EDmbOFp6MNvsEJ7II0SFOYGNNU51piuDkDhrLgPnq3c1ASnp2I6dN8HOpu4DYCp7XQHNwqy9dlsh9++O9zSuO3y92m06VAe6nAoK+V8T/j66TWsqIA5AzWylCd9DNUoeCcUUThJOKkjXS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395560; c=relaxed/simple;
	bh=CsVUf50sObcUku/mroVotClxV0W8lcZ0puo+cGBDLrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQCafsbMXivNaDfNTRScS/stvuEphcTFPiMi12H22p1/+drodkwr4nF3hVh99m25MhlGlDIacxZgOiEAv0TT8BQhnClr2VLA7cOjGkY//BfTuQT5nsEjShNZcrizXRX7a5M1aP4v2ELtHKuV07ht1KNGh4IslZa13hndBY3BWqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+UlkKyz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so62765271fa.0;
        Mon, 25 Mar 2024 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711395556; x=1712000356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCiFMH0263F/w1Boz/4ACSdzIpxCPhV2O6OirjCh0B0=;
        b=j+UlkKyzdKkiScGAeDI+RgtrBEyKcHPSuRhxUFAEEjRimySNRdiJG8GYK8CyRPL3UC
         mcj8PEFeEqII3+K1uTLqqsur/s6ouCNqiODCofqJCGEV+sUGEVrWCBeTcXLGayw6Dqmm
         VmJf/NUvlv0ZH0WBIPEkPvMtElmTlbkX4xuX/hI1jMp8+YGNQHC8na61VDv2CEX+qVQX
         15rpB91WUwWWp2BigLic0WqoU+hEa48bsuL4qGHn9jDrbvi4ZutqjVQnrcXW61G3kT3k
         5qrM4QUbJIFLAcf/tIj+MyNPrqkWHXLe1Ys1RkIF8uDQ9q/5psz0r52MFpUS8ErDTd6B
         vBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395556; x=1712000356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCiFMH0263F/w1Boz/4ACSdzIpxCPhV2O6OirjCh0B0=;
        b=ou+wZa9ILVEHpNW26MYQd3xftQ6HVTviGGWU4j8X6AHL1F36H45IPIx+TjDDr0iCwn
         tnNx+XpO/T/Y/zw+94Dc/8kwro5sOKZuM0Usv8If4fls0H062UZ94UFDTVsaH0w7+Ufg
         RZVido5I6OzP4ySSS7lppbQnO5sSaHQ0XjkwPFHrPx8oNFZDWO/BXz8mOwTz8FmDFZQL
         KWAaO2EThOwddYID/ZudlL3OmAIScYGhAAOSsOy1o/KZwcqjr9Tjws696x1jo9Xiy+Rn
         /Ap4GQ5aBHCZ0LtqDb7E1gPb5jfBHv4GPwccPU3yqCid8TD351f3xiP6FeIlUC5rRDDN
         73pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNiDxMh3rCVbK6mp2H+TKHRoN3z3USH2wJxWLiE4UWNYCKHm8DOlF7Ig+mPl28b2NtwNSHEpHZ+7qmPCbTkfemMvfAQyFXGssWUjJZXB9gXh4k7f4VP4yF4mHR0lMXLL9ddo6g51IPrzVhG9PBNh4CZhfo02JnAW7ZogWRmGKN1+8VMsE4
X-Gm-Message-State: AOJu0Ywjw1tbnHGJEkOReIBKUAfDqHTmE5SH3v5kSw/PwlsSaWFFYw5I
	60w8ehNaQncD9pPbOBi+DAJU7Bfa+CCq0bsrvpspXzv4VCnRdtV/fpPru/1bPC/k2dSyQe9IH36
	c1LaO2CP0ZFyl5e2g3E8FDvQIoCQ=
X-Google-Smtp-Source: AGHT+IEO0HQYH0RAUefHQ88oKPd8VrLRPkmE6nkd2e0YQtTaamD6D0keaaFiiiGRD8g+GOmhBLFR4FTEiV/wSwncUdI=
X-Received: by 2002:a2e:8e86:0:b0:2d4:8fd0:b5f2 with SMTP id
 z6-20020a2e8e86000000b002d48fd0b5f2mr5556267ljk.7.1711395556273; Mon, 25 Mar
 2024 12:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com> <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
 <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com> <ZgGzWWV4Lh2Nal--@hovoldconsulting.com>
In-Reply-To: <ZgGzWWV4Lh2Nal--@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Mar 2024 15:39:03 -0400
Message-ID: <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
To: Johan Hovold <johan@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan

On Mon, Mar 25, 2024 at 1:24=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Mar 25, 2024 at 01:10:13PM -0400, Luiz Augusto von Dentz wrote:
> > On Mon, Mar 25, 2024 at 9:57=E2=80=AFAM Linux regression tracking (Thor=
sten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> > > On 14.03.24 16:07, Johan Hovold wrote:
> > > > On Thu, Mar 14, 2024 at 10:30:36AM -0400, Luiz Augusto von Dentz wr=
ote:
> > > >> On Thu, Mar 14, 2024 at 4:44=E2=80=AFAM Johan Hovold <johan+linaro=
@kernel.org> wrote:
> > > >
> > > >>> This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.
> > > >>>
> > > >>> Qualcomm Bluetooth controllers like WCN6855 do not have persisten=
t
> > > >>> storage for the Bluetooth address and must therefore start as
> > > >>> unconfigured to allow the user to set a valid address unless one =
has
> > > >>> been provided by the boot firmware in the devicetree.
> > > >>>
> > > >>> A recent change snuck into v6.8-rc7 and incorrectly started marki=
ng the
> > > >>> default (non-unique) address as valid. This specifically also bre=
aks the
> > > >>> Bluetooth setup for some user of the Lenovo ThinkPad X13s.
> > > >>>
> > > >>> Note that this is the second time Qualcomm breaks the driver this=
 way
> > > >>> and that this was fixed last year by commit 6945795bc81a ("Blueto=
oth:
> > > >>> fix use-bdaddr-property quirk"), which also has some further deta=
ils.
> > > >>>
> > > >>> Fixes: 7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fw=
node exists in DT")
> > > >>> Cc: stable@vger.kernel.org      # 6.8
> > > >>> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> > > >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>
> > > ...the plan forward here? This to me sounds like a case where a quick
> > > revert is the right (interim?) solution, but nevertheless nothing
> > > happened for ~10 days now afaics. Or am I missing something?
>
> > I guess the following is the latest version:
> >
> > https://patchwork.kernel.org/project/bluetooth/list/?series=3D836664
> >
> > Or are you working on a v5?
>
> This patch (revert) fixes a separate issue than the series you link to
> above, but it is also a prerequisite for that series.
>
> v4 is indeed the latest version, and it has been acked by Rob and Bjorn
> so you can take it all through the Bluetooth tree. Just remember to
> apply this patch (the revert) first.

Doesn't seem to apply cleanly:

Applying: Bluetooth: qca: fix device-address endianness
error: patch failed: drivers/bluetooth/hci_qca.c:1904
error: drivers/bluetooth/hci_qca.c: patch does not apply
Patch failed at 0004 Bluetooth: qca: fix device-address endianness

> Johan



--=20
Luiz Augusto von Dentz

