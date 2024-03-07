Return-Path: <linux-kernel+bounces-95048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FBC874895
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7797A1C21A46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33B1D556;
	Thu,  7 Mar 2024 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVLvf9cE"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995610A34
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796136; cv=none; b=NUK66KhF0gSoZ02UYPPHXjU5NHBWoQQC0Iv+UzJruor8O2yVYl4jdn+uxS8lsyopCoWHtMVJtnMfl1qu0i6ijdCJ5yaM/IFmohJClIE2rUK0N3Tln9cgeHuXdMprdD23ODQnnvA6lh1/wrSGxEInIQWSOznZbvP4BOjCoLGg03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796136; c=relaxed/simple;
	bh=3Wvh//EdEK7OkgXxQfeb2wrZ1RrXwb+Opckfe+jFRYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjP8un908FkzS5XxD7hgIYrDCnMxf3Ig7s84Vo6YQoIfKZU1C3jMIDHmW1X8nl1gBoNIYNZSJzlioc6I0rBZ5KrgEWOtIJHY+LalSfC0U97jeaWSy+vqNyUPyBSW99fLzvizZ9TMjpA6kQj87X3hXLSCQjBdlKzfOXAGGXfHfzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVLvf9cE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so89038966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709796133; x=1710400933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/YnS539ptGgyKKHfv4qhBSslUWwHqXXifjP5zqiAvI=;
        b=WVLvf9cErRaL9IHCERBoAZAhN8c+q1bd5oELRfqtAwYH7VYpK17T+lX7koaDkZsXRB
         HMDQkt0u1GPK/gaGLk5FPJseHfxv4yBb0ZAUKtTkQAMJY+gXV+hBS3+dV6gPmJT8an4Y
         XSVthYuqhi7IOt7t0e+s8lXLf3WrL+tpZWl/fyz3gktXxFDb2gO5mcdHwEfJi5WkUF3A
         O/InF2EoVBvnv/VYjCywn7AWJ8UQepBZEQggZOIdJAwbJcuWXdETZrvPojEiIfFxsXmh
         h+EO9UH7wCYcvRHY1fn2MP54wKb3NKkXbqpZKx3n6tLirIbSq9iji8zOUyn7O3iJSkUU
         BXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709796133; x=1710400933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/YnS539ptGgyKKHfv4qhBSslUWwHqXXifjP5zqiAvI=;
        b=KKIPGJhlEMmmDmHnv9e6htlhH/TTrfv4hpmUEBSb/C1YnHm6lh45C7d6UUtLq0+JKJ
         YGEgeFQWhVJLe8RUrlo+XJEMFUbwCP9MwlTXnMjpSPTiUIC3eKzK4Jp4UZBmNks3MW+K
         o2FiorKcU/91xTacQafTUW0+ddLl9n8LYyv/Z7snTvLssC2+fGCtuk0VKEsrHQKROAul
         nApJUi/+vGWCTMnBYsxAvliGyhn2m7Y1HVecF9VfoFZjrUutFtWX+RJIL4wllBTgV8Aa
         xHugLPSe45odDbMkk8nd1DjmOQCw9o8/J9zOrnhHC5aL17OxEk9yqmlVspkK/LzP/SJM
         Wdmg==
X-Forwarded-Encrypted: i=1; AJvYcCVMVEWUZhDCtpI26vEAVh6g7Tdwjx+Ww1/2E+GZUUZjNyHPcjGtHqSbSzsmzOI4mvpVlSfeu7U+G+y8KB7OOmy8r51TC64L4ewxHdrO
X-Gm-Message-State: AOJu0Yw1OfpS41O28USD+oz3OrmKYFut6YSNDmh7z0o/Hi2HKlmEWige
	cfA4s3Xz8bd8lzi52FVn+dTnUy8Utz3kXhbZ1yX1jFaSu4iy+kTM
X-Google-Smtp-Source: AGHT+IH9OMD/+4rfy0poFbuqXp1wQlsi7ggivfzbiSEMqYHCyGWHqBb+sXt2TyB3psLbAjPsApO1hA==
X-Received: by 2002:a17:906:da06:b0:a44:4c7e:fc07 with SMTP id fi6-20020a170906da0600b00a444c7efc07mr12293907ejb.0.1709796132798;
        Wed, 06 Mar 2024 23:22:12 -0800 (PST)
Received: from [93.173.64.159] (93-173-64-159.bb.netvision.net.il. [93.173.64.159])
        by smtp.gmail.com with ESMTPSA id mb17-20020a170906eb1100b00a4490267ecfsm6807468ejb.221.2024.03.06.23.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:22:12 -0800 (PST)
Message-ID: <b9af7523-8ff5-f35d-7f5e-a3b5f3aefde1@gmail.com>
Date: Thu, 7 Mar 2024 09:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] char: xillybus: Convert to platform remove callback
 returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20240306175710.82569-2-u.kleine-koenig@pengutronix.de>
From: Eli Billauer <eli.billauer@gmail.com>
In-Reply-To: <20240306175710.82569-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

No objection. Thanks.

    Eli

Acked-by: Eli Billauer <eli.billauer@gmail.com>

