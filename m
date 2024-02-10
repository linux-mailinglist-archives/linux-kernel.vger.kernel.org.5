Return-Path: <linux-kernel+bounces-60299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0608502DA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B08DB223F0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F2624214;
	Sat, 10 Feb 2024 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZgZZGxVe"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D81A27C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548444; cv=none; b=b9KOFOAZlC+6n3HUT56fZuHfN2+yU0icrKg8USRcV8JGLMsVSv8DsTf+Oo6E4rXXUg5RCL19XccCPPtTyLCSueJeAyZr8jmBLkaI1C8NZtICczMxwkzkNoM/VeTCrZTwYmjXjAQXhnBIKrRQ8sYHLtJFPXgtQ5b6DWdeB+MleBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548444; c=relaxed/simple;
	bh=ZtjqAt2Yq4OUXIaX7R+nn8REMEEMKAok1ITHIzfkHpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF8VTX3eDo179yjWw/zj2LiC7n4OaMxij8hnJrb+yGeAMQP0xes84W6pH495LRkCp8xlzP6gp72drT5jSFJlYafgFkWtCeopgAt/nMvMiEIEeeByELt+awXCYoGy7yIS/mUc5Ej/ethS7DXS0u+/EsIn7/zNLsQO8oLkZfr+wEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZgZZGxVe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso903191b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548442; x=1708153242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYFXmL9enl8Nqc0X2rjMzIeAy30W1fA7dyQuw3D2AfE=;
        b=ZgZZGxVegADBa/vJ0QvpaaGIKdt6HvbthQ6iWa6PC511lD4lHJZRcT88WMG/C9Z14S
         XTf/1qnNfVAmkUpgRTq1qYfXnz1lyHuJN4zzLcmvOCiD+wZfrG8d7cM7MDpYaPaMaJQ7
         uefJqtXusSUi603xRQRpnfIYCgOTgtvkRIhWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548442; x=1708153242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYFXmL9enl8Nqc0X2rjMzIeAy30W1fA7dyQuw3D2AfE=;
        b=XrUHXiDn4DXxZYaCqqlL5edy2hUA1zFXYMzJU9/btE4ys4RB2ZFBu5YvtM9dL6FUQZ
         4IPYjDMxUBscbIjKwUKhkO5CNtBOMgdAHZh4u9t8s48lObO9myeF7j/o7ctiSOd0dDXj
         ON5dsNfhu8l2H0nLPYEJkeXrW18mpWz4UDnlX3k6cvbx+H7pzt9PluXsXcgPNWn7LmkB
         Uy/MepmQd20q44ihC6xYspIxoJqbSxCn84Ztrd3Exeo9/8FbOr1//nczqENbUllzYncU
         unM+XQKPw0XLL8M8iiIwFaBD/SJY26kzXN9eZYNhJwNoWDsOwF5kccG0jM+GXi7phw8Z
         nrrQ==
X-Gm-Message-State: AOJu0Yy8o9MQn4QoUHr7eMcF2+ecdsQ3M9KnobSLMd8lpaR0uV4cmooL
	2KUlbRleXQpWJkjK0m7Y9aBaJq3JCIqSmwO5cqQj9qwVrehDf8EDVosTm1X8NUxoyIBHUpGRJx0
	=
X-Google-Smtp-Source: AGHT+IF/KTX0QN/a8lviuei3NB/zdWXnpCPVd2mPeBrpmBgxEfz00vK8GUh1HylhXPPgBitC+8t5kg==
X-Received: by 2002:a05:6a00:2ea4:b0:6e0:8a23:65c with SMTP id fd36-20020a056a002ea400b006e08a23065cmr4124497pfb.13.1707548442518;
        Fri, 09 Feb 2024 23:00:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWp608kYFRN7GxPqnpTu3do8ixzLsypK9rb2cOgy8DretbLXf6U9LgS3fl4J6YFvzuT3urfnxFQM70mfsT7H2XGTBlZS/2lb/xg+3eJze6TBJMWeZANtt90ZGBLo/0dcCB7Blj8YBzn43NmSP6Y96IdbNljxZ+BM4AJ/lalD3ehAblvHy+kuBKAJw9Kcb00fQoJwoPKqRWoxgHT/Ivfu4XFWXCDyg/O/evDRu9SyhWmU6Mvi1VgkBFUj4nTxnX00UrmmUSe04p8Blk
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ls53-20020a056a00743500b006e0967170bcsm1610335pfb.158.2024.02.09.23.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:00:42 -0800 (PST)
Date: Fri, 9 Feb 2024 23:00:41 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/10] scsi: aacraid: linit: Remove snprintf() from sysfs
 call-backs and replace with sysfs_emit()
Message-ID: <202402092300.926169D618@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-5-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-5-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:16AM +0000, Lee Jones wrote:
> Since snprintf() has the documented, but still rather strange trait of
> returning the length of the data that *would have been* written to the
> array if space were available, rather than the arguably more useful
> length of data *actually* written, it is usually considered wise to use
> something else instead in order to avoid confusion.
> 
> In the case of sysfs call-backs, new wrappers exist that do just that.
> 
> Link: https://lwn.net/Articles/69419/
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: Lee Jones <lee@kernel.org>

Yeah, better to use sysfs_emit().

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

