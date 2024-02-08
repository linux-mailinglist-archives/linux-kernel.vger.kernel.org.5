Return-Path: <linux-kernel+bounces-58464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3926D84E6D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98061F28608
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA7823D6;
	Thu,  8 Feb 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEmPcwys"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6E7F7EA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413549; cv=none; b=CMn7X7dAC+y3EaCTnFBbxAS6W1QT9zjuvX9A0+/H+X4MGJKd7WJn7QxBeDOffKA3PAaZ1rPnwi1Ei2dfvxC+I+xnwXs0xvtkHsM4+1aMRjh7GdLUiHDJZhEvrGB7E9Tb4Ugm/uzwIjd/lH3kJTZmw+uTofbvvvm/NmzMPftIU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413549; c=relaxed/simple;
	bh=7NexPi4ZvLHEuMjPlTUsE8U/UuJJ7UuIYjbZcLB5JLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKxvX9CcKBKa0/NxBaq1wvEMXE/OtF2igKMWxtCdwL1Heiuq5z02AUfzSpqUHF5PGzzX2AbvjvD7TEzTO3w/dpxJeRhOjqHE2LWYwPkCSkiQINfBcGQ5JwoOtsVti0PQExOB50HwysBfA3sT+fSczykML7QwtvpgvxHd3EZhhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEmPcwys; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707413544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NexPi4ZvLHEuMjPlTUsE8U/UuJJ7UuIYjbZcLB5JLM=;
	b=HEmPcwysWo0ybF5i8/5OKswhtqN0xASrqnfTLBXcs+X1fg5P4wAbHASw5aGSKE1/VrPk5H
	oROHJupCCvK7J97XR7zpE4CT4bMF7SbsK8jGqYB4pGZk/by5o9KIx3qey5o8J9iVUcqSg9
	CCYi9Ze7vkQ6sdFKnT0yW9hw2FiE96w=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-5fjnypZ7P5WF0GkYNhrHGQ-1; Thu, 08 Feb 2024 12:32:23 -0500
X-MC-Unique: 5fjnypZ7P5WF0GkYNhrHGQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bfdf15a3b9so2180941b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413541; x=1708018341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NexPi4ZvLHEuMjPlTUsE8U/UuJJ7UuIYjbZcLB5JLM=;
        b=Y0pI4nwGTeGOmCZSQIuhqpLVHVg9XAAOcvzTEqWWriTlggIY6e7JXLrFVlHRLOg1/r
         mS/bv8HPn+xYTy4nodE048/GYXU1RwFsjgzYkc6i8bQ9gRU8luRck3o3O1NfN1Gh6mtI
         JIAOOlVb6FesJ2tzEFga7RxROJ6Xs6VZURFWRrrA7BtmjLRPyhoUcmdOcKWgCGO1CJVI
         yYN8LwrOfdmQDW1ze06RTZ5nv8WO2LhMojnv+0OV6xWF2CeVCCplyZDlFKaII3AsoyiM
         Zp/4JLfnaESou9TZOZ4cfQAJHhp/o8NeZnJ8EenzSSkETGNldUl3jKSfx43pIsGLyNn0
         cniQ==
X-Gm-Message-State: AOJu0Yz9fxrWJ7BmjnTDwxER5qzor74TqaCqD5x6aT+TsmaNoBwq3cXv
	e2LUa387TfXaU4giJ8WxLJmC5k5AlQcmmvEFs7fH/8KlirOeA45Y8fWa4aDAIsFY2N6ylFRm2y1
	KQxpMIlu/1RhWONu5xeaFdMwsr9mFJxZH+NOYfHU3zA/tZxPnkMpbsphxxZfRhqStAF5u2kqifH
	PQVXOZQuZg9pXZeCdVtnK/7D98jXSWpraWRUJR6AdZ7zmx
X-Received: by 2002:a05:6808:1709:b0:3bf:d152:fb35 with SMTP id bc9-20020a056808170900b003bfd152fb35mr9469663oib.49.1707413541693;
        Thu, 08 Feb 2024 09:32:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFui1Jt+JpattIFcP1GZrYXY3zqSnk0oSHo/XW0zG1YLW12bXE2A85gSdzo7ME4SCqYMpnjXLxH4HbAyhaQans=
X-Received: by 2002:a05:6808:1709:b0:3bf:d152:fb35 with SMTP id
 bc9-20020a056808170900b003bfd152fb35mr9469648oib.49.1707413541467; Thu, 08
 Feb 2024 09:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131233056.10845-1-pbonzini@redhat.com> <ZcOWwYRUxZmpH304@google.com>
 <CABgObfa1SmH0HDq5B5OQxpueej=bdivMTkVrO=cXNfOi09HhUw@mail.gmail.com> <ZcULFqXM_sA3dSY7@google.com>
In-Reply-To: <ZcULFqXM_sA3dSY7@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Feb 2024 18:32:09 +0100
Message-ID: <CABgObfYMg_7b4U=RXSz0c8ouo5UKqpP2Ra48jkq9Gur7fFKs4g@mail.gmail.com>
Subject: Re: [PATCH 0/8] KVM: cleanup linux/kvm.h
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 6:10=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> > I can do both, a topic branch is free. But if you think this is in the
> > "if it compiles, apply it", then I can take that as Acked-by and apply
> > it today or tomorrow.
>
> Looks like you already created and merged a topic branch, but for giggles=
:

Only to kvm/queue to show myself how it would look like...

> Acked-by: Sean Christopherson <seanjc@google.com>

Thanks!

Paolo


