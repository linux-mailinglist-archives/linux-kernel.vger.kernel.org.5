Return-Path: <linux-kernel+bounces-152676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01198AC2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401FD281404
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0564ED272;
	Mon, 22 Apr 2024 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS1ILjDS"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4CB79D3;
	Mon, 22 Apr 2024 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713751376; cv=none; b=kY6SLeZc6f+ukSTbepLXvBU/6/aKNpD4olMOIqC8ion1m3R2VA2MHkDkm2EKkUm8G+LuBU9Gd8KY9Y0V7S+dWhc/JWgR5iypbrCmL7+35sQbtV5rSVbWcMNOkxkkWeK4tbX1ZYbc6HyACDId1e/s2IyCnJv+vWdXZNX3ZVU8QBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713751376; c=relaxed/simple;
	bh=gX58Kqwb4ETkW3PNNVNBEZm8HOp4ZVyZ3Z+Q1hS32XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMgLPV3mj/j4G81ptGIzhl/aUwFEYtSFRC2suiyx5XkdvImOjOlH3MUjOdoutleLprl22FoaT8qDdNbONEt1cS3gLV4C2s4VXt06As5qeDQyAbq9bCeT3kdsDR666wdtexYtMUPuFTAggyQR6XpLarqDjlpmsniNKoD9gIbZGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS1ILjDS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-617d411a6b3so32883077b3.3;
        Sun, 21 Apr 2024 19:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713751374; x=1714356174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rCd+3oGFPLNxJ/lF2Elx3LOmcNWWnGksUlsqddWG9M=;
        b=YS1ILjDS0SH36/GKd1t+zvqDUKawmO31EAp+RMbaOMUL0Y1DaGnLrSbPfeONuBlvxd
         LTxD7PDgeapshiUhuTumOG+hWjPn9lGnQ6MFVU8Fwv98YIJH709OF7vg9x0KVQlNbBfW
         He/BKKonDCUdNOJwEGV22lanXuh25AGmtKN3IJbwicUmeeUIkyR7o/TlHGWK9CXXOBF0
         qviGYAL4TZOLUcmKlq9IVITHW7jM8qc1T/yIWgo80So4hhzdFq7LfcVcjrMJ9AwxKmZB
         BLUt9P5jws4P8M9C6ngYANHNgsVN3LTkhAubLqFQ3YhCNfcd3amkYfKDOOwl803x9gyr
         K7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713751374; x=1714356174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rCd+3oGFPLNxJ/lF2Elx3LOmcNWWnGksUlsqddWG9M=;
        b=Qt1s2YDqn3TNbaI45QGkbQ2Br54+GGllhDOLprveqH6Vq3t+O8UNTOb7vYGRW05SZ4
         46kj+ZEIjSbqHVM6syFTCn5gklE5h6EUZDTLhf/3d+0OKH/D6pKvF7qYIMWJ24fiqJR3
         U8a0JD+uAdOz5wbj7hbINbe+zhx3cGg4T96ICo9vB+DWgJEX3Qt23IUrHeB3SoY2tfRU
         vx+7b3dmXpCEEM/zuArfHZq0ASDZnrQMtbHw1tCUHzfd+amoo9Vg3r4jdjnDia7RHNkL
         fZXN9QELeMIVGVQTX80hbNWXQ6nwW/Fla5jxWk4h3r7iy4om6cikjg/Mbn/3KKFHREcV
         O44w==
X-Forwarded-Encrypted: i=1; AJvYcCWV/3CYisVBllm/1n5OulPY7eSLCg0johpiuG2JqdzxCSVkK6OBmv6gsNvWJr5LXwzcPJuckpF6G2l9zWmLKDkBo5zb1B3fGpkUqaVTofLTbhOHEGMTvBRjAOTfODHlzbx4ChAl24jTQl3N2A==
X-Gm-Message-State: AOJu0Yy18Vd6e+O+ZJtyI8t7YXE8LwZ44EWAPiSiyo3zvMcIntTcNHdM
	bgdicf2rLp3jfPDc4VYOWf5scY0wfRkTw2n/3+BbZIZUSNUVdZvhocZkpkVVU04lEf5q5yDW9vP
	2k/dIQWtGnyTGkGiLe8rSw38/YN95uTy6Cn4TfRjW
X-Google-Smtp-Source: AGHT+IFhNKH1ucZi/kC1SXz2zfN2BjNMtrLIppGo/tv6NzQ/hO96DTo8DIjfFVwcB6/X5VASl0l1T/dI/XFc3RNDbVs=
X-Received: by 2002:a05:690c:368b:b0:61b:3346:83ce with SMTP id
 fu11-20020a05690c368b00b0061b334683cemr9549761ywb.15.1713751373879; Sun, 21
 Apr 2024 19:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417053530.30995-1-wangyao@lemote.com>
In-Reply-To: <20240417053530.30995-1-wangyao@lemote.com>
From: Ainux Wang <ainux.wang@gmail.com>
Date: Mon, 22 Apr 2024 10:02:17 +0800
Message-ID: <CAPWE4_xp4YNdnkWnuoH85TM7XBxF6f4k3Q0wWKe+D0tjgyJtRg@mail.gmail.com>
Subject: Re: [PATCH] modules: Drop the .export_symbol section from the final modules
To: wangyao@lemote.com
Cc: mcgrof@kernel.org, masahiroy@kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, everyone:
Could someone review this patch?
Best regards,
Ainux Wang.

<wangyao@lemote.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8817=E6=97=A5=E5=91=A8=
=E4=B8=89 13:35=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Wang Yao <wangyao@lemote.com>
>
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> forget drop the .export_symbol section from the final modules.
>
> Signed-off-by: Wang Yao <wangyao@lemote.com>
> ---
>  scripts/module.lds.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index bf5bcf2836d8..89ff01a22634 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -13,6 +13,7 @@ SECTIONS {
>         /DISCARD/ : {
>                 *(.discard)
>                 *(.discard.*)
> +               *(.export_symbol)
>         }
>
>         __ksymtab               0 : { *(SORT(___ksymtab+*)) }
> --
> 2.27.0
>

