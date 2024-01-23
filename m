Return-Path: <linux-kernel+bounces-36079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA56C839B35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C418282F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5FC3B790;
	Tue, 23 Jan 2024 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ad60CBuj"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2052C682
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045474; cv=none; b=WEIGmARkw1EDE+kw4vBSrWpudEsFFBv2aItUaLmoGnoksWPcKhnOtH9q9ygFIAvIqU51Yzy3GtsnOX53CUPHN/TZPD1TIRkOY4xMWqzmD2gLxX5dYJ6TAajIzzurQ9QBMYMyR+CsdldHtqR7awIRJKTWNWsaU+qVJPm2J1WMtcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045474; c=relaxed/simple;
	bh=jP2/IW9UNkEjSgAKZeY0ax+X34XlCZzhZYmXu4icG+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt5u7gyag6PhZ4Q1trldtWqLo2iFa2ZV79Rf8flpGWtg0Xz9YmeZ4xSV8qY6d1HBzPwSeWeXCKBOtnS7ol+HZzy3jkEYS4XS2LnGFoVJ44/WJkTYQpQJrGELoW5KcAso7QvHCMobBhhFCr4LsKCKdCcY95h8hjS9Li3UBqUt3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ad60CBuj; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2681789a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706045472; x=1706650272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLSrHTqApY0rnoNDPNmTbGyM4UlT798vTtkhFOVuGO8=;
        b=Ad60CBujlqu06M2IFBbPXvjYD8g/BEXRejYj+DNvOwe8wY8n5vBoew7hrTl/u+VcTX
         Mw1Suq5x7dhwT8+Kg1UpTRVofpgjJnrHYr6gl+HBY//ZZHbqrNqMWfVbigTZJZHXagmU
         rnCo70Rr5QxK6vUJfK1EJi4krFDpBRl+2UwKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045472; x=1706650272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLSrHTqApY0rnoNDPNmTbGyM4UlT798vTtkhFOVuGO8=;
        b=ediMbpM2NQ7+7gRMfWODEs8BfsP/N+sOCpZTyuOUyYQrbDP82BKMgkkdiR4cTorvwi
         uPM2LsNQDDsCiZds7WSSK6GcvBXZkw3VydQrOKxQWs/fOPygf2VoSZktlBBq2GrHv7yO
         CY84TWrvhgfgWrGhAyo55IOf5AIgg+ZIr8lGH+Iy6Ci0Up3Yv3UhQOAxw9niYrloG5hS
         az4ugW7rRaSOHU6aGcxnWL7IcF3HxDUFDnTYTP7A4MdUCWAuNjOx7aLyq/4ucr1xkFRQ
         yVxzwo3ybegJZj4DybqMDnnusMojClGxKvCIcPQWaBcXPuTAphjwJMvCR8j/48SqnWAe
         imng==
X-Gm-Message-State: AOJu0YwYCN+Hi5s7V9/JgwdQyWX/hPyn9qKGi/GkCmUMYscIMB4RXeNL
	oK5fwQaoLluyQPIDx11YjGIqoqyV7AQUelCVFc2ig+IVyDgfYsTvhI3EnNCBqDtg4J1GEvj6Mam
	5RQ==
X-Google-Smtp-Source: AGHT+IFZZEebKX2R0JqbRWEEh9em7MQ0hN72r+XKI76xsV+huWAf7uMifAtdFdhTI+U9kp5jq78zPg==
X-Received: by 2002:a05:6a20:28a1:b0:19a:3a7f:63cd with SMTP id q33-20020a056a2028a100b0019a3a7f63cdmr3098127pzf.49.1706045472672;
        Tue, 23 Jan 2024 13:31:12 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kr8-20020a056a004b4800b006da73b90fe4sm12541675pfb.14.2024.01.23.13.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:31:12 -0800 (PST)
Date: Tue, 23 Jan 2024 13:31:11 -0800
From: Kees Cook <keescook@chromium.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-hardening@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, John Garry <john.garry@huawei.com>,
	Fangrui Song <maskray@google.com>, linux-perf-users@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 69/82] perf tools: Refactor intentional wrap-around test
Message-ID: <202401231330.C55D17922@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-69-keescook@chromium.org>
 <dc3a7101-964b-46c5-a78b-374b68cd54fb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3a7101-964b-46c5-a78b-374b68cd54fb@intel.com>

On Tue, Jan 23, 2024 at 08:21:41AM +0200, Adrian Hunter wrote:
> perf tools has separate includes to the kernel, so does not
> seem to include add_would_overflow() in any of its include
> files at this point.  Need to update
> tools/include/linux/overflow.h first.

Oops, thank you! I will adjust this.

-- 
Kees Cook

