Return-Path: <linux-kernel+bounces-92061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B3871A52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8470F281FF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAA854904;
	Tue,  5 Mar 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gT9lMjiE"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299B54770
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633549; cv=none; b=t/YMOezHHn+WgeQ6YPKTdzyDsvaY3Lj4lxwNA1w765SEsNil48YjpbEMGfT9uLOgjFXP+9VYoTeE5aOpD+ybnDDUfXttGepxdw4QvAzW4GVsLRl8tyjZkXKPrrRWYpYdDy2Og+2HzskZncNbvuJ8uKdoKCdB9DFMmk8iByY7wGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633549; c=relaxed/simple;
	bh=qX84Qr8Rjx3k1Qrrec1tOKVgxK5Rdtm5/Yv88GrB3xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0XVn1ECQ1M6tNqj9+rUZHZw4mA2dejL8kb0ykoryXx20JT3IexklV7/s+wfr6tJ9UYiRusU0LUY5GPmoYPhub6gEGOjKK/hysK+qywO3C4ldDzT8DIAp0In+eCOXbJ+nCurFT7BsYyT3F5F1tmMGyfMEUn4jZi0TVoFp5wITOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gT9lMjiE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dccb2edc6dso45464045ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633547; x=1710238347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90GoPmdoNB7qy/Rz4aKAQpu8I3w30a6c5BBckmqB0YE=;
        b=gT9lMjiETrAheaS14Ym8qIZ1UybbiLc8FoP+cq4pXprpgq/K3ae6Hyavcrr8ezOnEf
         EwlHVc5SET4LNV4m+8tMcvR3Zo/b4atkP34fMI3c2vMsw4bzu4er7OssbexTHiQy/VDR
         vW9HcMeHMi4+K2iC4Vwe57ZpMV6TfQjgCtOeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633547; x=1710238347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90GoPmdoNB7qy/Rz4aKAQpu8I3w30a6c5BBckmqB0YE=;
        b=bhrW/3Sd81icXwrk+Xehg7knJgOi59pRPY6qdNcjiidT0bLtyFzvY/lZaGQOFxZwcR
         QMcvT0FrnSOsmQFEx+/xx9GxTeldjLcsfzu2mmYk0bd7uqf/8GurmLjBzY5vdk2432Vv
         cbVWrAwbseDAIno5TgeCLFMGLAqOvnB/Ut/ylE9ohXEi6jSWAJVeJBDnqHKWjigt/JxT
         /kTTfwG0mceTrc9QEnuhzhCQ6cMzrkbECVLhD3dX4QKUzQCPZbHE5tYWx0TBq2mDPwuA
         pRgnZ2T6C2cWVNGXbPb61RjvlWvUfsNwd1ze8bnK336M+hZ4uuxorZ0vq6TvufjHyTsc
         7/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXRO+5KNjlyv2uOSaoTFtaIixDu+v+8Zrp8ipNRAxRit3lfwSsMHGazBmSuvhnhF3s82IRgMS7pC2Cz7484iu8HahiXmS84Rr3JK9sh
X-Gm-Message-State: AOJu0YzwBH0CNtrP10KN/Jy5fWrdV4PU4015UQfhsAEb2M93asG5/tiG
	abmMfL3gedbWMrLI0SQChrnwHnA5Mm1G71O3vfst/HK+PTOFhYn9pRAmxxJXTA==
X-Google-Smtp-Source: AGHT+IHivF51UPX1N5OEzkfKJUGVPso4IRPc5xLAaCXRGUd0otijzh2wsjGTeXcfAY79j5YppLpA7g==
X-Received: by 2002:a17:902:8a83:b0:1d7:2e86:fb2a with SMTP id p3-20020a1709028a8300b001d72e86fb2amr1109359plo.65.1709633547547;
        Tue, 05 Mar 2024 02:12:27 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mm12-20020a1709030a0c00b001dc96d1a662sm10134092plb.197.2024.03.05.02.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:12:26 -0800 (PST)
Date: Tue, 5 Mar 2024 02:12:26 -0800
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-fsdevel@vger.kernel.org, kernel@collabora.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <202403050211.86A44769@keescook>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
 <202403050134.784D787337@keescook>
 <20240305-kontakt-ticken-77fc8f02be1d@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-kontakt-ticken-77fc8f02be1d@brauner>

On Tue, Mar 05, 2024 at 10:58:25AM +0100, Christian Brauner wrote:
> Since the write handler for /proc/<pid>/mem does raise FOLL_FORCE
> unconditionally it likely would implicitly. But I'm not familiar enough
> with FOLL_FORCE to say for sure.

I should phrase the question better. :) Is the supervisor writing into
read-only regions of the child process?

-- 
Kees Cook

