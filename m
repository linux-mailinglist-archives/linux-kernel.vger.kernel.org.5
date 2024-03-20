Return-Path: <linux-kernel+bounces-108401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D8880A04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1448A1C221BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC64101F1;
	Wed, 20 Mar 2024 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="OmCSeYdF"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B34F9E8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710903469; cv=none; b=JVEdX+e+qGgK63JY182S4UeGqip/PVfNykMZ+aYkI4lg5FCB8Xg6e5hymCOpX0x/LRArtdcdq82NiCm/IMw+us9DJ9vy/m6IbiYfzYpfJ3AjQa3JtRrEJKaOjHGKk6daYt8Rcrih/gJDdRjvL+fhZFFYyC08oZoySsTKXjKC7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710903469; c=relaxed/simple;
	bh=At7Q5UWNlzmJw3agLnxP7eQBtICERWJET8Wu0oIP44M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjdaVTopg+C/8tRJs+1Ouz7PLODiUNpEIapdsJ0z+k8V+flqUPJLyjtcvVTGw7XYAKC9wHvcYttdJJDT6kRWCTYskdNqTC5oMy70rEyuAT5Z75j2xj5VPS8FiTUZrxQ2w67MD9TBOZrO+Afz0L2LaJtdCDXMhwcKUGaaw9phzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=OmCSeYdF; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-430a25ed4e7so38615791cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1710903464; x=1711508264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At7Q5UWNlzmJw3agLnxP7eQBtICERWJET8Wu0oIP44M=;
        b=OmCSeYdFj0Garxw3q8xDQUSmqlvCan1UNpDiMYF+3xEMAf9IvlAnbPNP7isKfNWkLl
         9yNuuwRtWNz9brGjrsUioTOEoXOfIija170Gf18tep0uUagUDf+RMlo7bD/Hsu/fZje2
         KERNgpKkKw+oVsKTvo+YJiLY1zE90kR2XEljTBATysQCrpzV5U+pHAbtFlm/zEazq+kJ
         v0O4YTxkMtObCwobDt+KtoR9SlNohp7CrvaUoAAdq8VetNGNh2OaK3LlDofYAITdLgNg
         P7juMQHFK5BZyyj/JjRMnlJyY3Q168WeQQ5nf/opXejYYG2wp6NjieY3VurbIjfbTJ0l
         XIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710903464; x=1711508264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At7Q5UWNlzmJw3agLnxP7eQBtICERWJET8Wu0oIP44M=;
        b=YdZkBt+o7ctk5qlLEAaDgKeAZVIaH25ybHd1nEP4i8JhLp6Qv6uPFigESeYEe+6blE
         dh0dZWaH4qUmy9SqcBeBKugclO1fZhlB5LGMhUm950fW3mBuvGdDyZw+bgelT6hi6oF1
         VOJrDTPGwWiotT8836MYtiymu7BcADQDv//T6pvKjOEwZSwJ2qmvpI3TzHsrdAsmJYjA
         H05tLIroTnQpT6++MPVfxmDGTNZz12F/6OR1jk21e/OPy2h6y0apRoa97ArlQ+J7jinf
         0C1OHVjyDFy/IwdbzudNYbatUncn0HuWHcA8RgtLH1jdmhFKdoRdZG2mJT166/pXbHsg
         Jziw==
X-Forwarded-Encrypted: i=1; AJvYcCXbvUPt/I1Ej9q1DvesIZD2G+itD7hLuzfABuCkFMDzr2BqptjCMdHzel18KtmWsxKILvZtATAbk8b3vOHEKUK5rs3TMHqf/smhmign
X-Gm-Message-State: AOJu0YzE2Fnx5XiXhFTvjpH5ByzONmD3za/f31VIUVee/hFna3/hxlx9
	pfmraZDWntXvHwubV/d3IqQw0kgfh/t2zOBiLtzplKUSZKcIQKZ8UigqGNVS1w==
X-Google-Smtp-Source: AGHT+IHXbQg6KOoTI6Pi7Je6gBH1UdVnDzLQPMagb46MmWK0VYDd/gNgw6HAwCyKwyMd6lsfXlY2uQ==
X-Received: by 2002:a05:622a:390:b0:42f:2048:a0f2 with SMTP id j16-20020a05622a039000b0042f2048a0f2mr19951137qtx.11.1710903464366;
        Tue, 19 Mar 2024 19:57:44 -0700 (PDT)
Received: from localhost (pool-74-98-221-57.pitbpa.fios.verizon.net. [74.98.221.57])
        by smtp.gmail.com with UTF8SMTPSA id i13-20020a05622a08cd00b00430eecd29c5sm1156049qte.63.2024.03.19.19.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:57:44 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: kaiyang2@cs.cmu.edu
Cc: dskarlat@cs.cmu.edu,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ziy@nvidia.com
Subject: Re: [RFC PATCH 0/7] mm: providing ample physical memory contiguity by confining unmovable allocations 
Date: Wed, 20 Mar 2024 02:57:22 +0000
Message-Id: <20240320025722.204254-1-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
References: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Adding the missing citations.

[1]: https://dl.acm.org/doi/pdf/10.1145/3579371.3589079
[2]: https://www.usenix.org/conference/osdi21/presentation/hunter
[3]: https://lore.kernel.org/lkml/20230418191313.268131-1-hannes@cmpxchg.org/
[4]: https://lore.kernel.org/linux-mm/20240229183436.4110845-1-yuzhao@google.com/
[5]: https://lore.kernel.org/linux-mm/20200902180628.4052244-1-zi.yan@sent.com/

Best,
Kaiyang Zhao

