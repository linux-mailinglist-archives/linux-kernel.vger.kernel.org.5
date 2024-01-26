Return-Path: <linux-kernel+bounces-40698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CF283E44A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9C21F22E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAC25634;
	Fri, 26 Jan 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ELvwkOfN"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F52556B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305890; cv=none; b=lewUpVczqmT+PaJCTOnJ9iE4ihXSDYge8okI5rtaIvtd62ZCLKtjyQVU3Mu9E0IQx1+zsHTzGc7pI1+JbJ7H6EZ2YnezAc4Dw5GHxZ59vihdfbMYLmWcFtzXP3KIvwD0riVUs9Oy7w1tMXi6LtT+az1udA1L+zepLOtfrAK2+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305890; c=relaxed/simple;
	bh=04D3xXJMPnckdiNNY8fguQ6tU0HevW+YvL65Y5Kj82U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiKsdUqdTOLhjM7B7lXeI4+j0ENWL2+PKlTRXz47L7DKPqZTJhbM1U7clv0a3QbTR/FcJw76AWD5hZN4+y5SYNa4G1PlN6K+OO5mzZVE08FVqeUbkjD6ao1K1qroq0efVQK06NRHZZsKya47+PKqm7vA3xR6ncRCDcqLJXpNhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ELvwkOfN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf3a04ea1cso11115541fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706305887; x=1706910687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MqrpniylWfWC1VCZp5L8n3yVakZrt949RVza9zF/u5c=;
        b=ELvwkOfNep7nKdDz0agyUKM3tysasFoSOuxg5dg5gTpmdDRU91A59mUDbT/wzXxzkF
         3fmM1rTpJAPFiDQQJiT0RIiPk2OPHAIXrI3Zro40mNQ66Ct1/FuMXM9MFTVkKYYdVXZy
         g38c+XiKAXwjI46MwPMsZlqSLRqiUG+ZtFCW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305887; x=1706910687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqrpniylWfWC1VCZp5L8n3yVakZrt949RVza9zF/u5c=;
        b=PW2B3RxWawRakwmNFtdX0aiqTZIPExAXEsbbH3NSCkfQ+1qP4ccuDs3adUkMpT/b/r
         /6oRp0KLDdB72Xca7KZfc2wEgiLZZB9+GUMdDF5pXekmohMRpDyXghqBtv6KE6keDVWE
         4x8ZoMGtup1b3toj30CAYesyLe1teIZUSvyYns6gD0sxCCJ5t/6tMgmpTr65SOSk8/oe
         Qa5PZiKboFPR6xiYRoZI73PFzydfknL9Ej8rKdpmQ8FzRep4apsGsqGOzI1thPrf31Yb
         r4I6pTVEEPgqKYe+HBNI+77noR5gl5L+UZ15XLyckipjTfQBM1CGRjBfAxVOfLq40xMs
         aGjw==
X-Gm-Message-State: AOJu0YwMrUCFRWjzFB5TdIDA0x/qgVATnC8SCh3uKe3RdHmBa03eMkSf
	SQtWMBnaG6KTzMLFWXBP7/bS24IJcPoIvcCwjKstZhxvHh5Z11Nler+ITsSnSIQ27BvHbHnS2Ze
	niPMUKg==
X-Google-Smtp-Source: AGHT+IGijJqVFcmc6Pou6CF8BH5L0nxTTjISjx6tvsU10Sd5zPOElK71Sz3FKLfSjgtBKeZrmIVGvQ==
X-Received: by 2002:a05:651c:1423:b0:2cd:8f26:a1e9 with SMTP id u35-20020a05651c142300b002cd8f26a1e9mr240093lje.37.1706305886756;
        Fri, 26 Jan 2024 13:51:26 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id if17-20020a0564025d9100b0055c741533e4sm997679edb.55.2024.01.26.13.51.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:51:26 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so13572555e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:51:25 -0800 (PST)
X-Received: by 2002:a05:600c:548b:b0:40e:7d24:cc15 with SMTP id
 iv11-20020a05600c548b00b0040e7d24cc15mr344687wmb.34.1706305885604; Fri, 26
 Jan 2024 13:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com> <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
 <20240126200008.GT31555@twin.jikos.cz> <8b2c6d1f-2e14-43a0-b48a-512a3d4a811d@suse.com>
In-Reply-To: <8b2c6d1f-2e14-43a0-b48a-512a3d4a811d@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:51:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjhtqo_FEqZkPuOVUNZzsGhjftdcN9aQpA3f3WD0qS1pA@mail.gmail.com>
Message-ID: <CAHk-=wjhtqo_FEqZkPuOVUNZzsGhjftdcN9aQpA3f3WD0qS1pA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:39, Qu Wenruo <wqu@suse.com> wrote:
>
> Oh, I forgot the most obvious problem.
>
> This means the extent buffer is full of garbage.

Allocation lifetime problems?

> What's the page size of the system? 4K or 16K or 64K?

This is a bog-standard x86-64 system. With 32 cores (and 64 threads),
but there's nothing remotely odd about it, except for the fact that
it's running a very recent kernel...

             Linus

