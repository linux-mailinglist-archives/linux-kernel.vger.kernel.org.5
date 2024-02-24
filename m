Return-Path: <linux-kernel+bounces-79475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAE88622BC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6301C21F68
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096AB17586;
	Sat, 24 Feb 2024 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbDQ0hTm"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B417588
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708752577; cv=none; b=b0/fYRv1+67FxT5cDFZvJ1VFKj85psmXR7srIBro3a/buSztEgqSekKyYDcW32WjMAmfGqwELDG2oKMx/KdE6wg78jW3/DcqGCutHeK4XLqcXs96HfnQGePJXgbwZD+ye5hXA3tnn1u3FktO40k4uYXMJR6uDGlygxJc+EwuMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708752577; c=relaxed/simple;
	bh=QkXAVadBbbhC7bhRBuY+zfwSKeZe3vRCZjDqgT/q5E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyhiBy/5mTbL0Ex5zsAlrmPEzIUk4zrwm0PjMAN+Sne+fPuNk2Cpkf9QD+jnxKnxEKHSekgd7mc6RuKPTc7FwETD/AumrHimqyUqG5VC3BR4pXuH/IHzPjC23vvxAV7uAepHQ7IFZCbn7i/e4HBDTBucATTVribj10ob4Bb8O/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbDQ0hTm; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42e0b1b11bbso91831cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708752538; x=1709357338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4n0EEX8jNZZC2pFBMoUXcztzFChc13lSIA8SSXtQGY=;
        b=gbDQ0hTmEDJJkN4Rn+l/tjzGEcrhkJEwyJFLzHTGEbnn/tjoXYn0NKKn41X+gmpVd1
         sKe9N5sSLZcA8X2ut5zIJ6EgDf0EVmiVs9m8RqwwF4+IoLF5S/2LR3s/oWCAgd+P2dNB
         pVyq90wnZbcYu+3ge7duRBffT1EL1d9kqjlBGjJPfe9aiRkDUA8SOtKYcWkZIuOEWvYj
         60dGKhJMsBj3j12FtW6Ufyf7UVJxBQlagFngR3iKxtRf/0dttEBKQHGv4uS0/rKuGoFx
         yYrEYCtR6aLU9i2iGCHrI7ZQOz2EXkMUe1cP5VWd87VJhwLjQ+Y7g0b1I3Y6fdGkKj3W
         GC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708752538; x=1709357338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4n0EEX8jNZZC2pFBMoUXcztzFChc13lSIA8SSXtQGY=;
        b=L/LUXnX46IPvcXT4ralP7cR0WN6ZeQcdFSw8PbDXb3YpdofIrMOHkS3D5nRpV5O7Jg
         aiqY1jT5v0R+BMvtxEZKoTBF1yxLT85vygfJ1Iwen4nefA61M+L2Ntz9Q4sFnUO0SY+P
         IQIrCNcG3ev1dkWPZKPzfJclG2AqaKQQh/qMwEzpZWjMXK+b8f4a+2HgJJCgRURCyRwR
         IEOlc6q2hUKV/RBBZnYcVa29vTh/BNXL+lOG4ChWHPmOv9SD84+svKtVf/O85xajC2hQ
         itfr4Qxh8YDGYUXCDVSnUBnMMaFCeA0odp0cKwcDAusqspys4tFQkKlad6n8Db7dS5rR
         NLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNtA1bX58VbotHtGU2vERFqWoRinqxrUGAUJuFghk/LozlyvEuvChSohQoCwdQoXWEVU+OTU+bDJN3D1T0NG7MI3fCzeoDhYlg0zUG
X-Gm-Message-State: AOJu0Ywc1IpT5HVBz8kN3g7I9U0Yzzhem/T+jgL9617Be48u+7mSxbl/
	9FlhgdmBFAn/Z6LHcZ+u6l8DAL4HRZLibpkFaRbq5e3+0zxjBRdYgMmSRf7nUw9KO5wJskwvKLQ
	OLVJJHmyNkLk0wrDDKb3jEfzm5ua3CJJ4Q9r5
X-Google-Smtp-Source: AGHT+IGpkNG50duu4FZuxCsRIzu/MxR/r2Jlc+Yz2igEuZwxMMi6sJnFQEo2easuFJxkbpyENtnHU5eQlCmFdM642q8=
X-Received: by 2002:ac8:524c:0:b0:42e:6b39:9df0 with SMTP id
 y12-20020ac8524c000000b0042e6b399df0mr162594qtn.1.1708752537610; Fri, 23 Feb
 2024 21:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224052436.3552333-1-saravanak@google.com>
In-Reply-To: <20240224052436.3552333-1-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 23 Feb 2024 21:28:18 -0800
Message-ID: <CAGETcx_m22xLSDz_kk9ovw5veKaij49+LdcRx0iyzEk8iEz_+A@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:24=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> finding the supplier of a remote-endpoint property") due to a last minute
> incorrect edit of "index !=3D0" into "!index". This patch fixes it to be
> "index > 0" to match the comment right next to it.

Greg, this needs to land in the stable branches once Rob picks it up
for the next 6.8-rc.

-Saravana

>
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a rem=
ote-endpoint property")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Using Link: instead of Closes: because Luca reported two separate issues.
>
> Sorry about introducing a stupid bug in an -rcX Rob.
>
> -Saravana
>
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index b71267c6667c..fa8cd33be131 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1304,7 +1304,7 @@ static struct device_node *parse_remote_endpoint(st=
ruct device_node *np,
>                                                  int index)
>  {
>         /* Return NULL for index > 0 to signify end of remote-endpoints. =
*/
> -       if (!index || strcmp(prop_name, "remote-endpoint"))
> +       if (index > 0 || strcmp(prop_name, "remote-endpoint"))
>                 return NULL;
>
>         return of_graph_get_remote_port_parent(np);
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

