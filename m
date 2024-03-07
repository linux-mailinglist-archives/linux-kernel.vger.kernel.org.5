Return-Path: <linux-kernel+bounces-96034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9030B87565C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B380D1C21427
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EEE1353F9;
	Thu,  7 Mar 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCeIizCg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE612EBE1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837394; cv=none; b=q5TXDcnnAcJ/AQeLCm5vHYfRvaa9TzCkprK2ZKMLjKr9fjYFhkS1UM5K77f9vfFSsJUkZpof78l/0sEqdQAG/1i2Qje2MJ+Kg4RVqR9HoSMdtm68mTb51+IWl/CewLVwP2OaNGj+pbVB9RAEHhyDv5+ly3xCYG1gjxP+fPl6bx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837394; c=relaxed/simple;
	bh=EuRKz95FN9SGdKbWnl15zhSg+qJASOtPXYNCLbcleBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tWVVQVzsdPR5mhNUh3bXzh7+2/8iNuJkaWHAj2pYcluUTgcNrWAHlxSz1I/1NQCuMLL1lT3bx3LJg6AZswtodlh5r398W9Dl2P6v1aQjTdl/IgE6Q576fyyN5sgZ9IB7cI1udTSTg5GzRvyqiSTSv1AI1pPD14R/qd4LBS38TtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCeIizCg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609ff3206c3so6712077b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709837392; x=1710442192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LevaRXpRhYVuTMqknpJsS+gS66i4K+WZCh05fcEc6jU=;
        b=nCeIizCg6mmkCDtZd3KK6bBxUyyiQ8CJ9U3UTOV8wJuN+fZz014ENUV+G4Fk2csANQ
         /UimazSfioOI8ipFdqmToBR7tcZhcNgOvg4BKO2gRioZ+z0uAL8K/1l/OHnKb3UfZTip
         fzqBjC8xcHxDIN6g3fFsaB1AlekYQzbKr7fNpiwLDojbKn3YAfqMNxg9UPNWluQAwlBu
         kTcZDG623UC/O7P1tD7bIqDQq3NHglWQYrkywN2/Fm4g1/KiqEStDmO+nh1ImdhGKKig
         rvmaUuR5g97RmwNJ5UWHGhVmB6w+ePIHVy8f/6lqL8t+Zm+JQ7JGlYvGS18NJ04wYziI
         52AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837392; x=1710442192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LevaRXpRhYVuTMqknpJsS+gS66i4K+WZCh05fcEc6jU=;
        b=oq0L+X934TtU82EdJgkzKyrjsgUXss4iqMQv1nnAw3R8n1D8HDa7dqRX/DmT6iC1vp
         E4MTG9wvjfN7jTlHV5c99fwI4U4XXYtW5uumGzArBtGzmQ/dXx5BKTuV1TPzRNsZVrXb
         pJjTBwb+8BFL5MOX7tfBmR56eD6OhIOKQUrKEcvIdxNN9nADGZiYJSzr2lNbeUh6SWrQ
         mVdEezPA49pcEhg1K9oU3OwVHvbHnnMFS1R9nEazv0Fj+m2qhi4cn4rsxyTpvbdWI+lC
         VIpyfcWCQ0ozYcZ6uvSvu0/rDW7vdqwA5H8p6otourxJ96h4MAWHWdj1AN0i1HKLRAz3
         TcwA==
X-Forwarded-Encrypted: i=1; AJvYcCXTuZnzp2syckZGcf4sQWiup2Ezr8laGrtdnKvDspx0/pVOvfMitiuJmzS/IBw3nH9bhl2h2NBdww7xAdpENAG+c5e+CmNo06Oup2qT
X-Gm-Message-State: AOJu0YzYFqyl+sN5dlxncIroMSxBrvSaN9TnfCYgP89eHCaCB8dvF9Sr
	lBO0EoSsAByUUgpWo1dgw8cvrRPSeUiESxRpQsANrrzw19g1t6vn+jUnz+yT7VUsJA4oSC6XrL8
	5BA==
X-Google-Smtp-Source: AGHT+IE38wSN0tjfjKpTr9DE9hMPFhb5WiVeLmcVoWFCybyDcOix0t7yjy2LlxL9TMTgVyLLgO1wcy3VuOI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:fce:b0:608:72fe:b8a1 with SMTP id
 dg14-20020a05690c0fce00b0060872feb8a1mr5696668ywb.4.1709837392441; Thu, 07
 Mar 2024 10:49:52 -0800 (PST)
Date: Thu, 7 Mar 2024 10:49:51 -0800
In-Reply-To: <ba8a51fe-7b22-46b1-be5f-1e4c837d085c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-2-yosryahmed@google.com> <ba8a51fe-7b22-46b1-be5f-1e4c837d085c@intel.com>
Message-ID: <ZeoMTzNSyZ1ValBb@google.com>
Subject: Re: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during
 context switch
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024, Dave Hansen wrote:
> I know we all have different rules, but any time you could spend absorbing:
> 
> 	https://www.kernel.org/doc/html/next/process/maintainer-tip.html
> 
> would be appreciated, especially:
> 
> > The condensed patch description in the subject line should start with
> > a uppercase letter and should be written in imperative tone.

And while you're at it,

  https://www.kernel.org/doc/html/next/process/maintainer-kvm-x86.html

which my crystal ball says will be helpful in your future. ;-)

