Return-Path: <linux-kernel+bounces-136015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA7989CEE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58632287262
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFE148FFB;
	Mon,  8 Apr 2024 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6lhfpFN"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98D53807
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618469; cv=none; b=T3d832FLW95Z4xbEcxXZzcqLyCKtBkiymi1Nfnnf4PcK+YKaSFqLguS1tbwjo1MHi6diqPmEwdzTHzQycHBZ3n2n5RM8OsaTjsbHOycPZNad+tWy9WJ/Z7IBIDNRbeIM46Gpkv1VarQDlOsh6S7M2jisr63TDFoBwKPRPwUdS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618469; c=relaxed/simple;
	bh=73NyjQ9jTspi4Vo9rs6GAoRJetcGTgtL2w4l+r6/bZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J2C+nIanvo7bOZP5iN87s2Dzu7jGu1fkZ+GKa7rHUjOvA44FlseUE0R3HNxpZRRGy01ivyR1vKRaE5731l/hEoj2+RNKDcuCk5mrFoeqBIj21+mPwG7fly+hR68+F/ndkvAPNTp5PgugtQGhAVt35X8VCv4uLKjy4WsUhCwOYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6lhfpFN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso7411501276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 16:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712618467; x=1713223267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAmUps3fqSSeTtMjZ2t2oR9+XDoNJRncj38VfyILVlI=;
        b=B6lhfpFNfaTPix50KSDohYB77ybojp6ehrgs0TbTbwPAIEUdSCl3WwmYBWRnh+3GF3
         OQoTXV+5EvwQasVWguVnaOfF0XzYMKFLkMsjy1Wbg7qOe6kDpRoi1s0xHKfYcznX0+CA
         TGpInonJXlKK9rNk790qJS9hn4BFARq1NTEsG72xfXMs1jkegG2gfrvWVYSPH+lVLLy5
         nrKnpRjQY9lp8KUGFvLPscyevc/LeOdeDYPj7KeEAJK4+JIgNRc1/Uw7VXwk97S69aqg
         G+9OB/XfkMTSACzx3KnnZpFLlbGxf9Qij71WFN7PFZ3gvdyLbQj5vNoSxjeo9DXMFVnx
         w7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618467; x=1713223267;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jAmUps3fqSSeTtMjZ2t2oR9+XDoNJRncj38VfyILVlI=;
        b=qhSsmKjzkAr0YY2X01A6j5huVI1HKFdqp7prd53bEezJdaiR8GDl2RFC1O1hV1KpiA
         HhQyzsqutBzaQuTT/zS7Jpx8xYBLBzgQdWztzpDxCy2gDpO0T7Iax3BFRF9ZcyAr6YyJ
         usq/5Wk7eJER8DpaKZhN0GmVkqBvHuv6FWAT7sUNt5Fyj1aFRMEJLSFRJArtKh5iJXbR
         EZ7RYIeOKCYvci9VLMLrvymOoCSxPmydr6PZLZ+TWzgYMTyyO5IYK4xpMPM0RUljKuF5
         H0G3px7GqF4lsBw/XbOIXAvVJtMfZw04jJ/vjukASMi0e84iS+u8J7S4Ozb9fWJVtJhx
         B4Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVHZ/KlQca8gi+wyygdP8YesiqAqWwRewljI3zMClSm1gmJMgN5b6WNV9HXNej9JeZvHFTzvc2kkzz6wPuC1mprTnz5qBR/Mrmy6Dl8
X-Gm-Message-State: AOJu0Yz0VgP1cWGLhBfSfX4AFSaYLfxf0OMMsCEoXaRbIcTwz+MGqcuj
	wvIi9jM6qSoY7N1XZOgje7n128cAM5eOXnbSQDuKsjpUU0VXmRxVLeatEBCNBF3ubOuSUWEG65A
	NtQ==
X-Google-Smtp-Source: AGHT+IFUcHjnvxedK+I4lyvh2pzfpl+jD4rB/VzNuFRZTn6oZ0X85k5RAJHtKIhy26MTuhSuNPdtYHWm0II=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1245:b0:dcc:f01f:65e1 with SMTP id
 t5-20020a056902124500b00dccf01f65e1mr3044891ybu.8.1712618466822; Mon, 08 Apr
 2024 16:21:06 -0700 (PDT)
Date: Mon, 8 Apr 2024 16:21:05 -0700
In-Reply-To: <ecaf87b40d6da2ca39a5eaf94d2efded2ae3368c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320001542.3203871-1-seanjc@google.com> <ecaf87b40d6da2ca39a5eaf94d2efded2ae3368c.camel@infradead.org>
Message-ID: <ZhR74WgWxO4MQcbl@google.com>
Subject: Re: [PATCH 0/3] KVM: Fix for a mostly benign gpc WARN
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+106a4f72b0474e1d1b33@syzkaller.appspotmail.com, 
	Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024, David Woodhouse wrote:
> On Tue, 2024-03-19 at 17:15 -0700, Sean Christopherson wrote:
> > Fix a bug found by syzkaller, thanks to a new WARN sanity check, where =
KVM
> > marks a gfn_to_pfn_cache as active without actually setting gpc->gpa or=
 any
> > other metadata.=C2=A0 On top, harden against _directly_ setting gpc->gp=
a to KVM's
> > magic INVALID_GPA, which would also fail the sanity check.
> >=20
> > Sean Christopherson (3):
> > =C2=A0 KVM: Add helpers to consolidate gfn_to_pfn_cache's page split ch=
eck
> > =C2=A0 KVM: Check validity of offset+length of gfn_to_pfn_cache prior t=
o
> > =C2=A0=C2=A0=C2=A0 activation
> > =C2=A0 KVM: Explicitly disallow activatating a gfn_to_pfn_cache with
> > =C2=A0=C2=A0=C2=A0 INVALID_GPA
>=20
> It looks like these conflict with
> https://lore.kernel.org/kvm/20240227115648.3104-9-dwmw2@infradead.org/
>=20
> Want to arrange them to come after it?

Very belated, yes.  Though by the time you read this, they should be in
kvm-x86/next.

