Return-Path: <linux-kernel+bounces-47658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C618450DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53AEB22D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E30771B32;
	Thu,  1 Feb 2024 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0ulfMHV"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C8612EE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766284; cv=none; b=T80JuZf5fkUtEqxBgtuidSpCAvmWs3edaLFGx0Gss5sfxctjEhMJyPNcBkZXIBzxnwOOoEDMCbRaWQ9Bp1OaivcDepSjM1N95YKEq4geDpKnfilTytoeEq4Fi3qRWgLCRQg9ySqIBRQFmrX35adxOIaxPFNndv8Xh+8sOK46bF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766284; c=relaxed/simple;
	bh=vEMPM/EH6Okz3t25IkSZi1WRRqu1MVzESQkdYhAZwy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRfxcK62LHvncB+YjthrcJPm2zrSKew7jt4+47V88TY70gACeUz7hsqtQRAk9OEz/Y3zqrHAS6TnTGSH0xvHMHIsK+afjf/tAPjAiV2iTlA2iRrpAp0CRvH/8D0WJlAS8f8QXvaWAvF+vQXwNHIyFgw3ZmOQUmulmBkFMfUoVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0ulfMHV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c495ba558so3314116d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706766282; x=1707371082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmok2g8b5tWvpbsX9cLmWQHlMF1xII4qzBeVlpsQ4mQ=;
        b=c0ulfMHVBWZj79cvVe0naZvUO52Tb+Yv9+vRF/6YydinKpRNdPbH1L0DoavM+YaxlB
         IBPFlRdnj4YJOqaeNHSu6WjTF3YTQVz4PcgZm5iWI531sga2YqmbsXE+3m/mXrjf4bY2
         U8cFaZ/oqQzSl+O5hYY069Ddj9MNG9oEXP8KNUKoBeD90NUxsW9m1S3fph7Upz6AIJj5
         LwPjQAb4frvDNU6tlTtWxBBvd4pYkXId8kVDmH3KrsF0MJs69m3PirinqWrCpojOXlQZ
         H2aaUSOkMCnojU3l5WjROjh/4W9hU5zVpZlxikSqL0b6m/YgvTkQVx3+B7zGtW5+acK1
         Jeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706766282; x=1707371082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmok2g8b5tWvpbsX9cLmWQHlMF1xII4qzBeVlpsQ4mQ=;
        b=ABfOOX/6gJ9WSryi9VNmNDmvZenbW5xxJJzNNVCi+vLmF4vJzYcTfJHKpsypCU94dW
         04dnKYxvMXRwm+L75XhosU48MuvUCCYs1OEdC7qMISJ99CqrpLq/9LjKwukOd00dM1xY
         QXBKzIC4XH/emz3/geqdwgpQsNIwnVajmvC8CgqsPv3uRTi6TdkW3Ibg5Qt94N7TsBoP
         rJNTXCmz8HQ04DGQ0N1lS/ccNsi927T+aTbZR9kZvpR3PIyQte855PJrElGmMSHZY9iE
         n6WsXzuxSXWNhXtX2AocqOCcy7y3pPQu/OZS2vbK85/PDSoxLlvG6GjJ4LIub6YWmFyr
         ushQ==
X-Gm-Message-State: AOJu0YwqYRn4raL6mpaO64VzL+12zDs0Frz2iDulCk5BUJ1HnWhPuPzG
	jhYv451uXpf39HHiVgy5xSnvqjEVGFaKH/lSQdA2JGiuY8sDur6n7Y+Y8zw3mGES+aTK+XlTJKq
	DVfdbYdYxCW4VbFuMtjy+sMrk8kTf5F7X4hOP
X-Google-Smtp-Source: AGHT+IHVvumo0DfD1PcCVlzlBND2HO0YlBAKMh0ymb7ulOnj4hcNNN1Lnv/Ngc1/yQN/cM+UWlxHcXe5s2sVnvXBr4U=
X-Received: by 2002:a05:6214:d87:b0:681:77d9:c405 with SMTP id
 e7-20020a0562140d8700b0068177d9c405mr3957939qve.33.1706766281534; Wed, 31 Jan
 2024 21:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <a06f9b81-38c1-4be8-9d07-6db31530741e@intel.com>
In-Reply-To: <a06f9b81-38c1-4be8-9d07-6db31530741e@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 1 Feb 2024 11:14:28 +0530
Message-ID: <CAGtprH8HhCVvjARm3ZuHu04uxAENOLa--kHQhRtAfSz+4-23kg@mail.gmail.com>
Subject: Re: [RFC V1 0/5] x86: CVMs: Align memory conversions to 2M granularity
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, 
	pgonda@google.com, michael.roth@amd.com, kirill@shutemov.name, 
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:23=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> There's a bunch of code in the kernel for TDX and SEV guests.  How much
> of it uses the "CVM" nomenclature?

Right, I see that "CoCo VMs" is a more accepted term in the kernel
codebase so far, will update the references in the next version.

>
> What do you do when you need to dynamically scale up the SWIOTLB size
> and can't allocate a 2M page?  I guess you're saying here that you'd
> rather run with a too-small 2M pool than a large-enough mixed 4k/2M pool.

I am not yet certain how to ensure 2M page is always available/made
available at runtime for CoCo VMs. Few options that I can think of:
1) Reserve additional memory for CMA allocations to satisfy runtime
requests of 2M allocations.
2) Pre-reserve SWIOTLB to a safe value just like it's done today and
not rely on dynamic scaling.

Any suggestions are welcome.

>
> I also had a really hard time parsing through the problem statement and
> solution here.  I'd really suggest cleaning up the problem statement and
> more clearly differentiating the host and guest sides in the description.

Thanks for taking a look at this series. I will reword the description
in the next version. The goal basically is to ensure private and
shared memory regions are always huge page aligned.

