Return-Path: <linux-kernel+bounces-91262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A651870BEB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE5B1C20E9A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBB310A19;
	Mon,  4 Mar 2024 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WiB1WV2i"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE7F9EB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585761; cv=none; b=iE/QMqlAFoOkSmki4xBb8PKQNFmijxjsKic3Z7zXGCdMIIdokuYF69Bz17h1g0L3byfuWWQziE35VTiWSlEK9Ox4CN8lcqtnZ6pzd/Gke9WnQVf61i3/g1cp6xiE8STlSws9GJ/H06tUN+mtuRWfgEHl7qxty3WUcDIwZ7NPIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585761; c=relaxed/simple;
	bh=Xlz2ZWcOWc8IDGysuXBIvluPifNHYRG/R4yvi08pKOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfqc+A/tuKpddxsDUJpIDzL5svXc9z27l1nJsgp8ASpxXRZshaBVg7gzd1iLi6JZCNTJIx1M7UjfbwYcokyOCaEjufPTXHvwSwMkqb1j3dTmM5omTFQSADZItCMQFcAN84BZWtV0b+jlvhQM3hn5vB4KS3spoGQCB7cJQEe+TfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WiB1WV2i; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so4759682b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709585757; x=1710190557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VZP6eFRFm49p8drfTAJOKTfORAhladZw0uGB3+WSL8=;
        b=WiB1WV2i9C6GamF/xI8b46IAsf/wrYNJGrUHuHSazgVuj2hH6uJyLhb2yycmuutAdb
         8Cd4bopXxJbDprDmBqX01DRiNHhzQZ1OrKXoE5X1LVH4cJqZ2Wkk8dV+IgqA0WK7Fxl8
         Fsz4xt9nUxd85mhWv5Y11FH4BMuQfYbcQ2dtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585757; x=1710190557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VZP6eFRFm49p8drfTAJOKTfORAhladZw0uGB3+WSL8=;
        b=gx6F0sQeqhf2A+SgCiNTINPmeqh8pffmsnPpoOx1Dval2F4FEqhHi7/8Pzh7x3zFs0
         MkOlJGKZ2sqMF0wzDSLo828QBxEkEZ+JwaoHnTqP/fg7LcC4ZhPizwe57UKHhiVWK6wr
         ddpdfLBtEXl2eBSsz78GwcNQrbVtOKJNawCehuFJ0RBbjbKnutInNecbrSPi0mFo5ypq
         BsKa4LlV8KZEfEvOBWFvtmgZ3xmHTMHptNaNz63vU58Yj/b6IuxrQsabRPxfdc7UvlaL
         JD+WoovOlO6fiz9LJqfmGdX+bNipHJrjZHpOAmvN75o0nx29VnsmoLLO9ONDX8F74VDF
         kWXA==
X-Forwarded-Encrypted: i=1; AJvYcCVvY3yp7Sdoi6OvnO51mxnmJgqJbjHmbwUUWJm9aHYXHCCdfEu4/NfF4gEjiQv9ntPINO5mM7DPAxsei/5ysQhc8IPOtB5ePgr8llU4
X-Gm-Message-State: AOJu0YySuMxO/CM+uFsR4/RdI36eT2q/NwBd/IPJKTC6SJ11ihYyR+6M
	aH99u22CHQ62qeicl++Mp/gt/QbgKt+vUn5YwwaPWAu9kaCZFmvagsU//UoXaA==
X-Google-Smtp-Source: AGHT+IEk6XxeY4cdUe3b+NTvi17Gu57p9lo+D0aVZSXVbjaWNgo5OYjM6y6Rs9SMukETfLs4Bkx8yA==
X-Received: by 2002:a05:6a20:8424:b0:1a0:b05d:2d04 with SMTP id c36-20020a056a20842400b001a0b05d2d04mr12851206pzd.26.1709585757622;
        Mon, 04 Mar 2024 12:55:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e29-20020aa7981d000000b006e592a2d073sm7535861pfl.161.2024.03.04.12.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:55:57 -0800 (PST)
Date: Mon, 4 Mar 2024 12:55:56 -0800
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	kernel@collabora.com, kernel-janitors@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/exec: Add the overall result line
 accourding to TAP
Message-ID: <202403041255.4964C19467@keescook>
References: <20240304155928.1818928-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304155928.1818928-1-usama.anjum@collabora.com>

On Mon, Mar 04, 2024 at 08:59:23PM +0500, Muhammad Usama Anjum wrote:
> The following line is missing from the test's execution. Add it to make
> it fully TAP conformant:
>   # Totals: pass:27 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

