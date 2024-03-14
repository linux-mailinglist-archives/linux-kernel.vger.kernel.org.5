Return-Path: <linux-kernel+bounces-103788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8676587C47E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A71B2247A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEB0763F9;
	Thu, 14 Mar 2024 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QZ//2V5B"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C246763E4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449769; cv=none; b=EI704oORSMg/FZCQoplnjRa1vN8dIhEzuosLz8CLGWdAVikLgpRyRH05UfErln/bzi+qEPnAQqIwm9tLuvJcRrnW93MyRfu8gyZeYC71EnRNS3NU0JOVjYppg3hzB0NP5yDf+FK4+oOaxurAjDwgNCUtk0V8koXnC0Fkya2CTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449769; c=relaxed/simple;
	bh=pRHD+TcjUHkyggbW48f7epyoClmqj1C+KlHwQMyVxzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdFDJzGh/EvGdYKx0O3EMG3heaEyF5pHYRCQaDdLGvT4UccOJI2eFkqDpqIaZo32Y/0JmVFtDSkGGW9fggw6lFfsqGS1JfOg/Z+GOs/NQmmoOSCOW0Uv6GSuVrLLIfKgixxPQ1T1dass2XfYPp/4bonZQGkJmDtssopJFT+5CqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QZ//2V5B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1de0f92e649so8395255ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710449766; x=1711054566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRHD+TcjUHkyggbW48f7epyoClmqj1C+KlHwQMyVxzE=;
        b=QZ//2V5BqcGJc2rqpgzBZEdF/z5f3ZdvY3Llp2HHNI3IBGFCAdF/AobEQzrP9yToX5
         vPAww3vOF6VT0x09GAvsC2Eg7Oo5Q4vDsNPaGzz1SRUCZMu/G6/uzlpBe6PISeKd9EQV
         AV8dFihzMkGDcrhwwH8bdXfSKWlWBS5Amgkr1cSzGFhnWfnrSQS9nmRyAu3huICUFcla
         kn/IDYExg5zYpBLpCVzKR0mv9ccldPCk79r9pO2+eHkl2FsoE1qNihOGnuRqG9jXGWHn
         SpD3ALBERRQoLUmHSTz4/G8MTdxg6ka7Mz29Khcyezs1B9fgu59cxMS/pBp88rxTViQV
         qR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449766; x=1711054566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRHD+TcjUHkyggbW48f7epyoClmqj1C+KlHwQMyVxzE=;
        b=amyCWnXD3lhrYVyt/mGV3+vwT5dH+PHZ3bCfLNTXpwyULjHK9PbPQxVnKRF57VC5hR
         NL4QwwfRR1dC63UOswqRegBRNFtS3Ttm4+lEGXAmPChzuRjDuNxB5wmW2xpe0BcZompu
         1S/K+9zprXJKvCniG+CJLsrEewlXvaHPUL+jh1nMdhjawCP1r+hRCbOFu7Cbjal1STPT
         XWdbJ1gu4HuULEDq+lVaxM7z91+dbUYo7KQQyzd57zcFq58LqYqvI4x+CCtVDSdKvvvI
         e7ZQOo/tOfksKHbAk4/fZyXW5P3KV2nMm43bnCL+1dpH7gfhehNquLnoNCOgbF3wktBU
         7Rqw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Y2wTY3OUSYGv2JkqNSAs9uUN4C7l4+T2YRgBsbN7foYYJl4SrzcvRh5zCx3fNqBQrOwqoQ9Y5m3R6hG3q0v+aMuAih6RsnHhH7BK
X-Gm-Message-State: AOJu0YyXjUtBEYT+C9ytgQOYVxNT2pjy2bt09QmAG5ix6cq3ZtySrztt
	REAtWPLcrRcdmUQ9Rj+HatW7cfvP8nNxU+iXmNvgTLnwHnajq7NDusIN1pGjjlUda92oILTVtID
	jsyjDqfnpzhF3figgr19mxBzf2VM=
X-Google-Smtp-Source: AGHT+IHX1AyajLJTVHGSXYPwtKX+7yh7PG9wayr6B9dveZH+o9n5qK2EDhZ/7woQQgmNKPpyAzCre+qGGjjW9NMe9O0=
X-Received: by 2002:a17:902:780d:b0:1dd:b6c0:1363 with SMTP id
 p13-20020a170902780d00b001ddb6c01363mr2687465pll.69.1710449766557; Thu, 14
 Mar 2024 13:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710259663-14095-1-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1710259663-14095-1-git-send-email-quic_mojha@quicinc.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 14 Mar 2024 21:55:55 +0100
Message-ID: <CAFBinCC4k5nuwNq8kUub2kqZGNV=qmOQribnchuFg2vaKF3J3Q@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: meson-mx-efuse: Remove nvmem_device from efuse struct
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, neil.armstrong@linaro.org, 
	khilman@baylibre.com, jbrunet@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:08=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
> nvmem_device is used at one place while registering nvmem
> device and it is not required to be present in efuse struct
> for just this purpose.
>
> Drop nvmem_device and manage with nvmem device stack variable.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

