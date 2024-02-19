Return-Path: <linux-kernel+bounces-71238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC585A25C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D808281016
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674AE2D05F;
	Mon, 19 Feb 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTIt/VMB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F22C842
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343175; cv=none; b=kA6dTArkjbe5fWdvJ4uygma89V9jASIQG5+yayFwXF7ILhoqsf+ZCO+PhXxXLSV1IZ+MVx6hF7PmmXyPnn2x+E6FtYjTCTOwF9qVoA8gv9aC+dP89xSPzpV+mybeRvtRDo88JRhSqtmC21Q5hFoyQ5yyFy7mv/5tR8qvPdyQ9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343175; c=relaxed/simple;
	bh=4ZD/Ak4Shixqt+hRFej2u9n/4j5VFvBfGQlSNWdsOZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVFvBKc+SYdYP4Ob7lli9l+5uP6Kez6IaBvnHdWJKuRlBgDyUnu76ykJHE5yFo0cQ5cIRCXOzqPIigwWw7Q6qhCwEY97lN8Y1SC2mMYAsJeTWOpn1MNqLlygeHFljbOwXlNDMj1eGVNRpAVhGY4TBk+KQl/U8NkG1btfLtX/KTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTIt/VMB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708343173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZD/Ak4Shixqt+hRFej2u9n/4j5VFvBfGQlSNWdsOZ8=;
	b=HTIt/VMBAMjyY8+dO32MTjaTAOG1PcL59ZYuvlI+gWLAKMTN2Lvx6tsippESUurlwcd68y
	nuBrhLys566q+I9zBpeDhKprLZRZCtUXM6fegmzRvnYmFQN6WOrt3DHuNH6sSAj5zgnxi0
	D9pSWo3fEIS9moSyFtmH2CauHcsD4s8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-EPPZq4tQN-qRHuCQbnC0IQ-1; Mon, 19 Feb 2024 06:46:11 -0500
X-MC-Unique: EPPZq4tQN-qRHuCQbnC0IQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42da66f3f2aso55396061cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343171; x=1708947971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZD/Ak4Shixqt+hRFej2u9n/4j5VFvBfGQlSNWdsOZ8=;
        b=IvEq7IzUeUnXNnjlNvA8oqzrxVBVtduum/hr6yXTsdf2DagwsrdJmx8yFkbtf57lVG
         +eLVPuoj4oGCDLLRLjwlUYVnZzCE9m+cTt/kfRympItdD7+U452mxk2EvjJmb8EVcR2o
         IXKIHa2+VnX6PCevJQw+RJshliDhs8lSsf2Z5hNeJJ1zGnYXny2RBM1sQlwGzzaN/RpO
         xG2fm9TqqkpZiykmyWIgypPl+WDGR3XAWfp6+lGccHQf1sgcKyFE8IoP0epHnkcWA5p0
         2KTWbGfAB7ziCNSgdGIv5yWhSffO5i54igggAtP+TRuzUKR0chrjv/yJWHgNQBNb71d8
         +PxA==
X-Forwarded-Encrypted: i=1; AJvYcCX3Mi0f2/eVrLRjcfO00jSiHFND3PVkOxipFnt0WUG1d9YSV8YiKD8WqX7jFWxa4QyOsq0oqw9WXwtNhM5UH4UiCWNu1Dzvm4KC19OT
X-Gm-Message-State: AOJu0Yzt5EryUUb8CPq0hd1ecOkoWPWG1so4bbmeA98w8ndhQtIgvvMN
	ePr4eBW5rqcDgYPsAx8nmIAPqr2vNHD1H0RKIERz9MkxmYbTQlVDdbb+TcQ/lYTZ4zcCcLFmDGV
	uxrfKdmDOTi3QE+A2AdpvvdcIlECha6UtWBfv0cD4zMALR/2NLtLH0LfGuv20lQ==
X-Received: by 2002:a05:622a:4f:b0:42c:7bfc:8068 with SMTP id y15-20020a05622a004f00b0042c7bfc8068mr18270856qtw.11.1708343171122;
        Mon, 19 Feb 2024 03:46:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiNw4DCsKkz2RLLVtfw6QNV6TRlA/lysd4gQNMYeIoLrM5/4vWlvVZ/26MqBKbSbHaFvNgsA==
X-Received: by 2002:a05:622a:4f:b0:42c:7bfc:8068 with SMTP id y15-20020a05622a004f00b0042c7bfc8068mr18270830qtw.11.1708343170853;
        Mon, 19 Feb 2024 03:46:10 -0800 (PST)
Received: from debian (2a01cb058d23d600e55283140c56efd3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:e552:8314:c56:efd3])
        by smtp.gmail.com with ESMTPSA id t13-20020a05622a180d00b0042d0995a040sm2444657qtc.62.2024.02.19.03.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:46:10 -0800 (PST)
Date: Mon, 19 Feb 2024 12:46:06 +0100
From: Guillaume Nault <gnault@redhat.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-ppp@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/12] net: l2tp: constify the struct device_type usage
Message-ID: <ZdM/fjlngUdegmC7@debian>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
 <20240217-device_cleanup-net-v1-8-1eb31fb689f7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-device_cleanup-net-v1-8-1eb31fb689f7@marliere.net>

On Sat, Feb 17, 2024 at 05:13:30PM -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the l2tpeth_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


