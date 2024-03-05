Return-Path: <linux-kernel+bounces-92184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EF2871C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2821C22E20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66E5B5D1;
	Tue,  5 Mar 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCO1BVVM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3055B5BE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635864; cv=none; b=PglIZ6Icom/6MMB5H2834+Tfi5D6wKSyjyx/DIiqA4r1jPZGJIvAXX1zmDzh9s0QmAyXoQWW0OOD20rtzc+V5n2D4i0Mv0XlVJRPf9GrYl2AgFogdPuZn161dOt53fPKRUYURRQsier2Ugzjo+whOhu4Jt31lIZhFlWntkTZNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635864; c=relaxed/simple;
	bh=Y3w0Ew9wLLwbDmC5HJ1Ff1yqBUqbPViPyGpW8TQye+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V7eqlADmVAw17Pf2Bt9CTXe28lE9gYO0mLTz+ui7x9NzkM/4HbyLdDjYp0pBmLLvC96WvoK2mKy+wFYb+OhR/Vto9jD4peG1o0ceLmMx0GwOqVjmj0686Cf1q7K0/EQIp/djAAoBU2coBjZnd1GgKiy2svvCckkQ2Y53zxAYKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCO1BVVM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3w0Ew9wLLwbDmC5HJ1Ff1yqBUqbPViPyGpW8TQye+g=;
	b=fCO1BVVM3nxLjq0iAZ7LfsOy+Mk15oDxkQylRYZqahbY/ez9UhTEevoPJNxDmSB5FgiPHC
	gfdJRuPKract+MY3Y73sU3RkSEVRW9HP9VjwChK+9CTmfISCwiXsrB0dblShcFCt3cHfww
	YJDx1Uauyp/p7MKJmEwGcp83ntZfALk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-2Hu8fhhsMvC4f3YJv0aMcw-1; Tue, 05 Mar 2024 05:50:59 -0500
X-MC-Unique: 2Hu8fhhsMvC4f3YJv0aMcw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-42ef6a1b7d3so5345541cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635859; x=1710240659;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3w0Ew9wLLwbDmC5HJ1Ff1yqBUqbPViPyGpW8TQye+g=;
        b=fyHcttNvf4fihMbHr0SN7KbvUehWC1NhGNB8t0o/OspBted5jPsDE8OJAG8O+CEgyx
         MJWl1FFJNJIhlLLZX5yKncM0PB2BOaaZ9rnzB7rwg/Xlh+ocFRsOHjjluS1eInSrbHU1
         7avfvKHmWmSo9uMS6DIxx2IjmrVLW8yEZqmF3AID2lIzbNfo15nlTnEMaI9zNycu4hOQ
         Xa3WpY0rx9Z/KgPttOOrvkuNjsthhaZMWrSUH8cBy3PwVHPYcvkQwyyKHXYirqWRxIBz
         PyCR4l0rHr1okY+X0jbUVY/ioKKyP/aXmeoPz76+Dvqk4JFU7JaVxD5r0H0J2VNsMz82
         M46w==
X-Forwarded-Encrypted: i=1; AJvYcCWxso8BAJFUnv1NfqHuCztmQTiDLIan657I5US6rx45ZF6vCQjAjk35ssxGNLHgRHE4u6fknqm2TfmelWRjWPeR8YeIIwpFFSnzZZGn
X-Gm-Message-State: AOJu0YyW0t4rmWbB0ZlYGHSjOPsqCyHPH31St5MnZrDNjSp3D5njZHT5
	tXfVf3L4nbfV0p0/NfrdF6DQYwJiE1HSPOK6JJtKfcDKGVtvWu0VwFCRHO8FxTBICcukdJfOZXJ
	QPl5YGRIZ2/nQ1dvIkdt6+bC6mcKxqemJ5S3wNUMtdF8IWWto+fFuDe2CLZ3+Gw==
X-Received: by 2002:a05:622a:1a1c:b0:42e:695b:fcf7 with SMTP id f28-20020a05622a1a1c00b0042e695bfcf7mr1600195qtb.53.1709635858924;
        Tue, 05 Mar 2024 02:50:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP/qnfbWt/FKFrO989foJrTC7N49AF65uTG2/3fNijxwKX8AksiYNJukoIZbeuoQc9lZ2iZw==
X-Received: by 2002:a05:622a:1a1c:b0:42e:695b:fcf7 with SMTP id f28-20020a05622a1a1c00b0042e695bfcf7mr1600183qtb.53.1709635858653;
        Tue, 05 Mar 2024 02:50:58 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id dn1-20020a05622a470100b0042e5c83cf22sm200909qtb.69.2024.03.05.02.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:50:58 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH 7/9] sched/balancing: Vertically align the comments of
 'struct sg_lb_stats' and 'struct sd_lb_stats'
In-Reply-To: <20240304094831.3639338-8-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-8-mingo@kernel.org>
Date: Tue, 05 Mar 2024 11:50:56 +0100
Message-ID: <xhsmha5nddka7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/03/24 10:48, Ingo Molnar wrote:
> Make them easier to read.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


