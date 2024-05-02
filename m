Return-Path: <linux-kernel+bounces-166617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F118B9D19
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B356B249DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988DF15AADA;
	Thu,  2 May 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EYtytLqM"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6831159583
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662856; cv=none; b=U25Pg8OP80k1HYsL6cEVBN7Owi2EEChVmVMfBSbqTA7EQc4dPly3wBbUBxGEKFraP/iNzSL1i2tqoVLyN32fckpkpMAEQ5NEkXn+0BbgSSYnp/iyURdcQImRYtQn+QMPYcCoh4ary6VWcv8XsNGVBGzMLhbMALQxnXh9K8U/uyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662856; c=relaxed/simple;
	bh=VDm/f33gMRZJn1IEH8M+iEGbrAW/USVPxcL7qJhNNmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQvyOheEmTYQcKNXdqOjHz0CjXgLfQT0s17FDCQu0QDK2ymqEbHSR3cJtTk2LZSRmhHBBwzGHwxRUWfB9UuUzuTCFdsOQ29fde4zgOf/TDjts4zlOQdTTD7A2RLvoD+5z2Q6RycGBI+75LRYPyh6QcGzeLjbsuWo5itDBEojabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EYtytLqM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so62239025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714662853; x=1715267653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cbY/VcBLbuHrSNodrdRFjHRQXR5diN61KT/KCDRPbos=;
        b=EYtytLqMVZ76YsJjd0Vx7l2qi2ja/HdQ6nR2lFOW5doo++NiLxvXvIPqcIK1cJACs6
         THV2zuxjlG+z3JXCw2hE6oYKk+7Gc2nKiwAJMlZHnlZ3rndtiyk+aZjR/MdDf6ajIsXy
         UaysEipjVj73PznDKS6d46yOnUcUxT5fxjObkPTogyCtG72wTmXptUUJUjwWU/dEOuZ2
         JOfR5qBGTEb1KnVK1QtDj170tzoma5NZ66hm96/BoBhYLC0mdWj+rOrVRBf80SVM2g/Y
         Cb5nQsw71X1yDFpYTYbee2XEWYC7HP3zAE5DHhL+lv6vWWA5uBzeIRRR3L7+M8zXyCFe
         ++VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714662853; x=1715267653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbY/VcBLbuHrSNodrdRFjHRQXR5diN61KT/KCDRPbos=;
        b=gk32lLr6+r9yvgBxFKeLh+88z5vktXqGwFzUOKvxBytI14WZ6A+hBuKMVxxXWtoD5d
         HxGlLsEBQacV/ujWFbWag/SJZseTdZC6xXl9NRBdPape5QB1ApbvAvGiW223xRddsx/N
         DHTRQTPc9LPOcHvrj85I/AU81HDhc+5w3G7OvCjj8DigG3Rfbw/UehSU4pMaqER23P6S
         +A3HPGSRm5BNYV2IqzsGg7U9UlQGgsKC5jARyCkGIbu7hEoK71fUTpnG6daaR1d4pmO3
         7cvPHz4WaKBO6yojfJfXdukyVTBiKaRSCvMct/2n5ZSzkdeEs5i33A9ISTyHlVww8b65
         G4yg==
X-Forwarded-Encrypted: i=1; AJvYcCUA0FakDWNIDjHUB9+slf4by//cZGMghlEcq/2kkC6mpIETd1VNJCPD/d0pCtiXdCxN74NZgA8Km+1DseF1PgZRfHR7WPjUQwnL1R2c
X-Gm-Message-State: AOJu0YyTq3oNhm9Gk1eYdxhsKOWdQb3Jrs4aBL4dD6EWtIeWa4j+YBo2
	FbW2A0+8OuEnCIzj0YWLHWclJ19SR2fIm+xEc9Ls4MaivFENWBJtdCyG6yrlYmSbfBytvkDrWtk
	n
X-Google-Smtp-Source: AGHT+IFlsoRLNMn3LkTjImslFRW1koUYMMOKLDCsUquNVjPgESRcsDbCgtsLIfRPeZxiBfMILNOLUA==
X-Received: by 2002:a05:600c:450e:b0:41b:edf4:4071 with SMTP id t14-20020a05600c450e00b0041bedf44071mr23404wmo.35.1714662853248;
        Thu, 02 May 2024 08:14:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0041bd85cd3f2sm2256509wmp.19.2024.05.02.08.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:14:13 -0700 (PDT)
Date: Thu, 2 May 2024 17:14:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Justin Stitt <justinstitt@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
Message-ID: <ZjOtw-ov-GXxG-dv@pathway.suse.cz>
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
 <7cdc63b3-31cc-442c-8c2e-75adb2c76b52@wanadoo.fr>
 <CAFhGd8rO=-DYvXi0YHvQqnhTteV+Hgeuou0X3USx61oTobj0kw@mail.gmail.com>
 <289aa316-5067-446e-96d8-7b318fa367a9@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <289aa316-5067-446e-96d8-7b318fa367a9@wanadoo.fr>

On Thu 2024-05-02 07:06:21, Christophe JAILLET wrote:
> Le 02/05/2024 à 01:18, Justin Stitt a écrit :
> > On Wed, May 1, 2024 at 2:39 PM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> > > Hi,
> > > 
> > > Nit: The { } around each branch can now also be removed.
> > 
> > There was one line before and there's one line now.
> 
> In the block after the "else", yes, but now the block after the "if" is only
> 1 line. (it was 2 before).
> 
> So, {} should now be omitted on both branches.
> 
> -    if (str[0] >= '0' && str[0] <= '9') {
> -        strcpy(buf, "ttyS");
> -        strncpy(buf + 4, str, sizeof(buf) - 5);
> +    if (isdigit(str[0])) {
> +        scnprintf(buf, sizeof(buf), "ttyS%s", str);
>       } else {
> -        strncpy(buf, str, sizeof(buf) - 1);
> +        strscpy(buf, str);
>       }
> 
> This is a really minor nitpick. Not sure you need to repost if there is no
> other comment.

I could remove the brackets when pushing the patch. But feel free to
send v2.

I am going to push it the following week if nobody complains.

Best Regards,
Petr

