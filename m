Return-Path: <linux-kernel+bounces-137781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DAF89E754
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968F41C2122A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BF346B5;
	Wed, 10 Apr 2024 00:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYBprYRw"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CEA1FAA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712710420; cv=none; b=NIZ87J9cSOIoUEjYF1SR5WbKPeU+NschHq9bca+na0hyNpBNsjZlc1dJZL0+vHfDMP4cRbdcpip3h3R3JGi/b/y0CoJjwYu64q00QGBWnfS/bPsct/sF8HLeEHnRKy6bHNS4RKdApUj6l+vY+A3z6L2t1sPK1/pGv2kzJlahPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712710420; c=relaxed/simple;
	bh=4w30RNt2IfMUjklfvgDmalvXrZsyb0372fw4oVHKjSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vhl3+TfAbLPJ9lbkhr1N1gWj57i0ez0VZFV6yQ8PV2MQKLXlPeUIhgAnkLxdh3B3BxneKdnDEcb8aAyPxZY1WepJRLIO0TRZDXmbai8vrmByLb7MIddqY0TjWkJ83jEKjeOjnR2mbWNH+USBjT5jbBOPzbhUtKg3irqMH3M3mLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYBprYRw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so7040494a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712710417; x=1713315217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4w30RNt2IfMUjklfvgDmalvXrZsyb0372fw4oVHKjSk=;
        b=IYBprYRwZ58uQJrJSCREPRcLVsZF0co+3M6qpzyrmkKCseEEg2c+HDHBZ3Qp0h/2ZI
         uTMS3y0mFloQH3iI69uIUhVu8ohv5MyyYeXY70i7L2XDEcRRh1/J/9YRekPDEEDV5zvt
         8lkpRCn4bDXb2ME8k4Er8sSE9ihuNl7v0QpHZD3iVwseCnWaSAsCXV6idloSGugDx39t
         Uc7D86uWboRJGxxaFatIWH8xIh20wq/hxjXHFiGaD/9ma18e/81ythckVijq9cJBqIXM
         PJ1icPaSa3QBgwZzvjhlO0aRmSGJuGj0RpSAE7uECfS5ZwN3VHfzUAnSSWcoA5DtM542
         Iq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712710417; x=1713315217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4w30RNt2IfMUjklfvgDmalvXrZsyb0372fw4oVHKjSk=;
        b=uwNUVHKieUtxZierO3/AK25964GGD0GbBqzhIB2A65HWEwnCDQdU1ylrFaJPPrrI1r
         9yh9bs1owYHIexf7eGdIuvtUwEMSoCRGHNqD7xYIeZMmlN4GXvpAn/q5xXxiJcOzZeLZ
         eklVTpmVXAnzkooRegcmIe8q6TtLCDjHzMtLK3ZjcO0kuvEu+avlyz5jTa/xYsUKF2to
         N8RsgVMdYAm+YcOTRxPS4LMA4xcVHPfFrpBfcdEOAheIslVIHThzL6SK0CSD6sBiI3n6
         VvPrMnkodNeYF8u0iouZRfXTCsCixJwbLd3LOlbGoIRCVmisg22sMXsy6qqvBGCejzD3
         Wfng==
X-Forwarded-Encrypted: i=1; AJvYcCWBaRpCKCKQtoY5IpgH3TYOFGShEzXec0aPvTBOmvdSPJUVCS9GvTfcmt07P0Qx5aJhldzdVAyuRrRgxTHb9V9fSVjG2ObdJQWnp/7R
X-Gm-Message-State: AOJu0YwJ/CmghuLVc7hYeSpjIz4SNnHwUnnWr2LZijMb13acDIlJr2o5
	WzLxTkvZvh+Db6Nx9Pr7QBEXW25GY4Zk21jRzs9us3oZfHTQhLPI6htrWMLaGBltPMAB5APwKQz
	92okhgn6lrczPJGNDbt+XmW/zmA5VKNaZQLBM
X-Google-Smtp-Source: AGHT+IHBqwcvOxXjgiQrSE/ABnznnh1jLedaXxfgvV158OwPm76B04H0EpVDwJZVCI9ikofDJN7iePX8BSDXHJIyAJk=
X-Received: by 2002:a17:907:20ec:b0:a51:deec:483c with SMTP id
 rh12-20020a17090720ec00b00a51deec483cmr557352ejb.6.1712710417418; Tue, 09 Apr
 2024 17:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-3-yosryahmed@google.com> <20240405152619.GA866431@cmpxchg.org>
 <CAJD7tkaSCvgs-yKXeAVoW14_LhtCrL3N9hu9xA41GCvz+RvWBw@mail.gmail.com>
 <7aec7b98-db81-4238-bdd6-afb69679f852@redhat.com> <CAJD7tkaa3P7dQys+LhuDe8kqWsUqf7PDB8Q+07+wnQ513-6NLg@mail.gmail.com>
 <69dcd33b-e8de-4927-93dd-d4ea22834a18@redhat.com>
In-Reply-To: <69dcd33b-e8de-4927-93dd-d4ea22834a18@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 9 Apr 2024 17:52:59 -0700
Message-ID: <CAJD7tkb5D6Y5OMTzpHefYgSXbw7GdPtfjSp2=nBGjJFk99GP_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
To: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > Do we need a separate notifier chain for totalram_pages() updates?
>
> Good question. I actually might have the requirement to notify some arch
> code (s390x) from virtio-mem when fake adding/removing memory, and
> already wondered how to best wire that up.
>
> Maybe we can squeeze that into the existing notifier chain, but needs a
> bit of thought.

Do you mean by adding new actions (e.g. MEM_FAKE_ONLINE,
MEM_FAKE_OFFLINE), or by reusing the existing actions (MEM_ONLINE,
MEM_OFFLINE, etc).

New actions mean minimal impact to existing notifiers, but it may make
more sense to reuse MEM_ONLINE and MEM_OFFLINE to have generic actions
that mean "memory increased" and "memory decreased".

I suppose we can add new actions and then separately (and probably
incrementally) audit existing notifiers to check if they want to
handle the new actions as well.

Another consideration is that apparently some ballooning drivers also
register notifiers, so we need to make sure there is no possibility of
deadlock/recursion.

