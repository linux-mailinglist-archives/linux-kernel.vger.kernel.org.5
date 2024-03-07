Return-Path: <linux-kernel+bounces-94797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B9874557
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377A8B23AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EDA5667;
	Thu,  7 Mar 2024 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtcZ+CDC"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4704689
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772828; cv=none; b=UpqK1QnZnfy88x1PdSuBDe0ixG/K2WFycrom244Iwop7GOu4TzvKIAPB2/WAjWdgApJXYUzzADdcFDBzxzyXhKH9aqW/0a5i84CYM3f9NdYE6ECHCl4hOA5IEfMQ4Z0bkA8mHUjobIqRCXlIy4o0UnVXmu7lu+kZMXOBp+zeOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772828; c=relaxed/simple;
	bh=kL//jgPDiFCIqsbXAwIf6piqMB/VEIeEGVOQr6c+ZM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAEsgUbhaS7pMyOJhrIB/9XVl6MwcQYOvBcwGgY+ONq6oIzsJx+BdaeMmf90p1JrbNE6D2tXhAOzqGhsQ4qZPpKxkxx+tU9ZRT34wrXW4Wh1rIYK3cXkcgHLra3rgnrOr+4y9z3A9Mq3iGR/dF0h9KRbap52mZx86ySOdq/HfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtcZ+CDC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e649a2548cso324776b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709772826; x=1710377626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTftWjXZw94q4+F4f8emI0lnL+iz/nWWwkVmzB+hhvg=;
        b=TtcZ+CDCKB1Vx+33z3GuAGYZCgGj59wyGBC82V6x4qn7ROFFNPTs1N7BIatU97Kkjf
         DLvisLUDt/ahDaOs0if6mBGQf/l9u1NirKnivUyjIg1uDCT0ujqGoL/lF6zQf510/LSH
         Ii26hgHk7X8iPgbUS35oNF+vbcbDZOTDnSOZvfFUC9x4/ZHTv8Li0k13YTRr8WjKQp0g
         VoySSAS60qGVnwJR4CBt+eXOZyi5Pla55k6CT5vpsrIhs7YgFbeXu/aZ6n0xAXpRAdsU
         MceSh767nr9kpR5ADVk9Ksh8KAQKLwkDOjivoF4++LJKlzNoTxLVGGDBGG0qkRa3Cwv0
         4lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709772826; x=1710377626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTftWjXZw94q4+F4f8emI0lnL+iz/nWWwkVmzB+hhvg=;
        b=Mk9L+8EGcwWtWe36QYg20P1Jjj6bYLBvn9PNTpw5STU7regJtHPEKcf5YjQUHyFv20
         wTVmUNCqS1kLl/tT22Mb7Si9g9ZP7ZEogySMzqelbqfFfX35swR2rUSYg63bM7HTPRRM
         z2+Mnvu2acpiW3ilKshhTn9ukffX3XzqgJao7tTR5qBszNpsusLv3W2lIcEyTpcvHd+5
         je8LNvgITvgKA4B6cnNEdfx8PaA+EsXd8nAA0m9bXtjkv54dsf/2QVk48NqUZcI6/Oqm
         /UbZNS4tYendews+mLuS63jtawEN6j8M3aSA+mmQ2FU0bkfzpmSIDMVeMR+SSjttWVD5
         RVqA==
X-Forwarded-Encrypted: i=1; AJvYcCX0FFqdXUmfpfU0CbC119VVGSpnKOVcyuVAs9Lk5SCS2j4iODk/G1Rl+xTBGCoHe9NdU2kK3cYR6k7ag4K5t7IYpWURt/yhlay7p/GS
X-Gm-Message-State: AOJu0YzXvMSJ9yR1mVTJDYTQBtnweZboyP2fYlY46g5QVAOr+HCORBE1
	n1Peu1J8eVs0vJ98/mCfH1PKwYoEomI50R4T2LOVlQhfP1ykajtajTGWfjkeAw==
X-Google-Smtp-Source: AGHT+IGAn1fdYlbImKRNZc/GrCx7mEmPc71V+M4i5UOui2PzT3x/GBReTpx2caiH9qy7SvCNMsgKBQ==
X-Received: by 2002:a05:6a20:1a90:b0:1a1:44f9:cbf3 with SMTP id ci16-20020a056a201a9000b001a144f9cbf3mr5188857pzb.57.1709772825580;
        Wed, 06 Mar 2024 16:53:45 -0800 (PST)
Received: from google.com (61.139.125.34.bc.googleusercontent.com. [34.125.139.61])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001dcf91da5c8sm9398420plx.95.2024.03.06.16.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:53:45 -0800 (PST)
Date: Wed, 6 Mar 2024 16:53:41 -0800
From: David Matlack <dmatlack@google.com>
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, isaku.yamahata@gmail.com,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Federico Parola <federico.parola@polito.it>
Subject: Re: [RFC PATCH 0/8] KVM: Prepopulate guest memory API
Message-ID: <ZekQFdPlU7RDVt-B@google.com>
References: <cover.1709288671.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709288671.git.isaku.yamahata@intel.com>

On 2024-03-01 09:28 AM, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Implementation:
> - x86 KVM MMU
>   In x86 KVM MMU, I chose to use kvm_mmu_do_page_fault().  It's not confined to
>   KVM TDP MMU.  We can restrict it to KVM TDP MMU and introduce an optimized
>   version.

Restricting to TDP MMU seems like a good idea. But I'm not quite sure
how to reliably do that from a vCPU context. Checking for TDP being
enabled is easy, but what if the vCPU is in guest-mode?

Perhaps we can just return an error out to userspace if the vCPU is in
guest-mode or TDP is disabled, and make it userspace's problem to do
memory mapping before loading any vCPU state.

