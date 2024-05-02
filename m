Return-Path: <linux-kernel+bounces-166610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7038B9D06
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046CE1F227CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577FF1586D0;
	Thu,  2 May 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCBssuna"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB75381DA;
	Thu,  2 May 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662223; cv=none; b=t6poa1asWGfIMIcu4YGLkDOIqecPmrKBfO3eDidFrLmhTMfKfExbopWmby8R3PkR6XVNI5nVTsJFvb3yufmeokuhsnhrZGgFbcG9nKKGGRhhqPHeyAnNrKs0gvliQ6CX6sN9Tzhqyss0c38XShA95Idxo+IurceFi+A2AjNTPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662223; c=relaxed/simple;
	bh=j4+nVr6NKTDhXKl7PTWamprIjgj/O3ULmfyUybvZP0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV6pwywbtijMz+2hJVNjucCfU4ZNeyFCT5+6DuAgkaZ4J0rbxQf5kItRa7xxy9HOeqgG1O/33VgRHBfSSvjhYPNU9qk5PjaY6CnKG1+4MIW6nTenE5RJYLhbTLEfkuF+R9Ap85tlBhpNSyarjwrLKTKXto5YYjddyAvbiPWSAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCBssuna; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2db13ca0363so130416611fa.3;
        Thu, 02 May 2024 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714662220; x=1715267020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4+nVr6NKTDhXKl7PTWamprIjgj/O3ULmfyUybvZP0o=;
        b=fCBssunabmRbw57pYVCWbhQ62mv7DSMLLdqst8Vt0DqpQWZCWAw4LP/XUAQyIOBZmv
         Ko5irXNOvEpF7j8jjmYdzEhLgXbjQcYNIecVj26k6hraqjLDtA6ujHBz1Q8rkCTVOdyT
         fHb96pITzRwCBivCkHbfPAC3osthJUBfrHxJWowmnYGRXw3ESMafKC9daIc3yA4J/cma
         tZs4Zm15iPyDQNs2IU4S+hYG4LFrnYMoosez0oDij1Lgvj1yMXdTj8GbgHSwvYJgt0D7
         H8Lb47O2yi9ito5mpootuu/WiD/JkvNejnKw9tay6uvEqUnG8f5DKXNG0/XRk3fNtjR5
         njbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714662220; x=1715267020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4+nVr6NKTDhXKl7PTWamprIjgj/O3ULmfyUybvZP0o=;
        b=fDjpOgp/V2Zi6RjQ1kwF8GFfd3R0cJj32xVHKnPupmjjU8Bbtgbd+6h+L4QhNEu4O3
         iz0C/GAHC3engEGG0HGwyTETTM/fwriGOOka7nrN8sn8Xf36qpCNYaAZNFcJFsQDQArq
         KtiQVGzofn+SHLw+E8bKeoWjg368JK1Bhpqqbl7HKm4M1meR1i6Cjqm6moXT8qlFekTr
         ZnIhN6g6yBTDWC3R/9hSti+N0uhjSHO5WMUFWrmD3DY9b2xt4MEPsTRUyV5jx+0FiOBU
         b3sUxKy4tqOb+xkVpf/KApNV1/KAux9qHUhk2D8tq5IPV2efXx17GEvQpQb4usmUVRjb
         1Suw==
X-Forwarded-Encrypted: i=1; AJvYcCVAur5HJG5Tp9nOlr2bZwFWnfPLMCv+jteGiyITmsQeQx6FPmrUJYn14WGi/SzCWpVuY+bZP/QWfFL1zmidj73YcbbjOaVn7lhMC9lC9xduZIcdui5US961rgGMoxKaMxP0kS3YxjkIyrbaCygv
X-Gm-Message-State: AOJu0Ywx0IQAUXze3L6wJUcrDBdWrpzgUy7KcIguReW33jKFMY188oxb
	roHqFiE4l2BH5rBivUDsiBgQk0wotqyjq6Hj+Zm8QHN2kP5yNMSqGOPXQif63knqnjkPDGCd50Z
	JP8/fxPoOMIgsS3SORgBnJIiK4iE=
X-Google-Smtp-Source: AGHT+IFOz8ONWbsgEsApw0WT1hSDOSCZ3n8dTfrGXCIRw5g9nyxgPtjdut0SzjXdajx+lllzxIc5U/d88/1NgSfuWgA=
X-Received: by 2002:a2e:9882:0:b0:2dd:2bd8:a4c1 with SMTP id
 b2-20020a2e9882000000b002dd2bd8a4c1mr6334ljj.10.1714662220092; Thu, 02 May
 2024 08:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502141359.89567-1-harry021633@gmail.com> <CAHp75Vd9PibrQA=tgZLHuv-kDXana9rGcu5s_aPqyxW6tDBYGw@mail.gmail.com>
In-Reply-To: <CAHp75Vd9PibrQA=tgZLHuv-kDXana9rGcu5s_aPqyxW6tDBYGw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 May 2024 18:03:04 +0300
Message-ID: <CAHp75Ve4BV7+C+XsNmmjCSupcL6PXe_9ZNMGAQXg9nqdMBFrqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] string: improve strlen performance
To: "Hsin-Yu.Chen" <harry021633@gmail.com>
Cc: keescook@chromium.org, andy@kernel.org, akpm@linux-foundation.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:59=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, May 2, 2024 at 5:14=E2=80=AFPM Hsin-Yu.Chen <harry021633@gmail.co=
m> wrote:

And on top of that, check what this code will do on the architectures
that do not support unaligned access. If everything is fine, mention
this in the commit message. Btw, your commit message needs
elaboration, e.g., pointing to the test case (which is absent in this
patch, I assume it's already in the kernel?) and step-by-step
instructions on how you got the mentioned results with details of the
hardware you used for that.

--=20
With Best Regards,
Andy Shevchenko

