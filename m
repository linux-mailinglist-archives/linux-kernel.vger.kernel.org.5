Return-Path: <linux-kernel+bounces-96183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9133A875834
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51BD1C22A88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5213956B;
	Thu,  7 Mar 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z9qYltEc"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F201369A4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842972; cv=none; b=qQoKjwZG13ByZDJGHBT/baVWJWum0AwtgD7j0TLoKkjmqK78Mvu9Fmqyj3zHSJQv6PMV0mLBIX3RfEI5Po95sN7lKh/XSSIg1zX7UcMmxfU54GT/MNtMb5Kr70mpxKxUbUNMJWPrPM2AqvDgM+Vntqwo76B+tcwopuug4QebasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842972; c=relaxed/simple;
	bh=rsRY4KHhOJ11hCtZ8v0Bh9J/hZ5MuHy4e/+hy4b7p7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu01TK1tlv8BZp89jVgp7862Zb+hLyS74LGoIbodXwV6xf/ITFyWNB4Sz1bB4A/iDMZXpVh9McwHDTzZ30A3Y8VPNa5n4CqC01z15Io8SFmQQtNoQYyA5CzCgIa0ikSttCPHyYhd+3q4X18fYBJQKcMnty26v01HiY9PSrOyyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z9qYltEc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dcafff3c50so10238335ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709842971; x=1710447771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gj7oOuwiWTs3D3sNhRN8A6+8rBskvEU4W316SxnrZUQ=;
        b=Z9qYltEczee533bhL6XcuFl3TuMK+ESAhilan3P4tEKBrRuWu4xMSw2AVzsiGFK//K
         Iv4JNewp1DzM5TKsoI+f9U+O6uxYMjMrNvITeoy+wMIfZRv7MEcUOrU73oQHCWG8JRim
         EFrot9hhxqtP59O9lGYQT7iMAetLMkhmdVsb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709842971; x=1710447771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gj7oOuwiWTs3D3sNhRN8A6+8rBskvEU4W316SxnrZUQ=;
        b=bzvOFY3WGf8VTBqmWg/bt/tcQ2b/E4NpFoZG0BYbub2u9R/HVJFbB/m8kE2O2ocuFo
         Gt4rxH6zdAs5+6P2D7lu4JOEngqwRSsYVhamj59Q+pSTvGSAqkOgu3+L2p8xiRGBOXqm
         Cdx2QVIGxXx/xj4tfP/N6H2UrxOfEFmF0NYMz5U/PYB58h44zuwNi6isLNCIaNGSLyHo
         oUxBcRu7t3XUW7Ap62opC2OP8dT4fw4ehrFdLbFeXNtwbv4iEAooHz4c36r/qgdk3nKP
         s6ye7VrY6H1KR5YMRAobayq2usoO/fB9cRxlisN+hW2EizOsz8MjUCjMghRhhfATzvPI
         IJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUylt1lgGFMaVJNi/41vlbgPC8mFrSmccuopBYIG8cxQiv2JBDREf+lUO9aTyOMI6hD1SwSmXNPNkIoJg3sjB9bMVChSnccQYkoCKB4
X-Gm-Message-State: AOJu0YyRnQJr9pJVYbo2TF6zNWGGKiMpU33/URaGaYB5hkxp8RmLw0rI
	ulOfiTq4MUWvOVIKnMQ1MyaY/srR7kaX9J/eTolA5s8kFW7zUW8Xt8IcAyBokQ==
X-Google-Smtp-Source: AGHT+IEaVq/z1Ao7qbCydAde3vlTjlckhexdCldutHJ7sK0OKwFxXDLmqCrbxxaDdS2K2YLHyqccRA==
X-Received: by 2002:a17:902:e84f:b0:1dc:3c3f:c64b with SMTP id t15-20020a170902e84f00b001dc3c3fc64bmr10989479plg.24.1709842970750;
        Thu, 07 Mar 2024 12:22:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902680e00b001dd62b4dd7asm581604plk.47.2024.03.07.12.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:22:50 -0800 (PST)
Date: Thu, 7 Mar 2024 12:22:49 -0800
From: Kees Cook <keescook@chromium.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Jameson Thies <jthies@google.com>, Hans de Goede <hdegoede@redhat.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, Benson Leung <bleung@chromium.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: ucsi_check_cable(): Null pointer dereferences
Message-ID: <202403071216.DD2F952B@keescook>
References: <202403071134.7C7C077655@keescook>
 <ZeoggIXSLy+lVHP1@cae.in-ulm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeoggIXSLy+lVHP1@cae.in-ulm.de>

On Thu, Mar 07, 2024 at 09:16:00PM +0100, Christian A. Ehrhardt wrote:
> 
> Hi,
> 
> On Thu, Mar 07, 2024 at 11:34:21AM -0800, coverity-bot wrote:
> > Hello!
> > 
> > This is an experimental semi-automated report about issues detected by
> > Coverity from a scan of next-20240307 as part of the linux-next scan project:
> > https://scan.coverity.com/projects/linux-next-weekly-scan
> > 
> > You're getting this email because you were associated with the identified
> > lines of code (noted below) that were touched by commits:
> > 
> >   Tue Mar 5 13:11:08 2024 +0000
> >     f896d5e8726c ("usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses")
> > 
> > Coverity reported the following:
> > 
> > *** CID 1584245:  Null pointer dereferences  (FORWARD_NULL)
> > drivers/usb/typec/ucsi/ucsi.c:1136 in ucsi_check_cable()
> > 1130     	}
> > 1131
> > 1132     	ret = ucsi_register_cable(con);
> > 1133     	if (ret < 0)
> > 1134     		return ret;
> > 1135
> > vvv     CID 1584245:  Null pointer dereferences  (FORWARD_NULL)
> > vvv     Passing "con" to "ucsi_get_cable_identity", which dereferences null "con->cable".
> > 1136     	ret = ucsi_get_cable_identity(con);
> > 1137     	if (ret < 0)
> > 1138     		return ret;
> > 1139
> > 1140     	ret = ucsi_register_plug(con);
> > 1141     	if (ret < 0)
> > 
> > If this is a false positive, please let us know so we can mark it as
> > such, or teach the Coverity rules to be smarter. If not, please make
> > sure fixes get into linux-next. :) For patches fixing this, please
> > include these lines (but double-check the "Fixes" first):
> 
> This looks like a false positive to me. The code looks like this:
> 
> 	if (con->cable)
> 		return 0;
> 	[ ... ]
> 	ret = ucsi_register_cable(con)
> 	if (ret < 0)
> 		return ret;
> 	ret = ucsi_get_cable_identity(con);
> 	[ ... ]
> 
> From the con->cable check coverity concludes that con->cable is
> initially NULL. Later ucsi_register_cable() initializes con->cable
> if successful. Coverity seems to miss this and still thinks that
> con->cable is NULL. Then converity correctly notices that
> ucsi_get_cable_identity() dereferences con->cable and complains.

Ah-ha! Yes, the ucsi_register_cable() check seems to have been missed.
I think it's confused by:

        cable = typec_register_cable(con->port, &desc);
        if (IS_ERR(cable)) {

This isn't IS_ERR_OR_NULL, so it thinks cable might still be NULL, but
there's no path through typec_register_cable() where that can be true.

Thanks for taking a look!

-Kees

-- 
Kees Cook

