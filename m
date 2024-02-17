Return-Path: <linux-kernel+bounces-69519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2D858A74
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28884B28759
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADCD534;
	Sat, 17 Feb 2024 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LM4JPYap"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9C9440
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128085; cv=none; b=p+IKEjWUsrUpxli88Gt3Fg0qcGwjN/6PI43nLn42/AvpomG26PXm4XbfQXZZqtFRLpqv0YO0MJxxJ2f1aHZHGX/i71NU1mIDnGghxpcaanHLMfkVmfkx9IQZLz8GJBCXQKVEcjJvPX2PXa8oNanlIHmHE/yV7FPJmjy6il54vPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128085; c=relaxed/simple;
	bh=twJMaz5hQjLxWg2D2ZOlTmtBY3tmgwGEsmcoi1okmMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o77JEPbpIvKdCempAKfu8GBA+hdpGJXxsVZBg+fc+KdyWXl2gu+s/NCpUIQ7Vz5YOx6snuVTD01AuPWqgUz3kbp9efw9388SnNftA/1Qw6Oo54FhBPggYEcF8EJHEob8fmqXfwGkNyHBqfofsIvjRtC82dbUwIvG8uXClQ3RfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LM4JPYap; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7881b1843so23208915ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708128082; x=1708732882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rcCKG3D7AvePSxZeCEt+RshRF5ENt/rXD6pLatkDrQk=;
        b=LM4JPYap5xEEAOR9XDel1FAmTlNGnZShmaFs1bN2ehNMF0bD4X9662RPDljC4eYh4Z
         xtFMhgF3uCmt/7fBPRgCx1tyo/pcwcS2SM7RwQsCzwMBdRK9wlewow07mlZjOZvqZE/9
         +pjQw+lrEPHGCTzY3sFx//uiFCfBgGwscuyZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708128082; x=1708732882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcCKG3D7AvePSxZeCEt+RshRF5ENt/rXD6pLatkDrQk=;
        b=HIgxJQ38vSXR2SGRNdc8XTXMOSnvvt7tR0u6OXvlOHbKJ7jK/r6DzeiwYVPhe1xcrR
         G856tbaI3SiEp78sVuiGf7d9RI0RzEzXZseeuWdb0hnXtKJAC77eGxvcMKbsTyiWcznA
         3Dgwmfziu1DJfh0nHHR7fWd7EqUsUu+lUAPf51uHJSJove2uD51v9oQBacD7jcripYOF
         s9s4dkcQaxfvB7cMKZa26FZXDVaaYpvATuXalpd2aQNghlGi7tbnlpNsTxHrO3Y6N2Cc
         RCrTOf+QAjdFueZ0K4bgchz0D0l8mgcy49MjSo24IdaVmn/aQbxqKxyqXJYpRJCp81N+
         JJfg==
X-Forwarded-Encrypted: i=1; AJvYcCVULatRPvImQJi+6USs4AzFnsmzpqo8hj+agPcx3ITrgP5Kpsw2yQBNf/cAC3h+sVWuI4UGWlmjpiLCDPSIs0FvyrXfuFWo0KhWzIpm
X-Gm-Message-State: AOJu0Yw7rIIbl0uHR19CZB9g2DGoWXFxNfIUpEc7lOp2R+MaFdhtv78P
	Obtc0qYMn0F6m/MQPZxjIiMPc5pbajJqSFNSuluWeak2L8H045DH3Ydkad/2NlK8P8YUJrgtpoM
	=
X-Google-Smtp-Source: AGHT+IHZC4htSp/S1o8/xuNw5MoOCc264ogO2hnLmdjTYKiML02zOzt6m83Am38ZfpxtzNSuqYdmUw==
X-Received: by 2002:a17:903:22c4:b0:1db:82fc:8b55 with SMTP id y4-20020a17090322c400b001db82fc8b55mr8278333plg.56.1708128081792;
        Fri, 16 Feb 2024 16:01:21 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u12-20020a170903308c00b001da11733477sm408091plc.75.2024.02.16.16.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:01:21 -0800 (PST)
Date: Fri, 16 Feb 2024 16:01:20 -0800
From: Kees Cook <keescook@chromium.org>
To: SeongJae Park <sj@kernel.org>
Cc: shuah@kernel.org, "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Vijaikumar_Kanagarajan@mentor.com,
	brauner@kernel.org, jlayton@kernel.org, jack@suse.cz
Subject: Re: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Message-ID: <202402161600.BF1D110BB@keescook>
References: <20240209174243.74220-1-sj@kernel.org>
 <20240215011309.73168-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215011309.73168-1-sj@kernel.org>

On Wed, Feb 14, 2024 at 05:13:09PM -0800, SeongJae Park wrote:
> A gentle reminder.
> 
> 
> Thanks,
> SJ
> 
> On Fri, 9 Feb 2024 09:42:43 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Fri, 9 Feb 2024 10:30:38 +0000 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:
> > 
> > > On 08/02/2024 21:29, SeongJae Park wrote:
> > > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > > 
> > > > 
> > > > 
> > > > While mq_perf_tests runs with the default kselftest timeout limit, which
> > > > is 45 seconds, the test takes about 60 seconds to complete on i3.metal
> > > > AWS instances.  Hence, the test always times out.  Increase the timeout
> > > > to 100 seconds.
> > > > 
> > > > Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> > > > Cc: <stable@vger.kernel.org> # 5.4.x
> > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > ---
> > > >   tools/testing/selftests/mqueue/setting | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >   create mode 100644 tools/testing/selftests/mqueue/setting
> > > > 
> > > > diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
> > > > new file mode 100644
> > > > index 000000000000..54dc12287839
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/mqueue/setting
> > > > @@ -0,0 +1 @@
> > > > +timeout=100
> > > > --
> > > > 2.39.2
> > > > 
> > > >
> > > 
> > > Added Vijai Kumar to CC
> > > 
> > > This looks similar to [PATCH] kselftest: mqueue: increase timeout 
> > > https://lore.kernel.org/lkml/20220622085911.2292509-1-Vijaikumar_Kanagarajan@mentor.com/T/#r12820aede6bba015b70ae33323e29ae27d5b69c7 
> > > which was increasing the timeout to 180 however it's not clear why this 
> > > hasn't been merged yet.

Should it be 100 or 180? Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

