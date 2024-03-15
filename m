Return-Path: <linux-kernel+bounces-104714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9C187D2AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D781C21B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FAE4D9FE;
	Fri, 15 Mar 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="rUsIq+aW"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80112E71
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523277; cv=none; b=d5+pf44Ul8Lyx1Q2woPb/9GNee/cPYbd7Z2AuJYHEqcTXJk3qIKv1BQZfLhgNKfl285SnkBEnDokFVYZbby0deRC0P06MMhAsjUSYUagBAN7qo5rx2SVllSnpeZbpZCLjonXnUfnGHPgb5/rA4B7zYiggckSo3pGHrX4Sqm7mHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523277; c=relaxed/simple;
	bh=lZGIfzqc2Drzycj6AUKwKqZXUp1iJGO6D44k85fp6lc=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=hiVJN3mDgulu+ZSxw6kz8+9aD3WqJkMcq3mh1VHfOLU0LAf7IbfwGxYDBvEem60zpIXvEfhAJT1umEE3VUiZ4a102jpxOV34404e3fS6TL4u4zTR5JiAg8OjZUKCOc87ITvDpHkUU9ZEMOUP0y/AaBc73L/IbHUmQ4bY3c9UoA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=rUsIq+aW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so1182346b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1710523275; x=1711128075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4Uu/E9gE0652T6hoQJRicZh5VPvjIkh0J3KEQ5/ek4=;
        b=rUsIq+aWDlp9HkYbGp89cDOS5Q6V9Bsi+5LKAOXST70EmooYPJ8cKvqL0+R45mLzSG
         lpN2Rx4C6zSX6px0hlG50f0J8UFldBDa6AVpl+RBjdCs2SG4kQWmHaxBuocRYuzlnFc3
         TT/u0jCSJ5/JANc/zVpPV93k6Zo6nDkfYy0o2xW6s8+5v1ykAYtvlHDwrFOphaK/V5SQ
         7OFMbRQ2553MA088lD15/DALfNoPbLKKO97k3MZnlJ9AAJOREwvAkDt5aaIqymyG1rs9
         gVegLdwty6WMkVL+tuJ/oaFxVwBMeGDI2l8U/6YUkCwqx3FryusCinDtEpf1aXOrYq6X
         /QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523275; x=1711128075;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4Uu/E9gE0652T6hoQJRicZh5VPvjIkh0J3KEQ5/ek4=;
        b=iB5lHKfISHzuf4dG727slv9/VbIwLfEBXqryKJOAR8IJI2dZliNn69HFHMzEsSTJgN
         9gqQdZM532zd04tNkFBRWHgUz0T2u1iuPUXGUDLHQDh0VUJg0gPv//HENuQCpsVf/GH/
         yPo7eD1V8ucVCTNiprvbaw9KxJ+YAhF4rKFSU+l/MsVMv1XDsK4+bO9ncSNptwUwAgW2
         ZYpc0jaXEfy9u95RroJqKCohe14pAuSWYpQW0HBQcUqTJCWEaF9uv9SLAkLUHQWSNS3G
         oxFjasZ9BmDo5tVc/HBwoemzpTeVHpPDk1+hNOpao8yZ1404sRbtp5Gvyx079FKu6eaD
         maNA==
X-Forwarded-Encrypted: i=1; AJvYcCWi1EYPjzGPXaxFUXPZAEPKLGqpD/jQ6Mh5+u0JUOVw99NGR6kAclPbLtpqccXwo9waOCzep0q+Hq9XfN2JkaXXy6RCwlF0g7qbQsID
X-Gm-Message-State: AOJu0YxgSGHvXCVHDXl220Xss16hoIbRGiL47bB62mlDQsnnGAhUm/AU
	T8d851XGISpecoKUytC70aRpvbxpDBtRCJ8F9z6RrJvWIldHpnBUYuvzCMjcOxc=
X-Google-Smtp-Source: AGHT+IFobowEw/BZzPFUGcWVFl2f0Ay+g8tIGVtL6ZeOGfHYkRhGF70dEpXmyMZCMSlq5eClBe2ngg==
X-Received: by 2002:a05:6a00:b52:b0:6e5:d88:a73e with SMTP id p18-20020a056a000b5200b006e50d88a73emr6658033pfo.9.1710523274903;
        Fri, 15 Mar 2024 10:21:14 -0700 (PDT)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78712000000b006e6be006637sm3614761pfo.135.2024.03.15.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:21:14 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:21:14 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Mar 2024 10:18:57 PDT (-0700)
Subject:     Re: [PATCH v3 1/4] dt-bindings: reset: sophgo: support SG2042
In-Reply-To: <MA0P287MB282221F8E750206EA615B3CEFE282@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
CC: unicornxw@gmail.com, inochiama@outlook.com, arnd@kernel.org,
  aou@eecs.berkeley.edu, chao.wei@sophgo.com, Conor Dooley <conor@kernel.org>,
  krzysztof.kozlowski+dt@linaro.org, Paul Walmsley <paul.walmsley@sifive.com>, p.zabel@pengutronix.de,
  robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
  jszhang@kernel.org, krzysztof.kozlowski@linaro.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: unicorn_wang@outlook.com
Message-ID: <mhng-76918908-fb82-4312-9320-959318b98b5f@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 14 Mar 2024 17:15:11 PDT (-0700), unicorn_wang@outlook.com wrote:
>
> On 2024/3/14 23:17, Palmer Dabbelt wrote:
>> On Mon, 29 Jan 2024 17:49:45 PST (-0800), unicornxw@gmail.com wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> Add bindings for the reset generator on the SOPHGO SG2042 RISC-V SoC.
>>>
>>>
> [...]
>>
>> This is now
>>
>> Fixes: 1ce7587e507e ("riscv: dts: add reset generator for Sophgo
>> SG2042 SoC")
>>
>> which landed in Linus' tree.  Looks like that went up via Inochi and
>> Arnd.  I don't have that in my for-next yet, so I'm just stashing away
>> this patch for my tester.
>>
>> I'm happy to pick this up if folks want, but it'll probably be cleaner
>> somewhere else.
>
> Hi, Palmer,
>
> I see Arnd has prepared a tag
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/tag/?h=soc-late-6.9
> which contains the bindings part changes for sg2042 reset driver.
>
> Let's wait for Arnd to submit, although I haven't seen this in Linus's
> tree and not sure if Arnd have submitted this.

OK, sounds good.  I realized I dropped the ball on a fix, so I'm not 
sending a PR this morning either way (I hadn't picked this up yet, 
though, so shouldn't make much of a difference).

I'll just leave this in my not-for-next until it gets sorted out.

Thanks!

>
> Thanks,
>
> Chen

