Return-Path: <linux-kernel+bounces-44359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE60B8420D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD0E1F29885
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7805960B89;
	Tue, 30 Jan 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfne4MM+"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212E605B1;
	Tue, 30 Jan 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609499; cv=none; b=j0cnNUd3noPqF0geQ8edyaCMFWRVuDY/bkJ4qCZoZc+/gY6GCrCa43u6/4yiW1CeBQCS3+dQjgi7JT16BKkyAqHZycj4o4MZ+NdB9u+8jgnUE5CdNQaUnHGI4uccFnnYwZZFVoyNhqXDLKQoJvdAAQSykmgyyeTeDSUYMORtviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609499; c=relaxed/simple;
	bh=lmOeyMwWYgVH9cF8GPIvshL3MIJRZ/YHOwbCDZdOR50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQ7enoLGZIaBozYThipx8GP604w5cEU7iq9JmU259HeJvSoWUEOvQwRWW5YtMWhiKFB9tWHGz9rIs6IfK4iNScYAIZ7ww3ax4mvmtgAPDzDxtwc5Plz74dZlMHxTFKZsoSgCpCHtGCYP7T54JCRSOfasrfHOhZ9NRfzPiifoM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfne4MM+; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed0710c74so3896562276.1;
        Tue, 30 Jan 2024 02:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706609497; x=1707214297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmOeyMwWYgVH9cF8GPIvshL3MIJRZ/YHOwbCDZdOR50=;
        b=cfne4MM+gEwiBpnK+Oyx5nisbmWmrfMRXUTm4stwzNrOy3+xmEXllUFRcpaw9FIyAZ
         1nvx4Tgs3/gZlbI+UOLmWtX6e33q+mW/gPlfgNcq230CuPeZHdN+Pic6dCQ2jmZ0nVdY
         kSID51gRQC5j58FNnBE8R1j2OGjMjDMElwhTByRL2wZIVX9gnPs1S1Vh+XoPnFCr5rtw
         Mw6Ki97WZMMtQlqiKxafUDtwsZ/ZOfQh81RlUaoFD5yRDwglQ7NbdxgmdaGtaN0uvbS7
         il5XgDIW2l5+jMQJmAUNO31BNQRSWa4TRr99L+CC4DPIDzDwFiWlcQwq/+SQ0JCioBLm
         zs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706609497; x=1707214297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmOeyMwWYgVH9cF8GPIvshL3MIJRZ/YHOwbCDZdOR50=;
        b=Q+T7wMG/4QOEPVmNXAA28lv0ir5+7JMyB9txeOE71dsrYgAdgZQu6wzEV3hAk0xms4
         NZ+UT3V0XsVFyVpupWjTaHXZfJQT8wvhXwWseTOsNCpJCsC8TlXvtaa3Tr69nPOOl8BC
         mdEhgFGfQCHeAu5FiiRq2Kk47LN+jQ/koPf7feJv18sAEy1IrJfwNpag2hKmneTa7yui
         qPuJ2qKgHKTYwlFkrt+pISLQH9JHdssY56VlO5E4OlMHbv5fi24CkP/S1AIQOjbPxR51
         uyPjFA7fjX1FRmWkbhgTClKQl3tBOIRxBM50yGv0amdApAOeMoIe7Igfbv8GMFAwTjli
         HlAA==
X-Gm-Message-State: AOJu0Yzb0PDdMd7bHm5jICH5Lg9004MuerRA7Jgbr0LAOW6BhpamKgVb
	Tg72mj8ZjKuM7HUU8j0Hp4GN31OxqNSLjiSGCpDTzUV9Ctw6oiW7A3FLQyv+ldkbIcGmV+s53Tk
	9x64/r5PxTrEHP1Abs3DflwQVnX0=
X-Google-Smtp-Source: AGHT+IFRK4YrafkFlOPeBC9SYD6/OCZjylW/dLDByDsvbyNSUSM6fgkeRBu+0v3hZktbmcW8jzax9bO7QB1UvHQI25I=
X-Received: by 2002:a25:9b44:0:b0:dc6:9c4f:9e7f with SMTP id
 u4-20020a259b44000000b00dc69c4f9e7fmr1139552ybo.18.1706609497124; Tue, 30 Jan
 2024 02:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127140747.905552-1-hayatake396@gmail.com>
 <154f979e-a335-461b-b72e-5e9c54fe940c@linux.intel.com> <CADFiAcJShbgBLXdVgs1vK1jqDFopkRcw-se4b4h0V3Yd60xLVw@mail.gmail.com>
 <92958c7b-7e5f-4e25-819f-4e52f9ffcf7b@linux.intel.com>
In-Reply-To: <92958c7b-7e5f-4e25-819f-4e52f9ffcf7b@linux.intel.com>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Tue, 30 Jan 2024 19:11:26 +0900
Message-ID: <CADFiAc+0G2ncXKDQ+p8aZ98HtfsqNBHoSZVTYhgXUHu+=dof+A@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next RESENT v3] ethtool: ice:
 Support for RSS settings to GTP from ethtool
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, vladimir.oltean@nxp.com, 
	linux-kernel@vger.kernel.org, laforge@gnumonks.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcin-san
Thank you for your comment:)

> The way I understand it now, this patch (and the ethtool one) adds hashin=
g on
> TEID field in GTP* headers. So I wanted to ask why do we have a case (gtp=
c(4|6))
> that doesn't include TEID? Do we hash on other fields in this header?

I understand your question to be asking why it is necessary to have
the option to select gtpc(4|6) for RSS when it doesn't include the
TEID.

When hashing in cases where TEID is not included, it can be done with
the IMSI (telephone number) or the SeqNum of the GTPC in this header.
Essentially, it depends on the implementation, but there is a reason
for differentiation as the context is different between cases where
GTPC includes TEID and those where it does not.

Thanks,
Takeru

2024=E5=B9=B41=E6=9C=8830=E6=97=A5(=E7=81=AB) 18:59 Marcin Szycik <marcin.s=
zycik@linux.intel.com>:
>
>
>
> On 30.01.2024 07:39, takeru hayasaka wrote:
> > Hi Marcin-san
> > Thanks for your review!
> >
> >> Do I understand correctly that all gtpu* include TEID? Maybe write it =
here.
> > Yes, that's correct.
> >
> >> It would be nice to see a link to the patch that added GTP and 'e' fla=
g support
> > to ethtool itself ("ethtool: add support for rx-flow-hash gtp").
> > I will send you the link.
> > The one I sent earlier was outdated, so I've updated it to match this p=
atch.
> > https://lore.kernel.org/netdev/20240130053742.946517-1-hayatake396@gmai=
l.com/
> >
> >> gtpc(4|6) doesn't include TEID, so what is its purpose?
> > In GTPC communication, there is no TEID in the CSR (Create Session Requ=
est).
> > Therefore, there are cases of GTPC that do not include TEID.
>
> The way I understand it now, this patch (and the ethtool one) adds hashin=
g on
> TEID field in GTP* headers. So I wanted to ask why do we have a case (gtp=
c(4|6))
> that doesn't include TEID? Do we hash on other fields in this header?
>
> >
> >> s/TEID(4byte)/TEID (4bytes)/
> >> Also, I think two newlines should remain here.
> > I will correct the TEID notation in the next patch!
>
> Thanks,
> Marcin
>
> ---8<---

