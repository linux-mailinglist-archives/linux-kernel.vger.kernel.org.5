Return-Path: <linux-kernel+bounces-72005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D585ADB9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5349628345D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875353E08;
	Mon, 19 Feb 2024 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VO3/rqEa"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA95537E4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378261; cv=none; b=uA/riMTfFAFVDk7nh8Sye8OMxnMOYq7CA7A+PQtSFPyW7uCMI3bBfQPwzciB8I69/28mp3cLCspsF7SgaADNeqz/832YAjoeNk77412PoIZ4vytrWTlWaFiudSviaQNKa7it1Ro3JxtxR4xgdZm+hOZTWBXNH0u8EYIH/XqVXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378261; c=relaxed/simple;
	bh=aoPIAPeIcMZ3O8NtO4F6czhuBJaXTuwiOia7AEB4YqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbBi2VwEftehf16j5IaYOY4jPOBnRjMwuY8qBNp3iMz/xSfdh5kWGV28esRLr6UgCAppeQYi6XMhpEyPHeosCtuGTjWYYQYupevn/bkP3/1WnU0cKPsV8u1d5CGI5SxXVU5KTICh7umXP4cl5nitoIFr7dX/EAcVxcvJUII+I68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VO3/rqEa; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e458a77be3so457146a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708378258; x=1708983058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLvvJpjFswKgVoEBvb+c2q57/k2FJfy6sWagye6yyVc=;
        b=VO3/rqEaNssd4CqzfdZFhtXWUQgM9bor7ZFWJMTNgyAJqmENKo2EYHF8SQYasnFe0w
         ohnxB1gP4qXNkSpGUHemAybnaspPN8pRBy9uipqUQ6rxDbe8kovbMSTtbfCH3EQQbx2L
         g+MDB2YOR8jBmediDxnH8UFZyGzFNuzK72XbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378258; x=1708983058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLvvJpjFswKgVoEBvb+c2q57/k2FJfy6sWagye6yyVc=;
        b=ZereBTZPPiDo7iXMEHIqUakKvU/j0Cu1SyAfAqQsZuQo6R1lvtZd/CA6wMaCfFHD+a
         V4OojHokQgMAw36NGY68pDOdyy6eYly0fqDHhq9/w2RkQuO+TIEJeuFwzYOTN2cpxDfC
         QrFVNQ5BbjlOzb8HoL/qHaXH8i5Qcgzj3fBnCrabXDvWQUFzqqarBbj9rgZigWBuS9WI
         Jwqj5Ry8dt70dBgkk2OqaHjpOoQeDTXC+k3DwTZcTBqOPsHJiXEcvwu3I1AnvMhTDN6H
         8+aUNGuITQyXZWqbMLVh5ZUxUdA+VfyoBH0V3eHtGs34Hwc96KI3yDMxnHPP6QYN22DW
         tSkA==
X-Forwarded-Encrypted: i=1; AJvYcCWFEvZS7HuYo6+fWveYboEqHBlbL4pwmYCKDE9ULtICX7V9WdOZDfCY8itIbttU0QugJaAIp0np0rG0OP174CCiap7sN0OsbdrlTZ/V
X-Gm-Message-State: AOJu0YwRcpv6OwwuAq0qKz3WzKMLtpw9UalbYlAcVNK1qWsa63QO7SiR
	ZhiuUgw4w2bkBH4D4HrRDCI2UJFjoswFJRgtUQhjS3PSMyWLJsOmO5n6UYXFcA==
X-Google-Smtp-Source: AGHT+IENMyYwE8lEUHnaBTUNox2l0l51uXNOHgYriL2vmu8euJMWrvHPGQ3xwxdL1Kwl7EWjX6cntQ==
X-Received: by 2002:a05:6358:d26:b0:17a:c976:c143 with SMTP id v38-20020a0563580d2600b0017ac976c143mr15279982rwj.12.1708378258679;
        Mon, 19 Feb 2024 13:30:58 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e466369645sm2065885pfv.132.2024.02.19.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 13:30:58 -0800 (PST)
Date: Mon, 19 Feb 2024 13:30:57 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: James Bottomley <jejb@linux.ibm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	drew@colorado.edu, Tnx to <Thomas_Roesch@m2.maus.de>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
Message-ID: <202402191328.8E1A325@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-4-lee@kernel.org>
 <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
 <20240208102939.GF689448@google.com>
 <98bdd564c6bf1894717d060f3187c779e969fc5f.camel@linux.ibm.com>
 <20240219152312.GD10170@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219152312.GD10170@google.com>

On Mon, Feb 19, 2024 at 03:23:12PM +0000, Lee Jones wrote:
> Adding this to checkpatch is a good idea.

Yeah, please do. You can look at the "strncpy -> strscpy" check that is
already in there for an example.

> 
> What if we also take Kees's suggestion and hit all of these found in
> SCSI in one patch to keep the churn down to a minimum?

We don't have to focus on SCSI even. At the end of the next -rc1, I can
send a tree-wide patch (from Coccinelle) that'll convert all snprintf()
uses that don't check a return value into scnprintf(). For example,
this seems to do the trick:

@scnprintf depends on !(file in "tools") && !(file in "samples")@
@@

-snprintf
+scnprintf
 (...);


Results in:

 2252 files changed, 4795 insertions(+), 4795 deletions(-)

-Kees

-- 
Kees Cook

