Return-Path: <linux-kernel+bounces-59489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D6F84F7DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F71281A97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603F6A336;
	Fri,  9 Feb 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CHSMIBD3"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0669DEB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490117; cv=none; b=Y4gekHAQlNrDfrBJBSm5XHDnwVjC7FoO+NIChXBzm0EyUQVHBEEqcN/Y2I9UrapHx3meJ4BD795TCLB5omjeFsKT4q8PU7yveueYBrbeaAxPcvWf7iDoKP2DncWWx0CUiRJn9aGy95sZUVSL+SVvTKbcCkvzQc3CFAWOC/3b0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490117; c=relaxed/simple;
	bh=Rosu0LylrQOocQ0kiqV7FEBAOESJOSa0MbNbA6yyi1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0CQmV/2qvLBCezfSziQNh5E+rbv7FdFz2hIT7bAGd1FOLHbxV+hXq8qLoGE92UuROU2mMoNrMeJj8VUnKk7bq+dUZC4SGr0EOyDhcUb38+zbkURPCtKzKiws8gYl4l5pgyfM+G5Gx+w8beO34xdZRzF32gMFffiJ8ReATiLHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CHSMIBD3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so1306236a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 06:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707490113; x=1708094913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rosu0LylrQOocQ0kiqV7FEBAOESJOSa0MbNbA6yyi1o=;
        b=CHSMIBD3HDwOFRi66CQObjlZIZwP0s6NYt+Cn++EvA0DIE5wy+OasADrOiJokKerF8
         KGJN9Z6i4W78ySH13L84a/oAzo/aouA9DNkp0ZsV0XjQVS5s0QxB3WwQqp2x7ux+31Zu
         /RzIB99y6Qii25cZrOin6si8edbEr64BsjTRxintV3O77ULSmITDTtkcQSzJCIwk0Ad4
         gIIV2iQDdHwrqeycWNY9QGih9I3ZK5MFM9d0kazASzZlN7o5A8AH+bfXpCSO1xCreVOF
         FMy5hJLJqBW9rFdET6CpYQtOJA898um298l25nH13o2GNqvjMjJr2IyI8dNaDNMegdr3
         Kc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490113; x=1708094913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rosu0LylrQOocQ0kiqV7FEBAOESJOSa0MbNbA6yyi1o=;
        b=nlrvj2NwtEY3f+217vTGQcwhn8PQ3LF37GFmIuTsdoRdruxeFgIkLWXVidzQBon5uP
         p3bqcXrRHEzSeJZrLnxrmATvzRrV+P2pwJvATsrE9GrtCwIwy8XklYY1+vOY3orFGF7j
         mH9jp6fPXNYja7Gb0KGGkq+MQ3vknHMWkcaRCIVONIoxlVW/tcjjXJpXWl38QPjTuyb6
         lNlY+yt8AxJA0Mzb/a8Q8AnYTY2ZyTQ6qo+3STBjAhnDdd+w56uKIgGS0tti8X/UU42p
         alKyEWtx56qoi+W/IkgAzOwiPUHOHZBTYq1E1zhmqJRziFZHRG20zGU3/6NXRn3Cx7yj
         S7uA==
X-Gm-Message-State: AOJu0Ywjv0rvdlzr7SuRtWuSznfBHAxSbAvF4SIfDLDRqGisNysfTvjr
	zca/m3wCIENxKF3UQEpS33gOTLYSNSIaRyoB1lEO+dfRKZhkYER8NZ/owhFLHX/L2gY4DPl7Bva
	9
X-Google-Smtp-Source: AGHT+IFdS0ivCDza65+RenmmYkg62TR6Bz5B5uChHDV8fRXSYRTgOhfRNyd/a0Qz1ieRhtnrmrCNyA==
X-Received: by 2002:a17:906:d151:b0:a3b:f798:cfe3 with SMTP id br17-20020a170906d15100b00a3bf798cfe3mr1287354ejb.42.1707490113531;
        Fri, 09 Feb 2024 06:48:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrl6aIDhUyw5BYLlIThEXajbxfIfLb7Hg4Gb39aXhw9aMn9zcHaNxwId9z2LskVqNJeSm6y2ATUrw2T6oZxTnma/C/qatKcor4RZ98iNFNn0ElRGB5JBPlXUIUPmp1XQ+5NDh8FRUMCllRM/I0qCnwrFW8BOV66cB0zSDIgxwqd00efgEyJpsO2IWgnRxfv4gZzms3EUg6dw==
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id jp7-20020a170906f74700b00a37db24ca65sm814040ejb.152.2024.02.09.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 06:48:33 -0800 (PST)
Date: Fri, 9 Feb 2024 15:48:31 +0100
From: Petr Mladek <pmladek@suse.com>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: dianders@chromium.org, akpm@linux-foundation.org, kernelfans@gmail.com,
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 0/2] *** Detect interrupt storm in softlockup ***
Message-ID: <ZcY7P7KLDt90XqYE@alley>
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208125426.70511-1-yaoma@linux.alibaba.com>

On Thu 2024-02-08 20:54:24, Bitao Hu wrote:
> Hi, guys.
> I have implemented a low-overhead method for detecting interrupt
> storm in softlockup. Please review it, all comments are welcome.

I like this work.

I wonder if you might be interested also in reporting problems
when soft IRQs are offloaded to the "ksoftirqd/X" kthreads
for too long.

The kthreads are processes with normal priority. As a result,
offloading soft IRQs to kthreads might cause huge difference
on loaded systems.

I have seen several problems when a flood of softIRQs triggered
offloading them. And it caused several second delays on networking
interfaces.

Best Regards,
Petr

