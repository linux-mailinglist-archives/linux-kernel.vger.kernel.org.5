Return-Path: <linux-kernel+bounces-141807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB58A23B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DAC1F214C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19556DDAD;
	Fri, 12 Apr 2024 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fTiPib+h"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04439134BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887818; cv=none; b=ckL1nwota8/k7CxK7gBKJFuWe85ZYPZ0MzKW3326GfucDctTXhaaKuAXMlCceheqye+tNkrNX1d1qlDhx1nnuQdC12b6nAWgAV6y2KpO62QgfgVJMuujPeGkdzLifXS5QSat77c/plR7aChoSiHF4w9dtk2crRamjGh4/nFFHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887818; c=relaxed/simple;
	bh=3byBbhHPbAbBuHjuvastDaMYVcOaFYFEWRQWWcNBJEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPKo7dBg+54fxVC4XlqojZryAnTDuX5u8xuXfvpdkEeBTM9xQ4vb7jd6tkdof7eQoy/v6h8y1NJCv1V99G9KxA+VTdcPGloT8dNOs0nITHUQ20rL7rLkzlUavmeb2WK0y5YdqBCcRgx3p2y3nIBfsjTIUngRTUJekVUrVNyCSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fTiPib+h; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a9df87e7bbso332704eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712887816; x=1713492616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3byBbhHPbAbBuHjuvastDaMYVcOaFYFEWRQWWcNBJEs=;
        b=fTiPib+hPpELBGl9mXBDX3GtzxsphGVGmZplXY5c60TQ5YwaTHjWIPUD9Zi66Kt3lB
         7EUU6013wMnUxFPPrW14B06w77hD8EclgIpmhhdPUFbFq32MG0W7fp0UTv1TP8pMs1iA
         vb8DJdVtoewMod9+w90f6OOs/OJahX6agucWrnZ/bMsXr4LhMjMJspjzVuj7pYR1fs4/
         6FTPaCuCYb42sDTDgcb2BeYqrp7RHm51wSJw3jrWf9RjQLxhcr8w/3YslbRXAyCN1pLU
         gYyms8lzPhWTT5LlOsBWolG/RWKZ2lR1I0ksEX+HvtmJnFhlKIL+HfNBDUPYt376pHvl
         3SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712887816; x=1713492616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3byBbhHPbAbBuHjuvastDaMYVcOaFYFEWRQWWcNBJEs=;
        b=gZ5I6TSnbAUIon8YrNnOWpdfkjPTfFoqDw88jPI7KL8a9LItVzBGc0qdOervtqfRnE
         m3HVYJHJQb40ViHNaanDFnt4OeoRTBpsHaI5CJEzIPjkSrZslkQ3fN8n8OyBye2l4vo4
         BUtoO+VrwfDOoVfyHu/E4F4teJyNvGAMuvsdDYWevdgMs53/Zdn6gxuRmtMJj+4g+VNf
         xzK3ibujvR3ZEH0vZ0Yf4WUFenvCUfX8LBU6ZVGKreD/65w77/2LypkRPhRwhFOfARQ5
         M9ZEZ6782/SCUUaV3yS6vHwWK5Kc3BmoQn4FFvDybdXZraoHutmv3X8zimT0YqGhOxvs
         cFHA==
X-Forwarded-Encrypted: i=1; AJvYcCXOu4bZKanmGlH1N76urfxW3LvD2VNcYXDit9TtJShMczCqd1Qnur5k1Xq9Or4OXSvxweMrsPJWnmHUZ6AmcN0hKsQtY8N4A5Nvrq+E
X-Gm-Message-State: AOJu0YyPlI9u9LkoexJ2gsDV+imvmVexg6f2wkz1+wR7ZXkTxGUwQB0d
	ntI8x7+o1Fci1fOT5I3ecm0zPaYgBq7n9JZijmxhEKcME0TnnA6fOAK4KMAJydU77ZKXdYYcnXD
	iebAjCJiFes6L7c6kh4PtT21sFRMGI3EY8sACVw==
X-Google-Smtp-Source: AGHT+IGlOlFyLP7nb72631wmeBnbeNqFrUTNa6xuGgqZC1KLH6e9hMuOyTmu/5EQbYJDgq3GFRyDSHVjJyECJ38qxLI=
X-Received: by 2002:a05:6870:390c:b0:233:4685:aea3 with SMTP id
 b12-20020a056870390c00b002334685aea3mr1355286oap.41.1712887816077; Thu, 11
 Apr 2024 19:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407123829.36474-1-cuiyunhui@bytedance.com> <ZhetojJewygmTf6N@bogus>
In-Reply-To: <ZhetojJewygmTf6N@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 12 Apr 2024 10:10:05 +0800
Message-ID: <CAEEQ3wkfHvH4jXNO5NRDf0Fc3xUkY64hp7BDBmgNVdcsmYy-kA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Thu, Apr 11, 2024 at 5:30=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Sun, Apr 07, 2024 at 08:38:28PM +0800, Yunhui Cui wrote:
> > When the type and level information of this_leaf cannot be obtained
> > from arch, cacheinfo is completely filled in with the content of PPTT.
> >
>
> Which platform is this ? Is this arm64 based or something else like RISC-=
V
> based ? That would help to understand some context here.
>

Thanks for your response, RISC-V currently has this requirement.
Please see: https://patchwork.kernel.org/project/linux-riscv/patch/20240407=
123829.36474-2-cuiyunhui@bytedance.com/

Thanks,
Yunhui

