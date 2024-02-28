Return-Path: <linux-kernel+bounces-85783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01286BAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792C5B2596E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0266A1361C9;
	Wed, 28 Feb 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq/6N6ZK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9B1361B8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158975; cv=none; b=RuE7zAz1/lkGrJRHJykAjlLnFnAu0I4qvodl4QDgCRZcRJ1vdyV02+E2s4b4WHpZdTQCbmXwU1zym1Obh3L6x1uV7d4u6DfjRnXA3rssucBRSxhlB76JGRU8E0dw8eUz31z+NYCigff8dXLwmzuFvefs50vun1ujIOCj0RbiDEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158975; c=relaxed/simple;
	bh=bqPIJ6+vi+DTHNESKaVkxIhlnvIO2JJ89ZmaKhl/6iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTxaAuGCEzK3gQp1VaQNlnD/EwihS65DmGJtAi/A/7OvMyVXdNlHIWEdz9v+jteVAqgUfX+oWQdDgin5cPhh/4c+dBrwn1mKAHXSWp2tvM79EdKPlxIVoaszT+cPT0u79vfhA+KbW+ZQGeZtOE4g0eTowwmvq+nLs3zcvdUekK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aq/6N6ZK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709158972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgQoXqD0xYq4yf+u8DVK7cpxCCNjrztlu+cKe20ucFc=;
	b=Aq/6N6ZKBtzlM5wD2RhdGeS45Vrs6GuUIjLaJQRKZQpXXBpyMCA7fz1tKZApcBITC07q4M
	kefIcfcqJE3WdlXwzq6UPCAoKcQHQVcg6HmGNwC1McnjhCSgIuvaWSB4ql/5paM6HB+GVi
	7w0cVCIc3SVMcDrUcWF33bnlwTljRoI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-TeVike1eMlWbG9gOE3H3KA-1; Wed, 28 Feb 2024 17:22:50 -0500
X-MC-Unique: TeVike1eMlWbG9gOE3H3KA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-787f6208f7eso47949485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709158970; x=1709763770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgQoXqD0xYq4yf+u8DVK7cpxCCNjrztlu+cKe20ucFc=;
        b=TbktEa7d0sZ49ojI8Vox8BSmf8wjfMfLW9XN798+g4+guW+b4+okyg37H3abyRdqGx
         Sc7FxkWJzKIcXRkwMm7wh5b5QujydHFWGqBl+Hs3SpT7ggDswX8DE44STR2yUcHNAq5j
         IqSAk0UmqXg4q1Qcrp2BCRmbnhLeQrEmj6FoDDGP3eCq5f5sSCENXi7gVSBT4CZfzx4A
         HRA+WRktFLQMqkvBZLqorhAzzUpJh3vPoD7OY2yHwMRsoQqsNP40s/ZUNOZa/MXVUjLT
         ESBB4XQeJU3ciR3D6en8nILFAfoUk5ZqnRqe2rePHHXlBeyhc+YztTyy7uR1r3DdwXZh
         tMRA==
X-Gm-Message-State: AOJu0YxGpFopIPzvFQLKq/4qrz+CROwfvmLs/jPWAgJnCxJLZzjlWLBP
	mA0vqOi/BNZQPMiQQ61cBXnNDEFMhloezXdlZpbFkVyym0gXsE8X11jGjKtp5STsbUudcoAG8C7
	QwYDQ1rVqEQsK2G9CPSjblEn6zqNNJNoAowEzT/b9TufGdoZ0Nytn6kOK/uR00Q==
X-Received: by 2002:a05:620a:461f:b0:787:730b:11e9 with SMTP id br31-20020a05620a461f00b00787730b11e9mr114074qkb.36.1709158970482;
        Wed, 28 Feb 2024 14:22:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHuI02LDtQgKgSd9QKijmRxf3I56jmTMM1/oKYzDbnQzdy4Kfs2Qu1hAfjNjUsjmInaQPnNw==
X-Received: by 2002:a05:620a:461f:b0:787:730b:11e9 with SMTP id br31-20020a05620a461f00b00787730b11e9mr114057qkb.36.1709158970229;
        Wed, 28 Feb 2024 14:22:50 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a12e300b00787db370253sm55031qkl.92.2024.02.28.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 14:22:49 -0800 (PST)
Date: Wed, 28 Feb 2024 16:22:48 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, javier@dowhile0.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] driver core: Don't set a deferred probe timeout if
 modules are disabled
Message-ID: <zgjqt7nbjwyv5ge2mxjhalx6msdpmnp2fcuyt5h5cjy3rrw3mk@nsyy7ee5ii2f>
References: <20240227231001.648698-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227231001.648698-1-javierm@redhat.com>

On Wed, Feb 28, 2024 at 12:09:02AM +0100, Javier Martinez Canillas wrote:
> There is no point to schedule the workqueue to timeout the deferred probe,
> if all the initcalls are done and modules are not enabled. The default for
> this case is already 0 but can be overridden by the deferred_probe_timeout
> parameter. Let's just skip this and avoid queuing work that is not needed.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
> 
> Changes in v3:
> - Just skip setting the deferred_probe_timeout parameter when modules
>   are disabled (Andrew Halaney).
> 
>  drivers/base/dd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 85152537dbf1..48a45860d2bb 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -266,6 +266,13 @@ static int __init deferred_probe_timeout_setup(char *str)
>  {
>  	int timeout;
>  
> +	/*
> +	 * If loadable modules support is disabled, there is no point to
> +	 * set a timeout for the deferred probe and schedule a workqueue.
> +	 */
> +	if (!IS_ENABLED(CONFIG_MODULES))
> +		return 1;
> +
>  	if (!kstrtoint(str, 10, &timeout))
>  		driver_deferred_probe_timeout = timeout;
>  	return 1;
> -- 
> 2.43.2
> 


