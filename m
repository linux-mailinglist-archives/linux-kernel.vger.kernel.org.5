Return-Path: <linux-kernel+bounces-90107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE286FA73
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735A41F214F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE39134BE;
	Mon,  4 Mar 2024 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUkCyXPE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6512E51;
	Mon,  4 Mar 2024 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535937; cv=none; b=goi+J/8bePZijXwh+UDr/R1wneeXkFfpXJRercp71cvPWeNNBbePRX6KiS5eVJ/ktReFZZwFW+FB6Tpw6MARnx8ageaEF8djTzYBBpXisDAAffKi05IL7Gz6L9s2cl9qs7qIwIl7lD4xTJokL4DHmEzTdjQOlgFTU3XuGSJwYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535937; c=relaxed/simple;
	bh=uZOiLiUhyXTDISekQ6gI95VgtmBCaMN1Y1rXTmgseG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LOBEovpHtIy8cIb9dOypZWUvc5EPryEe48JwoqzlaEPOswWfuzj1ogcaUS7qAdZGaMUx3h37wQTT1QvzYQbhWfH68PgKri+OsCGLtbgQWcnrUZdfQ0YXEssHyfTOlLq1T3UpDxnKBjM3OWLmABfNAk0TAi1pNK/bFywzFgz58ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUkCyXPE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5133d26632fso1622291e87.2;
        Sun, 03 Mar 2024 23:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709535934; x=1710140734; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZOiLiUhyXTDISekQ6gI95VgtmBCaMN1Y1rXTmgseG4=;
        b=HUkCyXPEJbfG6CsQpajp2FUbvhzhySdJLEMWiLOV1wSWwNlyhRK1A2ChBjM8vcXDIZ
         8ivxjN2/KU8ITkcQnnWK4PdH65PZoU2l9WGnY8Dp9tMH1x5Rkfh/Afun5yR5ndOggNcl
         KKCGANgh1Bw05IwcgfPFsM5fS59Gblnwo9y6KmtCU4234dyvbCL4kG+mCQrJPuX+Gole
         Vj7prvBdcxTiuJhSzqTNkX6Zyo5J2ke8X8U51se6zGJJ4NmdtqrfmrpZcRxyj6ktg940
         fn9S6v8txttlpESX/BMJzNmmh1dsr0zW8x9UfLkiXncgvdPZ8o+Qhmot4V0YKK4ep95F
         Ki+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535934; x=1710140734;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZOiLiUhyXTDISekQ6gI95VgtmBCaMN1Y1rXTmgseG4=;
        b=SL3Nye3gKCHrimipx9DmhZx07f4XMiEMeSVg+2XLi1TkZrTa3fDnoyOFmQGv3Ilczc
         MArZ3peSdrN0gqrzqky6bBwa31puxIX0brQwcyKwc2CvBj66nY3w8rI2UuK4jxE5wEtA
         eeywIVnno6rGeqlwQUyxxgieuOVlc0bYObFKn/ou4dgc/mF6zfKu8HahWwmRfDrcyRof
         iP3EhNyOiP+a0L2gauGgBEfpzyDrzFRDDKPfFimm4IV4brIQLsvFc6Se0KZoiASfEgVo
         ndrakvVIDWWEwP45vzeEcUFiUnFhpJ+EEDhlwdSRsNuWMNcZxXWQzPV4jmuqb6EycFt0
         VrYg==
X-Forwarded-Encrypted: i=1; AJvYcCVi+4SpLdUsRf0JHTrOWxgJWyKQkipT5agrL3eoBRV0eCEbGqLOm19FvgbcSUZlJUZkmYg2118FyLpuDvuNSkRixU9/UHsz4fP6SkCWHN9GpiROiDnxEjJY8kT0dPM5IERzHw8k
X-Gm-Message-State: AOJu0Yy+4vD163WTrR5XcFoI92csf1lN4WB7qNk9MEfznh0kfM3+j+zP
	bVVVwun/7SFTIDisYJ1qnNo6PYm1QD3k+8jT2tEmy8RQBJcBbWPjKEsNpMB+o+SIzZ+YCzqBNvj
	CCB1mdJB1SU8plJH2ppnDnjHS0DwvP96Psrxf9Q==
X-Google-Smtp-Source: AGHT+IH79lNVlQtBywZnbndMdatWNWGcIwIqtPti+7K6lgsxAVSinJGVCpRhVVAlmFtK5IdgZSGwYEMVeAmNAETvla4=
X-Received: by 2002:a05:6512:2fb:b0:513:3ab2:5d2a with SMTP id
 m27-20020a05651202fb00b005133ab25d2amr3222186lfq.55.1709535933753; Sun, 03
 Mar 2024 23:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000>
In-Reply-To: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 4 Mar 2024 15:04:57 +0800
Message-ID: <CAL+tcoDAmA4q+FxJchgA1LQ2fxhD8oRdjDOmVPeJ1-eSnkSt5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/nlmon: Cancel setting the fields of
 statistics to zero.
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 7:43=E2=80=AFPM fuyuanli <fuyuanli@didiglobal.com> w=
rote:
>
> Since fields of rtnl_link_stats64 have been set to zero in the previous
> dev_get_stats function, there is no need to set them again in the
> ndo_get_stats64 function.
>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> Link: https://lore.kernel.org/netdev/20240302105224.GA7223@didi-ThinkCent=
re-M920t-N000/

Suggested-by: Jason Xing <kerneljasonxing@gmail.com>
See https://lore.kernel.org/all/CAL+tcoA=3DFVBJi2eJgAELhWG_f+N-kwmrHc+XRfKX=
hYk2RJcPKg@mail.gmail.com/

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

