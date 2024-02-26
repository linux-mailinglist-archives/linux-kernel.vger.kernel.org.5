Return-Path: <linux-kernel+bounces-81309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F38673DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ECD1C27A44
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17EA1F61C;
	Mon, 26 Feb 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJtHEJyc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3022EF8;
	Mon, 26 Feb 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948218; cv=none; b=TeTfLPoMV/z+OHNnXr7KWt5rRCcrOQQTOq8+KO+3kBlf3ml4mmNFCCB9AAnGrXtvRPRw8Zphp37BeHPuER9ACfuiIciv8q9lXBo6jUyolbKQGQx1MJ6Tl6khJvsZrBOde+aBkiRhhERdJZOiXsImxtsOh2LL3JlL1CEgGSyztkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948218; c=relaxed/simple;
	bh=Zz4It40rCfzYgJgcxxhcmSR/4rm3qRBwnrdtdAkbN+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=peSk5qhR8GBEvScxbjWfqyKG6BVggbswA6GCeN5ffSawmcXZWlyR9ZQ18CyAO1mSqW9+QlGqEgYmaEMGcaNGIK/TwwGu2+sVgB3JlUUKvxxyIc19FRg5MIop/TqUAenxMXlYWt0yCFJ87lQBh/wp3B3Dk2Iet+UKv8dFwtv0Jc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJtHEJyc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412a3ebad2aso7268435e9.1;
        Mon, 26 Feb 2024 03:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708948215; x=1709553015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tT7qzPkUbJLvjuR9/4oPIX1uKCZBeRxZ0EUxJGmNjFY=;
        b=eJtHEJycoZ5QdYA+IUTtWQOOQsCWtfs0MQi9Ta097vtpbBHwAEP4OscF4TCAWHNfVq
         zF2A05OGMZl5qh+I2kB3om22FEyIG0W6aYhoGTvMLHcLxRcsfTxDtrOarIsxYSP4NwwY
         05BV0cfwFDGBIjFtU8A9vD0+T0dBiQWzSSAOUkItyZ2yNqneYsAS/TKi+Zv0HzHdg3Ox
         X76ku0QdQrl6PmafY1KrDolAZiobaaUVH+HUN/aPhkAyeoHQcc/R8dWQRtxabovAW5O0
         P4dL3gGlMdPIVzVN+UYusydxHmSWJ9sELXygQ7QpO1a0rFzDAH9H6FNkyuS9p3LP4C9g
         U0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948215; x=1709553015;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tT7qzPkUbJLvjuR9/4oPIX1uKCZBeRxZ0EUxJGmNjFY=;
        b=GkweJRBdbzEkDjAgE+PMEzMBnxuHx+QcZthAJ3Wj++/pn0LEpuOw8UDqT/D+1996Se
         EfF/O1tI+OZnxOsfj1jTuPe0qQv/t5OJb43AZRFnxnD2hMKmslvwYWM6GOLy7R+z4rDV
         p2HvP9r7G43G2cytGJPsGDqTfMb7CrE4SishYWgJdAO1k/V4QI/i6DRRiWXTclG43Ujj
         C25+/TrnPeKLidMPwdS1wMNaLoYrGOnKiGH/fgnPLcgfOFZU5PVBm34WNkYAJ5SqXR/y
         tgmvldmb15eTGJ7SNYK4K0E7DuFrkoYSAWRm7mUMlpkpDdRVpuYQmm7IQ4vBYD7ukEnA
         EFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2hTQEX9w6LV3/rRXWJaTfwHqkyu1OagHbXpU03wJfYMIP2OjmX2bcGCmNBFCHU9pBoCjuQKDrnJN1sSasqJiDGGnNE1pIIHycm4CVq/nWM6pv5fUPjK9KkH41QDeo2Em6Dykt
X-Gm-Message-State: AOJu0Yz1pAjZWzWzrOO24MWOQLgsZKJTXEo+K/n4/h6PJaMuhOHIQIuf
	G0aUPDYa3rr3dvti2AYAP0KGDxUa5jjv6yUonAGpm7iDqEo7akCR
X-Google-Smtp-Source: AGHT+IE+3zWMBYJo+LOSNnUPTM9uv9HLgb9uhPZcYSkJYb9Wl35oOzWViwr1kfefKsqRRdk3DUsw+Q==
X-Received: by 2002:a05:600c:4f01:b0:412:a112:ac6b with SMTP id l1-20020a05600c4f0100b00412a112ac6bmr3184290wmq.4.1708948214814;
        Mon, 26 Feb 2024 03:50:14 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id bx10-20020a5d5b0a000000b0033b2799815csm8202532wrb.86.2024.02.26.03.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:50:14 -0800 (PST)
Message-ID: <f8d32b4c-82a2-4c70-8cae-424e898ad155@gmail.com>
Date: Mon, 26 Feb 2024 12:49:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1] net: ipv6: hop tlv ext hdr parsing
To: David Ahern <dsahern@kernel.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9b82bb29-9316-4dfd-8c56-f8a294713c16@gmail.com>
 <1161ecf9-9db7-42b5-a277-d92b2672dc89@kernel.org>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <1161ecf9-9db7-42b5-a277-d92b2672dc89@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

David Ahern wrote:

> In addition to restoring the const that Denis commented, this really
> wants to be multiple patches in a set. Also, it would be best to have
> selftests as well that exercise the code paths.
> 

Thanks for the comment.
I'll think about relevant selftests, and submit a v2 with the changes.

