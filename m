Return-Path: <linux-kernel+bounces-126999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E8894599
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD57281B16
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0038D548E4;
	Mon,  1 Apr 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yjSW9Puh"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C653E1B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000432; cv=none; b=kFB6zX//jRO52s719L0rxHAd5TUzBs0WkE00z1E1T+LTQaEMFciBpGW6kXnLrcbMgSps1ayGon07cEkEJo9EskQTutZrTiyljjs6jzM8gYlaF7oH0bpLrSw2nz2jibVkQw/WE1VlrDOkDUXEMwtLbSRUfhPrQlaxY/HM017FvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000432; c=relaxed/simple;
	bh=l0Z6BGOa6aQ3LzuruVpcOIFCOQoft5ykkCp4c+D9ca4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA3+s8FZ8bfeKcK0QX/0S2f/dXbhqavzYZagZbV7e/4KcBWsGrqa17OsnCRjyahKDo1eQTjL2tnUxCtNgYtn4sXCkbzSkOdb0DBZmR4q6sT+5fNM8PfCfVfClNO4kCLzfsHwZVwqlnURf18FxK/Tl13W+myeauYoWdvd6xQvBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yjSW9Puh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so61733131fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712000429; x=1712605229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0Z6BGOa6aQ3LzuruVpcOIFCOQoft5ykkCp4c+D9ca4=;
        b=yjSW9PuhLmF2rczI2BlI6wkDGe2gcdZiKBQZO5vvvMxaJAOQPaYCcYC9O/Yh+00cBz
         uEGfmWuPUfWJzUCOpkwr+tuA2lxbxpMUGCdAVtetDeZOL9jeSwDWbi2WT2BFea2bjyW7
         lVIwx401xUi8pIPtTFKAyJtVz+jhfdTMFFuKxNYuKKCytgYaKY5UaCrWTFAbczMAt2C0
         ka1y1wf9l8h9gleVWyy/818gGpe8fcykMMqRP3+D4PnXzH3Io89LXKsIqTZq8s9M56r3
         kNqIxTuelmjl1E8NWNRU9JlVMAl+hJq+Y13Ke90XJjFeSS2Wr20KALFJhH7CxztyAYRO
         iydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000429; x=1712605229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0Z6BGOa6aQ3LzuruVpcOIFCOQoft5ykkCp4c+D9ca4=;
        b=pIztJ+ymZy4HRdtBPLNPwFAgRRfVlLV+yJ6AcbpIYIR2AqV6n3/GfhRq9ykM7ExmzG
         x1BAPzSWvsCYGo00EQqTRfREhyYzXnGVDQlFb770u20Dh1cdoFt2egV44hWPptPbgTi+
         s9Qkl5RoEzjcmwQDvzWx+DBzJc6rJRHq24BeF0Diop2EsmGz8sEVUlqQ3UPRAHDN68IR
         ubIc5ZmKPEXwM0vIKSzYqgKc3x4IyezViur5/q4iPqraWupNtp5iyO8zbtzuT71EY9G8
         0O/LL+4tuSRpNGAAF+5NZl0iboQxuE1crSpLXHi5eyGiyXwU9BLR/C+BJK94gx4f26uS
         CIVw==
X-Forwarded-Encrypted: i=1; AJvYcCXVAaSF1YKpy6WLhnmLwmRRCkzzWXpCWhl+QhrSz+whmgLxmIV/THDrV12BS8Lb8Ed1UedK3ZHDo8sA+2JbbZhTGV6/Hel0n9klrOPW
X-Gm-Message-State: AOJu0YzSFfzP8Udx74zxgz/NIqiaDY600Q8NWUpHgVAzjDfbeuu5NCOF
	qCSP6+BmWiwPw6tv/L1Hfl91iACtdDYXa3XK11N0mGofiWmz+Q/pEdTCKoPR+GBfSTiCj5ynCWV
	W8fMUb6WsalpymAOJQJuZM9L3GlRHHPMmeFUKzg==
X-Google-Smtp-Source: AGHT+IFl6bzue3XRZCycrKbfasb0UTboZ3/Gvf+nMAgRiEG89W5cAu7gDepSOQQdI6cKXe1iJqAsYE9kdjEaNXBp2/I=
X-Received: by 2002:a2e:7a16:0:b0:2d4:d78:b05a with SMTP id
 v22-20020a2e7a16000000b002d40d78b05amr5775375ljc.19.1712000428742; Mon, 01
 Apr 2024 12:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-4-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-4-34618a9cc502@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 14:40:17 -0500
Message-ID: <CAMknhBH8UEPSyYiyMPo4en4vcjnJ7_W5q+iJtMOhdp5eNmP=8w@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ad7173: refactor ain and vref selection
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> Move validation of analog inputs and reference voltage selection to
> separate functions.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Same as my comment on PATCH 3/6. We would like to know why this change
is being made.

