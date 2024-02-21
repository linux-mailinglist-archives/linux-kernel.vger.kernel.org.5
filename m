Return-Path: <linux-kernel+bounces-75051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC6385E234
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF981C22F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1B81742;
	Wed, 21 Feb 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6uKue1h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4180C11
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530991; cv=none; b=Ubr2+/32RaR1pd0DByNvjlDVIpGW164kRtQjARXK3e9CtVkEW/1jgFsaYEaJojHZ/o1dERe92A9pJKHVHW9N8mepMcYimeXRVzgGdugQNr4ib5tqNE6pbqZuLqMZM2aJCclOt7fUlvtNQUvJ2r0U3kvZXA8Wj+yldJdETv3f8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530991; c=relaxed/simple;
	bh=DxXEaPs1AbpSUHOuzvn5jW4oK4LHIugbcpGp7aTcqGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+ndrzuWC68RwbmgqJ0Axj0bJCnOVrTKBk5WzGj4gYYisdKzaQYZ5Q274LoCKdLN/Jykzhus77H12mh7bYHZYJt2/MgOCQA1tA8DspIyIT2QCETsoN+zb2Iyoo96wBwjU5yxaqtsEBM9f7Uj6dYLbtZXKdNG8eaLtQt6f7CotvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6uKue1h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708530985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxXEaPs1AbpSUHOuzvn5jW4oK4LHIugbcpGp7aTcqGQ=;
	b=M6uKue1hJyKHbkmAXnO2TxM0ht9ZD3azll64bDBD93JAFW4b7bBPLYtKKHMt3D/tE3dD3W
	XdPxmlAiX+xBAaASfM2MZe3DrYajUMDqEfO4awnWG7gKWiVkWYYCKU6/A8MTNMcDLPb5gY
	TiP90ApmTtcwpKLsYBjURgkMJ7lRVts=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-1DOE-IB4PKGYaucaHZEUdQ-1; Wed, 21 Feb 2024 10:56:23 -0500
X-MC-Unique: 1DOE-IB4PKGYaucaHZEUdQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7816e45f957so128107085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530982; x=1709135782;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxXEaPs1AbpSUHOuzvn5jW4oK4LHIugbcpGp7aTcqGQ=;
        b=TTg609BHflZN170YJvW00/uOoJmflkpGNq1Iq3M0Lg91POgBPq4nGSbuGC4vyvnFEM
         ufLkLCZPicyFYWaaQ7a5Y01ZD7N8Udl/L+OQ1Ats55u+69Y4zZzsnjRmC9CGRxMKR17L
         whk7sZZe2rWie8ac2usyVd8pShzGn5FG2c2h39OeX3gbS9NLGVlbwpJ8MefxZtaGzxcN
         ZsAwgXa5q2ZhAVTRZec4tmZGTM57ToyByu2tMrO4gpHjer3Xq0jnj2F7Nr1YowS+9hs7
         jNyBfH0yaUBM+TWMwJeg3nBcwjLhyWCX+G5Vklzli8W8U2VbV+rVhvXC4DMUNJykuXjH
         24iw==
X-Forwarded-Encrypted: i=1; AJvYcCW3lZmv/bZf0ghrcN+EVTbUHvqmLgxVWeECAPIFfgrvsPKmKpT5K3RpRaHTEe977F821LmFhcEngYGdkh21m3D/PygVqqOYWJk2hqMM
X-Gm-Message-State: AOJu0YzTt128cp0ufaRl5Y6jSepSRZCaFMabaYaY7hdma+YEKDW5r7fN
	d4Fdq21S79uuMdRlm3dBNsWkuFqwauJEq9cCFX+jRFN9yS4CTlMgf9H4PVPIB5bqzAHJBDY5f9X
	ZCk36AdEKj3TEwwCal2N0SQm+0fL2cidvp8FeGvfJa27XHfGyzD6vVD5FDSYtr/mqvGrCvA==
X-Received: by 2002:a05:620a:55b0:b0:787:747f:21b1 with SMTP id vr16-20020a05620a55b000b00787747f21b1mr7053298qkn.55.1708530982434;
        Wed, 21 Feb 2024 07:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOyjUl4IZVQ83TH6JGu+4yiX7k92dlbC7D3VEBhgZ9b2Of/Uqmh5YdT90xy5fe5wOxL0IXMA==
X-Received: by 2002:a05:620a:55b0:b0:787:747f:21b1 with SMTP id vr16-20020a05620a55b000b00787747f21b1mr7053276qkn.55.1708530982206;
        Wed, 21 Feb 2024 07:56:22 -0800 (PST)
Received: from x1 (c-24-2-114-156.hsd1.pa.comcast.net. [24.2.114.156])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a0e0b00b00785d538aebdsm4409941qkm.95.2024.02.21.07.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:56:21 -0800 (PST)
Date: Wed, 21 Feb 2024 10:56:20 -0500
From: Brian Masney <bmasney@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Maxime Ripard <mripard@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	Enric Balletbo i Serra <eballetbo@redhat.com>,
	Erico Nunes <nunes.erico@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Message-ID: <ZdYdJILy9_anIsrr@x1>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
 <56625c21-1b34-479b-b5b2-4c4d8b7a11b3@app.fastmail.com>
 <724jnhrbs6r4q6whynr3aon5w7mhfvetlgcnts4nukvtxbuium@mrjv6apjqk7r>
 <8ad96253-2053-4dc1-8dc1-d01d1fa36877@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad96253-2053-4dc1-8dc1-d01d1fa36877@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Wed, Feb 21, 2024 at 04:53:26PM +0100, Krzysztof Kozlowski wrote:
> It would be cool to group also all the per-SoC needs in dedicated
> fragments...

It would also be nice to have a fragment to enable the various tracing
options.

Brian


