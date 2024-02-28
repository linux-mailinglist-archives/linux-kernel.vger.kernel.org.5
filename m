Return-Path: <linux-kernel+bounces-84285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970186A491
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8172FB25684
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E3111E;
	Wed, 28 Feb 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KAx74stG"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA9A29
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081535; cv=none; b=ETREUocxGUwj/CypVLIhWjsIswX7vYINs83AMTFpzyraH7wrkw2q65m9HenIk11to6dOEYQzNe4NK1J4k0vuJXPgQj8e4qDl2T6snMKdPt/V3yFpoDyYq/PX9hA0G2mX7yTVoSdcthRmrrln3i5oPDUYkUchlOIx3xPC9/480vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081535; c=relaxed/simple;
	bh=/4+xU2nl2Qim7JMaWpZ5/E+UvRv0P+YRKK4Rvx4upno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXdwixKlnlfQXEDe3OEtD8HgTV2HQsMV+tNocOkzSIHWDx7M5Djb1r6hZrWIW4COCxRaHAbG1hFfVlaofQBO8GGICOThtTIbjuQioAshBw16xwOlmMnH/ezx3KfJnD+ojNDwVNIQ/6xILrS9mjvPnqnIGU5KWsoZym7CPh3cSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KAx74stG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d2505352e6so69648221fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709081531; x=1709686331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H/XDCG1AIPihXz816FH77DikjrbKv0OtTNG33iOLSO4=;
        b=KAx74stGkQPTsABFbcSuIeZWuWQMOlxvKFswlentJs3zjM1ezqnm4jlM/IqKlGaRSR
         73o0ak14hZ/gAkXKaN7UQaqSy/32aD4m7PS4K62bFM+HOl6p/2qsTzxasL2b4xs5YaZ+
         ueKMR7hhtfOkF9WK3xLikfPCcG3NQ0hKMPqpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709081531; x=1709686331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/XDCG1AIPihXz816FH77DikjrbKv0OtTNG33iOLSO4=;
        b=rWi+DwDh4klen8x66AkLsrtZ28VZKWhd5S2M8Oj2WjykG504R6ZvhAEIxgh+dFmxz7
         OGTDO/8MDd0gBYAtNhidifzMzDYcfQRWMGrJEygX3/zl5TjNrijDg3g+UaY14FJekuZP
         l5lQBgljJfZ7uodv3kJQ3eBwIIKsi7L/YL3l2QyD3TMiHIRO7X3NJdj1WSvKPnI17uwz
         5ghrqA4uquiJuvN3AFsWNVLZRIGNP767erHtITSx8VEFD9S+CnEhABe267vKCjiURrbq
         Y13y+TzDe4HJmPtxFq/Y3KhEAe19L4nSQNpMzt9ZTnsyewyOgP+batxc6ezZ91zggFFM
         djWg==
X-Forwarded-Encrypted: i=1; AJvYcCXDQP8QoqkfTswL23m5L5Qf0IMWrw8+A2ZyWJHFD7zk4ai5AxgpznD2nrcGCfYTTYJedVF0iVnxhw9MavnTc5zlZvbwDBBTjlowyzHZ
X-Gm-Message-State: AOJu0YwhgMpqmSG9WF2C7/NDazbBYaQPRG+bHC16LHBrxFOwUp0T/07H
	+pTSmYROl/CxbHt+Cp2gLbhfG5/+pk7JoZAp43LgQZMn7Haum4jgkiA+VqepSuAzaNGpCRwvKNk
	wCu+iQw==
X-Google-Smtp-Source: AGHT+IEX6+JSmROyLy8j/Pix6GNzAamlVJmqEIijqmwa9CvOFYrmZ+kbWPeMflTEHuajVpzHk16+HA==
X-Received: by 2002:a19:e01d:0:b0:512:d8fb:e45e with SMTP id x29-20020a19e01d000000b00512d8fbe45emr6892065lfg.45.1709081531405;
        Tue, 27 Feb 2024 16:52:11 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id va27-20020a17090711db00b00a3d81b90ffcsm1265313ejb.218.2024.02.27.16.52.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 16:52:10 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a431324e84cso375477166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:52:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDNaoi+Ea4aYlrS7WSq5Crkyqnjng4dTQHECm7gBggNfDLcaJKPqs73et9MlEBjWXp/2cHatc+1scIQjR31TnrB1Y+1NKXCwYBQ1VN
X-Received: by 2002:a17:906:36db:b0:a3e:95b8:4c7a with SMTP id
 b27-20020a17090636db00b00a3e95b84c7amr7569487ejc.23.1709081530526; Tue, 27
 Feb 2024 16:52:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227145619.40b2f9b33dc2723df27f68c0@linux-foundation.org>
In-Reply-To: <20240227145619.40b2f9b33dc2723df27f68c0@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 16:51:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjk98Rt6PYgwrEp627ociAzWrRpNXOg7TRJcDO_nx1==A@mail.gmail.com>
Message-ID: <CAHk-=wjk98Rt6PYgwrEp627ociAzWrRpNXOg7TRJcDO_nx1==A@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.8-rc7
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 14:56, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> 6 hotfixes.  3 are cc:stable and the remainder address post-6.7 issues
> or aren't considered appropriate for backporting.

Hmm. I notice that you add "Link:" pointers to lore, but you do so
even for emails that have been sent to you without any lists, so that
they don't actually exist on lore..

IOW, that link-generating automation of yours looks a bit overly aggressive.

                Linus

