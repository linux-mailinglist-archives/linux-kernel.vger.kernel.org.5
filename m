Return-Path: <linux-kernel+bounces-85863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F13C86BC77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A951C2391D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501D23D2;
	Thu, 29 Feb 2024 00:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQAAjyIW"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA21106
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164968; cv=none; b=JxUvGVShpkOi0BZ4H4DeZPCytgLs0uC0e3+/jhkqRBlBGaN8Mr+CRGwFJF+GnYdvT4S5oKnsiAGNexU+//yd5WoWUTRV0EBsBOHvikEwGvcVqDoi4UyPmymbF6iZT0SeCf8RQoRcz1NKpEDBFLT92vY6vKPS1w/iMcof7wMJETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164968; c=relaxed/simple;
	bh=tH8Do06WsHG8uh7bIC0z1/jOfTEgMGtUd5RXQ5jyXwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqwWCVGALaYlv1F5EbU3VlGxTMQWvfj1a12DeSv5c30H526NgeJEPG06yviCsOcW69SBGrZTAsIz5i4vpsD8Kt5sQuTkTicU5wHnhi14tQskDLk0igZ59kqJXdokOIzXPwbP9YlE5uyLBFXIwN/1SUnbcvs3euR35HgW+EIGEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iQAAjyIW; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e478057f1aso144767a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709164966; x=1709769766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzYFHNFtHHHpRZc8edEq8bHU8oqWM7vjNzOC9ZZj3Zw=;
        b=iQAAjyIWjHzlp0w0zAz8XfTortXy50gEPPvXUInJQNpwa2nzLMHuBnYqRILTEpwNbi
         GJFm+FilgeG+XUGAHAtwkUM4M3sEMT87s0zsdaXbf3Vz/MGUO0LzDopdH4+CbDPkG6L9
         MFTXQyqmObj1eNFTbtl8xAFTIGsl3UADpscxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164966; x=1709769766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzYFHNFtHHHpRZc8edEq8bHU8oqWM7vjNzOC9ZZj3Zw=;
        b=XFBB8S4YyfeG+NjHwDRjiq/EHnMaX28+rbVEzLEnHxJRb9GAiXJvBq6wENElKVJ5cn
         FCfbROm51KVmOHOwU4Y91XG2dY7zPlVusipBZpmhI4EDNmikINw3MqiOelH76dJnQlzW
         S74MNEO/ukjrvmxcqQUdeAean6AHir42qHo8HXmrcj2oyrrZsgulrZ8e36e1w53hWX2g
         8oOtDeKbOAs353y5ODIPxC10k1D/C3+C+VugCefbeXlrIdBPQhDygyrdFrDdgrNV/Gi/
         aSfjIQH3ihMfuYfzWM5A/237HfCeHaBRKBAFcAq2Pw1xsP40kZEwjGvciBtvKax4njgL
         v02g==
X-Forwarded-Encrypted: i=1; AJvYcCWuH3dirRC3Y8s2AE3sOT5XJ476QUmRtCPeYcT3mdbxee5tFImtNRuOU+k04iORjugfiMRLZYEFU0z4f5sYgAUP5Ztn2wPU2EEeOoGq
X-Gm-Message-State: AOJu0YxN8Mondd2tTLl63SKEEMiHSB3SeWuCoQzKxOti2U6BmeudzBNf
	IZARJ/R3+ZQsXW1stZsYCvtukrPiUw6aa7QNChfuoQG0yS68MX+mGcx+3vCwGw==
X-Google-Smtp-Source: AGHT+IHqJ/JwJcpPTP9TpL7Xpyx58Z+NNG0bN9Bpx1sjxaHowFIn1a95cgyKBfJKxJgwJgp15rh7Lw==
X-Received: by 2002:a9d:7acd:0:b0:6e4:787a:9bc5 with SMTP id m13-20020a9d7acd000000b006e4787a9bc5mr461484otn.14.1709164966200;
        Wed, 28 Feb 2024 16:02:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a63d843000000b005dcbb855530sm61436pgj.76.2024.02.28.16.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:02:45 -0800 (PST)
Date: Wed, 28 Feb 2024 16:02:45 -0800
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
Subject: Re: [PATCH v2 1/7] scsi: mpi3mr: replace deprecated strncpy with
 assignments
Message-ID: <202402281602.2750B1F2@keescook>
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
 <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-1-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-1-dacebd3fcfa0@google.com>

On Wed, Feb 28, 2024 at 10:59:01PM +0000, Justin Stitt wrote:
> Really, there's no bug with the current code. Let's just ditch strncpy()
> all together.
> 
> We can just copy the const strings instead of reserving room on the
> stack.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

