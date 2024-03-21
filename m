Return-Path: <linux-kernel+bounces-110536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A89886046
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84B81F2369E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5A71332B6;
	Thu, 21 Mar 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UjXTY4ym"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6141212BF3E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044348; cv=none; b=hO+2JTXI+TYZ/Jtlo2P8ooqZQCjqkEIJwMMWnGUNK/MUFl4mBj2RaEEOa+Hcmbf4nLk8XQoTI6cQoBfk34YFV6cF9tgjjFeWbsau2ClvNwnvowe0ssRZNqIIU8GNg3stxsfkJYrYHNQJbj29ULf40BssFz9pQebwwKkjOzFj5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044348; c=relaxed/simple;
	bh=i30qiLYfNUY72DfrE1cT/dPxNGz6ipB+9wUBiDjUtho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW879J2wZgK5U0glpKVec9DPiPDEpPiXSHGHqPiNevcMlPfvt9KSwMsxmOwd/Bdb3S1SHQ1NXTneJrjha6cM+Y1gUem+VB3SlsSPJRAjIG7XlWvrfdiGeneJZ5ViIS1642GQ3/Sc31M97sabTsA6gOUXJQGCQ90+zdaRL8RzcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UjXTY4ym; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d4a901e284so28027501fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711044344; x=1711649144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh+H36p7va+V4Lc6HuD7WLMtjuJ+MxeQtzJ/2W8wqJg=;
        b=UjXTY4ymnQ8pHfFiOg5LFlLTK4gx2hjlhdNQij2MVaLfLQV9Km1vxSSo1DOnidt2O8
         zck2cn/UH4mP/IMHI49wp0iwK7b62cQMD9Fdx1fXigDzw0jGTQULqjjtfy+G4m9qh5ON
         vUDAZP3ZfuP61LH3fbfFrz1bsa5uEiAndJURc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711044344; x=1711649144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh+H36p7va+V4Lc6HuD7WLMtjuJ+MxeQtzJ/2W8wqJg=;
        b=e7L6fNH2PTixsVzO7nZugndBYxVDE4MJDtsTKf1I8K9M0vAUBa+o4MmpmZ0w0+DXkL
         +Q38A/4P9EoenLG6oVNdBv4mTHcZLGRsY1BOC/GYJxniPmbsK4Q5QjYyVy+y9gXNUBw8
         KBmSyZ618pWp3fR32rXYf8ItSb3admq6lWnbhnuFgcZ7ygkn+SOB/bjtW76LVgHwS9Zd
         mwmkwNh+Hn7w5nGarfnkLrzSDIVOyABTU0pHDgYkBiZniy4Orw23SBGAxY4VLsUdzIZU
         CDJJCA+j7GHr43B4SSd95HuU0iYC9lyKhPCl3SsCcBKXBqka+7qU9t5V8+MdiC5Dhj8l
         Zi2A==
X-Forwarded-Encrypted: i=1; AJvYcCUjS1Wc3e2wdoMI2mzYN3rCgT7VWz/0Qv42Nx64hAz4gfwJG0hy/eo9Ko7jX3b+6RD2cscO07gRRvtsA1VS7tkZcwMD9qga/pSqIzT1
X-Gm-Message-State: AOJu0YzV2zufiwtquL0Ly3jWbRLaFtWAjrE/W8SZ5XDyO0svO2IRAqC7
	nD/AmCOa5Cuz8aH5yEK6qkL4swxhUvir9r8aFx7Yn2EoPMOH3rGVmMEt5JB1EtSq455531RuyTi
	56iKWJg==
X-Google-Smtp-Source: AGHT+IELEf6XXnJnRhtiNovE/mXgElVa4eH7oAkiagbd6t8YZrz8NRKWXECq/TBTULX37MKI/TsKPw==
X-Received: by 2002:a2e:2e0f:0:b0:2d4:22b6:eee6 with SMTP id u15-20020a2e2e0f000000b002d422b6eee6mr230108lju.8.1711044344379;
        Thu, 21 Mar 2024 11:05:44 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id p7-20020a2e9a87000000b002d2191e20e1sm33710lji.92.2024.03.21.11.05.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 11:05:43 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d28051376eso26534821fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:05:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8QURUdOdhoyvtHq9cuUkyBE3tAKzm/51P/DTHjh2QXrHZuUs5/2yqqi0hTTIb7c3GlZuxMhMNtBvlaVn2/S0EVk2vtMFx+6JZ4B8D
X-Received: by 2002:a05:6512:46a:b0:513:bed1:5069 with SMTP id
 x10-20020a056512046a00b00513bed15069mr120672lfd.13.1711044343093; Thu, 21 Mar
 2024 11:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321125518.1675903-1-andersson@kernel.org> <yniwjzjynmyndzqglfmwpy2th3vtadmms6ifxqs2ojo7wr66ne@ydnr3rltaddn>
In-Reply-To: <yniwjzjynmyndzqglfmwpy2th3vtadmms6ifxqs2ojo7wr66ne@ydnr3rltaddn>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Mar 2024 11:05:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQA+Cj-_LtVuw-1n9jwrQ9pO8kVYBNNkA7OHHCDbFR0Q@mail.gmail.com>
Message-ID: <CAHk-=wgQA+Cj-_LtVuw-1n9jwrQ9pO8kVYBNNkA7OHHCDbFR0Q@mail.gmail.com>
Subject: Re: [GIT PULL] remoteproc updates for v6.9
To: Bjorn Andersson <andersson@kernel.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Davis <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Abel Vesa <abel.vesa@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Joakim Zhang <joakim.zhang@cixtech.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 11:03, Bjorn Andersson <andersson@kernel.org> wrote:
>
> I was further notified that this conflicts with your tree, Linus. Below
> is the resolution for this conflict.

Heh. This email came in after the pr-tracker-bot email notifying you
that it's already done..

I think I got it all right, it didn't seem at all controversial, but
maybe you should double-check.

          Linus

