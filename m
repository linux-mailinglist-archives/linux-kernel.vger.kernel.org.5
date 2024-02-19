Return-Path: <linux-kernel+bounces-71202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E090E85A1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C475281ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03F2C1AF;
	Mon, 19 Feb 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RuamGSQI"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD228E09
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342034; cv=none; b=OvKGe4iSaWFWb7zXC5MhEYef+8plgj5bqJDM1NSm0l/08y50PAyQFhceUCp3CC5xh9wyZxLg4Tg+6Qu0FEV1lNSHx6f2iEaR+040tL1c/9leaxRmNV2U6acfC5g6G1nWHtFoS4lVyNwnSZwc7NdGnQpt3zDu0r3C09EqKt+v+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342034; c=relaxed/simple;
	bh=psRznd+qwD4id3H3mkwUZ3NR28Q098n95rwBPacKDxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpmiffwOb+1GivF492IhLlBNdF37T0nTns6IFtHd7h/9lxQGqiSNCvjfCZ8fBbGVrTiRSjt5KPDiilwjJnMnhLMc5qV8+nfBIoDM7fVlB5UdnVui4kFa8bQS22xgGkjG78LqbcPsCdHsHYCDIn3f23hg+8Riuz+8V04i5bq7Qpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RuamGSQI; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607d8506099so39355317b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708342032; x=1708946832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psRznd+qwD4id3H3mkwUZ3NR28Q098n95rwBPacKDxA=;
        b=RuamGSQI7GqoCVLg/q2m0RK5mjcT9ldwLOSlPBkOZmSiO6fpNRGZezZMkv1uy7WBG2
         29jRTSvJTJ2NoIhosCrDluQHbA00nI2PO4tiArv6RvWxtqG2TsxwpZKzTwoLvHBnaGTD
         7ubvmG2DvHE2M3fjbnGHs0PviFpi7in5ItKRaaM0i8bu417AqOBBjh5CpYJQSzzUm/95
         vF72EKwk+3JQacpP7nhNcd+gy1ZcxSn5zYE4ER2AwDNhEcSFy2ZTLcBC9ACdxoaSLT61
         He4rWpVpjOjj3/QDGagbFEqudRwwqRjrrG7hbGMO+8FrX8AaXA6MUJmQPGrOzcF1oWMt
         1IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342032; x=1708946832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psRznd+qwD4id3H3mkwUZ3NR28Q098n95rwBPacKDxA=;
        b=gvBHxJcabWd/QCc0S2IZx2KsQcEuutkRzMe4189hpOcS2wfmwexxYahG+Cf1k+NP93
         ts73st6+CKS00gF6gwrxDCvXCt54nLl18ZLujF5KwEKdrF2XJDe9WT1HYwQP4ANaKAdR
         fM75QV9cwhE12gWwny1S6nGePQCS4jS4nRR9gYrKPsa8mmnsvq1/NvPSU1u6Qk/OckOA
         HOVuRAUPHz+McUV3isKND6GecG2J9jcJ9uq21dJ6WnbhP5rflwG061BY8NUYHDLigaRI
         BW7Rw5EjWZNWDCG++6lPc81fq6w7quqdEqheHCKf2Sq8HK6zB3PCu8d7YkGuoOwBAkAx
         lYpg==
X-Forwarded-Encrypted: i=1; AJvYcCVYaiUptyGXjwOZkQwnGQOkp21q6RGnk7oS9Ma1cPHNHYBTkbUVSUI2Mza4FsHLBFtH6Popbs/TAQf4LImF/VENhd8ftza+9V9i/5wd
X-Gm-Message-State: AOJu0YzE5XsvQwBGl+aExPYwQ31kW/GlvUD99fDozRxFD1xqe542zcXC
	HrIenLNXP1KU2xEOujS88uWSeWypO9yLDkkg4h/Lhh/T9NIqbq1CFXoDLXMzdmMpUHVJhOAE0br
	2sOVFJ678XjjH4svqEl1Jy/nPnEWqDE2JYjg4
X-Google-Smtp-Source: AGHT+IGYQ7Ft8/k+yh/fauCEDuGdjwHYmI6RFXGJtA15ZTj7Vn8HJ0Oql8n7gZRk8bvuYJStcRQFfFcSWNN8TG2iA8c=
X-Received: by 2002:a0d:cb89:0:b0:607:c93f:2c2a with SMTP id
 n131-20020a0dcb89000000b00607c93f2c2amr11818399ywd.46.1708342032049; Mon, 19
 Feb 2024 03:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com> <20240213055426.GA22451@lst.de>
In-Reply-To: <20240213055426.GA22451@lst.de>
From: Howard Yen <howardyen@google.com>
Date: Mon, 19 Feb 2024 19:27:01 +0800
Message-ID: <CAJDAHvYbMVCitf59OvKGQk+cWrHc9Sk7_20LSyssUOEeJGvbFg@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Feb 08, 2024 at 03:28:05PM +0000, Howard Yen wrote:
> > Add support for multiple coherent rmems per device.
>
> Why?

Resend the message because the previous one contained some HTML.

I tried to upload the patch to support multiple coherent rmems per device
because in some system, the primary memory space for the device might
be limited, so that add multiple coherent rmems support per device to satis=
fy
the scenario.


--=20
Regards,

Howard

