Return-Path: <linux-kernel+bounces-75965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D443E85F139
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888DC28303C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A812E40;
	Thu, 22 Feb 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A9MeDhRk"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C5DF41
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708581612; cv=none; b=D30Fq/eezsnOcUiLPT3x3jWAjrR6OeIOoLIUwSeJY73oJ9Ig3UQgABl/hmOCTIdhJxLnauq35flCBtCTB5E/QQzFDUL6LyKeCkuNehKIJKjm84w72xsdUkRDD0miz3xSdWGksOkU/yuwGHdCKO3VDhgccX/G5ZeB19fY2AyLFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708581612; c=relaxed/simple;
	bh=jfydpiinpYlW5lz/CxxcHMi0x0ZILrRNe4+Fx00kgU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8GeUicNvZg07IIxJp8fPBuVtMUzgbdDTziYBsEMacPlZeub0R7Qq4yRU+2+NlkyV/+nsdeE45yOge8pKsZHobdK3YICpt4X7Eydrya0vwiMfUVKBcsvCaD4IsaGlCiRewHq2wpM3qbiyZCOfoX11VKJ9nrrlK0wSJCYwjm2s+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A9MeDhRk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0cd9871b3so5159431fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708581608; x=1709186408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrfADjbK9wBe+Anypf28Boz5+FV1y2DabiZpnaLd2+Y=;
        b=A9MeDhRku5ZkKM47HuBJ+VeyTI472K4HeybnEk+91J6W1BYcSb/bdUzBRZmVOAYqgj
         uRbzlBnhbkue15IP0mHqJ+tiQkr2wMhoWKy7A4+NRbG8ZCruIofvwr5FmBoDJVheuh9A
         sAhulTktch+b/I2GnDRpthJrOt5oy3CkA6UOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708581608; x=1709186408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrfADjbK9wBe+Anypf28Boz5+FV1y2DabiZpnaLd2+Y=;
        b=fRYqR1lCfGSbQgdKSMceUU3gdjTJEOewy/UUa9IgzoOhTXboB6HJ1E9+74VJPimwMM
         sJERx96Z6HDT/u1zb9h/KKXDWLbhcOcAObZ48u3xwnI/N2Mnvc72TgZMpq2iy6hBgvtf
         n8rI6Vplwhs+VvyDd++qxP1yLKvVajIcBHv4lwv668XJi+VFDjCUnqwZN6dubNCzMzmF
         MEtGeUVrC3XFemDVYr05pFn124VlnyFGPxTnaPjMiY/AEmlkC0DuLqOJZ969GsEyLDlb
         yklvdQdH80TalAOQjh5nJBT3cKZIHY9g6gecZXswqiXMV85/pJma/fVlGGxZpZ3n1IBF
         S6Vg==
X-Forwarded-Encrypted: i=1; AJvYcCV34L0GW/Qd96qRZ3BLr4Ns8LK+Z/rzhYv3FB1qr6srPg/HtPNlJEIIRoUdIqHPBFEU5QpCuiMdVFP/bmiHM/TKs+HDxgiNvXjFSns4
X-Gm-Message-State: AOJu0YyWEtdd3szW2u5OXlOeesmJ7ia8T19b0qzhBctBSIMsVcHSodfQ
	PUNpzDsVinkmZNHYPHobHYrtvqL3aH4sCzW1TLNRF6hFA/6eZSz2J50OCWVzjxCrMRlFoJfilW+
	wXeg=
X-Google-Smtp-Source: AGHT+IFgR4p5opIBKCPYhSfBb9KEZ+VP+gCEwjXSgvlvC7U5paUi9Qp109s4D4mjr/erPWKC0TVRhg==
X-Received: by 2002:a2e:3203:0:b0:2d2:2eb7:b484 with SMTP id y3-20020a2e3203000000b002d22eb7b484mr550739ljy.22.1708581608610;
        Wed, 21 Feb 2024 22:00:08 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id x22-20020a2e8396000000b002d0f3c58e60sm2107707ljg.117.2024.02.21.22.00.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 22:00:08 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0bc402c8eso4972401fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:00:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUT5jyIwSzWeYqi5u1oZOMOrHhFrdWQaIf5rcSYszO0ntEM+8phScHZb5XZ/AMPNBgtEvHs5cxo5yl1D1Hke8hhPuGYZn31gb2V852F
X-Received: by 2002:a17:906:f0c4:b0:a3e:719b:c049 with SMTP id
 dk4-20020a170906f0c400b00a3e719bc049mr1321213ejb.28.1708581587292; Wed, 21
 Feb 2024 21:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-9-davidgow@google.com>
 <anz6qjyb2oqkz6wdy4ehnlpoujy4rz2itohpglgfqzadtonxtj@ljakgnqmfxxh>
In-Reply-To: <anz6qjyb2oqkz6wdy4ehnlpoujy4rz2itohpglgfqzadtonxtj@ljakgnqmfxxh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2024 21:59:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com>
Message-ID: <CAHk-=wgafXXX17eKx9wH_uHg=UgvXkngxGhPcZwhpj7Uz=_0Pw@mail.gmail.com>
Subject: Re: [PATCH 8/9] drm/xe/tests: Fix printf format specifiers in
 xe_migrate test
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 21:05, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> this has a potential to cause conflicts with upcoming work, so I think
> it's better to apply this through drm-xe-next. Let me know if you agree.

I disagree. Violently.

For this to be fixed, we need to have the printf format checking enabled.

And we can't enable it until all the problems have been fixed.

Which means that we should *not* have to wait for [N] different trees
to fix their issues separately.

This should get fixed in the Kunit tree, so that the Kunit tree can
just send a pull request to me to enable format checking for the KUnit
tests, together with all the fixes.  Trying to spread those fixes out
to different git branches will only result in pain and pointless
dependencies between different trees.

Honestly, the reason I noticed the problem in the first place was that
the drm tree had a separate bug, that had been apparently noted in
linux-next, and *despite* that it made it into a pull request to me
and caused new build failures in rc5.

So as things are, I am not IN THE LEAST interested in some kind of
"let us fix this in the drm tree separately" garbage.  We're not
making things worse by trying to fix this in different trees.

We're fixing this in the Kunit tree, and I do not want to get *more*
problems from the drm side. I've had enough.

               Linus

