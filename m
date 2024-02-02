Return-Path: <linux-kernel+bounces-50197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79E78475A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE36B29435
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AD314E2F1;
	Fri,  2 Feb 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5YYYMdy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85D14900A;
	Fri,  2 Feb 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893403; cv=none; b=OmDy6sMHxndPPfjAkN607eHN/fXzFWeSUNesoTRpvE0EuqjoPj7AgdRVQU7clYKOYK0wbCqGu5dFHsPs1EC6RpEW50PZIiU8ggolkb+n6jCviCeHxYDhjN3FiXcwVsnQM+lZ4V4rXOFLYTnC9o85NSW5XYSUDuxZ3LLnX/4vStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893403; c=relaxed/simple;
	bh=UNcjKbgtq2SHVkgxXgFW1sGPDotmGruVW6Uw3ganfnU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKIdXceIxC9AluiM8NCFgkLj3CV5N8o8uVdeF4/UG3F6Po4ilNs/HPu10kF2vS+71OEZP2wLb2Ux+KY1YW5KINxsZSNgN2fZn3jiGL7ta/QEkt9BmtGlnuW31r+mURyRBMgsg6vdO3nlJVV+rU6++sLWC2PKxPhb01pL/rj0NOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5YYYMdy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fccd090c2so763095e9.0;
        Fri, 02 Feb 2024 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893400; x=1707498200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DOlCKHisK2Tg4+zoV5Rvslpll2neVr4rhQD1dXHl3vw=;
        b=k5YYYMdyI4ctkL89KlTxGVDdp101wJTgKz7p69JDvpYfqKFnaD4N3jfieG1dQig1vS
         FivnWViPXONCvkTguRvhYfqDe3rUnm2TlF1X7S7LbRKQ7mc1noBf2UQy7a41gjtsEoT2
         6/p+kenqtrQmSOtPkEphbEI/V6/D8qIvh6H4Fw3AElMDz86FMcwFKDvUycyY3P8rQtdV
         OJQJCU1Hp5+smkhjeDqxGuWFi3I7nGKgF1aezZu7xHNu0DqVXOVY6XsGYDvCYcy2/dAT
         PZrQg4FHyg3HOtL05sFDhnXfMbV4tRX6d3ieDvCwW2J5zzJSLQCrj75zfhY8BoG/WZsX
         +Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893400; x=1707498200;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOlCKHisK2Tg4+zoV5Rvslpll2neVr4rhQD1dXHl3vw=;
        b=Cyipclo8GjhjnJ17OtPazmvDpSPVYXaWeQ4tKuHVDfWJvwazlmby6q4HuqQzOPdg4O
         kQzIEt7ytnmxGpXAmyLXUqTIs8cGfH9ohxgWkNpcsNu5F2LeuAU5ko0M0B9y8bXC5lnM
         guFyQvNLZ86F4GK35Q5SiR3JYo8F71G+Qif/Ndyzt8CLWmpq92zKIP31Fz2O/2zmum/a
         HhBsEJwwvqovr2bHvuvcQM8AzTBDE2Najn5hUdS8Blnb4xCDqHU+pBN+2872CeSd5xXR
         ES7QaQPMLqrKwX+qpOPjbtyBzjDezcKa5y0DratJEtvRyOGSnkgJkpBGG/ORQtTUTQkV
         aMVg==
X-Gm-Message-State: AOJu0YyA+vnEfRmCrRwhUYjW9YstRu2bbIPwqZQcim1xs7beNUjxnJaG
	iqLwcukXh7EdNX7gDuwHlcBSk26Xh7pcjsMBkt1nNkBcMkioj+yG
X-Google-Smtp-Source: AGHT+IEjhLMP/SwXID7gjUKxnJg7zcodpyKpg5Aat7driagvPstkgl7qEfPavqvpBZw231y/w/1ZkA==
X-Received: by 2002:a05:600c:35c4:b0:40e:f67e:a4e2 with SMTP id r4-20020a05600c35c400b0040ef67ea4e2mr6389283wmq.39.1706893399939;
        Fri, 02 Feb 2024 09:03:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQYKLQqDENSg0SCkt1ywpIL+KTmSCRIXPvPPJrk/z1CWS4YUOPYvekFRipoeD1fCIvLSiRs2SlOP4SIMufYY6UB7dTLYsy95bKEMRZ3HlRzJCM98cHdDl8jvRlhKtgPHYEDLDBxSIW+YeURxonmb5R7h59tMJdXDKXiPzyBUCHXRtAckb6vZVDGvZ5PL6whoxWypn2ERD47PImeJyDoggBYM2aYrhyljFnUoc2PtcAA4VqeiYm8OcjjFX+bTnu2uK6gWt095pfmjylOsrvSUBc58vpfQopGMZj2XYcr13B7bUWDLTN/i5dUBrzNv5R3Zwrh23XGP1RQ8Gh6f6aOrAsWr17/VfKG/saJUaOlohsfQyJWRwqA5kgkPdIwUDQ9Vh8l0I6jOUNri3qqyVeSb7bzas6hru2z58BmQWA1v66GSUwriuWbJ4XcZP6+AAFyqjnrLJnrJvqYBvauM06mnIiGmio0W3nWBhiNjlp+tqkrOuk+GN1ZslJ1sX+ru8l8Vh2DLs6oOVNFb0UX92rAr9zY9Yy1OxqT7KQu+IHQK8u
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b0040eee852a3dsm447924wms.10.2024.02.02.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:03:19 -0800 (PST)
Message-ID: <65bd2057.050a0220.e4621.31f2@mx.google.com>
X-Google-Original-Message-ID: <Zb0gVMjOskSC--_T@Ansuel-xps.>
Date: Fri, 2 Feb 2024 18:03:16 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 5/9] dt-bindings: net: add QCA807x PHY defines
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-6-ansuelsmth@gmail.com>
 <9933685a-5265-467e-aa39-d2c92a12edca@linaro.org>
 <65bd07f7.050a0220.e8e5e.9e28@mx.google.com>
 <20240202-absurd-guidable-527a3f3147bb@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-absurd-guidable-527a3f3147bb@spud>

On Fri, Feb 02, 2024 at 04:58:32PM +0000, Conor Dooley wrote:
> On Fri, Feb 02, 2024 at 04:19:15PM +0100, Christian Marangi wrote:
> > On Fri, Feb 02, 2024 at 08:41:56AM +0100, Krzysztof Kozlowski wrote:
> > > On 01/02/2024 16:17, Christian Marangi wrote:
> > > > From: Robert Marko <robert.marko@sartura.hr>
> > > > 
> > > > Add DT bindings defined for Qualcomm QCA807x PHY series related to
> > > > calibration and DAC settings.
> > > 
> > > Nothing from this file is used and your commit msg does not provide
> > > rationale "why", thus it does not look like something for bindings.
> > > Otherwise please point me which patch with *driver* uses these bindings.
> > >
> > 
> > Hi, since I have to squash this, I will include the reason in the schema
> > patch.
> > 
> > Anyway these are raw values used to configure the qcom,control-dac
> > property.
> 
> Maybe I am missing something, but a quick scan of the patchset and a
> grep of the tree doesn't show this property being documented anywhere.
> 
> > In the driver it's used by qca807x_config_init. We read what is set in
> > DT and we configure the reg accordingly.
> > 
> > If this is wrong should we use a more schema friendly approach with
> > declaring an enum of string and document that there?
> 
> Without any idea of what that property is used for it is hard to say,
> but personally I much prefer enums of strings for what looks like a
> property that holds register values.
> 
> That you felt it necessary to add defines for the values makes it more
> like that that is the case.
>

Ok, no problem. The big idea here was really to skip having to have a
big function that parse strings but I get that it's better handle with
string and have them documented directly in the yaml.

> > 
> > > > 
> > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  include/dt-bindings/net/qcom-qca807x.h | 30 ++++++++++++++++++++++++++
> > > 
> > > Use filename matching compatible, so vendor,device. No wildcards, unless
> > > your compatible also has them.
> > > 
> > > >  1 file changed, 30 insertions(+)
> > > >  create mode 100644 include/dt-bindings/net/qcom-qca807x.h
> > > > 
> > > 
> > > 
> > > 
> > > Best regards,
> > > Krzysztof
> > > 
> > 
> > -- 
> > 	Ansuel



-- 
	Ansuel

