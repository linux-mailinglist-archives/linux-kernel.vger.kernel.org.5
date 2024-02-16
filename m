Return-Path: <linux-kernel+bounces-67967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB88E8573B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B4285725
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A8DF6B;
	Fri, 16 Feb 2024 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNbal+Cy"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFFC157;
	Fri, 16 Feb 2024 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049740; cv=none; b=R5JfmGkYsw0F+aVssNT6blfWCVumkayliY+LmDAdhSgmbb8LlAiztxZiy547Lth3LiGKWpKX1TFuNdpAkxT2S38owvbPeJxM8W8Val4rPx3Len91kGOZJP8OXSGZXvyXEqwoD5MbICiN3ZbtPizPcBHNC5J4qt7CyZQdapXOea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049740; c=relaxed/simple;
	bh=ARqY6mUTlN+X8PxUwy7uCqH8uqqNhJsDjkHBaAlCrWg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WvxUN1alD7ZNx3iyBQHBrHm5Z3NCHfTMBMBayUXQwoVJxHishy9ZDVEC/IhjsZVCEVgare6xWbANIadnNeNOfnurB13fgbRrnDLbEBVKbSuOEOHKW6D9M3qHmuxgfnVa3jsSpEPz7z875nuqfZfJwGpZ3EaOCu/XKKohR9z4h7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNbal+Cy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d8da50bffaso9134305ad.2;
        Thu, 15 Feb 2024 18:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708049738; x=1708654538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9cQ2zWbvweV7CQGRMU52GzC1urlxVK4rcMLJdR1GzA=;
        b=lNbal+CyeDDUYlEKf9rMokjNANeH38FGB8VmB4ZUeyAlxa6DQtWA0bJD3K4qZujVO3
         QixD9DXIfwmJr3dYxpw2CfWsbTfScFU0648kERxBpngvtZCRqsnTjBdNphuJEtr94ZY4
         iAKMrem8evxEE+AzS13qWXgj1w8UW/s+A8EuvLJbJ0AhmiGQhS0UYqQQ7d7P/lFdXADf
         kn+woiJ+0L+qh+f2125Dbb+AoWK5+9qtmcUJBum7JPjy0XYsS86NorfAuceu24XQVAWU
         QsRMeomBHkunmMIHE6ZkeAmayMWqbIfV7dQNE6K2puXcv6kdBGyGaZM+gbkDTftpac3Y
         AMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708049738; x=1708654538;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9cQ2zWbvweV7CQGRMU52GzC1urlxVK4rcMLJdR1GzA=;
        b=Y+vGScv+AWj325Ib+6WyrKX/RZWpG25QdaJ2DREVRnU7QkHtXqCMEpUJMwT3AsW0km
         TRU0oDVeUCbXBP97OpoTKUdoBWzCEjw4Nz+MXhyQfxM397qlQt1bSwPe67bHVUiNBrn7
         br/WbL3McMgiccwMeGhij+J5MPpbCUh09jnB6qMYNt4NKjwXAocb+Hb2WzDXD3sjviSk
         DZf0uuLbFkOiX+ehGxKlTSmQoZefQxq1mOrRSXCUQUQWPnPrH2aIh4XOuXMZymIgbduE
         62MZFc9HGprNGJuKrxv+HPNL8tQi8QGvBzIhe1fAjxn8TeaLGgclGg4iqrnkcAOKYxXn
         j7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv34whOALp2c3Iyz5l+BsfQZUyiyemOfGgMTD9N7iTj1xoEUnsKVNMOxHv3/06o9ZVijrtCOjA8FVF9iwoCsOD1eaPaN5N+kYHqO+HsXP9sN3kKu/fit1J5EEw1nwH0crWA6XN7g1q
X-Gm-Message-State: AOJu0Yx5Wr7gNeFylZ9J53pAIeCpMhtTvgjRFBdQtWKD2JBZrxj3QZMS
	LcvBvWLTKsFJoNAcAAnsJQeePMYRak6mv4siFT5VxSiJvnxERJIB
X-Google-Smtp-Source: AGHT+IE4zxgSO6UiWRnOuG7pVs+WaKgIdjfh/vLNYLlIqUCS60kR6/+U0omEw4lxbkXIGpqg7xbMyw==
X-Received: by 2002:a17:903:234a:b0:1d9:578:4582 with SMTP id c10-20020a170903234a00b001d905784582mr4620901plh.37.1708049737877;
        Thu, 15 Feb 2024 18:15:37 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y21-20020a170902e19500b001db4433ef95sm1913240pla.152.2024.02.15.18.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 18:15:37 -0800 (PST)
Message-ID: <fd73a8b4-c13d-4469-86ad-1ca6a0953c16@gmail.com>
Date: Fri, 16 Feb 2024 11:15:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: federico.vaga@vaga.pv.it
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240215214546.19947-1-federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc: it_IT: remove references to original documents
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20240215214546.19947-1-federico.vaga@vaga.pv.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 22:45:46 +0100, Federico Vaga wrote:
> A relatively recent improvement to the document building process added a
> functionality to point to documents in different languages. Hence, it is
> not necessary to add an explicit link to the main English page.

It might be true as far as htmldocs is concerned, but please remember
there are other targets such as latexdocs, epubdocs, etc., where the
translations extension has no effect.

That said, you are the maintainer of Italian pages.  I wouldn't complain
if you ignore the other targets and go forward.

Regards,
Akira

> 
> This patch removes those references
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>


