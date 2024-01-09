Return-Path: <linux-kernel+bounces-20894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A9C828711
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F961C24407
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5E839861;
	Tue,  9 Jan 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MaFq5Q9P"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D743985B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5988e55ede0so14546eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 05:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704806917; x=1705411717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZGVYLyRRIrus7zfeKpJFG5CwZYvfhfc/PZIzLzRZJk=;
        b=MaFq5Q9PGJQKlpLgbBduZroL9o3s/qhlVWp9RhhmhQnwWaqMjv8MwJEua4oynI9C8s
         Utin1/yER8+JCwasNh+kHJnI0xq6rbsgr8P3CUil+VbQ5aqGlCNbXcnI9MaON0I3z43a
         e/k3wRjqInCcRL9nBIMwMIM44oxGsINUBKJWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704806917; x=1705411717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZGVYLyRRIrus7zfeKpJFG5CwZYvfhfc/PZIzLzRZJk=;
        b=l3hhNVruWXeBxM+S3AlisTyq68VcO5XqJxc/WeDLMTjr8Zjfmdj7HFEZfixMnpAHLe
         CjcZ3Y34IC4Z5uULnCEL8EnLU8GR/JZZ3J13K2Xzio4pECErdXqEDHK55pyjHLusC90V
         TD2gDIHpLY6yZWYjcJlZkFrgxTY05MP9ClfgFqEirjnuxQ2zO4p9JlJa8+jkCkTNnhko
         oZFJofb3sIOebAuHyNldK7LgswE0XJMiuSe91JmH9BQNwcEDfyL9SmAxrdMZmaQsvPsI
         pmCn+XYsrjkOg6xvMbyeVwgMiNz16P4+D5g2tYXsJmdHlMmRV/koJTB2q/0Derd++wt6
         3qVQ==
X-Gm-Message-State: AOJu0YyXnFyqSLvxMxZrNbR74GMP+9hNFwRHk5ojVeIyonjJ0uRl0CWa
	2cdug/4G84KpkoWoRlqQliNyPOI7us3N
X-Google-Smtp-Source: AGHT+IGJIXOpJ/8M26Z3KnZWKvxWI8FZxasEcSOFV/OYezC88V7VqCVJrWO+cgwJQBEcfLxIrGRh2Q==
X-Received: by 2002:a05:6358:891:b0:175:97b6:af58 with SMTP id m17-20020a056358089100b0017597b6af58mr2721311rwj.55.1704806917345;
        Tue, 09 Jan 2024 05:28:37 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id l14-20020a63f30e000000b005cdc9b091b7sm1621561pgh.53.2024.01.09.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 05:28:36 -0800 (PST)
Date: Tue, 9 Jan 2024 22:28:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
Message-ID: <20240109132831.GD1012017@google.com>
References: <ZSRJfRdUXQOzagKr@work>
 <202310091252.660CFA9@keescook>
 <20240109124026.GA1012017@google.com>
 <b8686724-9351-4f40-a587-fcbba5b0eb14@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8686724-9351-4f40-a587-fcbba5b0eb14@embeddedor.com>

On (24/01/09 07:17), Gustavo A. R. Silva wrote:
> 
> > Sorry for shameless plug, a quick question: has any compiler implemented
> > support for counted_by() at this point?
> > 
> 
> Not yet. And at least for GCC, it's expected to be released in v15.

I see. Thank you.

I got confused by include/linux/compiler_attributes.h comment, as I'm on
clang-18 currently, seems that we need to bump min compilers version.
Oh, and clang link 404-s on me. I'll send a quick patch, I guess.

