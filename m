Return-Path: <linux-kernel+bounces-49832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F084702A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE87A1C26E36
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2591419B6;
	Fri,  2 Feb 2024 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zL4A5dXT"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2E13F001
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876504; cv=none; b=jnRNtNZ/y/q8K90Oi1obgi4CU/8ZUcxolXFrMT60OZ8FTQvygKCp3dkT0iuR8YKExc4lBCOP2CKVsoTq87PNSvcIASIoR2ACiNygHAwpzpVqvw33pS7UWGUJFb8EAxxgrGQ3/a2W5keuE9rL/YX/wiSr/I6Q9QsN7ujFC+RkQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876504; c=relaxed/simple;
	bh=/lSQmt72CkXTO6IuU4LTaBs/Ul5xFwmo+dJPP9Jkq4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syFFOq/bHnCg26s2X7qRAEbcZ95w9iKeGKwNp9Cf1rVBuBrRd0v8D0WewMfcq6rRmZyG7bOOBipE722ICephBuDgOzeENwfb9HfXOesthWCKV/lmZ9uGCnOQFB1H+97hWCCcLqIWklZBLCD+TWBi9hKEMglbXYAXI3KuD2eW4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zL4A5dXT; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-51124d43943so3200525e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706876501; x=1707481301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8W2rvp+iz0AMnClCez/6mpFobBZYw1hUu+7ubVOtV0=;
        b=zL4A5dXTjLBJxOw3GBDgZ1673e6vMGkwNs+Eq1djDcJmwHZesUf5EhiZG7QY9gbie8
         Cfd3/Gwvxg8Yu7WKfGP1r1/oZjVoTDTwY6dYj9RSMRn5mfSF30Fa2ZDB6komU5aDqma5
         Amq3wotPmjFn6JP14xNyUuLWMe+Gf/Ybv+3dOvQNmV8uuUrTACAeo9BJqJSISZLd8Jdi
         nFdluGBff+rPUGBQwJSUGUl2bD43ZzarhUe2y8xB3U+p4d3QUmdxM6htS4Rta+0FLXSK
         4xXeyz7Mx2Q3ZvcuOzSmFKHfcR/+jWkhcjfD69HbFuqq/xyz0W7NJA3tEwS8kYFgz8NN
         SRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876501; x=1707481301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8W2rvp+iz0AMnClCez/6mpFobBZYw1hUu+7ubVOtV0=;
        b=p9jUYZZtkJ1NTjuOws4rRLjsiAxRm1E56Nn4RBbbTkAqSVNsCEhqFJLhHGrpIFluUm
         4yv8kLmedlYcAHJvdhWWUggZvD1dQy2TLbBAgow2kKjduMG7af7eVrgF+dTIr3wXuyKS
         WSbucuMF8RRvGPvb96t8c6T/1B5tIjEIJndCIFRJ9mSIw+/g+NbLOTmi50VYn7D7+Aps
         Q4B2mU4UHBTW07ZdV9TY1Lo0V+iVOu6bU70rm6ViErgTVVgEfpVLuSK1KmOFacFLNLVh
         cOl8umJWTmxCohGoZeXcsf8rbUcmuQv1WH4ZxxbNXwOz7bnJ+TfgETASP7JnybVAopKx
         8sdA==
X-Gm-Message-State: AOJu0YwW52kDQrjYXolztChNmEB9FVRJqQDNyB8mKolUFdAHo0Og3EIN
	5C0q7B5i71AsnOZ43Ioqg0vobgjOigSQ1sVMH19hMOWrKUIW9ebAdDWqwUPkCQSnulvouP036d3
	3/cqa4w==
X-Google-Smtp-Source: AGHT+IHuyzepGqzxcqmF4kQM1BTlD66SloEdPur1ZTqtQDOOA9um7Eu0Ctuhe5renJU0t0S1tz2q6Q==
X-Received: by 2002:a19:6912:0:b0:511:33d4:c99b with SMTP id e18-20020a196912000000b0051133d4c99bmr1066834lfc.43.1706876500765;
        Fri, 02 Feb 2024 04:21:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVlMlicMDZ+2SNsVj0g0p5WamBP0KeCBpOSXqPQk/GYHt+vJE/aOFF33umv47b05w/CnWAru0qFnVS7qz94jADuv7M6UtaKsyvZjDIOzA30pA61zxUCiS6eEWex0vYWGN6KB4OoUZsSvAzrDCCWeatv8D9Pg4pyT5NxXYj7b7aZeeAhQniRN+jZ+Uz+BgJB+GWV2LEpjvdSBsy1vVBaicedz81bcMMV3paXZqsNJQ2GX5zzw5GPdtmjTcXgTbEvCcgK0l5nBjdJwXAIQ4dN4ZPvVKDMiXHWs+fJ3lR2+H5A4YzzGzz0km/BpUzrarLtsE42WoMRqZWkGOuXvzXzsOLcsFerhIhidvqLfSKVdS+CvouHgXjHXzX7i2QU1YjoSl8KMc7x/kRvyWSHqLCC3BDSuCju8gU1/Zvgjs/KZBezhnsN91I9jf5i2xN1v3j8BlKSSD3UsYXKQXqtbxdA2KnRN6DImtafou48nE4bYquMO099mOi8n0uFTNW0P17x7SqtIdHel48xu9E5YpZgVNse/xkgwmUqtNChxhQF5cM+uLwKPzIqOQpc/8KSn8bSla3jdIKgNLt4aNUc9tzOkxD5R8D8DOV0B6hXRs5X8aJrgYYoSTTrDsZ9YljHhLnC5FWiisuceAu/o4Baqvxf9a6p7csBKVAQCPQEOSuY1owd9zhA2RBOO9Cd/aSsS7FVlZEXtm9sBPocdFn4pi6ExGt7wWzdOiZwid3t1WDRQNqu9Bjn48009TNidvwhovm9ssIqORzGFezZ7OY5eS5mRJL5OTMqVtRJ1iHi+3hkYSrmm7o1NpzGnw==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4b9100b0040e3bdff98asm7131019wmp.23.2024.02.02.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:21:40 -0800 (PST)
Date: Fri, 2 Feb 2024 13:21:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, cake@lists.bufferbloat.net,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH v5 0/4] net/sched: Load modules via alias
Message-ID: <ZbzeUW459-2f7iaq@nanopsycho>
References: <20240201130943.19536-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201130943.19536-1-mkoutny@suse.com>

Thu, Feb 01, 2024 at 02:09:39PM CET, mkoutny@suse.com wrote:
>These modules may be loaded lazily without user's awareness and
>control. Add respective aliases to modules and request them under these
>aliases so that modprobe's blacklisting mechanism (through aliases)
>works for them. (The same pattern exists e.g. for filesystem
>modules.)
>
>For example (before the change):
>  $ tc filter add dev lo parent 10: protocol ip prio 10 handle 1: cgroup
>  # cls_cgroup module is loaded despite a `blacklist cls_cgroup` entry
>  # in /etc/modprobe.d/*.conf
>
>After the change:
>  $ tc filter add dev lo parent 10: protocol ip prio 10 handle 1: cgroup
>  Error: TC classifier not found.
>  We have an error talking to the kernel
>  # explicit/acknowledged (privileged) action is needed
>  $ modprobe cls_cgroup
>  # blacklist entry won't apply to this direct modprobe, module is
>  # loaded with awareness
>
>A considered alternative was invoking `modprobe -b` always from
>request_module(), however, dismissed as too intrusive and slightly
>confusing in favor of the precedented aliases (the commit 7f78e0351394
>("fs: Limit sys_mount to only request filesystem modules.").
>
>User experience suffers in both alternatives. Its improvement is
>orthogonal to blacklist honoring.
>
>Changes from v1 (https://lore.kernel.org/r/20231121175640.9981-1-mkoutny@suse.com)
>- Treat sch_ and act_ modules analogously to cls_
>
>Changes from v2 (https://lore.kernel.org/r/20231206192752.18989-1-mkoutny@suse.com)
>- reorganized commits (one generated commit + manual pre-/post- work)
>- used alias names more fitting the existing net- aliases
>- more info in commit messages and cover letter
>- rebased on current master
>
>Changes from v3 (https://lore.kernel.org/r/20240112180646.13232-1-mkoutny@suse.com)
>- rebase on netdev/net-next/main
>- correct aliases in cls_* modules (wrong sed)
>- replace repeated prefix strings with a macro
>- patch also request_module call in qdisc_set_default()
>
>Changes from v4 (https://lore.kernel.org/r/20240123135242.11430-1-mkoutny@suse.com)
>- update example in cover letter to existing module (cls_tcindex->cls_cgroup)
>  - tested that ':-)
>- remove __stringify in alias macro, net-cls-cgroup instead of net-cls-"cgroup"
>- pass correct argument to request_module() (Simon)
>- rebased on netdev-next/main
>
>Michal Koutný (4):
>  net/sched: Add helper macros with module names
>  net/sched: Add module aliases for cls_,sch_,act_ modules
>  net/sched: Load modules via their alias
>  net/sched: Remove alias of sch_clsact

Set looks fine to me:

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

