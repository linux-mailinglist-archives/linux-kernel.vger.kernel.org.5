Return-Path: <linux-kernel+bounces-62287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B9851E13
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71081F224F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C284D9FB;
	Mon, 12 Feb 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="DPWyE+FE"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12554D9F0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767076; cv=none; b=jSZS8OndDTsZVT/dNqYxkIxKAALz945v+qy7pc//jl55pa0H53DVJlTD/ibwMB/6oVg8ESfqKLoFycLBZIWnJfw8HyrMzz8hviclw5lX1O2qS11oX6spgVDdWVUpFiPYMFgB+4kwEemLnTO0WjyhgsTClW8t/iznBFFl/Xucdjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767076; c=relaxed/simple;
	bh=KjD7psLI9JZ7o4JEwjsaa6s1zHsa/wBzL22vZID9xV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuAEl+P+p2yP9Sv7m/jU1h9NV2yUm3Hi7vl6X7kUjtbB8UEi4Pa8aEkEGYyVynoYrYO9yLa2iMrS4utY+kPhII8umaXRzoJNxm9CJscXG6nnff+zfte5AhSgJjxUbFvubCLmO7Lf5LCeuRnU2KINYpVNXWbx2Hfe9YJfmrrzC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=DPWyE+FE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e0a4c6c2adso991497b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767074; x=1708371874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FvPZ2Ml+uoIOAYYcFOueab5OR3zuP4CSL4jW9UY/oxQ=;
        b=WMmUvAHPCZCmHrS4ukyw6QFWsIaZU0FtZYpYqyx3/L6HRxGLVApSS5W501g9IN4CB2
         QJq/IkaRqeHY2mWvDGXea5zquvTwt3ff4Mc5/aw9l+36yXkYNpGbbG7JVPwc4d5HtWqh
         dq7DFT/rNpETkkym3hakofH39k6brvSIMr7b26aOhkAA7yRWwo4uTQWvx/6K0TcDQIkS
         6tXX/GBbA56DTQQp+W+kFET494AE/hd1GZEMxl4Ia6bSjuOtzmZujAA5hr0IprZGJxuR
         BVTsVJkMnVE6IAN8zRc9pAD8Obr1uvKkFmINoM8HW0IwR2S9032acXSV1pmg2WueNbot
         0NIg==
X-Forwarded-Encrypted: i=1; AJvYcCWaNpdF5RLxV8ejg4rc2TNAd9JS50mRlO5fuNMiNE78WSdjC175DqpDWtEOUG7y3RPM0iMNZrFAzOZ3dhf1WyapLfK2NY4utt9DRoyv
X-Gm-Message-State: AOJu0YwSxdrbGPwws71HJBY6jQHnh1ESjpa5fdKUsztOIXp65JCen6yd
	Ap4uyg73cgQxmWMEI+/ypSm2QyZTF8RM8u6hH54t4HWgVecpudnm6YKtB1+fXh4rSA==
X-Google-Smtp-Source: AGHT+IExLDeu3uIps4ittpz27fGovv/noGrlkq30qco/QggkpI+1lGcioSJgXHTUiOwnm6Lo+wuz6w==
X-Received: by 2002:a05:6a21:1789:b0:19f:c0d3:43d9 with SMTP id nx9-20020a056a21178900b0019fc0d343d9mr3084325pzb.37.1707767074000;
        Mon, 12 Feb 2024 11:44:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0cLlpxWEL157wC0tyhvqlvVRxw2HToFI4lHyJ0rsfBlU+cEaiJv/0SSwPg1CGsVabrR5RdqGAQ2Y/3JwGB7njQtri0h0hoIVAFZ008rPRKc2zOKZ3OQiVYp9whJtRtghZ4Ahcz2q427Uo+RM9j87h5QO3qYcR5fSGzXKjv09OF0ehjp/rjZIOHxPOpVODbdskdBhMxZ2yc9X1D72+fGIfzZhRFTza+yzLwOVK0vnax39MdXwYQHjx5MkQBMMCyf6KSfca+NgZQPDCOQQf
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id fa12-20020a056a002d0c00b006e0f6e6c014sm64596pfb.84.2024.02.12.11.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:44:33 -0800 (PST)
Date: Mon, 12 Feb 2024 16:45:10 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707767072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvPZ2Ml+uoIOAYYcFOueab5OR3zuP4CSL4jW9UY/oxQ=;
	b=DPWyE+FEI/9yFMRKXRojvK5OWV31gxFCw/b2sibBdY/T1GYsGQbaIplSQMhQMvOU4a9270
	JG9qjhGSle1Dz6n1UlvF+xb+kv/WgY99iiOurbuGlDCxwVagunkYU25HDOARZy3Nia8QVc
	9PfUokm18krdiTYK0+kKa74uU0+nBEJHPMAUirrqbciwBqKoKTnL8rm8AmHeTfntnvNbEZ
	Lc4hA6cL37ap4i0NBURQg4ckYdoJE1jFoAGd19EwRI44PmMTiFaV5FbnmltFiWD+JH1Pan
	cdBFWb7+x96mPsPFy1C3zla3yGaOo+vCr5wShqpgv6yLZhdaAnw9TIA2C82fng==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/4] powerpc: struct bus_type cleanup
Message-ID: <hzkhylt7euhqdofum2otxckc24wj2qzjuuqk3ufncfg2yb5bbg@oabi6h43zt33>
References: <20240209-bus_cleanup-powerpc2-v1-0-79a56dcaebb1@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-bus_cleanup-powerpc2-v1-0-79a56dcaebb1@marliere.net>

Please disregard this series, I will send a v2.

Thank you,
-	Ricardo.



