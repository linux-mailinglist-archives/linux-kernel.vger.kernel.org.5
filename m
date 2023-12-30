Return-Path: <linux-kernel+bounces-13420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C736C820651
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3591C2117A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A558BE3;
	Sat, 30 Dec 2023 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="ZQt+PPzi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82058489;
	Sat, 30 Dec 2023 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35fcea0ac1aso38006885ab.1;
        Sat, 30 Dec 2023 04:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703941179; x=1704545979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+SPPYnUKKW20M/c+9jcCpTlZCNyMAPsPCD8sE9q2KXY=;
        b=WrBmGNNep2x9kW0yxSWM6tRVIuLK6AivwaI1AxM5+NsGdfnz3tK6kVElQJ4f4nJGuO
         q3uutLhJsvBEwroTjLtKnCdV0NeZInQ1PWQgo/47aQM9VbxEWH9FXbWMiP3Bf8I9mlN5
         CBSCvwzd33mJECcLACA+zqxWj59VU6kNUN4bP6N0gcqzJFJDQO26cRCr2F606fBNKPfl
         PxtKSbWmZcWNd6Pc1oHez7Nj4hJrDEkx4peSTYf0uJCBOBe8yBNYM3pfbynkOlu6+lXB
         HiliT58+KS3SuWfUmgHduCWbT1Q/f9JZ2N6GFoDptaZnVzddsBlKjpJsf1JDyAkJiq2T
         aHqg==
X-Gm-Message-State: AOJu0Yy77jpqRQtQLrrXwLAWgp4qGNesL68OVn66y5nwP1wBGvlr7hNI
	TtzG1EC6BV1SGzy4dCvyedw=
X-Google-Smtp-Source: AGHT+IELIFDcFmENKgqmiyD21UiRKt2HITdlFCAxxtYexcKtA1cbXKI34gYZ6e3FLZzYttx66ZFHZQ==
X-Received: by 2002:a92:ca0e:0:b0:35d:59a2:bd2 with SMTP id j14-20020a92ca0e000000b0035d59a20bd2mr13619674ils.104.1703941178892;
        Sat, 30 Dec 2023 04:59:38 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a12-20020a65640c000000b005cdfb0a11e1sm12080891pgv.88.2023.12.30.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 04:59:38 -0800 (PST)
Date: Sat, 30 Dec 2023 09:59:49 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1703941176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+SPPYnUKKW20M/c+9jcCpTlZCNyMAPsPCD8sE9q2KXY=;
	b=ZQt+PPzi6WAqbFjufkekLbkbc1xVykUa/dm2flpY5wz6YDtxOtEH622TtcQEAfmUTEEnB4
	ciX4qZ+Leg6bqqNI11lZOnxkSRNddDMagEWg0oz/oQ/e5ubD249hUyjPAIU7DY0Hv+Odad
	LOZReIg5TNcBQTO49XDn35v+3tpTy0fWWZTRMGkRpUeq9m+yLDkX4aV3sPJsTryKQs2wJ+
	HnvGTd1+93QeLysV7MAgdJerGgbxGveA2if3uW1NXBBWkwyliimI9EmpTwWCnz3hOm5akl
	49qBCUpYNo/Ykn3+IPcJdgCw42EKVf0Gxp0uJD7LvxoqARWVzywChE+mXlBjbQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/156] 6.6.9-rc1 review
Message-ID: <w7qzykc6e5baubwb3fcgdimxenisxl4kc2ydxlzwfkyt2i5yit@jl5tf6lsjntn>
References: <20231230115812.333117904@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>

On 23/12/30 11:57AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 01 Jan 2024 11:57:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

System runs fine, no noticeable regressions.

[    0.000000] Linux version 6.6.9-rc1-ktest+ (rbmarliere@debian) (gcc (Debian 13.2.0-9) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231227) #1 SMP PREEMPT_DYNAMIC Sat Dec 30 08:42:24 -03 2023

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks,
-	Ricardo

