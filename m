Return-Path: <linux-kernel+bounces-83983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A865486A0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD8BB25E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B9814DFED;
	Tue, 27 Feb 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PlRbB+Co"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F851C4C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066471; cv=none; b=IqSq5owhv21lIWmUBXsldqLCYa69wrowDrNvfgqHxdzRjAgC2PfccLGNaK1NGjxbKC0BZPi4MIUGGD9kqCSnYTEKBnrGf/uQXw20pDDVitXQS8ra3oCHr+QZ6lPMqXEeeRFefSfEhUiF4iSjZUwc0sUdKVX4ivxXZ0rxJSvMc4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066471; c=relaxed/simple;
	bh=Kc8/DnEIqj9ihyvhHXZRL9D2xQyaeIUiwEE9a//D3/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHtNmjJ7p5jpnV+kOH4z/5z96tHS3EFwsoSaB9AgMjSWBEP3dYOEbDfG8R6fdfmiVYwZaxrD9/kqIwtNjK0hmTUEu9ZWvEseoHDOAcCslDRssEG4Xn9FoW+cQQKnzwxZq3CjMUx3oftEY8scHb0ySz9S/mQ5G7wujYPAzhKQOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PlRbB+Co; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3122b70439so593681766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709066467; x=1709671267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=juAeacRch3k681Zfd2bjBuM8kFMkd14jsXtMgJ5fuGM=;
        b=PlRbB+CoW7stIw9cye5TOSecpRUaGisFcwm3tEa6Pik5IoTBEh+3IzDopQhTLHKkNw
         Pexm7VxxFYMASzhPoM3KvT6yyul0FUpNlJUgNjsfal2e1AxqDfObyLiCPgcCYnHTN8Wg
         nHgwMVEr0ZrD+yGrZ8G0c8FWFDdRbizKV5hKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066467; x=1709671267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juAeacRch3k681Zfd2bjBuM8kFMkd14jsXtMgJ5fuGM=;
        b=d7dLUMpOob1o4k/8ytj8sENhOpZNuah4IDnOE17QdEvDBdSMjtIxiIl2fSuQE5AbnW
         GiLKgcQUnm+hN9w7FiZAw0LtdUtax7dR85v7D9UoP6QOOCCrTA6dKFRW20j2tDp6ENxb
         jyy+FfOpkr/OF1an/B8ZH5n42THzRWEoejJdnoOJMwBaptH8W11MsCNVkTQeKpSaAA6F
         94WrAoe+AahA6y0SfBypgFU3yxvpYhjYq/MNrKqT0sgAY7nNgI6XHpSyHsjD0HgrEc03
         znOCHsFpWGiIjO/lrw2PBTjRDxDhk7AamwtFoax2EomtD0923G31nXeW28B27Xg1emom
         TZFA==
X-Forwarded-Encrypted: i=1; AJvYcCUDllMKe61oH/hWAFK3JOdlgwjhjs9G4l/2Y0/fyMI9Cm8CFZvecw1fYKN4fhQPdW/YTE/M5vGCzaSmgFq5tFnOTQCT6dJqZIHvCTsn
X-Gm-Message-State: AOJu0YzV7swlNgUUwTFsfHS0HPNNBS3JXR17XYGx2XCjzLNEGSo0WHe7
	Jk5A5mY7Rw4Dpd3mR7rA40jU0Zc7slTbpTgPZeBSy64nALMijy53c1SqjYmvjSGidX7GVbmOEBq
	m6RDZNA==
X-Google-Smtp-Source: AGHT+IFn+7kyAZlKY7b8uSFZeTTDBxZxmsBNGCRIrGKyaLZEhXyCobVvSGQ0ioSOdE9u44p0FWri7g==
X-Received: by 2002:a17:907:20ee:b0:a3f:8925:50bb with SMTP id rh14-20020a17090720ee00b00a3f892550bbmr7258022ejb.76.1709066467614;
        Tue, 27 Feb 2024 12:41:07 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090622cb00b00a431e4d5deasm1099034eja.155.2024.02.27.12.41.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:41:06 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3122b70439so593679366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:41:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2Rd6xgwjbL7u410jh9qLZdCva3l5hAo3uPMcX7aKLNQpm8POk6q/EmQ4CZ+cGJMk6wWFBiKwJolgtAC5TBRlUerVSjvmL+F0W/hqF
X-Received: by 2002:a17:906:b349:b0:a3e:fce7:9393 with SMTP id
 cd9-20020a170906b34900b00a3efce79393mr6662120ejb.10.1709066466422; Tue, 27
 Feb 2024 12:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
 <170905253897.2268463.13371523233762430828.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170905253897.2268463.13371523233762430828.stgit@dwillia2-xfh.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 12:40:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJJf+FwWNcWEv15hXjK3v3VfPLabj-SqQpMk8qLM0xAg@mail.gmail.com>
Message-ID: <CAHk-=wiJJf+FwWNcWEv15hXjK3v3VfPLabj-SqQpMk8qLM0xAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] cleanup: Introduce cond_no_free_ptr()
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, gregkh@linuxfoundation.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 08:49, Dan Williams <dan.j.williams@intel.com> wrote:
>
>     5/ cond_no_free_ptr(rc == 0, return rc, res, name);

Ugh. Honestly, this is all too ugly for words.

The whole - and only - point for the cond_guard() is to make mistakes
less likely.

This is not it. This makes mistakes unreadable and undebuggable.

             Linus

