Return-Path: <linux-kernel+bounces-65503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245E0854DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0AC28C206
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BE95FF03;
	Wed, 14 Feb 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dYRUISY/"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0065FDD4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927494; cv=none; b=sxeG7XTKX8ZHnbwdxKjNtbt7ohmoN8kWVet3wsq4Epo/baw5u5Llzd/jjOdENmKY3CrqlzQvKZzBIf4yOESGF6XI3RxltBi0T/hCGZc38hT9uoacVWD7PrVLhVE9tffHVTBzRL3aeTdE1vCOuJMKihmwZDViJochxrpNyTDZGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927494; c=relaxed/simple;
	bh=nQhGmT4uvDWbAT1gRu+pj7ax6f9ZnZmTz13m1J8P4S4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJ8CV8wHak28TdfBnMpDb1l/8y/Eh4Rf2mtUShLcvnuNoX9NM8h5UuNczsECeMRbjvY1Rbe0tlrFn/QlTN8vjxRyA6wpMDkOgfn1BqLgG+WAKjFRxFhPHZIakWxMhUz/E4YlTl567nNiy5yZ93GTDTKXHH0NSVAlsl2UPPhSvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dYRUISY/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-781753f52afso294664485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707927492; x=1708532292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Zy8FkrT33RAdAZpiy7nWjgoV1yHp0TI4JUKOAfcr3Q=;
        b=dYRUISY/QGo3HPF35pvzFVRMLQhp2IH8Q0HYrBDJEuEieSzI+N8VSKVTvkS93hbEcq
         IN+fAxSVZt3RfoUR59ysqD02HUIquw5Wq+B0oJBrQpfmSMmeRshKO600NjcrFlTlsw4b
         /oDKE7+/L4xBMUr0jyDAq1S9F6ycPNBeyi8VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927492; x=1708532292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Zy8FkrT33RAdAZpiy7nWjgoV1yHp0TI4JUKOAfcr3Q=;
        b=qRV2J6ry8sYjEUYp+qBPI+Kf8UbHbjn/vuPaM9bFPty8xfYy1ZDdmFsR2h6mbDo23j
         ntZ9QFu2fZdsVN0j6jnfEY5yvACDIXOnLmcMfgdEznm+u6uSNthiGljHPfmL35tRPSVn
         +bgh+8XdpUqbhCtyakxLjuMnFNt7EtsRObgK6Y1u/fbf3v8HFhFP3o7UYxzX8dJIr+Zu
         nWo56YHNVUDLQf2AX7EzaxourHXadIn8uVOwstzHXb/KsY7VTSQI47s9QbXSXjtVnB1Y
         woELqgpT02g2+IA8ptXzkVf/q6oZfxAZZMVzwlZu//TuCi9t4ESutKv7u0xbVu/oU2Ln
         2uvA==
X-Forwarded-Encrypted: i=1; AJvYcCVPC36RXNWBKwNxyu/jg7d9H84g8fxZna4bO5lPMwDptb1g4qJDe0CNAFqrGNC9JT6XCJgpPPU/Vw78qAiNQSD+JH8Rzpz1N2gCgbrO
X-Gm-Message-State: AOJu0Yx3CTwRfPF0DGH7+a28lC9GhiVxBV6jbfN4VQozJ0enLeGpIR01
	mRAtsTqQJWBpuZeeC21qrn1oWE87ECf4I/ixzLpwIUeeMvZmCqQLTv1auUNYzw==
X-Google-Smtp-Source: AGHT+IEwpP1HbvczrkCb/9VE1aa9iY2oyn1CllXTa9Ts5qCljUBQyO69tK4ro9S/fv+gzvEgRURL2Q==
X-Received: by 2002:a05:620a:5584:b0:787:23f6:874e with SMTP id vq4-20020a05620a558400b0078723f6874emr3475242qkn.3.1707927492015;
        Wed, 14 Feb 2024 08:18:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxCNP1/4IiCZdCkWvzj9TE61oinsYbt8/C6JjvHSWZYRFx4eKippLGey5qk6SvsEsJysoG2dGmbW1PI6pTSE0f4h+gbQ95Kot3yFJLgkfsybggZKXtGDNwq0qc9C2qha+11DHLXQbgWsox3wUugU14dNB+9XF60tjcdwzYqz1WtdcWUm9McErX69Vl47+2JB/asqJldebKg+OAngz99xFxwBOj++DxEzCVkszyEbVykikX9+y4ibQK3COHYZDVcfYr/nAt+im6VYZ0KxwGnRTFSpwmN/huy7lCDZO1M6IsHez2VWXJrRJaC0kZ4ugNys2tR+Y+Z+SYDypY+O5ocQQFpkf9djh56VvWKexd5jmWaSGWYoGFTij8y5z7BmFxvUukM14HzXvAoRAkLDf7YsTaVSPHUaF+CyWUMvcSOAseYthHzxR/
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id or14-20020a05620a618e00b007872affb7d9sm592171qkn.45.2024.02.14.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:18:11 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Wed, 14 Feb 2024 11:17:58 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcx53N8lQjkpEu94@infradead.org>

On Wed, Feb 14, 2024 at 12:29:16AM -0800, Christoph Hellwig wrote:
> Chmining in late after a vacation last week, but I really do not
> understand the discussion this cause.
> 
> Complex devices need diagnostics, and mlx5ctl and the (free software)
> userspace tool provide that.  Given how it is a complex multi-subsystem
> driver that exports at least RDMA, ethernet, nvme and virtio_blk
> interfaces this functionality by definition can't fit into a single
> subsystem.
> 
> So with my nvme co-maintainer hat on:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 
> to th concept (which is not a full code review!).

I've been trying to figure out how to respond correctly to this over the
last few days, but I share your sentiment.  It's probably time to have
something like this upstream for more devices.  My initial concerns with
something that allows direct access to hardware to send messages to FW
or read/write registers over BARs were:

1.  How someone working at a distro would be able to help/understand if
a tool like this was run and may have programmed their hardware
differently than a default driver or FW.  There now exists a chance for
identical systems running identical drivers and FW to behave differently
due to out-of-band configuration.  One thought I had was some sort of
journal to note that config happened from outside, but I'm not sure
there is much value there.  With the ability to dump regs with
devlink health it's possible to know that values may have changed, so I'm not
concerned about this since that infra exists.

2.  If one can make configuration changes to hardware without kernel
APIs (devlink et al), will people still develop new kernel APIs?  I
think the answer to this is 'yes' as realistically using default tools
is much better than using vendor tools for regular configuration.  Even
if vendors provide shortcuts to program hardware for eval/testing/debug
my experience is that these are not acceptable long-term.  Requests are always
made to include this type of changes in future releases.  So I'm not too
concerned about the ossification of kernel APIs due to this being included.

So if there is general agreement that this is acceptable (especially
compared to other out-of-tree drivers, I think a few who find this
useful should sync on the best way forward; I'm not sure a separate
driver for each vendor is the right approach.

If upstream (and therefore distros) are going to accept this we probably
owe it to them to not have misc drivers for every different flavor of
hardware out there when it might be possible to add a generic driver
that can connect to a PCI device via new (auxiliary bus?) API.


