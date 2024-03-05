Return-Path: <linux-kernel+bounces-92502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A3F872141
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA191F235B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63A8665A;
	Tue,  5 Mar 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="RgMhHdDV"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A645685C62;
	Tue,  5 Mar 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648085; cv=none; b=TXhfVgWpOCeDFVv7IcIPfkCbtz9yim1863pBm36YSHuvtUmRkGdDfcXMIC2Nq+le/fW0Ru12t6rRFaMbIDk8FNtuGURWxP9KHimnO3/MnDgchaOqnw2MRzUxFvWxDwBhUptY9KA2KF/FmT2l1v3irW1SBGqmn/sJU7aBBQN3Xgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648085; c=relaxed/simple;
	bh=X9XhWS+exg8WKoissfaKP6C7l61CaxTTFr9do1hp1FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGmtmVv3LPOLfgiVaEtn3QcVFOGp1GoJsQtvZTuZS37347trzjCt1S5oQnPS9G/q17gNV/7bqIBvpN55qhcg5gWYFA62FSO7WGmPAQDyWJmWfdqun2ldltAyt0KFTIGydku37ns2/rHxV4sPljNvTwUu5975+sHF6BPZkt+Yzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=RgMhHdDV; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1709648029; x=1710252829; i=kernel@valentinobst.de;
	bh=X9XhWS+exg8WKoissfaKP6C7l61CaxTTFr9do1hp1FI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=RgMhHdDVnXVS+bbJxFq1415n+cp/Sr+uvzxiw3K7wbyGcNhtjsNF8d7jVMDoClSD
	 tg7z/VTQB3GdMO6yHSSmAzWLMfQL4gEPQF5VR9z+HrjMsJGuL+6kuXovw9PAbvoTf
	 pLuq4HYb0vF1tO94er0oAluO4Jc0K+WUBrzODhcQlXKseyZ86TiqGSh6ixuuh3C4j
	 rupwQxUaM9Grj7O8W83hgPlruL1G7kFT1cdyKcXBUcRmZvdFT+oW/hV/TmJ+79Rqf
	 kOm3fkBRMcLGtymJ8qykPOQZB2/voOB3sedXKusNRSX9V3Gdtd4sO4kOxMT/PJ+up
	 pgPue8vSK+AJDo8i8Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3UhO-1rgxaR1RZa-000bLv; Tue, 05 Mar 2024 15:13:49 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: aliceryhl@google.com
Cc: Jamie.Cunliffe@arm.com,
	a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	ardb@kernel.org,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	gary@garyguo.net,
	keescook@chromium.org,
	kernel@valentinobst.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	maz@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	samitolvanen@google.com,
	wedsonaf@gmail.com,
	will@kernel.org
Subject: Re: [PATCH v2] rust: add flags for shadow call stack sanitizer
Date: Tue,  5 Mar 2024 15:13:23 +0100
Message-ID: <20240305141323.127587-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com>
References: <20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:Eba8bZiNq+yNshh44Mby6AbjtmHiExFjyzEFIMreco5UToK3sHV
 TFmXwP2CtyB+GZgLSi32znLt7qbQVMbTzv9HFiMPgCWIz/2eiIHVIwmKVzHkHJMthljK/E5
 ji9MrEvVcNpTiCzJXmeOuYZQImJmMNXXIPDmxXjKprJs8f9CVfqi/rF0Z0MneDcgajIaxLs
 0a8zvYkwh0Dwnd0n4ez1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f3DZZkIILkI=;tbncaOB+OkBKBKUitvaL4LRZ+LH
 45dUQ7SqeCOMSlsndpuOPK0xJq05eC7SK9Lc+Q1xBQBLrseM8L76xjU4Xaduruf5IqWD1+Rhu
 rpCEqJ797vmDjffbKOTcs2pISbpHBjSgffZMlypyAGu5pYRndbhtqsxb3PvyX95mVE9uNar3S
 jiviPahoD5NXbB5MVmXdtNnsSmJ3+dBYCEMS7lGdk3hInFK/GmCyK5+Tif8bc36s2dXFTMwbW
 J8BvDez0AmuLlnI0G4bCzMfodihaD34nsNBkmA9f2n1nrNpz15RiJh0xt+bfRNplc6wMQFM0x
 0kvHHPrhW8+HxyBpyEBcPobQIZD7eIXhkaAzhI6MqoJva49I1+JV9DPhxnr7QwbIrAEwDYs5R
 D7AqLLnZLy93jJhhrFyYuMonKA5OnMHNqVN4AkcyNKMu5fz0d6LWCsvHml82MeCdzRarl1g5X
 H+7YQlQqJ8rJGtFmzZK/CYH0MBDG4mmmIP3GAhSuv7ihSyJoVchANd46oxCP4FC4VqbCZed/z
 zsISkrDkBG1oPkOSSMxVHYZezSmq2zSDvtRaMNpzsL1MA1xfRR9W9oRg7cvFbxWg+16IhSSsC
 EOWzq0BTc7sgC74mSkxvJds5uzLRz61jVT7oMlf0ye3K54N4ny8YC1F5NYOY0p0jW/f9e1tkk
 4OBfdtFreCZU45QRoI9LLhqUhfkbBwabkWrr73KnJmZzxrwEHHiQyoEY1e6DNEkd5EQeP/tVO
 zrVYUpEqCmxwqI2Mfo4ykwcMj9Ky6JrkW9RvaSG45/BXOX4msze2Lo=

> Add flags to support the shadow call stack sanitizer, both in the
> dynamic and non-dynamic modes.
>
> Right now, the compiler will emit the warning "unknown feature specified
> for `-Ctarget-feature`: `reserve-x18`". However, the compiler still
> passes it to the codegen backend, so the flag will work just fine. Once
> rustc starts recognizing the flag (or provides another way to enable the
> feature), it will stop emitting this warning. See [1] for the relevant
> issue.
>
> Currently, the compiler thinks that the aarch64-unknown-none target
> doesn't support -Zsanitizer=shadow-call-stack, so the build will fail if
> you enable shadow call stack in non-dynamic mode. However, I still think
> it is reasonable to add the flag now, as it will at least fail the build
> when using an invalid configuration, until the Rust compiler is fixed to
> list -Zsanitizer=shadow-call-stack as supported for the target. See [2]
> for the feature request to add this.
>
> I have tested this change with Rust Binder on an Android device using
> CONFIG_DYNAMIC_SCS. Without the -Ctarget-feature=+reserve-x18 flag, the
> phone crashes immediately on boot, and with the flag, the phone appears
> to work normally.
>
> This contains a TODO to add the -Zuse-sync-unwind=n flag. The flag
> defaults to n, so it isn't a problem today, but the flag is unstable, so
> the default could change in a future compiler release.
>
> Link: https://github.com/rust-lang/rust/issues/121970 [1]
> Link: https://github.com/rust-lang/rust/issues/121972 [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This patch raises the question of whether we should change the Rust
> aarch64 support to use a custom target.json specification. If we do
> that, then we can fix both the warning for dynamic SCS and the
> build-failure for non-dynamic SCS without waiting for a new version of
> rustc with the mentioned issues fixed.
> ---
> Changes in v2:
> - Add -Cforce-unwind-tables flag.
> - Link to v1: https://lore.kernel.org/r/20240304-shadow-call-stack-v1-1-f055eaf40a2c@google.com
> ---
>
>  Makefile            | 1 +
>  arch/arm64/Makefile | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 0e36eff14608..345066643a76 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -936,6 +936,7 @@ ifdef CONFIG_SHADOW_CALL_STACK
>  ifndef CONFIG_DYNAMIC_SCS
>  CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
>  KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
> +KBUILD_RUSTFLAGS += -Zsanitizer=shadow-call-stack
>  endif
>  export CC_FLAGS_SCS
>  endif
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index a88cdf910687..9bd5522c18e9 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -48,9 +48,12 @@ KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
>  ifneq ($(CONFIG_UNWIND_TABLES),y)
>  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
>  KBUILD_AFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
> +KBUILD_RUSTFLAGS += -Cforce-unwind-tables=n
>  else
>  KBUILD_CFLAGS	+= -fasynchronous-unwind-tables
>  KBUILD_AFLAGS	+= -fasynchronous-unwind-tables
> +# TODO: Pass -Zuse-sync-unwind=n once we upgrade to Rust 1.77.0
> +KBUILD_RUSTFLAGS += -Cforce-unwind-tables=y
>  endif
>

That's the setup I used for my previous testing at [1], offering:

  Tested-by: Valentin Obst <kernel@valentinobst.de>
  Reviewed-by: Valentin Obst <kernel@valentinobst.de>

    - Best Valentin

Link: https://lore.kernel.org/all/20240305112017.125061-1-kernel@valentinobst.de/ [1]

>  ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> @@ -103,6 +106,7 @@ endif
>
>  ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
>  KBUILD_CFLAGS	+= -ffixed-x18
> +KBUILD_RUSTFLAGS += -Ctarget-feature=+reserve-x18
>  endif
>
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)

