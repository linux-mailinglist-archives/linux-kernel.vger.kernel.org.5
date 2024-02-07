Return-Path: <linux-kernel+bounces-56914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D876484D150
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080281C2235F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBB484FA4;
	Wed,  7 Feb 2024 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZeFjXS2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D257CF05
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331181; cv=none; b=V3H25hYft9bwCHJBOV+ja1CKJ91kthrPlWMws7Yv3QVfp+c/1IGbq6vcdm3J+DLMwAPG3y5z/h/azxwSMKQL/RWMNe76XRsWS7AQmxa2w32rRzVCLvBbvXPF3vKJMzqjn45FDeri+t6VaFrRcYoIjEJwKZ1Roy/NgAoz44z7kP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331181; c=relaxed/simple;
	bh=bHH03PwBsJDDFfRRWRjUDTvMo/Icvm5kxoAEQTu957U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXKZ8bZBMedctAa5DJiXIRAeqEBvdrG/1rSMHUxUyhe81WaMLLlD2LxsozohY95YFbkCO+JLcYw7df4kqgpyHVRuYQXJVitz5lN9hhNOhcXePlW+1y60Y44DBKlrxLIr94Hkgfgf5NAr4cbB1XcTtCHfa6czZPv6BffQ4f1oZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZeFjXS2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zA3U/3AyORshqdfEbbnoh4Y8vo2HvRG4is/2gsO8esc=;
	b=CZeFjXS2Gy3my7MoGZarzcxE0MUEbbO1x9EhE4PDlFWTZOdonBq7GOMiUHcvko/sX+ma3Q
	kiQvTVonCO/Wf6+qanxdSFfMeV28/cJHbHCUtmYhlK57BAJYeZJ5Kx5ftVdi0br9jmjqyO
	6C+pQdE9tcakqfYpmWA6I2M13codPMI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-LuGUMTDqMvyLkqOv_pkQUw-1; Wed, 07 Feb 2024 13:39:37 -0500
X-MC-Unique: LuGUMTDqMvyLkqOv_pkQUw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-680b7da38bcso14518746d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331177; x=1707935977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA3U/3AyORshqdfEbbnoh4Y8vo2HvRG4is/2gsO8esc=;
        b=Rjl1AgpbHyHKlaaVHUIjL+FlypJNkIPj408LufalH5l9LNpAMKcqbsQ4iQOd5zOVbr
         X1uxdX9VTUVfGH+t6ruEwCx2SrowYjZCEPQTAQDCU2fIptsuXslEqtqZcpe5LKNnPHbU
         1tX5hAQq/bqSA9PW6viYF68D/cyQU7N43Fs1W8uNgnFVgIcqeKeObbsZCyLkQNMWnqln
         84ECY33+yfv1J6zfP3RRxSeTOpYpglKuhQ1uDs1bgWl9D3QnyGlgdkZPcO3LOWkQ5Jbu
         T61CJgw3dXn8rSVGCoPsRn6xh+yOyY+2Qk8tCtVoXGNu/6/LghKjQ8qUl8vlhmEn7L1f
         5KcQ==
X-Gm-Message-State: AOJu0Yxm4nLXV0ebh53dzuOfBwilP87JLvLAlfpHYXFf07wJs464kEKE
	5XWmyf1HUXlvcmvBO/pmDNLGCTg04q6WYnPjEgh4gG+iRPDTZ6yOPgNYckpYKSB+Ns+K7P4nJCx
	kzcDb0z7NHvx/7JVw7A6NxgPG8mffWQ0uyQZTsb1VRl3f4u9kHUxBmo0i/Qk9Lw==
X-Received: by 2002:a05:6214:19c8:b0:685:7b4a:2fa7 with SMTP id j8-20020a05621419c800b006857b4a2fa7mr8226594qvc.33.1707331177336;
        Wed, 07 Feb 2024 10:39:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkhV8vq9uOtPlMzQmzArx41ClcZgTX4ovDF+F3bU41POaEMaTi1sWPw91DgAY/TwdnFnfIxw==
X-Received: by 2002:a05:6214:19c8:b0:685:7b4a:2fa7 with SMTP id j8-20020a05621419c800b006857b4a2fa7mr8226571qvc.33.1707331177099;
        Wed, 07 Feb 2024 10:39:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0GzdGWjAG3uEc/8XaNsIzLnP2lCtpnJfXojYzocTRbEsdWQeAVTRu/Wpyv0z1y3wZ8mwi68/D0VcboBFxMyF56ceINGg036foh4bJ7yRyZgw+N+3LNGHF3kmR+iz3QE/mAdedoK0Y4CVOAnovVuT+iyyEuUyev3lstJWhHPOlOv1Y0UIsXOv0EnudX3m8lPVks2ynmvW/AU2NFxsm01WA0N1gNBoPzKc6McfGE/UyauLWe6cmk1WAe+FlalMfeIpLgcb4o7BzNN/a2oU5RPeJgEwDWDYSB5UDq7varlmuJUeFGGaN/xeZQOoN2RSmJO9G0serIBPXRU75yEb+oV7jOUwN40jhL4ZsPjmKcKJMllwbMYmVyXlj21SzslNNU96RqM61ELRs85vyu5tgJ4MoTgKn2lP+OMwSQj+ZFNjhR2xFOTeBUxc0iDcHvQ3Q9W4G4qRLT8jAGZb5YzOWG/FRTwZvqshltzVRcCaFpqD4Sbn7wAcrWzfdGDmdkBw39juF5d1EPBGW2NqjiIyyf0q09W2V47WN41qATWQu1g7LSK80+lPifXF3blNhT+yyh3cQZZPmG/3FvWCR6OBq9UUVc1LEOKW+wVwz7bf2f1/RuatXrztUHYgzKMsGEgQngHXEQpnThPkBU7jxm3mGeIkehamoMwndVaLfpSxWTAXuMW4jahbNFeC4fgkw7ubs87SX8VeacxexZ9OapWXaCkuw0roNJawZ01YiDdXIZ6apuvz8u98AiR7yBu1h3yTJE1qSMUVEdJlia3y1WmIiu2zI5xgDXQ==
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id ld11-20020a056214418b00b0068cbc630dc8sm835619qvb.49.2024.02.07.10.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:39:36 -0800 (PST)
Date: Wed, 7 Feb 2024 12:39:34 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Prasad Sodagudi <psodagud@quicinc.com>, Rob Herring <robh@kernel.org>, kernel@quicinc.com
Subject: Re: Re: [PATCH v2] net: stmmac: dwmac-qcom-ethqos: Enable TBS on all
 queues but 0
Message-ID: <6ihzd33vbgvixbe54jjoaj27tc5thhaq7u6iaufbmpejrtgxol@jit6qyaxjy3y>
References: <20240207001036.1333450-1-quic_abchauha@quicinc.com>
 <578b6a6e-83df-4113-9c1f-cdd7aa65f65e@quicinc.com>
 <20240207101934.6c0ab20b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101934.6c0ab20b@kernel.org>

On Wed, Feb 07, 2024 at 10:19:34AM -0800, Jakub Kicinski wrote:
> On Wed, 7 Feb 2024 09:26:05 -0800 Jeff Johnson wrote:
> > > This is similar to the patch raised by NXP <3b12ec8f618e>
> > > <"net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings">  
> > 
> > note that there is a standard way to refer to a prior patch, in your case:
> > 3b12ec8f618e ("net: stmmac: dwmac-imx: set TSO/TBS TX queues default
> > settings")
> 
> Yes, please fix.
> 
> > (note this format is defined in the context of the Fixes tag at
> > <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes>)
> 
> A fixes tag would be great. But we can't point at 3b12ec8f618e, right?
> Can someone explain what the user-visible problem is?
> TBS cannot be used? Device reinit is require to enable it?
> 

I'm not sure you'd consider this a fix, but yes the syntax there should
be using that fixes style for sure.

This enables the ability to use TBS / etf on queues other than 0. So I'd
consider this a new feature for the Qualcomm variant of things here
personally.

Longer term it would be nice to be able to change which queues can do
what via ethtool as was discussed over here, but for now this at least
improves things and follows suit with the imx and intel variants:

    https://lore.kernel.org/netdev/c2497eef-1041-4cd0-8220-42622c8902f4@quicinc.com/


Thanks,
Andrew


