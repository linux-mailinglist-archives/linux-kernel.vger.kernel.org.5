Return-Path: <linux-kernel+bounces-157613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EFF8B1392
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689B328B5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760078C6D;
	Wed, 24 Apr 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6XF4RBW"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CB7580C;
	Wed, 24 Apr 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987117; cv=none; b=t4Yzp4RTKMSvD94r48kAiQKm63qCsHayG1SwLsX4/DVcPkK7Tp2rgLsu/ztptm14c7U8OXg6n6/7qduV3xEpwnPfz+RVXdp94m2jRsvk37T9cdm0KmmYjg1KmzbA/lW10kEahlKltdGqY516xNJLwZNEURPxlhfrYhNjboTFm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987117; c=relaxed/simple;
	bh=mQ/+d3gWAOcD9KnX2wfP3u+ftFZAlpcW1F7JU92hcsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUOG5mzQWvAMAM7MAYHVc+YCm5r8UXoJ+Sd5IcD1oQgLS8I0vaqgcfEMCJVgM2qEyQiQZNSz2HJKUeUDB/fawl4bX0pdJ9pn4P1xHmn+BKlGbi1D6e4q/1uWd5aRoLNQKDgDfI/u++dJ6M1gRPz6wL4th1kA3PkwYG2wJaI79U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6XF4RBW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518b9527c60so223846e87.0;
        Wed, 24 Apr 2024 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713987114; x=1714591914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ0TpkzmYZr6hTX7MZ3GhreDMH2peuAcdL3k38EcDhs=;
        b=m6XF4RBWTs7iiwyd43H4qp5IrUv/S6g4+y0S500fZwxTCHoItfeifE6u8rqU9GpvVm
         AnGTsrPirENBeZbbH9HQvB6WrQNO4139ZmWKPkrrZ3IARxZb6aTiqORGQAjbL9V8K2L7
         jKI3vO4jFxWC74BypOOCxiM1t+ZYGzi0HrdTOL7MZW5UmSrY6a8Kf8kMliBQuFM5RfmV
         KKA2hgind7wDHrgDBzM/6EbdhSqgJzXOF85Wwp93eU/qt4u6pqRvLUpmJ+ztr9Y9xiYK
         2pgTxok5NbNKPHf+lrkIM3Bdz6iRN9YIFRRd/g6F38TIFG+VI7LHUDpB2xmML0IkEZQF
         Cp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987114; x=1714591914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ0TpkzmYZr6hTX7MZ3GhreDMH2peuAcdL3k38EcDhs=;
        b=oY3R4nproGZjJm+fuUpHPHLIFJBNwg9/uvpwSKAbp+87nSBGf9w2fDdnO/nZpZFt9p
         qwQacs4/El661scUNVQrA9l+QdFH1XZymPsvTj9CUOQoVXbEB7HHU1ZD6PT7HrwFhfW6
         YKjnNX8npJqSW5wya8NqwyGeZVccU7lWINcndqqx9NpKseV0S9yDFvu2mH1QlbixxKqc
         QER+6cvTJZ3rBNdFereqnn1MnVFsnOKx6VyYPjmfOeSQsWDZjz/w0exCvnWv7dsIEQWG
         cadCVQN4mDQCg80o8fQ2MoazMfF17wskLvNMSHhd8xmqOs4zmh/3sfIp/TdAch2y6qV6
         POMA==
X-Forwarded-Encrypted: i=1; AJvYcCXCd1OkpA+IPv5vf2WQHTr7V8PJDrP4mlpssmFXMAT+cdBh1kYCJkIs8K7g+mkqvbPgUQwfE75IiOs/F/xQJUvXEIVv97YstfU7LC3TzYq1K5/hPJUk1zExU4pVTi7Q+9vWmOa0pcfKmT8=
X-Gm-Message-State: AOJu0YzvwTfHluxfAHS2lPZjAzjhD4ZUI/CngqZsnAukKunM7Z2CNaEq
	2DxOXur9G+7jnSQYfn0bG+GMrSux5BxiOwidk7y7bY7hfT2EWq13qKGQmNAfwxcJ2p+ufvr0hro
	0d/dHOAktdwpeV2gfUGGKnKbhE1o8jXPB
X-Google-Smtp-Source: AGHT+IHIaGYAxKkGvJ35yj7ZqMlmMinua0HY7IEEpin7dNCuHY4Mh1cMERg/mBPHCSACXd8sTXQWUXRgQWVjYKKxamo=
X-Received: by 2002:a05:6512:39ca:b0:51c:9d2:f440 with SMTP id
 k10-20020a05651239ca00b0051c09d2f440mr2034502lfu.38.1713987113376; Wed, 24
 Apr 2024 12:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424181245.41141-1-tony.luck@intel.com> <20240424181546.42446-1-tony.luck@intel.com>
In-Reply-To: <20240424181546.42446-1-tony.luck@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Apr 2024 22:31:17 +0300
Message-ID: <CAHp75Ve_vX=J9wKd5iEP4m7foGpjCQGWepMaSfwhewbPJA=1XA@mail.gmail.com>
Subject: Re: [PATCH v4 67/71] media: atomisp: Switch to new Intel CPU model defines
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 9:15=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> New CPU #defines encode vendor and family as well as model.

Got less LoCs, so good change,
Reviewed-by: Andy Shevchenko <andy@kernel.org>
See also one nit-pick below.

..

>  /* Both CHT and MOFD come with ISP2401 */

> +#define IS_ISP2401 __IS_SOCS(INTEL_ATOM_AIRMONT, \
> +                            INTEL_ATOM_AIRMONT_MID)

I would make it one line.

--=20
With Best Regards,
Andy Shevchenko

