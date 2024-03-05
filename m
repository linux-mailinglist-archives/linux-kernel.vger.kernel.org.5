Return-Path: <linux-kernel+bounces-92539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA08721DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F95283FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97787126F06;
	Tue,  5 Mar 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FCzqe9W1"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721986AD4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650039; cv=none; b=Ov03lhu6tKJ518+HQ3vZt5wBJ0r5Or7by/cWAWAhWUX3cpFk2ULjffE2HD4clWqzh787UF0G0Aid/gyvyHsixONBw74IY17GCHuSVawEBjleDTpaeFgyFLKkxy99PTE0qVurns1OZHRBvOeftTDwZ4IeY9Y+udiFGjB2XczKDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650039; c=relaxed/simple;
	bh=EDwcVC0ouKKBPrgcvb/Hf3LK0z1kjlmQ7SkDR1caA6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0gtjpVFrER0EvQpwPZemyTJTUaO7fS0ZoX8TE/Qx6UCeV9wTrXAZDsAySwY4L0R7vuyFO3DZrvsts/+YMxkvVc6zsoCiVDiXAkjZBImKym9iIDV7M7qvWs9oATLug5yUbWW4BXg+urOadHAvuqYVtDeNCEqTSc4MICaifF5xjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FCzqe9W1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a450615d1c4so468493666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709650036; x=1710254836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MzDE1xUJo3upzKGltFbuIe/te77yWPQZ7Hqlh5YC5o0=;
        b=FCzqe9W1/ejdYrqkRHBQ4f1xKSGN9iTKs19t72/ubcRu/XG/iwNXKN91j7v3j3mQYY
         sZQLzBjNOcxyYE1BUUMFn3xOM4IrnVpNo6pnTsdArAfNOxOE4gjPVVVyrYWLKBQAyoR9
         E5WbRV2+pFEJQzjg+IWXA+kQIQvjikTM8vmfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709650036; x=1710254836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzDE1xUJo3upzKGltFbuIe/te77yWPQZ7Hqlh5YC5o0=;
        b=AvfDfqSzMFOb7zAbHdiyzVheAT1DWQIRd5vOpRP0ObnP3Iapg1lzmHymaw0qTVGh8w
         JzUUXX0GR3oD9qepTvpxeSy3oc9FBEG+slxQ6erhXAwA9QPrLkhXc0WR9wkCo/HuJu4G
         bU6ItGz54JNv2tEY8cHcSCdGYe1xxFPR98UpQFBTxAdIXUVkdCfbHIIOcCF2l6flrLt/
         akJ/jOBwW1PmGDm99c+zBc8jlo8Yphwdb4q1zaY78Yf1nI7q60vGyjWlkSNaO8ygqavm
         pQIhK+2Km+RL7x/2Gc/1Kz3Gvt9ScdaYYfTI02fUaT+EFex+VPJlCzeLZmzbgoR1JTUH
         xM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGBQ3qApzKmIXSROAERXGlLDYsqjkmPLyXt9wEV57GY37I3GVZjiwpY6aO0PNSACzFacK/0s9lY+cdfkRUojMosmCYz8UP7reRag31
X-Gm-Message-State: AOJu0YxGVmYfkYJkzRO4dDmm1er6U0S5KSAGSP0C0u3T43lhz5eWMRzA
	dkEOMdO4whTz4s4a3IP7XcSLwNoWsFNMu4WzOWWfXGPwdl9q8ZuQcIFO84ct2OtVsgm4W1pF7wV
	/81OGG3XzVddcGliiBqmRy6nLBuMH0S1ovSbyWw==
X-Google-Smtp-Source: AGHT+IH+LTjQkKzTBl9qR/8ShbsWm6QPQenKqK/4sdr2+VqFryoHEXOUt4dzA81l542Smk6teNd2lreRtjEMQkBRjcs=
X-Received: by 2002:a17:907:6d13:b0:a45:9e6e:fba1 with SMTP id
 sa19-20020a1709076d1300b00a459e6efba1mr3519872ejc.15.1709650036517; Tue, 05
 Mar 2024 06:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226035435.60194-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20240226035435.60194-1-jefflexu@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:47:05 +0100
Message-ID: <CAJfpegv+Pe7s6Bj35fLhZEEQYfoiPAF2n0NgfZSc45ax0S2Qyg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] fuse: add support for explicit export disabling
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 04:54, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> open_by_handle_at(2) can fail with -ESTALE with a valid handle returned
> by a previous name_to_handle_at(2) for evicted fuse inodes, which is
> especially common when entry_valid_timeout is 0, e.g. when the fuse
> daemon is in "cache=none" mode.
>
> The time sequence is like:
>
>         name_to_handle_at(2)    # succeed
>         evict fuse inode
>         open_by_handle_at(2)    # fail
>
> The root cause is that, with 0 entry_valid_timeout, the dput() called in
> name_to_handle_at(2) will trigger iput -> evict(), which will send
> FUSE_FORGET to the daemon.  The following open_by_handle_at(2) will send
> a new FUSE_LOOKUP request upon inode cache miss since the previous inode
> eviction.  Then the fuse daemon may fail the FUSE_LOOKUP request with
> -ENOENT as the cached metadata of the requested inode has already been
> cleaned up during the previous FUSE_FORGET.  The returned -ENOENT is
> treated as -ESTALE when open_by_handle_at(2) returns.
>
> This confuses the application somehow, as open_by_handle_at(2) fails
> when the previous name_to_handle_at(2) succeeds.  The returned errno is
> also confusing as the requested file is not deleted and already there.
> It is reasonable to fail name_to_handle_at(2) early in this case, after
> which the application can fallback to open(2) to access files.
>
> Since this issue typically appears when entry_valid_timeout is 0 which
> is configured by the fuse daemon, the fuse daemon is the right person to
> explicitly disable the export when required.
>
> Also considering FUSE_EXPORT_SUPPORT actually indicates the support for
> lookups of "." and "..", and there are existing fuse daemons supporting
> export without FUSE_EXPORT_SUPPORT set, for compatibility, we add a new
> INIT flag for such purpose.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Applied, thanks.

Miklos

