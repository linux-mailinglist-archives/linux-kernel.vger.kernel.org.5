Return-Path: <linux-kernel+bounces-141292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E38A1C35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3398F1C22F30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568915AAC4;
	Thu, 11 Apr 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbjBTsh/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B40653815
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851902; cv=none; b=iHjqGiFl5sZ6s5O7rwMZeIvzpAhER8kY/m2uzy4O8TztHrEVl52zG5ozApPx60j/Y8e/N/LRUQ3jwGj1ks0AFU8hZ9XzOEakArOlAFsrQLpJjBGWsWUsIUEWFeWLEpJhJwh4HfnEQcPuFpI3o8vWY3ff6KRm8N+e0Ixk3n/7eQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851902; c=relaxed/simple;
	bh=L2jcJnuTYJv0eRkkE+PmZ1tBb2gSNZLLy/FJPeuq3kM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CCFyv2aOZMIDRAs2J9MbdTkB2MMG3CZtryTjxDDwyxWDWBvu5ViL1Yx4yl7A6YE313FKn3H5KFXQ967al153hEd1H7SGD51mFmi7Z3mfchBUXcZtGOM4qVEA/XZIN9EUEv8S5tlANmZkBoahTc2RHu0H/17dztyKzvAA3SKePpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbjBTsh/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-618409ab1acso35188577b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712851900; x=1713456700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dA3lLmzuvL7jU0zNfJHm6+v36KvfdVGE0I5vccyMUwM=;
        b=mbjBTsh/VDOesvG0e/jdH5R+MP4tTXHdtKcWdsj4jYRVaG3Fa2RGrsCf2XXgqnVelg
         WOR5V2AKalGzMbB2LgUXG+mwgNZonwUjEXXZXlfk+urPGKAxSBKA9ts081sJ4CXhI3Y3
         drC3IPVlz46yW8rAfZ++7nIB2W7IDZoYd14Ude48q9ea6kJbG/jGfSxtD7AjfQYRWdlF
         bF4/6qZ4ivMJaTXUUTC4guYS3Jn/9vNMPahzntZZZkOmDOycuTGBfy6T8KVkFm3gwmo1
         aKW2rGdD6eZi0xThVZveSSGtFXDq/M5wloWjF/Acd4Z52oehMcaX7oBi5bEvm3SSrP5j
         I+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712851900; x=1713456700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA3lLmzuvL7jU0zNfJHm6+v36KvfdVGE0I5vccyMUwM=;
        b=pnu+aGOXgNQvAcE0BkI9A0hJdlOn2r71Wc+oWAANzDhcpX+kJnB7OWJemCUoArWfzv
         O5T0MPfC9u9pLofnFYaA+57sp6DW6zy55vBI5NEzaXlluaRV/Q5Wj6LmUmpcqZJLrdMq
         mbg0mfQgaUUbr8F1o6j18ogLJNiNst8BqbiP3RTtlPdnI1yGXGM4WjOQuTIrVZRYenjs
         RTXS1CnZw6wKcuDhUL2E2nHNVvHGorhCBiAq1akvDUzuU6qV0EhL8uBR+7bsAdXdn1NK
         GG+s5Nlr01EDrDqDTFXAU6jxyXuM0RcxOWf3u6bReswj+2j1ANZ99tLl0KOqrhC5vUVz
         ROwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5QR6K4tiAxYmf9A1OcdXYTaPSpYTskQJaUd9c6cHKbuUXLataocl0LFmMcQxqdve8zDIXsshQlWdSEf9j01PIqQK/y3qXa04inwrn
X-Gm-Message-State: AOJu0Yzu1TsQ1a6rdw24sD//Ot303z3GLzh/WU9nZlRvUwkNnzUeLUdm
	Ge0DJfE3IkfVa5A7ihHxNrAsC9IwZrrbfkbfj6soVGbGQjdMi3VmazMBeMIJsMbeSLZRzyEy4rK
	1Sg==
X-Google-Smtp-Source: AGHT+IEvtAQzM4k0ZSSzVGatPdOU1W/00aEZmkIXzCLyNlxCcWLg3a2WgR9TFXYbA2NhxYAXbVaqzwsAdpw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4f58:0:b0:615:577e:6af with SMTP id
 d85-20020a814f58000000b00615577e06afmr1325384ywb.0.1712851900307; Thu, 11 Apr
 2024 09:11:40 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:11:38 -0700
In-Reply-To: <20240411144322.14585-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240411144322.14585-1-xry111@xry111.site>
Message-ID: <ZhgLuiKzCcBR8tNC@google.com>
Subject: Re: [PATCH v7 1/2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Sean Christopherson <seanjc@google.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

Don't disable *PCID*.

On Thu, Apr 11, 2024, Xi Ruoyao wrote:
> Per the "Processor Specification Update" documentations referred by the
> intel-microcode-20240312 release note, this microcode release has fixed
> the issue for all affected models.
> 
> So don't disable INVLPG if the microcode is new enough.  The precise

Same thing here.  INVLPG is very much still a thing, it's only PCID that gets
disabled.

