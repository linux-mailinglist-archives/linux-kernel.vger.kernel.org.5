Return-Path: <linux-kernel+bounces-149093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E068A8BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DAB281072
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CAC23758;
	Wed, 17 Apr 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZ8pHijh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EC1D52C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380396; cv=none; b=Tv3e4A8qMoaZ/5JfcnuTA+112laDhts59o+Zw9wS9EbLv5R3jo9Qtkn8dqJszqjR7rlpzlxkMlegUJNSziUJeLWgq8u/Re9xHWiiOSohjPiltEmItX39XszHKwlA7YfDpO97eNHaIE/F3CxSlstmpFT4xUje9rrvNGwcB/2jEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380396; c=relaxed/simple;
	bh=BA12yhIn/tlwN3KcWEpZllfM7GcJgrUEZA6BLeoXfDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fdb6jQcOxaTROEMgeO7MUDjn6KMGONZNwBDZr2BO/sGv0uWclA7ZIE0unnIoM/1jAXvGL27JqUYvkVdidthLFDxG7qM9zoruN3UpxUgD0BRorIfznzsGToZFk1OYqAWqjRyMa8WRgrLMf71tfAUhNmtunmSXmFjHCW7DaSsPfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZ8pHijh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so117549276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713380394; x=1713985194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQae4cfX4NaL9u9eCz9LjDnsnMH5rontKvZj0HGESGE=;
        b=UZ8pHijhXU2M5DY14KIDtG5azuS7dx2pir3DzjgH5unhra681YLeDNN2BWWXsb0MDO
         q98wBaE8iSe/WupeeLGpclW4xmPFk+d/jemXAYujISqKzMZORIjPHJlswz3q5HZnigEw
         kkHOvhREJP5oBeSAMA4K8bRylKCgB+jlrhDri9DKDGqlBydPmjuyAJcUo2Eb1Od7MahQ
         cjgJzuskOK1SUJNDvuPEqVdLNiepdohow1+w00fARTjaIGKClmoBZP0ORviLJ6wv2i0F
         IfmlTHPsDj/NdnBzQupJXzJSqyNV7/qVHocejKbMDWMTZMwiNWnvYhWQ+dZJXejDsrzH
         hKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713380394; x=1713985194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQae4cfX4NaL9u9eCz9LjDnsnMH5rontKvZj0HGESGE=;
        b=p7I6a3eLJj3qMdzd1oP4oXRYrwIOl39zPWvVjM7QwL0lof7vKdW3j9ZxyCFZ6iYBYO
         b7PfGoGdnDjJrlkygRPfdHmFSM8+vgkx9275b+AtGOOakKR4uEXc5m+OBAygYJCIyP/J
         Ir1ZNhMv8bME2v6wNPrlSp9ZwiMdYI+OJo8LLIFTFmG7I8e9edgWsqQhS7Y11/2gjmU6
         wyqtdvS3mlKdeUwsedBuxKS7W7ikhaSwTDSOkEYNtJGdQV5o/yvXJ9tRBz3/5lNm58TW
         maVAgCN3E8Oe79U97Pe/FSv2lPQULw5jimKWFIQSRqrxJLZkLkpMT7emUU+VJaheJlYi
         6oiA==
X-Forwarded-Encrypted: i=1; AJvYcCVBONh/BulAMVtNVMYrjbXtWofBDvU6Wc8eSnvSxcKucaCzYwCZnBeLzoFjw7YI0W2Rr7EQnc8BB9MpvFmFYzGY4Vdq4jKzDworb55y
X-Gm-Message-State: AOJu0YxU88g5oe51p0sIUvOnTsPWTtCrJwv0yIAvP3oDTKyo5xR/t8tq
	hjiW2+0SSju/0wEuX6SDwYCxMBfCGCCeN0ksR6oN4XkPMjZSj04Dk6mBvDQqiYPfX1j1EsdAPwv
	0Ow==
X-Google-Smtp-Source: AGHT+IGLW2W1pTs3wPgozteR9glPETjOgHDdfcxzf86ViF2A3bPyNslXaVI1lvNh87ZSztdrKiw/9LObPqo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c711:0:b0:dda:d7cf:5c2c with SMTP id
 w17-20020a25c711000000b00ddad7cf5c2cmr22957ybe.13.1713380394327; Wed, 17 Apr
 2024 11:59:54 -0700 (PDT)
Date: Wed, 17 Apr 2024 11:59:52 -0700
In-Reply-To: <20240416211941.9369-31-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416211941.9369-1-tony.luck@intel.com> <20240416211941.9369-31-tony.luck@intel.com>
Message-ID: <ZiAcKKX_L2MNOF_n@google.com>
Subject: Re: [PATCH v3 30/74] x86/cpu/vfm: Update arch/x86/kvm/pmu.c
From: Sean Christopherson <seanjc@google.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

For the scope, please use:

   KVM: x86/pmu:

On Tue, Apr 16, 2024, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

