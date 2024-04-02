Return-Path: <linux-kernel+bounces-127247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F578948C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1031F22390
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90DA14A99;
	Tue,  2 Apr 2024 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G4lN+Yma"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD6E552
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021209; cv=none; b=GvxokFXS3rzaJu4HAtQdx64vut3JG1qv6x26BFueOgEjpYZIJd4nrIii1Gwwg/rB+v8gIlT5DVLrNk6K+HcJ1KarbjfPW6kqmGsGs7xg5kj8xxdrE1w6AK6LaBijdRNCW12dH2HPxIm47CP1F0wuq7Ts7FNqLzkzUvcIGIyjDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021209; c=relaxed/simple;
	bh=WqrYHc1OrW927dxpv9fTrIBfKRqR2NBvDdcY6XIS0bs=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=pfMEl4C36fBntYq3OpdqEcLs93rwMY0i6szipSZ9vJAdUxbs17aFJyMnC6wlfN0YBK1rzKYBw/78JGudnVHaE5W8irinMEwYfssTZO/U5PBLoBY6qAQR1ZngHDg0x0xOTR3XuaHynEIRoihsf1IzQh2lU/JnuCXIljdad9ubaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G4lN+Yma; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-432c947e92eso22865351cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 18:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712021206; x=1712626006; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRws9YXLN8yb7zuQUc8CIutzWgp4avkTPI09HZCU6cI=;
        b=G4lN+Yma1v3mXG/SF+E4Q4Vmtq9IXlAYYEGNzQXsfUcjzmflAs+JTdgx6LMlAIFL9g
         HDlwt0Akkidq+vZKEYCuIM8jG6PdXrvmlZSZvYvCuuoFw+UXnJWjIQVzVoTaPmseSUjB
         drYQtYihg223VfBX5smeEnjs9qy+vAJ0lPjCvzSMy/HoNWd/TZEAO8q6QRngJdOnp4EN
         9xaNBt90oS9blyJa/pJykeOXUxR6rsO8BLXsKDz6q/rxfL+/lA7UkmJHT3RL6kelYr/t
         eRDPrIDjF8MoOn/FpM4kB5PBwj/pbnZQyNAOl+U0vdT69ZGIZF0SqDAiL/yIpoyYbrEx
         8StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712021206; x=1712626006;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRws9YXLN8yb7zuQUc8CIutzWgp4avkTPI09HZCU6cI=;
        b=Y1gShiheqaIKqthe1sK9w46YCIo1YNeH6G81SXIniLsl9mN7+8/RF7ATaXrG2mWqQV
         6s6vz/NhtLmpSc5cF1SZDqwb04OB/S+quh1PtsNYE2QzMPduBf5HZXu2FqZbteroKfMG
         zqwq7NOBEoZa/sON/kC8+GDyJdpD4pouruT3M4dhKQHgzRJGHtOY+wo6Wisd1Cyxnwjb
         IWe72YB00s/QETZvZe4F1cw3CADLBkVIK11mI8uF1GzM1hl30Go0myqwR2BmCvwC+E/C
         DduafkG6dsb1vkM85+MBSfkiK6DasdwK1A0vLUlg0RwOH6k2LdE/IoDwlnMilrJFPNB/
         kyQA==
X-Forwarded-Encrypted: i=1; AJvYcCVTGgddjBKw8UeU7vUKu0DXh5InTIaji2QNWOehdME3raKvsq1Bdn0VfjterFd4GbOVI9sVce+nqCYNK2NcIs6zab6SYsCzsLkRxAHe
X-Gm-Message-State: AOJu0Yz7BwZKt29OzpY0g8Hft856U+HzvrTQx2QUXUhl/iogr6rdjFcf
	JC5THtmtJ+9Oi4B0WYTBKchJ+1kd1pCQYvZ++x/fzOLSUlrzZhJqfaOqmoox0g==
X-Google-Smtp-Source: AGHT+IFZ7SasfMMYh5vB3j/xGXqf/TCs4Bcif8z6dD6zV7+EZAG39P9HJEPaE4K4Urz2UW0TPzSDug==
X-Received: by 2002:a05:622a:4b11:b0:432:de8a:3a8 with SMTP id et17-20020a05622a4b1100b00432de8a03a8mr9661426qtb.18.1712021206548;
        Mon, 01 Apr 2024 18:26:46 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id fw4-20020a05622a4a8400b00432bcd630c8sm4405470qtb.93.2024.04.01.18.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:26:46 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:26:45 -0400
Message-ID: <7bc35832c837a23773424bdc2255808b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH v16 15/20] security: add security_inode_setintegrity() hook
References: <1711657047-10526-16-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-16-git-send-email-wufan@linux.microsoft.com>

On Mar 28, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> This patch introduces a new hook to save inode's integrity
> data. For example, for fsverity enabled files, LSMs can use this hook to
> save the verified fsverity builtin signature into the inode's security
> blob, and LSMs can make access decisions based on the data inside
> the signature, like the signer certificate.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> --
> v1-v14:
>   + Not present
> 
> v15:
>   + Introduced
> 
> v16:
>   + Switch to call_int_hook()
> 
> ---
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 10 ++++++++++
>  security/security.c           | 20 ++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index b391a7f13053..6f746dfdb28b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -1020,6 +1023,13 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
>  	return 0;
>  }
>  
> +static inline int security_inode_setintegrity(struct inode *inode,
> +					      enum lsm_integrity_type, type,

Another bonus comma ...

> +					      const void *value, size_t size)
> +{
> +	return 0;
> +}
> +

--
paul-moore.com

