Return-Path: <linux-kernel+bounces-100494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2BF879891
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40241C21AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD637E56A;
	Tue, 12 Mar 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iT4MRI2b"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BA7E11A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259811; cv=none; b=Ndv1QUrD6VlF/YJXFNZLeC4QsHlM3VEvuxu/sj2BEx/35hjW2MMqTafEutq5xWf9AGqpy/3cHFHctsl/Q4AnPaa7zM7tD/238LVT3pNkaIcw8DjgowpOPVJe3NSdPX9W4BMmdqJtxvuO7vjlFD14/Sgom7/sP1ONnsEyXjjjmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259811; c=relaxed/simple;
	bh=qPjhJHW1dcYo8k1atulrqKd7xFkV2OV5T4XFSz4kxUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzbbx83V5jVi8WXuy3E5XcHYeKgZ11gXWshuSjcAMzvlS7SDhTbyW8pqMDlzVMTD0LeizkPaRKqnGGCoIpePZ66W4it3e6tGcZYd8iN+SVkMB3HAHNKPknFHvL96/1JoUMj8gyzo8Ri+0AXmMYAsFvsZ1Rk6kSwzyNjL6v2s6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iT4MRI2b; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4649c6f040so84085166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710259808; x=1710864608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3+O10vd3liFJMunazLMlhKBOkgOhJq74haBneqSUXs=;
        b=iT4MRI2bJVX2UqPUI6iUq2aGqBj7UAhiIR9Xf73KajY1rVBvNLhzfUGof5ndn+wo4d
         LUSipPernN1zCeRZ8cPEKLeX6BjMknn4GbQ9ytAyNqkUXIl62TI/0NeJbfxAMI2NXmON
         jQYbWhXuCTUCT4WsCDp5jHr+jN2utX7u2vLsV9cmzaZIdBosM/OiYwaW2eaaQVsy0ntY
         Tb9e3UWnG7iorxsdk94fAyt2oNfhM9I8hqwUd9OH2iiu6JHt2pnhLwxRLXO1AdW3W8M6
         huit4gHauSjOiWxMN2ieFxSBny/nplkzcJL4nI0zqoYbb+FS7NIhYYMHnv5j/2aWTyb9
         mPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259808; x=1710864608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3+O10vd3liFJMunazLMlhKBOkgOhJq74haBneqSUXs=;
        b=Vi/WPxiVaA417nKZQP8PP/AJ2681IcZ+vt1llWZ5Udkzac5H7z2ixFODOMLVlLDHCf
         Pa108LWkiEkFGPQqP5Cf0zSma6wg+Sa080VSXzKOp3lCEu0t5wuZ8UA7rAHIBLPe+V5t
         d1Bu3tHaAlR1DE/Kj3yhCqSnSqwQgIPJFNcwBdCb3u9ug6NKEeQidIBbWTgTR9KKNdo3
         8ee7PQbuFcc18iu6cNm8dpRnjqLiJSeTfkMy0SP9KB1cRTXHSW5PJ76c0w5v1BydbHX8
         ZflCqaxE9laJy2PvjBcLoh0UpooVZpyW8A1LgYuscp8jnqzrBQCPU5YUutGTeYD9+NCm
         ODjA==
X-Forwarded-Encrypted: i=1; AJvYcCVxZO/CdvAqDc+UW7JQPRcPopECT28y6sI/qDvo5q8n62XlHUd/UmDBou0hSt+x1JZzxzXXmJk6YhRcqI+j77fImV/KSn8b+YsLyg+1
X-Gm-Message-State: AOJu0YzcUwX2WmQv4n9+lqimFIg+/seBQMHdmL7dp2pzzTjcCLkyiThV
	6R3yLj7n11bRPIDB1l8llSaRG7AcPehJo97X3EhmbJOBtQBWbfVZxrcecJHD3mGp2ex03Ee470K
	8M+uboTPaBISUUbn9CkCoPSvH6XFtxdYawnMn
X-Google-Smtp-Source: AGHT+IE80lye4zSsuGhA8kA3D+sK/NVpvlJukMC7Gww9CfMolxu7wRSlYSv2oORoukxm9HtOLfrE1Q10/pe/qHtuCto=
X-Received: by 2002:a17:906:b14e:b0:a43:6cd2:7bb7 with SMTP id
 bt14-20020a170906b14e00b00a436cd27bb7mr6714888ejb.47.1710259808090; Tue, 12
 Mar 2024 09:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312155641.4003683-1-yosryahmed@google.com> <d24c8736-d963-4aa5-a3cb-5cc1110e3ca8@intel.com>
In-Reply-To: <d24c8736-d963-4aa5-a3cb-5cc1110e3ca8@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 12 Mar 2024 09:09:30 -0700
Message-ID: <CAJD7tkYXfFiOQMpM+GkR7a=aUxFM-smDc-ZFTTtFu2Kbd2KoPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/mm: Use IPIs to synchronize LAM enablement
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:04=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> Yosry,
>
> Could you please slow down a bit on these?  Us lazy west coast Americans
> are barely a cup of coffee into our day.  We haven't even had a chance
> to read v1.
>
> Once a week is about the right cadence to be sending these.  Every 12
> hours is more than my poor inbox can take! :)

My bad, I lost track of when I sent v1 and saw Kirill's comment when I
woke up so I addressed that. FWIW, v1 and v2 are almost identical
except for a small change in patch 2 to address Kirill's comment. I
will hold off on sending anything else this week.

Cheers!

