Return-Path: <linux-kernel+bounces-111717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D73E886FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690681C21B42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440F53E2B;
	Fri, 22 Mar 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="frWhI6et"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1024AEC1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122398; cv=none; b=R6ajfxZhmX/11C7n1DTJdqXlhAh2ANhWXKt1H/E4EfMZAQ6NS3cJI9bpgB4dMhq3fIJM2r/WmtWGMmgh/6sEFA+otUT1T8YVaSVtI41FxT6NYjzxp32x4wj3p2ivz2FQiq5wMYz8RvsDlNAZGNFnUa/tHyrA7sYI6XcUrsX7irQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122398; c=relaxed/simple;
	bh=8cwJ+D5ZreiSX5Jqa/29OHQBcbGwWAaifXZ2EAozcJ0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7DFexxqCRfqjB4/hgWOTc1fQ0VSeGXJ8n/gFLLGiRm/8LI/TgcVFDLqpsFIxbZZbVzMKH9iXdkP15ePXi5wOfj2nm54SzSZatCkdJFDbqx3i2GGiNjMqldz3GyeNH9OqkKkg+JTFV4di8qq/7on7PCb03+pHP1qfZFi5vc7+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=frWhI6et; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47695273c19so913534137.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711122396; x=1711727196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VXg7QrkxfLMQmYFlOdcOd+lF4krIJAEFq1gLrBxkmFU=;
        b=frWhI6etT4Gfc67XBGHTJheRgnyNfU2J/w3TduImjr03IqU3OZqvlam0ARPLArAmO1
         3DZ+taQrrIzyljugLqkCq6DWHJhjqbQRDfRmfRsRN+tZkPgqAGIDiQBNXYK0Ms5gof5k
         NkBf4ydIl7VGsoXZwIAt8+HCrKNi1mNPSRc5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122396; x=1711727196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXg7QrkxfLMQmYFlOdcOd+lF4krIJAEFq1gLrBxkmFU=;
        b=KmWnGiv4/CsFD3pm00gubwtBM1WzLG8YVD67smeQgLM5FBtojrvxNRJoyRc7RwV1dU
         iPgZhPk8Ifb9GB8a714qS1p7GsiHl7bdv92T4PdHtNVf7NcYA/6N3d0TmHRdpUx9jcEY
         emajMtUcf/F6yne10rF4FT4gvgynsiSZ6JU5+0LL1krT5ztst8+vBC33YWLp80JILmgU
         6mLFaBqUEbDoZqcWbDDFE2xRGNgcwHMedH7Kp3phWI2VZELH0ZfC6NktWLyCVMGOuRgA
         IxaOdN/562Lp6O+zIUTOU5GbczTTojyRdhIro1h/C7vskCl+GLaiHJ45N/KQJCXcCAja
         bNtA==
X-Forwarded-Encrypted: i=1; AJvYcCW0YJfxCvcpcAwYPvKTKaOAotazm7pSjxylEa0Qs9QqstfHns1VapUXf1ppOYc7vPSRgNx3+6nAkevJ11l8gXoXZeeZMLi5BOb5mD5r
X-Gm-Message-State: AOJu0YwceBenpJbO73c4XjTrxiAEoMuXeZ+FXhGgwQ4twrKSGAwC/Rb4
	NKHr9WZjSkA0/fl22xGElB44Nvm6b4VRbjPrfPMQ1mKDdENZ+rLf6+FaIGPJbg==
X-Google-Smtp-Source: AGHT+IGA72XQzWfCKmEK/9mQGJxYv5qJP4bEubF57rbo5s1eEhVNLj9joTwii7QMoNhBGrT61pwNfQ==
X-Received: by 2002:a05:6102:240c:b0:476:6d3:dfc4 with SMTP id j12-20020a056102240c00b0047606d3dfc4mr2923858vsi.18.1711122395864;
        Fri, 22 Mar 2024 08:46:35 -0700 (PDT)
Received: from C02YVCJELVCG ([136.56.245.122])
        by smtp.gmail.com with ESMTPSA id os6-20020a05620a810600b0078a012ca9d4sm858806qkn.83.2024.03.22.08.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:46:35 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Fri, 22 Mar 2024 11:46:27 -0400
To: David Ahern <dsahern@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>

On Fri, Mar 22, 2024 at 09:24:29AM -0600, David Ahern wrote:
> On 3/22/24 1:32 AM, Greg Kroah-Hartman wrote:
> > 
> > It's the middle of the merge window, not much we can actually do and
> > this patch series itself couldn't be applied as-is, so it's hard to see
> > what could have happened on my end...
> > 
> 
> The proposal was sent a week before the end of the last development
> cycle, and I believe the intent was to motivate discussion around a
> concrete proposal to converge on an acceptable solution before sending
> patches.
> 
> On your end, what would be helpful is either a simple yes this seems
> reasonable or no you don't like it for reasons X, Y, and Z.
> 

Well said, David.

I would totally support doing something like this in a fairly generic
way that could be leveraged/instantiated by drivers that will allow
communication/inspection of hardware blocks in the datapath.  There are
lots of different ways this could go, so feedback on this would help get
us all moving in the right direction.


