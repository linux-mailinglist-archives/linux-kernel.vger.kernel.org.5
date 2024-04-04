Return-Path: <linux-kernel+bounces-131609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80387898A01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA9428BF2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8361712D752;
	Thu,  4 Apr 2024 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9qP4IGm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FB129A77
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240573; cv=none; b=X3EYmlqUE7DMFXShrloYYnyVJ6zBYg7YVp/6+6T5HHJ3it9hmlK7LN3MePqAaZVFTzpZz9+sGSQRXLqggQLZThxlSWinpEpdIgAfrh1Bub9BFrN7wnSpG/63PbkqDkKqCaZ4muSUasomJihqnYvXmkVb1gADEwDAluhqlYAzELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240573; c=relaxed/simple;
	bh=2MZpobfPZh8gJcNwAd6MYFMPrGLj+iB0IMaUCgPF9jM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HqCB+qHgaCK2tmiTw7du0HEZ6Gdr/ecTXMnvJe021rClcvL6zyJCTuRPk25TVGU01yuMANJeIC6rrzOCQgTUjJn7JEZVViFn4/dxR7SPDS3hPIJ5XvYLcs7+Q6m5gIBDdOWf9SCkUhH929OlJz4um7PxPC/qMfgVBYSFw+U2xVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9qP4IGm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712240570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2MZpobfPZh8gJcNwAd6MYFMPrGLj+iB0IMaUCgPF9jM=;
	b=V9qP4IGm1pS+XlO7qOUvA7LwdjrVwUKjh2vgY+yqRm2Zz6nvplcMFZcPduSdEMnT42KAsk
	Y5xFoPCJuayzxlJmHN54VE4bryc3O3tZ47Km0MkG83sKidY5CWccwF70iRbCc64V3YODE8
	zuK7uUOovzB3HralROViSNoP1iodnQ8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-hlsETFMAPpK0FGiCwrWhTA-1; Thu, 04 Apr 2024 10:22:48 -0400
X-MC-Unique: hlsETFMAPpK0FGiCwrWhTA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78bea765eaaso91318085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712240568; x=1712845368;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MZpobfPZh8gJcNwAd6MYFMPrGLj+iB0IMaUCgPF9jM=;
        b=q/fDsObEhBwYCdsxCABU6GLYOqrLbBbUawKJJKXi4GW7Z6EELdCl/8XAUFx9EIEzjD
         QQHJBTfYqePpE0j+frbPE9pMVzCDFs62OkvupzWGUCuLa1PtAXqGtttsMd0i1ADSSBqZ
         iGqMEJAcElfneK/6+bdM9LhFGOCC1OFFx7knddPRXk7116MAk+MmUC2MJ179GGL2lf0F
         ErkTdVsEoNzrOShGYZvTUTJskga15wxPLpGSoYHcp2TVP3EkhmQ2FOrTXDlLevoFfB5D
         9J6A/dPzb/9UqxuZeGQdvlx+FoLkzHIFTPWOngFLGhBXq3Ay5m3pubqRjF0iAJAaAtrZ
         17jg==
X-Forwarded-Encrypted: i=1; AJvYcCVfHG5kRrt4n3xTsbBMV6QI8O+9cjFuCEnV2PtWvXmHjz5mgC+DBGGSkbVKAMpwkg7qpi2ItCEXWxizRemCpO/XO/iAYUhcRbVPlwWn
X-Gm-Message-State: AOJu0Yz9sZuZ+GsVaEqiFk0ls13QHPM4a+pPsuR01+jqwgnXz27QSHcc
	Ipj3vkoJ+/m4jXwBIQqFRi6DECR5IiR+gbJdG/1LuZ063kPKo7hQe8955VF0z/ahkjsiBQbnCpn
	iTepWD6YBlkeRzKn9LKM6n2KD+T0eZg2Hs4ejo4uLslTvUt7FiY3yfRj5XjR4ig==
X-Received: by 2002:a05:620a:90e:b0:78b:eb70:df7d with SMTP id v14-20020a05620a090e00b0078beb70df7dmr2638391qkv.61.1712240567773;
        Thu, 04 Apr 2024 07:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7ZWrHvsw6SdFKvZVph6KYGjwGCx9ECeSApPPfgojS0zAV4IsLKdzBNTobaytKZez+51ANLw==
X-Received: by 2002:a05:620a:90e:b0:78b:eb70:df7d with SMTP id v14-20020a05620a090e00b0078beb70df7dmr2638364qkv.61.1712240567418;
        Thu, 04 Apr 2024 07:22:47 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a102c00b0078a68148b72sm5884416qkk.57.2024.04.04.07.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:22:46 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, Vitalii
 Bursov <vitaly@bursov.com>
Subject: Re: [PATCH v3 3/3] docs: cgroup-v1: clarify that domain levels are
 system-specific
In-Reply-To: <03b7979666088f8d55db301c6649e0c75c727d6e.1712147341.git.vitaly@bursov.com>
References: <cover.1712147341.git.vitaly@bursov.com>
 <03b7979666088f8d55db301c6649e0c75c727d6e.1712147341.git.vitaly@bursov.com>
Date: Thu, 04 Apr 2024 16:22:43 +0200
Message-ID: <xhsmhzfu99pho.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/04/24 16:28, Vitalii Bursov wrote:
> Add a clarification that domain levels are system-specific
> and where to check for system details.
>
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


