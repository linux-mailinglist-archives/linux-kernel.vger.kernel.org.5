Return-Path: <linux-kernel+bounces-150415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6909D8A9ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A53A1C2235A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3603416EBEA;
	Thu, 18 Apr 2024 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGkHN+Cz"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D916E891
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455070; cv=none; b=hd0tJQphJrbtOQxLcTzVrVHIJuiVNKA72EFKQhFwE4mgQIjPLdCNo7767KQN+cQiBHoKUA7S6EIG2xMjao6ZX9nNPuQUuLu8aEia/DVeRgU3h4mfJ/0BWMwnei3pxiImV6I3ubQMYlAzDSQ2WFK6o/qDf9YZSKc6Ez9Cdf1PEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455070; c=relaxed/simple;
	bh=eW41FDAYitNVnqBwCLv7gIF9iBGx/T1PWewJl/Lc39k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9ycTdtrnU7Ku4o3zJB2KpQPhsGCV84vUSz0H9kb0ubup+vHSuyPBfhUWTPK4N9K+/AkAfxv+loFnMNSq76sOkq9YtrQ7BNli/EEsda5gjuQr5f4aX2xrnLF1SaCWcFa3f5ZHLWysqOQYjbu6q6p16quSHRooOeaSWut/Z5yc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGkHN+Cz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343b92e54f5so777737f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713455067; x=1714059867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtCAalpEU3sOWMKDUifAwR/7NkFi/BBuronL/FSnyNk=;
        b=nGkHN+Czc/F8uoFXtHCbSIZM+yy0deqX7miZec2LA42CxZ/4zHw9dxTaa0rKzUDXoK
         wyiJgY43EwMMQbVCzysExVyheRe6BUh3/ysKr5rYjXcSlKCtQp+LW4nqWIOGnNdS+eUt
         EAQ03NWHYmd4IkxaVKm5Catup61N73bHIxugZ85NDZzciXM5u8kiLdG7UgO44D1jA4n/
         qCmcE2pm6eO/xfBbKxJfI8zPyehXz4qhG5a9ncd9ADrfJFjwgDg8r7mxl1VzaqI8blaO
         ONP2d1CQutgD8Z+TOSg1jJzqn+XDThU33a6n6yeCqxUiR20zFPl6xwxbF/8Tf4eb1mt5
         H7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713455067; x=1714059867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtCAalpEU3sOWMKDUifAwR/7NkFi/BBuronL/FSnyNk=;
        b=JNIx3rBCIKaRqqPjPdux9JacINvxYPQ7m5FGBYe+mVOZmCrb0Vxet6qB++Z6X2IFCg
         WZ9ZNRgQknWPIHVlFy5b0DQweULJ5OFF5SKh2NFlkSnhIEdDthfojFSlnGQlwJvDAgb4
         QXFhZrznqjZ1yMaPe/j8LBoOf4Oe7qV/me3mzmt6rsdOnc3J5YpKSb+WKIIjoRrE4USQ
         GZhfCx7OYNEDPWhsCcp8wNVhjId0XzXBu0XMHvFTqKaaVL4BjskglwXCBaOwR3YnFRG9
         vN3hNpenHQoCMaz4GHUV+ydlZte4R9M//ebDEVnwh0RjGEuvFLj6Z0n7rBMdJsBAWxs4
         xsBw==
X-Forwarded-Encrypted: i=1; AJvYcCUz2O9dCequA5pfNTTnsNKkwqDhfPmvAp5SFQ9JnrWF8evJ5UWTQ364h3DBPUabluAojEHN5TPj2oPTa6+K+QVLCoL8EmT2fhJ/sbkl
X-Gm-Message-State: AOJu0YyWhYhjmRg1zAFeVxPOyY2Zr99uObSDSize2QayNezOSP2LjtSA
	Y8OHMvPILCv+J4PQsWnXpcGizrBhFRQIu7xboKfHbxhvpZHKcdaMVuRNbkwsL4K0xbbCUr7g3T1
	mFwcmdtZt55NtlDhmEooGal+XNH9vX1mW3Kse
X-Google-Smtp-Source: AGHT+IH1/hV82bCx1Gv1NIXaALjYWfsTvoaiACaL0kbh8+h0DPYoNJGE2WuAkBJUelNQ/WhcocDOHrc4DjFmQeedIa4=
X-Received: by 2002:a05:6000:912:b0:346:cd6f:40d4 with SMTP id
 cw18-20020a056000091200b00346cd6f40d4mr2059470wrb.59.1713455066857; Thu, 18
 Apr 2024 08:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org> <46343CD5-24D6-46BF-92A7-0B0FA0E6937D@alien8.de>
In-Reply-To: <46343CD5-24D6-46BF-92A7-0B0FA0E6937D@alien8.de>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 18 Apr 2024 08:44:12 -0700
Message-ID: <CAKwvOd=3Jrzju++=Ve61=ZdeshxUM=K3-bGMNREnGOQgNw=aag@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/purgatory: Avoid kexec runtime warning with LLVM 18
To: Borislav Petkov <bp@alien8.de>, Arthur Eubanks <aeubanks@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, morbo@google.com, 
	justinstitt@google.com, song@kernel.org, ribalda@chromium.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	ns <0n-s@users.noreply.github.com>, Fangrui Song <maskray@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 4:15=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
> How much of this silliness should we expect now for other parts of the ke=
rnel?

Looks like ARCH=3Dpowerpc sets -mcmodel=3Dlarge for modules and ARCH=3Dum
does for the whole kernel. So that LLVM change may have implications
for those 2 other architectures.  Not sure we've had any bug reports
or breakage in CI yet, like we have for x86+kexec.

> Can we turn this off?

Maybe we need to revisit
commit e16c2983fba0 ("x86/purgatory: Change compiler flags from
-mcmodel=3Dkernel to -mcmodel=3Dlarge to fix kexec relocation errors")

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De16c2983fba0fa6763e43ad10916be35e3d8dc05

at least the -mcmodel=3Dkernel addition (since that patch added a few
additional compiler flags that still LGTM).

> Why does llvm enforce .ltext for large code models and why gcc doesn't do=
 that? Why does llvm need to do that, what requirement dictates that?

Google is now at the point where a few binaries running in data
centers are measured in the gigabytes, and attempting to link them may
result in relocation overflows.  From that commit message, it sounds
like they link together object files built with the default code model
and some objects from the larger code model. Putting large code model
data+code in distinct sections is helpful for then being able to place
those further away in an object.  For other architectures, the linker
may insert a veneer/trampoline.  Not sure why that's not used here.

https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html#index-mlarge-data-thres=
hold
makes it sound like GCC may place data larger than a certain threshold
in a new section. Dunno about code (.text) though.

Arthur, you probably happen to know more about code models at this
point than anyone particularly cares to.  The raison d'etre for
e16c2983fba0 was avoiding R_X86_64_32/R_X86_64_32S relocations.  Do
you know if there's another code model that can force R_X86_64_64?  Or
is the large code model the way to go here, with updates to linker
scripts for this new section?

+ Fangrui, Ard, who might know of alternative solutions to
-mcmodel=3Dlarge for e16c2983fba0.

Otherwise, I think the dedicated linker script is the way to go. We
really want tight control over what is or is not in the purgatory
image.
--=20
Thanks,
~Nick Desaulniers

