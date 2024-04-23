Return-Path: <linux-kernel+bounces-155930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC368AF8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A48CB27ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BE8143890;
	Tue, 23 Apr 2024 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUw4umd8"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610E20B3E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908118; cv=none; b=ainRbpVvNhEcSIa5Qxe728LSrt5Hu2paJc5j2466gFt4B8voAchJfa7H/NycIsat/y5+fLMF3/ojS9jCN+bdFpoS0luLUwKu0luq4pfbzMyLr3+Kp9KvkdkN+/5LTBqZGM/1zX0Nsqhs1imjqeWGNkB4+JMYnaf95eUeaB2xbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908118; c=relaxed/simple;
	bh=5d6+zFSYJmyy3AfzAE2VOGKQ9Gjz+CHRK8T81rYhQAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dwqv235HhI/2RLJuBcW4tpv4D7S6Ub8rWzy9k2FVqYnYYPNZYfcTFw0QA/P7+m/3LoIJROmLblAbUR53BDNrEkJG3xTCvNOtrB/8t9e6vAgcEuIkKK5WpNJ4mYWDFBGt+rS0yyGM/k+btp2CEvc1tIszzmKGwMdWGnaAJtfcB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUw4umd8; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-436ed871225so40841cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713908115; x=1714512915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKGAmiBY8brLZk2gwaInIBRHzAk4kWqV70ABWJedJWY=;
        b=JUw4umd811VO1l7lKdoP63oKnCwdguD0X98vc+ecL+s0x8JGX9dwXpwu2FoauPmAiA
         gUMpWM0HcPlt3lDocAR9LjPF21nYZSb/K1BY2xoLTuL9HHXwqdBh/G+73J1g10MC14wD
         HmIpkN40Zdb6k209OZZ1yrRWJm46Z6SLZUr1WgwUSYY4TkSM8w2oaEzYEZ/jWSsE2ne2
         sJ0p2NFSklRQS1QxA2aF3ycF1sVjGyHrVYLF6Pa0oF08z+Fb5rKVdDMRaYnQK1yrhk0b
         XhnHvNZJu5+qV2N8DCoCPgM0UPOtPrfQ2+t1VFMMBaCIB63xU+Pf7s17WGjfvXmXRFLl
         4lZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713908115; x=1714512915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKGAmiBY8brLZk2gwaInIBRHzAk4kWqV70ABWJedJWY=;
        b=SKJbVVefR3S4cf2GB6vMWauE7WkdPMvm4HGBXYEI0bCbITlq4o0SCNZqKaskSOy13V
         reN2/YFEriAHlOx5bH6OfzfhcpqXRG5NefMbi3vAxGqYj4oPQppgMa+vWK98sRUbu08T
         WnTyOBNeBLpWVkraSug8bEZENOdc6g5ziO6pcbsWoNql1SCQZC8tco72GbwtV2Ydl2nP
         RRLDn7Dd560KENf73iFDM5gf6eP1bcfxntsUxWsgzBJQcxTxFMWZq+IJCWJbi8qLyhHQ
         VmmriNwiYweqmAT6Gh9BfOjpZo/X7gpkwXF66cV98chgMSYp+NlVmYsLPPtG1BnN55Xa
         YFEw==
X-Forwarded-Encrypted: i=1; AJvYcCXQVxE+OdbCxT+zAlMaYWVUHJsrnEjRpYTwUB22ZSkKe3hOQ6IlLDelHkFjaks3sxQaD54RJO7DCZRbLbvpvRZihXzXBZJ2cZoPrE98
X-Gm-Message-State: AOJu0YyRLECOpSO7g2LOreb7Kjd7U7r5n/zG5B5Yhjr8UZJwj6rcAeTh
	N9DUASh7+PcSPkAaWTyhLikNoKWJBB8tJzpE/1pMsMzebItDvQLaCDm7c4zgRi95sPEh3KeTJXq
	scgoXXxbvSgMRdsF1lgpUJyf4hkFgQQzrzFon
X-Google-Smtp-Source: AGHT+IEN/0C2sAZReHz8xqnlV3IYP+2lc0ishc8pG0y2szANbMQrigdNg6/nr4ZMmbBb2XxBZCYmy1wafPF+jzDsEe8=
X-Received: by 2002:ac8:45c8:0:b0:439:8cec:2f74 with SMTP id
 e8-20020ac845c8000000b004398cec2f74mr23573qto.9.1713908115562; Tue, 23 Apr
 2024 14:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423182701.38359-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20240423182701.38359-1-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 23 Apr 2024 17:35:02 -0400
Message-ID: <CA+GJov7BUm4BnWh9m6+hCQRBQ2OW=UwoB9z3dMcFWKRqz44O=g@mail.gmail.com>
Subject: Re: [PATCH] kunit: string-stream-test: use KUNIT_DEFINE_ACTION_WRAPPER
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 2:27=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> Use KUNIT_DEFINE_ACTION_WRAPPER macro to define the 'kfree' and
> 'string_stream_destroy' wrappers for kunit_add_action.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hello!

This looks like a good use of the macro. Thanks!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/string-stream-test.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-tes=
t.c
> index 03fb511826f7..7511442ea98f 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -22,18 +22,10 @@ struct string_stream_test_priv {
>  };
>
>  /* Avoids a cast warning if kfree() is passed direct to kunit_add_action=
(). */
> -static void kfree_wrapper(void *p)
> -{
> -       kfree(p);
> -}
> +KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
>
>  /* Avoids a cast warning if string_stream_destroy() is passed direct to =
kunit_add_action(). */
> -static void cleanup_raw_stream(void *p)
> -{
> -       struct string_stream *stream =3D p;
> -
> -       string_stream_destroy(stream);
> -}
> +KUNIT_DEFINE_ACTION_WRAPPER(cleanup_raw_stream, string_stream_destroy, s=
truct string_stream *);
>
>  static char *get_concatenated_string(struct kunit *test, struct string_s=
tream *stream)
>  {
> --
> 2.34.1
>

