Return-Path: <linux-kernel+bounces-12854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB381FB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58944286236
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE710946;
	Thu, 28 Dec 2023 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnvejs/o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6810945
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3fde109f2so699785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703796211; x=1704401011; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuWAr1LFb8yGIvyDQdiCDLS5Dz8Fcnn8SIF/MmaVoyg=;
        b=gnvejs/olSjGy+na+x6pqFaUa8/NLWjNpQY2Kpi1rGnfJYEPx0//antibQqjCAQV+6
         YkArQg6on6gEAU9VQ4NX3Tvk+ROHjaGThGe6z4XeNtJJ+4VrtTESFBXIKopE6+BuuuF6
         17Og91zRHyoKSpTZP1MTISTv0Twrglnal9kqTbQkyiK08bkc1aAoNhmll+JyycPVvikF
         c1GN0bcZMsAq5nb+dT8GzT+E0ykn22fIygzvuY1wII0sdQu2v+DVwrDPxm9u875F9i/E
         LnMbb5qGPloN81bR4JEXDrsrlwFGAN855MzINUfAQzrvQUBPoxJ07exiMzZA4MvExRBB
         zY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703796211; x=1704401011;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuWAr1LFb8yGIvyDQdiCDLS5Dz8Fcnn8SIF/MmaVoyg=;
        b=h/XJjdhqX6KnqNM0GEdiNT7fhhDBU3YpTEg9LeaGbV7MDQdokwkmGqaKBrU0XgcRZr
         WheXN2790kCQJTLWR+5Eea1caIhf7bp9cPfdv9Bwbkag5CzFcIvzCpE0bIVFYxYAqdnt
         PYwr902dFIhnOM+3Ak78egpQIRELoZwYUBeWnoprtxc+f49qsRFFolSWZoW/I2ZtgUaM
         D+sbeJWk6//cYOeF6H6AYib3aTaRNB7cQtHHU7htmR6Kxe+nxaQJVmmuqQtGstXaU0Vq
         lmuU1X3pvCvLJ34/WTkG7UqWI+ZqN12fuOrPlH1bCK6x+VvYoK2kWKkpvI9q/kb85+MK
         l0bQ==
X-Gm-Message-State: AOJu0Yw4DOT0C7ZCJ8ng2fv4djAN/RleEm6hk6MSryEnv/QNrfhpZnsj
	H3CBF1JMDZa68PZNvVmKJqTYrUtliFxO
X-Google-Smtp-Source: AGHT+IE9NYwxoWhXKOvsAaJeVvsMfZ5eSVNTx5QbyFf9LmfqhNBxrOnZWJtiCrJ++mVStkr/lkXTjA==
X-Received: by 2002:a17:903:2094:b0:1d3:fd5c:4d63 with SMTP id d20-20020a170903209400b001d3fd5c4d63mr729722plc.1.1703796211447;
        Thu, 28 Dec 2023 12:43:31 -0800 (PST)
Received: from [2620:0:1008:15:5eb6:dfb2:ff4b:8b64] ([2620:0:1008:15:5eb6:dfb2:ff4b:8b64])
        by smtp.gmail.com with ESMTPSA id w2-20020a654102000000b005c21c23180bsm11305956pgp.76.2023.12.28.12.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:43:30 -0800 (PST)
Date: Thu, 28 Dec 2023 12:43:30 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
    surenb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    souravpanda@google.com
Subject: Re: Sysfs one-value-per-file (was Re: [PATCH] vmstat: don't auto
 expand the sysfs files)
In-Reply-To: <CA+CK2bAARPNHwZB9tkd6miKr8GWrZ_L6h1oiUM0qWu6pJqh3Wg@mail.gmail.com>
Message-ID: <c2b73ac2-c271-d11c-6d06-3e0ab74a29a6@google.com>
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com> <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com> <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com> <b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com>
 <CA+CK2bBxbvO-osm5XKk4VkaXYgfZXkDAtfayaYJ-vXo=QFqGPA@mail.gmail.com> <13e5fbd4-d84d-faba-47f1-d0024d2c572d@google.com> <20231227104244.824b0977ae6d4bb6b37f6f79@linux-foundation.org> <CA+CK2bAARPNHwZB9tkd6miKr8GWrZ_L6h1oiUM0qWu6pJqh3Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 28 Dec 2023, Pasha Tatashin wrote:

> > > But for existing files and conventions, I think we should settle it as
> > > "keep doing what you've been doing for 13+ years" and don't force this
> > > argument every time a kernel developer wants to just add one more stat.
> >
> > Absolutely.  Let's do what makes most sense.  For new things, one value
> > per file.  For stats which logically group with other existing stats,
> > do whatever the existing other stats are currently doing.
> 
> The intent of "[PATCH] vmstat: don't auto expand the sysfs files" is
> to do exactly this: keep the current fields in
> /sys/devices/system/node/node*/vmstat as-is, but prevent future fields
> added to node_stat, numa_stat, zone_stat from showing in vmstat.
> 

This is the opposite of what Andrew and I wrote above.  There should be no 
need to start preventing future stats from being grouped together in 
vmstat if it logically makes sense.

NAK.

