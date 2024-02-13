Return-Path: <linux-kernel+bounces-64464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1D8853ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4751CB2110B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83451626A1;
	Tue, 13 Feb 2024 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZsBs4ED"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA3B433AB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863727; cv=none; b=Vqf2yKmyg/uoeqc4AAJyLpidXBYAe1bPOOoHqRBvsYRoWD6D3zf1eVmaNzPja6jYcujmE6KLy4kHCe3PH2EMnvYgRQCJjcp1GQ2abD/Nz4xAzVpoZUIyxJTulxjApBurP4JNRjuPBQj3NWFxE1mES4Ypst7NEFXnz21ZkXc+hTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863727; c=relaxed/simple;
	bh=tipJi+U9GDj0CkiqDhKdK1o65riVM70ZqCF20enCo9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHTC8p6vPVsiin379MluGFkcj9ACma+grfj4fM6Bf/YEikxresv0aKYpRR8/n6vS1u3Gw71JbKFIlPIZdi6wi/8i+1iv4405IAg9St+O6PZ5HDlriLK6UpxkgV6BWQ0wHJQMVyM9U4ijggdt4Hd5ex00GvBWtunTm/MK0/ep0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WZsBs4ED; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e10ac45684so21099b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707863726; x=1708468526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHb/YYBc6pIFNIEe2DPG7rOnAuRcX3ih2CyzFyZ/wSE=;
        b=WZsBs4EDBlVYYS0mMOZjPQWdvecHXsC/Q7akLJ6IV7/e/VsM3c9LIWA4dmx6oVsimL
         QcZKQxHCQhFhuJ2sGQpZuQNPNak/tFZ7Z+qUD7axAFzMKLw2DEjRlzPWZQoKCEbQ+WIo
         5BG2k6rLjREpwuQn9BSaYkm7wCQ8i2ksHWlfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863726; x=1708468526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHb/YYBc6pIFNIEe2DPG7rOnAuRcX3ih2CyzFyZ/wSE=;
        b=PSUolB4St5yVM32HkRx+bsA606/oRsVj/S5gBqZ5gbJ475L86snSLQQquTH2NLN7Uq
         G9H/3FlgpQtc56toxHyG2NLWoeW+MqdacO2mRyUrOyPe/bLKjMZ06Rxpm8cE1dQvpOFa
         aVDLCm/NibFYhbnzP3S7y8SGuK1npJ8WTs/K9KKUexgU57HK5feLbl/MvPFnqE88N0lv
         LbdUeD3Wr9RykqLdKx772RXbiQ9BJEQ0zxIXTsyvEMzGYgWYTNlUrDdLRIxmpFfwZOcK
         6dmmsCMAf+OK9yXCoyTybTmMMdg96zYj/k7cDHkR+5AOg9Umo6VYUZ9yTYZGW/F3ST4H
         5TTw==
X-Forwarded-Encrypted: i=1; AJvYcCWUygb3ME7OPtLK5yu9GSVYol6jSdiLLtMoBhPhWQiSJ1FSe323EZ5oOuGVDC9Z9+vdKykk+FoPgYmRO5uBdQNqkriPtAZy7d/CmXx+
X-Gm-Message-State: AOJu0YzTOguf6YB0KjvfFXIqDqxb7QitHVDAQcooHdN06pD1b7QLe8A3
	IpBa1PIb7BquuHHtdl66KCpy9GsOz5+ReqrRp/RO88Hm7wMIFEPBS3SrYGuEaw==
X-Google-Smtp-Source: AGHT+IFl+ixrff+OQKZ4hGvka+YzZ2Fu4NyTeH+/fRphqNrwSiUKZgybbR/ivq1vpF2UfFHuYi3UmA==
X-Received: by 2002:a05:6a00:26c7:b0:6e0:8ccc:3978 with SMTP id p7-20020a056a0026c700b006e08ccc3978mr568946pfw.11.1707863725782;
        Tue, 13 Feb 2024 14:35:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIHdkdxxey73LnmlkLOMQg7I1B9rH6TUWFTQN98YHugPGy24HS2haJws/2J6qK1ImHjz/r5apOEDJcyR8nUcJY7APZ8vwwVdJ0mWg2yVKgbD30bCK/OsN82PBBpQ5Q6fUhUTHXM7zpl5FsR1h0E/V1xvQ+tTcBtY6nx8p1D/S7Fp2IMLhc8lQfBABjy/782CW4MzZ6qzGj1QpJgHZSKLGB1LP8XPnfIhY/0IV4TLpJrACV6YKzQutFf0w=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a00198500b006dbdb5946d7sm7948181pfl.6.2024.02.13.14.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:35:25 -0800 (PST)
Date: Tue, 13 Feb 2024 14:35:24 -0800
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] Documentation: Document the Linux Kernel CVE process
Message-ID: <202402131429.A604440C6@keescook>
References: <2024021314-unwelcome-shrill-690e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021314-unwelcome-shrill-690e@gregkh>

On Tue, Feb 13, 2024 at 07:48:12PM +0100, Greg Kroah-Hartman wrote:
> +No CVEs will be assigned for unfixed security issues in the Linux
> +kernel, assignment will only happen after a fix is available as it can
> +be properly tracked that way by the git commit id of the original fix.

This seems at odds with the literal definition of what CVEs are:
_vulnerability_ enumeration. This is used especially during the
coordination of fixes; how is this meant to interact with embargoed
vulnerability fixing?

Outside of that, I welcome the fire-hose of coming identifiers! I think
this will more accurately represent the number of fixes landing in
stable trees and how important it is for end users to stay current on
a stable kernel.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

