Return-Path: <linux-kernel+bounces-47373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07C2844CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37CF1C22B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EAD405FB;
	Wed, 31 Jan 2024 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhgnv3KH"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171C3B195
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743543; cv=none; b=hxTfHLXrqLG4ec2t7UiyEdxi0gFUmTd7uOwVCfUbEcQEtCUvBj70Ayx5oBumFLQH6eol8u+RNkCdYckgqHo3Tomn8qbVJCspkC7U+W1CuMRK8llLT7r3C4DFojsqNEcSnD9zThVLzO9prrH4ht1kgn5xhcRfsYT2Y3CntPg1QCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743543; c=relaxed/simple;
	bh=SRM+ZkTQopoKjEIsOT0GRbY/yEckJ1SCXR2I6jeUaqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwDetnutfxAaESY/j7H/bEJmSNI9LvYQSgKGXC+yGth5ITNhb35BeIbZDB3V2DsUC4FVuKT0hYquHB4R1rfmKtYLUbM1kp4iBstXaPV1UWVD4nkdyifZ7NFfE142P+bjhk5YAQyE7PbUs4UpvrtaKpCm5XYDyGRGB/vMAoWwsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mhgnv3KH; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bed8faf6ebso13621639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706743541; x=1707348341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRM+ZkTQopoKjEIsOT0GRbY/yEckJ1SCXR2I6jeUaqk=;
        b=Mhgnv3KHFMLUVgP2YJxrdiiuA0BPCnQzQkgKndiJWhSHTwmdlZaWvMTX/Y/+rYoVSl
         DntqYZvFvusNXX1YPzz/bG3d4lDYadcJhgqFto1uGO8hPXjWqUR8TDp4p+9/G3QQXkbo
         cIsGk76Epok0nOP0LDR1jOBnyKwrNmasV1YkhYDgBJDcGwziAdtNnsGgbU56vomawlem
         C7Yjh95uj+bOUlcCvCAJqqj/qYEjB4b7yN+jN/+Pv6yJZiyQg+SpUIIUpk6LYDi4OZu4
         kxBYRpXTLGEcMM3CdlN4js3sJ305e3HJm21cVbzLCC10/AwaZbWV8kgjt/NygKBwyVhK
         IOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743541; x=1707348341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRM+ZkTQopoKjEIsOT0GRbY/yEckJ1SCXR2I6jeUaqk=;
        b=HhjQ7wsPiMHkYmMO64YxC8s9H1WJ9NignKZqYIIbc212gXXtsqJi6kidwLjzrhlKUR
         HpIE2a1C/FCnqvMEWJY6i4TWFxs2m05C6+2EjexhiyDEzMa6IDhCdFq5AYjFgq6mJ/1x
         xMaa9zkqBC7ZZp8OpqUJGEhrUsGPEntlb1q+8e0z1h1OmS+63fLG4Ekr2o92Gw5X20kA
         iS1lwpMz2PDE27pI8zI93pxJ7kPsDKITDeRf5iVM+WqqMiCCKiD6RKRNl1QXfE7aswkB
         ui2pWGEM1Mh16FP1wkLgF8nrk7yScx0+ofFG2p7RF3ik3x8BEqo4TqhGsTlLxIL/suzg
         sGRw==
X-Gm-Message-State: AOJu0Yz0LrZU+8U+3zB0ZhVvHsE3CtazSXqCzgtPWclD+yiNIL1RGy8B
	cNTIJ5Pb+zPIBqiXVBkpcJOD9yNZix2/lQnfo0k1cfYten4v0nHv+3uvbQxJhFLsALDeZvs2GUU
	0P09VuZB/vYTCKNwOJxMtY2Fph5c=
X-Google-Smtp-Source: AGHT+IHHB5rKGYSU3G+AkhflStdCFi9mNkjtblISqCLN96KfF2VhLpJm1Wz6sWJ9EK+jYXFhZxvDRVA+RGKu7canjQA=
X-Received: by 2002:a05:6602:3143:b0:7c0:26d5:8a68 with SMTP id
 m3-20020a056602314300b007c026d58a68mr2803806ioy.8.1706743540796; Wed, 31 Jan
 2024 15:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-18-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-18-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 31 Jan 2024 15:25:30 -0800
Message-ID: <CAKEwX=Mh7_iTUesMH_tpRMCJtmjFHsWS_h89XLyk80=T6j40=w@mail.gmail.com>
Subject: Re: [PATCH 17/20] mm: zswap: function ordering: compress & decompress functions
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Writeback needs to decompress. Move the (de)compression API above what
> will be the consolidated shrinking/writeback code.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

