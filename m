Return-Path: <linux-kernel+bounces-20847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23214828625
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331F41C23B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3138DD8;
	Tue,  9 Jan 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CtqOLqJw"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F3381C3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28bc8540299so1658800a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704804032; x=1705408832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+K+iBGf5qDJUPXHd12KoLyityxUnYoSVawKfBzB7oKM=;
        b=CtqOLqJwMUwEbgcD4NnJmGg+ciLhVp3uBmR95Zs7DejavkHVzl/aPvf88XD8RWTGgk
         GAZDUnoDGvbEOqnRqDb1OML2635DyAmsT/ofckD5xVDSXhSXM44GZlmJHquCKDlsGIcm
         x1j1M9quKbukzfY1koFcCHnwyH+jQlk9N2440=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704804032; x=1705408832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K+iBGf5qDJUPXHd12KoLyityxUnYoSVawKfBzB7oKM=;
        b=K3Hh9XO5fZ1CK2C84fnWHUxHyuTBRzKn1NuDbOihYUN/PmsRTE8eIYpo8sTCD2wKLN
         EakPUALVUDrVdW/G5VPinXpqgm2UD6+r+kOulbpzuzNJUZ1bj0qVg8YNXrVPk0UrnQRb
         uOddS7KSDLBu4+KNu7JR+gyyJf3Zo2grvEYXAI3nLau4tXxlpA8uFOxD9sMnXSZYt9Mw
         gkmPd2tZw0TaLMFXw9s2F6BnVKWDknnTHgT7xNpJ5u4kUwskBOzQ1jYPos75di8Fuan8
         bkHXKRMDRVtgONoFvRMZgXSAN+BObaG+ptgHhmpZbn4qZ/d+QvDcWDQR3b7WJmoO7Lsh
         vrog==
X-Gm-Message-State: AOJu0YyYEWsPkyaKqwyHV7FPIO3vHO/2sLq6FqPxCtn7mzodEyIIcGOb
	ZbYO3uRpSL4wpsR/SF7OuJsORftfn+xL
X-Google-Smtp-Source: AGHT+IH2offlfMdPACFUtIsHxeVqe+6Gd+f44kMTmBAtYNCgy/GtMy0D3GBgDlzNju2HOn9Ag3ajUA==
X-Received: by 2002:a17:90a:62c4:b0:28c:843c:105b with SMTP id k4-20020a17090a62c400b0028c843c105bmr2285019pjs.27.1704804032290;
        Tue, 09 Jan 2024 04:40:32 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id f89-20020a17090a706200b0028c2b4f5f32sm2027011pjk.3.2024.01.09.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:40:31 -0800 (PST)
Date: Tue, 9 Jan 2024 21:40:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: venus: hfi_cmds: Replace one-element array
 with flex-array member and use __counted_by
Message-ID: <20240109124026.GA1012017@google.com>
References: <ZSRJfRdUXQOzagKr@work>
 <202310091252.660CFA9@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310091252.660CFA9@keescook>

On (23/10/09 12:52), Kees Cook wrote:
> On Mon, Oct 09, 2023 at 12:42:05PM -0600, Gustavo A. R. Silva wrote:
> > Array `data` in `struct hfi_sfr` is being used as a fake flexible array
> > at run-time:
> > 
> > drivers/media/platform/qcom/venus/hfi_venus.c:
> > 1033         p = memchr(sfr->data, '\0', sfr->buf_size);
> > 1034         /*
> > 1035          * SFR isn't guaranteed to be NULL terminated since SYS_ERROR indicates
> > 1036          * that Venus is in the process of crashing.
> > 1037          */
> > 1038         if (!p)
> > 1039                 sfr->data[sfr->buf_size - 1] = '\0';
> > 1040
> > 1041         dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);
> > 
> > Fake flexible arrays are deprecated, and should be replaced by
> > flexible-array members. So, replace one-element array with a
> > flexible-array member in `struct hfi_sfr`.
> > 
> > While there, also annotate array `data` with __counted_by() to prepare
> > for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> > array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> > 
> > This results in no differences in binary output.
> 
> Thanks for checking!

Sorry for shameless plug, a quick question: has any compiler implemented
support for counted_by() at this point?

