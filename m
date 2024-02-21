Return-Path: <linux-kernel+bounces-75138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0619885E3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688321F255C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE982D9F;
	Wed, 21 Feb 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3XHan3v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BC69313
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534210; cv=none; b=mHd6WheWD+tQOGJFsT6V2fLcEp5Hr0g0x/EztT4PGBPqfj+sc5dn+z+TlinxAsLyZL8FgBmtD5XwmqWCKcPuTNWLxqMQ9soGJc/s5qoYiMTPu5zeF0PIX7Z5EWg5jk4wGrAgPP38XKecD7W8WJQg2OlSliA4D33YxVqerRg96FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534210; c=relaxed/simple;
	bh=08EjmvccMdxB/X4LHQ5EjZMUbY7CQAszbuiJSP0Q5jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV3KsBqsgkFN4vvTZM13N65Jqj8n3bQM2E7Su4YnUia3F82chMeioWJDlbfOGnt7brtwJH5Yp0/6alUYf8SsHoKYBVkOT9hJbeDedqkg+Fd9OmS/bWI8RLG1zK7UD+6mRW7z1L0ttJXDK4/zs8mtdiSZzcqjXnh41/zluPtEgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3XHan3v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708534207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Y6wkod5v/VwhXfaC4PUhKCVkOXfj/Mh966B+szPrs=;
	b=O3XHan3ve2xG4ytQUe3IBfSG9mE8EJfsX51KSEt+CIv5e1eYkvkdMm1GIAPLESQ+vPv8A3
	uGlIzAwNZAJAgIIhjAD5DqqPWbWyZftavJweyVODlVmJByxlWjDEozPEoODb+s5ZlezCbX
	gDcNU9sK2efLOR8U1UUWNBFHY+9fYBE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-wPFDPpZIMQSpYAI2XVUnAg-1; Wed, 21 Feb 2024 11:50:06 -0500
X-MC-Unique: wPFDPpZIMQSpYAI2XVUnAg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7874e6a5172so559821285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708534205; x=1709139005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8Y6wkod5v/VwhXfaC4PUhKCVkOXfj/Mh966B+szPrs=;
        b=Ty3RQp0KHfggB73Lt9qkM5gzsgcEg5wTSqogrmo9ym96oH3DrGS6jlK+1KRg0qYPt4
         1VFfkJmMCV2y8SltO+otD/6v25jfvF1YDDpF2uljsBGLazU4GoiSxuTtDsQRFYTForcE
         sj7rgya40tfUfkLR1bUNgt37/OOz8vRiaXSXqG0Z39tBveU2WF9RwSHPvn/tJTjcResi
         5YdgWVl2zVyJaL8/dt9cRzwRGFErKg4vqK3UommGaMmFDvZ4ytDkO2r8hCmqH3H7HXnW
         nPK8vPWWsnxiFdlmsN7JDelTTML95WdOqWRWJBTM26eEtnDIceCAllzRFyOcWwwenffh
         7rrA==
X-Forwarded-Encrypted: i=1; AJvYcCXzWS+hXIU+dDIkdnDHq5gb+oRbs7wEgFwehAwKZ+S9ARKXIKsJwjHQdlmJYSYfc7Nls1WE9rAbTifiy/eSwC7DlKkQWTrQvYJ2Yu6J
X-Gm-Message-State: AOJu0YzHcJfEdVaWy3raWfB4UZNvzA99bsCzktr4fJvSdMDHqLoPok/H
	IB9IRzyWHGWdcvKbJKCJHq/+db3phzObhmDeg/NXS1MuJFPiK5k3m9AmJJBbEtlzCX4VAHHPzTF
	fBOiXHFH1NBsYWzM+diHr4Xzq0DidB2vzquo0ffuFqWNyySA/G/wNFx8AJwAuwA==
X-Received: by 2002:a05:620a:4483:b0:787:24b1:eb7e with SMTP id x3-20020a05620a448300b0078724b1eb7emr25781805qkp.74.1708534205737;
        Wed, 21 Feb 2024 08:50:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbCyAU2RCcg9u94L+HIjMA5CodPDqzIMQrgpD+sT+zcDsysBqBooiO8xftZgi+ucE12LIXtA==
X-Received: by 2002:a05:620a:4483:b0:787:24b1:eb7e with SMTP id x3-20020a05620a448300b0078724b1eb7emr25781788qkp.74.1708534205490;
        Wed, 21 Feb 2024 08:50:05 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a166100b00783de6b5ccfsm4470863qko.88.2024.02.21.08.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:50:05 -0800 (PST)
Date: Wed, 21 Feb 2024 10:50:02 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Maxime Ripard <mripard@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org, 
	Enric Balletbo i Serra <eballetbo@redhat.com>, Erico Nunes <nunes.erico@gmail.com>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
Message-ID: <zeg7z74rtvqkwofbvgdf4dysz75c7jb3o3tjar5abuob3x5dce@rvc5dttxynpz>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
 <56625c21-1b34-479b-b5b2-4c4d8b7a11b3@app.fastmail.com>
 <724jnhrbs6r4q6whynr3aon5w7mhfvetlgcnts4nukvtxbuium@mrjv6apjqk7r>
 <8ad96253-2053-4dc1-8dc1-d01d1fa36877@linaro.org>
 <ZdYdJILy9_anIsrr@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdYdJILy9_anIsrr@x1>

On Wed, Feb 21, 2024 at 10:56:20AM -0500, Brian Masney wrote:
> On Wed, Feb 21, 2024 at 04:53:26PM +0100, Krzysztof Kozlowski wrote:
> > It would be cool to group also all the per-SoC needs in dedicated
> > fragments...
> 
> It would also be nice to have a fragment to enable the various tracing
> options.

+1, I cannot tell you the number of times I've been burned by the
defconfig not having those enabled and me forgetting :)


