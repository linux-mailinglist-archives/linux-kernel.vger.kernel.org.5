Return-Path: <linux-kernel+bounces-43864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FFD8419B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEF31F229D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE11374C9;
	Tue, 30 Jan 2024 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adqWSMq2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB333716E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583500; cv=none; b=RUfUjUGk1oJzo8TELdBKgU4R+mYs9xVpaxN2IvfA/alGfi+UYzXupYTAfTz1TuuhHejDiJNMDipWB0Myqt8spSIGVqid39pgNv8Sq+NzCK4Gq2CZU/1Ult51tPiP6KjOvfSXc00ct4o1uuFesrhYz25Bf1RNQ9GzRLxwB9RN+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583500; c=relaxed/simple;
	bh=pW982+GYLASK77ZhAQSGeWYMPszWY8gCAexOneAReOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=lj20fy6JaUmZ59wwpqyQf3TYxHVt9cXFWrga/jiAhaBZWIVjX7lxUhjp1uLxGSkPoEr/9lOTdt+xVO9d1L2IftvMdV5g7CZqtyfoEdq3/uI8XNC2xFrEzvUHheda2Os3gxB6u+1vxL0Uf3TMsxN5hDPKK/yh329rqN7TMMP8NeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adqWSMq2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706583498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxDckz8vpdJPlf7qb1zDq9KByIIYH0cQdPi1xVztQBY=;
	b=adqWSMq2nFiJ8Dp1zuavq4rPV6xx4WvWKdE/C0uk9ZWhmED19AqLa7fYkt9qKj1x3fUeCX
	B6sNlBMtTW/v4ycxKhTTOjkTxGQmi2nIXqobkJImy4H5oW3yDchcw/1IsTzjyTMyWRDjLE
	mTeiGej1nrDrehPT6HJBw8/TGhvkRy4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-HqWWgtbzNW2SkF8lb1bS1g-1; Mon, 29 Jan 2024 21:58:15 -0500
X-MC-Unique: HqWWgtbzNW2SkF8lb1bS1g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6800aa45af1so70145406d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583494; x=1707188294;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxDckz8vpdJPlf7qb1zDq9KByIIYH0cQdPi1xVztQBY=;
        b=Eg+KOW9CSyAED/zB3hdW6ARBD2cqK66uonucXc91nBUG+4kHPQxHJRFwH5fMBmF7CV
         FlqM47sx6TPtmu0DxhgGpfoxTXU8n+u9qgpCxI5kGEVmfBB+n36HwE+O3mKgUk8fmiDa
         HYql9kwYSG/bGq8PWy4y2i75XzHvaNmO31wzQATGeQcLeRiiq9LAbCVM27foD6epbgDL
         KVKOlaiBRc8zRiEjT/TBgOunk/YVsgGoKUzgXoqW9wurXgjVBEedsY1jriMb4eTlZIqx
         vokUBRAqwmSJ0laxh5m9GTluw7fZeJcUEj8CU8KgMcb0YEZmFyc4onnEsFSqyrtt3TB+
         sncQ==
X-Gm-Message-State: AOJu0YwqizyKVzqg622bUzp2w54ZW3Mf2eGDj1ug1MSNvF2FCWRhZAFg
	mY6VQOYr1FC/wf/UHbLyasrVO+QVYCFE2c2XZ08O9aOK7JteiKZle4jyCgY/2xFmWyi/v8lD+OD
	jwYOyVFQqHwuJC1k5Sc38hPLTpZO4owmjhTMdH5+aQiQGzZbc+VIcgklpv3aJoQ==
X-Received: by 2002:a05:6214:250e:b0:681:8768:17ab with SMTP id gf14-20020a056214250e00b00681876817abmr6495386qvb.100.1706583494727;
        Mon, 29 Jan 2024 18:58:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg05kF4pZOPL/DY8OrPJ71HdGRVsjNDN525gNg74gQq8wFSnUaI2s69+fm/iOxElXr9OMBqQ==
X-Received: by 2002:a05:6214:250e:b0:681:8768:17ab with SMTP id gf14-20020a056214250e00b00681876817abmr6495379qvb.100.1706583494469;
        Mon, 29 Jan 2024 18:58:14 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:e70d:8905:313f:9514:fada])
        by smtp.gmail.com with ESMTPSA id ld27-20020a056214419b00b006869e0eed00sm3991376qvb.26.2024.01.29.18.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 18:58:14 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org,
	Junyao Zhao <junzhao@redhat.com>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on queue_delayed_work
Date: Mon, 29 Jan 2024 23:58:07 -0300
Message-ID: <Zbhlv4EDS8qPmg_3@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZbhPWSWAZZo8gk-a@slm.duckdns.org>
References: <20240130010046.2730139-2-leobras@redhat.com> <ZbhPWSWAZZo8gk-a@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 29, 2024 at 03:22:33PM -1000, Tejun Heo wrote:
> On Mon, Jan 29, 2024 at 10:00:46PM -0300, Leonardo Bras wrote:
> > When __queue_delayed_work() is called, it chooses a cpu for handling the
> > timer interrupt. As of today, it will pick either the cpu passed as
> > parameter or the last cpu used for this.
> > 
> > This is not good if a system does use CPU isolation, because it can take
> > away some valuable cpu time to:
> > 1 - deal with the timer interrupt,
> > 2 - schedule-out the desired task,
> > 3 - queue work on a random workqueue, and
> > 4 - schedule the desired task back to the cpu.
> > 
> > So to fix this, during __queue_delayed_work(), if cpu isolation is in
> > place, pick a random non-isolated cpu to handle the timer interrupt.
> > 
> > As an optimization, if the current cpu is not isolated, use it instead
> > of looking for another candidate.
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> 
> Applied to wq/for-6.9.
> 
> Thanks.
> 
> -- 
> tejun
> 

Thank you!
Leo


