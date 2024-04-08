Return-Path: <linux-kernel+bounces-135878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A589CC86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BAA1F22B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC71DDEB;
	Mon,  8 Apr 2024 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="X1YCDvOu"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638EB1EA73
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605289; cv=none; b=YEhc69mGcaBNfnmHkK2OnmHQ7b+Or/JmUQOlfz8l4Ov1jCVsmPbIcOXeDZwCqp6suz0swcLrZRAakQMGExWMnjFwHpUBeWN+ikQvoB/tjIuiS7dNdxnLZ5QkZtp+CpmMnHYXTTLxOUs/h5JcN5pUTQLA67E9h6I1VE5gMGYkn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605289; c=relaxed/simple;
	bh=S3xOTyU04Fo6JmhxwRhR9/wKIYvQLxQ0GQTLvmmFAII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X945bbQmHo6JrDY6qn0XdrG40OvRy4IhkQJ6dJqUkH9Jthbttbt+1qpUS2U+yWXLO7VPHjz0qVaCvE9K4VhOvu+H+E9L5A6KaaiW7kLroCYKHfOdA73IL1GjjKQFf6TjN7xTWdE/jGF51F9qid+9Qkvm7VqDS1LnQh62Fojm0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=X1YCDvOu; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c396fec63aso1612289b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1712605286; x=1713210086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlG2+sb2I/nukv22GaTz5r2V7S8vwQAqFCnvBWEiOp0=;
        b=X1YCDvOu0+zzsHSJz+nqeVx929R8L2fdzIRXdYhR7zS3Fyd0Aj+8UlhiM+M9MPndmL
         7O8vgYpkPleuxXx4tj2yq2NryLzIz7sDbPvamf51aIR43/2ritKkmK0JPkwmHOgKQ37Q
         1pkq61ZhY6JFR9+DTiLBh4KwY0h/l1T9Z84nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605286; x=1713210086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlG2+sb2I/nukv22GaTz5r2V7S8vwQAqFCnvBWEiOp0=;
        b=T92FwgjymN97yqA9x5WH9AsaL/98nhy+5C7ntR1q0HG7EyiegzkVnBaSvXiPYAxru5
         uE61rQK+gvdA/YUARHmP+46yUarvnepu3zzsSF1E1UVP5bV2ZTWO6GcTXsPW1HkqhgML
         qJjt/huPx/z0FZcH5dloqnE4Di3sclAo5W/WnPt9S8TOrBqGwR9lnqHXduBYRhVI1D2r
         CNqa3gi782bUWoz6uiKU81lcPrKSGZ8EVDbPGbC8WIbLNPq1ZbyGM7YGK2375STSm7nR
         vVPCgWHYvSKncLQ+411QxSDZlq9SfMDZKZ8GZR974p9nV1dl8Whj8UDv70HskTKW+XBr
         JP+A==
X-Forwarded-Encrypted: i=1; AJvYcCXYhmAAV5HSj3zoj4I/QbZopDM7ZNIg9iZ5Eq1M0WGDvNtfZRbUP+fk3G/xEOCsjSoupFglVCLkpW+W/IXkrwk2qo4EldhsbT737MZW
X-Gm-Message-State: AOJu0Ywm3dTbAZAR2Mm3vUp2qnpCvrC1f1xiDPkf099p6qGwh6tBQNd3
	TTsvvzHeU+U4LmDZtWS8OxuwiY6olLMDhHfCAoWjsU3P4hOHp56u5uvCrY/vPA==
X-Google-Smtp-Source: AGHT+IGek7isLuUjx9ixY5A+C0MVHTE+URqlTgRG2I5lQX2fHlVkLgSJN2j/OD4vraUj3CKdt55rjQ==
X-Received: by 2002:a05:6808:1c7:b0:3c5:f77e:6133 with SMTP id x7-20020a05680801c700b003c5f77e6133mr2667584oic.34.1712605286570;
        Mon, 08 Apr 2024 12:41:26 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id k1-20020a544401000000b003c5f66569c9sm357473oiw.46.2024.04.08.12.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 12:41:26 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 8 Apr 2024 14:41:24 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
Message-ID: <ZhRIZDN-cnwQLuwL@fedora64.linuxtx.org>
References: <20240408125309.280181634@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>

On Mon, Apr 08, 2024 at 02:54:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

