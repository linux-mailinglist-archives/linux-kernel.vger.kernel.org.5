Return-Path: <linux-kernel+bounces-44093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18241841D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2CE28CC24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD1858AB4;
	Tue, 30 Jan 2024 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPwf5Ghb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED858AA4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602233; cv=none; b=YB319+PrPNCAycfppQOjnmpcAxTPjJTPiFOoF5b18cnH3fcbmsqkZClsssc93NsDNFt1ufT0SQICUvg9rq8FFPytKw/P8/p7/li5CQia9rdNrzqp8kBrlSLkiwOuZTsF+2/wjTog9ihVYLKLMTxOCeL1Ee+EUsV3t5YcrR6gn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602233; c=relaxed/simple;
	bh=9ZET7Fo19Dw4M7inOlC/5E9PDwt35q588zogVvBoDfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MFXDRer9bOhWfBZZpYKEKSUs3E0ByxcXtvg/b1WcVyxf3RaYo/ZCYkCnuPBivz/fLqBrtdt+lrw/JcFS8cUVIIC/SHAahT4mUgWYBJvzkICAAmx5WSMTbvMwho8H1U/oudtxAAPdC+f+OXCkCwQGkYeeU5LYH6uFwb4QbQsJnZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPwf5Ghb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc24eb13fecso5072347276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706602231; x=1707207031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZnOLNdRHdVmZEYzBZDXQm3fENJRBWRgNcjjB2bXNoo=;
        b=aPwf5GhbqU83V2VkluQIDmnJUhiBTjJuoBR4t0k5f74vKHC17QmjoZPqr9lnFgg2vw
         HeYn5hay/s7P4mxXLTlnu40AG8kTuYcL5I826DE3ZDVW3bFG93oFe2iMvYuQEPY3GHel
         1kwAMbUmthY+eDCbDkhPmZ2Kjt88TyTVMz03c0fE0c1lOzvBbBbBduijVEgBB2r2Mq+U
         5D+PkEpT0G+vSesP+WzNOImX+AOQ/0aj3ETr0tug7NZZXwDANVOQs/yUBRSUyIP/rNN1
         e6u0clHJM73o768uX9d4Ao+nEnpz1CEo2MxfT/0uatpuUHLuUuTe02bPMSr93qCpEGHK
         0tAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602231; x=1707207031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZnOLNdRHdVmZEYzBZDXQm3fENJRBWRgNcjjB2bXNoo=;
        b=hw5cbCCMkBV67ZOpmn50G1kIeqZekqMeKaeb7koxvmfb75egQCy3/+oyBiHs0GQYGg
         aTwuknnQzyuMTtloU8lKMBlihA6DLi3ijpc0ejcW9Lgb+hrrShPjdG9E9948BgN2lSbX
         fn6BU4FX3NariPto2tNlloEk4YOrstKW8fyqtmfdhLimJ42l/mzfPSX/jNi4DtB/owRG
         9HKMxNkow2hlRTpRcjzkF3l2H3gwNuuk045hJ4tC1k4BpNAotMPnFKH/magS/+30wmNC
         1DNcmTcNODb3rs2+Di9Bm1wbgXc/Fx3FeqJz3UMWjKmSRir3ho/kFxqGEJctjBTOkaqA
         Pwsw==
X-Gm-Message-State: AOJu0YzBbSZ5gm+EkhiC30VP7ywQBCGbAEsdWkXzRTwot4UfyJkvpiTE
	yM1LD3qcoCXXs7kiRUu3jcAKPZoOa+VN1R4kD6qbiGnV8l9M7jFrlYi4X+kH0Ty4XT4acdxpvO/
	eOIjw8jJM8S94gPCogw==
X-Google-Smtp-Source: AGHT+IF8BJrzVEhgFf5syMkXx6sFjusVdbhNwJYTPQqJj/kc0IxRjQiKYF3On/Spi1esmylhBoKh8jtlIWv0WJuV
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2313:b0:dbe:d0a9:2be3 with
 SMTP id do19-20020a056902231300b00dbed0a92be3mr253956ybb.3.1706602231255;
 Tue, 30 Jan 2024 00:10:31 -0800 (PST)
Date: Tue, 30 Jan 2024 08:10:29 +0000
In-Reply-To: <20240130014208.565554-6-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-6-hannes@cmpxchg.org>
Message-ID: <Zbiu9V8yPJ58zCjM@google.com>
Subject: Re: [PATCH 05/20] mm: zswap: clean up zswap_entry_put()
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:36:41PM -0500, Johannes Weiner wrote:
> Remove stale comment and unnecessary local variable.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

