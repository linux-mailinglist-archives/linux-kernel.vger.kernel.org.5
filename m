Return-Path: <linux-kernel+bounces-128815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA6895FE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1596328314F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06941C7F;
	Tue,  2 Apr 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSNIr3iH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D12942D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099222; cv=none; b=djfc6Qqz36nEPZZRpY1/mIbM/NoqeHRNeaUhAosO32iwTQu5lni3FnI0udmqQn3HdJqaOQ9hAHNGEc4goihIjNdx3bF4HopQHkTM5v257tG062CfTCbB0LPzdu8zqgVZjMiviEqdWmEUsMF+fxjJNxBIb4ZLb9wuMRumica9ykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099222; c=relaxed/simple;
	bh=C+ij29dRhrqI5jcxTxsDaSlvXKcifI5OQZdLLtJKNdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ua6H/cxU0K5e+IL2151Nps+svApdDBVblaod8rtvEV8TAsMFV8/IK1nnSec5FQW683n1NDoJh9KujKdPHNKGGb0Loy2Aq28JjWBKHv95AZhQI2la0SKBIawNKKiMMjqp/EcbXKUnL5ZSNy54kcDhWJS3OOEu37jR3Gs47jhRlGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSNIr3iH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e0b29c2ef9so48467725ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 16:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712099220; x=1712704020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7422aHnKc2YIMvnMd+j0sBwZWTd2YcB6sZqSb8qExc=;
        b=fSNIr3iHUE2KS1JwvAp+0VTuTWOnVAwhzuOjz2jaVuO4SYAPYSfmuGk2d1sSi3FoWz
         YN0FppBeK52vbwjimHxMauvlLlq0BpFuZrmgo32oQ0kYvcl68zXSuC8xxB3sZojNdiVV
         sHxNSQUEQ2/7opU+V3x6cm0/oLWr9FaFNh6IYcCnnqwyYxCRBnbNOJ/2Lcn9jpSLqbo0
         rHMdvLsFi3sP8eKImkxL78yfysEC9oNCPCw25lVlB+JbPvmVAxVY6PoEe7PwJ5uz88My
         xf4Vq+/hnfhLW9XUPdJeVMOo91Fwl7Te6pJOO+ssVSVJbaV+wY/aorXV0z7wEQfyT8AF
         wbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712099220; x=1712704020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7422aHnKc2YIMvnMd+j0sBwZWTd2YcB6sZqSb8qExc=;
        b=PqCSYRtUqU3pyY9CYgeoULL4IF3touk8jrqX+S2XVn5RHDTXRglWfl/+wmaAHgs3jl
         SmOmXKf2DyeRjWtEKDEpcQ02860jToMA6/ctVKOeFmHTU8HqHDWswhlmxuQ6ZdT/OHx7
         rRpP8Xgvy2KOivF3GPrFk5F+BQF01IeCOS3fvocGBRHYHsGpGm47koDj+BLGkojcUMnH
         EOTBOu8sCcSc4lZ6a2/fRIyqAz0ZT6kp5NgMK/HmD6gNN1jHlMl5QUrdPIE5DH60tr91
         198ZOE8UEFqd7layrJ+r0+Ekdy2T2WJf52g/66aC88/FJC8AiPii7kc1N2BQWtHkz0ch
         WZjA==
X-Forwarded-Encrypted: i=1; AJvYcCXcvG/HT/sh03TJO0evDIHUXcu4Jwx2FvHv8nA2VobE+Zqdhj5tDkPO1SwNVjqU76IsOued1jUpYG33K6ezi8ELNfV43kHW8Wv0sq2w
X-Gm-Message-State: AOJu0YzQaWzgN3DTcnusSTk6QqIAOgRttqXyanh7CT7fMIzW5+tRqHF1
	0n/a8Yq3NNQfVEBlBvi5h9PWg1yYEz0VoSTCIFO1blIMrfA7wW7HQ8Ip34dobRRMeiQdFLXHmz6
	ApA==
X-Google-Smtp-Source: AGHT+IGRm2VsuXBt3jAN92k0nAeok/Lf4J4zQfP39FSHUoKS6RXRTu02feTnvHV+1X59u3kiSav4RscI6qs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e884:b0:1dd:cc3f:6510 with SMTP id
 w4-20020a170902e88400b001ddcc3f6510mr1141063plg.3.1712099220554; Tue, 02 Apr
 2024 16:07:00 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:06:59 -0700
In-Reply-To: <207d6598c8b74161efc38bd18b476ca8626786b1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315143507.102629-1-mlevitsk@redhat.com> <207d6598c8b74161efc38bd18b476ca8626786b1.camel@redhat.com>
Message-ID: <ZgyPk-1MCqJIXXoB@google.com>
Subject: Re: [PATCH] KVM: selftests: fix max_guest_memory_test with more that
 256 vCPUs
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 02, 2024, Maxim Levitsky wrote:
> Kind ping on this patch.

It (and patches from other folks that are getting pinged) is on my list of things
to grab, I'm still digging myself out of my mailbox and time sensitive things that
cropped up while I was offline.  I expect to start applying stuff this week,
especially for fixes like this.

