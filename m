Return-Path: <linux-kernel+bounces-50934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D148483F9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB6A2893B4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FDB1097D;
	Sat,  3 Feb 2024 05:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l62OrDZK"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9D10A1C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937594; cv=none; b=Gf3Gt1K2KhVREjf87v/o1TXKGQkCUoJoEv8VroJjwGn5waanjieX/HH38STn4mdjTcYhV0SL+rqdCNto9QLLKcdTN71exglGWeOk3yq0mA4hOfScRtgEnseNnpzMwXUR4mbiaPP4r8WYpl22R2wNGpVcehVJnz7doYSl1wtUtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937594; c=relaxed/simple;
	bh=aV3RAoxJAIIl/L41qxXGSFWaFYi0w5bCiFnptXPK/IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGi4lGlYEaEMhSLNGWuD8ab6JD6GdCZ/qqK7gjBxOBP/qmnMlw2D/whXAJVqjVxL8pZp7aH/dD1NWG5gfbj+tEbi7OHSQk85zfS0yxmz6txo1Cj8G6HC8wARXAfkcRzVWbLSlNyr7F11BAHmM6J+C786Y4WtiODzjJECauDso/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l62OrDZK; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68c7f482f8eso9468606d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 21:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706937592; x=1707542392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxZUisTRnkCHmoXtIIiIE5AFQkxg9hNXueoX4FT1IyU=;
        b=l62OrDZK9YxbcV8Jlk+51HjizekLGOT8xMDBYsyY+w6YMV1YEE8UC5FvOEOpb2qnKS
         jmt5Z0o/nQPyPKwHDjyUReV79b/hxWpR2b4QKd644+v2QqIN9LLTsrr1Up/f5cI6S9R5
         M7g9+u9An+wnmEs5/U46Ebqb5szZrUS7ukYvVxMMtN/nMSnEfnERQwmENy7oz0ChSa0U
         oYDC498w2tUaCQA0NXXKgzH2P/1U/tQFcpji+ViehH8DTuWdM2LaBEIV3YK6vLRxx7je
         NRGSKGYna8eOuGXFZ+ofBL0rsdRPS8iIDaP41Bfjy3yI7eqDtFqm5VmXK8tYq5cqD9Jf
         4ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706937592; x=1707542392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxZUisTRnkCHmoXtIIiIE5AFQkxg9hNXueoX4FT1IyU=;
        b=r/4Jw3QAxXxQ3WM6rbUioaHSpWAXiSLKZPf8attNkzS+mrNTPsJNlqTZsB/vIpkgag
         +rehFUILVBtg3bWXOw/vo8ygTXwbsDzm681ntfbzW/RM/jqoGn/bknQDUoLBdO2vIy3N
         pl9A2sUG7/c9iyptCzetpfYjCGHG1sOvt19oh2nhhDVcZL7YK2zfTfCFq+KaS3ugWlFW
         27jvAHPzYKH6w5ssWGhkcTIoDaQMVs8f9/175235f7xy9JoavLNSjNX7Vh01cDBmexh9
         EKw1dPUezQAU5scdLALzPVT14q+uXDXfBlfXeTQFtdHhxHdlvOYeRJvlkGK5bjeBztWi
         Et+w==
X-Gm-Message-State: AOJu0YyZ4tAfnaAFyP0JTphBi1y9GUE4/yvIWYbSi7yk+PoiTk+2xM6t
	bq9/LWPJJR+vz6qfDA+M4n7c2/VrebmJoUbLIe9fT5pZoSqWD8P4BcOe7fVSS84fkq+UYY5IoWM
	7ATpEMy9dH6B7gqvP2GXE7lN9y0vo+f6aGBJz
X-Google-Smtp-Source: AGHT+IEZAAPF64V9fhwb83mtq8fxx2bw72Ju+9SxlvorBwmV39Npwwn5YZ+MgV2PpJ35mYdpTaZi8VMsqxbbJHCx/cY=
X-Received: by 2002:a0c:aa1a:0:b0:685:edc7:62c0 with SMTP id
 d26-20020a0caa1a000000b00685edc762c0mr285138qvb.30.1706937591794; Fri, 02 Feb
 2024 21:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <20240112055251.36101-6-vannapurve@google.com>
 <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com> <CAGtprH_ANUVU+Dh1KOq0vpT7BGbCEvD2ab9B=sxjzHYsKxFGeA@mail.gmail.com>
 <1d9d3372-825a-417a-8811-ffa501c83936@linux.microsoft.com>
 <CAGtprH8r0kYYqGoumsVeZq42cX8CN3cchkuRYhQULqtb-1nKww@mail.gmail.com>
 <3313c886-e964-48c3-8277-b47cb1955de9@linux.microsoft.com>
 <CAGtprH9X0Yz_Z+QaYcLpLNXtY_Ye68aqvx-G1pOWZxv9SiRRoQ@mail.gmail.com> <746d2448-3adc-467b-a39c-5585f33bd740@intel.com>
In-Reply-To: <746d2448-3adc-467b-a39c-5585f33bd740@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Sat, 3 Feb 2024 10:49:38 +0530
Message-ID: <CAGtprH8X96enAOmgu60q0N6L=NEB29PBu_0yEuS8u1U=C4VO3g@mail.gmail.com>
Subject: Re: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at
 2M alignment
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, rientjes@google.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, peterx@redhat.com, 
	vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com, 
	michael.roth@amd.com, kirill@shutemov.name, thomas.lendacky@amd.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, rostedt@goodmis.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 10:06=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/2/24 08:22, Vishal Annapurve wrote:
> >> If you must - focus on getting swiotlb conversions to happen at the de=
sired
> >> granularity but don't try to force every single conversion to be >4K.
> > If any conversion within a guest happens at 4K granularity, then this
> > will effectively cause non-hugepage aligned EPT/NPT entries. This
> > series is trying to get all private and shared memory regions to be
> > hugepage aligned to address the problem statement.
>
> Yeah, but the series is trying to do that by being awfully myopic at
> this stage and without being _declared_ to be so myopic.
>

Agreed. I was being overly optimistic when I mentioned following in
the cover message:
"** This series leaves out some of the conversion sites which might not
be 2M aligned but should be easy to fix once the approach is finalized. **"

> Take a look at all of the set_memory_decrypted() calls.  How many of
> them even operate on the part of the guest address space rooted in the
> memfd where splits matter?  They're not doing conversions.  They're just
> setting up shared mappings in the page tables of gunk that was never
> private in the first place.

Thinking it over again, yeah the conversions that are happening
outside SWIOTLB should be impacting significantly less memory ranges.
As Jeremi and you are suggesting, it would be a big step forward if
memory conversions happening for just DMA requests are aligned to
hugepage sizes.

