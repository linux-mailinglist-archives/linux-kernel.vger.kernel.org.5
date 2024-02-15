Return-Path: <linux-kernel+bounces-67407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82C2856AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4141F265E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6C01369A6;
	Thu, 15 Feb 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGTeqnfO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE218132491
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018116; cv=none; b=NF4zGvfkOrWnP27zpeVd/0Wur5C5sv5rqj2oDzHjUlHivwCatOAa9iEkjxinZg2R/R4hBmCV8qcAxnKq0lhZLxfvJGMySTZW2+g2dZGX+Fzov5lSCTHl519j3DSgCpc5e12ynIcVDh8MW66HAj+2EDXqUlwEd43B2WWdJfnM2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018116; c=relaxed/simple;
	bh=dHZd5Ku4cKnaQTeuYbLj3B5g+jqGKkqQ49mVjgl6HnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae6ghg21wMTkPYdBRZ284ojKxVl8R+ogtI8+Tq5B5ypRXC99sAXPKXNkmyIwjWVwlPkf7e/qSZ/In2LFq9n5liASanmNjmXXSiy0qraXdsqC9mFrh4ZQLGEjP0NQsYVBa0SreQ1LcRP6JMArx30lcL9SbqovYqyxel9nmOVebXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGTeqnfO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708018113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHZd5Ku4cKnaQTeuYbLj3B5g+jqGKkqQ49mVjgl6HnE=;
	b=UGTeqnfOU6UN/QnX6fGbGHtT/Nphp7RmuYSETZrssDJqF67kzTyagCL0XrUHwXJ8Gs4GH/
	zyiXiL0jbkLKg4rm0IVJbDRnlUjmeWE8peEGQcX+VAzheyR3oUUUdoAqInJs2o/ZheBjvs
	+QPAYcYX8KTpWId6TBSQTVb3aG8cbxo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-KI0RZET6PaeJJiZymEt7oA-1; Thu, 15 Feb 2024 12:28:32 -0500
X-MC-Unique: KI0RZET6PaeJJiZymEt7oA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-410727c32bdso5501665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018111; x=1708622911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHZd5Ku4cKnaQTeuYbLj3B5g+jqGKkqQ49mVjgl6HnE=;
        b=ipmpsXw+24Hh4D5mgB+T5PsbTWscLewTRydAqKRFKAiMA6PIv+Ri04VIf0kLEjsH0o
         zfyAYBbXvjyT526I2jNZwa08Wh5iMlduV0n0wYtLv3gxVKPiSMRg6UUn0dws2mMethME
         5vCU934u0mC1efwJU7W0Zw1i/l+taxuVTRW9S5OKaQmJ2byYHsXuIAbcmmJmK2F3qevW
         MYslcbs696dD0wHTyyCDEfrvxhmjnt87X+s5NM9eBhDRQQjR+Ajz3h8/tNds8a8o4owZ
         kicGe6+Pu5Ykuwqk9l7/Lva96mPvNQHbwgPVJm9hUJhGwcs7rlKJeVCz2xM9QlTdg0Ra
         QIEA==
X-Gm-Message-State: AOJu0YxhaJhlz+RXttLokItBNqAyIIWpsd+bXeBgxg9Mmpa4VaYZTJF+
	cE9G+8dPR9sB/3AJiMHpEo0KgXOwgj7kMbyHT7kjY1Pnk+2K5VbypDhgbz6k4orzv6JkdtxAaEK
	+PoSstr8XtIrcM8GWuk0KQ4q/g+eCJMINu7dNIKlHi17pdUAuYV2sQRyzfbTxl9CEzn5pfE7G0b
	uhkN23Q8308TzTH+MxuYKPwSVeF3PgLFWdFBJB
X-Received: by 2002:adf:e70a:0:b0:33b:697c:1fc6 with SMTP id c10-20020adfe70a000000b0033b697c1fc6mr1728116wrm.20.1708018111229;
        Thu, 15 Feb 2024 09:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFvsu31+8oSt1VvAhl78DRahpkJxHYyoUVkf44jL3ze3T4AcbebuNJqhIs3oFW2TjAkTKdYlKbVjAlBEhbG0g=
X-Received: by 2002:adf:e70a:0:b0:33b:697c:1fc6 with SMTP id
 c10-20020adfe70a000000b0033b697c1fc6mr1728104wrm.20.1708018110911; Thu, 15
 Feb 2024 09:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209183743.22030-1-pbonzini@redhat.com> <20240209183743.22030-10-pbonzini@redhat.com>
 <20240215013415.bmlsmt7tmebmgtkh@amd.com> <ddabdb1f-9b33-4576-a47f-f19fe5ca6b7e@redhat.com>
 <20240215144422.st2md65quv34d4tk@amd.com>
In-Reply-To: <20240215144422.st2md65quv34d4tk@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Feb 2024 18:28:18 +0100
Message-ID: <CABgObfb1YSa0KrxsFJmCoCSEDZ7OGgSyDuCpn1Bpo__My-ZxAg@mail.gmail.com>
Subject: Re: [PATCH 09/10] KVM: SEV: introduce KVM_SEV_INIT2 operation
To: Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	aik@amd.com, isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:44=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> What I mean is that if userspace is modified for these checks, it's
> reasonable to also inform them that only VMSA features present in
> those older kernels (i.e. debug-swap) will be available via KVM_SEV_INIT,
> and for anything else they will need to use KVM_SEV_INIT.
>
> That way we can provide clear documentation on what to expect regarding
> VMSA features for KVM_SEV_INIT and not have to have the "undefined"
> wording: it'll never use anything other than debug-swap depending on the
> module param setting.

Ah, I agree.

> That seems reasonable, but the main thing I was hoping to avoid was
> another round of VMSA features changing out from underneath the covers
> again. The module param setting is something we've needed to convey
> internally/externally a good bit due to the fallout and making this
> change would lead to another repeat. Not the end of the world but would
> be nice to avoid if possible.

The fallout was caused by old kernels not supporting debug-swap and
now by failing measurements. As far as I know there is no downside of
leaving it disabled by default, and it will fix booting old guest
kernels.

Paolo


