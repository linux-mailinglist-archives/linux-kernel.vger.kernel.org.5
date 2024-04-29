Return-Path: <linux-kernel+bounces-162394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A348B5A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EC31C21649
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB75745F0;
	Mon, 29 Apr 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1GjTcmX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33C2E401
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398679; cv=none; b=RhDo50IS5+Peqpz/oZRaARRnnt6Dwg/cliWDWdS0N3gFfn8lqsuYnM/MSl1GHJfT/XvDxstP6jvQqBOaX9nUIzRmqnwnWSTqSEZQ6ZDLvhQPbZejFk2HhGFVfPssOjVtE5J31KdnTNUZ2ex38rpRYcCDhON488daUFJPOckoJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398679; c=relaxed/simple;
	bh=/jIJCnMvgZY5Up4X3Z7+dau8RuABLbiQc/6Wav+cbRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqFVzgR9jEGIftKrfLb40KKj+w23uzz1zF0KB1BP7NQM5Ff3S13Rh/zg0j800iwcqX2I/0LQOfxtgRUv8KMR8Lb9Ri8WJTJo+PMiSwXOMX+AGxaGiqOrIUT3D3+8Q3LVJtXGRf5o3bwrSkLSWy7OGb9tlpewVX+DjJGdWSrKfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1GjTcmX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714398677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tbMD2h7PJ3lWi6PtX11/1+14job09F9/bpkbzHIXK8=;
	b=T1GjTcmXBqkFmfEFLhls6bEKwVwFv6gvsbJsAhcH74JOXfQ3BJCrPaqltyTbUF0snPKKoO
	BwWBF11Rj8Myg0imCJtQLSENaCfkYlX6dTiWt3nfKQjJtryx3TETE940HSegDwuSykiZ8H
	gdYAn/EOWKhFLUHmBWP3lilUqhZxZvE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-Xw74E2WjOaGfQ788Kgabvg-1; Mon, 29 Apr 2024 09:51:14 -0400
X-MC-Unique: Xw74E2WjOaGfQ788Kgabvg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-61bb2b4204eso5536587b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398674; x=1715003474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tbMD2h7PJ3lWi6PtX11/1+14job09F9/bpkbzHIXK8=;
        b=Ow4O8a+QIrZ9eG3eWwBuAiLtCMIKJYXmKqwnzlI5ZGVpRMvjNj0CrKQB/9DXc9DZC1
         y3E68tMo+2tgkErzfepdaHqrBXZupYNKo9cOwL5ttWQbtxuoH0hR8TW+e6/W2led1j3q
         MKH/39HPhZSIvhb9Wzy8dm0dC37WHmoMRsn0hcZ7oNBflxPlM5WLFnyPWHl3eOYu1f1q
         GcJ2mN5FD7eWN0AkJkEjIX7wpN1MHHGrP/FIFAB30IK7cTBXog9wvLMpAN5XWgIa/Utp
         vp96ZSwSh3KM3OTwSdy2uGb73AIdXwDcpzfpiPUNaBWMoLX/c5NWwzCg9Dy6jFFblAzo
         OIdg==
X-Gm-Message-State: AOJu0Yy4Agu5c+UN/DtWBnCp/khqCxQrM1+fptIInhmAK+j6+faDph+g
	B/z3evQkBro8P5dCjUOrLovA5KUd2NaK6aWa8QRdBkE8FtvSYbfyoxL57ODc1x7FJwUAE2sadgy
	LcHA4zMR2bDi/4uHp/U4D5i8vlYYsktgzNlccsyZCSyFqP/2RMnFSqvhC253Q7Q==
X-Received: by 2002:a25:b29f:0:b0:de4:5c38:40b8 with SMTP id k31-20020a25b29f000000b00de45c3840b8mr9172214ybj.6.1714398673780;
        Mon, 29 Apr 2024 06:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzbclBqcimK4lAEWdX1Uas2H83fsLI+db0WSQp/ICCVyIzSWiD5cYwnQ01wud/FLiGmgLing==
X-Received: by 2002:a25:b29f:0:b0:de4:5c38:40b8 with SMTP id k31-20020a25b29f000000b00de45c3840b8mr9172187ybj.6.1714398673284;
        Mon, 29 Apr 2024 06:51:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id fu48-20020a05622a5db000b0043781985244sm10433284qtb.59.2024.04.29.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:51:13 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:51:10 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 2/2] mm/selftests: Don't prefault in gup_longterm tests
Message-ID: <Zi-lzjgoEiBGlsrX@x1n>
References: <20240428190151.201002-1-peterx@redhat.com>
 <20240428190151.201002-3-peterx@redhat.com>
 <4171dbb6-81c0-4553-a405-a55f75be4cb7@redhat.com>
 <Zi-cONgqV4_kUIE4@x1n>
 <2338119d-060b-4127-9199-5ff39fd62fc4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2338119d-060b-4127-9199-5ff39fd62fc4@redhat.com>

On Mon, Apr 29, 2024 at 03:26:22PM +0200, David Hildenbrand wrote:
> > The test patch here doesn't need to rush. David, how about you prepare a
> > better and verified patch and post it separately, making sure to cover all
> > the things we used to cover plus the unshare?  IIUC it used to be not
> > touched because of pte_write() always returns true with a write prefault.
> > 
> > Then we let patch 1 go through first, and drop this one?
> 
> Whatever you prefer!

Thanks!

Andrew, would you consider taking patch 1 but ignore this patch 2? Or do
you prefer me to resend?

-- 
Peter Xu


