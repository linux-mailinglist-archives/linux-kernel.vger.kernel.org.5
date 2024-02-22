Return-Path: <linux-kernel+bounces-77048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D5D860076
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1901F27131
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11111586D8;
	Thu, 22 Feb 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOEn9Uor"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977B1586D1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625326; cv=none; b=dKqThfyKp5zBfbl/JvnEVrE1xKYN1kf1fXZGGtXG4wR5jhfIvHdooxLzWlpQFTGFYhEJa4n8MWqiZwmQnf9jB+KDyhGUriZiGWzOBHRIj3tV5EjlV7jfswEz8FIms5tExmQ3BQgQ0rvFPSW8KLgPq5W0VMsaPbGq4yzpuTXM9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625326; c=relaxed/simple;
	bh=fy4liYg48gPvnH1kE6+qcZ1q7Bfu0MU2FGcOfrrT0bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qq/vXjLTisbEhkvD8L3aoanaFafgDceQkIVujQqCA0pf46m5S4v1Lz+9ctCzA2QmpwNdDPP0h36UVx/uq+vzzIm6BEddkN1hvebfbxrJjaSE3W9UeK7I46JB908WpheKc9+GNUEyWcD8g/3Rtq9EF++Kuc/2m8fA8cDFhbLGje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOEn9Uor; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708625323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CJoex4NkBFusthzZP64VSRgiIqDu+jmbcl9OVx+65A=;
	b=hOEn9Uorex00uX7RYatk0t3vR2bKuvHWI4UoZ0ydj0cOFSVVf7A74lP9sVLggmiJlCbQ74
	qcxqOj3WKvyjr3FM3G08MxKDgQma2SbOOL9JMU7Bl9kNx6FndSngzswhiQmkIhFtJ+irlr
	zhPzMuMLU/WmtnmRJg3OFRCmyL1Rqrw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-k-rL_whAMwu35ib5lY87rw-1; Thu, 22 Feb 2024 13:08:39 -0500
X-MC-Unique: k-rL_whAMwu35ib5lY87rw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d8b4175dbso8058f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625318; x=1709230118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CJoex4NkBFusthzZP64VSRgiIqDu+jmbcl9OVx+65A=;
        b=n0/4SHjiQVlu7C4xTPnQwJcK8l6Q8zhmVNBtP36LQNw41otg3LYZRrPmpaCG/NcIFi
         DDD5LNeAkXKflOT5S9psaR97KPiPBHJP+hOH3DoyHLvMyidELsiJq7GuOtWMs84Jo0Cs
         QAgMu3Ssz957JyauBwRwi7cX/mOkjBrffs0rXj7we16VmJqBLPxR7NwiEstBNfBRlJht
         i5TwtvFnEWq4pEO+ibAV8YlGjXTp/EdLhxZ9tcriBxt+hjR12PmbxB/ydrpk1HA3YKjP
         LTP7E/LpI73Qy5ilu+SZj+Zg6y7q58Ba+0MtrpHqHk958zdLhgzBunBayQvxqmiTAOYy
         Elhg==
X-Gm-Message-State: AOJu0YxrAUUDyNTYs9cZ9gwlj99pn6MO8K+x9/bVBHAMSSegbnrkEHS4
	ZpCi7qsz1tu4DWEJ30n74Wrjpy6zCC2i4gA63evZw+hT02KMxtZ2161O10gIDropM8Esinh5tfB
	5htvBJGqq2vAOTaYjC4Wy90AilE3a0tq8WPTF8/D5jir2Hf6bD6zxyImcQKXibuHVbhQv5Xpj4g
	5hRZMNz3VBIDqC0kHBSuJFgjTN4l73ecrz3KRJ
X-Received: by 2002:a5d:55cb:0:b0:33d:8783:1e0e with SMTP id i11-20020a5d55cb000000b0033d87831e0emr2256749wrw.70.1708625318227;
        Thu, 22 Feb 2024 10:08:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIUQS8ouwPxlaKQVxX9DLq/Mvc03qLzRTc8yg50FNvecbYAl2IuBempcl7FEGw8G6iGj5LeAgPO9VoiSe7Mgg=
X-Received: by 2002:a5d:55cb:0:b0:33d:8783:1e0e with SMTP id
 i11-20020a5d55cb000000b0033d87831e0emr2256741wrw.70.1708625317940; Thu, 22
 Feb 2024 10:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230902.1867092-1-pbonzini@redhat.com> <2b5e6d68-007e-48bd-be61-9a354be2ccbf@intel.com>
 <CABgObfa_7ZAq1Kb9G=ehkzHfc5if3wnFi-kj3MZLE3oYLrArdQ@mail.gmail.com>
 <CABgObfbetwO=4whrCE+cFfCPJa0nsK=h6sQAaoamJH=UqaJqTg@mail.gmail.com>
 <CABgObfbUcG5NyKhLOnihWKNVM0OZ7zb9R=ADzq7mjbyOCg3tUw@mail.gmail.com>
 <eefbce80-18c5-42e7-8cde-3a352d5811de@intel.com> <CABgObfY=3msvJ2M-gHMqawcoaW5CDVDVxCO0jWi+6wrcrsEtAw@mail.gmail.com>
 <9c4ee2ca-007d-42f3-b23d-c8e67a103ad8@intel.com>
In-Reply-To: <9c4ee2ca-007d-42f3-b23d-c8e67a103ad8@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Feb 2024 19:08:25 +0100
Message-ID: <CABgObfYttER8yZBTReO+Cd5VqQCpEY9UdHH5E8BKuA1+2CsimA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/cpu: fix invalid MTRR mask values for SEV or TME
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zixi Chen <zixchen@redhat.com>, Adam Dunlap <acdunlap@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 7:07=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
> > Ping, in the end are we applying these patches for either 6.8 or 6.9?
>
> Let me poke at them and see if we can stick them in x86/urgent early
> next week.  They do fix an actual bug that's biting people, right?

Yes, I have gotten reports of {Sapphire,Emerald} Rapids machines that
don't boot at all without either these patches or
"disable_mtrr_cleanup".

Paolo


