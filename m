Return-Path: <linux-kernel+bounces-54087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2804684AA8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5ABE28E970
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666DD4D5A3;
	Mon,  5 Feb 2024 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNmS9UIn"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404D4D108
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175933; cv=none; b=q8ahF2Pw+LnRwVURGVFyjdWZVEL5fPSegp7IV4KYtSR+cJw9RPNOR6mTA/wfJPrBGaaQKH91FK+weLogdmtqqGKmuoRMhPxOMavipjJ2gnXuhmd5/MG7gY5YOtEel8P2Xc/GD56zDFjIWa6vFjBp8TlUl2oObfvslAj1HlnQ1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175933; c=relaxed/simple;
	bh=s+ba7UNNd4l6rcm9bL2S4lJrdSzTfcoNEa8bBjhT/34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XmPzTXiDd0eMoz4mhhMVKJbrSyVudBdxDeLdC4AIbL73X0H5lON8TOwGsElwyGfFNndAX294aUWJtN+YJsih+LT1FxogownEK4YA5PoLx8iF+fqjU9zBUI27u9erPp4hr46L2eSpjFroCwQ/IAbXdjIkgnOlEbngtdp57tiLdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNmS9UIn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d97833a289so50124955ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 15:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707175931; x=1707780731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2aHiF8WGptYmPz5iXMzHQodsCytVgYePbufYEivoKF8=;
        b=kNmS9UInZkwugRVXONpUYeITMI4z3nrzSxamF86GfTXtLfNhYMSmLPPE1IKCe4SvHq
         BIfHRve3tefFQABD5eFXLhZiPtS2UMOyjyk0a3bgFz2TByNSrDPdYY4Ym3v8KEt8R/+y
         gvXNtHB58VhcYtqFlQNZyoaFlE+7SRw6hfe4rAemkEsimDkNjjuc0N9jZQ9BmEcTzRhJ
         yYgVMZPXfHcc5zY2JJBxqf1KkGaazjaLMcS+9//UK/saoikd2um9vUEOVexSIcmEAav3
         cthMEAqezixR2rAgFKf3KaDo2zgc4O3cbhQXa0cn6yJHZ7Wv+uVHmNdrmhmiUgOpD47x
         c5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707175931; x=1707780731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aHiF8WGptYmPz5iXMzHQodsCytVgYePbufYEivoKF8=;
        b=pGEykwtQ8SfD+csZn6Vengrx6o3gYc0qBPYwIvgKre8hhiuBrpaZl7OQGHc91B+VwF
         o8K1FbDOmkJ3iQvDA26BdmUS5px+xNJzUymtzScfkbOqjVqN0FMZD6tpGXLpDv/z1pM9
         ChWpX0pHB4/KqDRy5DItaWbb6BvDKnHQt5Oy36nqJgS3x/rvj/LsLyoFNnZ8+B6Ybjf/
         rkh4Rcsp6eLNg81FudGxiFLeyCSY70yVxcGzQ7Er1N3q86S2Wzp3a38gmxqbij8K+qKN
         yeiZcpDe1Wpu//cOZj78KNKxp3vRewBgxqzVtQIukQpOyvOSnZf4nL4eLMgZzfk1gOix
         kirA==
X-Gm-Message-State: AOJu0Yxm7i+IteZ6cyOdBTAul55xS7l9u//u5jWPMJYKcZfNLfXypGb/
	gTFGVsz+DPHtNym9/JOF+naF9yK7b97S3koMU0e66spPTAjecrU32T9LWVuiE953e3LGklt9GMb
	U5A==
X-Google-Smtp-Source: AGHT+IF9pQzmD6LV2uQvxz4V7wiPEQ0CxqP6mZJtdq5EHg/fzbnEEZKqUoflqGDmgX/A+FwqUkK4tjTOOUk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2452:b0:1d9:68ae:b650 with SMTP id
 l18-20020a170903245200b001d968aeb650mr2496pls.12.1707175931486; Mon, 05 Feb
 2024 15:32:11 -0800 (PST)
Date: Mon, 5 Feb 2024 15:32:09 -0800
In-Reply-To: <Zb69ryhz_mDw9UK4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234603.366925-1-seanjc@google.com> <Zb69ryhz_mDw9UK4@linux.dev>
Message-ID: <ZcFv-cYtQghiz2JK@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix GUEST_PRINTF() format warnings in ARM code
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 03, 2024, Oliver Upton wrote:
> On Fri, Feb 02, 2024 at 03:46:03PM -0800, Sean Christopherson wrote:
> > Fix a pile of -Wformat warnings in the KVM ARM selftests code, almost all
> > of which are benign "long" versus "long long" issues (selftests are 64-bit
> > only, and the guest printf code treats "ll" the same as "l").  The code
> > itself isn't problematic, but the warnings make it impossible to build ARM
> > selftests with -Werror, which does detect real issues from time to time.
> > 
> > Opportunistically have GUEST_ASSERT_BITMAP_REG() interpret set_expected,
> > which is a bool, as an unsigned decimal value, i.e. have it print '0' or
> > '1' instead of '0x0' or '0x1'.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> This all looks good to me. Just want to confirm before applying: you're
> not planning any other patches that'll go through your tree that depend
> on this right?

Correct.  There's one patch in kvm-x86/selftests (see below) that touches some
of the same files, but unless I had a bad -ENOCOFFEE on Friday, there are no conflicts.

[2/5] KVM: selftests: aarch64: Remove redundant newlines
      https://github.com/kvm-x86/linux/commit/95be17e4008b

