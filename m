Return-Path: <linux-kernel+bounces-96477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28AA875CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78E4B21AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC822C1A0;
	Fri,  8 Mar 2024 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8Airerv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906C2C19A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709868361; cv=none; b=fppvzQJ1tKk5aOxydI3LOpniwf/C/8Wv7S4zaTIa7FjC1gyZQIkk7IbE6szY9Nar9+Cst3fV5uXh8gopXoOj0Nl3GozSTlpXEuzBqhYKkL1ByHnO+mHXPijEsUp9T+yZU0qaENOjd8yddhBOAVDu799iKhq+sN0jSuagy9Y3beQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709868361; c=relaxed/simple;
	bh=YxYsPp2jT0+nsgvCsO0L9tTPd6klWc6+ck0k5NkCspQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM/8FgYmJOz5VEqrtwCKmlKZGGumSRe2HmkPkwtcj4RGfGAq9ESKsgxSwJmucZtySMozTFX9cNaO6JADqoszBwtw684spojOEiJOC0HgRNobFHVMQVNuoWXaONr/w4oU8AG6ymuOnKlQMyJnFv0fIor7gBFtuv+OX8QnT6OhI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8Airerv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709868358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PybR5AcU1HfTv1X4VNBJgftVTm18j/aD+eRiC/mDwDM=;
	b=V8AirervOibKZ1F0WKoNUmQMfTROwJyXLONsXecen2OZQML/TFaltqzJS9CmOOIBOhPY3W
	dXBsayybAUY+l6ahSdZWT4TunR1Iy161EJUfOmhQ1waNr+tK/JH6l6wQgMSv0RtBvFYslF
	oVSf8hDr7Xjem7T/WqgR3Op+WRHetIY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-JVXOh-4uMpCBCYVtNxBlQw-1; Thu, 07 Mar 2024 22:25:57 -0500
X-MC-Unique: JVXOh-4uMpCBCYVtNxBlQw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dbcbffd853so18425235ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 19:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709868351; x=1710473151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PybR5AcU1HfTv1X4VNBJgftVTm18j/aD+eRiC/mDwDM=;
        b=fhn4oBMFpUSg5wkVLmnr397IHK22WBPFZdvAQWDI082zu5GC329wo5YSvNrRj8T6Ig
         fs/IsY4KyQ7wNA25tvgrXTBkviFefkdgFX9h17kvpCbifVZPpc9/O7l6gO5PvF1Vn9PG
         oBWpE95aARFD3VnREpCvQrB6Y2DfQSF/SrT1xttKIjNjznv+an9+qsnTblzW0EqC1eUI
         X3c4bgoVrf+/wyeKytRhgjDa0pw5yn2E+ZzGAxyajl7WQZU7NBEF1I6ITQoq1A7DR7Le
         TWYJF771ofrhYpY/Y/uW+bgDpGBGF3QdJHidrx5g7t2TT+ym9OARye0nf/z9wNCpvN1J
         dB8A==
X-Gm-Message-State: AOJu0YzKFIvvUTSEQXqSV3n8Z1fW+DF7tQRTbEdz3nz/4MHJdLKZJX+F
	WBbhu/En2FVWfNXS0Kz8NwcUB6n1xedtkgN5ZZhG83QKLX3zcqhDPaCiJOsAafVLnecPwVZ9R65
	ykAjRGkNH0aw2630iDlbt8puiArZ9Dltl5e8ljLsnuS3ehDNf7QHmF6OUIXoaRA==
X-Received: by 2002:a17:902:ea12:b0:1dd:528e:9bd with SMTP id s18-20020a170902ea1200b001dd528e09bdmr4024735plg.34.1709868351025;
        Thu, 07 Mar 2024 19:25:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxLZl1+bQFUoT9RAmqGoW5BDWYJ6KqC6bmlwf1NbsnLayaLnh2DK4Bmp+XlKoPDIQgjasuBw==
X-Received: by 2002:a17:902:ea12:b0:1dd:528e:9bd with SMTP id s18-20020a170902ea1200b001dd528e09bdmr4024717plg.34.1709868350551;
        Thu, 07 Mar 2024 19:25:50 -0800 (PST)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001dcb654d1a5sm15324100plg.21.2024.03.07.19.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 19:25:50 -0800 (PST)
Date: Fri, 8 Mar 2024 11:25:41 +0800
From: Tao Liu <ltao@redhat.com>
To: Dave Rodgman <dave.rodgman@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Matt Sealey <Matt.Sealey@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"markus@oberhumer.com" <markus@oberhumer.com>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"nitingupta910@gmail.com" <nitingupta910@gmail.com>,
	"rpurdie@openedhand.com" <rpurdie@openedhand.com>,
	"sergey.senozhatsky.work@gmail.com" <sergey.senozhatsky.work@gmail.com>,
	"sonnyrao@google.com" <sonnyrao@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, nd <nd@arm.com>
Subject: Re: [PATCH v5 0/3]: lib/lzo: run-length encoding support
Message-ID: <ZeqFNf6Ay6yNq2kW@localhost.localdomain>
References: <20190205155944.16007-1-dave.rodgman@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205155944.16007-1-dave.rodgman@arm.com>

Hi Dave,

On Tue, Feb 05, 2019 at 03:59:59PM +0000, Dave Rodgman wrote:
> Hi,
> 
> Following on from the previous lzo-rle patchset:
> 
> https://lkml.org/lkml/2018/11/30/972
> 
> This patchset contains only the RLE patches, and should be applied on top of
> the non-RLE patches ( https://lkml.org/lkml/2019/2/5/366 ).
> 

Sorry for the interruption, since it is an old patchset and discussion.
I have a few questions on lzo-rle support, hope you can give me some
directions, thanks in advance!

1) Is lzo-rle suitable for userspace library? I've checked the current
userspace lzo library lzo-2.10, it seems no lzo-rle support (Please
correct me if I'm wrong). If lzo-rle have better performance in kernel,
then is it possible to implement one in userspace and gain better
performance as well?

2) Currently Yulong TANG have encountered problem that, crash utility
cannot decompress a lzo-rle compressed zram since kernel 5.1 [1], since
there is no lzo-rle support for current lzo library, crash have to
import the kernel source code directly into crash, which is not good for
crash utility code maintainance. It will be better if we can update lzo
library with lzo-rle support. I guess not only crash, but also other
kernel debugging tools running in userspace such as drgn may also need
this feature.

Do you have any suggestions on for these?

[1]: https://www.mail-archive.com/devel@lists.crash-utility.osci.io/msg00475.html

Thanks,
Tao Liu 


> 
> Previously, some questions were raised around the RLE patches. I've done some
> additional benchmarking to answer these questions. In short:
> 
>  - RLE offers significant additional performance (data-dependent)
>  - I didn't measure any regressions that were clearly outside the noise
> 
> 
> One concern with this patchset was around performance - specifically, measuring
> RLE impact separately from Matt Sealey's patches (CTZ & fast copy). I have done
> some additional benchmarking which I hope clarifies the benefits of each part
> of the patchset.
> 
> Firstly, I've captured some memory via /dev/fmem from a Chromebook with many
> tabs open which is starting to swap, and then split this into 4178 4k pages.
> I've excluded the all-zero pages (as zram does), and also the no-zero pages
> (which won't tell us anything about RLE performance). This should give a
> realistic test dataset for zram. What I found was that the data is VERY
> bimodal: 44% of pages in this dataset contain 5% or fewer zeros, and 44%
> contain over 90% zeros (30% if you include the no-zero pages). This supports
> the idea of special-casing zeros in zram.
> 
> Next, I've benchmarked four variants of lzo on these pages (on 64-bit Arm at
> max frequency): baseline LZO; baseline + Matt Sealey's patches (aka MS);
> baseline + RLE only; baseline + MS + RLE. Numbers are for weighted roundtrip
> throughput (the weighting reflects that zram does more compression than
> decompression).
> 
> https://drive.google.com/file/d/1VLtLjRVxgUNuWFOxaGPwJYhl_hMQXpHe/view?usp=sharing
> 
> Matt's patches help in all cases for Arm (and no effect on Intel), as expected.
> 
> RLE also behaves as expected: with few zeros present, it makes no difference;
> above ~75%, it gives a good improvement (50 - 300 MB/s on top of the benefit
> from Matt's patches).
> 
> Best performance is seen with both MS and RLE patches.
> 
> Finally, I have benchmarked the same dataset on an x86-64 device. Here, the
> MS patches make no difference (as expected); RLE helps, similarly as on Arm.
> There were no definite regressions; allowing for observational error, 0.1%
> (3/4178) of cases had a regression > 1 standard deviation, of which the largest
> was 4.6% (1.2 standard deviations). I think this is probably within the noise.
> 
> https://drive.google.com/file/d/1xCUVwmiGD0heEMx5gcVEmLBI4eLaageV/view?usp=sharing
> 
> One point to note is that the graphs show RLE appears to help very slightly
> with no zeros present! This is because the extra code causes the clang
> optimiser to change code layout in a way that happens to have a significant
> benefit. Taking baseline LZO and adding a do-nothing line like
> "__builtin_prefetch(out_len);" immediately before the "goto next" has the same
> effect. So this is a real, but basically spurious effect - it's small enough
> not to upset the overall findings.
> 
> Dave
> 
> 


