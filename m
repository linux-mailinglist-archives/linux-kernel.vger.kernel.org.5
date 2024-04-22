Return-Path: <linux-kernel+bounces-153019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0908AC7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3A7282E57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C45479F;
	Mon, 22 Apr 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NkUFJEK3"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256646026A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775746; cv=none; b=fTGvWuK+NvnRPSiHlrcKuM1+B2zujDKz09HNUawe6FhNTuaMZogp+zU8Qpv7zRIkb923ig1AQgPODm5FNG9injhNnphRa8otTAZLEiqKyfiTOHWy+bNvEQEwNEKsv0ryVFIBosy2EBlnfGt1Kg6rCwHaIXbR+svb8vgO9V/vxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775746; c=relaxed/simple;
	bh=CT2XS1e89+VXbYTqzvXH0Y15mp2pRI9oxR2LT3rbeeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipxSxHRJyEard+McxCvAMyNdvEqsPIRxCbmpdJM2/mP3g04pA+uOZt3F6JQY85D3EpUaxoaAeopPlcWg/W/3/uyFC4MiN01pUkvBrGdZX2yw4KFke/8UmVsMAqqiFJ2ssUlXZmOTeFO4xunjYk8aNnO2D+Zw3t27H1s4k2ShymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NkUFJEK3; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4daa8e622f0so1160515e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713775744; x=1714380544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81H2tvp2dnEImlGObJk9X2NDKqHXpLpFCie3SlEmMD0=;
        b=NkUFJEK3/S7dlNMbfaKMakzM77EmAHPN1I9IoZbq/fWLW5H4A2wmJ2NnFWcsaWfdD5
         aFiPAHSY0Y9pR3n9IpqHA7fjAzc1hUTfHLpfuuOKVqCFzAE+nAOTOwwrnyWuhxBV4+zm
         y+QJYLGevdhIPXXHGeQOUyMMWDkwlPnY7S0OKIsZc+EDu3DFa201Ad9C2foSq4xyLtvF
         lP6/vxltUGlFV3TUz37GFkKBDJtzfcLjp3sFCawryy6tZVdTIDqrGw744s8/6JRmhLOj
         d4Z1nSldogqYxnVyTA6VywdVbNAM0PEcXMLuixN8xbnFQl33lsBHoHgadN3za/HpABMH
         OGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775744; x=1714380544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81H2tvp2dnEImlGObJk9X2NDKqHXpLpFCie3SlEmMD0=;
        b=TcKng4UrAf1W0bqYw8Y6pni9QDmzVt6sAe8MzGj9OdCbRn30EagRheKH/uIEHEc2qH
         h9/pSqP4PfXxA4lQkrjaRNaJvkNQ2l49zNbQeAWsq9XFwl17UAhrVBxNhTHoyoU5Twfq
         mompU6OHJdwY9NuXI0WDe71lxc1hUPvsVm/BPAgJmNpJXy7agzvPImDPmyIFQU1Bm4An
         FwCpSvWJh+KMNXWKsGVZ63zSzkXRFHhw00cQr3ETaFbq+x8q0h1dqmt4w78NqdqNni0A
         P9T15hfEsnKnzFQNeySBjHd43/Em9dd21x3qmCSHyZJjcyoC8RFNeYwipSLzIW296BOp
         cyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx0m7xbIlA9CwY9GKh2LgX9KeAg0a7kKUXOxGpcwJIJUl+eJ5nNhLG7gXeI7EPEYSNrh2N3g5Ez8hn0tX0fV7hGP4Haj/XRTWn8cH9
X-Gm-Message-State: AOJu0YzGXgMdVQqDW/1vHEvYarZq07zo+9cysKhOAdq41vJDncISSpEb
	lfZQVuyzj/Hfd8LgMLgUZyidqMhKQuIHvG3oUB3PK+zUoCejY3z5P0G7qjm8SLxPrUQlHjRmj5k
	6+E+wn7RzrBLRgDUxulbSrjeL4/T0Qs515pM6
X-Google-Smtp-Source: AGHT+IEQSgdlHXUsgOeV6YmT9G8tiLYTZX/LCUwTiWsJcbPy91Vh0VZt3NNcie66mXn1DRWyl2UOedjfFoim2Vi3Ou4=
X-Received: by 2002:a05:6122:916:b0:4da:a9d8:f719 with SMTP id
 j22-20020a056122091600b004daa9d8f719mr9487633vka.4.1713775742422; Mon, 22 Apr
 2024 01:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421173750.3117808-1-cmllamas@google.com>
In-Reply-To: <20240421173750.3117808-1-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Apr 2024 10:48:50 +0200
Message-ID: <CAH5fLggC597GVm3QQGi+VeqUNBJk6vfq2eQSKgGyUZfS6dHVqg@mail.gmail.com>
Subject: Re: [PATCH v2] binder: fix max_thread type inconsistency
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Serban Constantinescu <serban.constantinescu@arm.com>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 7:44=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
> size_t to __u32 in order to avoid incompatibility issues between 32 and
> 64-bit kernels. However, the internal types used to copy from user and
> store the value were never updated. Use u32 to fix the inconsistency.
>
> Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREAD=
S declaration")
> Reported-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

