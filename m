Return-Path: <linux-kernel+bounces-77960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29528860D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D5BB22285
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32811B59B;
	Fri, 23 Feb 2024 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6gLO3x4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50C18EB9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678690; cv=none; b=dSnUErlSnFBxRjOTsT9apiBqE1pAB88qegzBf80aOTJFlySOjGos0ffCflizMH8v99ADOUlcWs372NcdmAJRy3nHd4VOIzAzoIJFWy6ifEvbHhLHBkUI9QI7QDrMrpaJobbvyVEnpdnx41TG97yXPspyyIOl/vGf17ZNuh66tbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678690; c=relaxed/simple;
	bh=YZbhuAtP+26wSLICWdq/lyQWSLDnxV62jHh0sN94jd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3/+LgW6pYpkQ+UL6L3ErMYcBSyiRBBrY1lsu1/O5U9ePd9GZjxS9nd13nctnbtQZiIuvzprBYtEd7xCNNjQ50KdJQriP/FYdBoAKatzt7zmprpEGpew7YIZNy27XF1UB0Vb570sn8wTBklbpIUBA1wM0V7Lkl5uaw/qevm1084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6gLO3x4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708678687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLQwWfoTn0xaoRpTFSAvxI7eKjXdmQ16vLaj1rspCoQ=;
	b=U6gLO3x412UlNLi7iT5R+TroQiBcykyHJE7UtWiN7f3SDiuitTOrf3xL39erCeZ2S4r2H8
	/7U4O3uZ00Ub4O0yz5qeoip1w8gq2n56kSdfW2aYwLkdSxnlAFtTLM8lQt4KjjChOqursU
	VTvO4ce8f6IGKZEJagB/eTj94ghbeNo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Xcjfg5BdNESh4ClbbrUosQ-1; Fri, 23 Feb 2024 03:58:05 -0500
X-MC-Unique: Xcjfg5BdNESh4ClbbrUosQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412829eab17so3220905e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678683; x=1709283483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLQwWfoTn0xaoRpTFSAvxI7eKjXdmQ16vLaj1rspCoQ=;
        b=AsChK3wRpxsfNA01mKDkSOzcxs8Q5U6eejntglR1yU1IiChxanaWQ974DHNCZBik54
         ukRlN8hvA3MjS2iA+AoguM3uSvoItv9BsCegnyUdnKIWD7TI3gnoRozmTWPHNOjAqYld
         SIJwRZ0/VEtGakzwK8a7FKPIKip8PSgZilOyggLK7Hx4s4917KRuyEOJKRLZ5IO8GLdd
         aWhI7JsT9vFY+2DFHRVmRbjuN1JtOJkDwP8a7WO1GEA5PGiJC/NZsc9UBsG8FnM05O7L
         E1RjwaDkvdgkqybqr8aAjzXdBuoxjKBHy/hYg16UGdZNG3pZZuVZQud8LKrMqwZLxQRY
         lgGw==
X-Forwarded-Encrypted: i=1; AJvYcCWrKCKvOvBo91laSJ9Zq/adBYwSA8YT9HN3ZaE2z7w61Bv42U8tQW0AHQuGDtQIdNKtPCo3KXuEOO6kpA+/D7uA9inHrf4ge7sme7Ts
X-Gm-Message-State: AOJu0Yw2E3gnsjNJsh6r9XiIQ5+E59AgfS8FRIkCVGWIxjq4fHdvOiHa
	2RnPpwOqXL+ugOXsokPC59r+4zdFY8SUUlG4fnDPnBTV7wycJotfmW32Tpa7r/StyBcFe7kw+VW
	jcmZsG5z/AOVJeEAXBTovxSgQFLHEc75EofqSpXBqaxxAOLvFzk1fez8N0Da3yh6xHBQzMV1MeL
	a5VotB4mV+f9DnQDXyxMIYKkxjTLR+zKUeIMdgeKe9NAdn
X-Received: by 2002:adf:eac3:0:b0:33d:71e5:f556 with SMTP id o3-20020adfeac3000000b0033d71e5f556mr1020421wrn.27.1708678683411;
        Fri, 23 Feb 2024 00:58:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+mrCKzWAaGkT/K53qU2Sd9UG7Fu614wcbzGC+OYclult0+HHvvNnkxisAg/4y0NnQxxIN8re7HwpceFAujt8=
X-Received: by 2002:adf:eac3:0:b0:33d:71e5:f556 with SMTP id
 o3-20020adfeac3000000b0033d71e5f556mr1020407wrn.27.1708678683094; Fri, 23 Feb
 2024 00:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222-memfd-v1-1-7d39680286f1@linux.dev>
In-Reply-To: <20240222-memfd-v1-1-7d39680286f1@linux.dev>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Feb 2024 09:57:50 +0100
Message-ID: <CABgObfakz1KQ==Cvrxr5wS36Lq8mvF9uJtW3AWVe9m-b+0OKYA@mail.gmail.com>
Subject: Re: [PATCH] Build guest_memfd_test also on arm64.
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:44=E2=80=AFAM Itaru Kitayama
<itaru.kitayama@linux.dev> wrote:
> on arm64 KVM_CAP_GUEST_MEMDF capability is not enabled, but
> guest_memfd_test can build on arm64, let's build it on arm64 as well.

The test will be skipped, so there's no point in compiling it.

Paolo

> Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 492e937fab00..8a4f8afb81ca 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -158,6 +158,7 @@ TEST_GEN_PROGS_aarch64 +=3D access_tracking_perf_test
>  TEST_GEN_PROGS_aarch64 +=3D demand_paging_test
>  TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
>  TEST_GEN_PROGS_aarch64 +=3D dirty_log_perf_test
> +TEST_GEN_PROGS_aarch64 +=3D guest_memfd_test
>  TEST_GEN_PROGS_aarch64 +=3D guest_print_test
>  TEST_GEN_PROGS_aarch64 +=3D get-reg-list
>  TEST_GEN_PROGS_aarch64 +=3D kvm_create_max_vcpus
>
> ---
> base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
> change-id: 20240222-memfd-7285f9564c1e
>
> Best regards,
> --
> Itaru Kitayama <itaru.kitayama@linux.dev>
>


