Return-Path: <linux-kernel+bounces-80287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13105862CEB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD0F2831AD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B451B953;
	Sun, 25 Feb 2024 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbMcQ7Ii"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4551B947
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894018; cv=none; b=SQxoy9B5R9O17TupaN2vl87Qi6FRlVqE0IEz3idDctW/uqqNsBXzqCemHZUZhqoF6/CnH+WgY+hlw5he6bXoeEVtlLL7nntKhy8EF1HCs+F/m3wk+xep7oJrtE3uHbOyq2lRk/hHKOAjG2ClBG5FHj4n/nArvAVnJ9VqixCj8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894018; c=relaxed/simple;
	bh=sE7UpPpq14m6j1C5fjYJz6pL/gBGgixJwDk3zBLz1LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMo8ESBQkIt60ahvf0tWow7x6vUtVH7p6guWct5LuNCbPVZVdytoq4Eeh58SkuumZRDkknjb8F2ApHNNgTr/Rvp8v0Ix83yXnlXQAnjMZoM5/25Wa7Mei7qHhlJd8gfP6lNcWe9QXe7NOF9k0jbpEV+9qpM9KGZj9XWmXb2eIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbMcQ7Ii; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c72294e3d1so116536939f.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708894016; x=1709498816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fP0+4HWFw0qnQgXN16N53EqzsauNUwws4Q93UfRzHx8=;
        b=JbMcQ7Ii6vhGOHKqIk/6ZKZCvrQtQinhqyfUalCOBgLhp+xha6WiAYbgAxq2lbkjjh
         IYJqIxhKggDPDOn39oiBavH6Z2w0lmCt+Sb1ajpeAv58Rf6ihPvCSYu1nD5aRS4EfmFf
         XqLEFX6nSiDMQzAmIz5a7MNbllY3Zbhx0BPv3+ZGSc255EREFlYboJ3SbThSEOXD5yZa
         0OG7Vgd53BGzDY2oOohzvBTmNGdn3N79Ou8SqO5/55oQyfb81u70nN7oMjukG7Av220R
         aDBdFUh3fQ5W2Lde566NDygA3Iw5G3l+/sQgpeoCFTa8H/Zp7ypqk5hcSrgRaG8uE72I
         +pIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708894016; x=1709498816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fP0+4HWFw0qnQgXN16N53EqzsauNUwws4Q93UfRzHx8=;
        b=hhjZ4sWJ59eQQCbPqOLqPIynp055QNvKu91G3Gldc9X8bOIJ9evDn22FBZxVPVb0xY
         rjEav5M6RALpcrZLzPMurRNloNv2+v/dye/0GjUmicc4No7XzmVvCtO/x1mzUN8EiepC
         XTb789iD4hFB25/mnZ0tPrqoDdpOBL5iGRknZYvF8Jktf1LtcsLq656DwlidsOV0Mswj
         0Y8DPnwpiC/4U1g5YzaEvqRYd9IIirMLMP2GXutcnhNjpqhjDXyQpNnHPNU4HtDWEsqG
         nKO2CwRR/CEl7530Fz5MAK30NwSS4Y7811ol+uc8bHpgJnetIhQOxc7vgihcsbQDgyPd
         rCLA==
X-Forwarded-Encrypted: i=1; AJvYcCV/VwPi07HRC9kuEQ6X0zFJqqLmKToEEMXe1+pDbE9RTD3rqfZUwITerXN5W0ZV45MHn3pHiaoAfEfqXtWJxm7KTPhcFCkpoEHlEif7
X-Gm-Message-State: AOJu0YxwAAOQw/Z4ei3zhY5RsrSPFgy7SIhLa6Sqn0CbYY8P/4r7RgFp
	1drJk5eWRmMFg9fAyuEUMPYhZ9HM7x28IAokik+eB36hsEmn+G5psLWJ7ZvfV/wzBsL/+BqxQOm
	Ko9+Cpqadntszzt/pOyx8fv5aA6tCx12f1gi5/PPKfsi45cPjxLw=
X-Google-Smtp-Source: AGHT+IH30JucjSV92EMaK6FP3kuwTYaUFcc6+QVaz4blJzc7lhZK3wG5byZhUyFYLDGqCziSm3HL8i5G+2N6h2Bqk2I=
X-Received: by 2002:a05:6602:2c86:b0:7c7:97e5:48ad with SMTP id
 i6-20020a0566022c8600b007c797e548admr8177997iow.16.1708894016207; Sun, 25 Feb
 2024 12:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225202545.59113-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240225202545.59113-1-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 25 Feb 2024 22:46:45 +0200
Message-ID: <CAA8EJppVN72sfz_rjn2K4Za+nBUva3KqP4RRaus3Cs3U+UZQiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: drop unused kerneldoc struct
 geni_wrapper param
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Chris Lew <quic_clew@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 22:25, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Drop description of non-existing 'struct geni_wrapper' member:
>
>   qcom-geni-se.c:99: warning: Excess struct member 'to_core' description in 'geni_wrapper'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

