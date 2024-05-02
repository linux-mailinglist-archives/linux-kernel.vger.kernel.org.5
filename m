Return-Path: <linux-kernel+bounces-166735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102668B9EB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1FA1F2218D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949C7E578;
	Thu,  2 May 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="BY4/vMhZ"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3364CCC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667818; cv=none; b=p3EYVl/n/oO8Mt1nnTiel1riKBsCKzIvnet/+kmNuHV/HXAijryaYEer8Fv9ByGxeB51M6XwIHIfxcMIfQ34SaUtGqlsQsgAOopP71SPIBOOPAnuyN/irwr8eTwvPqsge+yJshg0vd2EWc1rVIfjnygIaJGnHz0Wf7jN9zqHb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667818; c=relaxed/simple;
	bh=hxh6vLlaBAmJMIpW+o9O8Kuvdm38PoN+9whXOP/foBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJzYIP3Qnpe33dmyU0MBvvu0QCyo0+l8GwrKM835FnaWQLS8tG3ANyk/4ttKO6F3psPCht5pC3FfTnogfChmWmMEBOL/cbI01LDJigBafHrbKquHEVg59TD8lQ2TwToipWiw5K89kCGQ6Kf2RyHx5V6zU/BJWIVrA/0LJbQzPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=BY4/vMhZ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso6050479a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714667815; x=1715272615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hxh6vLlaBAmJMIpW+o9O8Kuvdm38PoN+9whXOP/foBw=;
        b=BY4/vMhZGJIiRmmXSG23/iXW24hrOk99UxO5c7e/tVtqjWHyYNf5XqvtveBlVAxcF9
         iu+VcIdAPE1vDMrYzm2WTZYQ4/RoJFQRnkKPt8Mnhqwg8uvDnljukQW/oFFX0MFrPCcu
         DRR4n2NRZsPxUdLzrw+yfmjmrKhttOuZGYFh2Qwdx6hPlDRyZ6yqK70kFJDjHSCZyNgc
         nUQSQZ/hEt9cFLelDBMPAUqgSsuSjGkgVXgH1lfvP98Uw+huW65wePFxLmvf8Shn/lw8
         633antLanhuWZklyHIq01A8OT61+ybIbGVwZ4kJlv1hJhpg4Xp49pdxLn1jFlgPb/yQ2
         +DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667815; x=1715272615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxh6vLlaBAmJMIpW+o9O8Kuvdm38PoN+9whXOP/foBw=;
        b=oN++IJ4raJYCIbkJ3q/9DQjZTQjW59SLV9LmLkU8qlHVzN8rS0CL8BfPvEacLdu2PT
         C8KM/taKhFVqwVUcZ4QjTqkRA3ykURBRxlKZrleHsfL+bFuahikHcPDWu3FWDOGPmcBa
         ekYYULlpS2G5wNa2fqJ75cSXn9gqwbNi9Qo7CEpspsKp0/q63TK3hqDJBf8TmqnKYOsV
         /6LkfXFHoXizEu2N6Azyee2MXUm2kvrXW/AIdjqHIVdgEXdOZIcZsLp5QlwLum/j0O/u
         mBRNdLRjOpxoG80HxN7J4FDX5UQkgJTCQR/fYDmOOfzuD/5XbzrpBRK0L6144D9toITB
         xQww==
X-Forwarded-Encrypted: i=1; AJvYcCV/32qgRC/fyTELLkJfkNHDIrnK3GcpJnT07nuaaqlAWFi4raTqKS/tx1tcFufGl2r/plcCXVkIWJ2DH+A4A1n7BRKtSlWGTZHNmuWj
X-Gm-Message-State: AOJu0Yz3lbHyL/LdRy1USImvUeXjm9TzOAJFFzRYPbLonXdftdlX/dfO
	mVclr8734H4eLtuM4q70I5kY3Cwfsy/66gSugI/KxxpZeKOIRacG9sHvN9syAxU8k2qV/HjmxLR
	zcvB6Q0/j2KjI08segXayZzDn0R5eiZzdZpwxkA==
X-Google-Smtp-Source: AGHT+IEuOqyeziu79sBDiYNWNKAoD8V7qZLGHIvBnQ/cgZc+zCD0DGKXAqqp2TIOchm67nCvd+puIynmJN1u5g+FTiE=
X-Received: by 2002:a17:90a:ab92:b0:2b3:ed2:1a77 with SMTP id
 n18-20020a17090aab9200b002b30ed21a77mr332035pjq.10.1714667815631; Thu, 02 May
 2024 09:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430210539.935040-1-naresh.solanki@9elements.com> <1fef896c-0624-4a3c-af3b-ecb43782eea7@roeck-us.net>
In-Reply-To: <1fef896c-0624-4a3c-af3b-ecb43782eea7@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 2 May 2024 22:06:44 +0530
Message-ID: <CABqG17jpAGzH-=SQ1rwT6x5kt2m3HKviup_Jj2P7XU4HdeogyA@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon (max6639): Use regmap
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter

On Wed, 1 May 2024 at 05:24, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/30/24 14:05, Naresh Solanki wrote:
> > Add regmap support & remove local caching.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>
> I assume the first post was superseded due to the missing version ?
Yes. Apology I pushed the first post without updating version.
>
> Either case, please provide change logs with your patches.
Yes, I missed this as well. Will do that in v3. v3 will include
fixes you have suggested in v2.

Regards,
Naresh
>
> Thanks,
> Guenter
>

