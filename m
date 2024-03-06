Return-Path: <linux-kernel+bounces-93948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E48287375D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D596B24563
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07AE130AC7;
	Wed,  6 Mar 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fbQCBMgz"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D563E48E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730484; cv=none; b=WRv5m5lPOwsTvmM0fsFrpk2Kq7iavaMVpBpz24qW5xz9z0HTSbP4wYAbhWtk9YMT0+69wa+u3o6UlvElr7PWFLtM5ni2RkbyLXiD+z1psFHzBnoajRGwrbHh6y1a+KU9fB6OStakASzX0n0CvY9gVdCF7qBtGmffpUa23gnL8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730484; c=relaxed/simple;
	bh=8grmpMo6kXaCL1FNx9R2bfmPydXiA0rq201Ykmbj6XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AibQZ9yixYXmZV8wVfFf3aeS+4VJJrHCTpCO00JbWqtolOmLB559WfISICedN3BeYbLuSvM7COjU78nL9DrRRundxhoJsezd8kWajj/ICblm0f5HbAquICUmYNwDWyDY73j2+gCMTJGX4uKqMFYIydXnkB/3G6eDy7OZ2pCTTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fbQCBMgz; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c19aaedfdaso4163740b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709730481; x=1710335281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8grmpMo6kXaCL1FNx9R2bfmPydXiA0rq201Ykmbj6XM=;
        b=fbQCBMgzk+KAhLBzDal/E+VtkZn2t0bkvgJ74igvKt0UouOqhflnAMtCtEeTa4x44A
         BXigzOKFFi1nBu9+40pZxylv8/flfrBd76v2Qe9Zxr8vcUVsyMIhdgCL6Q/AnZz2Z0Ct
         96MrRmmx/PYoWzPlZVrBQcQGCK05aRL3weJaGvsBsGwC+iGNi/GvwoEWPpLqXvroCi06
         KjV28Edvht5eTJ4JRLrgNanDd0QtuhNNnbbxAIFECAPgQeUQ9cvl9TkAZ3MhVOrQ73Zd
         yuaFgEwF4U/YFs6r2P7De4tthxG8nal3Hfe0+KEPPG3ZdOzmX39uAot1Uc57MEUKI8D1
         CUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730481; x=1710335281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8grmpMo6kXaCL1FNx9R2bfmPydXiA0rq201Ykmbj6XM=;
        b=GDO7i3kYbnXuHBPTRytAKZapjd3ZVhBe/o4ZZFskEsNjKD9F5Fv4PcqRgPPTnOCs1L
         FYuiVgS2Bi15HC869mys0mPVcknMM3BSyWV6QuYLeuSZiFvOwyFeA6+Ef8I7ZRMVuHsD
         7IBFmbiiT9WF91qg7PMpb0cY1POJPOACudpIK3vwasacyUVHCCg1TpnXypPBxKuMTfZo
         mCiahX4QLj+XbsCiiB9koOsDQ8/qXNBy0Bbfs7FxhxZZZZrL+IeOrOfH8wmzO1m3BJTy
         j5OSN6d/B0TjWByEEVwTjNMBUSaJH6pco+7F7cjWY1dYagBsX6RWLF4i4qZnj7K0OwBj
         kSZA==
X-Forwarded-Encrypted: i=1; AJvYcCV9WJ+4kF02N69hL69iXi51fWLQa7vpiUFcLyhL8V4CPQ+zOfIYyIjShGlLgfqIBiAfSh0yV1QBp/qFupgie/wJx2AC6T2iGo5GvQwm
X-Gm-Message-State: AOJu0YwPmWWfzYNpQUyxCf5o301+H2+uvEULattep48qKuQ7NvqfkOV7
	VAJUoiugTqnUqMts8R/hhxtzLJzZf7g2Tyvhvg4R3SI8Xpd6njjbEV2KjxZ3nQMTe/MesrH/XBZ
	91+XGcfLjFSMZWTw4EkvZAyFYL+yixs0lligUrw==
X-Google-Smtp-Source: AGHT+IHApjo0FyHz0+mTNfy8Jycj2LxiGFq4dH+7d3CKS9BmX1BulHze6m5Tp4NLWckeoTdAQ7+7m9r34TwCA9Uv4iY=
X-Received: by 2002:a05:6870:a99f:b0:220:88b7:5145 with SMTP id
 ep31-20020a056870a99f00b0022088b75145mr4894851oab.41.1709730481594; Wed, 06
 Mar 2024 05:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com> <26f3e99c-8f57-4779-a679-2085e469d9cd@siemens.com>
In-Reply-To: <26f3e99c-8f57-4779-a679-2085e469d9cd@siemens.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 6 Mar 2024 21:07:50 +0800
Message-ID: <CAEEQ3wnDKdhCH4yz+MY+Xks21jLnuFiyx-xxa7CFczokG2shvQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/3] Revert "riscv/efistub: Ensure
 GP-relative addressing is not used"
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ardb@kernel.org, xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, bp@alien8.de, xiao.w.wang@intel.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Wed, Mar 6, 2024 at 8:52=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
>
> On 06.03.24 09:56, Yunhui Cui wrote:
> > This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> >
>
> This comes without a reason - which is likely something around "will fix
> this properly later". But then you regress first and only fix
> afterwards. Can't that be done the other way around?

Sorry, I don't quite understand what you mean. Can you help explain it
more clearly? Do you mean "delete mno-relax instead of revert
directly?"


Thanks,
Yunhui

