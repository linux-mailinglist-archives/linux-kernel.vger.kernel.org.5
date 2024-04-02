Return-Path: <linux-kernel+bounces-128685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA5895E26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354C61F22583
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38AB15E20E;
	Tue,  2 Apr 2024 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD/r6cqs"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC015E1FF;
	Tue,  2 Apr 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091351; cv=none; b=QuJATyKN0ptoCSbUjGHJU1SBcG3zf8LpDmY5hKShpRk99sUjQYbzWpyJALt5Zgr+ze8Q0/tIJeRXHwNVqXIvPY8GEYN1vBN6/PX5zAz6d1PH3YsR8RLab7GCoxDAvjoBKTMCuyXr3t8YFyRubz9xDEoMUAY6vLoCGdLabrA7Xnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091351; c=relaxed/simple;
	bh=7ObDvNjkkkCUWg4QCMGkVodcfexYwJXHcVpDdMBE3sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=py8pGfTfeLwbRgJra06EdxL9dZcVelrkeUU1pXWU1ieM2t+p5lypDdmhMpVKzxnq1+k7KIDeYBaytdUBUJPwixQgG0QMvdyHFEej8ybe3ZA45oGMeBLgVk6NDOJI7QZhvxw0DVgR4PH/1sNcLaI21CjF2VBA4wmTiVlXe6n/dRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD/r6cqs; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515a68d45faso6399992e87.3;
        Tue, 02 Apr 2024 13:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712091348; x=1712696148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA/naT4hpiqj8NJalm6Mzoq648QnqC+NHjrjlPJzIoY=;
        b=MD/r6cqsMMTtj96vwxPkSTc1GcRX9+ltvvtA0Tq+g3VxiCUDsNsLv4+Bap3UWS3JGT
         87jBvudIVgtyWm9/QaqdZtjFU5nyZNeQ3x7HFGfl66MWLjOmJU6o1/VJvNOFMDnzYjSV
         1IkZP3lbOZE9gr0O1dnPyEhZv4ju5Ayk/uGCpSBAdUpWvkkyXJB76iaYcnPe0eFC+A7M
         65cMPOdG+ExgRc7OHC2ZdXcVib18fcAnbfHh2lkuXFKWPSDt22Fb6/ICtqd19OauW7Qz
         OwUlwR6IiEdp2FE9Z2pKSK0miTFpawXZVD4isArURGkOefB7b/JRZgeb07Q2X9FTxv+n
         KSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712091348; x=1712696148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TA/naT4hpiqj8NJalm6Mzoq648QnqC+NHjrjlPJzIoY=;
        b=pCAPH3I4L5tZ3VUBWeifLj3a5sO0W0S3iFNsL/44d2pT4r2fqkIGv6/F46c0SWyIkC
         P7Y2p8ivWjDDaUQzPTlg+Ntio38AYW9F2PHi0wsbHapGQyvtifsi5N7xX738K+X1W5yH
         Cc43kBjorhsLIT5XzEOfQksVXJTpmd59P+AF090Y/AOpHiQV7j8Z3EgHlRHEVtk4xxFg
         g1g7v7d77CHvTKr0/q2fsbLHTCkashrJaw/ylVNNb4V7RCawoQ4EhaCxIeHHnt5XhKqH
         hzLIxUAJsQrD29mccEY3XZiDUHz7R8WgDXgAbSdlW/jrjaqkwI21NsefZZmcJnf9JdST
         dxEw==
X-Forwarded-Encrypted: i=1; AJvYcCVAquzxxijGqJVMbGmlPozTlbJCYmj726eW+Bs7xADurz/lK9UmHHP58djEU+JCSzOjnvRFRH1KwSyJ1tTUmDq84zeucYbPA7suD8ML
X-Gm-Message-State: AOJu0YybakBT2OkYSlfxzexh7rRuVJaJeo9u3dTJcgwnqSVOTnUpY5W6
	elc/ss0kuiUxYjqRFjv3H9566SXM/GaxFqXtg7gJT48/OCH0/y3CDNlt98THvglWAYrVdzy+l5F
	sKhfccIfa06XUlPKouCQJ+iv74ZnINqo0WMU=
X-Google-Smtp-Source: AGHT+IHePyy0Iwz6NRd2VpYIPHCPEprWOmgr9YX6IUoP5FMSSjlPKybWCJnM4OYdE6DTOekg+ozdK85HD02KaI8At/c=
X-Received: by 2002:a05:6512:15d:b0:515:8d1c:bf09 with SMTP id
 m29-20020a056512015d00b005158d1cbf09mr8839032lfo.16.1712091347303; Tue, 02
 Apr 2024 13:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402180026.2469459-1-snovitoll@gmail.com>
In-Reply-To: <20240402180026.2469459-1-snovitoll@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 3 Apr 2024 05:55:30 +0900
Message-ID: <CAKFNMonDO_diEo+_JXKgHMTmOPv5T30TALb-ZvsOprcwSJCtFQ@mail.gmail.com>
Subject: Re: [PATCH] fs/nilfs2: prevent int overflow in btree binary search
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:00=E2=80=AFAM Sabyrzhan Tasbolatov wrote:
>
> Should prevent int overflow if low + high > INT_MAX in big btree with
> nchildren in nilfs_btree_node_lookup() binary search.
>
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  fs/nilfs2/btree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> index 65659fa03..39ee4fe11 100644
> --- a/fs/nilfs2/btree.c
> +++ b/fs/nilfs2/btree.c
> @@ -300,7 +300,7 @@ static int nilfs_btree_node_lookup(const struct nilfs=
_btree_node *node,
>         index =3D 0;
>         s =3D 0;
>         while (low <=3D high) {
> -               index =3D (low + high) / 2;
> +               index =3D low + (high - low) / 2;
>                 nkey =3D nilfs_btree_node_get_key(node, index);
>                 if (nkey =3D=3D key) {
>                         s =3D 0;
> --
> 2.34.1
>

Hi Sabyrzhan,

Thank you for your interesting patch.

In this function, the value of the variable "high" is initialized with
"nilfs_btree_node_get_nchildren() - 1", and "low" is initialized with
0.

nilfs_btree_node_get_nchildren() returns a value read from a 16-bit
wide field, so it will never exceed U16_MAX.

These index calculations narrow the range between "low" and "high", so
as long as INT_MAX is 32-bit or more, it seems that the calculation of
this intermediate value will not overflow.

So while it's a good overflow avoidance technique, it doesn't seem to
happen in practice.

Am I missing something?

Regards,
Ryusuke Konishi

