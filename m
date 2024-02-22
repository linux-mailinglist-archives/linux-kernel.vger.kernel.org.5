Return-Path: <linux-kernel+bounces-75697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6A285ED84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5871FB25C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A73168AC;
	Thu, 22 Feb 2024 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HMjGNXyK"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54469EBE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560218; cv=none; b=B3HdljmzcmnRVOTGYZsQ6HJxUko8xzyC6oDdSTbglSWdnR2BLAH7znayPbrZfoIo4tzrUlynfSG5mYFanK0AvGYRHfov517XMHxw/UtkTeWIS+TzobS3zFIeuwsldJVzt4aCtRC2jTz2WRdcqeIJLp0mLzmnNWsh+feZqh8nYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560218; c=relaxed/simple;
	bh=CUHAvM9TBOBSGIeXrGaqW9poJoi3l306rHYdGLQmack=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=s1fO4GcbJH1fzs+4+z9V0P1avPVYdEKMokz7b5NDIw+QqgqUKa8NxShfwfzuv4W8iMihpGJK8ZYxM7xa5/pAbWWxcyLF0nSHuYgxHT7nOWi2eF/XVoSYoEUeoQHPg2yX6uYOWDfXk/zmeFCaISfMGHr6Xzj+Qz2SSpuSvAj5DcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HMjGNXyK; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e432514155so3565509a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708560215; x=1709165015; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KUJ35hEQ/dpB50QPavQbMY8BuIMgUZWkF4Rx+INF3EA=;
        b=HMjGNXyKkz8vE+w/qqACWEzKUdKfNMiEOd6/16fLa3Uknj7b+b3TkxuvvfyRHODZF6
         kwv7BipGGe/dk5CoWf4nbZx1JchXGV26is20bUZt7v0oKPV/LkcQFU+CLvVO27la/140
         KS93fe/X+V5NrAUunCc10rglAPjltC2kMHFgMi0LwBkE7LZtDBJLIHaSNb91MdBQBxbt
         CtH551fO1ec9fB1OfvP9qqzL/I0/lFIKrPiLxghGxTFr3CSsKfqzQcxV93wrOQDKf+IC
         FVya05pooWajPet0UKz+gLfYspckuZAfveYkbm6LpVvikVu60lP9QOE8hmppKsf2+q2x
         0NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560215; x=1709165015;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUJ35hEQ/dpB50QPavQbMY8BuIMgUZWkF4Rx+INF3EA=;
        b=PF6NEFujN4T82qmdXZ4XnrKkx2scZzQriCuiw/Ydy6nHTRbxjt+D0ckd359buu4ObO
         i0fxqzNoNFwiZpfLPo6k5opCYJmEgbHVNxa2rZVA57IY5QEHYH8WjJuMC3v7e4D/m9Lz
         T86miu0+u8HnP/Haz3/ecHvvh9KFH88A5wLqcZGtrRVmxLs6LS/+I9+hEI0/Pu+WLETz
         0o9EpsDay51W51Kn5/wvIhIBw0vBrB49kXZKxQp9LeuXvlDGXwTdp4CHgEWbQvFuZVnp
         VSHf2gM2hxvXSXJ29+UOe+jrAbnTuS5FepLH4/cjelk8RD31rZ4me46QFLqhLOos4HjJ
         R4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWyuAZS3WfRyIFKIqx3G6qXFu6/KVUQgaBRw+MXNUQ2kjyMgJmY64Zf0mqKxmfJZQazvXnuFzdIl/QkTgV8BkTsDRWpdsYFrA7jBfYK
X-Gm-Message-State: AOJu0YzlLPxpjZUbJOZxM0G4MNAldpZria7pfvLf31UmA76+AkqVB7RY
	sMjauINXvdydOP5/GNMms7nzQeLZeKw5OhrDGR6Ea2CUL5gkXyVGG2ykB/ZULA==
X-Google-Smtp-Source: AGHT+IHLyOG4MwwtHs06DLmn5fZMM7YdjPSbb/US79bK/6ILGjHlbvPthFQhi3Ojtpg+Ahhrbn6S/A==
X-Received: by 2002:a9d:4814:0:b0:6e4:3247:8244 with SMTP id c20-20020a9d4814000000b006e432478244mr18197851otf.37.1708560215346;
        Wed, 21 Feb 2024 16:03:35 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d9-20020a05622a05c900b0042ddde7c415sm4856546qtb.9.2024.02.21.16.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:03:34 -0800 (PST)
Date: Wed, 21 Feb 2024 19:03:34 -0500
Message-ID: <86532a709c172423ea200c1cabffa9f3@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Pairman Guo <pairmanxlr@gmail.com>
Cc: jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Pairman Guo <pairmanxlr@gmail.com>
Subject: Re: [PATCH] LSM: Fix typos in security/security.c comment headers
References: <20240217133504.4534-1-pairmanxlr@gmail.com>
In-Reply-To: <20240217133504.4534-1-pairmanxlr@gmail.com>

On Feb 17, 2024 Pairman Guo <pairmanxlr@gmail.com> wrote:
> 
> This commit fixes several typos in comment headers in security/security.c
> where "Check is" should be "Check if".
> 
> Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
> ---
>  security/security.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged into lsm/dev, thanks.

--
paul-moore.com

