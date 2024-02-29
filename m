Return-Path: <linux-kernel+bounces-85866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5086BC80
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70892B249E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A1E2116;
	Thu, 29 Feb 2024 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ej2Br3md"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90236E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165052; cv=none; b=NeaFNmLHF6kiwDd2orQPkX4j4VEvSBMU8aVr7rQG1WTMEGQZMyfWuwyaZelquFZX0LPIL9uaXYXfXIHCLiuSPw6NSXygPtRUBZ5sRr7jCqLSxrwK0MvTyjPLu+RPEy7+SUYej6VtKTc40PxEUQo82wbqeXURTKAWeSf+SSpFeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165052; c=relaxed/simple;
	bh=BlRDOZg+zYl2/c2qiWKrfWwMo03Qg8kTaZE9gXkvdu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqHYvj8/YiMo8j730+byEEya/vz62c709jPgvxn9gBh9zBM51cEFEbNKaEspqJRwBsLy+uVr+JL3u2bgZONzg4js8lMwc10W+WspfVSqEJXy/UCedryzTFCRwGzTkXaBpR4Q20qPGIzZbTWplCjgeqvy5VLFuWY4An4i19ndSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ej2Br3md; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bade847536so16986539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709165050; x=1709769850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUj5hY7aGRQbXDULaVrC9+/HHDaRLDH5uHjbAmT9VvE=;
        b=ej2Br3mdLKng8neAkFwC+buS+Nrzprbo7zYRo6DIoo1kCwIFKUscjKNY5E47CkeSNz
         JWoiR4JVpeIpqIeL7S/PiaAyvNQmAFAFFHHg1lNwtnYkKR5JTyIVExnEUxkU/t6pnt13
         dqUG7x1jK3hr33pDMSJFbgexd4EGt8In09WqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165050; x=1709769850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUj5hY7aGRQbXDULaVrC9+/HHDaRLDH5uHjbAmT9VvE=;
        b=EqJvFQ3QhLYvaKzPtNjNrt9KP2vniTAkjEJoHRoRK0f5KD9MS7wrl7HMUpz3FuxrNI
         NwwOH67KRMCsuwqjLzeM0180xL5Zli4VnKhVNulMTlS0pCL+QEoUKfl1ujPwscfyf6sA
         /5jAAsDvISTuZetiQfzPn0NqHxIaOXYizMB4/MK4JNb+DjLD8uAqyQr8+gBmOHlUtDAe
         cyWqLVInOSwKgXSUHBFS/IDDJ4Xsb/7GB+L/n2up9wduwAUyutNWgGjp/XeB4tvilm4p
         xPReZNUo9D8ijlRFG2m+WJgAQ3aNHnfR/vNVC7iZrgtcmePclrkh8jwloKCP0psd5Ako
         eH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX6Ztg0a1D92UrlysgG2ZVNdUwm0uyKtJtWNXMQIIiTgUFCv8qAGy8oiwuQIsqS6gieA210bGEB5Ild8p+ovG7gxE3k/6aB5x2X1Y6
X-Gm-Message-State: AOJu0Yy2sh5eYFQuU69j7AIhE1qKrkNQGRPLYfTdB1aczFV7WCispNHN
	/zSbHsvDvPGsScNRB7lIScLmM2x2JVcCQ2YYybFZmOzRZ6fNGrffZkJxjfyipQ==
X-Google-Smtp-Source: AGHT+IHMceGOR/TqQRDwpXXUp9zn3ZRfO8HssBUzlpIFHIoDWaL+0rfSEW9cDWBqvWkjRiWTEC2RaQ==
X-Received: by 2002:a92:d312:0:b0:365:1a59:dd6f with SMTP id x18-20020a92d312000000b003651a59dd6fmr846556ila.21.1709165049874;
        Wed, 28 Feb 2024 16:04:09 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00199000b006e56b4e10bcsm34291pfl.53.2024.02.28.16.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:04:09 -0800 (PST)
Date: Wed, 28 Feb 2024 16:04:08 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Don Brace <don.brace@microchip.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
	storagedev@microchip.com
Subject: Re: [PATCH v2 3/7] scsi: qedf: replace deprecated strncpy with
 strscpy
Message-ID: <202402281604.C50A4D9@keescook>
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
 <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-3-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-3-dacebd3fcfa0@google.com>

On Wed, Feb 28, 2024 at 10:59:03PM +0000, Justin Stitt wrote:
> We expect slowpath_params.name to be NUL-terminated based on its future
> usage with other string APIs:
> 
> |	static int qed_slowpath_start(struct qed_dev *cdev,
> |				      struct qed_slowpath_params *params)
> ...
> |	strscpy(drv_version.name, params->name,
> |		MCP_DRV_VER_STR_SIZE - 4);
> 
> Moreover, NUL-padding is not necessary as the only use for this slowpath
> name parameter is to copy into the drv_version.name field.
> 
> Also, let's prefer using strscpy(src, dest, sizeof(src)) in two
> instances (one of which is outside of the scsi system but it is trivial
> and related to this patch).
> 
> We can see the drv_version.name size here:
> |	struct qed_mcp_drv_version {
> |		u32	version;
> |		u8	name[MCP_DRV_VER_STR_SIZE - 4];
> |	};
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

