Return-Path: <linux-kernel+bounces-102735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB3D87B6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1AEBB22D46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060DE4439;
	Thu, 14 Mar 2024 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bLFfIq0f"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6B1841
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385529; cv=none; b=CYxquPvdH8eweUIVGdElCmAXM1DME+DczVt0ilYGZRgCeL823021LnwyMEJek0kFQbgn1mqXKhS2GFxX2JcrDnhLUiCQX32Uo8nrrjQ0aYC8X6RmxSwjVZKkXIghmA88ZZK6w6GpbiKkGvJbl3ufbCZ44x9E5EkBZP2b8rZD95I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385529; c=relaxed/simple;
	bh=Qgv5rlbhOAbCe1rCBDzkjDeUSGCQ4ojuwVHIKw8hWok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At6JCBN5nBri++h6IlekN/fWXgMS4QxFwiZfzOCg1EDcnk/6mVEPyhaLAhfX+aDDXh9z86u0nP2sThh0Tr0xvO8XdUHvD590iNoc8HBcEsFbCEBZYoAqGCXMGmI4VJU8uiy0f8WPHjKUbNfGvT8VaVgGxdapfcfevqcJ1+DOMcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bLFfIq0f; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso392196b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710385527; x=1710990327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypOGhMCAN73MtfDxp8ZJp4UKB982TdtlWTiXA9kmja0=;
        b=bLFfIq0fhehHNbqlpBii7bR35f4y+et/1TiizxGBGdH/WPHnyq6ufbxn1I9LhlNGn1
         BRipUW8e2DZUpI3vyQ1a1nQTHCvjJPNgpef+Ai626xq5EOfOkDPe4ItrqXdKCfFK2AcQ
         Ke9j167Nd6GoBSDJvUw5if951o1Q+mWknTzOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710385527; x=1710990327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypOGhMCAN73MtfDxp8ZJp4UKB982TdtlWTiXA9kmja0=;
        b=IS22oIwEIg1CEz6Lbiaec3zKT6UMQjX4Tdu1bzH/n6wMMcqRQ0wey834hhYAdf7cID
         VxKO5o0/reVD5BCVkHJuK+jHOzy+9M+HfS+ID0WIjPAV3EwmOtfTAEUtI0K/DhId6Ff0
         4N1qgJ9QGZ80S4rXA41hyynYxLADPPzF/Ci4AohJ356VAcF1p+neZ7gMdsJ/NejNUGt9
         OClauPYFZIsRGRQZutvsEMo0yfRVdOxFYRLjz5pHnT2PtRmCZgALzGNoCwakNXCroNu5
         Q1qYydUY9uCBArvutY5rWECtF9lBkD4Zg+I0k4UQY2j+aZ0u4A+bDhbB/m5vcPzZFN9l
         81NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGkAfvKcTN1VbaHO3kshhaAEp90Fv0fn1V8AKe6tenrhPFWSIO1FvrHFjOKii5hrxe63HCCLzXXK7Vku6xKezNHh6MJDjrZt9DZJbj
X-Gm-Message-State: AOJu0YzmE/+8K975D+f1qOh5tSv/6PXvTiej/HbaY2Fh6XKHBB3LY07S
	hWLkCnj3RWDOrRxdGWry82Y6YTugq+8IbfLRGHAWUF7bKkuONf2sHv77fX3YZA==
X-Google-Smtp-Source: AGHT+IGXCU1sMUllUHH1QEXTB/y2IlAJwPEYcck4CI5Jy+Va7HiXTygbixu6bf/LssOAXPEcABA+tw==
X-Received: by 2002:a05:6a21:1a3:b0:1a3:3d6c:245b with SMTP id le35-20020a056a2101a300b001a33d6c245bmr977362pzb.38.1710385527265;
        Wed, 13 Mar 2024 20:05:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ee12-20020a17090afc4c00b0029bc2b845c4sm368348pjb.11.2024.03.13.20.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 20:05:26 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:05:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [Test Failure Report] exec: Test failures in execveat
Message-ID: <202403132004.84C9C50A5@keescook>
References: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>
 <202403051256.7A50FE28E7@keescook>
 <fd210d04-cc98-4e29-a051-bdb7e1367494@collabora.com>
 <202403071238.AC7BD90@keescook>
 <cf98ff2f-66a8-4800-855f-5c03c952b514@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf98ff2f-66a8-4800-855f-5c03c952b514@collabora.com>

On Mon, Mar 11, 2024 at 10:08:36PM +0500, Muhammad Usama Anjum wrote:
> On 3/8/24 1:39 AM, Kees Cook wrote:
> > On Thu, Mar 07, 2024 at 02:22:27PM +0500, Muhammad Usama Anjum wrote:
> >> I've tested this patch. Still getting same failures.
> > 
> > Okay, thanks for testing!
> > 
> > What environment are you testing under? It would seem like some unexpected
> > userspace conditions exist that the test isn't prepared for. (I was able
> > to reproduce one error with /bin/dash, for example, but not the others,
> > so something must be different in the set up.)
> I'm testing on Debian Bookworm with v6.1, v6.7 and next-20240304 kernels.
> I've tested it on another VM which is also Debian Bookworm. The default
> shell is dash on Debian as well.

Do you know which kernel version this _passes_ on? I haven't been able
to find when this actually returned the expected values...

-- 
Kees Cook

