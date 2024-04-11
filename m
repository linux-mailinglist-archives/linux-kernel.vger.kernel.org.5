Return-Path: <linux-kernel+bounces-141553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B048A1FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4301C221F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9217BCC;
	Thu, 11 Apr 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="MrcYFg97"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F9F9DF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865446; cv=none; b=NRTWpRb8D8vSlROr0x+YV1AfeU+lv+fq892Poc0NHv4lzGoumSQAJziF58SBDMZseisxox0TmYV4ym04mdykWXun6AUdx9/I6Ao/ID1OplseNT/iZRJsfJX6/LjShyqi6H9WWV9SfUC2kcLD6Bel/7/etaeZFf3wBBxxW7bd/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865446; c=relaxed/simple;
	bh=qX84F/lXaQ1PVH00KjcK2IThFqDOeXh8hk0g/UzpyPw=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=J+1k1Aa2cLYabe9N+5Cr/oP9kDbg7Ar6iPNt8QF90PeLORwDTUFb2ZcvVV/jGYfmySvZSwI2hgrZPXT/3EdYrNRNEK0PtcE7sOG613fU3gkWOQ2vixzPvsskVPBuvYNAbITPO9B9gTC2umd24qSyDVJP4XD+nthLWzmHv2zIQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=MrcYFg97; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso214887b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712865444; x=1713470244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASuWKF1IyVny77juPKeYhHIQgdscvqAEKvf/s9kut2I=;
        b=MrcYFg97/G9J5mWBaBeiWE4JECOHIYPO5NS+0/90qBKGd5tvfYoQx4fDFMeHk1ZeK3
         sjNq9XTz094XnYQSvvDj5mDyEpzcclvBxDbh3q9aSjk1QnXr2zdo60Stss5l0Dzg61Eg
         Iv1LXIq+dJHXEwZ+gQW5+kLzeU7PmwQ9HY1crQAFOYmdQKGcQpLG5bX4cKx60jV0bRkN
         Khni4FE0BSRNp6R+0USuNWzu9sGxYPsFZfMVfD2yWXh6uvi9PiM7yWQG19qKOhBDehAX
         GwB+CQ1vcF5/tJjG7pr8ONWJ5NnTfw/iKZW6GXAS9xPei5y5Ii8zlYe0P8nbSbYr8OnO
         VjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712865444; x=1713470244;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASuWKF1IyVny77juPKeYhHIQgdscvqAEKvf/s9kut2I=;
        b=w1Z6gewkPktczeDpZnzuwS6Gd7QyFLspwI4kqNIXp71R5PxEgPRcjvGFaAzjeCeTXC
         t40Z1Z6W9Vdi6mIDKL8DeEHqBRtD5n3z+XwviGcO2wRYuIjEsXQCWXZpbFSZ62U/U0di
         7bM/uMOeNqFEJJSt99Feuh+msuSj8cnw/WQrkg4DQpxUdMWG+jPlFJiff2KQDHiPiLCX
         I5faJ5Fg1US94jo80bseJwO0ZFfm7Zk0SCgEVTBKGb95xDXR6SNfO+/5sGtWfHVxLdL5
         gXEIHSmn1+PTSb2tAfgbeFrs1bBKh0Oav50Jo3BDJqHrxYuGmuSHh4CI9AVY1EZiruYg
         0TaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu2dqXP2VHZIjTPEqjVtsYsXgAYjzhd25LZg6rQpr2+9XC1NKY60jDV+gJg9CRgmVaVOxQl5CvSgOnhgpClBfYN5fF5JRq8lzo6oHY
X-Gm-Message-State: AOJu0YxRW9MpfC09qH4JAjcOc3ZHjxzte8W4xuvFN4WSZq7250LajT7w
	hXt0QhUvlH083amvy2IO8uDn7KaNSqrK3FdFNhEQYRncBYUOKbp0rEmGcgbWMs6xI4khFqUNbZl
	K
X-Google-Smtp-Source: AGHT+IGoeWkdZaGSZlUIvJ4+wlGVepb/0/HzuNHkaPvH2S+cbxddwGFXFYFQo0xSCJHBhfC++htiGA==
X-Received: by 2002:a05:6a00:1a94:b0:6ec:db05:36d2 with SMTP id e20-20020a056a001a9400b006ecdb0536d2mr801820pfv.4.1712865444236;
        Thu, 11 Apr 2024 12:57:24 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id y25-20020aa78559000000b006e6c0f8ce1bsm1555237pfn.47.2024.04.11.12.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 12:57:21 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:57:21 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2024 12:57:18 PDT (-0700)
Subject:     Re: linux-next: duplicate patch in the risc-v tree
In-Reply-To: <20240411080622.0cd5502c@canb.auug.org.au>
CC: Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
  linux-next@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-e6968c18-74dc-4091-8f0c-6be1437f8167@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 10 Apr 2024 15:06:22 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>
>   36d37f11f555 ("export.h: remove include/asm-generic/export.h")
>
> This is commit
>
>   0316e4b04e01 ("export.h: remove include/asm-generic/export.h")
>
> in Linus' tree.

Sorry about that, I guess I just picked it up as part of the series.  
I'm just going to throw away the version in my tree, it's a cleanup so 
it shouldn't matter too much.

>
> -- 
> Cheers,
> Stephen Rothwell

