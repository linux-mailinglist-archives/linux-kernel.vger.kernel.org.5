Return-Path: <linux-kernel+bounces-29578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B543831060
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C57C1F22760
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD822631;
	Thu, 18 Jan 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CZ1a1DKs"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7F10E2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536686; cv=none; b=MTJAGzs3lf90Ba+pJQdBF+LI1W5LeLUNsxIEf6T+fGII/PkQJvVyDzyzWzrTh/DQH/3sTMX8RBNsAhwfgNfqRc0a/dGlDVvM9I6DSyYyF6GZ8tuC+HwNPPvCsfuaM8IdAyCYVMrsMlT64JiLP2O+i25YPj4/PBubn27RHpuKbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536686; c=relaxed/simple;
	bh=1w5Q64brPeYx8/ViGQBpGfdLrhYesMFZVAAlV6NcyTU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type;
	b=jhpOXRcTLXyNQWr34pj/C+PpDuS+FVUS7+CNjKmZM4DMoJtsjsPF1M9oWUd4Ql2U9Rhv5OYZUK/ktYTfZnnRmaCmRfTHrTNQeyzZ9tPVtLrlCJgvKsAQ9AkxXoRnpziptVGSi48aLD+lT02ZeXOiQ13tAsUww1XdomsbYyOWuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CZ1a1DKs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a29058bb2ceso1232852166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705536682; x=1706141482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DH3fH0sAOwBA09p60ldRSMkKa4SNaStD6jUtWJRacm0=;
        b=CZ1a1DKsvHFNatqJEDZVVWubbzKXj1zr7+jhss/u03AH+PBNhsI7B8+ngeCQMCkqo2
         yUvbcoEWXNdxNLNtw87lE/kP7hxP4EAMzyyBrNQFkmf7SIf28+Q+LrCWEvr3xcmgc3hV
         d2z7haRasYut2HhCUol5f3dVcnU9G9qoTKaDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536682; x=1706141482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH3fH0sAOwBA09p60ldRSMkKa4SNaStD6jUtWJRacm0=;
        b=GO3jWR89uejuEKWA+f+LNosl5/P8ZzIWTgwN6IsxgY8dT1lnSoUZoKud0NUEE0+/wU
         uHv9Ud8yhJuLbYG5VUsO1kEIiLmat5ppoR7RLppDHtA+0qpsXtgZbajnHP8i8MUiJhj+
         lFkanXZjGQ5WreYwd7uA9xcA+2R+Puv0/YJXzEZR/7NPiVQzj+cxWbyEwVH+O8ugk7vv
         kZx5LwUz6XSITAH4elV+wBwfd+ucyh6UtJC/k9sV8TAIdpthsFVnvCEOo5GiurOKL+hB
         4N+zD/q/x5Xt0LKWcNjcgGAJWiDmG0bMTESN5RMVE7VIw24qaD7NAgM2wIYl4P9h/mk7
         o/QQ==
X-Gm-Message-State: AOJu0Yx8+LYApUymD0AMuEeB/hsxW/aaRBdsMyeG22fhlhDM9uQteQWn
	7/aILuYas7hSHtc9pSs9VcNumhPjBlFAmJ6tb8xAKhWoChDkSLecsAsec8gosEXfdSdu6+9Pdyy
	fZnRwtQ==
X-Google-Smtp-Source: AGHT+IGNt7+1pes4xTUZFcAhDxyGyzJv3T5AnML/bTjlskbhYiurSZjXLii+WQaqVgYfYvHnf44Zpw==
X-Received: by 2002:a17:907:a08:b0:a27:a518:5c03 with SMTP id bb8-20020a1709070a0800b00a27a5185c03mr3901ejc.129.1705536682155;
        Wed, 17 Jan 2024 16:11:22 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id ot8-20020a170906ccc800b00a28a8a7de10sm8393667ejb.159.2024.01.17.16.11.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 16:11:21 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so14418477a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:11:21 -0800 (PST)
X-Received: by 2002:a50:d4d9:0:b0:559:f13a:af60 with SMTP id
 e25-20020a50d4d9000000b00559f13aaf60mr38690edj.47.1705536681376; Wed, 17 Jan
 2024 16:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nqrl5ggszhlzaew6yte6t6uv5cbf4fhl5vd4pfhkitlsbqozvf@w4pttrz6supl> <20240117180021.GA539437@dev-arch.thelio-3990X>
In-Reply-To: <20240117180021.GA539437@dev-arch.thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2024 16:11:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgx15ew5SOkri9M8dXnX1WV4__FZdiJoQ=6v8nj_7YLmA@mail.gmail.com>
Message-ID: <CAHk-=wgx15ew5SOkri9M8dXnX1WV4__FZdiJoQ=6v8nj_7YLmA@mail.gmail.com>
Subject: Re: [GIT PULL] power-supply changes for 6.8
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 10:00, Nathan Chancellor <nathan@kernel.org> wrote:
>
> This is missing a fix for building with older compilers:

Dropped from my queue, will wait for a fixed pull request. Thanks for noticing,

               Linus

