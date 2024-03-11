Return-Path: <linux-kernel+bounces-99672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF80878B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14315B2113F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B359167;
	Mon, 11 Mar 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnVt4pYb"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF1858AAC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200671; cv=none; b=YJpdRE0muslCYbhLc+NdR8AWhNiBrAKscSX41rFSfcYTwiOa9bZeLMuOrDKfaluBe83TooKzEWB/gci9lnJyf793ysr6eAiM7s8/ITLJO1fsaX2trXAUNZSNbXSt4FjE+nyZ1VQLr7vgF7obwmXBYBxbGlcT8Wu/9RDnYg9OG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200671; c=relaxed/simple;
	bh=/7zACagJjW7/k71pULrkC1Ljk59pppVzE1FxfoB0cVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pvayO4FAEK0gumog0152k5RkZpJr7inSUueSjpHnNxHDqX+DONs47gR7x1MuXn20bzhe+Oy+ey50cRdpa2OAoTOyOdco/TUm9KqtxzTGNxtLJ9E5nCHJWdsv+olGRUf+FnpgSD3K98w5cU38VQkZM677jVchAcE3xWCBqTPtldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FnVt4pYb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e6999fd41cso934971b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710200669; x=1710805469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMI4Pmv/naxvAfPYroNwqy3j1VzI27ffy6ugcYk0ZHg=;
        b=FnVt4pYb+2ELmWlUZ2Btw+0s2z+jVvroV4la/FOeKlT3vcKGCvB8K29okF9XvJ9TrG
         DfQ1X2m/xkz4YM0RnHakZoYcTX7ifeo7N3282wLCtfNZxx1tgniZGSB3PUSx7427UmVc
         RBHDERpvfk+c/xyhXi8rPNIW1WexLujwdE548u1onHqo6KZP31wxe2V29sKY8MkCEHYG
         aYvV8Gzj3UvglQv4BNqIJJxa+oj4w5bqqNa1OrXNqTXdewWrrb6UBfHoqN0QOhW7HgZh
         e2XNze2iWRgI1K2aW6iXo4AWoTvi6ZJ89dds8eFPdaSACC35FNwJ+lN8JESP6PZEgBmk
         Zhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710200669; x=1710805469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMI4Pmv/naxvAfPYroNwqy3j1VzI27ffy6ugcYk0ZHg=;
        b=cTyXKzsQ5pr6+X8T7P8ZzcIzPAQDx67x294tZ87lW/g64ixF7yr8+OX2S2jjGEEyKh
         K/41XE6sT6J5sqSagqDIGCLudb/jpth6VyZ9DtO/UvLLlVVk44HbWuuwJoEnk+L4ELM3
         LSph+xm9TeI36ENlvxpXAqPMghhLIkHI2O9335uASj5ohlhT0UeL+FionlbAF22k+eu2
         EclkZpta7BWDI6TuTIsbi28tPSiDBCWG+BIRfx1QL9mLLdlG/vr3xoB/GOa8o0n4w7Bl
         rbVAkXuoGO/FRbIL64co69UmUp1oneNGBMAWW/j0dV3ae8rzbcR99VtDkg9O7EZ3YEP1
         EPgw==
X-Forwarded-Encrypted: i=1; AJvYcCU6yPmnJo7Rp/q/ExNj3mV0MCZ6jxlLqPMEBCC5SbXGL0DmY1kH5H/G1dUF8RYtiYSooatsD+dhm794DwqCXbYjK2TjjPdRrMCT2e62
X-Gm-Message-State: AOJu0YzalZ3M6eaF+iN9V5ZvhZEuEaEm4Gw+mEyYSJFqxpXyBBLyzrqq
	JFrUcTTaT0wVKbWl07Kvo1+MBbMnqAkzLKinIjjZ5hTkwrkpr77u7P1FRNpaMILR5p+5gSZhqvP
	hgQ==
X-Google-Smtp-Source: AGHT+IE9YQgFrlRUqic5Eu0BhIJVUHsFx32+jIiT3xQh1aWbzRN3MucQw3uy7SAgNL6CyAqfvrWvMB5g/1M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2291:b0:6e5:94b0:68be with SMTP id
 f17-20020a056a00229100b006e594b068bemr695709pfe.2.1710200668905; Mon, 11 Mar
 2024 16:44:28 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:44:27 -0700
In-Reply-To: <20240311032051.prixfnqgbsohns2e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1709288671.git.isaku.yamahata@intel.com> <20240311032051.prixfnqgbsohns2e@amd.com>
Message-ID: <Ze-XW-EbT9vXaagC@google.com>
Subject: Re: [RFC PATCH 0/8] KVM: Prepopulate guest memory API
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: isaku.yamahata@intel.com, kvm@vger.kernel.org, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Federico Parola <federico.parola@polito.it>
Content-Type: text/plain; charset="us-ascii"

On Sun, Mar 10, 2024, Michael Roth wrote:
> On Fri, Mar 01, 2024 at 09:28:42AM -0800, isaku.yamahata@intel.com wrote:
> >   struct kvm_sev_launch_update_data {
> >         __u64 uaddr;
> >         __u32 len;
> >   };
> > 
> > - TDX and measurement
> >   The TDX correspondence is TDH.MEM.PAGE.ADD and TDH.MR.EXTEND.  TDH.MEM.EXTEND
> >   extends its measurement by the page contents.
> >   Option 1. Add an additional flag like KVM_MEMORY_MAPPING_FLAG_EXTEND to issue
> >             TDH.MEM.EXTEND
> >   Option 2. Don't handle extend. Let TDX vendor specific API
> >             KVM_EMMORY_ENCRYPT_OP to handle it with the subcommand like
> >             KVM_TDX_EXTEND_MEMORY.
> 
> For SNP this happens unconditionally via SNP_LAUNCH_UPDATE, and with some
> additional measurements via SNP_LAUNCH_FINISH, and down the road when live
> migration support is added that flow will be a bit different. So
> personally I think it's better to leave separate for now.

+1.  The only reason to do EXTEND at the same time as PAGE.ADD would be to
optimize setups that want the measurement to be extended with the contents of a
page immediately after the measurement is extended with the mapping metadata for
said page.  And AFAIK, the only reason to prefer that approach is for backwards
compatibility, which is not a concern for KVM.  I suppose maaaybe some memory
locality performance benefits, but that seems like a stretch.

<time passes>

And I think this whole conversation is moot, because I don't think there's a need
to do PAGE.ADD during KVM_MAP_MEMORY[*].  If KVM_MAP_MEMORY does only the SEPT.ADD
side of things, then both @source (PAGE.ADD) and the EXTEND flag go away.

> But I'd be hesitant to bake more requirements into this pre-mapping
> interface, it feels like we're already overloading it as is.

Agreed.  After being able to think more about this ioctl(), I think KVM_MAP_MEMORY
should be as "pure" of a mapping operation as we can make it.  It'd be a little
weird that using KVM_MAP_MEMORY is required for TDX VMs, but not other VMs.  But
that's really just a reflection of S-EPT, so it's arguably not even a bad thing.

[*] https://lore.kernel.org/all/Ze-TJh0BBOWm9spT@google.com

