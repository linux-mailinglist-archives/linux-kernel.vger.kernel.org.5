Return-Path: <linux-kernel+bounces-93868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E33B87360C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E91F241EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9317F7E6;
	Wed,  6 Mar 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCgebXBY"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7097FBC1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726749; cv=none; b=Wt76Jk0WB0VO2qO6R9aF0IG47lrvoWLfTtLFab4s0h/S70esUOgeL1BSyWvbyNTIUOTNLr3UMNVIP7s8NfXFi4S6E0nUorv9GQ9zwb9iEg3BkVO8Ab7qLgrrMLnNNUGgHe+oIsJ5UxVK80dQFMw0VYs1eTHbmI/VCf+0sLq25gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726749; c=relaxed/simple;
	bh=G2h6GxpF5//h2blrI86hP/+PhlQEWBbGNRiIcqGjf/8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFuNQ7WRmb5tJmXYSbNchVtcvmwUfrGq1y/vAEPibP+PX0fV0dtsQVtKGdzlCqDmUFULUprD37Al2jIn+nnBYDXfx5mqY2XMqzcp7DonivgrwiXhHGgDP1qAHueIY8fKiMGKscgQdUfB1GDW3MJU4ICrNkc3+5CbBimvEAhjbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCgebXBY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44e3176120so498569466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 04:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709726746; x=1710331546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQBd6ohf0amX1OsSt75FPx0/Dj4ojSvbJw4UdMmdjuQ=;
        b=fCgebXBYJimHJMxp00O/23sjiuNFitpMjZsaJr+t6q6WsXMP4XPGS4Lz5IjYEjB7kN
         c2DnCATa1OzElDPifJZjjvufaKVJfGOqdwNRU2CeOaZdYCWzzCMlsIQ8ajx1TuxKI+fQ
         ev65ybWNwJUFOE3Yh24ECvFK24u4ebuM/duhXeVoKxLSjWXIkRn2cMx6QcMxGV8WEYpj
         TS/nLoCvrcxajaNtl83q3/2ebk3YVBA3Dlc1+V/QTIr2CZXSkP9y1Rek5NtWM+kp9Au5
         3qkdO2btEyrw5IdlG6zugk3VnzNKpr2CxlGi1yrL83W6XGhbIGsWdt+FQpdbtvjPhoMY
         ZJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709726746; x=1710331546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQBd6ohf0amX1OsSt75FPx0/Dj4ojSvbJw4UdMmdjuQ=;
        b=RYf9opSZCF0pi48X5fQO1sfGhjUQudBO62ObGJuEKIxhkb2DoIFIP1vRAUbJ9i/lSP
         p62stmCVhQy95Cg43Yiwj8gAKJPUkXcudeBf0r7/WfIhTlaHhrWBVsBaSPSIY/5rnmFh
         LeyES8dpp6uonPlJH5QVeUyv+fUc/sEpzzn/C22rqP+EmM+1qSTp0YpWI44+N3Id8XjJ
         HfiAZrDDfjsV6WTA94cPFb6uiTXtOCb98iTNJY49bqRW0DoTc30BSRL7mm532TGa3pxA
         Bb3sHp+HdzcflKvdv+al9RNuDkeVHAh6gjq5OJM4WuB7enPtTqKeCoxEm1uEi45pGmDk
         fi2A==
X-Forwarded-Encrypted: i=1; AJvYcCVtsmvB3U/Sl4idmlwQFFu3GZXfKhwFZJtbyxjO5IwP2/k9bJAg+wLOOSHQFkBqdBgKtfVXoUKT7JDXIX6gKOeiU5BuV2chZZie4P5n
X-Gm-Message-State: AOJu0YwWqHmyWno6QdurbeRxKYfd1+0P0NR3E99Yy0Dor81ocuFAhs+e
	aCeWj9KVN3El4+UKizMuDY5nG5f8W2+4i6ZQtjUkOsPoWJDf58JKIRmAzRCAJw==
X-Google-Smtp-Source: AGHT+IENvyQtE8JoTg5kWVbQtkdALMsWYIyvhW3MrnxD6N4yBhPGZfzqW1SSMI9IG01/r9t2iOYJ8Q==
X-Received: by 2002:a17:906:b850:b0:a45:ad29:72e7 with SMTP id ga16-20020a170906b85000b00a45ad2972e7mr2827372ejb.36.1709726746372;
        Wed, 06 Mar 2024 04:05:46 -0800 (PST)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7072616ejq.91.2024.03.06.04.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:05:45 -0800 (PST)
Date: Wed, 6 Mar 2024 12:05:38 +0000
From: Quentin Perret <qperret@google.com>
To: Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
	Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
	Android KVM <android-kvm@google.com>,
	Patrick Daly <quic_pdaly@quicinc.com>,
	Alex Elder <elder@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Murali Nalajal <quic_mnalajal@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Carl van Schaik <quic_cvanscha@quicinc.com>,
	Philip Derrin <quic_pderrin@quicinc.com>,
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: Re: Re: Re: [PATCH v17 19/35] arch/mm: Export direct {un,}map
 functions
Message-ID: <ZehcEqvC3Y9YytNi@google.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
 <ZdhEtH7xzbzdhS2j@infradead.org>
 <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>
 <ZeXIWBLVWzVycm0r@google.com>
 <20240304094828133-0800.eberman@hu-eberman-lv.qualcomm.com>
 <Zec6shyjblcZvTG0@google.com>
 <20240305093131473-0800.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305093131473-0800.eberman@hu-eberman-lv.qualcomm.com>

On Tuesday 05 Mar 2024 at 12:26:59 (-0800), Elliot Berman wrote:
> I still disagree that this is a Gunyah-specific problem. As far as we
> can tell, Arm doesn't specify how EL2 can tell EL1 its S2 page tables
> couldn't give a validation translation of the IPA from stage 1. IMO,
> downstream/Android pKVM is violating spec for ESR_EL1 by using the
> S1PTW bit (which is res0 for everyone except EL2 [1]) and this means
> that guests need to be pKVM-enlightened.

Not really, in pKVM we have a very clear distinction between host Linux
and guests, and only the host needs to be enlightened. But luckily,
since pKVM is part of Linux, this is pretty much an internal kernel
thing, so we're very flexible and if the S1PTW trick ever conflicts
with something else (e.g. NV) we can fairly easily switch to another
approach. We can tolerate non-architectural tricks like that between
pKVM and host Linux because that is not ABI, but we certainly can't do
that for guests.

> If we are adding pKVM
> enlightment in the exception handlers, can we add Gunyah enlightment to
> handle the same?

If you mean extending the Linux SEA handler so it does what Gunyah
wants, then I'm personally not supportive of that idea since the
'contract' between Linux and Gunyah _is_ the architecture.

The only ways I could see Gunyah delegate stage-2 fault handling to
Linux cleanly is:

 - either talk to Arm to introduce a new ESR specifically for this,
   which doesn't sound entirely crazy to me;

 - or have Gunyah and Linux negotiate in software the location of the
   handlers. That probably means SDEI or equivalent which is a can of
   worm in itself I presume, and I'm not sure how feasible it would be
   for this handler to live in the Gunyah driver (that too probably
   requires exporting kernel symbols we don't want to export).

Thanks,
Quentin

