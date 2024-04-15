Return-Path: <linux-kernel+bounces-145639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B99B8A58D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242DF280DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37483CDD;
	Mon, 15 Apr 2024 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SKn8gTAj"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5E83CD1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200913; cv=none; b=DDSNE0G2lZ6z0ZX8/69NcUXkIwB3OVFYsXUNtps7rZ2egWx2ECI7p8s02zjuwTCD88qb/pTxHysqD3AfVFv7BzlHdbGGiMuBZVnNwQ2OePSqHnXWfaGiRwGQHaogJ71Nm48HbHSaZpmc8AQYwGmnoFQX1DajY06gCdAyrFjMMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200913; c=relaxed/simple;
	bh=RugWEcPj7mLc+ykQmVDXsINc+yUnD4Z6zG9Nxnjmzg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE9E2nwPg4xmWIxJvY7WsoOcXJBtG/vTW1WyPtnrCo7ff4RNNMSx2jO2RwCbHgTqcm0sz1zDIU1geMz0T3V2BU6gQ592HSsvDThBg0GLRqAtJxvyk8wEontL0z3dhos5gvY2UzujgJ4OCO0bjNn67qzYkWuZFsSZFhE4mp71gFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SKn8gTAj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ece8991654so3189007b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713200912; x=1713805712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcAaLIzTeGt6hWYjO1jT3BQBc4jW6jSrXxhMBGNGb14=;
        b=SKn8gTAjJKMUvDZi51tQf5VIfrSZN+ezeWMCFyhWIQuVkBf3DI03hUSfmFLlpn1Sca
         i8fXbZyQ9jey1yfwJzRDWlVII6iil+ugpBmqJy41XE5qkLEg25lotpxunJd20OZspQpw
         DS+Nrj5isK6se5THFuGK7fI4fFGvYKJPmNQD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200912; x=1713805712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcAaLIzTeGt6hWYjO1jT3BQBc4jW6jSrXxhMBGNGb14=;
        b=Mdbi+Q4n6nm8sP/1Im8XTOs2VCsgCmmcA4T55xr2JjNzz1acaubgNMbeR1wofFh7Rj
         UEXex+5LjX6MCPAzuZtGzsloWt7djCmnhl2WHQX/mPoBPm2MsLdaUKkTmZXlvPPeRKWk
         cIjiYmxNE47tDS5cO8aS2obrguc/0bRYGcST9eyNmX8ToD61JBUWyeoSBVk0YZz9hx2D
         /tE0AYbWlQjt8ajtxHgzCr6AYqzDHDMsKahxf5oTYXhW9Ahjpcu3FeqhvsHKj47/ggxy
         JhRAdabI7MDQ/3a0nqMozI/vogMYBPTdPq0triwdE1QVOJRhzM/gDbGAaf67BRy573xD
         qQRg==
X-Forwarded-Encrypted: i=1; AJvYcCVbtQAEAMtVIr3Vs0oamWMwj5x2LJOh1OhSMBbfMktf3fd6AhF8BxW48ZlvylRvrSqNSBpA2PydrQPIHoNL+14nXZbj/3bRxj6JSNs7
X-Gm-Message-State: AOJu0Yz8hWCFyS1hyZsM+FRpxIyJ4DMEjV9Nq/82Exk9HTi0Vl+zwNGz
	x/TUDAK82LhgcxWPmv8Uq+Hy14aBxtyLgMQbUd1GRoS9FKON7O+HyjAvuBpnWQ==
X-Google-Smtp-Source: AGHT+IFS60V/7PQX7NA/39zXZhcKumbWVEL+/evOE3BhhEe5wnSkFy5tdvukgRaWDCkry3aMCaVenQ==
X-Received: by 2002:a05:6a20:734e:b0:1a9:9d07:c431 with SMTP id v14-20020a056a20734e00b001a99d07c431mr15727248pzc.53.1713200911943;
        Mon, 15 Apr 2024 10:08:31 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k28-20020a63ba1c000000b005f0793db2ebsm6302106pgf.74.2024.04.15.10.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:08:31 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:08:30 -0700
From: Kees Cook <keescook@chromium.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Philipp Stanner <pstanner@redhat.com>, Kees Cook <kees@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <202404151005.EB7F67A@keescook>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com>
 <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>
 <f08c06a4e8361f2cb55cd0dc1fa2bc2b0a046049.camel@redhat.com>
 <CANiq72kMZ6mpK+LaL9Xfsp032CZOfAEtr6Dp9A2R-m6dC3gkWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kMZ6mpK+LaL9Xfsp032CZOfAEtr6Dp9A2R-m6dC3gkWQ@mail.gmail.com>

On Fri, Apr 12, 2024 at 09:58:57AM +0200, Miguel Ojeda wrote:
> On Fri, Apr 12, 2024 at 9:43 AM Philipp Stanner <pstanner@redhat.com> wrote:
> >
> > Is that going to remain enabled by default or what was the plan here?
> 
> The plan is to ideally keep it enabled by default, but I defer to Kees
> with whom we discussed this back then (Cc'd).

Yeah, we want to keep "trap on overflow" the default for Rust. We're
slowly making our way there[1] for C in Linux, so I don't want to
regress the Rust code.

> The goal is that Rust code, since the beginning, has all wrapping
> operations marked explicitly as such.

Exactly. We have to not perpetuate the ambiguity of arithmetic
operations. It should be clear from the operator or the type what the
expected bounds are for a calculation.

-Kees

[1] https://lore.kernel.org/lkml/20240205093725.make.582-kees@kernel.org/

-- 
Kees Cook

