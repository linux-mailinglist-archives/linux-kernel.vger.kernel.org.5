Return-Path: <linux-kernel+bounces-30610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2808321B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C831C22F56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1801DFE6;
	Thu, 18 Jan 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FYEwT1/P"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4C28E0E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617799; cv=none; b=Blt7rNAlwpxEAlj4NYJc9rZpF8ND1jY/Gf0CUiobtLMJRy0+CbSFeVunGGXgBwd+unJfGLhgTOYusBGHiCHXknHZNCgZbYB05hAaWTa6PoRKYyB47JqniAgy3XB+NEVJpOBy1xb/A3xT93usPMyffPITTW2cZeh07jvlXJhNkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617799; c=relaxed/simple;
	bh=J9aE5jTKKrtOuYayvEM5BBFWlQaO0nXtr4EU9h/xXdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNoXKwlgJWqwYoYYTYEaLIglCd5VHyLkRHWK+b/VykhxCgkVzJOG7WuDJ0RTUOTEHpJgWtUEH9feQ3XH4oYlsPcic5hkNLgEvNmsI/B3qAvyv531Ntdu2NbsAMob1LzZgESf8dqRYaNbv3mE7bWASFV8mkstEmmj8CY62r/zLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FYEwT1/P; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29041136f73so185330a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705617797; x=1706222597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=81gxzXiItIaFn+Kjz4pG4NqE8kQuJBsHXKvoJtvOUUo=;
        b=FYEwT1/PjOWHgezUilVA2AAvP7Kafsv4BVfPbFcCE7eIqc9c3vrSJZB854JAuVfaN7
         ybGMquVOxn0fSNGv+m6Kgs8Kp8ag/mDdSdvFmv0wmXjz3+glsFqqMPF3lj1iI6dNa6An
         wXhN0QM3DOgBwE+zx4amJvwX21eKTkJ9t0QOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705617797; x=1706222597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81gxzXiItIaFn+Kjz4pG4NqE8kQuJBsHXKvoJtvOUUo=;
        b=Qh0ynP1G2KGcYjJh+7AkB7/44IwmdSuYgGH41qbOVifK3cQ5mPL/mEh5uchPheSKh/
         UKjK94VAetgShOOvjJeRRvsOwRwwC8/sVTx/iY8qHQjUfHQyR6k3MjX+asKGn0yPUr6M
         NsCm1Rx/u4aNs85LN8NEZsC9/6SZB416CPW/wP/7rNZkcaKKebBB6rrX+tRXiVC9/UMj
         RnjPqAPygn4Itj+x0ZoV9EroKJIKwd0/t6sm3RWE3a/EZBZWB3amUMq7k8nxjkPbrV55
         by5Z9ArCwwSKFvyGvVuuTp+y+lfv8JH3NpzZXWZ/kCnuPuxMYIjTNSndjvDJpGmMKPH7
         R23Q==
X-Gm-Message-State: AOJu0YwzyARiPlqKx9JjPVv3OzWB/GDPggo/+j5ig3nHJCj7lfyqkxYl
	vewwlIkMz2zTQPj2xOErOJtI/8Sz+k2JDBqtiaJ45qM5El537Rbbp2q4E1F/Qw==
X-Google-Smtp-Source: AGHT+IGAUQJ1LMgMyyhyHlnCR7y0uU2UWUkqbGDD3j6+b8REeI+vgs+4m6oIF6cqkXVuwb9cAU626g==
X-Received: by 2002:a17:90a:1344:b0:290:2c1:4a13 with SMTP id y4-20020a17090a134400b0029002c14a13mr1335144pjf.39.1705617797421;
        Thu, 18 Jan 2024 14:43:17 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pa5-20020a17090b264500b0028e193e1edcsm2412525pjb.25.2024.01.18.14.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 14:43:17 -0800 (PST)
Date: Thu, 18 Jan 2024 14:43:16 -0800
From: Kees Cook <keescook@chromium.org>
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>,
	Michael Cyr <mikecyr@linux.ibm.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ibmvscsi_tgt: replace deprecated strncpy with
 strscpy
Message-ID: <202401181442.ABC133B203@keescook>
References: <20231212-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v2-1-bdb9a7cd96c8@google.com>
 <202312121321.E15E09BF@keescook>
 <9f246fbc-b2e4-4585-912d-a5a00ac8cd04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f246fbc-b2e4-4585-912d-a5a00ac8cd04@gmail.com>

On Thu, Jan 18, 2024 at 12:21:04PM -0800, Tyrel Datwyler wrote:
> On 12/12/23 13:23, Kees Cook wrote:
> > On Tue, Dec 12, 2023 at 01:20:20AM +0000, Justin Stitt wrote:
> >> strncpy() is deprecated for use on NUL-terminated destination strings
> >> [1] and as such we should prefer more robust and less ambiguous string
> >> interfaces.
> >>
> >> We don't need the NUL-padding behavior that strncpy() provides as vscsi
> >> is NUL-allocated in ibmvscsis_probe() which proceeds to call
> >> ibmvscsis_adapter_info():
> >> |       vscsi = kzalloc(sizeof(*vscsi), GFP_KERNEL);
> >>
> >> ibmvscsis_probe() -> ibmvscsis_handle_crq() -> ibmvscsis_parse_command()
> >> -> ibmvscsis_mad() -> ibmvscsis_process_mad() -> ibmvscsis_adapter_info()
> >>
> >> Following the same idea, `partition_name` is defiend as:
> >> |       static char partition_name[PARTITION_NAMELEN] = "UNKNOWN";
> >> ... which is NUL-padded already, meaning strscpy() is the best option.
> >>
> >> Considering the above, a suitable replacement is `strscpy` [2] due to
> >> the fact that it guarantees NUL-termination on the destination buffer
> >> without unnecessarily NUL-padding.
> >>
> >> However, for cap->name and info let's use strscpy_pad as they are
> >> allocated via dma_alloc_coherent():
> >> |       cap = dma_alloc_coherent(&vscsi->dma_dev->dev, olen, &token,
> >> |                                GFP_ATOMIC);
> >> &
> >> |       info = dma_alloc_coherent(&vscsi->dma_dev->dev, sizeof(*info), &token,
> >> |                                 GFP_ATOMIC);
> >>
> >> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> >> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> >> Link: https://github.com/KSPP/linux/issues/90
> >> Cc: linux-hardening@vger.kernel.org
> >> Signed-off-by: Justin Stitt <justinstitt@google.com>
> > 
> > This looks good to me. The only question that I haven't seen an answer
> > to from the maintainers is whether this is a __nonstring or not. It
> > really looks like it should be a C String, so with that assumption:
> 
> To reaffirm the assumption, as I mentioned in my response to v1 these are
> intended to be handled as C strings.

Great; thanks! Are you taking this, or should I carry it in the
hardening tree?

-Kees

> 
> Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> 
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > -Kees
> > 
> 

-- 
Kees Cook

