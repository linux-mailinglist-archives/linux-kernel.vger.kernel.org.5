Return-Path: <linux-kernel+bounces-118497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D16188BBCE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92851F3799D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73FB132C15;
	Tue, 26 Mar 2024 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn/yxDUa"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC618C38
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439915; cv=none; b=QMT8OAiJFr3D88hJBusmta2+OJu2p3D8fmqq1qyr4VEZmOgPYM6/lgXuAmZPhtqhXdMOFVDQHtdXhXeKYMC/+7lu1T4ZV9KApquaBXL1Sgks5oWAGclAWlbB6KS/8Kon9tS4GYMps3PEK6AKngqCQo7hQW3r0guZHMAAGgSFjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439915; c=relaxed/simple;
	bh=PphWuelZfnpwiYVrz8R7ITRKIyFMxy5KrpQlOyfjIPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=telZ+hVF6p2+5bH0PQf5EUqEgsycH4P3/pLvywed4ql6Wfen4XFHiC4GTMVuyuHtpDjGeItj6giz15uSo46+SnSsUhshT4Zoms+TydsA/6PTSLaql9ePlAWlTMdSc/CTfVLFNzmDDU/Eu2EsWhfiIV7l7AEQqQiFI7R/MYx2Ky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn/yxDUa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso7259595a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711439912; x=1712044712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7oBJ+VsJSm9DaP+glmzMitdlm9IXiT7OAprSHRUPLU=;
        b=Zn/yxDUaXGswc2BBQ6rs2Z6A3grENl6stRNWolA9Cn/qgNUTSPX4jn1JZ9zNYZasM3
         fSKZIBdKP1LsMooXPORtOONjyog2oAkPw8ywI8M2Te6Z7RKVbkQIF+g1uuZHGRBuv32k
         i7pYmLcYsyV6C5g16EbiBp66bIXffv8fiaU69BMV15YQl8s+G526xQevVKIPcYiBdHC6
         mhpAGBB3eO7QWtwtQuFR7ffalRmvw/z5B/6hpDsvx/ztifc1IBsGALHfZatcEXyLBCmt
         O2V4DX1bO72q2+ycJ/Tp8bREQz30Y5h3kpffE5lsYBCeNjQikLrWdpWtPPTDagHg7phP
         f7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711439912; x=1712044712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7oBJ+VsJSm9DaP+glmzMitdlm9IXiT7OAprSHRUPLU=;
        b=ZOrDxE9RQr/5hUmpjgdokaAQnJMahj3KRZc9VzkpBGLVvsOBkt8DFsxNAblQu3FRAT
         Emo4GAD9cQKBCNZ59NgwGDNu/BnhwK4Qygk8oOxKmabVyuXxFJ1zTOYBUDH53tb76Ops
         rQtjwdPrR1bR/5HrBjcTHK+B6XcbM82Nr0+VEyoNRcwnKWfOCJO67/2kEDmaECu3gDj2
         qaclui5uLehD/A8tOR2h2mC0aFP30bDNBVFJZ7AvhrhIqcTVMy5cvbUY6VZc+yL9Kyr9
         JXQfid1F8GfkB0JT6G9hNCIwCr3mKzL1q87A1eXP+wexQtmKXNH5CwuMx4FEpNh70kJe
         /9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSuzUzdO3SQWQuPq8PvIDZvthjzAVykkW1iVOWzVU4M4bRKvJ+GpampZe5psMGcBKr5zyMTV5YHoyfNYlLdtBNz+VIa9bHcF1UoqcF
X-Gm-Message-State: AOJu0YyjjMyO2QRZcQ63GjHWeh2WAHqrojkxVoD79ZE+r8rkmZKJEWFA
	+CcUgmbLuVn0T8F4JrKChDcAmb3oUBQPq1MKI3Fvnk9CiwtIZlwq
X-Google-Smtp-Source: AGHT+IGGxD8smNjfxvPva9SMzkqRm4l06nLWaKO6wjGr/DZqTgWJq4ZMmzI2n9rtg2+Ky0vRIkEaGg==
X-Received: by 2002:a17:907:8694:b0:a47:4d61:de44 with SMTP id qa20-20020a170907869400b00a474d61de44mr5549287ejc.55.1711439911184;
        Tue, 26 Mar 2024 00:58:31 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id oq25-20020a170906cc9900b00a46c8dbd5e4sm3906226ejb.7.2024.03.26.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:58:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 08:58:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org, yu.c.chen@intel.com,
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
	nysal@linux.ibm.com, aboorvad@linux.ibm.com, srikar@linux.ibm.com,
	vschneid@redhat.com, pierre.gondois@arm.com, qyousef@layalina.io
Subject: Re: [PATCH v6 3/3] sched/fair: Combine EAS check with overutilized
 access
Message-ID: <ZgKAJAiAM61MLPBN@gmail.com>
References: <20240307085725.444486-1-sshegde@linux.ibm.com>
 <20240307085725.444486-4-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307085725.444486-4-sshegde@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

>  /*
> - * Ensure that caller can do EAS. overutilized value
> - * make sense only if EAS is enabled
> + * overutilized value make sense only if EAS is enabled
>   */
> -static inline int is_rd_overutilized(struct root_domain *rd)
> +static inline int is_rd_not_overutilized(struct root_domain *rd)
>  {
> -	return READ_ONCE(rd->overutilized);
> +	return sched_energy_enabled() && !READ_ONCE(rd->overutilized);
>  }

While adding the sched_energy_enabled() condition looks OK, the _not prefix 
This is silly: putting logical operators into functions names is far less 
readable than a !fn()...

> -	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
> +	if (is_rd_not_overutilized(rq->rd) && cpu_overutilized(rq->cpu))

Especially since we already have cpu_overutilized(). It's far more coherent 
to have the same basic attribute functions and put any negation into 
*actual* logical operators.

Thanks,

	Ingo

