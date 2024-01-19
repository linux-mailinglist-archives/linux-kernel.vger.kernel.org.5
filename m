Return-Path: <linux-kernel+bounces-30665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B00F28322CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DC3B211CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2AB1113;
	Fri, 19 Jan 2024 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aNbSmwo8"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AEECE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625559; cv=none; b=RBZ0MRjHx6zEeNex0GI1qBzhE2JUy3PjjCXHs3mpD7Sd+SPHjm3f57aQ1xKxVSiBDJS4Gyi2eetvdsPVm+Ae7KPKn/en907oV+Qp/F5OXr6tmyjvdxE8rR8o1Ir58/4hfvLdnlgzN+q+g9l6ZG6DagDr6xDrtIIVbv5ov8IvB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625559; c=relaxed/simple;
	bh=PkyL9kPj4Rmx4AQjC/j654aCNR8JQmTLIY+FPsN7SM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpNFsBOCFe6QlwUZ8LU7oAICnwl5yfk54yTJXbUgfz6FP4djbPONVhXrsFYZAxcI9mcZfDKWGZfju6ORcCuhLuNmwgoS8lKs3LJ79VSvB/jE0DcEYg2il65Ye+NSpPTLEqQINoeFi+GQlqz7KsRybSXEvQZ/RcTK9dsIEL13O1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aNbSmwo8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cdeb80fdfdso3128121fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705625555; x=1706230355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H61ilH2n5k1xI8w1q2NilzT5SPyyPAjMQ5rem1ZRbqI=;
        b=aNbSmwo8w//MBYfxYTi01Q37cXRr3ROdhh10Qah+PfsiGsw2llgikKTJSQjX/daCK+
         /azwDCiRszK9xtUAcEdicdd6aXV0hln1GcIKPxam3WYFNrCblQjm7nbHqQcVNb+vCa1P
         GavEeO6ap87YdjADomI3OuGl9yFsgsPAB6poI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625555; x=1706230355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H61ilH2n5k1xI8w1q2NilzT5SPyyPAjMQ5rem1ZRbqI=;
        b=E+LJepG05dUFMvzs77NSYrRunU6ccYQs1i9aMfCOPtkMatcFF+faVy5lKgziJii2lo
         /5ZMNAz/PJMgq1XJeP4QR5uWDcpDVgW7cWEgIQKaABjmUaorp+/pGos6CXUb+Lw15q+V
         hd9IMM1j3JXH41NO6YrsHyCmv5z/H89Pz1LlI3DdVntT2C01Zuw1Sa7rU2+voqTZsE7C
         FMAubD4cXjSfGxMmBFMqGYoE7Eq4/27MacN27kBOff0tm/Kn1SObw6bf3jVhLtHwmVOq
         HZxReGZPPLxFSFkAEbZmvfoVBJL5LK6AqXbP6ktQqKAeM20rAjeFcWhlhJzzpAFRTDa/
         355w==
X-Gm-Message-State: AOJu0Yx0VUXra9EzPm5XBXPADwvkrv2H2sbrrypVlGbn9oj9U+GFBBnt
	Ic1z4GgXXBVUWkR88EYssd+hCOWPtqSIOLmKN85q/hDnc1he2G5nwMSSaErUmTIgH+HKEI4BDIL
	iyKM=
X-Google-Smtp-Source: AGHT+IGCGYUdqzLOEqkKoA7a9LjJaHO7HBbIB1iTZYJS6lqCwC/yZLSLHhLQgqX7RoWHB76gO4NBwQ==
X-Received: by 2002:a2e:bc83:0:b0:2cd:ef2c:b43e with SMTP id h3-20020a2ebc83000000b002cdef2cb43emr117019ljf.2.1705625555302;
        Thu, 18 Jan 2024 16:52:35 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id b23-20020a056402139700b0055920196ddesm7028600edv.54.2024.01.18.16.52.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:52:34 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e884ac5c8so2585595e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:52:34 -0800 (PST)
X-Received: by 2002:a05:600c:2d8a:b0:40e:423c:954d with SMTP id
 i10-20020a05600c2d8a00b0040e423c954dmr456581wmg.276.1705625554320; Thu, 18
 Jan 2024 16:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZajTpGRSCJkhPEKk@infradead.org>
In-Reply-To: <ZajTpGRSCJkhPEKk@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jan 2024 16:52:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj18aK9-4yydL=T8WtwEKW2S78U5e=9YA+O4VCxYZopLw@mail.gmail.com>
Message-ID: <CAHk-=wj18aK9-4yydL=T8WtwEKW2S78U5e=9YA+O4VCxYZopLw@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.8
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 23:30, Christoph Hellwig <hch@infradead.org> wrote:
>
> are available in the Git repository at:
>
>   git.infradead.org:public_git/dma-mapping.git tags/dma-mapping-6.8-2024-01-18

Yeah, that doesn't work at all.  Please fix your scripts to use the
proper public facing side like

   git://git.infradead.org/users/hch/dma-mapping tags/dma-mapping-6.8-2024-01-18

instead of the ssh address you use to upload there.

I've pulled from the proper place, but please don't make me do that
for all your pulls.

In fact, this is the first time this happened, so you must have
changed some workflow for the worse..

             Linus

