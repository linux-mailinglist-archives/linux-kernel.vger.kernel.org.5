Return-Path: <linux-kernel+bounces-166333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E48B9923
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C42D285FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3460BBF;
	Thu,  2 May 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAJdWk1l"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337915F874;
	Thu,  2 May 2024 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646395; cv=none; b=LIZ1KuvbkIz63T7D7N/Ezq0ZMqc6N8104AQ9dMi8my/c8yDu0drHqBD9v37rD5NkrMbMPoUqvSz9A7/z7GYwZ8FQQSY6dESa5Ota6PGTZ3Je5qec1VBdMgBFecg/FjREntKMJSzdZg8mOA/YhRGfORbv3zBS5GL+xc8tw7L+QD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646395; c=relaxed/simple;
	bh=t5g00IGuHelGRldg6cVwXrUENnvsckikhiMzyAUt2X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Acud2VEX2ZoMqDUpavpz4IZjQE7+WegJKFRF/bJjJOOFy91EJMi3Px8rVtiZeD4oa+8WzRJavO4o1A/jzKMTm6grO/vROqulNUhykUfbQDAd824t8OhyoBgRjXd2KYpKIrOf928glZpLW9TFdowbbqY7sACNQnN2IkJv6eJLwmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAJdWk1l; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so76981685ad.1;
        Thu, 02 May 2024 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714646393; x=1715251193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t4GOnPYyyWwnP1/8TVXg36vGNLqaRGbyUqOh/xHsbXg=;
        b=IAJdWk1lv35dZEdIhCbTqm6TNz5VVezmq/fURr7yT9vYC0+qzqxJhpfcoZujOyhLgf
         FiYT6WYD7/IbS6pTwLVZQw/wGR5jr4wN3uem61TDcNCMhxqBwd7zPLTu9XPLFfAZn1Vp
         bfFC+mSv/jz67/qzAvZajs6CncmvVbfMBAw486jhrsYze/Rv62RzercXHxusaanVQjqt
         5Ex2LpYXWSagirCyebCkhoSTazyxDfUtNLk2DzE6vE9Q//8Wz8507bnVvfMFEcyXodRr
         YFtboxgBJPtC8gsZI8RLBJineu2L1f1taFuZ8Qm50TN0EutAzVc2HmCrOuOkJ87EGhcb
         LjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714646393; x=1715251193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4GOnPYyyWwnP1/8TVXg36vGNLqaRGbyUqOh/xHsbXg=;
        b=RGwf4cCBpPuvrDWGdM63RDcsr/aKFI0htbAax+3pZE07yEeLn3qP467qQvsMksYkEX
         G3MED5A/H3zVpyRJ09NQaU2Bigbkg85oSERV22k4+3rO/ZkBDtMHm/8XwVSN/751Fj60
         hO6s41yaW3bwCyI2Cb8xV4yIUos3X8Vk5v8APWHSMbbo+K8r0KoJiGUJLgU8EOvDdVYu
         LC2Be9bHNpZ2B+TALve9HrhnEb2v7dA2xbHNopWtwyhikZpnYZ0Ca1HNafJZomB8dZei
         D+uGl5aQb8Q53kO0x/UuyBg408CcYnhijL/6R65UDMD83jHhePKOgmz/ffxBiZCmB19h
         kuKA==
X-Forwarded-Encrypted: i=1; AJvYcCUrGaHOheKv3YwqmiuCXzOmvjgMLK4m3txqOtvMe6YwJMJJ0NUtvh7v/Jwy0JB5WWQuRM9t5epCS47B1pcROybGoTu0kZFTTg1PAkMH
X-Gm-Message-State: AOJu0YzWOwygwX2jb1bkQV6ngFEIC5aAQlrI2xGxYJZiY/9Ia/UCtkXS
	d8y2Wbh3EljLgJatZy+BcwXhlwVhlag47BxTUNzBp58Wt/Dnx2hGqnNvpw==
X-Google-Smtp-Source: AGHT+IFqR9Gkj344QonOI/YaQd5ZGgXVxI22fmuDMyiLr1wujioqvrX9hCDlBQudXht6mXr5poqAMw==
X-Received: by 2002:a17:90a:d446:b0:2b2:af15:f948 with SMTP id cz6-20020a17090ad44600b002b2af15f948mr5891627pjb.38.1714646393420;
        Thu, 02 May 2024 03:39:53 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t22-20020a17090a5d9600b002b16d9ab430sm879121pji.3.2024.05.02.03.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 03:39:53 -0700 (PDT)
Message-ID: <640114d2-5780-48c3-a294-c0eba230f984@gmail.com>
Date: Thu, 2 May 2024 19:39:48 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Sphinx error fixed for inline literal end-string by
 changing $type_constant2 in kernel-doc script to include "*" unicode
 character in highlights_rst.
To: Utkarsh Tripathi <utripathi2002@gmail.com>, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, Akira Yokosawa <akiyks@gmail.com>
References: <b9e4bedb-6678-42ed-9ac1-c10179be5b69@gmail.com>
 <20240501175730.23326-1-utripathi2002@gmail.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20240501175730.23326-1-utripathi2002@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Utkarsh,

First of all, thank you for taking the time!

Besides Jon's comments on the summary and changelog, please find my
suggestion below.

On Wed,  1 May 2024 23:27:30 +0530, Utkarsh Tripathi wrote:
> The kernel-doc script uses the $type_constant2 variable to match
> expressions used to find embedded type information. The current
> implementation of $type_constant2 does not include the "*" unicode
> character, which is used to highlight inline literals in the
> documentation. This causes a Sphinx error when the inline literal
> end-string is used in the documentation.

I'm afraid your description of what is wrong is not clear enough ...
Let me talk using some examples.

Current kernel-doc (script) conversion to reST:

    %WQ_* -->  ``WQ_``*

Against which Sphinx complains:

    WARNING: Inline literal start-string without end-string.

, because ``* is not recognized as end-string (of inline literal).

With your change applied, conversion to reST becomes:

    %WQ_* --> ``WQ_*``

, and it is a proper inline literal.

Please update the changelog accordingly.

This is not urgent at all.  Please take your time and read through
Documentation/process/submitting-patches.rst (among others) before
submitting v3.

Feel free to add (in v3):

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

    Thanks, Akira


