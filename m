Return-Path: <linux-kernel+bounces-122181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DB088F328
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47101C297F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F4D1553A2;
	Wed, 27 Mar 2024 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e6gWVNif"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A01534E8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581986; cv=none; b=Eiw2qNqt7VB0CeDo7hNgShzzIXaUk2SkhUteGT/ZXL1FKvpD6koGTrG4ussY+tchlvRLiRO1Che6uzMq46PcrcYEHBq9/W94EQ7ouCmYi9aTjBlSnlitHVLeIP+tv/OiLWzzkPpNA9Zjq7caXLjL6kO9q1es1VRUwJZ41ebK14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581986; c=relaxed/simple;
	bh=XCedJ/z+0eYVKuY7LLq2h+bes/UwclHDPkMTAjBTiz4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=cH5WGUD0ftrgW1Tx4tHMGZ6Wo5Qa75VpscM7RZSxZcDn/6ou8a25GATwPlpHWT7WCSkfbqHdJtslt89ovvDj6i+SJozQ4LVX724QDEenxWHX1A13gTzOwGp3BC4G4XYMtkXsQjQ/FWJaSXt/nZFtj4R0WoqMtRd5KyJPGSTc1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e6gWVNif; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430dbcfc2afso1815471cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711581984; x=1712186784; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/7kvPSf30iegoZEUmfV82z2Cj7ovOLleX6jfS1tw40=;
        b=e6gWVNif/SLbiuGX5pSQH0B6wg48g5Dry8Hg2J4LArniOzRSc8AwgMFf/eURf7JOkr
         pc1a/z2Cw/EZGfqYX/LYnowwBA3/PNDsQiAFqVB5s9QzTrn81Rlzb7J/V9usub3ctZn+
         QVZL12mjaxWAvxP6srq9lqggdMoIsJNZcrFbqzURyjb1CM61JsRjnTR7ZO5DN+ElFyk3
         lNMih8RJBsKJreORdOrtdtw5KflpuB2nJf9ixK52A7jwjXXkTft88dis32QS4eO665GW
         E21/yMHtdh39Emf7PgRIpia+dh1r4y6T2lCUG601pYEgoXnbMNg5vwe3KoQifhDH/R4x
         yLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581984; x=1712186784;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/7kvPSf30iegoZEUmfV82z2Cj7ovOLleX6jfS1tw40=;
        b=vSDhRiP5s42Jsp8UrjDtLi8lR1qVuCbzUBLIaQkxAqUPgeVdMaAwtbUDjZyT89L6tl
         60ZGx2whxoygZO0eCnejto0CFqGjZtVs65iscG71tmfNbU/W/i4TFk7lOID8ziu9DEx1
         dEuCyfoutseFBC6Q2mIN4WGBCU3m32rC1wJfnTFd1p0fn3T/JfjzYjr0JEvgdSAer4qR
         l0y/Qpk+5IQsjg6MSeTyvNvx/O8Ss1NZ74b62Vp5oLcuzj5yNu076tJzZcOgBGhTHOc4
         0Umm2kAQNIPKpFAxGwpPDe39EbSxfIjLIqKmCqsXlgPk8sfpzO/QhHDc+9aDfGa1j7CT
         Ssww==
X-Forwarded-Encrypted: i=1; AJvYcCWd3mIE5m48/l3E93Qv7cJQmftCcAXImoU7ECe55vjU9q/bn8KOJMMHiJuMw6SnIeV7BSlDCRBoQbC4vRgUlbAN+q/mFRTasPRMGvLd
X-Gm-Message-State: AOJu0Ywcmjqx/id/AzHE0ola/Hs58a0s+EfTMnGzpuBHYfQ3iJpwb5sa
	nvunWF2UWPIwW1EAmODaEYA72p95RXbtH3v/Li7BLXnaWd35waK+YP8TEQCE9g==
X-Google-Smtp-Source: AGHT+IEwlTj1WqrZ41T34KAxgdRDBj3tUCvoDCaVloFVjQk6hyGN0Hlh6bKjDbAdneSHeWU22cO4Rg==
X-Received: by 2002:a05:622a:104d:b0:431:234d:95bf with SMTP id f13-20020a05622a104d00b00431234d95bfmr1477248qte.20.1711581983797;
        Wed, 27 Mar 2024 16:26:23 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id fz10-20020a05622a5a8a00b0042eef160b4dsm75356qtb.76.2024.03.27.16.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 16:26:23 -0700 (PDT)
Date: Wed, 27 Mar 2024 19:26:23 -0400
Message-ID: <91da9949a6036e8d4f0fa82b7b1367d5@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selinux: dump statistics for more hash tables
References: <20240315181414.649045-2-cgzones@googlemail.com>
In-Reply-To: <20240315181414.649045-2-cgzones@googlemail.com>

On Mar 15, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Dump in the SELinux debug configuration the statistics for the
> conditional rules avtab, the role transition, and class and common
> permission hash tables.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>    print key in hash_eval() for class and common tables
> ---
>  security/selinux/ss/conditional.c |  3 +++
>  security/selinux/ss/policydb.c    | 23 ++++++++++++++++-------
>  2 files changed, 19 insertions(+), 7 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com

