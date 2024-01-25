Return-Path: <linux-kernel+bounces-39172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92E483CBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1778B1C2260C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A813474C;
	Thu, 25 Jan 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZoV4aU0"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED311F60A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209933; cv=none; b=OzCTKhpCpR0Ph0oPIDj14xdzmAyHMM0YCm0dK/j8uYHKF60aw2VzNobsXKZ/Yf5FbR/TuBYYWO5V7LeKmuax+val7e9BMT939dNkVoyp6ysXENEnToTFF0z/5mipCminunV/b33bI28p7K8KtopJVjlIfaF0hbl5byz+K/J5FJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209933; c=relaxed/simple;
	bh=aHkYPlV2Qfp6YZgOag6wd9BtFfvcPVwpYEcntK4GfiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5uD0ief6ugXxrS4Mv6FNRo4rQnACMSQtDDD1iR6Q7Hq6tCIcTzajfR6H1IhP51rWguJdjufuqf35nUwQPma9/yoTQiIn3jgkjcOhbFB7XkW2JUvKqiPjlDqPgKT/QlOjiVx1QRkX/T3KhrvFRiZKQzp/zmnSTFn9uQGgU0AD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZoV4aU0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ddcfbc569dso757994b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706209931; x=1706814731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jgf0dI3n+nDhVlYHqtCkwxHDrXSB359krf5rT5G2Cls=;
        b=lZoV4aU0bEJ+DdmYc/jtzy77emdaqkfiZdcd+ztWsyrL346q7JW71Gsfxl+tnup8sq
         5bN9rQXqLrgY8eGeNpgTTp18jC1oskwg73GFEqUaQuIktR36yz5tmQFJ8HfjbseDwMRl
         +YCskUanaSwRSvZhnLuSKN1XlddO4rjAvEVRTP4MQIyoDZmVSIbTz7V2JigBxOXGIc0f
         jZnMP6AZPb2JuC8044u5tFeVPFpKJmPCZLK+D03tyqsdB5HMq701x0gyNJPwF8rkBfeP
         OkCnbX1fgPtQ4uD2l2TenG7FPyDFC9v8FT8lO1AJp6zervlszX31aFmpI3dueHslPAhr
         aMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706209931; x=1706814731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jgf0dI3n+nDhVlYHqtCkwxHDrXSB359krf5rT5G2Cls=;
        b=bTQU6Kae8AtkmxLSemQdkDfIatMtAQ9pgbpolnk7sF7HDWh3bZA500adwPlIc4AK1S
         Y6WiKMD1l7V52wt60V0+QiAqdtvDjxga/djxTkjVgmGoMfY0UyqfEmroJaZpWaGmm1i3
         hsxSdl9hEGRMLbb1PckXN/w7bKHJCC3okInX0bApAyc+r9UJAKQeH4jtWGCJP8VygtPb
         Vo68BWjDcy9s/JVuDMrSWawgFqhFn0n9+CmtqosccAAyH8unusJT0xM+2Z8t6Ab0wSQE
         WSNbyM3LawUC9+89f9mzBC3fWaHTSua/dQufu/phae5TeFMqXH8QYikXTxPq48S/Tk+K
         fCCQ==
X-Gm-Message-State: AOJu0YwhEW2kt58MmjrSr9SLrC949RgIXclsjMVLR+SBc9kjM3CdbSMY
	iCZTCni30l1NPl0VhZaaCIlPQtBqcnl3K+jo7vbA3FqwjezE4dIM
X-Google-Smtp-Source: AGHT+IFjHDFHPHTxOhR6cbSKQ3RKRzBxHD8m/jootJDoUgQK9OMYdse/JlrSatXwnVL3nUDkH5R93A==
X-Received: by 2002:a05:6a00:1a8a:b0:6dd:892f:e2a6 with SMTP id e10-20020a056a001a8a00b006dd892fe2a6mr232072pfv.23.1706209931259;
        Thu, 25 Jan 2024 11:12:11 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00098300b006dd893f1ec5sm4165236pfg.69.2024.01.25.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:12:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 25 Jan 2024 09:12:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Audra Mitchell <audra@redhat.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
	raquini@redhat.com
Subject: Re: [PATCH] workqueue.c: Shorten events_freezable_power_efficient
 name
Message-ID: <ZbKyicgkFe_UBWJV@slm.duckdns.org>
References: <20240125190532.335558-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125190532.335558-1-audra@redhat.com>

On Thu, Jan 25, 2024 at 02:05:32PM -0500, Audra Mitchell wrote:
> Since we have set the WQ_NAME_LEN to 32, decrease the name of
> events_freezable_power_efficient so that it does not trip the name length
> warning when the workqueue is created.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Applied to wq/for-6.9.

Thanks.

-- 
tejun

