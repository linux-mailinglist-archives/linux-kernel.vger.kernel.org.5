Return-Path: <linux-kernel+bounces-108220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3E18807F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3028B1C22981
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4D5FDD1;
	Tue, 19 Mar 2024 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZjATGIlj"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825D5EE8D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889242; cv=none; b=fTefqGkEeZNQPwntIeYe3qUOeVTVjx54zeU3a0dyu59N82Cx4oNvqL6eaGgr7DT47ZbcGe8oUdbvFfzEPDz7t/DnAbmlbUpFd/Fbz3x5oxwwyCmAe6ykb9GA+m8nPwGH1xphutgTNWnaMdq3VzST/q1wLrgOC3hOxBNKILNX0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889242; c=relaxed/simple;
	bh=bmttXQsn7ePJrS3RSsRzViZwsDiwqJQZqSCfH7XcvBo=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=UjaLFpWwLBOOdE5APLV0XSR2aE52qnlat8HnXn7tXgYyy1cpQgBV2C/xL7y4XdhD2p+50xV+gqgPXPm2SjMstHn2fdikceJqpovIdVCRPJqdiN1n0XatIKEqaQiNnTDikrba4B1K48F+fVi8AqEnmsmd5jkiZdS5v2At8IIZmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZjATGIlj; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e675db6fbaso3602609a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710889238; x=1711494038; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B1lUfZg/s5mLlW6pu+C9FV0f0xOiWFAgmrfGrW7+FU8=;
        b=ZjATGIljivVKYYgwMgGMIWB8z+sQBX6k+j5wY/UdbOLwZNqYXQtQB+u8GX7wbcUz3c
         yyG181UcJsN8akPkxvSBPlpq+Wm7yzjzOH9fxGsEXTuHdDRkl1fg3xxV3c6mt6EEy3qO
         flasldwlS2DaSRo6xP74o3BIze2fU7/4fKCf6XGntIz+n3HjpgsgqWRLvCv4GDGzaAuB
         6bPv4mn7C8z8pi4L0X9V/jzxVHWmzgOOr8fBWDyV67MZgmKZTmlz9poKUK86yt49af+a
         +miRssM+ZalwSP/5FLfVo1ohugUWowN5gpnn44H/x8R0tJGQKO0pHqtbdFENRWbjnorO
         KtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889238; x=1711494038;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1lUfZg/s5mLlW6pu+C9FV0f0xOiWFAgmrfGrW7+FU8=;
        b=KtnoXN6WBZGH1WgnxRBXv2vAlE3zBt2R04t1VxiQzy9WHnW6SJ17LQd/ApQZut9wVv
         LlvyM8QHRsiiOwh2L+A5YFBrhZCkmNfCAR7agT+wW+icBCk2cM6taiTOoQB1/x+PjL2r
         RXwY/eaiUTMYepHBKaEzL3ZA0bvWq5FwxBRa2mT9eDQvc6aOsJzDqxCQj2DwKYO12UP5
         GLxeVnKgiKsRTw8U4Wkr1RPp19nlC4AEJeIXV7KI6AT5uT9JNduLWUd8QlacCBsjfvl5
         q8BLP+6ZAKAjcfQjxKwlb+Bl2B2seQg+B6bgYoMp/FCf6os5qic8s83/Gf19qBF8Qpvg
         cAwA==
X-Forwarded-Encrypted: i=1; AJvYcCWG/hvjIccp5Vq00f5jlePVws5jO3Jm6f+MqvWc4QpJOmYKWTuob0frVcWbHjUVNTILecgGaqqYEKZUuNNqkA9lDgycKLU6i0s4Czql
X-Gm-Message-State: AOJu0Ywlb72ZvZw9pFOpXK5TTyR+xyoPloZhzIHRpu20giQm+g0JSmB7
	2QfNkVreuddQDjJrpg41ymSTiyzIhnSsX0UbQ1p3ISF5PIHsaXHAmKjABH/TCg==
X-Google-Smtp-Source: AGHT+IH2BedFErXZvc/MdlUeUrWLnHnhWM0nrDa4rkAsKAMXW5C+nK0wePxGkm9DoXwZPu+DqNui8g==
X-Received: by 2002:a9d:7f94:0:b0:6e6:7a82:5cf with SMTP id t20-20020a9d7f94000000b006e67a8205cfmr4422911otp.33.1710889237766;
        Tue, 19 Mar 2024 16:00:37 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id dc33-20020a05620a522100b007885cd1c058sm5972263qkb.103.2024.03.19.16.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 16:00:37 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:00:36 -0400
Message-ID: <f5cf9d285bd5f09bbc3f79b0800d37fc@paul-moore.com>
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
Subject: Re: [PATCH RFC v15 12/21] security: add security_bdev_setintegrity()  hook
References: <1710560151-28904-13-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1710560151-28904-13-git-send-email-wufan@linux.microsoft.com>

On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> This patch introduces a new hook to save block device's integrity
> data. For example, for dm-verity, LSMs can use this hook to save
> the roothash signature of a dm-verity into the security blob,
> and LSMs can make access decisions based on the data inside
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
> ---
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 14 ++++++++++++++
>  security/security.c           | 28 ++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)

I'm not sure why you made this a separate patch, help?  If there is
no significant reason why this is separate, please squash it together
with patch 11/21.

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index c335404470dc..6808ae763913 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -455,4 +455,6 @@ LSM_HOOK(void, LSM_RET_VOID, initramfs_populated, void)
>  
>  LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
>  LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
> +LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
> +	 enum lsm_intgr_type type, const void *value, size_t size)
>  
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 9965b5c50df4..eaff8868766a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -83,6 +83,10 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
>  
> +enum lsm_intgr_type {
> +	__LSM_INTGR_MAX
> +};
> +
>  /*
>   * These are reasons that can be passed to the security_locked_down()
>   * LSM hook. Lockdown reasons that protect kernel integrity (ie, the
> @@ -511,6 +515,9 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>  		      void *val, size_t val_len, u64 id, u64 flags);
>  int security_bdev_alloc(struct block_device *bdev);
>  void security_bdev_free(struct block_device *bdev);
> +int security_bdev_setintegrity(struct block_device *bdev,
> +			       enum lsm_intgr_type type, const void *value,
> +			       size_t size);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> @@ -1495,6 +1502,13 @@ static inline void security_bdev_free(struct block_device *bdev)
>  {
>  }
>  
> +static inline int security_bdev_setintegrity(struct block_device *bdev,
> +					     enum lsm_intgr_type, type,
> +					     const void *value, size_t size)
> +{
> +	return 0;
> +}
> +
>  #endif	/* CONFIG_SECURITY */
>  
>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
> diff --git a/security/security.c b/security/security.c
> index 4274bbee40d0..8d88529ac904 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5637,6 +5637,34 @@ void security_bdev_free(struct block_device *bdev)
>  }
>  EXPORT_SYMBOL(security_bdev_free);
>  
> +/**
> + * security_bdev_setintegrity() - Set the bdev's integrity data

Let's just say "Set the device's integrity data" and not ask people to
figure out "bdev", although I will admit it should be fairly obvious :)

> + * @bdev: block device
> + * @type: type of integrity, e.g. hash digest, signature, etc
> + * @value: the integrity value
> + * @size: size of the integrity value
> + *
> + * Register a verified integrity measurement of a bdev with the LSM.
> + *
> + * Return: Returns 0 on success, negative values on failure.
> + */
> +int security_bdev_setintegrity(struct block_device *bdev,
> +			       enum lsm_intgr_type type, const void *value,
> +			       size_t size)
> +{
> +	int rc = 0;
> +	struct security_hook_list *p;
> +
> +	hlist_for_each_entry(p, &security_hook_heads.bdev_setintegrity, list) {
> +		rc = p->hook.bdev_setintegrity(bdev, type, value, size);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return LSM_RET_DEFAULT(bdev_setintegrity);

We can just use the call_int_hook() macro here instead of open coding
everything, right?

> +}
> +EXPORT_SYMBOL(security_bdev_setintegrity);
> +
>  #ifdef CONFIG_PERF_EVENTS
>  /**
>   * security_perf_event_open() - Check if a perf event open is allowed
> -- 
> 2.44.0

--
paul-moore.com

