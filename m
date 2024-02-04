Return-Path: <linux-kernel+bounces-51379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC1848AA1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590B61F24894
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407617F7;
	Sun,  4 Feb 2024 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEuAxbF7"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA6A92D;
	Sun,  4 Feb 2024 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013218; cv=none; b=ZK8Iju0PkMwA9qCV+0JMpllclJWoSTMGvKD5m8U4GpOie6hAavBUFsMJaChzjwrfkanWB4BUuQaazP9U5eNIYqNT+V4mZypkNnYDgbXNkBNRjfuZDepQRjuTwRGc8vslbMobffhH7+94kfxdm7riQVmKF1N9GRGeGvGek8SjKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013218; c=relaxed/simple;
	bh=RNZszhUT+/uT5RZG8XHRUQyhEcAG02BRiswwS8Rwglg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIvFjrAzFLjOauLWRcCeCbt7w+itngStma4iYvP8iVXp1+YdutyWA4q6edTwmPRwlkfJnqeJZrGSMQFnsHVA5zQ+mRjFGi0K3aTuJBhSa8rnRvcx9kG0ziGiezybzdofrRw6J4LaHQ0bUa+cK87mDtDwsEvhlP0gtpvImrQCdn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEuAxbF7; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59a58ef4a04so1766851eaf.2;
        Sat, 03 Feb 2024 18:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707013216; x=1707618016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNZszhUT+/uT5RZG8XHRUQyhEcAG02BRiswwS8Rwglg=;
        b=dEuAxbF7kI4RhR4+C+NuJ3Qm1xiv0hHE0ZpTH52mz55TuVkLIhVM4zvmem0yjiNJ6n
         iYdwzRu6eAuqyzp4TY8kTuH1Xfc8P2HuVdHXNG6sDup6Ca+spcLhN8y+YEMHMt6tak3Y
         jgSRW5RflmAMu2B44f6FpccfjYJxY4kIgT0D1Vy5ZT7zkyvTytrI1J4WKOOn1OBu60Fe
         Qd9S+9Y8IAUyx7ku7bqVwEQYcr3Oxrf1sBCFqGQO9EYB9sWTeZcQTsxFVL+Dv5Dpn8Wu
         LuPIhxQcu4FTk9O0U6+/NEYyC7E84z92zQpPaWJlbrg5zy/jZ2lA4ngsEVLGX3OfHQSR
         uMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707013216; x=1707618016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNZszhUT+/uT5RZG8XHRUQyhEcAG02BRiswwS8Rwglg=;
        b=RYzJzp2+alI5jOqWL3P9uTpDJ2reph+qyQ1fUi7m0QZwWfdjYxpwsuviDzWE0A0Nfn
         IynrL2wPTXwOo5n3UAqWvTyMs62vQQndgU3J3MgqC5RKWXb24MwCAtS2rbhmA0TYshSJ
         +C/6cJlLKR3Eo3JWNNKzmJyh32IZYOrfQH5D+JjHnxQ+wR7likFkvBXhhOPu8y3DlB9N
         OaWQpVIEymcuSpIHq5M3RyHe3LhFArQn5aMs+lBcCdzRT7VPG1Knzz/jFl8wlBWng+SN
         1B3d9aO1P6ocfECvJuTCNmrLRRacKQNmIK4LiTPHadULPS4iTD0QCxzyQO5Jo4rMoD1f
         4ZRA==
X-Gm-Message-State: AOJu0YyWcZjef8ekzdYWhEH8eJ4lVMUDMNlZGMsT/UkQj/IvxwVVs5G3
	8nlINqUq8eiHLqH5WJXs72slBOqQl6puRkIjo43iGLDCD369xkCx/fAUMnCKLxfIBZx8wARB08I
	XwfSugQr7yZ+mvWDp/N49eIrb8lo=
X-Google-Smtp-Source: AGHT+IE6uaJ4j4gXd0PdBc9PG5H9mjDej9XZyb/pAfNrHduzabrLT5oY7pCGhTfjHAPn8Fph8jQ1h05Sj4tEV2i8Lr8=
X-Received: by 2002:a05:6358:71d:b0:178:a197:15e with SMTP id
 e29-20020a056358071d00b00178a197015emr6990879rwj.32.1707013215695; Sat, 03
 Feb 2024 18:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-4-tj@kernel.org>
 <ZbxCHZzA6Uiw2Eq_@slm.duckdns.org>
In-Reply-To: <ZbxCHZzA6Uiw2Eq_@slm.duckdns.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Sun, 4 Feb 2024 10:20:04 +0800
Message-ID: <CAJhGHyBUGmarSSuGpiBOWvVZ4RW5f7_rb2uJZ7_gZCGBp+rpDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] workqueue: Implement BH workqueues to eventually
 replace tasklets
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 9:15=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

Hello, Tejun

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thanks
Lai

