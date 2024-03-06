Return-Path: <linux-kernel+bounces-93712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F708733C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E36F4B29C05
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90ED5F875;
	Wed,  6 Mar 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GUyHMI8e"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485605F566
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719784; cv=none; b=py//g7mQdXIr0OYAcnGehz0NS0u9+Z+mq2YCo0yvDLSSLq5hfk5+BlpM0hlIVY6YZUJ3txIUegSZl8feK7cGYX+5AP1dujGrmwHeDrIL6lEqrOKWWSUBQ7l/hcdFd2b6j9uuNEelQnoryPYRwAAuYjH3IKVGTryWp3kf/K0bYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719784; c=relaxed/simple;
	bh=0PccJErTXHfkHNF0XMu4d/4cmRjalvJVodpw/sl2B/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5+VyeOwVOUo1asXeXYOpIXdqBSBTPgwNgfSqzJhWXte3Sa8RClb7/nVZqXs2+T6ZgDPmdr8Jh8h4pyLz6d0Xm+5okDwfQiS/BCZrYvR/R4B+UCqeOEqJlKfdxpPUieF+JjUURO8Y+4QdlaRtwclc0gGxHa+/2RTp0LHHeAYSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GUyHMI8e; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so2218353a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709719779; x=1710324579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0PccJErTXHfkHNF0XMu4d/4cmRjalvJVodpw/sl2B/Q=;
        b=GUyHMI8eu0HwnZaN3mZxnaw6WtgSJWq+jom0ECcQiRrN/jVWCIzmdLFwgIUgg+uyIj
         8AUgRZEQx2vhrcpBE2+ayQUxFOxwIMscdy2bjnvWWKhmJZve0gBxcfmFjVfqv8RL/zPg
         0u6MadqV89KSptM44YFbwPW8c13oHr8Cfxd6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709719779; x=1710324579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PccJErTXHfkHNF0XMu4d/4cmRjalvJVodpw/sl2B/Q=;
        b=wbDAX8OwiUoeQz9cl4IjSKO4/Hk8PQpPaAUwakGySDrGtAxk9ob8Re8j0+RZn7aj5Z
         OjTXdo9duyG1QroyZ+Exu2yymyIUp2OhwyjH1DqJiCW0rNlIg5g9GA3fxoOl9DhJAGvN
         C0fKFmodOwgq9mj+qY0m6JRnvWVrwDPtES92mEx2mlxK9EA22RQzLDWtBO2t7dnxYvUU
         v0TI5SCv9uW1Xj7lrNiP9Lf86aJXLCv0CKwVcDKByVHu3aZpjWt/OVsD2QGhz8VC18ef
         OXV1Q4/BQFDWSvzaSpmgfgtPINZmQNPsMXIXLvIMvwc0H8RtTne5qvy0OhE90Rw3b2h7
         R9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUXc6azeEFNEp3iffKQgZwm+CmtlfAMsc+0TREsaDnFExgx/UrpNmff/PP1k5OYORZyhxSupfYc5zMMXZxPB5wy5gywK4/Vthxfq7XW
X-Gm-Message-State: AOJu0YxgwcgokyKFkTPCL8t26I24R1WPTWzbw9NPhlD+0R5AiCLvergc
	ucVqXw9XsYV1ZoB3VLbUNpJtx6IIKAXMeFCELISMNSiwTdDV5n14zWqRZWKsePZCyrSmz/XuSJq
	PfP0umqBDmAl4roN50YcGaqii+oIBNLoJH3QRXw==
X-Google-Smtp-Source: AGHT+IFRWLJmYTfiQQ9IQCza1Cgaiv+dmFKZL7V25wJdmMcJXunLADhAUYgk89XezMRItWsiRwu58/w+/rajyS0vIW0=
X-Received: by 2002:a17:906:364d:b0:a43:811b:71de with SMTP id
 r13-20020a170906364d00b00a43811b71demr9390748ejb.38.1709719779577; Wed, 06
 Mar 2024 02:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007153956.344794-1-shikemeng@huaweicloud.com>
In-Reply-To: <20231007153956.344794-1-shikemeng@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Mar 2024 11:09:28 +0100
Message-ID: <CAJfpegtjB1RufZBRTJ0wh_xdtbOdGkyuxVV9kNV98WxbUiqQFw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: remove unneeded lock which protecting update of congestion_threshold
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Oct 2023 at 09:40, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>
> Commit 670d21c6e17f6 ("fuse: remove reliance on bdi congestion") change how
> congestion_threshold is used and lock in
> fuse_conn_congestion_threshold_write is not needed anymore.
> 1. Access to supe_block is removed along with removing of bdi congestion.
> Then down_read(&fc->killsb) which protecting access to super_block is no
> needed.
> 2. Compare num_background and congestion_threshold without holding
> bg_lock. Then there is no need to hold bg_lock to update
> congestion_threshold.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Applied, thanks.

Miklos

