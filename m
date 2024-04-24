Return-Path: <linux-kernel+bounces-157281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF828B0F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7A2B2FF62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EE816D9D6;
	Wed, 24 Apr 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JbZOhrpT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A747161913
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974377; cv=none; b=EprhHx32CnJPkmiMpZ3wYLepix2hfhQiMAWv2nZ+Ixu6cV8mw0EGK9jgPRL/tUnbcdluaLDtUYY+EH5rskoSQ7D/jHdeAVU25JEZUYMcPHN3BPcGyZlH2+Z8Ph7H8lvtlsv4yHSRGy54nYK3YVqLWGWm66iFQvM+xlwNXrL6lc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974377; c=relaxed/simple;
	bh=0GiSfYTnN6d165IOBQzb694rnUh8tyUWWbTI6T31ybQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bo1oOBuQnTF9LgGHr5dKUgI14Vu5CuiAdZexwqsHbK0q6Qkp4bfG4sLcZAcp0FWakE4f1cF9SLeCBQRA0gm5JSGnbroCxfsVy7yaykLM6OwddS23VAJGfASlgAKw58TBQLztkLpWtxs0DvyqsBf/K787aTzulqyz4ZwEozcQQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JbZOhrpT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e9320c2ef6so31542735ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713974375; x=1714579175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WnnPsbn6LQ0620dM71ztuHhda8zUa4oNBqxG0zPojc=;
        b=JbZOhrpTlsJnQLzZ365dtjwupe70dJDCEXDimOBMkR3Bg7+zZd3iVL9+c/fblvuOJR
         x0/p7JzcKbF5JES4niDrqp9telHI2uMJwCUzDwhUzTuXKR6QJJzAvzo4uhChsQDsbZmc
         tiA0z6vwEp4T0MncXqV7aYzXI91gWY/TuKhuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974375; x=1714579175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WnnPsbn6LQ0620dM71ztuHhda8zUa4oNBqxG0zPojc=;
        b=dSpg+I5+qBd/DP1c6sdo5V1JZyqY8hIDN50GiXNRV/us0wrRK3ErVO/FW+rUghpMRV
         xkLGTyaSymAoJcb2jPZW1IVctfPg0towo+w89aCH3KYMRmTVJB1WsOAdewA9PFwNpG1Q
         xtwm2oXFDR6pn19QfNoxZ18fRmfz8etqd1mhs2fnVL4jZiwlT6OdQ9D/257F0sx93RUL
         aqPEX23rXcAI5WJf8tD6n97cqtqj9HAKRqLjwXGsSkV1nqBDHWrWP9axvxgJ3uliQ3U4
         9mJVS975+bzwgdxBWd7r53FA9CiStQGROQ3j33WzQgQPYSD2XV8BMQEipl1qTxo5P5j3
         9ZHA==
X-Forwarded-Encrypted: i=1; AJvYcCXiUSFFhdjKecAZTv9oK6JAztY6wEBGYa1CjHxO1P1Ym5dGjk371DxWUYZ/QwdPCHvwjM+Eut+VNjyqOyDNkbD2466bJkeTVnZgKL45
X-Gm-Message-State: AOJu0YwOHoLy8/r6zY1B2Am9c1njhiNwlbRSkj0qHJJPw3oL9HKCRCJJ
	XlzcqcC+A6xAIuiMcQcLF7cy+drrCZkzfN7MCkCnI8AOjShF4eF2/XnNFkewBg==
X-Google-Smtp-Source: AGHT+IFH25XoxrsKcb6phfTBuhyybN5yfvn80JCnlXdGkC8eys5A64GweFI7pjlxIx0ItdNyWbfEnQ==
X-Received: by 2002:a17:903:11c3:b0:1e9:9c6e:9732 with SMTP id q3-20020a17090311c300b001e99c6e9732mr3467740plh.19.1713974374923;
        Wed, 24 Apr 2024 08:59:34 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902bd0900b001e4565a2596sm12100439pls.92.2024.04.24.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 08:59:34 -0700 (PDT)
Date: Wed, 24 Apr 2024 08:59:33 -0700
From: Kees Cook <keescook@chromium.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Charles Bertsch <cbertsch@cox.net>,
	Bart Van Assche <bvanassche@acm.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/5] string.h: Introduce memtostr() and memtostr_pad()
Message-ID: <202404240858.0FDD390@keescook>
References: <20240410021833.work.750-kees@kernel.org>
 <20240410023155.2100422-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410023155.2100422-1-keescook@chromium.org>

On Tue, Apr 09, 2024 at 07:31:50PM -0700, Kees Cook wrote:
> Another ambiguous use of strncpy() is to copy from strings that may not
> be NUL-terminated. These cases depend on having the destination buffer
> be explicitly larger than the source buffer's maximum size, having
> the size of the copy exactly match the source buffer's maximum size,
> and for the destination buffer to get explicitly NUL terminated.
> 
> This usually happens when parsing protocols or hardware character arrays
> that are not guaranteed to be NUL-terminated. The code pattern is
> effectively this:
> 
> 	char dest[sizeof(src) + 1];
> 
> 	strncpy(dest, src, sizeof(src));
> 	dest[sizeof(dest) - 1] = '\0';
> 
> In practice it usually looks like:
> 
> struct from_hardware {
> 	...
> 	char name[HW_NAME_SIZE] __nonstring;
> 	...
> };
> 
> 	struct from_hardware *p = ...;
> 	char name[HW_NAME_SIZE + 1];
> 
> 	strncpy(name, p->name, HW_NAME_SIZE);
> 	name[NW_NAME_SIZE] = '\0';
> 
> This cannot be replaced with:
> 
> 	strscpy(name, p->name, sizeof(name));
> 
> because p->name is smaller and not NUL-terminated, so FORTIFY will
> trigger when strnlen(p->name, sizeof(name)) is used. And it cannot be
> replaced with:
> 
> 	strscpy(name, p->name, sizeof(p->name));
> 
> because then "name" may contain a 1 character early truncation of
> p->name.
> 
> Provide an unambiguous interface for converting a maybe not-NUL-terminated
> string to a NUL-terminated string, with compile-time buffer size checking
> so that it can never fail at runtime: memtostr() and memtostr_pad(). Also
> add KUnit tests for both.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

FYI,

As the string KUnit tests have seen some refactoring, I'm taking this
patch and refactoring it onto my tree. Once the SCSI fixes are reviewed, if
we want to land them in -next, it's probably easiest for them to go via
my tree.

-Kees

-- 
Kees Cook

