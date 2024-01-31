Return-Path: <linux-kernel+bounces-46961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786478446F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2911F21FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71311131726;
	Wed, 31 Jan 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T1YFQZmN"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429C12FF78
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724974; cv=none; b=SlazuhIRr9uoyiFa9uZWSWNYf9T3vqQJwGjN+W2Qiuu2oVPqF1hA6lcQHzHEB6UG1d/J+DPBpuuUeU0XpREW8PJf7veVS/cL84l9gKlX4khCXj0Tz9lFO5WsQaHznMyCRfuKFa/I+tDexk16W9G46zp+HjkQZP0qHbCkcC5CrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724974; c=relaxed/simple;
	bh=/mfGS9X1Fycipj1MsHNOiH5qZ7z+osYJL/vQLEyENj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuuL1ZtJwX39oEmIfdeZLLYrVfDP3iMVO/ERy0hObATMZR2rkhQdsUOMTLLhCd6ewNM6zW3X9PyAkeOqBV0O0xK0eUpzCTqnfZ5lBTi5kHFww4WNTl1dVstA+EHfQyLd6kRT2B2V8xlaS1COz3m398tF4DKAkDHsdjbo1BQulTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T1YFQZmN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5112a4fa97eso27975e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706724970; x=1707329770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDo8R5256piwYk4oa+Bo0H2/lJ0uAashjVqOCdQYzwE=;
        b=T1YFQZmNc7c1Uj9uGkj7qeDWkTqAmqBzhu1SdGIXFK70VijUSsEQ+23d77uYMZ78B8
         pvxP0sYJuJnZOTuvbGiv6e2gaHZ9e4/theC+K/AtQQDcx7HkCq4lNrAz72Iwl69gy8Bh
         IO4Nc+VN9G1xHc5ALe2RcuqWuhneSRtv6w9lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724970; x=1707329770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDo8R5256piwYk4oa+Bo0H2/lJ0uAashjVqOCdQYzwE=;
        b=n+vCFojf5YzZoyI0vqgkIhBwb6Frgk4xefaq40OrcVG/9Tynl3rGcz/kbtee48+wcx
         U7G9OGw8gTE0lTBD8CaF8WX0ldpL2+9bcHiBnMTAQuSNTMs76kzPmk3i78ddymamL2rB
         UtRukhvXduV6z8uYk25IVmBfJJIzjs/SmsDfX/joA0YYd8PobR/3upTPMr4E2qggk+QB
         wOw2b/WUrrrk/Bm3ugI9JaqBjrlGGplhtAHTRPJZVA2CWch5kyMk5X/XO8F0c1e2A9Pb
         QFsjMq6JaTuENpmbrQpNdrtBF1rXT93QFw3wEs7kq5VyX85tnphhxZJizy+QijEU0Ebl
         D4cQ==
X-Gm-Message-State: AOJu0YzyJb8CLowNaW61SAn9C94s/kUVWJ55MdknRy0Gh8khWhRlekVD
	JKAjgdQW6tD994YvTS/Sb9ljcFEhTRHi00aoXaM5wonn2XZXOYkO0AAIkgL1g73Bul/tBqN7Hte
	FCxw=
X-Google-Smtp-Source: AGHT+IHniKSbx9QPd/sUXp2sqHLFOusdRXlDoWpWPj3gPctEDmykgMu2iivYdDv6Q6DTnN6bu+LRUA==
X-Received: by 2002:a05:6512:70:b0:511:b86:35b5 with SMTP id i16-20020a056512007000b005110b8635b5mr173970lfo.9.1706724970489;
        Wed, 31 Jan 2024 10:16:10 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t1-20020ac24c01000000b0050e94329e7csm1909660lfq.269.2024.01.31.10.16.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 10:16:10 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf4d2175b2so1670851fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:16:09 -0800 (PST)
X-Received: by 2002:a2e:b165:0:b0:2d0:5dc4:4e30 with SMTP id
 a5-20020a2eb165000000b002d05dc44e30mr1825739ljm.21.1706724969503; Wed, 31 Jan
 2024 10:16:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c350958c01b9985e1f9bf9c041d1203eb8d82b19.camel@HansenPartnership.com>
In-Reply-To: <c350958c01b9985e1f9bf9c041d1203eb8d82b19.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jan 2024 10:15:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0GUPoBWr2HsKy2WhoJykadjCu1acH=qxQt23KYLJ_Ww@mail.gmail.com>
Message-ID: <CAHk-=wi0GUPoBWr2HsKy2WhoJykadjCu1acH=qxQt23KYLJ_Ww@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 6.8-rc2
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 06:12, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> 6 small fixes.  5 are obvious and in drivers the fifth is a core fix [..]

"Math is hard, let's go shopping"

Although I think even teen talk barbie could count past five.

               Linus

