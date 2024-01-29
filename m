Return-Path: <linux-kernel+bounces-43493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F142D8414B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7BE2875F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA1157028;
	Mon, 29 Jan 2024 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgeYCjbo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75615698A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561657; cv=none; b=hYrQd0IekhjCUxcM9ArSllt6lr+Ybv0kcaziYBZCUAO/Bdn1sx161Wh835neJEkBiRgrVmLjY01q+Mgq71Ba+CrxEN8dveX/OMrYP1aKcICu42cEyiXkl4IENsVJBv6LBEwEPWN2pSzvSjRD/B38m0hyI9UFREScMWmXCoEUz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561657; c=relaxed/simple;
	bh=Lz8ZGgdyhmFwzejUu0YJFSWj+JBOv/mTCFJd5qNWMf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=R/ysf9Mqr1iU8dBxtSFIGfze6UTi3gExTNgwDR29ozpHj3Bt93gawVaf26lFYi0BY1sUWwQemn4PgtgB+DaJYGvm1D2SA497G3AGT8W/PrY0JvsUUzpZlIMzGGOEWicRAkv5Jq+v6rgs8haijrFmQ43NtzO+5xcTJuR0x8vy7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgeYCjbo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706561654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MEBEtrT1GA+qdFWm4qa+roRqV/OTFbnmk6alAQIUjE=;
	b=PgeYCjbobpFTJj73Lv2+0xhkH/+PRhlgrZih2gLZjCB8ZG9tOZWmPNvnTMjNeaKTIe5C2v
	3hQBsCCzK6uieN3mxEeTHjq0IMNQtQ0+lsQy+Mb7m+0IAQYq6os+zWPbKCtpNLEgKZEhpU
	FSaag1pG+o6UyjcwROTmCjPnm83ur0I=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-rAl3IsfXPIiqPD_w6vQKVA-1; Mon, 29 Jan 2024 15:54:12 -0500
X-MC-Unique: rAl3IsfXPIiqPD_w6vQKVA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-603cbb8ebd4so21375827b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706561652; x=1707166452;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MEBEtrT1GA+qdFWm4qa+roRqV/OTFbnmk6alAQIUjE=;
        b=v+LVPopU3FfBw25oEQNdDT5mE4dfjoPCsVbOm7CBmWJVhroJUJBzXNZckpPL2X+HiB
         vdswu9tEfgOrfMY/H/ALI7cotB0myHNuEnn+d9LCV2jNiRfxHjDJdCYQCoGbngTkJrWZ
         3FG2ggakWzrtN5CAWHU1vqBReGeVDbEV+C+1F2QBhrj17nKCd0AcHP3DqS/I82t+8eFG
         QuJdaWVB3EZ8iKUKsNwqrd/s6/6FXYHvbp6iha8d8zgktzG/Y7WfphSj2a2OBFpdxKqg
         STb9CNHDCVeT2NsZNRZ4rVb8EmFngoXkPtVPm8YI/8cJOTx0zN6EXaoHt6eY+0ie0Sl1
         t0mQ==
X-Gm-Message-State: AOJu0YyIUFvsF2QaQOPT9zl1tYwKXoDGWjmuF8LHTCLcqh7ZF/FiOeJJ
	p1u2U8LSelwG7uROPPjf6ja4Vf0TTQgDwrUPPTMVKc+YW27Qk9hrRZr1lRypcu589Kf/Fpp65hc
	AvaxPuPOBdyKE++fjXPDZEcpZDlYk4L2bUqo9Dr0Y+/aaz1PgddAmWUUr+GRVvtFZ0AFMPA==
X-Received: by 2002:a05:690c:f87:b0:5e8:545:e0cf with SMTP id df7-20020a05690c0f8700b005e80545e0cfmr6005520ywb.100.1706561651844;
        Mon, 29 Jan 2024 12:54:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9OUuR77sfkQpasIaOx/Wle3+Jwt1mwVmFXa4vstvaDYpSVBK0vKWJTty1GsK4viVV4tHYSQ==
X-Received: by 2002:a05:690c:f87:b0:5e8:545:e0cf with SMTP id df7-20020a05690c0f8700b005e80545e0cfmr6005507ywb.100.1706561651572;
        Mon, 29 Jan 2024 12:54:11 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:e70d:8905:313f:9514:fada])
        by smtp.gmail.com with ESMTPSA id g20-20020ae9e114000000b00783f7aaa96asm1702455qkm.28.2024.01.29.12.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:54:11 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] wq: Avoid using isolated cpus' timers on unbounded queue_delayed_work
Date: Mon, 29 Jan 2024 17:54:04 -0300
Message-ID: <ZbgQbOqkrWFPW0Mt@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZbgPveDBk8ysmF8a@slm.duckdns.org>
References: <20240126010321.2550286-1-leobras@redhat.com> <ZbQozqY9qOa4Q8KR@slm.duckdns.org> <ZbQsr1pNSoiMbDrO@LeoBras> <Zbfr52x97-tLP66t@slm.duckdns.org> <Zbf8AVZaXwmExroX@LeoBras> <ZbgPveDBk8ysmF8a@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 29, 2024 at 10:51:09AM -1000, Tejun Heo wrote:
> On Mon, Jan 29, 2024 at 04:26:57PM -0300, Leonardo Bras wrote:
> > > Isn't that still the same number of add_timer[_on]() calls?
> > 
> > Yeah, sorry about this, what I meant was: If we are ok on calling 
> > add_timer_on() multiple times, I would rather go with the above version, as 
> > I think it's better for readability.
> 
> I don't know. It looks more verbose and less clear to me in that it isn't
> immediately clear that every branch ends with timer being added. But this is
> really minor, so unless you have a really strong opinion against the
> suggested structured, can we just do that?

Sure, we can go with the one you suggested.

Thanks!
Leo

> 
> Thanks.
> 
> -- 
> tejun
> 


