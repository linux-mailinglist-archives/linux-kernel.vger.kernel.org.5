Return-Path: <linux-kernel+bounces-130257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE51897607
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5431F23883
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3879915253C;
	Wed,  3 Apr 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qu28Gqe/"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943D152521
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164415; cv=none; b=DkVSV8OKU3YYDqMX9YrePdRXBFwOnbX7l/9TMYEf1TqjzCHJiSe208IcqmYixWjTAfDzcDmoTL4sDQRUWsOn3DceWEZXbZ565obYPWxGDAR2x3Gzz8OsODl78wWNFtVrYVJW/0GlmEXhPY3xuVvd6ZT9kjUuS93x2iW8fHYlUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164415; c=relaxed/simple;
	bh=ATkEd5SFVajpuoZ2rqVnvccmk3MpJlIfcLl6fpKsCsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iF7goRcWU9Lca28Mfotojc1vdwsLOd2Ki+o3TWyHOLoquwsUk7k+ae1LcWt/6+FIngcTmY0H7HApnGmEY4HAXY1ToF15P9oVRy33tXPj8rp/sDppO5yO+wuIb60SLtzdeIYuFz282T6iewsQhd95GhjLs/TIetbwMfAxStfCWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qu28Gqe/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516c403cc46so152211e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712164411; x=1712769211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1h8tWfpp+qoRNsUGmPIOTJfrPR4EipvLdehDBLGG8i4=;
        b=Qu28Gqe/qV2lMqxfGt7VyaDiMDck2eIswRVZwU3jf2zlOubuClbSMa6XxR/3t/Rtcn
         wMGBsFsyrCvy8AAF/FF/gI4/PTQJbkbp9BqbXthbrgMsMJc7EyhdBb48GRju8r4zaa7D
         40XauIHXHOrwRMYyg8ny9Dz/IqDVAcXStv5wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164411; x=1712769211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1h8tWfpp+qoRNsUGmPIOTJfrPR4EipvLdehDBLGG8i4=;
        b=HhHChCERekf37xYhQ0vRNz9yUHaIiSghiVjubsxDrviN4DFBElFPmJktwSLhT0+lcg
         ASUrcF3v0WTCbQBexECB7wo9RyYIwTZFKrlWw6AheOZZTffrq4ka5gl1axgwiciBMIYq
         859cNf3Th5vXEMktJ6xNCziQKd3XHJnetJMbi8XCPAbZzrhpYW7E7+Z5uj4acOHGzhD/
         x3LvbE7DnsMwCgUsdxDxRvbXqk2/3pdLoaZcJJzKN4fMge33WijVLeAusE7kjRplxjud
         3v2BYPUKRRQC1V72IJvwF1GYV+BzbQJP1Z3paHF/0AIINjbZjbYHcUqZzjaaryzluan8
         OyIw==
X-Forwarded-Encrypted: i=1; AJvYcCV7s9doRWtIrxY/14AKO6HyyAuve7vBkjWYv69DkkBVplH/ATSA8k7mCv4SmCO9JDro4xX3da+ja1t9ZP2NQIG6Y3wTze/IPMlM7RRy
X-Gm-Message-State: AOJu0YyLjkAkjHqtGFV9W/+L4dWrM6bxOMiIos1dVgd7kGQhPsplIRJs
	NsjO3d+3JLwPioHpF29jt6dFttXkHS+krJg9qEwQSgY4qzGp0t9NRTEXLevDsz69bvPq41UGk1g
	c8gqznQ==
X-Google-Smtp-Source: AGHT+IH5ULaQgikbBB3iS4+hTaY53SODh0KALXeaa8kK+GbVRLjP9pBQLDsGkY4ranFpRs1defpPbg==
X-Received: by 2002:a19:8c5d:0:b0:516:a4f1:d01a with SMTP id i29-20020a198c5d000000b00516a4f1d01amr93482lfj.53.1712164411561;
        Wed, 03 Apr 2024 10:13:31 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q27-20020a19431b000000b005139c3c584bsm2094955lfa.241.2024.04.03.10.13.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 10:13:31 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516c403cc46so152136e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:13:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqFkj5lqfTlr99VUpt23f0LFBgq+R/11zBJjztfEWlrYi+TwdsQWwe+0QRld46YxqEQeDB7EIyMu3eWdUQmKOyLqzVYChm8RrGQ/z8
X-Received: by 2002:ac2:551c:0:b0:515:acda:77f0 with SMTP id
 j28-20020ac2551c000000b00515acda77f0mr110424lfk.29.1712164410669; Wed, 03 Apr
 2024 10:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404020901.da75a60f-oliver.sang@intel.com> <20240403122350.GEZg1KVvsyc-Z3bwro@fat_crate.local>
 <CAHk-=wj+Q_LXV0Y5+kBvv-5sTxT3Y7E=8wJ2sX4vzWksd3LWzA@mail.gmail.com> <20240403170534.GHZg2MXmwFRv-x8usY@fat_crate.local>
In-Reply-To: <20240403170534.GHZg2MXmwFRv-x8usY@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Apr 2024 10:13:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjernNvgonRC-W=_OF116facZf--vaYZ+QUnOkXm99M9Q@mail.gmail.com>
Message-ID: <CAHk-=wjernNvgonRC-W=_OF116facZf--vaYZ+QUnOkXm99M9Q@mail.gmail.com>
Subject: Re: [PATCH] x86/retpoline: Fix a missing return thunk warning (was:
 Re: [linus:master] [x86/bugs] 4535e1a417: WARNING:at_arch/x86/kernel/alternative.c:#apply_returns)
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 10:05, Borislav Petkov <bp@alien8.de> wrote:
>
> Can you pls replace it with the below one?

Ok, done.

              Linus

