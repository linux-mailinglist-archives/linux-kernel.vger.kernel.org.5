Return-Path: <linux-kernel+bounces-123385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DAD8907C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4F7B21CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A198413173E;
	Thu, 28 Mar 2024 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IffZ6Zq7"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB240856;
	Thu, 28 Mar 2024 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648512; cv=none; b=rCNusSNWawPdtBev9rBxKvcMyWP4CBPziROQ4R7k7qEJdo8fyKomF5XgdGotdff+qMx2bv5UDISv7ANR/fk/+cInznBOysVsO6VklJDYm2pEeEcJcXiP9Y6cNuHOWyH4Mc5TE31H9UR+qbHN0OG4a66Hu7rxcZwaubM6O+hoHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648512; c=relaxed/simple;
	bh=o/ViFlzn9DcSB6zcA7kLtK65QCPH/Ss4D4l1HH9emKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp3gRY+mBkqKv6pmLXP6ISa1//f9MbZliapH+/irw3ssTL02eMwD/AVllUrx6yRDq6OO+holO5Y+mf5v7ScJUN7LY7TthnoWS6HbwZjgVm6yy8iXHwGW+32KpKDoBXUSxLb4d0AjiruXxcZKihacu6ewvgWSShA6rfOdnhLFeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IffZ6Zq7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29e0a1fd9a7so980847a91.2;
        Thu, 28 Mar 2024 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711648511; x=1712253311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWQ5s/MasTSk4jjQrdrW05L8Qpoj2heGIDr+tGSERBM=;
        b=IffZ6Zq7mdTlgFNOXYKYk8APhEZ+jnWd5P7vwV8L5bZgdd5YBj99UAEtTmBYfmR5vI
         gExwSz+/raqBzCXL2yKp/akDSbKK4j7V/ZzyD8CH9e+ylDWW1RtX0MbZa14kZfmILufE
         /t3NJ3FtHc4hJDtK0Ox1C+/15dK6UqLmvleGLbLMkMMCfZBj2UHcoQ7dL8xtIpJRwJl+
         H89s8wOuwf68ipXVqoyOIbAlimD9s8bMgjmEGEgfJ7gGYdhKPob06n89IRUa+tQvD5gm
         KwmFbmNMvYYX6vVqLyGIRIBIAYpr3u0zZqWZMKvv+Sxeh0voL1kH9oCsa0rVhT+AlTSF
         o8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648511; x=1712253311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWQ5s/MasTSk4jjQrdrW05L8Qpoj2heGIDr+tGSERBM=;
        b=igCQB4QFsYScQJeP3cRiQxUa5qmLNqpZC5tOlwX33nWNCf888oEZxhRUtBNw6Az6De
         ayrIpJosrt6iJl7D+ax3xPKN8uCp/jyESYD8z8rs9mXeYrLD1DY3pPv92MZJu2F5f23t
         NWhdBQuIEovlxVw0gsUf00ja9tHjqs2nBCcP6Ogwtv1JjTs+xRuwYXtQQCZMB4MhtLu3
         7Rjbh5TEQQTDwCBcOds3vpthVYN3CT+bF3kfHE76b2X36+qhh5oqjYbuTbt5YNGJTxJY
         aLRmt/G4WfGjB2+dKLvjCvG91AleXJG/H49ITYfiFvNR1IR9hafdcTG6r9wS6YfgpJQ8
         awuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuGa0nZKrEsNS7AXHHBRX65WF9XiM3fFvpPsn3s2rxTK/FMqe7m4o9cyoHYzwTFthYPh/CRYANPbWi0C0UEr2FCaOA1ZKayBxC+DCIuj8jS4RmiRYVxh2oEX60+KNM4p7RiuNdFSZg2iSNS7s50CRed6fjNUC1FAHnjyDZEGJ1wzDUIw1SUqXjMIkioK/ok0h0W6hrDTsvkbBRQfY6oi8aRzzmf7IzP8dSJJOq9iCUeyAARKJJXE3OY2FQCQp4TbB4QQ==
X-Gm-Message-State: AOJu0YyzHv5stqt7AuVoBIO8Gpz08IsWdmauhSa1iX/DxA1OW/oUtjV3
	6bf5HpY87l7xy1IlctxEQ2/KuciA1G63gA5DB1HzsuIdcZk1r+n7
X-Google-Smtp-Source: AGHT+IEL2KsBed1zz8v9qIzuDDeEt0qqVBch3QKL5XMgY1v1rvbtZioXqmZcYbMTotvgHuw38SY6bw==
X-Received: by 2002:a17:90a:e7c6:b0:29b:d748:fae5 with SMTP id kb6-20020a17090ae7c600b0029bd748fae5mr155051pjb.32.1711648510684;
        Thu, 28 Mar 2024 10:55:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090ab10200b0029c7963a33fsm3791215pjq.10.2024.03.28.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:55:10 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:55:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Daniel Oliveira Nascimento <don@syst.com.br>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Matan Ziv-Av <matan@svgalib.org>,
	Mattia Dongili <malattia@linux.it>,
	Azael Avalos <coproscefalo@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jeff Sipek <jsipek@vmware.com>, Ajay Kaher <akaher@vmware.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-input@vger.kernel.org,
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 02/19] Input: atlas: - drop owner assignment
Message-ID: <ZgWu-33aKyCOjRBX@google.com>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
 <20240327-b4-module-owner-acpi-v1-2-725241a2d224@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-b4-module-owner-acpi-v1-2-725241a2d224@linaro.org>

On Wed, Mar 27, 2024 at 08:43:49AM +0100, Krzysztof Kozlowski wrote:
> ACPI bus core already sets the .owner, so driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

But please fix the stray colon in the subject.

> 
> ---
> 
> Depends on the first patch.
> ---
>  drivers/input/misc/atlas_btns.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
> index 3c9bbd04e143..5b9be2957746 100644
> --- a/drivers/input/misc/atlas_btns.c
> +++ b/drivers/input/misc/atlas_btns.c
> @@ -127,7 +127,6 @@ MODULE_DEVICE_TABLE(acpi, atlas_device_ids);
>  static struct acpi_driver atlas_acpi_driver = {
>  	.name	= ACPI_ATLAS_NAME,
>  	.class	= ACPI_ATLAS_CLASS,
> -	.owner	= THIS_MODULE,
>  	.ids	= atlas_device_ids,
>  	.ops	= {
>  		.add	= atlas_acpi_button_add,
> 
> -- 
> 2.34.1
> 

-- 
Dmitry

