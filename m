Return-Path: <linux-kernel+bounces-141012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C48A1A17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21771F2198A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6423FE52;
	Thu, 11 Apr 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="LH8sSnq3"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4581C4C5A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849901; cv=none; b=We5pDLN9Sh8CJotP1GqZ7+HOdM9jM86NbIv1gJPCl8weg0lW7f8wCVkPr3UW13AvTJoJ/o8Zes0U98jtmUbE5cym8ITawLRDt2z7ZCKM6lnlSEpQKvP89ftCz1hn7i9nBEjYIQWyTmcZVOmAstMb76wgpcgvwG4qilhGYe5OFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849901; c=relaxed/simple;
	bh=c7ZbKM02ozoInY9TLL5WaNcYw6jZxIxWCpv/8aHKlWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD4LvA3Vlpqt9ORx1zhK3S36L+Axdw+7wh8J1OQca/8LmfGJJtI3TzQj1/PFWke8AgiTAHCV4AVyOSAOUc/pJ41x9nUDcB5PQAx1YUUyoWLoIYpgBTOVYW+XZVqqqf6IEx+15efo2MKqh68xArDYEhTDTtQ2wId38u/etiNCXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=LH8sSnq3; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea260f51b8so1947165a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1712849898; x=1713454698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQF8pW0Q5UZae20gtyOFCGbbxCzCiJFtoc6YhdkZSao=;
        b=LH8sSnq32JmoM8M0NdsnRbS6+jV8xpne0zaOegeuaxOPfUQAGVRXMPPapf/r8wTkJz
         5Rx0ZIODxRVh74zRTkQ++x8S/Nvpxz7wxRepLtOyl8I0gLB8nz43HsXB+YzCNOGO1rZr
         emS0O0IV/2v6OsVIw97rQkSyrk6HZ8pp4SaK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849898; x=1713454698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQF8pW0Q5UZae20gtyOFCGbbxCzCiJFtoc6YhdkZSao=;
        b=GCcnO86MKXFdr5KAIIrj8wr3frkVL0RUlcZjzpa5FDqztKjtMt0wqGUyqhAavE62YH
         UGXBPFeSZl4mXjPg8UK29D307C5GQJ8tjDKAXrO0uTNqY4hsegjpf7tE0Am1tvqsYtu0
         AoROa8J6cpgASBxByEbK5R/2wmopUSK6jMSSPjJpoeZwcM6wLbOSEcfqQ3rqcdgALIUl
         Az45oYlPpzJPSOSTrOv9+3TFapHtIgasClryPwiqJoNVtv1Sv7EZ2fTHxYgOMj9cNF0u
         q0rz8/LaneF9crtK8kql09zitejgy2nJ93dKaum3bBem+ZyajoQPwNOTJW5HpgNyEazT
         vtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKmOoyBcunFGdc7+Mhiog4SHVfPvmB8Ybo+ItcIZSSZb6Y0YrYBSMzRlDfEps7bip1UmgV+nnNYUtRK3MO6ndWiiWgKfookqMT2uvf
X-Gm-Message-State: AOJu0YwhFhbr1wS2hnCdEnKO2INFq3uf/BiPZUin42+vDi63ggGImtqw
	UD3RB6uVMjbSYDViZ6U8moXqWRxnCUtsFjXOsl2Yytmnm+I/Ph/EkZ6R+1ZGQA==
X-Google-Smtp-Source: AGHT+IHuutycOm+XsRHDl0LWcOxTy9NbRP7BpNLELnhVE5UZheCq3gAcUJShOSLCoSLKJdlEGR/O1A==
X-Received: by 2002:a05:6830:4d:b0:6ea:1189:de3c with SMTP id d13-20020a056830004d00b006ea1189de3cmr5851360otp.34.1712849898444;
        Thu, 11 Apr 2024 08:38:18 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id q14-20020a05683033ce00b006eb507d4257sm238520ott.33.2024.04.11.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:18 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 11 Apr 2024 10:38:16 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
Message-ID: <ZhgD6FVwprj26KBU@fedora64.linuxtx.org>
References: <20240411095420.903937140@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>

On Thu, Apr 11, 2024 at 11:54:28AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.6-rc1.gz
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

