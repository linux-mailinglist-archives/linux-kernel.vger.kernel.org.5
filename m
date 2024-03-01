Return-Path: <linux-kernel+bounces-89101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4AC86EA71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7671C25447
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064593D547;
	Fri,  1 Mar 2024 20:41:40 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31763CF7C;
	Fri,  1 Mar 2024 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325699; cv=none; b=Bp+ZDhiioaS49xChyaC+yLh5xnOCDzI83KAvYXbuXVvPKnp/0fsOatQgMeg3BAattCJkMpvq+6kiKaRt9TwqEZV2N+x1cboWRtqCGQcNuBBn+VHsMj3BWM2A2s6PWB//YAFCS3jyQJBSNyMg7wD5ICyfVixDThlgtnF4+krkDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325699; c=relaxed/simple;
	bh=cfUFUNDFLKj6pTLAvi8PLB+KfVR9xMknj8C7OD/5rtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPBGT5UU8VhkRQecvX/U6Z2sqhtlNGYFICVb5RTpLAaGxv7XpZd39OR810//9uoLT2STP3Dhsw1lujsCSJvVSgugi9cmX7qEfAQ/PkZGmnY/Gnrqh0vJcwXp1BcPPSWFYGsWyTvKAVtPFtCoZ21RuQYI2MM0NC3JRx9uZPeZARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a10f19d4a0so36417eaf.0;
        Fri, 01 Mar 2024 12:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325697; x=1709930497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfUFUNDFLKj6pTLAvi8PLB+KfVR9xMknj8C7OD/5rtY=;
        b=CXZj5e3BL5IjMDd16BYuwgzOquGkc5j3/hEYXMjU8UVCqdN2BgSnI5jAKOxjGn0aXd
         bbHYH9tNUQakmLxfvlZDMnYA7nHXIYiDiYHpNEZQaz6xJ37yQetTUBjhmmabfZcFNT/R
         0q7693yxPvGiip0Ctayufr+h8Ar/GQEgQN9gb0N1qadJqZEDXAdR45QPW8I4R18FxNNm
         blQKrGZZCXahxHTuMYgHK7we1ZfkAyT5Xd7vcCE81jvJoGZMjg648JfBGrG9n+gSZHRx
         wf56BJ1v6E2U+LAH6Fwp1z4DfaVRR+umG49Nz74xVHCeXD0MDWcmGd7T25YXViVawedf
         FFSA==
X-Forwarded-Encrypted: i=1; AJvYcCUVb0Yks+gtGIFju//LH3/jFAt1sAHlzP9edXRoq2G+0x3NfVFkTs/KxSd3ekgSg6qA5mx9fXcOKr/1rEL4zX3Ir+qWFRNABfDR5L8bieJ+1ixqvzbaZ/Du4DgJDm+hoN2M3x3wWlU=
X-Gm-Message-State: AOJu0Yyuytc57ZfOZygikU0ycXDRnU2uiTe/wecX4fCcJ9slPtGxx+UK
	yYmCDRSmMcawO5uKlOInV37l/itphPLiCeJQZ/3oc5Oz2XajzwoFWdHgUrqJn8EDlvUJZ4xQPIJ
	ocVs6qIHowDTkj1p8DScl6CHUmrc=
X-Google-Smtp-Source: AGHT+IHhGXCmW/U10NQlHOn/42JTQG4z0M4mbLYQYhuN7kdIqltd7/jAa2xyselcJB3OX438AoakO3jq5tkhTNwsG+I=
X-Received: by 2002:a05:6870:8dc9:b0:21f:9eaa:3f1 with SMTP id
 lq9-20020a0568708dc900b0021f9eaa03f1mr2927772oab.5.1709325697043; Fri, 01 Mar
 2024 12:41:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301081802.114308-1-yang.lee@linux.alibaba.com> <df67c46b-26a3-44da-8404-1bf445cb6efb@infradead.org>
In-Reply-To: <df67c46b-26a3-44da-8404-1bf445cb6efb@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 1 Mar 2024 21:41:25 +0100
Message-ID: <CAJZ5v0hXjoukVi-Ft71wDfPttAbutX8iomKuzmr21cpKx444BA@mail.gmail.com>
Subject: Re: [PATCH -next] powercap: dtpm: Fix kernel-doc for
 dtpm_create_hierarchy function
To: Randy Dunlap <rdunlap@infradead.org>, Yang Li <yang.lee@linux.alibaba.com>
Cc: daniel.lezcano@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 8:24=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 3/1/24 00:18, Yang Li wrote:
> > The existing comment block above the dtpm_create_hierarchy function
> > does not conform to the kernel-doc standard. This patch fixes the
> > documentation to match the expected kernel-doc format, which includes
> > a structured documentation header with param and return value.
> >
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks!

