Return-Path: <linux-kernel+bounces-88196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00D86DE64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3261C283CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE436A8B6;
	Fri,  1 Mar 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bKlkoHyY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9A41AAC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285961; cv=none; b=tTxaN50A1na3O7176gFHuMXfmmhVdqHdDabt0UWRL/1ykOiK1TWfe5W0a3Vzh/Z7GR5yj6Q25Ht+HYHTmdXrhzZl9sOFDoNT+55OPUqUopjYHFLG1A/F3078iKKcabBABhKDnxe6EG5WBXOsGrYXOrjSXKyaQcB8Wl5H0wShD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285961; c=relaxed/simple;
	bh=dwocay/ojmYkzVQJsnfotfx1l2ZC2l+MZCMNpvxNu/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPlDsNsCbDFHVq1d6/MhjKXpqKjmWrSWK9dgvg9GJAyqWTjEGam7spE7zR8p2v1i52DwjwAOqIkUExgfy5Kn4QR+ul4NkOAo5fqZGcccxFLHe/7DBGIs5mEQfmK++GO1pXy4RV1h2V6lDEeN3Pf6OLzhr9cH5QrZHj6MrYZARJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bKlkoHyY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so296353566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709285955; x=1709890755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ksja0aFvPs8vZW6J5BSMyrf5bgaFcujDoUqhbnnmQQ=;
        b=bKlkoHyY+uLJptr/G+kWS44rcnH5aecaR6mWsurhy7z1HqiOj+re0IIoOvCXthT5/U
         iWHUf29AjzOPSmKPvllhnWrk1YL4LIaInYG995AlOlpMU/EON7tYR5Y+VQtp3dAhBTeF
         95OJSm+nIgkWTGbYbLAzvXJsKN2Sw83i5JaQGyKX3vQgO2dxQcwCMSlDCKAVCmPIhMwf
         LquXqY+/b64/YUo31HCGTrpiwQRgsdTyAWfIDEVZ8k2/nT4XxK8NjVBjLYyZWuhyguO/
         CNslqwcT5N+Vv7G1aoMJDJ9nFizfNhHD4TKt/iBT80QJ3jkgpR/7A/A4qOuvIG2BteDP
         J/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285955; x=1709890755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ksja0aFvPs8vZW6J5BSMyrf5bgaFcujDoUqhbnnmQQ=;
        b=Y5AwO/sWvuYnZ7WtGeD5f/q5bWOvR6+Qb2Q8WD9Dp5dpZwyb53NPQpW0PqIkenSyI/
         dMMegQTWoud7hv6ndEKXZePhjYhjdRJ++TGQiFZ5pc6BZOGb5yyTZuB+PCqhXrEcGVu6
         NpZYbEiDPty6FaftWk2NMh+TAiYTJjAwUBDPjdK2APEvoXL/smfA+4IWlHd1SUfgPIY9
         if1bpadokc8HL1bD6arsP2m7sUyyOD9PaJop9BlAtNeQ86F7tlMer46Qedyz08WOmwdQ
         oBxlA2gJbdGDJ3Y1AMc3xheM9N6iUKgcs9B6iFfZTPYqFZFj0ZLweRruRKV8ruTLYRe/
         LtnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSVzEu/8dRPo+Y9XqeVHZC2DNP3zbFaS1jE4cO4e8IGifpovfr8Nw4rVZz+toGQU7sWgqwjHlXZTBrFgHr9fSity9TsU07xbSKGWNi
X-Gm-Message-State: AOJu0Yy/ykSfCHq2FFdIWvKt8+9Zfwq6u9N+RoceU86cA69BQc2grTbk
	fxUNccJN3yRrG8bX910upOzzeMJcgCyvmQ/t1+dHxzaCs8EWJ95McMlSrfjDV+8=
X-Google-Smtp-Source: AGHT+IE9EgSaidvKBKRB5QBeadA8MchJAu1Q5NI+0OHwDCYOn5AsV+MBfYpfDaRkXVRpVXJ5R/DaFg==
X-Received: by 2002:a17:906:e0c:b0:a44:70a6:9421 with SMTP id l12-20020a1709060e0c00b00a4470a69421mr779551eji.36.1709285955180;
        Fri, 01 Mar 2024 01:39:15 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id gt25-20020a170906f21900b00a3ec216ec6csm1516211ejb.45.2024.03.01.01.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:39:14 -0800 (PST)
Date: Fri, 1 Mar 2024 10:39:13 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 20/26] printk: Track nbcon consoles
Message-ID: <ZeGiQUZ0PfzKL4Ay@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-21-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-21-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:20, John Ogness wrote:
> Add a global flag @have_nbcon_console to identify if any nbcon
> consoles are registered. This will be used in follow-up commits
> to preserve legacy behavior when no nbcon consoles are registered.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

