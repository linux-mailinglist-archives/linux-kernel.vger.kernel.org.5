Return-Path: <linux-kernel+bounces-162621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB74E8B5E25
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5C31C20FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE882D69;
	Mon, 29 Apr 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Axq7vMu1"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0179982883
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405976; cv=none; b=ifzh2ydpMLpfPZ+5J8b+MMZI6pI+L6fFWrzdLhIp+75oUD/kCrxgo8vt0NEq5egm8Hsk2NYpN+HxtbMClv4T5sGRnIlZ6aWasKpuQgmW07QziXeEis9qrzRFWAV0m7X7rLeUi/c7y8hHT9sbO7W1QXLxyHkL9JREhDo4uNj+7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405976; c=relaxed/simple;
	bh=aqoYe7y596ceK+s22lTo4XTQ8iUewNNdVUJJ7YKSWzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6+bKCFIE9rtXJOkFz7pdKztRtxg12AeSEY6lGuSAytaQ8eKrvETJYrKbYgQ3ybWWALpnwkwlMTaCtDa3H2g7YHsDh+cPp/v0Bv/nM1SFo6DNI9ASrCoLgKV9iWxMzmEO1Ti0bVHLJf0bOPDVs9wvKood67zSCniUwAoEnGir1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Axq7vMu1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso3873638a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714405973; x=1715010773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lFVEj2ZOMp4v4mEsTFyGvr2pXAnpMOWy7SrvsDmidk=;
        b=Axq7vMu1g1KVCC4WCL2wHEtdq3Uvm8NniZyXhKp4JN/gwfwKfhBSRR1EgG7sDdltw6
         G5K6zuRF1yPWg/RBX4164DdOHpcWIOkQQKKLHR7D4XGmo4Dd1Y4DiWGqvm3bR3RbquWF
         8TcXS6RdVfIC4cDOiT/2QqSCOchBi9GD221Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714405973; x=1715010773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lFVEj2ZOMp4v4mEsTFyGvr2pXAnpMOWy7SrvsDmidk=;
        b=mXx3mCvLWlrp74Gmc+4IoZBGU5SCVPYRLwRLOQyyczTE21ddX8oO9mWlSEus+9JmVw
         YZleWUhMDxbrYQpCRgE3k1w5yV9Qi1Dhw2xMIaxKyn94d4hlVgVBMFpzXXPKPiJQzffs
         PesxHsDprQu9hICB5afWCs44RFnZOAFUsDpDqVK7joR3aacL8mh3a7ij03cnTVJtFZsw
         L7WKv/OTmj+cps09In/m+54mmKbV5g4QCe+O1BVhik8KcbRp2ACvGbjEL6zV/A7TMpJ5
         MnDWOcC5lk45sMMzcu3qfP8WnTACxlcJcr5fci6uFnxDA25zntlMUMniiStxu7TvFo/f
         FKgw==
X-Forwarded-Encrypted: i=1; AJvYcCUCmQsQYcH1ttfBnkK+64+fx2VFpDppx6L/abY0WfPhNi468I6LgcamBD9TKOYyAahW9XiHlxpDZr/RIlPbLv1E78qapRNuN86sc0b0
X-Gm-Message-State: AOJu0Ywq4H49PgQ7HjNvfiMjuCo20Kj84Afuod8X6aDFIJXIHKZTnWin
	ypj5nZp5+1qAfWcgkxs+nxUMO7kE48X/vB5jSgiEu74N/vCwXBQBF3mzUmB/pw==
X-Google-Smtp-Source: AGHT+IG5TTqLssvq9z3HQ/NiuCB1jv/9mz9B8cDLWUAwmsQjYlLPHPkcZyQSFOtZ7HAPToK6be32vw==
X-Received: by 2002:a17:90b:1809:b0:2ad:3688:de80 with SMTP id lw9-20020a17090b180900b002ad3688de80mr11136934pjb.30.1714405973381;
        Mon, 29 Apr 2024 08:52:53 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a390300b002a232e4f9ddsm21130064pjb.34.2024.04.29.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:52:52 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:52:50 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 5/9] selftests/landlock: Do not allocate memory in
 fixture data
Message-ID: <202404290852.29E4B471@keescook>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429130931.2394118-6-mic@digikod.net>

On Mon, Apr 29, 2024 at 03:09:27PM +0200, Mickaël Salaün wrote:
> Do not allocate self->dir_path in the test process because this would
> not be visible in the FIXTURE_TEARDOWN() process when relying on
> fork()/clone3() instead of vfork().
> 
> This change is required for a following commit removing vfork() call to
> not break the layout3_fs.* test cases.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

