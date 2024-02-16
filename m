Return-Path: <linux-kernel+bounces-67900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5D8572A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBE1F23287
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E3A53AA;
	Fri, 16 Feb 2024 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vFhJ52U5"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF24635
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044006; cv=none; b=Gi9eDMRYCb0FPnGQ0KmVIFOco83jnNAQt5Fyfv0Vj0+nb/VueGgTA/l4bZG6sw8s1xtHsNzL/DVZgB1TKK/YoiAdVyz7It3FN04dQXLHw6dScC3iX3csydUqaJAAZUF3ss7QVmnb/nW1otnm1mjXAa8Ibq7uPk5e8m4L39h7utE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044006; c=relaxed/simple;
	bh=lNWtY/B1xY1q4emMITPcTwneXwj+O8lm1/92kGWavpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3SEsovrmadNrbty6vv7AqGFfG8SjzHzUR2f8ku8h6yR5O8lvd/tahT6Ff1HJbOhES/0hpk3HbVqZvdglk2vvcD04oTwj6f8A2z0IbxTUMgcLlg6V+1zyEdKHHszk0JTA6QbJdfO57Wdr4nl7vQes+atWRYB3Cim6pAy9ZtFSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFhJ52U5; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso268921276.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708044004; x=1708648804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNWtY/B1xY1q4emMITPcTwneXwj+O8lm1/92kGWavpY=;
        b=vFhJ52U5Ca5lVgqXIok35m/wap6nAv63NFbqMG9BgcMU0LoFgV5xwyrMj48LUMEffE
         Uszg0p7JKzKZAJkqmYynoxYdmZqkm0PYwHTP86g3ujio1PT6UdhgJ6QbUek6pLkAYEyk
         8NUh6EXYOeiKAn4WWXiH9wX4B3uc5iADYqTjIB1owC5fGlpDICK88WPAZsmZgct+VSSD
         Po7N2t6/E8cr3ZitpP/aeAZ81eZfWhtUt6rDQO7ncBVgUUHk3wkYo6DNepKipZYUnBJ5
         x6ukBbpUrq075zaiEYBqC7BD1U5d6GA5FUre9XS1dFH+rt4m12JjSyhuFoPon2w2UKVy
         HJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708044004; x=1708648804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNWtY/B1xY1q4emMITPcTwneXwj+O8lm1/92kGWavpY=;
        b=NAc3P0lj5nBTzbFk90Tcn7BdQPjc25QrwjcRS8iiJE0Yf6Q/lPDdK7yBywRKWa8Oen
         ffsOSOpF/H6/lfLJu3fFDykl6tk+YA7k+R4QzBEztjwvjEdJT/gb0Vw6YQxtFUM4R8b6
         F9BcHQCx/bvmHj/Z5OmjDd6l04ZsFXks5Wxis9If0DtJXgNbMvgtfXSddBDNpicJt5UO
         aWuMbOkcvUTakk9QDe6S+OiPxNNMIA1uej5g8Nk06knMXayM1SCLyLPd3gTs7intWo5A
         HShVNiBIfG0jj//aWWqFRqeP6CDgNqM2/saSzs6Qv4dopUpn3xOA9iPnLcRcyuQ7lZ0V
         cIDg==
X-Forwarded-Encrypted: i=1; AJvYcCXVdXaXJC5sx5SV6XvyFJs/QuIfbnn+zmMEiYdgndhC89NGQDlX2as8wTHmfQ//WYxpYBhv7+Vx/PS0x1xOcjJtnH5w+q3QK7qQ270s
X-Gm-Message-State: AOJu0YyYhFhiTMvITGyS8SfGO1YCVBh38osTAZtow6YcRGR/drpyTMHB
	aCSrU/jc4EvB7p+dffMVpDCyxUWlUSncKiShPi5tKfr6KQVdbcCgbTITfrXg3cFBNupdJ2/lYdH
	WGpIEL27lBUPG6EwmC8C0LfBHw8glzvpxBdf+
X-Google-Smtp-Source: AGHT+IHAAsugZ3/nqJLaPaGwbaKWrJXvPAuodtlX22tVU71nS9Rg5t7nXyOIvNMt6vhQws8u5s7RYzYtvfhsM7i5y6I=
X-Received: by 2002:a25:b184:0:b0:dc6:c510:4484 with SMTP id
 h4-20020a25b184000000b00dc6c5104484mr3417966ybj.26.1708044003733; Thu, 15 Feb
 2024 16:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214225741.403783-1-souravpanda@google.com>
 <20240214225741.403783-2-souravpanda@google.com> <20240215161441.c8a2350a61f6929c0dbe9e7b@linux-foundation.org>
In-Reply-To: <20240215161441.c8a2350a61f6929c0dbe9e7b@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 16:39:50 -0800
Message-ID: <CAJuCfpHF=yxV9+=pUo+5DwSjvF=r2y7A9_8LHsUGUSoP7EUNXA@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] mm: report per-page metadata information
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org, 
	weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 4:14=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 14 Feb 2024 14:57:40 -0800 Sourav Panda <souravpanda@google.com> =
wrote:
>
> > Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> > to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> > to /proc/meminfo. This information can be used by users to see how
> > much memory is being used by per-page metadata, which can vary
> > depending on build configuration, machine architecture, and system
> > use.
>
> Would this information be available by the proposed memory
> allocation profiling?

Well, not without jumping through the hoops. You would need to find
the places in the source code where all this matadata is allocated and
find the appropriate records inside /proc/allocinfo file.

>
> https://lkml.kernel.org/r/20240212213922.783301-1-surenb@google.com

