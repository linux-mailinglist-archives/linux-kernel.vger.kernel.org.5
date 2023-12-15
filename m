Return-Path: <linux-kernel+bounces-300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F270C813EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD484283EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA357FC;
	Fri, 15 Dec 2023 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EeohEGj+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE24C8D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso155353a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 17:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702602098; x=1703206898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvr2Ur0H3dtPqApD/6gE9jtcOvzoERwrapX5poAQqaI=;
        b=EeohEGj+944dr4O1GMAii4oeeRcmUQHTT4em5So9vMXhfGenfJfu3HvDDV4OeAW0km
         zmTe+kWAu6gun4XmeFwg6O+HVHQHk1ANEL3rdv5encFZ5Vz9J4gX/Ij8KYIbRhpDNoNo
         8U3LVfSg26fhgsZ9mtCOvqr1DOzDY7GWezl5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702602098; x=1703206898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvr2Ur0H3dtPqApD/6gE9jtcOvzoERwrapX5poAQqaI=;
        b=b8lJDLQBq9SjP1QhZZB7ndqo86THDsFx3VufuRtcXWatMdicZPQZrh3Kf8EAruoocB
         T9rHGYSuNIMIWH9qpeWtvkIGlWsXD9aexq6T2x34HDmd6cCTYGIMDoR+/lUUN/GkMjVT
         vNNFVdF/R8++nom0NeLIMDhJdV+1PE+vPRSkfq4FENX126kkrDf8AbDfjwhRBNW4AzfA
         tZHjZ4JuP+hzuC2F6FpgwLy9+9cyl+7+mnDfJGlWW9EQYXH3zolTptDNKDUsOSsDT8PL
         +zXgs2etxBQ0W5psPGcpZ+muYs1GmSA4iP9Nrk5gP0ys/3WtGc4+xDFjnCH3VUjtgDOU
         35tg==
X-Gm-Message-State: AOJu0YzaZww2Mb8Uds4g2ViLb/vQ5PGwc+jqt3p+6hrkApTCVUEYgGW3
	a4t6+ceKA31lcn7X7jQ3h3Dk8A==
X-Google-Smtp-Source: AGHT+IGPtVL8rYlBWund2Lz0I8x1zZQs9kji60WlH+CCspE9KSHZwJ45Nu85BYXTCizpJr/Irv6Z4g==
X-Received: by 2002:a05:6a20:8f15:b0:18f:b899:21dd with SMTP id b21-20020a056a208f1500b0018fb89921ddmr14531192pzk.47.1702602098050;
        Thu, 14 Dec 2023 17:01:38 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b0068fe9c7b199sm12351686pfb.105.2023.12.14.17.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 17:01:37 -0800 (PST)
Date: Thu, 14 Dec 2023 17:01:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: Report excess struct member
 descriptions
Message-ID: <202312141700.E0BC0FD19@keescook>
References: <20231215001451.work.746-kees@kernel.org>
 <16d1510c-fa3e-4fa9-ba4d-c483a22f83a4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d1510c-fa3e-4fa9-ba4d-c483a22f83a4@infradead.org>

On Thu, Dec 14, 2023 at 04:21:17PM -0800, Randy Dunlap wrote:
> Hi Kees,
> 
> On 12/14/23 16:14, Kees Cook wrote:
> > While missing descriptions were already be reported, missing struct
> > members were not. For example, previously this output was empty, but now
> > produces:
> > 
> > $ ./scripts/kernel-doc -none ./drivers/leds/leds-mlxreg.c
> > ./drivers/leds/leds-mlxreg.c:42: warning: Excess struct member 'led_data' description in 'mlxreg_led_data'
> 
> I just made a patch with similar functionality last night:
> 
> https://lore.kernel.org/linux-doc/20231214070200.24405-1-rdunlap@infradead.org/

Ah-ha! So you're as confused as me about where the robot was getting
warnings from! Your patch is better.

-Kees

-- 
Kees Cook

