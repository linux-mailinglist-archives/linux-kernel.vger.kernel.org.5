Return-Path: <linux-kernel+bounces-120318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B188D5A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436C61F2B84D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688244C9D;
	Wed, 27 Mar 2024 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkBSrJ7W"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8236F;
	Wed, 27 Mar 2024 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515339; cv=none; b=I0gRMblErIfgM/T/RzZwdgQd5iAAlVPRomDv2bhq83hcB6cfKoPe83z5X1+PZ8u5+bHp0/kfCUgKdB/EYUzmG4vGBuy6jEkkkqwsolMJrt5mA0G/VOvc9ec2dDqmTZ7TGwNl2iGrIORdqWfXuffkkNAvjjBD3vFcMljsW0AyWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515339; c=relaxed/simple;
	bh=yBZpyQ+fc0eGRgkXfXNg/GTHnCao/0iH6YbeTY/B1Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuX283S4CdV/hLSEgyBIqZ2VWZKfaZ69UfF3ViW76+dBAvO+bNzO4m5meomaE/3h/mma3jw/MFbTIc3RHvd91LIJFjm8Hnvnxlf6Ui6lH+3libTP3ZBgcRCSQPUumqHNaEaH+AN5gjl0uhkRB7/FEIjMzPYp/QoE2AfoUqxtSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkBSrJ7W; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-229661f57cbso3480176fac.1;
        Tue, 26 Mar 2024 21:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711515337; x=1712120137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBZpyQ+fc0eGRgkXfXNg/GTHnCao/0iH6YbeTY/B1Ek=;
        b=UkBSrJ7Wktq3vEYvWlAeQMSUWoTt+CAD19c5u7Su8uHM4KLMAp3+RdInwyQL201ZVH
         insjM5NEB4IIxcfjMyv/DwmG4LvBX80leoaZOEWAPRQptc4QRsbkHiNXsDliPjsvrbIw
         Q5Q5o7pyxNUa/MWUUDadHwCz+ePH5RtEJo8WC6AGDAK7VvYbVV30BUpRnKxjxd4GwqvC
         B71BXYZnzDTrswbP6t9mZMuJ9vVZyTaOP8eBMZiufniiFJ181KPcYqMUjNJxYeo7EWUJ
         LO5xcxKch8K6YJj1Rg2socvzSnEsID5CbcmYmdONIphZUlxBtajWo5cA5bwKmF+mXOUV
         0vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515337; x=1712120137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBZpyQ+fc0eGRgkXfXNg/GTHnCao/0iH6YbeTY/B1Ek=;
        b=APhhEH41St0P9KNHE/8QKlTWFli1fIjTwdmvKrgvyLnvxAREO4ZQFAjDO1RVllhi3M
         bNBLWu8F9a2gwYMT+OOSbrM76sXK5iEdqhIrxCElAgwLC+OMOdcqOwbjIk5McIHQYu3W
         Jb0cwX4b5noKtMiAUQetZSLVSz7QE3kxj8U/DuXZsU9RYGjSLrsTDdZToeXw9pk1sNIu
         tTTZ7ofG72I2kg9J5jTvJH3yE0VqAMdos+Z+0cH2MT3UDD9s+px2ccMCLoHMVgv3jGWm
         QG88gXcSGqR7Pmg19qUcEkn6ATaYGc2rT86ZhXwPis6c7UWgMSRRz9VVinPmlpmzwJFX
         ZAjg==
X-Forwarded-Encrypted: i=1; AJvYcCWGvdHHI2Ys3KdHJ4cfmtA78607oOTkB6T9W52lo5cGooDurOL65uNo7bHytIAHhU1CO87Pfeh4mjnRVc54caeOSb2qSVQvAe0OhCbR81pVLFgwjT8siV9nMR2rhbr8TsoeNgohVX6VB8fONfWd2b80NpyuhJdBQ2HdgATDyOMiUTK5Jw==
X-Gm-Message-State: AOJu0YxZynqY+C1yc09fRf0S3+rM0UAitdFHLCpDnnLiO+PZ8Gs2UEHk
	RJAdAHSa/6UMGoQuUzMpYaAm7miN0UGf6N7Xc5mBDFlzeyOPVGNZe7ENmlkYvvhfa1DY4p67vo+
	PpmB2+AgKpNTgRgLlcFNIx7noZYs=
X-Google-Smtp-Source: AGHT+IHFmYuscTg0JtDVwp5F2/xqY4ek3IZ26YQmvlSX9PWX1lJyVnzRMlhOfs7mOfnX59SQv3FCEejFn0DuST/56Qw=
X-Received: by 2002:a05:6870:f10d:b0:221:96f6:bb67 with SMTP id
 k13-20020a056870f10d00b0022196f6bb67mr121593oac.31.1711515337491; Tue, 26 Mar
 2024 21:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326121735.11994-1-animeshagarwal28@gmail.com> <20240326-rerun-flap-6d827f654453@spud>
In-Reply-To: <20240326-rerun-flap-6d827f654453@spud>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Wed, 27 Mar 2024 10:25:26 +0530
Message-ID: <CAE3Oz83_7v6Zc+wEFfxWutiHW=JUc5vrodDeXA+Yc4M+Vz2t8g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: ahci-da850: Convert to dtschema
To: Conor Dooley <conor@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:44=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
> Could you make this an items list with a pair of text descriptions
> please? The original text binding's text for each can be reused.
>
Sure I'll do it.

Thanks and regards
Animesh

