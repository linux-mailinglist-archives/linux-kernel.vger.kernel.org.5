Return-Path: <linux-kernel+bounces-39271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842583CDE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C921C2265C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFC21386CC;
	Thu, 25 Jan 2024 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMe0vKK4"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5F13665E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216382; cv=none; b=Mj0sg4I8LqJwhhA0kFufObg1No4GV5ARqJbZbrpKE4XyHPQL8eJc86M/mQLVCuv2e3/Iv8+bb6ZlToHt/4/hHNXnj5Pn+NYB5EhZ34vTspSNQx16Wv6wdmcpQvjGDwv0EEH1F9wfqQFJiVIcLGK9fCjSvrudeX88zEoP33ymS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216382; c=relaxed/simple;
	bh=kugWdLPRbZv+nvzTzXeYEHDhAGQHx+mp0pJFpgLrtHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiuvTHrCtxVRRk4Io7flrtMk0ovWrL3baZNV5H4AxV6jd1O0xPNsx+ES3QL6Wgj66rhJzwf8STGg0Rb1x1qq6eaZA4jE4JjJrpikAiBq7OWXtSReZqaa9su5aAUS7VwbmVQRSAL49IExlT/P6OOIf2v+vdmWhFKX0MM5CmWfzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMe0vKK4; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-361a829e012so17215ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706216380; x=1706821180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxhQjCPn4Rmv3lAxNtNAmeDVJacck3kwKzoL0OQKBYo=;
        b=SMe0vKK4SSoZ8TR2ECS4eYh2DX7n11XvgPG2OIGXfJf2LSunohim7xvl+TvkNOzMnI
         Pf37y0CNYNq5Pk0lkrGmN54EzrUZVezz9C2So+O0nhuKfmTVFjEyxl3MCTYUBhpCM3z5
         s/tFi9rRLwE0yYxx+++17WEAl1yVnrKY1hBLFm2BvZuhz5U8UEmQDVviVzm+kYNXDyRY
         rR82/b26bOiLhflumVwkStXiQlM+MEEoVy58JRawyt+eAWYxesZWwm9rVvQIfUOumLhv
         xA9RVLLBmkDRgeZGmorJWEIB2wgc1VfiYlOoYrOGBDuTm1NUsCooYzHDIHW0EsMc7nS9
         zSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706216380; x=1706821180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxhQjCPn4Rmv3lAxNtNAmeDVJacck3kwKzoL0OQKBYo=;
        b=Tbqn9P/w8T5pAd37xMdBgNpSWuUlhK2qMNHz+e86HXECs0GAnD7PdYA8mPAWsDigQC
         pQYzqEI7anReLze07agjSE8G6RUVjeW97j8A6Hq2KEXM4onCtzgezi611iROTiutUk56
         FvO8lq3lHSwWUx8xt8rt9uFMkPC/ZsZ9rNnZTPu4gZ1v5kxHfNzPDv5rd20fjP6FdPOP
         Lo5pBTiVCCPsmlbPCQsJBgx0Kdw2aGoMzCIY21+G36DesrLJqCttmq1+tmQr9SZy2uCi
         8NrVOHlsaSwIDY+fV0sz4KS9MXkgqpcGdQRQWyvXEjeODnmknf/WGDvNDHQmjY0gTXyC
         gM8w==
X-Gm-Message-State: AOJu0Yyhoxz+rHO2CJoKOpEcflA/HCmuafohQKA2XeMFtJUCMe5Wk8pP
	PKQsEZyZuoM201jpqehzvH2MhGMnPgX9R2ipvo6aS1LctRWhiuqmfUzu2fUxpToxz3NMi6QM1Pu
	1JuTSu3Pr1PK+uLBazmVoM5NrDLq3B04EAwiA
X-Google-Smtp-Source: AGHT+IH6w3OVXl5Xxvj+X6w0bhRST4tKM7ssjJkE4Ww6EnA/boQv6Rq+izaq72As41Kbl3V2NYqiU7fSbQrPhDQo8PY=
X-Received: by 2002:a92:d4c9:0:b0:35f:6f66:286 with SMTP id
 o9-20020a92d4c9000000b0035f6f660286mr3777ilm.11.1706216379661; Thu, 25 Jan
 2024 12:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125184411.30757-1-kotborealis@awooo.ru>
In-Reply-To: <20240125184411.30757-1-kotborealis@awooo.ru>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Jan 2024 12:59:27 -0800
Message-ID: <CAP-5=fXWALXbbDSv9rY9DN3vRy8aynk2MQEBCbqC7drP-Xzcrg@mail.gmail.com>
Subject: Re: [PATCH] perf data convert: Output empty string for null pointer
To: kotborealis@awooo.ru
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:44=E2=80=AFAM <kotborealis@awooo.ru> wrote:
>
> From: Evgeny Pistun <kotborealis@awooo.ru>
>
> Providing ill-formed input to `perf data conver --to-json`
> causes it to crash with segmentaton fault. There's a bug in
> `output_json_string` functon: input string is not validated.
> This could be reproduced by crafting input that does not specify
> hostname/os-release/etc, which are written to 'headers' section of
> outputted json.
>
> This patch adds a null pointer check. If `output_json_string` is
> called with a null pointer, it should output empty string (`""`).
>
> Signed-off-by: Evgeny Pistun <kotborealis@awooo.ru>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/data-convert-json.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-c=
onvert-json.c
> index 5bb3c2ba9..f8fd22bd7 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -42,7 +42,7 @@ struct convert_json {
>  static void output_json_string(FILE *out, const char *s)
>  {
>         fputc('"', out);
> -       while (*s) {
> +       while (s !=3D NULL && *s) {
>                 switch (*s) {
>
>                 // required escapes with special forms as per RFC 8259
> --
> 2.25.1
>

