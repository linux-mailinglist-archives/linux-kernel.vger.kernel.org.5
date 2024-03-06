Return-Path: <linux-kernel+bounces-93862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3C8735FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1691C2255A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C367FBD4;
	Wed,  6 Mar 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="FXBPB4TJ"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1774C6E;
	Wed,  6 Mar 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726424; cv=none; b=TpF2l0jIgs5707BtbUxK/jmiJLm1uIESoYtnKUz3IXz6BFzlnBf7RGtda22MmCtPEW0DbuDMjeVVzdk/joGuDC7nKbL/ek5Gu79RzDOO6CoN8wtORdYTbRQiChhyRP3JjLPfXvgr3lOTserdeh+DVQUWfvSVf18c4WgKrHMB7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726424; c=relaxed/simple;
	bh=rll++81RHnPmXCpMgw5gtpQoU4SBkDZyM2rirVvZ/08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMSfV5ItK2d6jAI5jPsMG0MdsyGyXIbmTGSvKZ2CcV7jcXV6dzafJZZjYJTCEoqsbVFWtEDtEoOHKzvn0brscSw4E2z4S89HuP+z3TDPwQeGgV54pdRbjtQa/yHt1VMvn4i1Lla9C+vinXk7M/EQKdv5bgKvvM2AR6vsrw8ZXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=FXBPB4TJ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a1a0550015so25911eaf.0;
        Wed, 06 Mar 2024 04:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709726422; x=1710331222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NCSfg79XSg8gxcqeq6qiMLqlWj175rfDfcVyginmxjA=;
        b=t4tN1K2M3OROq9xDaVMqmdX9z0wagDU+zQhYSMm5j8VVXkluU61GbkJnpj+QEj9S2/
         KRTmwAZ9mqZx4Jos4KS1wqIfVlXPnYH2hFhEIpZY06OAttZnJibwYoTiHu/o34ChS9qe
         bmS0y81OVLOzdHerRRvOFMkLjWZg8lbHNf+w5uPNUV6aJ6+TgZbyFP2vd6+6fr35Bya2
         lRtqP5cGcxD2aZ4lcA+bgA7I3T4zjUxKpTTdNb0Nii6Cc9cR69pPDs4/IxwL29TZFbCi
         u7x/0yy/BmepCz737qqKmgHnAeYnBI1a0N1iPo+QerrnPa9LyuWlSZXtJ1eQEJFnHjbY
         GL4A==
X-Forwarded-Encrypted: i=1; AJvYcCWSMjqY9LGshAQwnNZyhECWnxBo1lRthra7QExr9TVtLDHkNQ+oUld4JGorEdgrjlsV5BLdtLm2UIdk1ka9aB7jB6KRvB3uGCOhtNsflDIoxoSM+M238/Iv196tSsXAQsW19vCM09zzAx2cquNuyNQQywhOUnIfOMSRGG/aTyzNqmfiiLy+eaSKjAsK9MnWFjpT0crFmt7H0r+9P1mbX/YI
X-Gm-Message-State: AOJu0Yw7tfHGwOucApQD2iK2vMcGR1E7T89+r3HGUB6LdImhLr6h84M/
	YTzck+TzY0kq68dln4Fxgxa91+s85clds8yaLsLS7rmseLweFKyF
X-Google-Smtp-Source: AGHT+IEQ00k2DZVL5LGzpnrYPcbL6NwbJtSjRk3MkAoox6RlfPwTN9DHzGp7XV1L0dSoMfJn7Oy2+A==
X-Received: by 2002:a05:6870:458e:b0:21f:f8a9:e892 with SMTP id y14-20020a056870458e00b0021ff8a9e892mr5089973oao.53.1709726422067;
        Wed, 06 Mar 2024 04:00:22 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id w3-20020aa79a03000000b006e54f344e14sm10661253pfj.22.2024.03.06.04.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:00:21 -0800 (PST)
Date: Wed, 6 Mar 2024 09:00:12 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709726420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NCSfg79XSg8gxcqeq6qiMLqlWj175rfDfcVyginmxjA=;
	b=FXBPB4TJRJV0G7bT2ecrH06o/RrcdzzhrudVqUO+CsIODDh+1wGZMQH9a48CN76l6m74Pr
	1WryduNUxVTTZoXakdH7219RsWARB5p4pyaZGlpkdv3h8oiu8atxqqB+gLzezexp24y7v4
	T1Ks4RAOlVkQLIYFE/+0Jxl3tarNj9NUhtseqh0y+0hhPqkDYIXWE48sUhIW0RiHtMr4Wd
	v3CgT9eg9wSYmz9zQnRedvJpNNBOCHIcdqRt7RUfM/LWaAdZSLbRMpgRqEvghyEPkomEyC
	aJ8FY0YNCKp6mYlaEgWVgdOkQ9h17yKETLpAHTyLjNkVEeBB12ZUmab0a+/cOg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>, 
	Jan Kara <jack@suse.cz>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Christian Brauner <brauner@kernel.org>, Li Lingfeng <lilingfeng3@huawei.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Hannes Reinecke <hare@suse.de>, 
	Christian Loehle <CLoehle@hyperstone.com>, Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>, 
	Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-block@vger.kernel.org, Diping Zhang <diping.zhang@gl-inet.com>, 
	Jianhui Zhao <zhaojh329@gmail.com>, Jieying Zeng <jieying.zeng@gl-inet.com>, 
	Chad Monroe <chad.monroe@adtran.com>, Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Subject: Re: [RFC PATCH v2 4/8] block: implement NVMEM provider
Message-ID: <palxzjqvvteqajsajrdgdvncq3eka65pq7de4jnwyhpfs3xrac@c34xcdxctbcq>
References: <cover.1709667858.git.daniel@makrotopia.org>
 <6061aa4201030b9bb2f8d03ef32a564fdb786ed1.1709667858.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6061aa4201030b9bb2f8d03ef32a564fdb786ed1.1709667858.git.daniel@makrotopia.org>

Hi Daniel,

On  5 Mar 20:23, Daniel Golle wrote:
> static int __init blk_nvmem_init(void)
> {
> 	int ret;
>  
> 	ret = class_interface_register(&blk_nvmem_bus_interface);
> 	if (ret)
> 		return ret;
>  
> 	return 0;

Just an idea, why not just:

return class_interface_register(&blk_nvmem_bus_interface);


