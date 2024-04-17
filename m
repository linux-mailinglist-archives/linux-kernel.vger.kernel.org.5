Return-Path: <linux-kernel+bounces-148656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A28A85A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941DE1F245F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF43F1411DE;
	Wed, 17 Apr 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+bhTTV7"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4113F444;
	Wed, 17 Apr 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363031; cv=none; b=MPkI+6oGtwyvdKQ6KuJhLBBR7G3NIVdIyUbWKpxFR8MPQ6xWjmSIKkLmafbuGiDXBV3QR2QadmWo5tu3TSOVM2gh+GOtTHqkUUOfZC47ATSvQE37VD2rv/NU3vml8Jb65DrTjs6MZyCuARyG7Z64Y3C1oEc+0TdAcB7nctjixI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363031; c=relaxed/simple;
	bh=1ky6nz6zC6wRtX/+5nKMyd9TVrDZLxBTuAdaISU8M8w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FK8bhrnCCzrMQbWs1jXcV5IHQBpY51imkHDCUSz3uhSFQTy5IQtQGqfz5wdBH5wwh1Zxyp9BzExNLH+MJ0o+kVLfRKda97KiBQhmc6iq5+zIxecT8fqciuUgIqSh2m76es2fyc5vKtCyM2EMv6NWotWQznTZeYizJ+aO5Ipy9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+bhTTV7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2da888330b1so46298651fa.1;
        Wed, 17 Apr 2024 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713363024; x=1713967824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALd+u4/BgGL4HYxmgttR60Ac7kHsW9LtST5jypjzros=;
        b=a+bhTTV7fewph4/ThnUgQHG/U8g0kz1iKdmRB0ebpySfAdrGvReeQRgUNndd1VHnGh
         Os8Gz3yX87b6Z//9OiEkufhpXfD/e+gnF2oAun7SGCZr4Fi8YV/aLqP+weatVlBpSaje
         zjCig8BFc3xKmdtCDpJ0rDGOYaho5ystAU3CupWucd7TSz1FWle/yzqg2ISJUu/TFgqA
         PfN1dJFNzET4PESNbqXmQ32GF7RF6bJrzWcCxkRE0Us0dlG0xwiXcpZnFCQRz/3QLq3d
         ARymMzbdLnEd7LNjXkjkPqsV5q3xayqk6FWE/X1K2Rvx2yLpgPDQ/NOwIkm8QRDzuWnu
         8lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713363024; x=1713967824;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALd+u4/BgGL4HYxmgttR60Ac7kHsW9LtST5jypjzros=;
        b=TPjQ+6pQr1u8RECUfllWosdqupncXfg+Exz3NP0QWZidv3FkKpChuQPn4oYmbBYPjz
         +ubLOPWH0acPmITbSfhv/pfjVtWKdJ+wk6bvhFwL5nw67csmChsL4rcwI7VALyD8Rex2
         0XmaLxu7ei/PuVpDwGkd+ON/cLB4HYbguyA4P1T+hUOxmM6mVu7qrM6WY4J5VZwGJP0M
         /dnqWKzVil1CV6g0UPrq5jAP26wjtmH7Ap2e+WRKm3HWKGFzZUrMZf+Tl1y0IFXfTOuJ
         IC8OOxLPvBG0B3zEjqcyVjESjNh3W1qNAQ1m1QfS2GQ0PsANIkkYq74hmIdG5BNXyYWv
         reBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm/teCeYeQXLC6TQ9IrFAhhC1axcZDIJceZpUFv1pRBCPvw1RtsnI5+15t2OZ5pEcsWSDKYIn4jgsHOSCt3+w7Gvv8TiJL
X-Gm-Message-State: AOJu0YxVZEAYojFuV9s9CukI+ZNX31XODAdDZvWdXTXgxsdoJUXkru16
	z54JX8A1OMTVuNeY5B/P6C/298IBes/UP7SWb1VtTGwDnWOWQk2N
X-Google-Smtp-Source: AGHT+IGWMrwifxKeRArQ90jIP/hx+hzmcPLSD2n1QWMvxog39x5nnYUbZUq3vWY9OtO4scJT1Emgzw==
X-Received: by 2002:a05:651c:10cc:b0:2d8:67a0:61b2 with SMTP id l12-20020a05651c10cc00b002d867a061b2mr10897403ljn.20.1713363023712;
        Wed, 17 Apr 2024 07:10:23 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c138b00b004187450e4cesm3042475wmf.29.2024.04.17.07.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:10:23 -0700 (PDT)
Subject: Re: [PATCH net-next v2] sfc: use flow_rule_is_supp_control_flags()
To: =?UTF-8?Q?Asbj=c3=b8rn_Sloth_T=c3=b8nnesen?= <ast@fiberby.net>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 linux-net-drivers@amd.com
References: <20240417140712.100905-1-ast@fiberby.net>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <39bbf689-ca2e-e5f7-f903-db4ef76177fa@gmail.com>
Date: Wed, 17 Apr 2024 15:10:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240417140712.100905-1-ast@fiberby.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 17/04/2024 15:07, Asbjørn Sloth Tønnesen wrote:
> Change the check for unsupported control flags, to use the new helper
> flow_rule_is_supp_control_flags().
> 
> Since the helper was based on sfc, then nothing really changes.
> 
> Compile-tested, and compiled objects are identical.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

