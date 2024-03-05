Return-Path: <linux-kernel+bounces-92626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600C87230A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7854D28403C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B95127B47;
	Tue,  5 Mar 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UFNvY0RQ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB86127B45
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653332; cv=none; b=uIAzTRq8yO3Dlwx+BLojlgbyCjnofTGMslPJs5FmPQkHjPy+us2RlktmdsDXkmBnulKhlQJUkjvGsYDN+jLBkj2BCjUos0BsPm6CJV0j7/CpyyP4ZqfDbc+Js6Q8kzAe6fCs2gAH3aSonkKaLaErtpnZdOEhyDD3/UD68Vx9HxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653332; c=relaxed/simple;
	bh=fB1DZM3hyKMkr+cgEeOlzUeRSDbIJulihStcsm6Ps2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCpCUoHaZu52azi9N5Np/Q92l7t1F5oHFs9B7m5eFQ3GWn/KNnFHsN2UHNcc50s5Y8mw+HjLe1bVLjJ3NVaSeJ2uygpu1gz5dBu7I5HWE+9fWVs4IguA2nckN4JlADABDEapxb1gY0+zUnBjlDrgSxLMioUhvAocxMoSLpUxqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UFNvY0RQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so11452601a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709653329; x=1710258129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBsxvGzWoDwoJ41jqX/ShHQbcTmlaY2LZ0kAFV1BWaI=;
        b=UFNvY0RQlY1oYXpUL2kUeB24Oohf4kWRkwlxSUclqLHQ2TVTirxCXkQmb/co38yRJL
         fb2f+PMTWRmgLGmQk4gmCjD7Zh1ECrm1sQWYWJmneFy14i5jBkpZy/ylVyLdu1XjsVv5
         ob5ImZCY5BzOmFhOmTmbdITWolzU7bpmbGmzTE8IG1XcVJzZQBqOgC1X0PVux2Rq/dO4
         5d8Ryk8hkmbGrr0xt0XvpXAhdi+HmwegRGcpEMsREZWCnsaK5M0hR6n85tc3npKIaMfE
         R+db7L5w8gaGxF72g2tugztG4pABZ0ND6dqQjt7cDH9T/2WPjMEnVYQF+QFqUuFgFKPH
         pZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653329; x=1710258129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBsxvGzWoDwoJ41jqX/ShHQbcTmlaY2LZ0kAFV1BWaI=;
        b=BlNivaTPG4xsOkQPi/i5CU4XFIxkOZ6N8Y96IacPgz+1xwR1OmOMDYnHTXnqeISdpY
         X7xDMw9hqoV8u3yrrA35SqO4qR/rm3VwJX62QG1qscXhgbRbooKYlnTsndmTIvn3aWGV
         bucaNfkC89QpU4kIx3QJM8UEJ0XHUX1UvvzMpL2SpZdeYvXSyrAioIH1a8NeDn9GcJrd
         8HSFPdLcD9x2W3fsVlkXaBn2ekYUm/yP9xRix5S3PafybK5Vd5JF6r8Xi7v40YL8NWRP
         Wr741/TU0Of4TEB5i6ytgH5LCjFpF+ICrgRctNzFktG3+LntMrPgV8MnnCu3vMugN/2V
         TlTg==
X-Forwarded-Encrypted: i=1; AJvYcCXqe1I3c+PC21L+Rp1VEX8dVFldVt6ZbKUT7kFPL+mW5ElzEbNtEYo1Vk9tWA4t/O21B10JzJXPr6cfFT2Kh+qKQbYt5PtOo8FgrsVp
X-Gm-Message-State: AOJu0YyEcLT1aqUWzUW8H2wASjMLvavcTkZ7CZ3Q7g3zZgdXMo4Wk7I6
	6Zkavqxu9GuUcv/woksoBlKnY3/38LoQbibHbZElDE72pnv2a6PjyNNU0pl4fYI=
X-Google-Smtp-Source: AGHT+IHA5gjV1ahoo841/Xb4YPzyqeDd/CE9X/Xtf1e/NIbsUzDp7lLo2vFOuduvDMemVXxOk/lyTA==
X-Received: by 2002:a17:906:6b9a:b0:a45:1746:ff09 with SMTP id l26-20020a1709066b9a00b00a451746ff09mr3636877ejr.14.1709653328569;
        Tue, 05 Mar 2024 07:42:08 -0800 (PST)
Received: from u94a (2001-b011-fa04-520b-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:520b:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id z20-20020a170906271400b00a441cb52bfcsm6181709ejc.165.2024.03.05.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 07:42:08 -0800 (PST)
Date: Tue, 5 Mar 2024 23:41:52 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: linux-cve-announce@vger.kernel.org, cve@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52462: bpf: fix check for attempt to corrupt spilled
 pointer
Message-ID: <zbmamyicnciykxaepg53jnq6qnkbl6xdsymukrjbmblgvcfw5f@o7xd2v4hjofd>
References: <2024022335-CVE-2023-52462-b663@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022335-CVE-2023-52462-b663@gregkh>

On Fri, Feb 23, 2024 at 03:47:35PM +0100, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> bpf: fix check for attempt to corrupt spilled pointer
> 
> When register is spilled onto a stack as a 1/2/4-byte register, we set
> slot_type[BPF_REG_SIZE - 1] (plus potentially few more below it,
> depending on actual spill size). So to check if some stack slot has
> spilled register we need to consult slot_type[7], not slot_type[0].
> 
> To avoid the need to remember and double-check this in the future, just
> use is_spilled_reg() helper.
> 
> The Linux kernel CVE team has assigned CVE-2023-52462 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 5.10.163 with commit cdd73a5ed084 and fixed in 5.10.209 with commit 2757f17972d8
> 	Issue introduced in 5.15.86 with commit 07c286c10a9c and fixed in 5.15.148 with commit 67e6707f0735
> 	Issue introduced in 5.16 with commit 27113c59b6d0 and fixed in 6.1.75 with commit fc3e3c50a0a4
> 	Issue introduced in 5.16 with commit 27113c59b6d0 and fixed in 6.6.14 with commit 8dc15b067059
> 	Issue introduced in 5.16 with commit 27113c59b6d0 and fixed in 6.7.2 with commit 40617d45ea05
> 	Issue introduced in 5.16 with commit 27113c59b6d0 and fixed in 6.8-rc1 with commit ab125ed3ec1c

While commit 27113c59b6d0 ("bpf: Check the other end of slot_type for
STACK_SPILL") is referenced in the Fixes tag, and made the switch to use
slot_type[7] instead of slot_type[0]. This shouldn't cause any issue
because its commit message stated that

  ... Verifier currently only saves the reg state if the whole 8 bytes
  are spilled to the stack, so checking the slot_type[7] is the same as
  checking slot_type[0].

It is the next commit in the series, commit 354e8f1970f8 ("bpf: Support
<8-byte scalar spill and refill"), that rendered checking slot_type[0]
problematic.

So I believe the issue is introduced with commit 354e8f1970f8 rather
than 27113c59b6d0. That said kernel releases seems to either contain
both or none of them at all, so in pratice the difference probably
doesn't matter too much.

> [snip]

