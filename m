Return-Path: <linux-kernel+bounces-66930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD5E8563B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299721F26C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B3312EBD8;
	Thu, 15 Feb 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVrsf1s1"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF212C7F0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001577; cv=none; b=fDWchN4KTegh1gQV28+95VmhELkws85aDTEz89hTXBsaROMjwB59imllA9l6mGUpxO2iV+BsPscL39lAhb1/ajyDV5zzS4OnIdxvdjjoR/JiZV99aQZee8lcAjd/Sl5+WfEavY9RLKo5slVNmiIPqA+4YM5Tmlu/Gu1Zks47vU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001577; c=relaxed/simple;
	bh=SezWjjSD6orUt3oayIngZPbAFgryKCchhK4x1DAlrho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3mle9BwVYGjI8/KWbAyRHXC8xqlA8yERL+pbo6r19+CePPVWAyU/PgMGhkXY0mN0SB9v/hSWjAO/CN17QEJ2Zba0L1Fjwnz/fy8cTck6HhQ2ay5yIaVkFMaKDLnREJWbaVB5p+AidKkOBpQrx4SnNMGznuRA74WttBL+S9mkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVrsf1s1; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c02af5c068so145659e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708001575; x=1708606375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SezWjjSD6orUt3oayIngZPbAFgryKCchhK4x1DAlrho=;
        b=PVrsf1s1vyHpMZ2ZbEXc6bCgGaM1p+toYr72f+9wFAgFwgiel3tfAGqUCLDzMCY+ZL
         4kKRH0Xqt23b7UKYVARrAcIImRVvTzSp7NNLCp6hev6eTxgT2WnXlG/BWD/FVnf8bSp7
         BrlmDAF4Ai5pJAgLuDZwDbu2elgtSa+KWHl/xYtTWRepSovX2GNrgVjAAKdiiavtFASo
         mtZ4GMxDctL81N/hTQB/jsObbgi5knpWLglfXfn7hfbmVs+74WlteIXiBT63ey7a1zWD
         /A25KrH4A/8qcdpfPkUelG5caxllYSPIzxUwmsDGvunaMRiQUxZ2UUFktmaa5lAL+BVo
         W89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708001575; x=1708606375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SezWjjSD6orUt3oayIngZPbAFgryKCchhK4x1DAlrho=;
        b=CNZ/kKQ7Bv/GJxUNllyHpQZ5bxuqojP/uqubRdRVX1acXi0Aa0Qifgk0KzEYZn5iMa
         niU36aG7ZQgWJw7cUiHcii0AxShC/ai8ga+PXW5balOY/g95ymynp6/rsWvO5P7EJ+Z5
         RURBDrTSo3ibwjPFl+kQSVg/BH4lMw8EvvbQN3dhPDFByISuvqOBMYbH4pNEY+UjdrB1
         V88MRy6O6ZBQRFzLZ+PHZaoVVGhSkQeL49ILaUlS+5Ky1WeFBgjs8R/M7VtRbaot9nQ3
         rnq0TVRBWYDhkTOOeIUowA7hEcFVUd60ZrgeU2HEIV/mX/00PuCI7tMVtz2w78U1kT0V
         dyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvHNckXOB/SWjvmxgAqruhaNvaKTXjX9anGEf1sWt70+CIuACh8BxGPnMnEux46dVbQCiWwrqM2BRuc7p9gsz+E58vyubxceCKiWdH
X-Gm-Message-State: AOJu0YxIt5NMC4Qi3F4F8UYMFLm15pQMbfQQMxTTWNSW75GU/NCYpRfH
	URMqQheIr3Gz+dXOxrSeY1pHW9M8rv94tUWCen992SLwaNLrCRdi84Jyj1UuKYQEEjYdA3RM3u+
	yLPnNsbkxVFCxiTWEAWKU1OZstlIK4eLq9dUv
X-Google-Smtp-Source: AGHT+IFGg5ehmpRt1TzMWxKazEmhf4eseqGfVUyCWfT2BFzc97DdnDCICov8BtBGowVdPef+irHc7zDmAcs3IBnxstc=
X-Received: by 2002:a1f:e401:0:b0:4c0:305b:694e with SMTP id
 b1-20020a1fe401000000b004c0305b694emr1209911vkh.13.1708001574796; Thu, 15 Feb
 2024 04:52:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170157.17530-1-osalvador@suse.de> <20240214170157.17530-4-osalvador@suse.de>
 <08a08ea2-6764-48af-8883-84639c732ce5@suse.cz>
In-Reply-To: <08a08ea2-6764-48af-8883-84639c732ce5@suse.cz>
From: Marco Elver <elver@google.com>
Date: Thu, 15 Feb 2024 13:52:16 +0100
Message-ID: <CANpmjNNuZQi4dc2eDaCZASBaHz98Qd+1663_Qhwru_5ZBAmXjg@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] mm,page_owner: Maintain own list of stack_records structs
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 11:55, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/14/24 18:01, Oscar Salvador wrote:
> > page_owner needs to increment a stack_record refcount when a new allocation
> > occurs, and decrement it on a free operation.
> > In order to do that, we need to have a way to get a stack_record from a
> > handle.
> > Implement __stack_depot_get_stack_record() which just does that, and make
> > it public so page_owner can use it.
> >
> > Also, traversing all stackdepot buckets comes with its own complexity,
> > plus we would have to implement a way to mark only those stack_records
> > that were originated from page_owner, as those are the ones we are
> > interested in.
> > For that reason, page_owner maintains its own list of stack_records,
> > because traversing that list is faster than traversing all buckets
> > while keeping at the same time a low complexity.
> >
> > For now, add to stack_list only the stack_records of dummy_handle and
> > failure_handle, and set their refcount of 1.
> >
> > Further patches will add code to increment or decrement stack_records
> > count on allocation and free operation.
> >
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

+1

Reviewed-by: Marco Elver <elver@google.com>

