Return-Path: <linux-kernel+bounces-49628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F4846D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCDB281B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB07A723;
	Fri,  2 Feb 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WeNtsJI"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409865BDE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867871; cv=none; b=pGnrw/ZZEH1DQv2ravFQn1X5kwi6D1CDtgozdD/m6ATySuuN02a/306uGCgo+F+v1FQoyQYMFoXS0ybU0MUBwSrTUqfxkhw7D1/KB7TGGfO3WtAGAI6IpjU239IhZTS36VudnfyT27GdOZSoJuXaxyAJxyPizSAlVCN+716E1ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867871; c=relaxed/simple;
	bh=RRNstcIluuEvvN5q92z4aRkcZ8MPGT3aLb5LKkuQEjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+p8Kn8Tzmr9nmydRF2zcS7BgrTLkPMvElozzTzSz3IJOz/KcXYnVz7FBl1v2nGVhErEHnfinQ/ZpY/QuSOYMWMl5Jfj7j2XEiunnelSwL1lVpCnSlpESggCOiWbKuhFz5qsFP++iHwhpQUCUwGtKwPx4O4n5OLXzKDC+QBFbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WeNtsJI; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d2e15193bbso947114241.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706867867; x=1707472667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQu4+TF2VOv8ovQWnIde7uGbT9lKBnDwIcv4xTfRr/U=;
        b=2WeNtsJIOyhyRtf5xVM1M67GxVS4hIF2B5bi8WITGqbL5zCPMBaz4PPLe2VOuSWuad
         Zxme6GUUjTB5ke3gmdDQrMIO/VuV/GUoZmoBKwebSa0TNxxyjJe1aTIct4JYlFArFuzb
         aT1hI2VMFqIkoajjRXKAtwlJiNiUlXaYu+Bf2rpdBS2+NIQDWIuxRTlGqJncevPCilpQ
         wb/E6pJLDX4KbuEuxoeZBnmSIR9na4WMKzicEuys7JZPBVJBFCxKKjht6LwW95SNqF0G
         w+Io3CQ8tip6NpschL4AU59L2TQcYjF++d/RwgsWZUCreDo94ZxixhUIulsz7s+dSf+S
         d5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867867; x=1707472667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQu4+TF2VOv8ovQWnIde7uGbT9lKBnDwIcv4xTfRr/U=;
        b=JEjBNb8T6rza2g53uv/mquDhkFPPWWq662Nb+/uo3SujICKzTTnhqckD8C497OybU+
         MaCvgeiC66NeCJyP747LtBztpQdCQ4IYHy3rRIcYvyGiEcOXU8vuzt29wMZUI9TZVDFq
         LwT47sZxPnGPSbRsXsSPvFSoNLpwPwFB8f0l5nxRvzhzHafCvlfDW39PJ9qChDlhITHb
         u2Wt76ovoQQrB/bDYqgzq2JBqifCyp2Q+TQmD2eypgEbyDvSiU3II3Bh84qSeCUo52im
         0+8LP20AWSMzQjEobOeddQoSiPvKX44frfCmv8hBy12Lex0qHILIKjYzYrjJEwbyfXoU
         j5hA==
X-Gm-Message-State: AOJu0YwWG6bnvNeacnq9dzLA0YkedUroCiVuINzm6l9HzSCiIFpS8VLt
	Tz0q6XS5PeAhFvfVpNosqsQ62gyzLOGyEsIpGelBJinzuKnH+Kg722PpO8BiUt5BJl6hfDoNy9j
	jaBb3QqXDj9pQU51w6S7b84CVu1UGf8S2lMcjXHVW/qhsAZrpbQ==
X-Google-Smtp-Source: AGHT+IHTiJLAxvje2qeRnYi2ylfwu0CGEMli5/Oc9gFFUCxF9OtJiu3BECSx1oy2M3xdLanJWbD1dRTko3CfBgGQbcE=
X-Received: by 2002:a1f:f4c9:0:b0:4b6:bdba:8460 with SMTP id
 s192-20020a1ff4c9000000b004b6bdba8460mr1408577vkh.9.1706867867177; Fri, 02
 Feb 2024 01:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202094550.work.205-kees@kernel.org>
In-Reply-To: <20240202094550.work.205-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Feb 2024 10:57:11 +0100
Message-ID: <CANpmjNMCBvdM7Ni+vWCQwtJbbVskOdjSA+gjhgh6R3dKRqjXnA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Silence W=1 warnings in self-test
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 10:46, Kees Cook <keescook@chromium.org> wrote:
>
> Silence a handful of W=1 warnings in the UBSan selftest, which set
> variables without using them. For example:
>
>    lib/test_ubsan.c:101:6: warning: variable 'val1' set but not used [-Wunused-but-set-variable]
>      101 |         int val1 = 10;
>          |             ^

This is the shift_out_of_bounds test? It looks like the neg and wrap
variables are volatile but the written-to variables aren't.
Technically the compiler just has to emit the reads to neg and wrap,
and can entirely omit the writes to val1 and val2.

Does making it volatile fix the warning?

>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401310423.XpCIk6KO-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 6b09731d8e61..bc36a5c167db 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
>  obj-$(CONFIG_TEST_IDA) += test_ida.o
>  obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
>  CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
> +CFLAGS_test_ubsan.o += $(call cc-disable-warning, unused-but-set-variable)
>  UBSAN_SANITIZE_test_ubsan.o := y
>  obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
>  obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
> --
> 2.34.1
>

