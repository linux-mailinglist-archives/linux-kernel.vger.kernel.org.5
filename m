Return-Path: <linux-kernel+bounces-82970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3834868C64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845EE1F21B08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4C136990;
	Tue, 27 Feb 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="etPMcNZ6"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A48135A75
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026696; cv=none; b=HtQZ4IeHK1KyBZHJTfBM6qWE/IsYWe1ufobXV8ose14hPTxbxHtt1vYJ5XxYQlyCybNVxFO0H/xTB8p3HhXbh8FeWaWWu7544QOs5stdDvB44bsDdOANSFR6+ByDJDef9tNsMWy2qVWaMHk49+qp9Mlbb52aQD+m2rEziNcaCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026696; c=relaxed/simple;
	bh=AxKvYrQWY9/F5dWJHbr0zeRC2wATwh2Xzpa4vVOSC4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL/Wnt6xQTiWFLICIylnJj0PG1zAsV7j+jISOGVFZakbAfw14S5HUoGuGPvP7J7koUB7MRSu5oWYyQ0Fqtjz4w6r6eAyT6+VvUNeDGid9yjVCijI7w11y/4fQdTgE3vXZWxRSxK4G7Ow2GRBqK9lHoH0ym8EupV9ODrL5aroIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=etPMcNZ6; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d269dc3575so37021621fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1709026693; x=1709631493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34nlE/jYLVlVaZ7lND+aFhIBs6PO2OjuB13sd0/fnLU=;
        b=etPMcNZ60xMu5HUAkGh8wzD5Vc5kjz0ObDGHlTTFZhpM666lh2t3u2aPnzehCWIn0g
         eSogmq9RxX8dbewKkhA8RDDgUeE/fQt+kOnvbYlIbZPqODz6frM16ugpkpyz+g9h+WeE
         XK1QBhMChA9hLYaidr8J3+HpAsKjaXNHLweRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709026693; x=1709631493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34nlE/jYLVlVaZ7lND+aFhIBs6PO2OjuB13sd0/fnLU=;
        b=OZ7VVldUabP8rX1+xI/v/JZbBqlVSuvnymm1P5XInyDLf8sBBrZLYAaty1H8UZd02N
         3PLeewdpjeNFNLabKlTE5lvmSo22paeA1iVwDRg08d/1TWQTGT+l0PwREDPa3mdYncHg
         MIGr7WNceFvdjJ7EmQtvGogOpXw+b7a37FbteE4/d+MGXdxlVXMdISJ0jN93t2zREFXi
         +YbyMIDOwkjwT9SQGUA9+7dHQsCcwYSoIUGbr+PzVpxhPgBhFLu4dC8j0ndxlWEKGWsG
         O0dvHs9eODIAkIdaYEQ/8H11ZIpWzWOL9dj1un9UdRniaLRK3wyAJc9rTfr9PnycOD3d
         32pg==
X-Forwarded-Encrypted: i=1; AJvYcCURJKUp4QWfI+smdDQNxsVbWL7qDjrggEwFuvMb8MH9Hbixiue8CzWy2PIXxTrbeaWQfpomEVFqLys+orP7S+HIUGojKmDn+V0ORsEl
X-Gm-Message-State: AOJu0YyGMeHmWUbiH5QaqVQUOkzISqLqWxZC8iegFL/jzJU60GWuBvZk
	ihw1ZVVmoGoIs33GWdDt4Yp6ntDeLXLNtSVuJQDYSrv7jo1zQTli7/hYMzoc9vw=
X-Google-Smtp-Source: AGHT+IFIS3pGCJaWAL8RMc5RJT5ivWEGBl+2mS/Sffs1nscQknt84kpwUa3IyS43C3isau2OTSqjwA==
X-Received: by 2002:a2e:a165:0:b0:2d2:3fa3:5af8 with SMTP id u5-20020a2ea165000000b002d23fa35af8mr2877025ljl.3.1709026692679;
        Tue, 27 Feb 2024 01:38:12 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p18-20020a2e7412000000b002d0f8b3e259sm1128939ljc.65.2024.02.27.01.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:38:12 -0800 (PST)
Message-ID: <1013ff2d-76b2-41f9-a5d4-39a567a3b0cc@rasmusvillemoes.dk>
Date: Tue, 27 Feb 2024 10:38:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/i915: Indicate which pipe failed the fastset
 check overall
Content-Language: en-US, da
To: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
References: <20240215164055.30585-1-ville.syrjala@linux.intel.com>
 <20240215164055.30585-2-ville.syrjala@linux.intel.com>
 <ZdfApN1h97GTfL1t@intel.com> <Zdj2ONs8BZ6959Xb@intel.com>
 <87bk83mfwp.fsf@intel.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <87bk83mfwp.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2024 15.57, Jani Nikula wrote:

> Personally I suck at remembering even the standard printf conversion
> specifiers, let alone all the kernel extensions. I basically have to
> look them up every time. I'd really love some %{name} format for named
> pointer things. And indeed preferrably without the %p. Just %{name}.

Sorry to spoil the fun, but that's a non-starter.

foo.c: In function ‘foo’:
foo.c:5:24: warning: unknown conversion type character ‘{’ in format
[-Wformat=]
    5 |         printf("Hello %{function} World\n", &foo);
      |                        ^

You can't start accepting stuff that -Wformat will warn about. We're not
going to start building with Wno-format.

> And then we could discuss adding support for drm specific things. I
> guess one downside is that the functions to do this would have to be in
> vsprintf.c instead of drm. Unless we add some code in drm for this
> that's always built-in.

If people can be trusted to write callbacks with the proper semantics
for snprintf [1], we could do a generic

typedef char * (*printf_callback)(char *buf, char *end, void *ctx);

struct printf_ext {
  printf_callback cb;
  void *ctx;
};

#define PRINTF_EXT(callback, context) &(struct printf_ext){ .cb =
callback, .ctx = context }

// in drm-land

char* my_drm_gizmo_formatter(char *buf, char *end, void *ctx)
{
  struct drm_gizmo *dg = ctx;
  ....
  return buf;
}
#define pX_gizmo(dg) PRINTF_EXT(my_drm_gizmo_formatter, dg)

   printk("error: gizmo %pX in wrong state!\n", pX_gizmo(dg));

Then vsprintf.c doesn't need to know anything about any particular
subsystem. And if a subsystem breaks snprintf semantics, they get to
keep the pieces. With a little more macro magic, one might even be able
to throw in some type safety checks.

Rasmus

[1] You can't sleep, you can't allocate memory, you probably can't even
take any raw spinlocks, you must attempt to do the full formatting so
you can tell how much room would be needed, but you must of course not
write anything beyond end. Calling vsnprintf() to format various integer
members is probably ok, but recursively using %pX to print full
subobjects is likely a bad idea.

