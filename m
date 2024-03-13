Return-Path: <linux-kernel+bounces-101083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B591487A216
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3861F2411C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6510A19;
	Wed, 13 Mar 2024 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ox3FecXP"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC360DDD1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302098; cv=none; b=upe1u8HwRkbwNl4PKUHJ+APUUEAAljcuzKJo8LSLWolnfPXHAzh42XapI2OUzNY9O07q4I2qssVeA59WhM5xvBaRfBwkwJqBkkj16AHVmC9GZLZ3hiUPOlR7EZjBOJToa31kEfY+wKSOAlMSG8rdFDsRS4WzimXQq9+CU8HudxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302098; c=relaxed/simple;
	bh=A9WuMf5engSRfC+urYs6dIjYYEm9lck5mar7taMu7O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lG4b5iFGPIbRopk4VQjhfxT25tmsUAJj5IDQpnrFCXOXM439qA+mgG5/E0rnBtigwWJArxNxsFWXL+aRhbEEikjE4QxvH4es4ewy3z3gjWxrAiXOiKSYJxGBcL8nsCxMmkni64AnWPisx5Sd/fkDvVIXQm3M6B6dztfE70N+CN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ox3FecXP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a465f635652so8188366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710302095; x=1710906895; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKVNlwXsG3iAqCu1W8+GU0KcqpNheelf4M1fbJwAcjo=;
        b=Ox3FecXPliA6smwNtcr4c9Yv9P/fE7bWRfWTpswaAE/aEQDiDdJJLxM/9MbZt7z6B1
         LOsHYRQ1dTIAg6g7KM5N4hNBRBJS6kDa1iEDBq4X2sXSARjJCreuyIY93GgQ595dMNoP
         ymA4hBSzRXUOX5fMFLGhNSXGOEhkPBFpZ78LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710302095; x=1710906895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKVNlwXsG3iAqCu1W8+GU0KcqpNheelf4M1fbJwAcjo=;
        b=D2OlwREKYnKstbhV0DEaFbIft6pFz2qvfotqJs3SH0hr0POOQDeQwzUVe0+aKVLPjE
         HbpXgJRixkou40B1L52u+rbjmm2WF/yU6MT2d7KbrAZhaScMDmNuq4dVu4YETKHB/Y6/
         0t4PcKSAglB/mZIkqUw8/YI8lpY8RduSySmvQN/1AFKFtBwChrRAZzdL31gO9EZ9wR1c
         /sTtgMemhPD2FFzbnYWM8mxxt6tGZ5ph5rg5TeQec0MoSiqo3epaw7qZL8O8a7V1P/iB
         cwK62UbvWc4sPQuU3z6NasUk2ls3Ze9c9Z/ZWniyqjb4I6GstFB7EnX7dMQ6XAhcb0RA
         UFvw==
X-Forwarded-Encrypted: i=1; AJvYcCXEUegImzl6SHgqHwTPYCE1+Ebldm4bDYbRGTpLF74gPCARh/K08LJlcMuNZkXhdrZXuECkuKnzKWG9tyeK1eU1tDBHfVgaFUdy30Xq
X-Gm-Message-State: AOJu0Yy7xy0mI8gnR/TLTAyWLak05OgWLATepcr6tCZ2ACQZWGoAU1H3
	cN0qZJzXptoav6uMM0nae2pQveFjHqw+abTeaJp6fpk0LaSeHG9z+XscoQdEcScSP9WJKixI2+d
	LaOUfug==
X-Google-Smtp-Source: AGHT+IEzSKIj8+Vk3/iXjD1/DwprAua/0AuyZn5esd2PSytE4rnGD6XAGOs+7KcIDfcjgEFWmnJd5Q==
X-Received: by 2002:a17:906:4349:b0:a46:4439:7870 with SMTP id z9-20020a170906434900b00a4644397870mr2363720ejm.54.1710302095140;
        Tue, 12 Mar 2024 20:54:55 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id dt14-20020a170906b78e00b00a45f2dc6795sm4449735ejb.137.2024.03.12.20.54.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 20:54:53 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a465f635652so8186766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:54:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkOjaij6xMAb//ci+A2o53dFAl16bwV2BBqJAAaPUOpHYMe7c24eX4B2VqPEYgWqFoZh9GatllQGIgldYW14srNWecwgudl2Chkgby
X-Received: by 2002:a17:907:7b06:b0:a46:6073:8df8 with SMTP id
 mn6-20020a1709077b0600b00a4660738df8mr51030ejc.47.1710302093318; Tue, 12 Mar
 2024 20:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c021631d-29e5-432f-bfcd-1d75ec28d065@suse.cz>
In-Reply-To: <c021631d-29e5-432f-bfcd-1d75ec28d065@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 20:54:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFUvms3x7BC1R_4-t80K3O_XTOW3BKp6nPL_FkFSPzzQ@mail.gmail.com>
Message-ID: <CAHk-=wiFUvms3x7BC1R_4-t80K3O_XTOW3BKp6nPL_FkFSPzzQ@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.9
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Xiongwei Song <xiongwei.song@windriver.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 02:55, Vlastimil Babka <vbabka@suse.cz> wrote:
>
>       Also deprecate SLAB_MEM_SPREAD which was only
>   used by SLAB, so it's a no-op since SLAB removal. Assign it an explicit zero
>   value.  The removals of the flag usage are handled independently in the
>   respective subsystems, with a final removal of any leftover usage planned
>   for the next release.

I already had the patch ready to go:

    https://lore.kernel.org/all/CAHk-=wji0u+OOtmAOD-5JV3SXcRJF___k_+8XNKmak0yd5vW1Q@mail.gmail.com/

so I just did a "git stash apply" and got rid of the final stragglers.
No need to have various random maintainers have to worry about a flag
that hasn't had any meaning since 6.7, and very little before that
either.

              Linus

